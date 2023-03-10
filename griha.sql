-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 27, 2023 at 05:10 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `griha`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `booking_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `total_amount` int(11) NOT NULL,
  `is_paid` tinyint(1) NOT NULL,
  `payment_mode` varchar(255) DEFAULT NULL,
  `additional_payment_data` longtext DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`booking_id`, `post_id`, `user_id`, `start_date`, `end_date`, `total_amount`, `is_paid`, `payment_mode`, `additional_payment_data`, `created_at`, `updated_at`) VALUES
(45, 42, 20, '2023-03-27', '2023-03-29', 1000, 1, 'khalti', 'PaymentSuccessModel{idx: 9kzZvQF8Vds5tXsTz7WRu4, amount: 1000, mobile: 98XXXXX177, productIdentity: 42, productName: The Village villa, token: 6kkBHU3ACBSCh7JQ3T8DYT, additionalData: {}}', '2023-03-27 09:54:37', '2023-03-27 09:54:37'),
(46, 41, 20, '2023-03-27', '2023-03-28', 1000, 0, NULL, NULL, '2023-03-27 10:31:18', '2023-03-27 10:31:18'),
(47, 43, 20, '2023-03-29', '2023-03-31', 1000, 0, NULL, NULL, '2023-03-27 11:08:28', '2023-03-27 11:08:28'),
(48, 41, 20, '2023-05-23', '2023-05-25', 1000, 1, 'khalti', 'PaymentSuccessModel{idx: Txvd2UxxBZZmGkfRRkVqHT, amount: 1000, mobile: 98XXXXX177, productIdentity: 41, productName: Beautiful Rooms, token: bNkVoQtSmg2CVuJG4SgZ73, additionalData: {}}', '2023-03-27 13:22:14', '2023-03-27 13:22:14'),
(49, 42, 20, '2023-06-08', '2023-06-09', 1000, 1, 'khalti', 'PaymentSuccessModel{idx: dqCaVy97VVGkdUECxcCZLW, amount: 1000, mobile: 98XXXXX177, productIdentity: 42, productName: The Village villa, token: ReRxX3HixEWRuSphWJ5dBQ, additionalData: {}}', '2023-03-27 14:08:38', '2023-03-27 14:08:38'),
(50, 41, 23, '2023-03-29', '2023-03-30', 1000, 1, 'khalti', 'PaymentSuccessModel{idx: S3WryJgFYrSzvvpWS8XApe, amount: 1000, mobile: 98XXXXX177, productIdentity: 41, productName: Beautiful Rooms, token: nmf4tdDoqHvLckcgM8DFVC, additionalData: {}}', '2023-03-27 16:56:17', '2023-03-27 16:56:17');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `image_url` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `title`, `image_url`) VALUES
(2, 'Appartments', 'https://cdn-icons-png.flaticon.com/512/1041/1041023.png'),
(3, 'Flats', 'https://cdn-icons-png.flaticon.com/512/1838/1838439.png'),
(4, 'Office', 'https://cdn-icons-png.flaticon.com/512/1599/1599808.png'),
(5, 'Bunglaow', 'https://cdn-icons-png.flaticon.com/512/2605/2605196.png');

-- --------------------------------------------------------

--
-- Table structure for table `cities`
--

CREATE TABLE `cities` (
  `city_id` int(11) NOT NULL,
  `city_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cities`
--

INSERT INTO `cities` (`city_id`, `city_name`) VALUES
(1, 'Pokhara'),
(2, 'Kathmandu'),
(3, 'Chitwan');

-- --------------------------------------------------------

--
-- Table structure for table `favourites`
--

CREATE TABLE `favourites` (
  `post_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `post_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `title` varchar(350) NOT NULL,
  `date` datetime NOT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `price` int(11) NOT NULL,
  `total_rooms` int(11) NOT NULL,
  `total_bedroom` int(11) NOT NULL,
  `number_of_kitchen` int(11) NOT NULL,
  `facilities` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`facilities`)),
  `city_id` int(11) NOT NULL,
  `street_address` varchar(500) NOT NULL,
  `posted_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`post_id`, `category_id`, `title`, `date`, `description`, `price`, `total_rooms`, `total_bedroom`, `number_of_kitchen`, `facilities`, `city_id`, `street_address`, `posted_by`) VALUES
(41, 2, 'Beautiful Rooms', '0000-00-00 00:00:00', 'These are the Beautiful rooms around pokhara.', 0, 6, 5, 1, '[\"Free Wifi\",\"Camping Ground\"]', 1, 'LakeSide', 19),
(42, 2, 'The Village villa', '0000-00-00 00:00:00', 'This is the village in Pokhara with extra ordinary facilities.', 1000, 1, 2, 1, '[\"Free Wifi\",\"Swimming Pool\"]', 1, 'Lakeside', 19),
(43, 2, 'This istest', '0000-00-00 00:00:00', 'This is very good', 1000, 5, 1, 1, '[\"Free wifi\",\"Swimming Pool\",\"Gym\"]', 2, 'Lakeside', 20);

-- --------------------------------------------------------

--
-- Table structure for table `post_pictures`
--

CREATE TABLE `post_pictures` (
  `post_pictured_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `image_url` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `post_pictures`
--

INSERT INTO `post_pictures` (`post_pictured_id`, `post_id`, `image_url`) VALUES
(28, 41, 'public\\1679467655734-image2.jpeg'),
(29, 41, 'public\\1679467655737-2023-03-16-15-08-00-brands_.jpeg'),
(30, 42, 'public\\1679467840311-1679467839929.jpg'),
(31, 42, 'public\\1679467840367-1679467839947.jpg'),
(32, 43, 'public\\1679820420335-1679820419745.jpg'),
(33, 43, 'public\\1679820420362-1679820419754.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `phone_number` varchar(10) DEFAULT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(250) NOT NULL,
  `is_admin` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `full_name`, `phone_number`, `email`, `password`, `is_admin`) VALUES
(19, 'Elon Musk', '983434343', 'test@gmail.com', '$2b$08$TcKM/L3suZ0.WcaI2W3cOObPXcRnaZ3F.aqN16xZZK2ayeX31eqQy', 0),
(20, 'Hari Bahadur', '9825109876', 'hari@gmail.com', '$2b$08$/nYVEUjoXT8ilHhLfH/Lx.IWOs4T0N.BQnVb.3JHjzM3qn5Xd/vgG', 0),
(23, 'Main Admin', '', 'admin@gmail.com', '$2b$08$L3MHOm4iCqqeKA78I4IdgOQ35r3Of2OWStVGz9fsQKr6BMuI2vwga', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `post_id` (`post_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`city_id`);

--
-- Indexes for table `favourites`
--
ALTER TABLE `favourites`
  ADD PRIMARY KEY (`post_id`,`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`post_id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `posted_by` (`posted_by`),
  ADD KEY `city_id` (`city_id`);

--
-- Indexes for table `post_pictures`
--
ALTER TABLE `post_pictures`
  ADD PRIMARY KEY (`post_pictured_id`),
  ADD KEY `post_id` (`post_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `cities`
--
ALTER TABLE `cities`
  MODIFY `city_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `post_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `post_pictures`
--
ALTER TABLE `post_pictures`
  MODIFY `post_pictured_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`);

--
-- Constraints for table `favourites`
--
ALTER TABLE `favourites`
  ADD CONSTRAINT `favourites_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`),
  ADD CONSTRAINT `favourites_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`),
  ADD CONSTRAINT `posts_ibfk_3` FOREIGN KEY (`posted_by`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `posts_ibfk_4` FOREIGN KEY (`city_id`) REFERENCES `cities` (`city_id`);

--
-- Constraints for table `post_pictures`
--
ALTER TABLE `post_pictures`
  ADD CONSTRAINT `post_pictures_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
