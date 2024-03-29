CREATE TABLE `articles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `summary` text COLLATE utf8_unicode_ci,
  `content` text COLLATE utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_articles_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `brands` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `short_name` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url` varchar(120) COLLATE utf8_unicode_ci DEFAULT NULL,
  `plural_name` varchar(120) COLLATE utf8_unicode_ci DEFAULT NULL,
  `singular_name` varchar(120) COLLATE utf8_unicode_ci DEFAULT NULL,
  `category_type` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lft` mediumint(9) DEFAULT NULL,
  `rgt` mediumint(9) DEFAULT NULL,
  `parent_id` smallint(6) DEFAULT NULL,
  `depth` tinyint(4) DEFAULT NULL,
  `shop_id` int(11) DEFAULT NULL,
  `param_template_id` int(11) DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_categories_on_shop_id_and_url` (`shop_id`,`url`),
  KEY `index_categories_on_depth` (`depth`),
  KEY `index_categories_on_lft` (`lft`),
  KEY `index_categories_on_param_template_id` (`param_template_id`),
  KEY `index_categories_on_parent_id` (`parent_id`),
  KEY `index_categories_on_rgt` (`rgt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `categorizations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `preferred` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_categorizations_on_category_id_and_product_id` (`category_id`,`product_id`),
  UNIQUE KEY `index_categorizations_on_product_id_and_category_id` (`product_id`,`category_id`),
  KEY `index_categorizations_on_category_id` (`category_id`),
  KEY `index_categorizations_on_product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `category_articles` (
  `article_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  KEY `index_category_articles_on_article_id_and_category_id` (`article_id`,`category_id`),
  KEY `index_category_articles_on_category_id_and_article_id` (`category_id`,`article_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `companies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ico` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dic` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_companies_on_customer_id` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `customers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(70) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url` varchar(70) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8_unicode_ci,
  `menu_item` tinyint(1) DEFAULT '0',
  `contact_link` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_documents_on_name` (`name`),
  UNIQUE KEY `index_documents_on_url` (`url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `news_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8_unicode_ci,
  `link` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `shop_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_news_items_on_shop_id` (`shop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` smallint(6) DEFAULT NULL,
  `price` mediumint(9) DEFAULT NULL,
  `waste` smallint(6) DEFAULT NULL,
  `sent` tinyint(1) DEFAULT '0',
  `order_id` int(11) DEFAULT NULL,
  `purchasable_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_order_items_on_order_id` (`order_id`),
  KEY `index_order_items_on_purchasable_id` (`purchasable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `token` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `total` mediumint(9) DEFAULT NULL,
  `item_total` mediumint(9) DEFAULT NULL,
  `email_confirmation` tinyint(1) DEFAULT '0',
  `state` varchar(15) COLLATE utf8_unicode_ci DEFAULT 'in_progress',
  `admin_note` text COLLATE utf8_unicode_ci,
  `customer_note` text COLLATE utf8_unicode_ci,
  `customer_id` int(11) DEFAULT NULL,
  `completed_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_orders_on_number` (`number`),
  UNIQUE KEY `index_orders_on_token` (`token`),
  KEY `index_orders_on_state` (`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `package_sizes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `weight_min` smallint(6) DEFAULT NULL,
  `weight_max` smallint(6) DEFAULT NULL,
  `price` smallint(6) DEFAULT NULL,
  `shipping_method_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_package_sizes_on_shipping_method_id` (`shipping_method_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `param_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `param_template_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `position` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_param_groups_on_param_template_id_and_position` (`param_template_id`,`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `param_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(65) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value_type` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `choice_type` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `unit` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `importance` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `param_template_id` int(11) DEFAULT NULL,
  `param_group_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_param_items_on_importance` (`importance`),
  KEY `index_param_items_on_param_group_id` (`param_group_id`),
  KEY `index_param_items_on_param_template_id` (`param_template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `param_templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_param_templates_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `param_values` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `param_item_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_param_values_on_param_item_id` (`param_item_id`),
  KEY `index_param_values_on_value` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `parametrizations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) DEFAULT NULL,
  `param_item_id` int(11) DEFAULT NULL,
  `param_value_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_parametrizations_on_param_item_id` (`param_item_id`),
  KEY `index_parametrizations_on_param_value_id` (`param_value_id`),
  KEY `index_parametrizations_on_product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `payment_methods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `short_description` text COLLATE utf8_unicode_ci,
  `description` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `short_description` text COLLATE utf8_unicode_ci,
  `description` text COLLATE utf8_unicode_ci,
  `order_id` int(11) DEFAULT NULL,
  `payment_method_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_payments_on_order_id_and_payment_method_id` (`order_id`,`payment_method_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `product_photos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `main_photo` tinyint(1) DEFAULT '0',
  `position` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_product_photos_on_main_photo` (`main_photo`),
  KEY `index_product_photos_on_product_id_and_position` (`product_id`,`position`),
  KEY `index_product_photos_on_product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `product_replacements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) DEFAULT NULL,
  `replaced_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_product_replacements_on_product_id_and_replaced_by_id` (`product_id`,`replaced_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `product_supplier_ids` (
  `product_id` int(11) NOT NULL,
  `supplier` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `supplier_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `current` tinyint(1) DEFAULT '0',
  UNIQUE KEY `index_product_supplier_ids_on_supplier_id_and_supplier` (`supplier_id`,`supplier`),
  KEY `index_product_supplier_ids_on_product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(171) COLLATE utf8_unicode_ci DEFAULT NULL,
  `model_name` varchar(140) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url` varchar(171) COLLATE utf8_unicode_ci DEFAULT NULL,
  `external_id` mediumint(9) DEFAULT NULL,
  `ean_code` bigint(20) DEFAULT NULL,
  `short_description` text COLLATE utf8_unicode_ci,
  `description` text COLLATE utf8_unicode_ci,
  `default_price` mediumint(9) DEFAULT NULL,
  `recommended_price` mediumint(9) DEFAULT NULL,
  `purchase_price` mediumint(9) DEFAULT NULL,
  `recycling_fee` smallint(6) DEFAULT NULL,
  `warranty` smallint(6) DEFAULT NULL,
  `vat_rate` decimal(3,1) DEFAULT NULL,
  `state` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'new',
  `admin_comment` text COLLATE utf8_unicode_ci,
  `initial_data_source` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'manually_added',
  `gray_import` tinyint(1) DEFAULT '0',
  `top_product` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `weight` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_products_on_url` (`url`),
  KEY `index_products_on_brand_id` (`brand_id`),
  KEY `index_products_on_external_id` (`external_id`),
  KEY `index_products_on_initial_data_source` (`initial_data_source`),
  KEY `index_products_on_model_name` (`model_name`),
  KEY `index_products_on_name` (`name`),
  KEY `index_products_on_top_product` (`top_product`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `purchasables` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `goods_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_purchasables_on_goods_type_and_goods_id` (`goods_type`,`goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `purchase_prices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supplier_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `supplier` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `price` mediumint(9) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `sale_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `evidence_number` mediumint(9) NOT NULL,
  `reason_for_discount` text COLLATE utf8_unicode_ci NOT NULL,
  `current_state` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `technician_review` text COLLATE utf8_unicode_ci NOT NULL,
  `discount` mediumint(9) NOT NULL,
  `minimal_price` mediumint(9) DEFAULT NULL,
  `sold` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `shipments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `price` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `shipping_method_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_shipments_on_order_id_and_shipping_method_id` (`order_id`,`shipping_method_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `shipping_method_has_payment_methods` (
  `shipping_method_id` int(11) DEFAULT NULL,
  `payment_method_id` int(11) DEFAULT NULL,
  UNIQUE KEY `shipping_method_has_payment_methods_index` (`shipping_method_id`,`payment_method_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `shipping_methods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `short_description` text COLLATE utf8_unicode_ci,
  `description` text COLLATE utf8_unicode_ci,
  `position` tinyint(4) DEFAULT NULL,
  `caesar_type_id` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `caesar_type_name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `free_from` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `shop_documents` (
  `shop_id` int(11) DEFAULT NULL,
  `document_id` int(11) DEFAULT NULL,
  KEY `index_shop_documents_on_document_id_and_shop_id` (`document_id`,`shop_id`),
  KEY `index_shop_documents_on_shop_id_and_document_id` (`shop_id`,`document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `shop_has_payment_methods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) DEFAULT NULL,
  `payment_method_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_shop_on_shop_id_and_payment_method_id` (`shop_id`,`payment_method_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `shop_has_shipping_methods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) DEFAULT NULL,
  `shipping_method_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_shop_on_shop_id_and_shipping_method_id` (`shop_id`,`shipping_method_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `shops` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `host` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `short_name` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_shops_on_host` (`host`),
  UNIQUE KEY `index_shops_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `stock_availabilities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `supplier` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `in_stock_count` int(11) NOT NULL,
  `in_stock_description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_stock_availabilities_on_product_id` (`product_id`),
  KEY `index_stock_availabilities_on_supplier` (`supplier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `supplier_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supplier_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `product_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `record_attributes` text COLLATE utf8_unicode_ci NOT NULL,
  `supplier` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_supplier_items_on_supplier_id_and_supplier` (`supplier_id`,`supplier`),
  KEY `index_supplier_items_on_product_name` (`product_name`),
  KEY `index_supplier_items_on_supplier_id` (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO schema_migrations (version) VALUES ('20120716112101');

INSERT INTO schema_migrations (version) VALUES ('20120718130444');

INSERT INTO schema_migrations (version) VALUES ('20120719081039');

INSERT INTO schema_migrations (version) VALUES ('20120719141903');

INSERT INTO schema_migrations (version) VALUES ('20120720120559');

INSERT INTO schema_migrations (version) VALUES ('20120723145007');

INSERT INTO schema_migrations (version) VALUES ('20120723164814');

INSERT INTO schema_migrations (version) VALUES ('20120724081520');

INSERT INTO schema_migrations (version) VALUES ('20120724124323');

INSERT INTO schema_migrations (version) VALUES ('20120724124808');

INSERT INTO schema_migrations (version) VALUES ('20120724151635');

INSERT INTO schema_migrations (version) VALUES ('20120725195416');

INSERT INTO schema_migrations (version) VALUES ('20120726091940');

INSERT INTO schema_migrations (version) VALUES ('20120726150930');

INSERT INTO schema_migrations (version) VALUES ('20120726171239');

INSERT INTO schema_migrations (version) VALUES ('20120727113113');

INSERT INTO schema_migrations (version) VALUES ('20120727132422');

INSERT INTO schema_migrations (version) VALUES ('20120728193928');

INSERT INTO schema_migrations (version) VALUES ('20120729075745');

INSERT INTO schema_migrations (version) VALUES ('20120729075831');

INSERT INTO schema_migrations (version) VALUES ('20120729080255');

INSERT INTO schema_migrations (version) VALUES ('20120729081424');

INSERT INTO schema_migrations (version) VALUES ('20120729085347');

INSERT INTO schema_migrations (version) VALUES ('20120729161953');

INSERT INTO schema_migrations (version) VALUES ('20120730090944');

INSERT INTO schema_migrations (version) VALUES ('20120801163159');

INSERT INTO schema_migrations (version) VALUES ('20120801170910');

INSERT INTO schema_migrations (version) VALUES ('20120809142342');

INSERT INTO schema_migrations (version) VALUES ('20120810095210');

INSERT INTO schema_migrations (version) VALUES ('20120810141959');

INSERT INTO schema_migrations (version) VALUES ('20120813081308');

INSERT INTO schema_migrations (version) VALUES ('20120813132912');

INSERT INTO schema_migrations (version) VALUES ('20120814134504');

INSERT INTO schema_migrations (version) VALUES ('20120823082028');

INSERT INTO schema_migrations (version) VALUES ('20120823133801');

INSERT INTO schema_migrations (version) VALUES ('20120824125930');

INSERT INTO schema_migrations (version) VALUES ('20120829140555');

INSERT INTO schema_migrations (version) VALUES ('20120904114557');

INSERT INTO schema_migrations (version) VALUES ('20120904114700');

INSERT INTO schema_migrations (version) VALUES ('20120904142200');

INSERT INTO schema_migrations (version) VALUES ('20120907092545');

INSERT INTO schema_migrations (version) VALUES ('20120910145600');

INSERT INTO schema_migrations (version) VALUES ('20120910145632');

INSERT INTO schema_migrations (version) VALUES ('20120912130741');

INSERT INTO schema_migrations (version) VALUES ('20120912150923');

INSERT INTO schema_migrations (version) VALUES ('20120912151003');

INSERT INTO schema_migrations (version) VALUES ('20120912151041');

INSERT INTO schema_migrations (version) VALUES ('20120912151334');

INSERT INTO schema_migrations (version) VALUES ('20120912152734');

INSERT INTO schema_migrations (version) VALUES ('20120912152818');

INSERT INTO schema_migrations (version) VALUES ('20120913144641');

INSERT INTO schema_migrations (version) VALUES ('20120914084110');

INSERT INTO schema_migrations (version) VALUES ('20120917114242');

INSERT INTO schema_migrations (version) VALUES ('20120917114618');

INSERT INTO schema_migrations (version) VALUES ('20120919072042');

INSERT INTO schema_migrations (version) VALUES ('20120919081505');

INSERT INTO schema_migrations (version) VALUES ('20120920081206');

INSERT INTO schema_migrations (version) VALUES ('20120921085541');

INSERT INTO schema_migrations (version) VALUES ('20120921121649');