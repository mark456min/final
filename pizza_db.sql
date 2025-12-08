-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 08, 2025 at 12:12 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pizza_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `banners`
--

CREATE TABLE `banners` (
  `id` int(11) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `banners`
--

INSERT INTO `banners` (`id`, `image_url`) VALUES
(1, 'https://cms.dominospizza.co.th/stocks/home_banner/c2560x800/ja/cn/3yv8jacnenr/063-Pocket-bomb-ADJ-size-Banner-02_0.jpg'),
(2, 'https://cms.dominospizza.co.th/stocks/home_banner/c2560x800/ph/ed/jp2mphedrlb/web-banner-298.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

CREATE TABLE `branches` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `lat` decimal(10,8) DEFAULT NULL,
  `lng` decimal(11,8) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `branches`
--

INSERT INTO `branches` (`id`, `name`, `address`, `lat`, `lng`, `image_url`) VALUES
(1, 'สาขา สุขุมวิท 22', 'โรงแรม Holiday Inn, กรุงเทพมหานคร', 13.73268400, 100.56534500, 'https://cdn-icons-png.flaticon.com/512/2928/2928883.png'),
(2, 'สาขา สีลม', 'สีลมซอย 3 (พิพัฒน์), กรุงเทพมหานคร', 13.72658800, 100.53325600, 'https://cdn-icons-png.flaticon.com/512/2928/2928883.png'),
(3, 'สาขา พัฒนาการ', 'ปากซอยพัฒนาการ 30, กรุงเทพมหานคร', 13.73671700, 100.62734500, 'https://cdn-icons-png.flaticon.com/512/2928/2928883.png'),
(4, 'สาขา เดอะ ไบรท์ พระราม 2', 'ถ.พระราม 2 แขวงแสมดำ, กรุงเทพมหานคร', 13.66982700, 100.44238500, 'https://cdn-icons-png.flaticon.com/512/2928/2928883.png'),
(5, 'สาขา บางอ้อ', 'จรัญสนิทวงศ์ 94, กรุงเทพมหานคร', 13.80456200, 100.51123400, 'https://cdn-icons-png.flaticon.com/512/2928/2928883.png');

-- --------------------------------------------------------

--
-- Table structure for table `combos`
--

CREATE TABLE `combos` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `original_price` int(11) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `combos`
--

INSERT INTO `combos` (`id`, `name`, `description`, `price`, `original_price`, `image_url`) VALUES
(1, 'Happy Set A', 'ฮาวายเอี้ยนถาดกลาง + โค้ก 1.25 ลิตร', 399, 450, 'https://i.postimg.cc/RVRSPm7K/Gemini-Generated-Image-ajau3najau3najau.png'),
(2, 'Family Party B', 'ซีฟู้ดเดลูซถาดใหญ่ + ไก่นิวออร์ลีนส์ + โค้ก 2 ขวด', 699, 890, 'https://i.postimg.cc/SxZVyX4b/Gemini-Generated-Image-b6mh6ab6mh6ab6mh.png'),
(3, 'Solo Delight', 'พิซซ่าถาดเล็ก (เลือกหน้าได้) + โค้กกระป๋อง', 159, 199, 'https://i.postimg.cc/2yzBbwdy/Gemini-Generated-Image-joykcyjoykcyjoyk.png'),
(4, 'Duo Lover', 'พิซซ่าถาดกลาง 2 ถาด + โค้ก 1.25 ลิตร', 555, 750, 'https://i.postimg.cc/C5XSTMKZ/Gemini-Generated-Image-r75vrr75vrr75vrr.png'),
(5, 'New Gen Pizza 1!', 'พิซซ่าดับเบิ้ลความอร่อย ที่เลือกหน้าได้มากถึง 2 หน้าในถาดเดียว', 399, 499, 'https://i.postimg.cc/nhH0byXW/Gemini-Generated-Image-qvel1yqvel1yqvel.png'),
(6, 'New Arrival!', 'เบคอน แอนด์ เดอะแบล็ค,\r\nอเมริกัน ฮิตส์,\r\nโคเรียน บีฟ บูลโกกิ,\r\nชีสเบอร์เกอร์เนื้อ เลือกได้ 1 ถาด', 239, 399, 'https://i.postimg.cc/NGkXq5mz/Gemini-Generated-Image-s9bhcns9bhcns9bh.png'),
(7, 'มารีนาร่าแฮมและไส้กรอก', 'ใหม่ท้าลอง! Pocket Bomb กรอบนอกนุ่มในกับแป้งสดนวดมือ กับไส้ทะลักแบบบึ้มๆ ของ แฮมฉ่ำๆ ไส้กรอกแน่นๆ ไข่นุ่มๆ กับซอสมารีนาร่าสูตรเข้มข้น\r\n', 149, 199, 'https://i.postimg.cc/x87C9D5Q/Gemini-Generated-Image-ytg7dcytg7dcytg7.png'),
(8, 'Chick Chick!', 'ไก่นิวออร์ลีนส์ + โค้ก', 149, 199, 'https://i.postimg.cc/x1xVNyHL/Gemini-Generated-Image-ytqp3sytqp3sytqp.png');

-- --------------------------------------------------------

--
-- Table structure for table `counter`
--

CREATE TABLE `counter` (
  `id` int(11) NOT NULL,
  `ip_address` varchar(50) DEFAULT NULL,
  `visit_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `counter`
--

INSERT INTO `counter` (`id`, `ip_address`, `visit_date`) VALUES
(1, '::1', '2025-12-06'),
(435, '::1', '2025-12-08');

-- --------------------------------------------------------

--
-- Table structure for table `ingredients`
--

CREATE TABLE `ingredients` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `category` enum('crust','sauce','topping') DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `calories` int(11) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ingredients`
--

INSERT INTO `ingredients` (`id`, `name`, `category`, `price`, `calories`, `image_url`) VALUES
(1, 'แป้งบางกรอบ', 'crust', 100, 200, 'https://cms.dominospizza.co.th/stocks/product_attribute_option/c150x150/ee/rc/it8yeercsdp/TC.png'),
(2, 'แป้งหนานุ่ม', 'crust', 120, 350, 'https://cms.dominospizza.co.th/stocks/product_attribute_option/c150x150/wf/ty/pjqlwftygmi/HT.jpg'),
(3, 'ซอสมะเขือเทศ', 'sauce', 20, 50, 'https://cms.dominospizza.co.th/stocks/product/c330x330/mk/yp/et4bmkypfnv/Marinara-Sauce_0.jpg'),
(4, 'ซอสบาร์บีคิว', 'sauce', 30, 80, 'https://cms.dominospizza.co.th/stocks/product/c330x330/db/to/6u1udbtoday/BBQ-Sauce_0.jpg'),
(5, 'ชีส', 'topping', 50, 150, 'https://cms.dominospizza.co.th/stocks/product/c330x330/mi/gs/dwzwmigsksm/Cheese-Sauce_0.jpg'),
(6, 'เปปเปอโรนี', 'topping', 40, 100, 'https://cdn11.bigcommerce.com/s-gch1s0t3lu/images/stencil/1280x1280/products/196/498/pepperoni__99862.1642185541.jpg?c=1'),
(7, 'แฮม', 'topping', 40, 90, 'https://denningers.com/cdn/shop/products/BlackforestHamSliced-100g_800x.jpg?v=1739720056'),
(8, 'สับปะรด', 'topping', 20, 40, 'https://media.istockphoto.com/id/1172156689/photo/pineapple-slice-isolated-pineapple-composition-perfect-retouched-photo.jpg?s=612x612&w=0&k=20&c=Bzx_hVtRDQkhvmUXbPagmTDZbCML7gCrgcDTcFIstL8=');

-- --------------------------------------------------------

--
-- Table structure for table `member`
--

CREATE TABLE `member` (
  `id` int(11) NOT NULL,
  `fullname` varchar(100) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` enum('user','admin') DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `member`
--

INSERT INTO `member` (`id`, `fullname`, `username`, `password`, `role`) VALUES
(1, 'admin', 'admin', '1234', 'admin'),
(2, 'user', 'user', '1234', 'user'),
(4, 'Qwertyyuiop Zxcvbnm', 'zxcvbnm', '1', 'user');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `fullname` varchar(100) DEFAULT NULL,
  `total_price` int(11) DEFAULT NULL,
  `status` enum('Pending','Baking','Delivering','Completed','Cancelled') DEFAULT 'Pending',
  `order_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `fullname`, `total_price`, `status`, `order_date`) VALUES
(3, 4, 'Qwertyyuiop Zxcvbnm', 508, 'Pending', '2025-12-08 18:10:56');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `product_name` varchar(100) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_name`, `qty`, `price`) VALUES
(3, 3, 'Seafood Cocktail', 1, 359),
(4, 3, 'Chick Chick!', 1, 149);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `calories` int(11) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `price`, `calories`, `image_url`) VALUES
(1, 'Deluxe Pepperoni', 299, 320, 'https://cms.dominospizza.co.th/stocks/product/c330x330/yp/3f/ci7ryp3fkda/Pepperoni.jpg'),
(2, 'Seafood Cocktail', 359, 400, 'https://cms.dominospizza.co.th/stocks/product/c330x330/yl/ve/fmmsylvei8w/Seafood-Hawaiian.jpg'),
(3, 'Hawaiian', 279, 350, 'https://cms.dominospizza.co.th/stocks/product/c330x330/7l/qs/doae7lqsu0k/Hawaiian.jpg'),
(4, 'Veggie Lover', 259, 280, 'https://cms.dominospizza.co.th/stocks/product/c330x330/ea/yh/imzseayhe3h/Vegetarian-Paradise.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `banners`
--
ALTER TABLE `banners`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `branches`
--
ALTER TABLE `branches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `combos`
--
ALTER TABLE `combos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `counter`
--
ALTER TABLE `counter`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ip_address` (`ip_address`,`visit_date`);

--
-- Indexes for table `ingredients`
--
ALTER TABLE `ingredients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `banners`
--
ALTER TABLE `banners`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `combos`
--
ALTER TABLE `combos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `counter`
--
ALTER TABLE `counter`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=619;

--
-- AUTO_INCREMENT for table `ingredients`
--
ALTER TABLE `ingredients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `member`
--
ALTER TABLE `member`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
