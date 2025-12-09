const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');
const session = require('express-session');
const app = express();

// --- Config ---
app.set('view engine', 'ejs');
app.use(express.static('public'));
app.use(bodyParser.urlencoded({ extended: true }));
app.use(session({
    secret: 'secret_pizza_key',
    resave: false,
    saveUninitialized: true,
    cookie: { maxAge: 24 * 60 * 60 * 1000 }
}));

// --- Database Connection (ปรับปรุงใหม่!) ---
// รองรับทั้งชื่อตัวแปรของ Clever Cloud, Render และ Localhost
const pool = mysql.createPool({
    connectionLimit: 10,
    // เช็คค่าจาก Cloud ก่อน -> ถ้าไม่มีให้ใช้ค่าจาก Render -> ถ้าไม่มีให้ใช้ localhost
    host: process.env.MYSQL_ADDON_HOST || process.env.DB_HOST || 'brttxn4lfdmo6hs3iwf8-mysql.services.clever-cloud.com',
    user: process.env.MYSQL_ADDON_USER || process.env.DB_USER || 'u14ibqankfctnyaf',
    password: process.env.MYSQL_ADDON_PASSWORD || process.env.DB_PASSWORD || 'd6SKKV6hnfRt3WsygB0e',
    database: process.env.MYSQL_ADDON_DB || process.env.DB_NAME || 'brttxn4lfdmo6hs3iwf8', // <--- จุดสำคัญที่แก้ให้ครับ
    port: process.env.MYSQL_ADDON_PORT || process.env.DB_PORT || 3306,
    waitForConnections: true,
    queueLimit: 0
});
const db = pool.promise();

// --- Middleware ---
app.use((req, res, next) => {
    res.locals.user = req.session.user || null;
    res.locals.cart = req.session.cart || [];
    res.locals.alert = req.session.alert || null;
    delete req.session.alert;

    let qty = 0;
    if(req.session.cart) req.session.cart.forEach(i => qty += i.qty);
    res.locals.cartCount = qty;

    const ip = req.ip;
    const today = new Date().toISOString().slice(0, 10);
    pool.query("INSERT IGNORE INTO counter (ip_address, visit_date) VALUES (?, ?)", [ip, today], (err) => {
        if (err) console.error("Counter Error:", err);
        next();
    });
});

// --- Routes ---

// 1. Home
app.get('/', async (req, res) => {
    try {
        const [banners] = await db.query('SELECT * FROM banners');
        const [products] = await db.query('SELECT * FROM products WHERE is_active = 1');
        const [combos] = await db.query('SELECT * FROM combos');
        const [count] = await db.query('SELECT COUNT(*) AS c FROM counter');
        
        res.render('index', { 
            banners, products, combos, 
            visitorCount: count[0].c 
        });
    } catch (err) {
        console.error(err);
        res.send("Server Error");
    }
});

// 2. Custom Pizza
app.get('/custom', async (req, res) => {
    try {
        const [rows] = await db.query('SELECT * FROM ingredients');
        res.render('custom', {
            crusts: rows.filter(i => i.category === 'crust'),
            sauces: rows.filter(i => i.category === 'sauce'),
            toppings: rows.filter(i => i.category === 'topping')
        });
    } catch (err) {
        console.error(err);
        res.send("Error");
    }
});

// 3. Cart Actions
app.post('/add-to-cart', (req, res) => {
    const { name, price, calories, qty } = req.body;
    if(!req.session.cart) req.session.cart = [];
    
    const quantity = parseInt(qty) || 1;
    const existing = req.session.cart.find(i => i.name === name);
    
    if(existing) {
        existing.qty += quantity;
    } else {
        req.session.cart.push({ name, price: parseInt(price), calories: parseInt(calories), qty: quantity });
    }
    
    req.session.alert = { type: 'success', title: 'เพิ่มเรียบร้อย', msg: `เพิ่ม ${name} ลงตะกร้าแล้ว` };
    req.session.save(() => {
        const backURL = req.header('Referer') || '/';
        res.redirect(backURL);
    });
});

app.get('/cart', (req, res) => {
    let totalCal = 0, totalPrice = 0;
    const cart = req.session.cart || [];
    cart.forEach(i => { totalCal += i.calories * i.qty; totalPrice += i.price * i.qty; });
    res.render('cart', { totalCal, totalPrice });
});

app.post('/update-cart', (req, res) => {
    const { index, action } = req.body;
    const cart = req.session.cart;
    if (cart && cart[index]) {
        if(action === 'increase') cart[index].qty++;
        if(action === 'decrease') {
            cart[index].qty--;
            if(cart[index].qty <= 0) cart.splice(index, 1);
        }
    }
    req.session.save(() => res.redirect('/cart'));
});

// 4. Checkout
app.post('/checkout', async (req, res) => {
    if(!req.session.user) {
        req.session.alert = { type: 'warning', title: 'แจ้งเตือน', msg: 'กรุณาเข้าสู่ระบบก่อนสั่งซื้อ' };
        return req.session.save(() => res.redirect('/login'));
    }
    
    const cart = req.session.cart;
    if(!cart || cart.length === 0) return res.redirect('/');

    try {
        let totalPrice = 0;
        cart.forEach(i => totalPrice += i.price * i.qty);

        const [result] = await db.query(
            'INSERT INTO orders (user_id, fullname, total_price, status) VALUES (?, ?, ?, ?)',
            [req.session.user.id, req.session.user.fullname, totalPrice, 'Pending']
        );
        const orderId = result.insertId;

        for (const item of cart) {
            await db.query(
                'INSERT INTO order_items (order_id, product_name, qty, price) VALUES (?, ?, ?, ?)',
                [orderId, item.name, item.qty, item.price]
            );
        }

        req.session.cart = [];
        req.session.alert = { type: 'success', title: 'สั่งซื้อสำเร็จ!', msg: 'ดูสถานะได้ที่เมนูประวัติการสั่งซื้อ' };
        req.session.save(() => res.redirect('/history'));

    } catch (err) {
        console.error(err);
        res.send("Checkout Error");
    }
});

// 5. History Page
app.get('/history', async (req, res) => {
    if(!req.session.user) return res.redirect('/login');
    
    try {
        const [orders] = await db.query('SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC', [req.session.user.id]);
        
        for(let order of orders) {
            const [items] = await db.query('SELECT * FROM order_items WHERE order_id = ?', [order.id]);
            order.items = items;
        }

        res.render('history', { orders });
    } catch (err) {
        console.error(err);
        res.send("Error");
    }
});

// 6. Admin Dashboard
app.get('/admin', async (req, res) => {
    if(!req.session.user || req.session.user.role !== 'admin') {
        return res.redirect('/');
    }

    try {
        const [orders] = await db.query('SELECT * FROM orders ORDER BY order_date DESC');
        
        for(let order of orders) {
            const [items] = await db.query('SELECT * FROM order_items WHERE order_id = ?', [order.id]);
            order.items = items;
        }

        res.render('admin', { orders });
    } catch (err) {
        console.error(err);
        res.send("Admin Error");
    }
});

// 7. Admin Update Status
app.post('/admin/update-status', async (req, res) => {
    if(!req.session.user || req.session.user.role !== 'admin') return res.redirect('/');

    const { order_id, status } = req.body;
    try {
        await db.query('UPDATE orders SET status = ? WHERE id = ?', [status, order_id]);
        req.session.alert = { type: 'success', title: 'อัปเดตแล้ว', msg: `ออเดอร์ #${order_id} เป็นสถานะ ${status}` };
        req.session.save(() => res.redirect('/admin'));
    } catch (err) {
        console.error(err);
        res.send("Update Error");
    }
});

// 8. Branches Page
app.get('/branches', async (req, res) => {
    try {
        const [branches] = await db.query('SELECT * FROM branches');
        res.render('branches', { branches });
    } catch (err) {
        console.error(err);
        res.send("Error loading branches");
    }
});

// Auth Routes
app.get('/register', (req, res) => res.render('register'));
app.post('/register', async (req, res) => {
    const { fullname, username, password } = req.body;
    try {
        const [check] = await db.query('SELECT * FROM member WHERE username = ?', [username]);
        if(check.length > 0) {
            req.session.alert = { type: 'error', title: 'ผิดพลาด', msg: 'Username ซ้ำ' };
            return req.session.save(() => res.redirect('/register'));
        }
        await db.query('INSERT INTO member (fullname, username, password) VALUES (?,?,?)', [fullname, username, password]);
        req.session.alert = { type: 'success', title: 'สำเร็จ', msg: 'สมัครสมาชิกเรียบร้อย' };
        req.session.save(() => res.redirect('/login'));
    } catch(err) { console.error(err); }
});

app.get('/login', (req, res) => res.render('login'));
app.post('/login', async (req, res) => {
    const { username, password } = req.body;
    try {
        const [rows] = await db.query('SELECT * FROM member WHERE username=? AND password=?', [username, password]);
        if(rows.length > 0) {
            req.session.user = rows[0];
            req.session.alert = { type: 'success', title: 'ยินดีต้อนรับ', msg: `สวัสดี ${rows[0].fullname}` };
            req.session.save(() => res.redirect('/'));
        } else {
            req.session.alert = { type: 'error', title: 'ผิดพลาด', msg: 'Username/Password ผิด' };
            req.session.save(() => res.redirect('/login'));
        }
    } catch(err) { console.error(err); }
});

app.get('/logout', (req, res) => {
    req.session.destroy(() => res.redirect('/'));
});

app.listen(3000, () => console.log('Server running on port 3000'));
