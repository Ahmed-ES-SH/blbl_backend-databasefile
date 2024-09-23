-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Sep 21, 2024 at 12:18 AM
-- Server version: 10.11.9-MariaDB-cll-lve
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u276442001_blbl`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'active',
  `full_address` text DEFAULT NULL,
  `latitude` decimal(8,2) DEFAULT NULL,
  `longitude` decimal(8,2) DEFAULT NULL,
  `account_type` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `addresses`
--

INSERT INTO `addresses` (`id`, `status`, `full_address`, `latitude`, `longitude`, `account_type`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'available', 'شارع اللواء جمال حماد, كفر الشيخ, 33511, مصر', 31.10, 30.94, 'user', 2, '2024-09-16 04:34:46', '2024-09-16 04:34:46'),
(2, 'available', '66, شارع المدينه المنورة, ثان الحوار, المنصورة, الدقهلية, 35511, مصر', 31.04, 31.37, 'user', 2, '2024-09-16 04:34:55', '2024-09-16 04:34:55'),
(3, 'available', 'مطار بورسعيد الدولى, شارع سعد زغلول, بورسعيد, 42615, مصر', 31.27, 32.24, 'user', 2, '2024-09-16 04:35:16', '2024-09-16 04:35:16'),
(4, 'available', '6, شارع محمد نصر, قريه سندبسط, الغربية, 31646, مصر', 30.70, 31.26, 'user', 51, '2024-09-17 02:54:40', '2024-09-17 02:54:40'),
(5, 'available', '19, شارع البهنسي, مدينه ميت غمر, الدقهلية, 35611, مصر', 30.72, 31.26, 'user', 51, '2024-09-17 02:54:59', '2024-09-17 02:54:59'),
(6, 'available', 'الغربية, مصر', 30.85, 31.24, 'user', 51, '2024-09-17 02:55:09', '2024-09-17 02:55:09');

-- --------------------------------------------------------

--
-- Table structure for table `bills`
--

CREATE TABLE `bills` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `unique_id` bigint(20) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `bill_value` decimal(8,2) NOT NULL,
  `bill_status` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bills`
--

INSERT INTO `bills` (`id`, `unique_id`, `user_id`, `bill_value`, `bill_status`, `created_at`, `updated_at`) VALUES
(1, 609377, 1, 400.00, 0, '2024-09-16 22:24:54', '2024-09-16 22:24:54'),
(2, 161772, 1, 400.00, 0, '2024-09-16 22:28:01', '2024-09-16 22:28:01'),
(3, 425827, 1, 400.00, 0, '2024-09-16 22:30:14', '2024-09-16 22:30:14'),
(4, 644557, 1, 400.00, 0, '2024-09-16 22:32:25', '2024-09-16 22:32:25'),
(5, 462141, 1, 400.00, 0, '2024-09-16 22:34:21', '2024-09-16 22:34:21'),
(6, 969296, 1, 400.00, 1, '2024-09-16 22:35:11', '2024-09-16 22:35:30'),
(7, 996181, 62, 846.00, 1, '2024-09-18 01:53:29', '2024-09-18 01:58:09');

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
-- Table structure for table `conversations`
--

CREATE TABLE `conversations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `first_party_id` bigint(20) UNSIGNED NOT NULL,
  `hasUnreadMessages` tinyint(1) NOT NULL DEFAULT 0,
  `first_party_type` varchar(255) NOT NULL,
  `second_party_id` bigint(20) UNSIGNED NOT NULL,
  `second_party_type` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `conversations`
--

INSERT INTO `conversations` (`id`, `first_party_id`, `hasUnreadMessages`, `first_party_type`, `second_party_id`, `second_party_type`, `type`, `created_at`, `updated_at`) VALUES
(1, 2, 0, 'vendor', 46, 'vendor', 'vendor-to-vendor', '2024-09-17 18:42:21', '2024-09-17 18:42:21'),
(2, 46, 0, 'vendor', 46, 'vendor', 'vendor-to-vendor', '2024-09-17 19:22:35', '2024-09-17 19:22:35'),
(3, 2, 0, 'user', 2, 'user', 'user-to-user', '2024-09-17 19:35:43', '2024-09-17 19:35:43'),
(4, 2, 0, 'user', 35, 'vendor', 'user-to-vendor', '2024-09-17 19:36:49', '2024-09-17 19:36:49'),
(5, 52, 0, 'user', 26, 'vendor', 'user-to-vendor', '2024-09-17 20:28:13', '2024-09-17 20:28:13'),
(6, 52, 0, 'user', 8, 'vendor', 'user-to-vendor', '2024-09-17 20:32:18', '2024-09-17 20:32:18'),
(7, 56, 0, 'user', 50, 'vendor', 'user-to-vendor', '2024-09-17 22:00:15', '2024-09-17 22:00:15'),
(8, 61, 0, 'user', 22, 'vendor', 'user-to-vendor', '2024-09-17 22:54:58', '2024-09-17 22:54:58'),
(9, 51, 0, 'vendor', 51, 'vendor', 'vendor-to-vendor', '2024-09-17 22:59:36', '2024-09-17 22:59:36'),
(10, 2, 0, 'vendor', 51, 'vendor', 'vendor-to-vendor', '2024-09-18 00:18:21', '2024-09-18 00:18:21'),
(11, 62, 0, 'user', 46, 'vendor', 'user-to-vendor', '2024-09-18 01:49:24', '2024-09-18 01:49:24'),
(12, 62, 0, 'user', 5, 'vendor', 'user-to-vendor', '2024-09-18 01:51:45', '2024-09-18 01:51:45'),
(13, 1, 0, 'user', 47, 'vendor', 'user-to-vendor', '2024-09-20 13:11:44', '2024-09-20 13:11:44');

-- --------------------------------------------------------

--
-- Table structure for table `customerserviceconversations`
--

CREATE TABLE `customerserviceconversations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `agent_id` bigint(20) UNSIGNED NOT NULL,
  `secend_party_id` bigint(20) UNSIGNED NOT NULL,
  `conversation_type` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customerserviceconversations`
--

INSERT INTO `customerserviceconversations` (`id`, `agent_id`, `secend_party_id`, `conversation_type`, `created_at`, `updated_at`) VALUES
(4, 2, 2, 'user', '2024-09-19 14:12:02', '2024-09-19 14:12:02'),
(5, 1, 2, 'vendor', '2024-09-20 13:47:47', '2024-09-20 13:47:47');

-- --------------------------------------------------------

--
-- Table structure for table `customerservices`
--

CREATE TABLE `customerservices` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `message` text NOT NULL,
  `message_status` enum('pending','in_progress','resolved') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customerservices`
--

INSERT INTO `customerservices` (`id`, `user_id`, `message`, `message_status`, `created_at`, `updated_at`) VALUES
(1, 2, 'السلام عليكم تجربة خدمة العملاء', 'resolved', '2024-09-17 17:38:40', '2024-09-20 12:50:09');

-- --------------------------------------------------------

--
-- Table structure for table `customer_service_messages`
--

CREATE TABLE `customer_service_messages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sender_id` bigint(20) UNSIGNED NOT NULL,
  `sender_type` varchar(255) NOT NULL,
  `audio` longtext DEFAULT NULL,
  `image` longtext DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `message` text DEFAULT NULL,
  `customerserviceconversation_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customer_service_messages`
--

INSERT INTO `customer_service_messages` (`id`, `sender_id`, `sender_type`, `audio`, `image`, `is_read`, `message`, `customerserviceconversation_id`, `created_at`, `updated_at`) VALUES
(8, 1, 'user', NULL, NULL, 1, 'أهلا', 5, '2024-09-20 13:47:57', '2024-09-20 14:48:47'),
(9, 2, 'vendor', 'audio/1ljvHOWZVrTs5JdIzlLo4j4T2uIQo4DYUJPPCFDl.webm', NULL, 1, NULL, 5, '2024-09-20 14:49:11', '2024-09-20 14:57:33'),
(10, 2, 'vendor', NULL, 'images/HFQC5QFKfiVL2uNUFWtIZnRFWbtNEp1NmLfoHN2Y.jpg', 1, NULL, 5, '2024-09-20 14:54:23', '2024-09-20 14:57:33'),
(11, 1, 'user', NULL, NULL, 1, 'مرحبا', 5, '2024-09-20 15:13:59', '2024-09-20 15:15:49'),
(12, 1, 'user', 'audio/Ah5qyNngjqhfPuAJUeCun20WkFquCWG1DgCzSIpt.webm', NULL, 1, NULL, 5, '2024-09-20 15:14:29', '2024-09-20 15:15:49');

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
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `sender_type` varchar(255) NOT NULL,
  `conversation_id` bigint(20) UNSIGNED NOT NULL,
  `sender_id` bigint(20) UNSIGNED NOT NULL,
  `audio` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `is_read`, `sender_type`, `conversation_id`, `sender_id`, `audio`, `image`, `message`, `created_at`, `updated_at`) VALUES
(1, 1, 'vendor', 1, 2, NULL, NULL, 'لقد تم ارسال طلب زيارة من 2 إٍسم التاجر   إلى - 46 إٍسم التاجر   🚚', '2024-09-17 19:13:22', '2024-09-17 19:15:30'),
(2, 1, 'vendor', 1, 2, 'audio/WlxhL03JRUbSgwUKAYAwuD5awd1Ssu1GaKyNFTDo.webm', NULL, NULL, '2024-09-17 19:13:32', '2024-09-17 19:15:30'),
(3, 1, 'vendor', 1, 2, NULL, 'images/kxwF5UQggp57jr3AM9OywcQpfVZsk2SRIrQxfi4H.jpg', NULL, '2024-09-17 19:13:45', '2024-09-17 19:15:30'),
(4, 1, 'vendor', 1, 2, NULL, NULL, 'أهلا', '2024-09-17 19:13:57', '2024-09-17 19:15:30'),
(5, 1, 'vendor', 1, 2, 'audio/ljphnLCUexXy3cr5ZWQC1t05Nc8YvJKIZebkmUSN.webm', NULL, NULL, '2024-09-17 19:15:40', '2024-09-17 19:19:05'),
(6, 1, 'vendor', 1, 2, 'audio/uXg0qNR0F01zJZZdd6fnOjj2mhC3Slfbt1jB9xJI.webm', NULL, NULL, '2024-09-17 19:15:58', '2024-09-17 19:19:05'),
(7, 1, 'vendor', 1, 2, 'audio/7Sg0hR0qMvd0EpuUUes2D71yKDH5aXGHc6I4hbhb.webm', NULL, NULL, '2024-09-17 19:16:49', '2024-09-17 19:19:05'),
(8, 0, 'vendor', 2, 46, NULL, NULL, 'Hi', '2024-09-17 19:25:43', '2024-09-17 19:25:43'),
(9, 0, 'vendor', 2, 46, 'audio/gPrfaIpFellxrPtjIU0xXNLSs9YHswbGftsTg1Es.webm', NULL, NULL, '2024-09-17 19:25:54', '2024-09-17 19:25:54'),
(10, 0, 'vendor', 2, 46, NULL, 'images/Z5mSDJzPEqXLtUB7HDH476NC5S3T88zS0jxbAZd7.png', NULL, '2024-09-17 19:26:17', '2024-09-17 19:26:17'),
(11, 0, 'vendor', 2, 46, NULL, NULL, 'لقد تم ارسال طلب زيارة من 46 إٍسم التاجر   إلى - 46 إٍسم التاجر   🚚', '2024-09-17 19:26:25', '2024-09-17 19:26:25'),
(12, 1, 'user', 3, 2, NULL, NULL, 'أهلا انا اكلم نفسى الأن', '2024-09-17 19:35:57', '2024-09-17 20:08:25'),
(13, 1, 'user', 3, 2, NULL, NULL, 'لقد تم ارسال طلب زيارة من 2 إسم المتسخدم  إلى - 2 إسم المتسخدم  🚚', '2024-09-17 19:36:01', '2024-09-17 20:08:25'),
(14, 1, 'user', 3, 2, 'audio/CPuiSkU04QbFBAmeg2rCYIiFKFq4utTrx7kpASwG.webm', NULL, NULL, '2024-09-17 19:36:17', '2024-09-17 20:08:25'),
(15, 1, 'user', 3, 2, NULL, 'images/Qeg6PnBvdf96ecfGMuK1JI1YnUvyhINTMMLdHlux.png', NULL, '2024-09-17 19:36:31', '2024-09-17 20:08:25'),
(16, 1, 'user', 4, 2, NULL, NULL, 'Hi', '2024-09-17 20:06:53', '2024-09-19 07:37:14'),
(18, 1, 'user', 11, 62, NULL, NULL, 'jfjfjf', '2024-09-18 01:49:31', '2024-09-18 01:51:53'),
(19, 1, 'user', 11, 62, NULL, NULL, 'jfjfjf', '2024-09-18 01:49:32', '2024-09-18 01:51:53'),
(20, 1, 'user', 11, 62, NULL, NULL, 'fff', '2024-09-18 01:49:37', '2024-09-18 01:51:53'),
(21, 1, 'user', 11, 62, NULL, NULL, 'fffff', '2024-09-18 01:49:47', '2024-09-18 01:51:53'),
(22, 1, 'user', 11, 62, 'audio/bDyzWtuAhSQU4sXqPOhz2h0zZqMeqPUQ810WGXAB.webm', NULL, NULL, '2024-09-18 01:50:10', '2024-09-18 01:51:53'),
(23, 1, 'user', 11, 62, NULL, NULL, 'لقد تم ارسال طلب زيارة من rajeeh إلى - 46 إٍسم التاجر   🚚', '2024-09-18 01:50:19', '2024-09-18 01:51:53'),
(24, 1, 'user', 11, 62, NULL, 'images/2CyQTzRO5SqFn6itev4jyNwzYfZUJGldGX03tWxJ.png', NULL, '2024-09-18 01:50:53', '2024-09-18 01:51:53'),
(25, 1, 'user', 3, 2, NULL, NULL, 'تم ارسال طلب زيارة من 2 إسم المتسخدم  إلى 2 إٍسم التاجر   🚚', '2024-09-19 08:13:20', '2024-09-19 13:55:26'),
(26, 1, 'user', 3, 2, 'audio/RW7nZ3Dmrc5wy2fGGraYM3TloyCIYImSc5ma8HCx.webm', NULL, NULL, '2024-09-19 08:13:40', '2024-09-19 13:55:26'),
(27, 1, 'user', 3, 2, 'audio/C4r2GiVrH83EpO8QMboHTgGk7GYET9vs4Ghkfgtu.webm', NULL, NULL, '2024-09-19 08:17:32', '2024-09-19 13:55:26'),
(28, 1, 'user', 3, 2, 'audio/VdqKNo8zTGKuHbAvHpIbdj55FLUHPp9tHMJfXcvy.webm', NULL, NULL, '2024-09-19 08:17:45', '2024-09-19 13:55:26'),
(29, 1, 'user', 13, 1, NULL, NULL, 'لقد تم ارسال طلب زيارة من Admin إلى - 47 إٍسم التاجر   🚚', '2024-09-20 13:12:02', '2024-09-20 13:13:20'),
(30, 1, 'user', 13, 1, 'audio/ylZV70yVWszgOmflapTpSiE2omyjrleVF95hzcV1.webm', NULL, NULL, '2024-09-20 13:12:20', '2024-09-20 13:13:20'),
(31, 1, 'user', 13, 1, NULL, NULL, 'أهلا', '2024-09-20 13:12:34', '2024-09-20 13:13:20');

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
(4, '2024_08_06_184556_create_services_types_table', 1),
(5, '2024_08_07_112519_create_notifactions_table', 1),
(6, '2024_08_07_112545_create_vendors_table', 1),
(7, '2024_08_07_112556_create_services_table', 1),
(9, '2024_08_07_112611_create_adresses_table', 1),
(11, '2024_08_09_032926_create_messages_table', 1),
(12, '2024_08_09_042813_create_sliders_table', 1),
(13, '2024_08_18_043028_create_personal_access_tokens_table', 1),
(14, '2024_08_20_151037_create_notifaction_vendors_table', 1),
(15, '2024_08_24_040444_add_api_token_to_vendors_table', 1),
(17, '2024_08_27_170638_create_service_sliders_table', 1),
(18, '2024_09_03_160622_create_phonecodes_table', 1),
(19, '2024_09_04_044239_create_ordermoneys_table', 1),
(20, '2024_09_05_043947_create_temp_payments_table', 1),
(21, '2024_09_07_121444_create__bills_table', 1),
(22, '2024_09_08_064050_create_customerservices_table', 1),
(23, '2024_09_08_072907_create_vendorservices_table', 1),
(24, '2024_09_09_135611_create_customerserviceconversations_table', 1),
(25, '2024_09_11_042015_create_customer_service_messages_table', 1),
(26, '2024_08_27_170555_create_orderoffers_table', 2),
(27, '2024_08_07_112604_create_orders_table', 3),
(28, '2024_08_09_032833_create_conversations_table', 4);

-- --------------------------------------------------------

--
-- Table structure for table `notifactions`
--

CREATE TABLE `notifactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `message` varchar(255) NOT NULL,
  `read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifactions`
--

INSERT INTO `notifactions` (`id`, `user_id`, `message`, `read`, `created_at`, `updated_at`) VALUES
(1, 2, 'صصصصصص', 1, '2024-09-18 02:50:39', '2024-09-19 15:24:45'),
(2, 2, 'الطلب الخاص بك لا يزال فى طور المراجعة', 1, '2024-09-19 14:11:57', '2024-09-19 15:24:45'),
(3, 2, 'تم حل المشكلة الخاصة بك من قبل خدمة العملاء !', 0, '2024-09-20 12:50:09', '2024-09-20 12:50:09');

-- --------------------------------------------------------

--
-- Table structure for table `notifaction_vendors`
--

CREATE TABLE `notifaction_vendors` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `vendor_id` bigint(20) UNSIGNED NOT NULL,
  `message` varchar(255) NOT NULL,
  `read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifaction_vendors`
--

INSERT INTO `notifaction_vendors` (`id`, `vendor_id`, `message`, `read`, `created_at`, `updated_at`) VALUES
(2, 2, 'مبروك! تم قبول خدمتك :dfssdfsdsdfdf', 1, '2024-09-18 02:48:16', '2024-09-20 13:49:55'),
(3, 12, 'صصصصصصص', 0, '2024-09-18 02:50:25', '2024-09-18 02:50:25'),
(4, 25, 'مبروك! تم قبول خدمتك :1عنوان الخدمة', 0, '2024-09-19 03:32:16', '2024-09-19 03:32:16'),
(5, 2, 'مبروك! تم قبول خدمتك :dsfsdfsdfsfdfd', 1, '2024-09-19 03:32:25', '2024-09-20 13:49:55'),
(6, 2, 'عذرا!!! لم يتم قبول خدمتك :dsfsdfsdfsfdfd', 1, '2024-09-19 03:32:32', '2024-09-20 13:49:55'),
(7, 2, 'الطلب الخاص بك لا يزال فى طور المراجعة', 1, '2024-09-20 13:47:35', '2024-09-20 13:49:55');

-- --------------------------------------------------------

--
-- Table structure for table `ordermoneys`
--

CREATE TABLE `ordermoneys` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `vendor_id` bigint(20) UNSIGNED NOT NULL,
  `paypalaccount` varchar(255) NOT NULL,
  `amount` varchar(255) NOT NULL,
  `order_status` varchar(255) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orderoffers`
--

CREATE TABLE `orderoffers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `offer` text NOT NULL,
  `sender_id` bigint(20) UNSIGNED NOT NULL,
  `sender_type` varchar(255) NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orderoffers`
--

INSERT INTO `orderoffers` (`id`, `offer`, `sender_id`, `sender_type`, `order_id`, `created_at`, `updated_at`) VALUES
(1, 'sdfdsfsffsdf', 53, 'user', 51, '2024-09-15 21:17:07', '2024-09-15 21:17:07'),
(2, 'sdfdsfdsfsdfsdsdf', 53, 'user', 51, '2024-09-15 21:27:11', '2024-09-15 21:27:11'),
(3, 'sdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdf', 53, 'user', 51, '2024-09-15 21:28:21', '2024-09-15 21:28:21'),
(4, 'sdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdf', 53, 'user', 51, '2024-09-15 21:28:55', '2024-09-15 21:28:55'),
(5, 'sdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdf', 53, 'user', 51, '2024-09-15 21:29:17', '2024-09-15 21:29:17'),
(6, 'sdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdf', 53, 'user', 51, '2024-09-15 21:33:23', '2024-09-15 21:33:23'),
(7, 'sdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdf', 53, 'user', 51, '2024-09-15 21:33:34', '2024-09-15 21:33:34'),
(8, 'sdfsdfdfsdfssdfsdfsdfdfsdfssdfsdfsdfdfsdfssdf', 53, 'user', 51, '2024-09-15 21:34:04', '2024-09-15 21:34:04'),
(9, '0109234345101092343451010923434510109234345101092343451', 1, 'vendor', 52, '2024-09-15 21:37:02', '2024-09-15 21:37:02'),
(10, 'asasdasddsadsdasdasasdasddsadsdasdasasdasddsadsdasdasasdasddsadsdasd', 1, 'vendor', 52, '2024-09-15 21:37:09', '2024-09-15 21:37:09'),
(11, 'asasdasddsadsdasdasasdasddsadsdasdasasdasddsadsdasdasasdasddsadsdasdasasdasddsadsdasdasasdasddsadsdasd', 1, 'vendor', 52, '2024-09-15 21:37:11', '2024-09-15 21:37:11'),
(12, 'asasdasddsadsdasdasasdasddsadsdasdasasdasddsadsdasdasasdasddsadsdasdasasdasddsadsdasdasasdasddsadsdasdasasdasddsadsdasdasasdasddsadsdasd', 1, 'vendor', 52, '2024-09-15 21:37:14', '2024-09-15 21:37:14'),
(13, 'asasdasddsadsdasdasasdasddsadsdasdasasdasddsadsdasdasasdasddsadsdasdasasdasddsadsdasdasasdasddsadsdasdasasdasddsadsdasdasasdasddsadsdasdasasdasddsadsdasdasasdasddsadsdasdasasdasddsadsdasdasasdasddsadsdasd', 1, 'vendor', 52, '2024-09-15 21:37:19', '2024-09-15 21:37:19'),
(14, 'fff', 52, 'user', 3, '2024-09-17 16:53:02', '2024-09-17 16:53:02'),
(15, 'ddd', 52, 'user', 4, '2024-09-17 16:53:16', '2024-09-17 16:53:16'),
(17, 'إضافة عرض جديد اختبار من حساب تاجر', 1, 'vendor', 9, '2024-09-17 17:48:45', '2024-09-17 17:48:45'),
(21, 'إختبار ارسال عرض من حساب تاجر', 2, 'user', 11, '2024-09-17 20:08:18', '2024-09-17 20:08:18'),
(27, 'gfgfgfgfgghfh', 51, 'vendor', 17, '2024-09-17 22:59:28', '2024-09-17 22:59:28'),
(28, 'ddd', 2, 'user', 11, '2024-09-18 00:15:27', '2024-09-18 00:15:27');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(100) NOT NULL,
  `sender_type` varchar(255) NOT NULL,
  `Service_descripe` varchar(255) DEFAULT '',
  `image` varchar(255) DEFAULT NULL,
  `coast` decimal(10,2) DEFAULT NULL,
  `service_type` varchar(255) DEFAULT NULL,
  `special_instructions` text DEFAULT NULL,
  `servicetype_id` bigint(20) UNSIGNED NOT NULL,
  `vendor_id` bigint(20) UNSIGNED DEFAULT NULL,
  `sender_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `title`, `sender_type`, `Service_descripe`, `image`, `coast`, `service_type`, `special_instructions`, `servicetype_id`, `vendor_id`, `sender_id`, `created_at`, `updated_at`) VALUES
(2, 'أهلا لدى مشكلة فى تصليح السيارة الخاصة بى', 'user', 'أهلا لدى مشكلة فى تصليح السيارة الخاصة بى', NULL, NULL, '3عنوان القسم', NULL, 4, NULL, 2, '2024-09-16 03:56:56', '2024-09-16 03:56:56'),
(3, 'أهلا لدى مشكلة فى تصليح السيارة الخاصة بى', 'user', 'أهلا لدى مشكلة فى تصليح السيارة الخاصة بى', NULL, NULL, '4عنوان القسم', NULL, 5, NULL, 2, '2024-09-16 03:57:50', '2024-09-16 03:57:50'),
(4, 'أهلا لدى مشكلة عويصة فى تصليح نظام الصرف', 'user', 'أهلا لدى مشكلة عويصة فى تصليح نظام الصرف فى المنزل', NULL, NULL, '4عنوان القسم', NULL, 5, NULL, 2, '2024-09-16 04:09:29', '2024-09-16 04:09:29'),
(6, 'تجربة اضافة عرض جديد -2', 'vendor', 'تجربة اضافة عرض جديد -2', NULL, NULL, '5عنوان القسم', NULL, 6, NULL, 2, '2024-09-17 17:04:32', '2024-09-17 17:04:32'),
(7, 'تجربة اضافة طلب جديد -3', 'user', 'تجربة اضافة طلب جديد -3', 'https://alrajhost.com/public/images/orders/20240917-170553_jpg', NULL, '6عنوان القسم', NULL, 7, NULL, 2, '2024-09-17 17:05:53', '2024-09-17 17:05:53'),
(9, 'تجربة اضافة طلب جديد - 5', 'user', 'تجربة اضافة طلب جديد - 5', NULL, NULL, '3عنوان القسم', NULL, 4, NULL, 2, '2024-09-17 17:07:34', '2024-09-17 17:07:34'),
(11, 'أهلا هذا أخر إختبار', 'user', 'أهلا هذا أخر إختبار', NULL, NULL, '7عنوان القسم', NULL, 8, NULL, 2, '2024-09-17 20:07:44', '2024-09-17 20:07:44'),
(15, 'sdfsdfsdfsdfsdf', 'user', 'sdfsdfsdfsdfsdf', NULL, NULL, '5عنوان القسم', NULL, 6, NULL, 61, '2024-09-17 22:45:50', '2024-09-17 22:45:50'),
(17, 'gcgcfcfvxzxczccxzxv', 'vendor', 'gcgcfcfvxzxczccxzxv', NULL, NULL, '8عنوان القسم', NULL, 9, NULL, 51, '2024-09-17 22:59:12', '2024-09-17 22:59:12'),
(19, 'sdfsdfdsfsdfdsf', 'vendor', 'sdfsdfdsfsdfdsf', 'https://alrajhost.com/public/images/orders/20240918-152126_jpg', NULL, '8عنوان القسم', NULL, 9, NULL, 52, '2024-09-18 15:21:26', '2024-09-18 15:21:26');

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
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(8, 'App\\Models\\User', 51, 'auth_token', 'd151f5996ceb090b3e225a109dad222a53df545565470ae7ac33a545dc7cb09e', '[\"*\"]', '2024-09-17 02:56:59', NULL, '2024-09-17 02:53:12', '2024-09-17 02:56:59'),
(12, 'App\\Models\\User', 52, 'auth_token', '1376f1bf764669443eeae55c0cd20e909c7cc72a8ec8c4d5b2fa6448cc33bf23', '[\"*\"]', '2024-09-17 20:38:43', NULL, '2024-09-17 16:52:05', '2024-09-17 20:38:43'),
(29, 'App\\Models\\User', 53, 'auth_token', '5c0a9f03361d69ef34c25648b62b23c655ba5baab16aff0954b78bd8e0f1db24', '[\"*\"]', '2024-09-17 20:05:15', NULL, '2024-09-17 19:43:21', '2024-09-17 20:05:15'),
(32, 'App\\Models\\User', 52, 'auth_token', '1688ff6a38347b2b23fb727e911b89f786c1240862e69298b3b6a42b4bb3d2c9', '[\"*\"]', '2024-09-17 20:41:00', NULL, '2024-09-17 20:35:22', '2024-09-17 20:41:00'),
(43, 'App\\Models\\User', 59, 'auth_token', '3c8399c03128a5ce59f06a597d823b7d9c38586b0c1c4ec1f77f82d19cf6bde6', '[\"*\"]', '2024-09-17 22:27:49', NULL, '2024-09-17 22:27:41', '2024-09-17 22:27:49');

-- --------------------------------------------------------

--
-- Table structure for table `phonecodes`
--

CREATE TABLE `phonecodes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `coast` decimal(8,2) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `rating` decimal(8,2) DEFAULT NULL,
  `link_video` decimal(8,2) DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `start_price` decimal(8,2) DEFAULT NULL,
  `end_price` decimal(8,2) DEFAULT NULL,
  `extra_services` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`extra_services`)),
  `key_words` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`key_words`)),
  `vendor_id` bigint(20) UNSIGNED NOT NULL,
  `servicetype_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`id`, `title`, `description`, `coast`, `image`, `rating`, `link_video`, `status`, `start_price`, `end_price`, `extra_services`, `key_words`, `vendor_id`, `servicetype_id`, `created_at`, `updated_at`) VALUES
(2, '1عنوان الخدمة ', '1وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-4.jpg', 5.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 25, 37, '2024-09-13 21:15:29', NULL),
(3, '2عنوان الخدمة ', '2وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-4.jpg', 2.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 45, 46, '2024-09-13 21:15:29', NULL),
(4, '3عنوان الخدمة ', '3وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-4.jpg', 3.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 37, 18, '2024-09-13 21:15:29', NULL),
(5, '4عنوان الخدمة ', '4وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-4.jpg', 4.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 46, 38, '2024-09-13 21:15:29', NULL),
(7, '6عنوان الخدمة ', '6وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-code.jpg', 2.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 36, 16, '2024-09-13 21:15:29', NULL),
(8, '7عنوان الخدمة ', '7وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-4.jpg', 4.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 19, 22, '2024-09-13 21:15:29', NULL),
(9, '8عنوان الخدمة ', '8وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-4.jpg', 4.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 45, 32, '2024-09-13 21:15:29', NULL),
(10, '9عنوان الخدمة ', '9وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-4.jpg', 2.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 8, 40, '2024-09-13 21:15:29', NULL),
(11, '10عنوان الخدمة ', '10وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-4.jpg', 2.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 49, 6, '2024-09-13 21:15:29', NULL),
(12, '11عنوان الخدمة ', '11وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-code.jpg', 2.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 34, 32, '2024-09-13 21:15:29', NULL),
(13, '12عنوان الخدمة ', '12وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-4.jpg', 3.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 12, 43, '2024-09-13 21:15:29', NULL),
(14, '13عنوان الخدمة ', '13وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-6.jpg', 3.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 22, 44, '2024-09-13 21:15:29', NULL),
(15, '14عنوان الخدمة ', '14وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-4.jpg', 3.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 30, 13, '2024-09-13 21:15:29', NULL),
(16, '15عنوان الخدمة ', '15وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-6.jpg', 4.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 34, 17, '2024-09-13 21:15:29', NULL),
(17, '16عنوان الخدمة ', '16وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-6.jpg', 3.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 50, 44, '2024-09-13 21:15:29', NULL),
(19, '18عنوان الخدمة ', '18وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-6.jpg', 2.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 47, 43, '2024-09-13 21:15:29', NULL),
(20, '19عنوان الخدمة ', '19وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-6.jpg', 3.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 9, 10, '2024-09-13 21:15:29', NULL),
(21, '20عنوان الخدمة ', '20وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-code.jpg', 3.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 27, 7, '2024-09-13 21:15:29', NULL),
(22, '21عنوان الخدمة ', '21وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-4.jpg', 2.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 40, 9, '2024-09-13 21:15:29', NULL),
(23, '22عنوان الخدمة ', '22وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-4.jpg', 2.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 21, 17, '2024-09-13 21:15:29', NULL),
(24, '23عنوان الخدمة ', '23وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-4.jpg', 4.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 28, 19, '2024-09-13 21:15:29', NULL),
(25, '24عنوان الخدمة ', '24وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-code.jpg', 3.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 33, 14, '2024-09-13 21:15:29', NULL),
(26, '25عنوان الخدمة ', '25وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-4.jpg', 3.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 50, 49, '2024-09-13 21:15:29', NULL),
(27, '26عنوان الخدمة ', '26وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-4.jpg', 2.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 47, 15, '2024-09-13 21:15:29', NULL),
(28, '27عنوان الخدمة ', '27وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-code.jpg', 3.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 46, 25, '2024-09-13 21:15:29', NULL),
(29, '28عنوان الخدمة ', '28وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-4.jpg', 4.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 17, 34, '2024-09-13 21:15:29', NULL),
(30, '29عنوان الخدمة ', '29وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-code.jpg', 3.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 42, 50, '2024-09-13 21:15:29', NULL),
(31, '30عنوان الخدمة ', '30وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-4.jpg', 5.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 48, 13, '2024-09-13 21:15:29', NULL),
(32, '31عنوان الخدمة ', '31وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-4.jpg', 2.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 38, 40, '2024-09-13 21:15:29', NULL),
(33, '32عنوان الخدمة ', '32وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-4.jpg', 3.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 26, 11, '2024-09-13 21:15:29', NULL),
(34, '33عنوان الخدمة ', '33وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-6.jpg', 3.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 5, 47, '2024-09-13 21:15:29', NULL),
(35, '34عنوان الخدمة ', '34وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-4.jpg', 2.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 46, 41, '2024-09-13 21:15:29', NULL),
(36, '35عنوان الخدمة ', '35وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-6.jpg', 5.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 26, 12, '2024-09-13 21:15:29', NULL),
(37, '36عنوان الخدمة ', '36وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-4.jpg', 3.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 17, 13, '2024-09-13 21:15:29', NULL),
(38, '37عنوان الخدمة ', '37وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-4.jpg', 4.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 44, 4, '2024-09-13 21:15:29', NULL),
(39, '38عنوان الخدمة ', '38وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-code.jpg', 4.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 39, 13, '2024-09-13 21:15:29', NULL),
(40, '39عنوان الخدمة ', '39وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-code.jpg', 3.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 8, 16, '2024-09-13 21:15:29', NULL),
(41, '40عنوان الخدمة ', '40وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-code.jpg', 2.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 12, 17, '2024-09-13 21:15:29', NULL),
(42, '41عنوان الخدمة ', '41وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-6.jpg', 5.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 17, 37, '2024-09-13 21:15:29', NULL),
(43, '42عنوان الخدمة ', '42وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-6.jpg', 4.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 13, 13, '2024-09-13 21:15:29', NULL),
(44, '43عنوان الخدمة ', '43وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-4.jpg', 2.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 19, 39, '2024-09-13 21:15:29', NULL),
(45, '44عنوان الخدمة ', '44وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-6.jpg', 4.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 50, 44, '2024-09-13 21:15:29', NULL),
(46, '45عنوان الخدمة ', '45وصف الخدمة ', 400.00, 'https://alrajhost.com/public/images/services/slider-code.jpg', 5.00, NULL, 'published', 299.00, 799.00, '[{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 1\",\"coast_extra_service\":\"23\"},{\"title_extra_service\":\"\\u062e\\u062f\\u0645\\u0629 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629 2\",\"coast_extra_service\":\"21\"}]', '[\"test\",\"test\",\"test\"]', 15, 20, '2024-09-13 21:15:29', NULL),
(57, 'dsfsdfsdfsfdfd', 'sdfdfdsffsdfsdf', 222.00, 'https://alrajhost.com/public/images/vendors/20240918-005457_jpg', NULL, NULL, 'pending', 0.00, 0.00, '\"[{\\\"title_extra_service\\\":\\\"\\u062a\\u0635\\u0648\\u064a\\u0631 \\u0625\\u062d\\u062a\\u0631\\u0627\\u0641\\u0649 + \\u062a\\u0639\\u062f\\u064a\\u0644\\\",\\\"coast_extra_service\\\":\\\"44\\\"},{\\\"title_extra_service\\\":\\\"\\u062a\\u0635\\u0648\\u064a\\u0631 \\u0625\\u0627\\u0627\\u062d\\u062a\\u0631\\u0627\\u0641\\u0649 + \\u062a\\u0639\\u062f\\u064a\\u0644\\\",\\\"coast_extra_service\\\":\\\"23\\\"}]\"', NULL, 2, 11, '2024-09-18 00:48:31', '2024-09-19 03:32:31');

-- --------------------------------------------------------

--
-- Table structure for table `services_types`
--

CREATE TABLE `services_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `services_types`
--

INSERT INTO `services_types` (`id`, `title`, `image`, `created_at`, `updated_at`) VALUES
(1, '0عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-6.png', NULL, NULL),
(4, '3عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-6.png', NULL, NULL),
(5, '4عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-5.png', NULL, NULL),
(6, '5عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-6.png', NULL, NULL),
(7, '6عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-9.png', NULL, NULL),
(8, '7عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-9.png', NULL, NULL),
(9, '8عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-6.png', NULL, NULL),
(10, '9عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-6.png', NULL, NULL),
(11, '10عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-9.png', NULL, NULL),
(12, '11عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-9.png', NULL, NULL),
(13, '12عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-6.png', NULL, NULL),
(14, '13عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-9.png', NULL, NULL),
(15, '14عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-6.png', NULL, NULL),
(16, '15عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-9.png', NULL, NULL),
(17, '16عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-5.png', NULL, NULL),
(18, '17عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-5.png', NULL, NULL),
(19, '18عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-5.png', NULL, NULL),
(20, '19عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-5.png', NULL, NULL),
(21, '20عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-9.png', NULL, NULL),
(22, '21عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-5.png', NULL, NULL),
(23, '22عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-5.png', NULL, NULL),
(24, '23عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-5.png', NULL, NULL),
(25, '24عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-6.png', NULL, NULL),
(26, '25عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-9.png', NULL, NULL),
(27, '26عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-6.png', NULL, NULL),
(28, '27عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-6.png', NULL, NULL),
(29, '28عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-9.png', NULL, NULL),
(30, '29عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-9.png', NULL, NULL),
(31, '30عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-5.png', NULL, NULL),
(32, '31عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-9.png', NULL, NULL),
(33, '32عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-6.png', NULL, NULL),
(34, '33عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-9.png', NULL, NULL),
(35, '34عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-9.png', NULL, NULL),
(36, '35عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-6.png', NULL, NULL),
(37, '36عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-6.png', NULL, NULL),
(38, '37عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-5.png', NULL, NULL),
(39, '38عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-9.png', NULL, NULL),
(40, '39عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-5.png', NULL, NULL),
(41, '40عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-9.png', NULL, NULL),
(42, '41عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-9.png', NULL, NULL),
(43, '42عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-5.png', NULL, NULL),
(44, '43عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-5.png', NULL, NULL),
(45, '44عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-6.png', NULL, NULL),
(46, '45عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-5.png', NULL, NULL),
(47, '46عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-9.png', NULL, NULL),
(48, '47عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-5.png', NULL, NULL),
(49, '48عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-5.png', NULL, NULL),
(50, '49عنوان القسم ', 'https://alrajhost.com/public/images/servicestypes/cat-6.png', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `service_sliders`
--

CREATE TABLE `service_sliders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `image` longtext NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `service_sliders`
--

INSERT INTO `service_sliders` (`id`, `title`, `image`, `created_at`, `updated_at`) VALUES
(1, 'عنوان الخدمة 1', 'https://alrajhost.com/public/images/servicestypes/cat-6.png', '2024-09-13 22:04:43', NULL),
(2, 'عنوان الخدمة 2', 'https://alrajhost.com/public/images/servicestypes/cat-5.png', '2024-09-13 22:04:43', NULL),
(3, 'عنوان الخدمة 3', 'https://alrajhost.com/public/images/servicestypes/cat-5.png', '2024-09-13 22:04:43', NULL),
(4, 'عنوان الخدمة 4', 'https://alrajhost.com/public/images/servicestypes/cat-6.png', '2024-09-13 22:04:43', NULL),
(5, 'عنوان الخدمة 5', 'https://alrajhost.com/public/images/servicestypes/cat-9.png', '2024-09-13 22:04:43', NULL),
(6, 'عنوان الخدمة 6', 'https://alrajhost.com/public/images/servicestypes/cat-6.png', '2024-09-13 22:04:43', NULL),
(7, 'عنوان الخدمة 7', 'https://alrajhost.com/public/images/servicestypes/cat-5.png', '2024-09-13 22:04:43', NULL),
(8, 'عنوان الخدمة 8', 'https://alrajhost.com/public/images/servicestypes/cat-9.png', '2024-09-13 22:04:43', NULL),
(9, 'عنوان الخدمة 9', 'https://alrajhost.com/public/images/servicestypes/cat-9.png', '2024-09-13 22:04:43', NULL),
(10, 'عنوان الخدمة 10', 'https://alrajhost.com/public/images/servicestypes/cat-6.png', '2024-09-13 22:04:43', NULL);

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

-- --------------------------------------------------------

--
-- Table structure for table `sliders`
--

CREATE TABLE `sliders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `image` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `extra-content` varchar(255) DEFAULT NULL,
  `rating` decimal(8,2) DEFAULT NULL,
  `stars` decimal(8,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sliders`
--

INSERT INTO `sliders` (`id`, `image`, `title`, `description`, `extra-content`, `rating`, `stars`, `created_at`, `updated_at`) VALUES
(1, 'https://alrajhost.com/public/images/sliders/slider-3.jpg', 'العرض الرئيسى 1', ' وصف العرض الرئيسى 1', 'mBVt1vntCe@extra-content', 3.00, 4.00, '2024-09-13 21:15:29', NULL),
(2, 'https://alrajhost.com/public/images/sliders/service.jpg', 'العرض الرئيسى 2', ' وصف العرض الرئيسى 2', 'ndRdxIDfor@extra-content', 2.00, 2.00, '2024-09-13 21:15:29', NULL),
(3, 'https://alrajhost.com/public/images/sliders/slider-1.jpg', 'العرض الرئيسى 3', ' وصف العرض الرئيسى 3', '7RCYaGsrbo@extra-content', 3.00, 5.00, '2024-09-13 21:15:29', NULL),
(4, 'https://alrajhost.com/public/images/sliders/slider-1.jpg', 'العرض الرئيسى 4', ' وصف العرض الرئيسى 4', 'EJqoIMVjcY@extra-content', 3.00, 3.00, '2024-09-13 21:15:29', NULL),
(5, 'https://alrajhost.com/public/images/sliders/service.jpg', 'العرض الرئيسى 5', ' وصف العرض الرئيسى 5', 'pLjPdFOSu1@extra-content', 5.00, 4.00, '2024-09-13 21:15:29', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `temp_payments`
--

CREATE TABLE `temp_payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `temp_payment_id` varchar(255) NOT NULL,
  `services_with_amount` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`services_with_amount`)),
  `expires_at` timestamp NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `temp_payments`
--

INSERT INTO `temp_payments` (`id`, `temp_payment_id`, `services_with_amount`, `expires_at`, `created_at`, `updated_at`) VALUES
(5, '66e8ad63b3da8', '[{\"id\":8,\"totalAmount\":\"400.00\"}]', '2024-09-16 22:22:51', '2024-09-16 22:12:51', '2024-09-16 22:12:51'),
(6, '66e8add90ec1b', '[{\"id\":8,\"totalAmount\":\"400.00\"}]', '2024-09-16 22:24:49', '2024-09-16 22:14:49', '2024-09-16 22:14:49'),
(7, '66e8ae5823a9b', '[{\"id\":25,\"totalAmount\":\"400.00\"}]', '2024-09-16 22:26:56', '2024-09-16 22:16:56', '2024-09-16 22:16:56'),
(8, '66e8ae9f03ec7', '[{\"id\":25,\"totalAmount\":\"400.00\"}]', '2024-09-16 22:28:07', '2024-09-16 22:18:07', '2024-09-16 22:18:07'),
(9, '66e8af08385d7', '[{\"id\":25,\"totalAmount\":\"400.00\"}]', '2024-09-16 22:29:52', '2024-09-16 22:19:52', '2024-09-16 22:19:52'),
(10, '66e8af1098bca', '[{\"id\":25,\"totalAmount\":\"400.00\"}]', '2024-09-16 22:30:00', '2024-09-16 22:20:00', '2024-09-16 22:20:00'),
(11, '66e8af846433f', '[{\"id\":25,\"totalAmount\":\"400.00\"}]', '2024-09-16 22:31:56', '2024-09-16 22:21:56', '2024-09-16 22:21:56'),
(12, '66e8af8716aee', '[{\"id\":25,\"totalAmount\":\"400.00\"}]', '2024-09-16 22:31:59', '2024-09-16 22:21:59', '2024-09-16 22:21:59'),
(13, '66e8afbf2a2ee', '[{\"id\":25,\"totalAmount\":\"400.00\"}]', '2024-09-16 22:32:55', '2024-09-16 22:22:55', '2024-09-16 22:22:55'),
(17, '66e8b1f94fcdf', '[{\"id\":34,\"totalAmount\":\"400.00\"}]', '2024-09-16 22:42:25', '2024-09-16 22:32:25', '2024-09-16 22:32:25'),
(18, '66e8b26dea196', '[{\"id\":34,\"totalAmount\":\"400.00\"}]', '2024-09-16 22:44:21', '2024-09-16 22:34:21', '2024-09-16 22:34:21');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `account_type` varchar(255) NOT NULL DEFAULT 'user',
  `email` varchar(255) NOT NULL,
  `balance` int(11) NOT NULL DEFAULT 0,
  `is_available` tinyint(1) NOT NULL DEFAULT 0,
  `is_guest` tinyint(1) NOT NULL DEFAULT 0,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('user','Admin','serviceinspector','customerservice','guest') NOT NULL DEFAULT 'user',
  `image` varchar(255) DEFAULT NULL,
  `phone_number` varchar(20) NOT NULL,
  `location` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `account_type`, `email`, `balance`, `is_available`, `is_guest`, `email_verified_at`, `password`, `role`, `image`, `phone_number`, `location`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'user', 'Admin@mail.com', 0, 0, 0, NULL, '$2y$12$thSUAkzSoJRcx5NuLtShKOkS0tCsFCqpUjGxdMfMzEJfWV0mmu8We', 'Admin', 'https://alrajhost.com/public/images/users/20240916052835.jpg', '96600000000000', '{\"address\":\"6, شارع محمد نصر, قريه سندبسط, الغربية, 31646, مصر\",\"latitude\":30.6965544,\"longitude\":31.2608757}', NULL, '2024-09-16 06:21:10', '2024-09-20 15:14:37'),
(2, '2 إسم المتسخدم ', 'user', '4pbWymUCnF@fakeemail.com', 0, 0, 0, NULL, '$2y$12$m2qbW0xMq4z0.j0bh8ijGO/DXQhtRt6D9lu5jCWRm3Z5wD1e4EvqW', 'customerservice', 'https://alrajhost.com/public/images/users/20240914-042204.jpg', '96699092343452', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:10', '2024-09-19 08:01:21'),
(3, '3 إسم المتسخدم ', 'user', '1JyG12FdId@fakeemail.com', 0, 0, 0, NULL, '$2y$12$qwZWl91Fk.viYwZgmjR6c.07ctmpijGc5fIAMupedah/VygwO9o2e', 'user', 'https://alrajhost.com/public/images/users/20240916040845.jpg', '99092343453', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:10', NULL),
(4, '4 إسم المتسخدم ', 'user', 'ORd2LJjV0U@fakeemail.com', 0, 0, 0, NULL, '$2y$12$afTw4eKK0hb/MquKTZXu9eCq0NLT8BCCAJ2zygJrJm7QINop4MOmW', 'user', 'https://alrajhost.com/public/images/users/20240916052835.jpg', '99092343454', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:11', NULL),
(5, '5 إسم المتسخدم ', 'user', 'MnbLe8u0Fj@fakeemail.com', 0, 0, 0, NULL, '$2y$12$ApSERNWLk1E55QsfEWWwaOg5H.I4FNIYxc9u6hLTToa2pRR3MQkZ2', 'user', 'https://alrajhost.com/public/images/users/20240914-042204.jpg', '99092343455', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:11', NULL),
(6, '6 إسم المتسخدم ', 'user', 'PpseBzAOfR@fakeemail.com', 0, 0, 0, NULL, '$2y$12$8u2I9fuvavw8Qbfhl4ATXOkB3dPLv6MUr.KU852lx9mzGSp4BobKK', 'user', 'https://alrajhost.com/public/images/users/20240916040845.jpg', '99092343456', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:11', NULL),
(7, '7 إسم المتسخدم ', 'user', 'PvpGUG0cRZ@fakeemail.com', 0, 0, 0, NULL, '$2y$12$YyoxMpVj29AHEoA49wYdWO8Bqo0NXNqwZ0rSeDfagmTIoQZz7POl2', 'user', 'https://alrajhost.com/public/images/users/20240915040212.jpg', '99092343457', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:11', NULL),
(8, '8 إسم المتسخدم ', 'user', 'aPbCZ7Rwdp@fakeemail.com', 0, 0, 0, NULL, '$2y$12$1cbJghRe.ZeoZGeerj/FA.SuhJ3UBeNsPmPfeXYo1aZMFM7R6y/rW', 'user', 'https://alrajhost.com/public/images/users/20240914-042204.jpg', '99092343458', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:11', NULL),
(9, '9 إسم المتسخدم ', 'user', 'Jfmy4HKYAM@fakeemail.com', 0, 0, 0, NULL, '$2y$12$2u4gRSDMlyZlTfj6kE29o.tTayLXOKClbZo3/i7g9bwTHaNH8QNPe', 'user', 'https://alrajhost.com/public/images/users/20240914-090725.jpg', '99092343459', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:12', NULL),
(10, '10 إسم المتسخدم ', 'user', 'wVr1vjoNtU@fakeemail.com', 0, 0, 0, NULL, '$2y$12$gpOA0txoChh3GSwIv4EQFuUp2tWF1eaVfrzLBnllf/ggRfB/xvMiu', 'user', 'https://alrajhost.com/public/images/users/20240915040212.jpg', '990923434510', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:12', NULL),
(11, '11 إسم المتسخدم ', 'user', 'I0RHfdeN5m@fakeemail.com', 0, 0, 0, NULL, '$2y$12$VAhz28EyEzLb339a.cnt7.Erj0bVP4wZW1WfH.Y6.U90V6wlPmB02', 'user', 'https://alrajhost.com/public/images/users/20240916040845.jpg', '990923434511', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:12', NULL),
(12, '12 إسم المتسخدم ', 'user', 'q4E5RBCg8C@fakeemail.com', 0, 0, 0, NULL, '$2y$12$PhMDNQGkWtfw451u5WyikuT3wVIBodTQQH3novGt.hYw1QF5.hDAa', 'user', 'https://alrajhost.com/public/images/users/20240915040212.jpg', '990923434512', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:12', NULL),
(13, '13 إسم المتسخدم ', 'user', 'BktNw2Z9Bj@fakeemail.com', 0, 0, 0, NULL, '$2y$12$XLxwMa1Af9dL/OfHiQJ17OGjk02ZqIkDcm98SvTbBjCOW3.8K4Bte', 'user', 'https://alrajhost.com/public/images/users/20240908-043704.jpg', '990923434513', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:12', NULL),
(14, '14 إسم المتسخدم ', 'user', '6lGT7M2hSm@fakeemail.com', 0, 0, 0, NULL, '$2y$12$ifaUtBSho8mDkQOd8/tZNOVJ6Vt8hZAU/OLPv0c7gdqG7oa1mToku', 'user', 'https://alrajhost.com/public/images/users/20240914-042204.jpg', '990923434514', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:13', NULL),
(15, '15 إسم المتسخدم ', 'user', '9pFs8IwHlI@fakeemail.com', 0, 0, 0, NULL, '$2y$12$uiQKsxrkRxgBhSyKTY9eh.M9PDbARboAMqm/nMtA.Srh8rCgEDpJ6', 'user', 'https://alrajhost.com/public/images/users/20240916052835.jpg', '990923434515', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:13', NULL),
(16, '16 إسم المتسخدم ', 'user', '3ChOlll6Tg@fakeemail.com', 0, 0, 0, NULL, '$2y$12$XPfDtfO8O18Q68aF01Xj2ufwcwXUtzHXQIZ9hyy.kGMAQFJUSNXM2', 'user', 'https://alrajhost.com/public/images/users/20240914-085029.jpg', '990923434516', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:13', NULL),
(17, '17 إسم المتسخدم ', 'user', 'SNgyXTEeLE@fakeemail.com', 0, 0, 0, NULL, '$2y$12$TURamR8wFdxyM7Lm.cJCB.QikVJUKl90l7T6vDdB/2ES2L8HktRiy', 'user', 'https://alrajhost.com/public/images/users/20240914-090725.jpg', '990923434517', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:13', NULL),
(18, '18 إسم المتسخدم ', 'user', 'JGbm1I5y7F@fakeemail.com', 0, 0, 0, NULL, '$2y$12$Noj4t9iFNMmCBah70LSC3ehlJtG.gtV28pbXz0voXE0WaZsUO1nzW', 'user', 'https://alrajhost.com/public/images/users/avatar-8.jpg', '990923434518', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:13', NULL),
(19, '19 إسم المتسخدم ', 'user', 'X6Jyl2snEb@fakeemail.com', 0, 0, 0, NULL, '$2y$12$e54ySevYTR.Qsh24FfDeueXqUFmU8KAb2sEf/q9QIpQOY35D7qbiu', 'user', 'https://alrajhost.com/public/images/users/20240914-090725.jpg', '990923434519', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:14', NULL),
(20, '20 إسم المتسخدم ', 'user', 'angLZRCDfd@fakeemail.com', 0, 0, 0, NULL, '$2y$12$KfFlCA8tF.UQ6/ozOYiu9.f4aV/h2W1CzkEXvwEvEwsgmeC.Fxi6W', 'user', 'https://alrajhost.com/public/images/users/20240916040845.jpg', '990923434520', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:14', NULL),
(21, '21 إسم المتسخدم ', 'user', 'pKrOujI4fZ@fakeemail.com', 0, 0, 0, NULL, '$2y$12$U0KXfHwN9Go5nE/rz4ZiOuwBeIFHoXGYrlP5MWrSKwRvRJzhiMHjO', 'user', 'https://alrajhost.com/public/images/users/20240914-090725.jpg', '990923434521', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:14', NULL),
(22, '22 إسم المتسخدم ', 'user', 'TnZaVTkH5m@fakeemail.com', 0, 0, 0, NULL, '$2y$12$qSt8Sgc4GIS7eXvMofImJ.bC1DQ96sWviQpuDbkewtCnBVYNkdS62', 'user', 'https://alrajhost.com/public/images/users/20240914-090725.jpg', '990923434522', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:14', NULL),
(23, '23 إسم المتسخدم ', 'user', 'Xv3PEiFSi4@fakeemail.com', 0, 0, 0, NULL, '$2y$12$TmQ40q466NPcnw4FCN/1L.6o7bd00Ke8/59HGTzDNirABJBlMzgaS', 'user', 'https://alrajhost.com/public/images/users/20240914-042204.jpg', '990923434523', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:14', NULL),
(24, '24 إسم المتسخدم ', 'user', 'L0YDeZIIfQ@fakeemail.com', 0, 0, 0, NULL, '$2y$12$HmmkeQDYUAqkXy6sV5r3E.iewunLTsnP/Y.lhdlcrThGg3biZG4JW', 'user', 'https://alrajhost.com/public/images/users/20240908-043704.jpg', '990923434524', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:15', NULL),
(25, '25 إسم المتسخدم ', 'user', 'PdeQvCQDmZ@fakeemail.com', 0, 0, 0, NULL, '$2y$12$FNFs18UuPXoMgyNEcQhF/uT4PogWtRdjEO/gQxs7n2UymxZjxNgnC', 'user', 'https://alrajhost.com/public/images/users/20240915040212.jpg', '990923434525', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:15', NULL),
(26, '26 إسم المتسخدم ', 'user', 'ebgBK4AWeh@fakeemail.com', 0, 0, 0, NULL, '$2y$12$bvBxbBIhBJUUW8ArL1vMfOzI9V1J8eLcXyhGTu0wa9srq2fqqgLkC', 'user', 'https://alrajhost.com/public/images/users/20240916052835.jpg', '990923434526', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:15', NULL),
(27, '27 إسم المتسخدم ', 'user', 'FcrLo6csM7@fakeemail.com', 0, 0, 0, NULL, '$2y$12$2olZ2Kg64Eg9B5VAnvRWwuU2ZeOHvhdcIpPgKN6pqQOZq3QtGcEGy', 'user', 'https://alrajhost.com/public/images/users/20240915040212.jpg', '990923434527', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:15', NULL),
(28, '28 إسم المتسخدم ', 'user', 'Z6e54ncBNR@fakeemail.com', 0, 0, 0, NULL, '$2y$12$vJGKAG8/NPL/g35fFdXdjeO8hXcla9GxCiKJXK6igEpXJYVl3IIi.', 'user', 'https://alrajhost.com/public/images/users/20240914-042204.jpg', '990923434528', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:15', NULL),
(29, '29 إسم المتسخدم ', 'user', 'kWg0zfMYdA@fakeemail.com', 0, 0, 0, NULL, '$2y$12$v5dSqWSih5hxLzhyIFQO8uocUxVtLVGOZDXuj3UysNCCqJXzsvFEm', 'user', 'https://alrajhost.com/public/images/users/20240915040212.jpg', '990923434529', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:15', NULL),
(30, '30 إسم المتسخدم ', 'user', 'l5gzutHtSA@fakeemail.com', 0, 0, 0, NULL, '$2y$12$4PzRgE0P0GcS3iuqalKTzeetkV8mxpW76CcgC.4YnGK48bd1c3sam', 'user', 'https://alrajhost.com/public/images/users/20240908-043704.jpg', '990923434530', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:16', NULL),
(31, '31 إسم المتسخدم ', 'user', 'Tre5hPwRiL@fakeemail.com', 0, 0, 0, NULL, '$2y$12$dVeYnN6FZx6gRrdN9iXm0ecJhj22geZMvaNd2.GujIK9ZJ5LNluFq', 'user', 'https://alrajhost.com/public/images/users/20240914-085029.jpg', '990923434531', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:16', NULL),
(32, '32 إسم المتسخدم ', 'user', 'HGcDZ63oLH@fakeemail.com', 0, 0, 0, NULL, '$2y$12$z1XCCyPxMF4QL8yg7lrkueSP/6tl905NHPJGTM/x6NCBU8HmT.Ywa', 'user', 'https://alrajhost.com/public/images/users/20240914-042204.jpg', '990923434532', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:16', NULL),
(33, '33 إسم المتسخدم ', 'user', 'fGkDtRQxmK@fakeemail.com', 0, 0, 0, NULL, '$2y$12$C36wGonJkZyd/klyZC3O2eufswbMgVM2.IQ1vXu1hGvNbgOdtwafK', 'user', 'https://alrajhost.com/public/images/users/20240914-090725.jpg', '990923434533', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:16', NULL),
(34, '34 إسم المتسخدم ', 'user', 'ZgTNIQW4h2@fakeemail.com', 0, 0, 0, NULL, '$2y$12$ww3s8nI3OTt0QSiT6gAGTOdMg61o4ifRo/db7N2ZaxTIyW63g7zoO', 'user', 'https://alrajhost.com/public/images/users/20240914-085029.jpg', '990923434534', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:16', NULL),
(35, '35 إسم المتسخدم ', 'user', 'hxy5CZeiXN@fakeemail.com', 0, 0, 0, NULL, '$2y$12$3Rd63OtgCVICe/47ieXzY.3Iwgta7gtJ77zDIvuymT9nuy1r/IRoi', 'user', 'https://alrajhost.com/public/images/users/20240914-085029.jpg', '990923434535', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:17', NULL),
(36, '36 إسم المتسخدم ', 'user', 'Gt1pUxKynK@fakeemail.com', 0, 0, 0, NULL, '$2y$12$Ppdigcu9UfCrC/EUw9ThoOX6ndl6lX/s15UUXFiauEPfb7BzZz0W.', 'user', 'https://alrajhost.com/public/images/users/20240908-043704.jpg', '990923434536', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:17', NULL),
(37, '37 إسم المتسخدم ', 'user', 'VgExqZITPm@fakeemail.com', 0, 0, 0, NULL, '$2y$12$LbCjp2YkX8wRKez4/wQ6oe6iCPmlEHZ7RorfQw3H8fpK5fGN3Shhi', 'user', 'https://alrajhost.com/public/images/users/avatar-8.jpg', '990923434537', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:17', NULL),
(38, '38 إسم المتسخدم ', 'user', 'YVUWom3AQo@fakeemail.com', 0, 0, 0, NULL, '$2y$12$KgIMffFThFn3TNxRuNYM/eppVtKmuyeApMIKyT6VxPK/umuJwC.mq', 'user', 'https://alrajhost.com/public/images/users/20240914-085029.jpg', '990923434538', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:17', NULL),
(39, '39 إسم المتسخدم ', 'user', 'pVhNRIfuzz@fakeemail.com', 0, 0, 0, NULL, '$2y$12$hnJTWWz2jAnCyGuOsCHYCuTj2f1p1V4Grw0j/J2Ypwtej87oD8uqi', 'user', 'https://alrajhost.com/public/images/users/20240914-090725.jpg', '990923434539', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:17', NULL),
(40, '40 إسم المتسخدم ', 'user', 'VT8Ynol29N@fakeemail.com', 0, 0, 0, NULL, '$2y$12$UWwuskiBHLMCwB85CW/7zuigmcaOfXr5Qaa9U.29UsBNbLY/PyCXq', 'user', 'https://alrajhost.com/public/images/users/20240914-090725.jpg', '990923434540', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:18', NULL),
(41, '41 إسم المتسخدم ', 'user', 'r4bRyXBToR@fakeemail.com', 0, 0, 0, NULL, '$2y$12$1iWmpq8P0rVQTnSABa1JcOWwKzzjxYVkx1hXOamfRrCIFaaVGZvPS', 'user', 'https://alrajhost.com/public/images/users/20240914-085029.jpg', '990923434541', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:18', NULL),
(42, '42 إسم المتسخدم ', 'user', 'y5EsoeuOf8@fakeemail.com', 0, 0, 0, NULL, '$2y$12$K3sH0.sPUuOc75WOb8Yv0uuVNaNxeMixviVPRd18MEsyZc.b2SYqm', 'user', 'https://alrajhost.com/public/images/users/20240914-085029.jpg', '990923434542', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:18', NULL),
(43, '43 إسم المتسخدم ', 'user', '4sPlbDKK9U@fakeemail.com', 0, 0, 0, NULL, '$2y$12$7MUhU/7Tx14dDE0z7MJkLuSLZEuDLFlMtECeyxkHiXXnSVZH6xmwa', 'user', 'https://alrajhost.com/public/images/users/20240914-042204.jpg', '990923434543', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:18', NULL),
(44, '44 إسم المتسخدم ', 'user', '9hnEbMsOCr@fakeemail.com', 0, 0, 0, NULL, '$2y$12$E6u.YsgsbTEw3a65inGfAu2Mk4E4Otigjh4taSDaWE7DtY/bkCOgq', 'user', 'https://alrajhost.com/public/images/users/20240914-042204.jpg', '990923434544', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:18', NULL),
(45, '45 إسم المتسخدم ', 'user', 'XAyppJos5v@fakeemail.com', 0, 0, 0, NULL, '$2y$12$EOULbzKwH1gKTv2dDNlVWebpBBdu9XZI/MAdk5amSl2YGka12oeAi', 'user', 'https://alrajhost.com/public/images/users/20240916040845.jpg', '990923434545', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:19', NULL),
(46, '46 إسم المتسخدم ', 'user', 'gh2S3wvqSn@fakeemail.com', 0, 0, 0, NULL, '$2y$12$cqFypUQyCn2jNrlU3MLcxOztQAY3Qh7Of/bxbZB5pIaJUrC1xAY76', 'user', 'https://alrajhost.com/public/images/users/20240914-085029.jpg', '990923434546', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:19', NULL),
(47, '47 إسم المتسخدم ', 'user', 'RnNEZkbky8@fakeemail.com', 0, 0, 0, NULL, '$2y$12$UIn3CPf4zmxUppsPYEHh7us2lPlxFixRPAH01Hf9HfagcUOVvy3Ta', 'user', 'https://alrajhost.com/public/images/users/20240915040212.jpg', '990923434547', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:19', NULL),
(48, '48 إسم المتسخدم ', 'user', 'OtWtoSykdz@fakeemail.com', 0, 0, 0, NULL, '$2y$12$IjpK0mzCWKzoQAyIAT07bumL2s2b62UNK6wOv5YoyHblkw/6PX4Zu', 'user', 'https://alrajhost.com/public/images/users/20240914-085029.jpg', '990923434548', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:19', NULL),
(49, '49 إسم المتسخدم ', 'user', 'A79iMY0ki2@fakeemail.com', 0, 0, 0, NULL, '$2y$12$Tv5VLpHgqZLz5S4jncgdruleK8zJ1Odm3MGOD2CDwwrzSnqm452Lm', 'user', 'https://alrajhost.com/public/images/users/20240908-043704.jpg', '990923434549', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:19', NULL),
(50, '50 إسم المتسخدم ', 'user', 'Lq73ny1NUK@fakeemail.com', 0, 0, 0, NULL, '$2y$12$yx6/iB9nM55Ym9BsUReoqOrEweN97K82LrPUu/mg/m8i7WpSba.G6', 'user', 'https://alrajhost.com/public/images/users/20240916052835.jpg', '990923434550', '{\"address\":\"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر\",\"latitude\":31.024665651815244,\"longitude\":31.396865844726566}', NULL, '2024-09-16 06:21:20', NULL),
(62, 'rajeeh', 'user', 'Alrajehhassan7@gmail.com', 0, 0, 0, NULL, '$2y$12$EKT0EvBiypHzrGYQOtHRIuyMuRnf.erALrumTUE6d676nbMJpkiEa', 'user', NULL, '9660582983104', '\"\"', NULL, '2024-09-18 01:48:17', '2024-09-18 02:01:40'),
(67, 'sdasdasdasdasd', 'user', 'sdasdasdasdasd@mail.com', 0, 0, 0, NULL, '$2y$12$U72n2qxCcONHGUIP5XkF6egD3luIYU3w2dLX9rMbHDHfIjuirMqki', 'Admin', NULL, '23423423443', '{\"address\":\"6, شارع محمد نصر, قريه سندبسط, الغربية, 31646, مصر\",\"latitude\":30.6965533,\"longitude\":31.2608773}', NULL, '2024-09-19 04:26:08', '2024-09-19 04:26:08');

-- --------------------------------------------------------

--
-- Table structure for table `vendors`
--

CREATE TABLE `vendors` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `api_token` varchar(80) DEFAULT NULL,
  `balance` int(11) NOT NULL DEFAULT 0,
  `account_type` varchar(255) NOT NULL DEFAULT 'vendor',
  `is_available` tinyint(1) NOT NULL DEFAULT 0,
  `number_of_orders` int(11) NOT NULL DEFAULT 0,
  `gender` varchar(255) NOT NULL,
  `job` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `skills_experiences` varchar(255) DEFAULT NULL,
  `image_bank` longtext DEFAULT NULL,
  `About` varchar(255) DEFAULT NULL,
  `rating` decimal(8,2) DEFAULT 0.00,
  `start_price` decimal(8,2) DEFAULT NULL,
  `end_price` decimal(8,2) DEFAULT NULL,
  `coast` decimal(8,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vendors`
--

INSERT INTO `vendors` (`id`, `name`, `email`, `password`, `api_token`, `balance`, `account_type`, `is_available`, `number_of_orders`, `gender`, `job`, `phone_number`, `location`, `image`, `skills_experiences`, `image_bank`, `About`, `rating`, `start_price`, `end_price`, `coast`, `created_at`, `updated_at`) VALUES
(2, '2 إٍسم التاجر  ', '9zClgLWp@fake.com', '$2y$12$/Eje6WRI5yTqPy./GROTkuPWF7RT37G0hwmCq7XYkf2wI/Ze4fmLi', NULL, 0, 'vendor', 0, 0, 'female', 'fake-job', '2001092343452', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/avatar.png', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, '2024-09-20 15:23:50'),
(3, '3 إٍسم التاجر  ', '0WVbXOII@fake.com', '$2y$12$kzxnJ1ETYrMbXRssJvfr5OgHImLb4TF8BW8iX4E5wZ4O/99RLWWb2', NULL, 0, 'vendor', 0, 0, 'male', 'fake-job', '2001092343453', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240916-055144.jpg', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(4, '4 إٍسم التاجر  ', 'BI3oKKFh@fake.com', '$2y$12$EG1ofQpP8nQWaVNbZ.MoredYJjmbqHrjXQMzoZOccOvrWh40FMEcO', NULL, 0, 'vendor', 0, 0, 'female', 'fake-job', '2001092343454', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/avatar.png', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, '2024-09-20 15:19:34'),
(5, '5 إٍسم التاجر  ', 'aekMw6j3@fake.com', '$2y$12$G90nd1qmPUFSJQ4.VELi0.uTgaMvHD3egAua3i.6vrTu3Y.Pq6MsW', NULL, 823, 'vendor', 0, 2, 'female', 'fake-job', '01092343455', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240916-055655.png', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, '2024-09-18 01:58:09'),
(6, '6 إٍسم التاجر  ', 'bB1UvIMT@fake.com', '$2y$12$wqiwfufkDury4Z8xWEnX.e8N3Q804c82yheY.w0qjJA3W8r9m1fp.', NULL, 0, 'vendor', 0, 0, 'male', 'fake-job', '01092343456', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240916-055655.png', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(7, '7 إٍسم التاجر  ', 'BYD2RhhC@fake.com', '$2y$12$LTrIK2/QBU73MqPfO.TAHutvRyBkXNKDqvTqQD4FeayZWrgilQsfq', NULL, 0, 'vendor', 0, 0, 'male', 'fake-job', '01092343457', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240908-043704.jpg', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(8, '8 إٍسم التاجر  ', 'tDJ8l3m5@fake.com', '$2y$12$EVZs/GU0gM9YmnJQwg.0j.8vI2PKdsDXT/j0D3KfulRUmOlWWQ2A6', NULL, 400, 'vendor', 0, 1, 'male', 'fake-job', '01092343458', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/avatar.png', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, '2024-09-16 22:13:31'),
(9, '9 إٍسم التاجر  ', 'A0YZQtqO@fake.com', '$2y$12$4olqG43jNdFjwLsRsl1t3umanL.NabV9fN7HjkMRjKYoxIT3iQ.Am', NULL, 844, 'vendor', 0, 2, 'female', 'fake-job', '01092343459', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240916-055144.jpg', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, '2024-09-16 22:30:32'),
(10, '10 إٍسم التاجر  ', 'KR55BH0p@fake.com', '$2y$12$xBR/u/qQOPedmrEJxqYVe.v7c5StkBRR03WsAPF6XwdGf4hDzOngu', NULL, 0, 'vendor', 0, 0, 'male', 'fake-job', '010923434510', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240908-043704.jpg', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(11, '11 إٍسم التاجر  ', 'VzsGLn25@fake.com', '$2y$12$Csbi1eqP8zQvST4rGUPyEOS28Uuo6JK8zqvZM7MXcUHZYRxX2Mq8e', NULL, 0, 'vendor', 0, 0, 'female', 'fake-job', '010923434511', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240916-055655.png', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(12, '12 إٍسم التاجر  ', 'sdBHRHI7@fake.com', '$2y$12$ep/s0/8ULYGDLarUL/e3DuVt5KG6KQQPwEGkDeNOzPEshe06MQE0y', NULL, 0, 'vendor', 0, 0, 'male', 'fake-job', '20010923434512', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/avatar.png', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, '2024-09-16 17:00:43'),
(13, '13 إٍسم التاجر  ', 'Aao6pWQu@fake.com', '$2y$12$9lEOzX1UdOHpVBFh.MSmlOMYCHUsp9Xf3CupFpoSUsI8PxQvLQDcG', NULL, 0, 'vendor', 0, 0, 'female', 'fake-job', '010923434513', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240916-055144.jpg', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(14, '14 إٍسم التاجر  ', 'Ts272IXT@fake.com', '$2y$12$T9qhDeRgnAqf6LIGSwhQ9e9cQLs/gBNAQ572Opz38TIP9kg28zv6W', NULL, 0, 'vendor', 0, 0, 'female', 'fake-job', '010923434514', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240916-055655.png', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(15, '15 إٍسم التاجر  ', 'rB9lXxXK@fake.com', '$2y$12$nghni9u1t34DbKkdsH8JPetW85dBTo7cPbwFLQbBm19MTKz5z8j2a', NULL, 0, 'vendor', 0, 0, 'female', 'fake-job', '010923434515', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240916-055655.png', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(16, '16 إٍسم التاجر  ', 'y9oXXgu1@fake.com', '$2y$12$sWv9j/mTg3S3GHGWqp6sju0mLBeWxQMGNy/uB9Ew.yG6pltkBwuO.', NULL, 0, 'vendor', 0, 0, 'male', 'fake-job', '010923434516', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240916-055144.jpg', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(17, '17 إٍسم التاجر  ', 'rnnwuwCE@fake.com', '$2y$12$d/bwoCpkIhC4oJmi6rh9Ne1OQ8MO0xq7hf.dQdYX9tpPQCQ3QXTYC', NULL, 0, 'vendor', 0, 0, 'female', 'fake-job', '010923434517', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240916-055655.png', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(18, '18 إٍسم التاجر  ', '0ffbimad@fake.com', '$2y$12$XQt0KKxiAS5OB007WZ10JuGVLQJq24mjO08JuAl3nVYnQjwu3b3LC', NULL, 0, 'vendor', 0, 0, 'female', 'fake-job', '010923434518', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240908-043704.jpg', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(19, '19 إٍسم التاجر  ', '7cXeWc92@fake.com', '$2y$12$3PG.s2DhWfAyAfQDT9IyQOI0GCbsUIxac1ZigUZWysY1aO1sN7Boq', NULL, 0, 'vendor', 0, 0, 'male', 'fake-job', '010923434519', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/avatar.png', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(20, '20 إٍسم التاجر  ', 'QU7aVXFm@fake.com', '$2y$12$brGszkqEWC/pu6OOGU548uNXnAg6eGnc35HGnry2rOxlr6GNMQbIC', NULL, 0, 'vendor', 0, 0, 'male', 'fake-job', '010923434520', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240908-043704.jpg', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(21, '21 إٍسم التاجر  ', 'o4wI1Ry8@fake.com', '$2y$12$WUsNNVzeuPDO2DkaAhAKWOwUeOCVLIcSFMmQIIwC3aERnxV/.VWUC', NULL, 0, 'vendor', 0, 0, 'female', 'fake-job', '010923434521', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240916-055144.jpg', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(22, '22 إٍسم التاجر  ', 'x7l6ZF6t@fake.com', '$2y$12$KcvpjvjaKn/5/k.Qu9/rm.OuS8ki4Knu3fOA8UBuKhgFazZ7QA9A2', NULL, 0, 'vendor', 0, 0, 'male', 'fake-job', '010923434522', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240908-043704.jpg', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(23, '23 إٍسم التاجر  ', 'f1Hw8Flr@fake.com', '$2y$12$gU8cJ7Dhr6cWPchWyctpEefvMg3wQVlwSfs7F9Orj84lGDnRsOdBO', NULL, 0, 'vendor', 0, 0, 'female', 'fake-job', '010923434523', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240916-055655.png', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(24, '24 إٍسم التاجر  ', '3AQpMhee@fake.com', '$2y$12$dP3wy/fpOwqOddXnyN3nU.qDJDJu3CxUrX/CuN9c6Mf7aBsMHnvxC', NULL, 0, 'vendor', 0, 0, 'female', 'fake-job', '010923434524', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240908-043704.jpg', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(25, '25 إٍسم التاجر  ', 'SfSofirO@fake.com', '$2y$12$4sO6qu2CbMqT8Aby9PpsWuFfUqK7isIcQBf2lpMsCbS4IeFiVZy/S', NULL, 400, 'vendor', 0, 1, 'male', 'fake-job', '010923434525', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240916-055144.jpg', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, '2024-09-16 22:25:16'),
(26, '26 إٍسم التاجر  ', 'yIKC7KL3@fake.com', '$2y$12$M2jUlNCKwh60LcclVXgWIudV5ZSaxpkVPGsHLPMXL9MQpsyzSRh12', NULL, 0, 'vendor', 0, 0, 'male', 'fake-job', '010923434526', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240916-055144.jpg', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(27, '27 إٍسم التاجر  ', '3tSSf0Al@fake.com', '$2y$12$kN1nqyrBFMK2z2vvpNnpVeMgfIqOk91BCLpXmcPaMbDD7jeDT94Du', NULL, 0, 'vendor', 0, 0, 'male', 'fake-job', '010923434527', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240916-055655.png', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(28, '28 إٍسم التاجر  ', 'L5WHQdaN@fake.com', '$2y$12$GiQPiLslfhOq3T3WjY2LS.JTPP0vq2CogOIAqVCpNWgyncdZxWU2m', NULL, 423, 'vendor', 0, 1, 'male', 'fake-job', '010923434528', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240908-043704.jpg', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, '2024-09-18 01:58:09'),
(29, '29 إٍسم التاجر  ', 'vfcx7C0C@fake.com', '$2y$12$XxTPu.PZ28Q.4e6tbm53vuAa9ISzekJ743hCZzDbQQY7uB2PGk3cC', NULL, 0, 'vendor', 0, 0, 'female', 'fake-job', '010923434529', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240916-055144.jpg', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(30, '30 إٍسم التاجر  ', '6XZKsT3U@fake.com', '$2y$12$25PtGF9whOW7Lf/fgmIW7OAGgVdtslzCuLnweVu5L8e6u25h/x8yO', NULL, 1200, 'vendor', 0, 3, 'female', 'fake-job', '010923434530', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240916-055655.png', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, '2024-09-16 22:10:37'),
(31, '31 إٍسم التاجر  ', 'b6aseffK@fake.com', '$2y$12$rjScnARPigS4wcVqOcMgpOaCcO4fdoMKVKbB64m/1OSCRI2RkSZSC', NULL, 0, 'vendor', 0, 0, 'male', 'fake-job', '010923434531', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/avatar.png', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(32, '32 إٍسم التاجر  ', 'pz8XyNC7@fake.com', '$2y$12$J2sNS2M0ISUNnGOiQVTzyecMkKzFarJNY.FynYC3V3mzSlX8B5Ida', NULL, 0, 'vendor', 0, 0, 'male', 'fake-job', '010923434532', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240916-055144.jpg', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(33, '33 إٍسم التاجر  ', 'BfPqbdft@fake.com', '$2y$12$mtR3m2l666zgYvspoG0R..9Y6.UPQwHNN9RZS71jf5TfAJep/zI6y', NULL, 0, 'vendor', 0, 0, 'male', 'fake-job', '010923434533', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240916-055655.png', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(34, '34 إٍسم التاجر  ', '9kM7oFJu@fake.com', '$2y$12$PEWG7RngXDn8slaHASjVMeyE/kCsMrCk1Gz3OzpLFEEpCHv3r5/jy', NULL, 1200, 'vendor', 0, 3, 'female', 'fake-job', '010923434534', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/avatar.png', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, '2024-09-16 22:35:30'),
(35, '35 إٍسم التاجر  ', 'XtNVrwOz@fake.com', '$2y$12$pFo1v/ioGxoIPMoDtc2vp.PFogE9.SpA0.iGub5nHrxQfS4xjDS7.', NULL, 0, 'vendor', 0, 0, 'male', 'fake-job', '010923434535', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240916-055144.jpg', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(36, '36 إٍسم التاجر  ', '7WrcQN1V@fake.com', '$2y$12$.1T3CcPMIMLaaVlBhNwF3uNqWKYNKwzRybvQ/yMrXLqW9WufbNvla', NULL, 0, 'vendor', 0, 0, 'male', 'fake-job', '010923434536', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240908-043704.jpg', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(37, '37 إٍسم التاجر  ', 'jW0nU0eN@fake.com', '$2y$12$rVKqne2KVe7Sk2Nj70N3BOaFYw8IUvlD4Sogr6sUsKI3rota/Dy0q', NULL, 0, 'vendor', 0, 0, 'female', 'fake-job', '010923434537', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240908-043704.jpg', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(38, '38 إٍسم التاجر  ', 'hzi0SsNf@fake.com', '$2y$12$QfQFS9ih03rDcv.3JkpfJu.81CuGjjTvEoeN6WPMPESsIrMa90JKu', NULL, 0, 'vendor', 0, 0, 'male', 'fake-job', '010923434538', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240908-043704.jpg', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(39, '39 إٍسم التاجر  ', '2F8Dixmb@fake.com', '$2y$12$Hdl2.EdWanZG1LQ.zG4lOu3wh8mZLjfIYs/dODr9LpW8QyggCRpUW', NULL, 0, 'vendor', 0, 0, 'female', 'fake-job', '010923434539', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/avatar.png', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(40, '40 إٍسم التاجر  ', 'TugCREap@fake.com', '$2y$12$zyyTl8gwCvx.RbSWvbwiE.hlElj9.nCE7Zyaea7k.P/a9egQGlr5a', NULL, 0, 'vendor', 0, 0, 'female', 'fake-job', '010923434540', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/avatar.png', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(41, '41 إٍسم التاجر  ', 'kcwXRftf@fake.com', '$2y$12$iJ5d.McjEk/tqZf8.Exgxu.VOS/wTrhV7dAz7y.KuAHDEDCWjjyZi', NULL, 0, 'vendor', 0, 0, 'female', 'fake-job', '010923434541', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/avatar.png', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(42, '42 إٍسم التاجر  ', 'SrJVSKaa@fake.com', '$2y$12$weFyRlgiMTjJmsO6PW64yOvYh4e/KBWY/SX5N1WBePYuMKimntSC.', NULL, 0, 'vendor', 0, 0, 'female', 'fake-job', '010923434542', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240916-055144.jpg', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(43, '43 إٍسم التاجر  ', 'KsxcLimx@fake.com', '$2y$12$1I7RLYE/FDB6kcyDFT2YTecdLGpW4TG5IgANcHaU3phvOiZhtCqee', NULL, 0, 'vendor', 0, 0, 'female', 'fake-job', '010923434543', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240916-055144.jpg', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(44, '44 إٍسم التاجر  ', 'FERj1wWF@fake.com', '$2y$12$Q4rj.raBAOgGzOeCWvOoxeeNKi4g2jl30GPhAP/Tfo8hPnIIfhm9K', NULL, 0, 'vendor', 0, 0, 'female', 'fake-job', '010923434544', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240916-055655.png', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(45, '45 إٍسم التاجر  ', 'R6mSn9PO@fake.com', '$2y$12$zukfpc8GVsCAjl9Xg5tYiearENRmNlBYacsUA7kfkVq/qxl2qUl4S', NULL, 0, 'vendor', 0, 0, 'male', 'fake-job', '010923434545', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/avatar.png', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(46, '46 إٍسم التاجر  ', 'aj7Y9E7D@fake.com', '$2y$12$K.aZzYS1u3fk2lowkKkkD.IHrvk4gq/3etvGJeM.eHq3VbE/5ZpWe', NULL, 0, 'vendor', 0, 0, 'female', 'fake-job', '20010923434546', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240916-055655.png', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, '2024-09-17 19:27:04'),
(47, '47 إٍسم التاجر  ', '7qAPrRQs@fake.com', '$2y$12$3SgRZrdIx1Al5i8b/gKOP.xEK83zHuMFppFY7B5G5EEE/Y6G108aC', NULL, 444, 'vendor', 0, 1, 'male', 'fake-job', '010923434547', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240916-055144.jpg', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, '2024-09-16 22:04:02'),
(48, '48 إٍسم التاجر  ', 'sneArbeR@fake.com', '$2y$12$OMu.Qtom02L00w7IbOqfEOnhx2NdTwZr4uET2.l9MOpVsQpgnCgWG', NULL, 0, 'vendor', 0, 0, 'female', 'fake-job', '010923434548', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240908-043704.jpg', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(49, '49 إٍسم التاجر  ', 'omHvgvJB@fake.com', '$2y$12$LwPg3zxrGKueACmQPVuOYOgiM5JiFDf8MCYhNYrl/NtknW.XvaF4W', NULL, 0, 'vendor', 0, 0, 'male', 'fake-job', '010923434549', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/20240908-043704.jpg', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(50, '50 إٍسم التاجر  ', 'WWYXNefY@fake.com', '$2y$12$02A7E6Lk71vVdXnx.MvO4ehBYAacbMY2lNPhfqkePw0hUXYit9rEe', NULL, 0, 'vendor', 0, 0, 'female', 'fake-job', '010923434550', '{\"address\":\"مصطفى الاجرودى, الغربية, 31953, مصر\",\"latitude\":30.9696706,\"longitude\":31.168083}', 'https://alrajhost.com/public/images/vendors/avatar.png', NULL, NULL, NULL, 3.20, 200.00, 500.00, NULL, NULL, NULL),
(51, 'bvbnbnvn', 'ahemdsgghehata9889@gmail.com', '$2y$12$IqBn/G5kGryMKDp.maREBu7zydPgKsZxSWd.Un..GySfe62x8yi7K', NULL, 0, 'vendor', 0, 0, 'female', 'سواق - 2', '2067576576767', '{\"address\":\"6, شارع محمد نصر, قريه سندبسط, الغربية, 31646, مصر\",\"latitude\":30.6965559,\"longitude\":31.2608815}', NULL, 'املك الكثير من الخبرات والمهارات', 'https://alrajhost.com/public/images/bank/20240917-225746.png', NULL, NULL, NULL, NULL, NULL, '2024-09-17 22:57:46', '2024-09-17 23:17:03'),
(52, 'ahmed-test', 'ahemdshehata@gmail.com', '$2y$12$KV0GaGNhG5LWFrYjJR.mMOyaoerOJe6hz20ClL8xStUymMtLPO2Bu', NULL, 0, 'vendor', 0, 0, 'female', 'سواق - 2', '2001017539419', '{\"address\":\"6, شارع محمد نصر, قريه سندبسط, الغربية, 31646, مصر\",\"latitude\":30.6965589,\"longitude\":31.2608839}', NULL, 'املك الكثير من الخبرات والمهارات', 'https://alrajhost.com/public/images/bank/20240918-151820.svg', NULL, NULL, NULL, NULL, NULL, '2024-09-18 15:18:20', '2024-09-18 15:18:20'),
(53, 'asdasdasdad', 'asdasdasdad@mail.com', '$2y$12$MiZ/mtjGCM3Ul3ylIAGO4OZr85Stmat9o0MwbcRDv0q.Qlz15I5Fq', NULL, 0, 'vendor', 0, 0, 'female', 'سواق - 2', '324234234234', '{\"address\":\"6, شارع محمد نصر, قريه سندبسط, الغربية, 31646, مصر\",\"latitude\":30.6965533,\"longitude\":31.2608773}', 'https://alrajhost.com/public/images/vendors/20240919-044621.jpg', 'املك الكثير من الخبرات والمهارات', 'https://alrajhost.com/public/images/bank/20240919-044621.png', 'ABOUT', NULL, 200.00, 303.00, NULL, '2024-09-19 04:46:21', '2024-09-19 04:46:21');

-- --------------------------------------------------------

--
-- Table structure for table `vendorservices`
--

CREATE TABLE `vendorservices` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `vendor_id` bigint(20) UNSIGNED NOT NULL,
  `message` text NOT NULL,
  `message_status` enum('pending','in_progress','resolved') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vendorservices`
--

INSERT INTO `vendorservices` (`id`, `vendor_id`, `message`, `message_status`, `created_at`, `updated_at`) VALUES
(2, 2, 'السلام عليكم إختبار', 'in_progress', '2024-09-17 19:33:35', '2024-09-20 13:47:35');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bills`
--
ALTER TABLE `bills`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bills_user_id_foreign` (`user_id`);

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
-- Indexes for table `conversations`
--
ALTER TABLE `conversations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customerserviceconversations`
--
ALTER TABLE `customerserviceconversations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customerservices`
--
ALTER TABLE `customerservices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customerservices_user_id_foreign` (`user_id`);

--
-- Indexes for table `customer_service_messages`
--
ALTER TABLE `customer_service_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customer_service_messages_customerserviceconversation_id_foreign` (`customerserviceconversation_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

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
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `messages_conversation_id_foreign` (`conversation_id`),
  ADD KEY `messages_sender_id_foreign` (`sender_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifactions`
--
ALTER TABLE `notifactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifactions_user_id_foreign` (`user_id`);

--
-- Indexes for table `notifaction_vendors`
--
ALTER TABLE `notifaction_vendors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifaction_vendors_vendor_id_foreign` (`vendor_id`);

--
-- Indexes for table `ordermoneys`
--
ALTER TABLE `ordermoneys`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ordermoneys_vendor_id_foreign` (`vendor_id`);

--
-- Indexes for table `orderoffers`
--
ALTER TABLE `orderoffers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orderoffers_order_id_foreign` (`order_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orders_servicetype_id_foreign` (`servicetype_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `phonecodes`
--
ALTER TABLE `phonecodes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `services_vendor_id_foreign` (`vendor_id`),
  ADD KEY `services_servicetype_id_foreign` (`servicetype_id`);

--
-- Indexes for table `services_types`
--
ALTER TABLE `services_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `services_types_title_unique` (`title`);

--
-- Indexes for table `service_sliders`
--
ALTER TABLE `service_sliders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `sliders`
--
ALTER TABLE `sliders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `temp_payments`
--
ALTER TABLE `temp_payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `vendors`
--
ALTER TABLE `vendors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `vendors_name_unique` (`name`),
  ADD UNIQUE KEY `vendors_email_unique` (`email`),
  ADD UNIQUE KEY `vendors_api_token_unique` (`api_token`);

--
-- Indexes for table `vendorservices`
--
ALTER TABLE `vendorservices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vendorservices_vendor_id_foreign` (`vendor_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `bills`
--
ALTER TABLE `bills`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `conversations`
--
ALTER TABLE `conversations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `customerserviceconversations`
--
ALTER TABLE `customerserviceconversations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `customerservices`
--
ALTER TABLE `customerservices`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customer_service_messages`
--
ALTER TABLE `customer_service_messages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `notifactions`
--
ALTER TABLE `notifactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `notifaction_vendors`
--
ALTER TABLE `notifaction_vendors`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `ordermoneys`
--
ALTER TABLE `ordermoneys`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orderoffers`
--
ALTER TABLE `orderoffers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `phonecodes`
--
ALTER TABLE `phonecodes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `services_types`
--
ALTER TABLE `services_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `service_sliders`
--
ALTER TABLE `service_sliders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `sliders`
--
ALTER TABLE `sliders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `temp_payments`
--
ALTER TABLE `temp_payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `vendors`
--
ALTER TABLE `vendors`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `vendorservices`
--
ALTER TABLE `vendorservices`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bills`
--
ALTER TABLE `bills`
  ADD CONSTRAINT `bills_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `customerservices`
--
ALTER TABLE `customerservices`
  ADD CONSTRAINT `customerservices_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `customer_service_messages`
--
ALTER TABLE `customer_service_messages`
  ADD CONSTRAINT `customer_service_messages_customerserviceconversation_id_foreign` FOREIGN KEY (`customerserviceconversation_id`) REFERENCES `customerserviceconversations` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_conversation_id_foreign` FOREIGN KEY (`conversation_id`) REFERENCES `conversations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `messages_sender_id_foreign` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `notifactions`
--
ALTER TABLE `notifactions`
  ADD CONSTRAINT `notifactions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `notifaction_vendors`
--
ALTER TABLE `notifaction_vendors`
  ADD CONSTRAINT `notifaction_vendors_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ordermoneys`
--
ALTER TABLE `ordermoneys`
  ADD CONSTRAINT `ordermoneys_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orderoffers`
--
ALTER TABLE `orderoffers`
  ADD CONSTRAINT `orderoffers_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_servicetype_id_foreign` FOREIGN KEY (`servicetype_id`) REFERENCES `services_types` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `services`
--
ALTER TABLE `services`
  ADD CONSTRAINT `services_servicetype_id_foreign` FOREIGN KEY (`servicetype_id`) REFERENCES `services_types` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `services_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `vendorservices`
--
ALTER TABLE `vendorservices`
  ADD CONSTRAINT `vendorservices_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
