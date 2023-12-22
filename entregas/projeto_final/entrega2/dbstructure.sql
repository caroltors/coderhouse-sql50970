CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE `carrier` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `value` float DEFAULT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `customer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cpf` varchar(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `mail` varchar(45) NOT NULL,
  `created_at` timestamp(6) NOT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `customer_address` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_customer` int NOT NULL,
  `postal_code` int NOT NULL,
  `country` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_customer2_idx` (`id_customer`),
  CONSTRAINT `id_customer2` FOREIGN KEY (`id_customer`) REFERENCES `customer` (`id`)
);

CREATE TABLE `log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_type` varchar(50) NOT NULL,
  `table_name` varchar(50) NOT NULL,
  `action_datetime` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `login_customer` (
  `id_customer` int NOT NULL,
  `username` varchar(25) NOT NULL,
  `password` varchar(255) NOT NULL,
  `last_login` timestamp(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id_customer`),
  KEY `id_customer_idx` (`id_customer`),
  CONSTRAINT `id_customer` FOREIGN KEY (`id_customer`) REFERENCES `customer` (`id`)
);

CREATE TABLE `order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_customer` int NOT NULL,
  `id_pay` int NOT NULL,
  `id_status` int NOT NULL,
  `created_at` timestamp(6) NOT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_customer4_idx` (`id_customer`),
  KEY `id_pay_idx` (`id_pay`),
  KEY `id_status_idx` (`id_status`),
  CONSTRAINT `id_customer4` FOREIGN KEY (`id_customer`) REFERENCES `customer` (`id`),
  CONSTRAINT `id_pay` FOREIGN KEY (`id_pay`) REFERENCES `payment_customer` (`id`),
  CONSTRAINT `id_status` FOREIGN KEY (`id_status`) REFERENCES `order_status` (`id`)
);

CREATE TABLE `order_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_order` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_order2_idx` (`id_order`),
  CONSTRAINT `id_order2` FOREIGN KEY (`id_order`) REFERENCES `order` (`id`)
);


CREATE TABLE `order_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_order` int NOT NULL,
  `id_product` int NOT NULL,
  `amount` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_product_idx` (`id_product`),
  KEY `order_id_idx` (`id_order`),
  CONSTRAINT `id_product` FOREIGN KEY (`id_product`) REFERENCES `product` (`id`),
  CONSTRAINT `order_id` FOREIGN KEY (`id_order`) REFERENCES `order` (`id`)
);

CREATE TABLE `order_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `desc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `payment_customer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_customer` int NOT NULL,
  `pay_type` varchar(20) DEFAULT NULL,
  `card_number` varchar(20) DEFAULT NULL,
  `exp_date` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_customer3_idx` (`id_customer`),
  CONSTRAINT `id_customer3` FOREIGN KEY (`id_customer`) REFERENCES `customer` (`id`)
);

CREATE TABLE `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_category` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `desc` varchar(255) DEFAULT NULL,
  `dimensions` varchar(45) DEFAULT NULL,
  `weight` int DEFAULT NULL,
  `amount` int NOT NULL,
  `value` float NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_category_idx` (`id_category`),
  CONSTRAINT `id_category` FOREIGN KEY (`id_category`) REFERENCES `product_category` (`id`)
);

CREATE TABLE `product_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `desc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `shipping` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_order` int NOT NULL,
  `id_carrier` int NOT NULL,
  `id_address` int NOT NULL,
  `value` float NOT NULL,
  `date` timestamp(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_order_idx` (`id_order`),
  KEY `id_carrier_idx` (`id_carrier`),
  KEY `id_address_idx` (`id_address`),
  CONSTRAINT `id_address` FOREIGN KEY (`id_address`) REFERENCES `customer_address` (`id`),
  CONSTRAINT `id_carrier` FOREIGN KEY (`id_carrier`) REFERENCES `carrier` (`id`),
  CONSTRAINT `id_order` FOREIGN KEY (`id_order`) REFERENCES `order` (`id`)
);
