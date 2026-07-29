DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES ('1', '2026_07_29_101122_create_items_table', '1');
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES ('2', '2026_07_29_101132_create_transactions_table', '1');
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES ('3', '2026_07_29_154212_create_users_table', '1');

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_username_unique` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `users` (`id`, `name`, `username`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES ('1', 'Admin User', 'admin', '$2y$12$XBHzW4ZCk6ee0YMrpDCx4O6Zt1Gm9bD0V9BVg7lOshl9nO3OtpHFS', NULL, '2026-07-29 17:41:14', '2026-07-29 17:41:14');

DROP TABLE IF EXISTS `items`;
CREATE TABLE `items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `item_code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `unit` enum('pcs','box','kg','liter','meter','roll') NOT NULL,
  `initial_stock` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `items_item_code_unique` (`item_code`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `items` (`id`, `item_code`, `name`, `unit`, `initial_stock`, `created_at`, `updated_at`) VALUES ('1', 'BRG-001', 'Lenovo', 'pcs', '100', '2026-07-29 18:32:27', '2026-07-29 18:32:27');
INSERT INTO `items` (`id`, `item_code`, `name`, `unit`, `initial_stock`, `created_at`, `updated_at`) VALUES ('2', 'BRG-002', 'Asus', 'pcs', '99', '2026-07-29 18:32:38', '2026-07-29 18:32:38');
INSERT INTO `items` (`id`, `item_code`, `name`, `unit`, `initial_stock`, `created_at`, `updated_at`) VALUES ('3', 'BRG-003', 'Axioo', 'pcs', '77', '2026-07-29 18:33:02', '2026-07-29 18:33:02');
INSERT INTO `items` (`id`, `item_code`, `name`, `unit`, `initial_stock`, `created_at`, `updated_at`) VALUES ('5', 'BRG-004', 'Heatsink', 'pcs', '1', '2026-07-29 18:38:11', '2026-07-29 18:38:11');

DROP TABLE IF EXISTS `transactions`;
CREATE TABLE `transactions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `item_id` bigint unsigned NOT NULL,
  `type` enum('in','out') NOT NULL,
  `transaction_date` date NOT NULL,
  `quantity` int NOT NULL,
  `description` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transactions_item_id_foreign` (`item_id`),
  CONSTRAINT `transactions_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `transactions` (`id`, `item_id`, `type`, `transaction_date`, `quantity`, `description`, `created_at`, `updated_at`) VALUES ('1', '1', 'in', '2026-07-29', '15', NULL, '2026-07-29 18:33:46', '2026-07-29 18:33:46');
INSERT INTO `transactions` (`id`, `item_id`, `type`, `transaction_date`, `quantity`, `description`, `created_at`, `updated_at`) VALUES ('2', '1', 'out', '2026-07-29', '14', NULL, '2026-07-29 18:34:02', '2026-07-29 18:34:02');
INSERT INTO `transactions` (`id`, `item_id`, `type`, `transaction_date`, `quantity`, `description`, `created_at`, `updated_at`) VALUES ('3', '3', 'in', '2026-07-29', '16', 'Tambah', '2026-07-29 18:37:08', '2026-07-29 18:37:08');
INSERT INTO `transactions` (`id`, `item_id`, `type`, `transaction_date`, `quantity`, `description`, `created_at`, `updated_at`) VALUES ('4', '5', 'in', '2026-07-29', '18', NULL, '2026-07-29 18:38:24', '2026-07-29 18:38:24');
INSERT INTO `transactions` (`id`, `item_id`, `type`, `transaction_date`, `quantity`, `description`, `created_at`, `updated_at`) VALUES ('5', '5', 'out', '2026-07-29', '5', NULL, '2026-07-29 18:38:33', '2026-07-29 18:38:33');

