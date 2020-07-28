-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               5.7.24 - MySQL Community Server (GPL)
-- Операционная система:         Win64
-- HeidiSQL Версия:              9.5.0.5332
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Дамп структуры для таблица employee.assignment
CREATE TABLE IF NOT EXISTS `assignment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `position_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `rate` decimal(4,2) NOT NULL,
  `salary` int(11) NOT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx-assignment-order_id` (`order_id`),
  KEY `idx-assignment-employee_id` (`employee_id`),
  KEY `idx-assignment-position_id` (`position_id`),
  KEY `idx-assignment-active` (`active`),
  CONSTRAINT `fk-assignment-employee_id` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk-assignment-order_id` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk-assignment-position_id` FOREIGN KEY (`position_id`) REFERENCES `position` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Дамп данных таблицы employee.assignment: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `assignment` DISABLE KEYS */;
/*!40000 ALTER TABLE `assignment` ENABLE KEYS */;

-- Дамп структуры для таблица employee.bonus
CREATE TABLE IF NOT EXISTS `bonus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `cost` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx-bonus-order_id` (`order_id`),
  KEY `idx-bonus-employee_id` (`employee_id`),
  CONSTRAINT `fk-bonus-employee_id` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk-bonus-order_id` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Дамп данных таблицы employee.bonus: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `bonus` DISABLE KEYS */;
/*!40000 ALTER TABLE `bonus` ENABLE KEYS */;

-- Дамп структуры для таблица employee.contract
CREATE TABLE IF NOT EXISTS `contract` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) NOT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date_open` date NOT NULL,
  `date_close` date DEFAULT NULL,
  `close_reason` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дамп данных таблицы employee.contract: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `contract` DISABLE KEYS */;
INSERT INTO `contract` (`id`, `employee_id`, `first_name`, `last_name`, `date_open`, `date_close`, `close_reason`) VALUES
	(1, 1, 'Александр', 'Гавриленко', '2020-07-27', NULL, NULL),
	(2, 2, 'Aliaksandr', 'Gavrilenko', '2020-07-28', NULL, NULL);
/*!40000 ALTER TABLE `contract` ENABLE KEYS */;

-- Дамп структуры для таблица employee.dismiss
CREATE TABLE IF NOT EXISTS `dismiss` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `reason` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx-dismiss-order_id` (`order_id`),
  KEY `idx-dismiss-employee_id` (`employee_id`),
  CONSTRAINT `fk-dismiss-employee_id` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk-dismiss-order_id` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Дамп данных таблицы employee.dismiss: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `dismiss` DISABLE KEYS */;
/*!40000 ALTER TABLE `dismiss` ENABLE KEYS */;

-- Дамп структуры для таблица employee.employee
CREATE TABLE IF NOT EXISTS `employee` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx-employee-status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дамп данных таблицы employee.employee: ~2 rows (приблизительно)
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` (`id`, `first_name`, `last_name`, `address`, `email`, `status`) VALUES
	(1, 'Александр', 'Гавриленко', 'Гомель', 'goric0312@mail.ru', 1),
	(2, 'Aliaksandr', 'Gavrilenko', 'Гомель', 'goric031278@mail.ru', 1);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;

-- Дамп структуры для таблица employee.interview
CREATE TABLE IF NOT EXISTS `interview` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` smallint(6) NOT NULL,
  `reject_reason` text COLLATE utf8_unicode_ci,
  `employee_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx-interview-status` (`status`),
  KEY `idx-interview-employee_id` (`employee_id`),
  CONSTRAINT `fk-interview-employee_id` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дамп данных таблицы employee.interview: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `interview` DISABLE KEYS */;
INSERT INTO `interview` (`id`, `date`, `first_name`, `last_name`, `email`, `status`, `reject_reason`, `employee_id`) VALUES
	(1, '2020-07-27', 'Aliaksandr', 'Gavrilenko', 'goric03121978@mail.ru', 1, NULL, NULL);
/*!40000 ALTER TABLE `interview` ENABLE KEYS */;

-- Дамп структуры для таблица employee.log
CREATE TABLE IF NOT EXISTS `log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `message` text,
  PRIMARY KEY (`id`),
  KEY `idx-log-user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- Дамп данных таблицы employee.log: ~3 rows (приблизительно)
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
INSERT INTO `log` (`id`, `created_at`, `user_id`, `message`) VALUES
	(1, 1595855782, NULL, 'Employee 1 is recruit'),
	(2, 1595912542, NULL, 'Employee 2 is recruit'),
	(3, 1595915505, NULL, 'Gavrilenko Aliaksandr is joined to interview'),
	(4, 1595930569, NULL, 'Interview 1 is moved on 2020-07-27');
/*!40000 ALTER TABLE `log` ENABLE KEYS */;

-- Дамп структуры для таблица employee.migration
CREATE TABLE IF NOT EXISTS `migration` (
  `version` varchar(180) NOT NULL,
  `apply_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Дамп данных таблицы employee.migration: ~12 rows (приблизительно)
/*!40000 ALTER TABLE `migration` DISABLE KEYS */;
INSERT INTO `migration` (`version`, `apply_time`) VALUES
	('m000000_000000_base', 1595846853),
	('m160429_093915_create_employee', 1595846857),
	('m160429_093925_create_interview', 1595846858),
	('m160429_093932_create_contract', 1595846858),
	('m160429_093939_create_position', 1595846858),
	('m160429_093955_create_order', 1595846858),
	('m160429_094024_create_recruit', 1595846859),
	('m160429_094025_create_assignment', 1595846862),
	('m160429_094033_create_vacation', 1595846863),
	('m160429_094042_create_dismiss', 1595846864),
	('m160429_094055_create_bonus', 1595846865),
	('m160429_094155_create_log', 1595846865);
/*!40000 ALTER TABLE `migration` ENABLE KEYS */;

-- Дамп структуры для таблица employee.order
CREATE TABLE IF NOT EXISTS `order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- Дамп данных таблицы employee.order: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` (`id`, `date`) VALUES
	(1, '2020-07-27'),
	(2, '2020-07-28');
/*!40000 ALTER TABLE `order` ENABLE KEYS */;

-- Дамп структуры для таблица employee.position
CREATE TABLE IF NOT EXISTS `position` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дамп данных таблицы employee.position: ~2 rows (приблизительно)
/*!40000 ALTER TABLE `position` DISABLE KEYS */;
INSERT INTO `position` (`id`, `name`) VALUES
	(1, 'Слесарь-инструментальщик'),
	(2, 'Станочник широкого профиля');
/*!40000 ALTER TABLE `position` ENABLE KEYS */;

-- Дамп структуры для таблица employee.recruit
CREATE TABLE IF NOT EXISTS `recruit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx-recruit-order_id` (`order_id`),
  KEY `idx-recruit-employee_id` (`employee_id`),
  CONSTRAINT `fk-recruit-employee_id` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk-recruit-order_id` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- Дамп данных таблицы employee.recruit: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `recruit` DISABLE KEYS */;
INSERT INTO `recruit` (`id`, `order_id`, `employee_id`, `date`) VALUES
	(1, 1, 1, '2020-07-27'),
	(2, 2, 2, '2020-07-28');
/*!40000 ALTER TABLE `recruit` ENABLE KEYS */;

-- Дамп структуры для таблица employee.vacation
CREATE TABLE IF NOT EXISTS `vacation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `date_from` date NOT NULL,
  `date_to` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx-vacation-order_id` (`order_id`),
  KEY `idx-vacation-employee_id` (`employee_id`),
  CONSTRAINT `fk-vacation-employee_id` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk-vacation-order_id` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Дамп данных таблицы employee.vacation: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `vacation` DISABLE KEYS */;
/*!40000 ALTER TABLE `vacation` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
