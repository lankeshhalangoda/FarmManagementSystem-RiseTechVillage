-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 30, 2024 at 05:53 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `aswenna_risetechvillage`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Seeds', '2024-08-30 09:11:12', '2024-08-30 09:11:12'),
(2, 'Fertilizers', '2024-08-30 09:11:12', '2024-08-30 09:11:12'),
(3, 'Pesticides', '2024-08-30 09:11:12', '2024-08-30 09:11:12'),
(4, 'Other', '2024-08-30 09:11:12', '2024-08-30 09:11:12');

-- --------------------------------------------------------

--
-- Table structure for table `crops`
--

CREATE TABLE `crops` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `growth_stage` varchar(255) DEFAULT NULL,
  `planting_date` date DEFAULT NULL,
  `harvest_date` date DEFAULT NULL,
  `cycle_progress` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `crops`
--

INSERT INTO `crops` (`id`, `name`, `growth_stage`, `planting_date`, `harvest_date`, `cycle_progress`, `created_at`, `updated_at`) VALUES
(1, 'Tomatoes', 'Seedling', '2024-08-30', '2024-11-28', 0, '2024-08-30 09:20:12', '2024-08-30 10:08:09'),
(2, 'Corn', 'Vegetative', '2024-08-30', '2024-11-28', 20, '2024-08-30 09:20:38', '2024-08-30 09:23:37'),
(3, 'Lettuce', 'Vegetative', '2024-08-30', '2024-11-28', 20, '2024-08-30 09:20:58', '2024-08-30 09:58:26'),
(4, 'Potatoes', 'Vegetative', '2024-08-30', '2024-11-28', 20, '2024-08-30 09:21:19', '2024-08-30 10:05:11'),
(5, 'Carrots', 'Vegetative', '2024-08-30', '2024-11-28', 20, '2024-08-30 09:21:44', '2024-08-30 09:58:11');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `growth_entries`
--

CREATE TABLE `growth_entries` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `crop_id` bigint(20) DEFAULT NULL,
  `stage` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `growth_entries`
--

INSERT INTO `growth_entries` (`id`, `crop_id`, `stage`, `note`, `created_at`, `updated_at`) VALUES
(1, 1, 'Seedling', 'Prune the tomato plants today to promote better air circulation and reduce the risk of disease. Remove any yellowing or dead leaves, and tie up any branches that are sagging. Check for blossom end rot and ensure consistent watering. Apply a balanced fertilizer to boost fruit production.', '2024-08-30 09:20:12', '2024-08-30 09:20:12'),
(2, 2, 'Seedling', 'Inspect the corn plants for signs of pests like corn borers and aphids. Apply an organic pesticide if necessary. Check that the stalks are sturdy and prop up any that are leaning. Ensure that pollination is happening—if needed, gently shake the plants to distribute pollen.', '2024-08-30 09:20:38', '2024-08-30 09:20:38'),
(3, 3, 'Seedling', 'Harvest mature lettuce heads before they bolt in the heat. Water the remaining plants early in the morning to keep them cool and prevent wilting. Inspect the soil moisture and consider mulching to retain water. Re-seed any empty spots for continuous harvest.', '2024-08-30 09:20:58', '2024-08-30 09:20:58'),
(4, 4, 'Flowering', 'Hill up the soil around potato plants to protect the tubers from sunlight and pests. This will encourage better growth and prevent the potatoes from turning green. Monitor for any signs of blight or other diseases, and remove affected plants immediately. Prepare for the upcoming harvest.', '2024-08-30 09:21:19', '2024-08-30 09:21:19'),
(5, 5, 'Fruiting', 'Thin the carrot seedlings to avoid overcrowding and ensure proper root development. Keep the soil evenly moist to prevent the roots from splitting. Check for any signs of pests like carrot flies and apply organic deterrents if needed. Harvest the early-maturing carrots and continue monitoring growth.', '2024-08-30 09:21:44', '2024-08-30 09:21:44'),
(6, 6, 'Flowering', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '2024-08-30 09:59:08', '2024-08-30 09:59:08'),
(7, 7, 'Ripening', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '2024-08-30 10:03:36', '2024-08-30 10:03:36'),
(8, 8, 'Flowering', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '2024-08-30 10:05:45', '2024-08-30 10:05:45');

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL,
  `purchase_date` date NOT NULL,
  `usage` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `name`, `category_id`, `quantity`, `purchase_date`, `usage`, `created_at`, `updated_at`) VALUES
(1, 'Tomato Seeds', 1, 136, '2024-08-30', 'Fruit', '2024-08-30 09:27:14', '2024-08-30 10:06:14'),
(2, 'Carrot Seeds', 1, 200, '2024-08-30', 'Root', '2024-08-30 09:27:51', '2024-08-30 09:27:51'),
(3, 'Neem Oil', 3, 50, '2024-08-30', 'Insecticide', '2024-08-30 09:28:27', '2024-08-30 09:28:27'),
(4, 'Glyphosate', 3, 150, '2024-08-30', 'Herbicide', '2024-08-30 09:28:51', '2024-08-30 09:28:51'),
(5, 'Urea', 2, 10, '2024-08-30', 'Nitrogen', '2024-08-30 09:29:08', '2024-08-30 09:29:19');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2024_08_29_054502_create_categories_table', 1),
(5, '2024_08_29_054503_create_items_table', 1),
(6, '2024_08_29_105836_create_crops_table', 1),
(7, '2024_08_29_105849_create_growth_entries_table', 1),
(8, '2024_08_29_105857_create_recommendations_table', 1),
(9, '2024_08_30_053057_create_soil_conditions_table', 1),
(10, '2024_08_30_121840_create_sticky_notes_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `recommendations`
--

CREATE TABLE `recommendations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `crop_id` bigint(20) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('jnnRfZ7XxCT0TDVIq1LjtaSU8RrEzvms8XR0SLd6', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUEpjSGtINmJFZXdlRERycXlJWUtMUWJiUWpITWZwZnhiTDdCa0x5cCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoyMToiaHR0cDovLzEyNy4wLjAuMTo4MDAwIjt9fQ==', 1725032789);

-- --------------------------------------------------------

--
-- Table structure for table `soil_conditions`
--

CREATE TABLE `soil_conditions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `location` varchar(255) NOT NULL,
  `temperature` double NOT NULL,
  `moisture` double NOT NULL,
  `ph_level` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `soil_conditions`
--

INSERT INTO `soil_conditions` (`id`, `location`, `temperature`, `moisture`, `ph_level`, `created_at`, `updated_at`) VALUES
(1, 'Vegetable Garden', 22, 60, 6.5, '2024-08-30 09:30:57', '2024-08-30 09:30:57'),
(2, 'Herb Bed', 25, 40, 6, '2024-08-30 09:31:17', '2024-08-30 09:31:17'),
(3, 'Fruit Orchard', 18, 50, 7, '2024-08-30 09:31:35', '2024-08-30 09:31:35');

-- --------------------------------------------------------

--
-- Table structure for table `sticky_notes`
--

CREATE TABLE `sticky_notes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sticky_notes`
--

INSERT INTO `sticky_notes` (`id`, `title`, `body`, `date`, `time`, `created_at`, `updated_at`) VALUES
(1, 'Irrigation Schedule', 'Today, check the water levels in all fields. Walk through each area to identify any dry patches, and adjust the irrigation system accordingly. Pay special attention to the new seedlings, as they require consistent moisture. Don’t forget to monitor the weather forecast; if rain is expected, adjust the watering schedule to conserve water.', '2024-08-30', '20:18:00', '2024-08-30 09:16:39', '2024-08-30 09:18:07'),
(2, 'Fertilizer Application', 'It\'s time to apply fertilizer to the vegetable crops. Ensure you’re using the correct type and dosage specific to each crop to promote healthy growth without overfeeding. Take note of the application date, and plan the next feeding cycle accordingly. Remember to wear protective gear while handling chemicals, and store any leftovers properly.', '2024-08-30', '20:18:00', '2024-08-30 09:17:18', '2024-08-30 09:18:27');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Test User', 'test@gmail.com', '2024-08-30 09:11:11', '$2y$12$gFZbTx6MOR94IOvqEHiBEe2vqv0hdKBQpNoMzBEKsIgG5735a2oNi', 'BoBN8Ricoi', '2024-08-30 09:11:12', '2024-08-30 09:11:12'),
(2, 'Lankesh Halangoda', 'lankeshhalangoda@gmail.com', NULL, '$2y$12$fuNFCdhU8Tr7KMXbuAuerOS4c1qzByOeuzDjE7gr1iJNZ/5HgV.Na', NULL, '2024-08-30 09:14:47', '2024-08-30 09:14:47');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categories_name_unique` (`name`);

--
-- Indexes for table `crops`
--
ALTER TABLE `crops`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `growth_entries`
--
ALTER TABLE `growth_entries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `items_category_id_foreign` (`category_id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `recommendations`
--
ALTER TABLE `recommendations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `soil_conditions`
--
ALTER TABLE `soil_conditions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sticky_notes`
--
ALTER TABLE `sticky_notes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `crops`
--
ALTER TABLE `crops`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `growth_entries`
--
ALTER TABLE `growth_entries`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `recommendations`
--
ALTER TABLE `recommendations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `soil_conditions`
--
ALTER TABLE `soil_conditions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `sticky_notes`
--
ALTER TABLE `sticky_notes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `items`
--
ALTER TABLE `items`
  ADD CONSTRAINT `items_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
