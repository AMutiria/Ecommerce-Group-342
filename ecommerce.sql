CREATE DATABASE ecommerce;

USE ecommerce;

-- Create the brand table
CREATE TABLE brand (
    brand_id INT PRIMARY KEY AUTO_INCREMENT,
    brand_name VARCHAR(255) NOT NULL UNIQUE,
    logo_url VARCHAR(255),
    website_url VARCHAR(255)
);

-- Create the product_category table
CREATE TABLE product_category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(255) NOT NULL UNIQUE,
    description TEXT
);

-- Create the color table
CREATE TABLE color (
    color_id INT PRIMARY KEY AUTO_INCREMENT,
    color_name VARCHAR(50) NOT NULL UNIQUE,
    color_code VARCHAR(10)
);

-- Create the product table
CREATE TABLE product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    category_id INT,
    brand_id INT,
    product_name VARCHAR(255) NOT NULL,
    description TEXT,
    base_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES product_category(category_id),
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id)
);

-- Create the product_item table
CREATE TABLE product_item (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    sku VARCHAR(255) NOT NULL UNIQUE,
    price DECIMAL(10, 2) NOT NULL,
    quantity_in_stock INT NOT NULL DEFAULT 0,
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- Create the product_image table
CREATE TABLE product_image (
    product_image_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    image_url VARCHAR(255) NOT NULL,
    alt_text VARCHAR(255),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- Create the size_category table
CREATE TABLE size_category (
    size_category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- Create the size_option table
CREATE TABLE size_option (
    size_option_id INT PRIMARY KEY AUTO_INCREMENT,
    size_category_id INT,
    size_value VARCHAR(50) NOT NULL,
    UNIQUE (size_category_id, size_value),
    FOREIGN KEY (size_category_id) REFERENCES size_category(size_category_id)
);

-- Create the product_variation table
CREATE TABLE product_variation (
    variation_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    size_category_id INT,
    color_id INT,
    variation_name VARCHAR(255),
    UNIQUE (product_id, size_category_id, color_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (size_category_id) REFERENCES size_category(size_category_id),
    FOREIGN KEY (color_id) REFERENCES color(color_id)
);

-- Create the attribute_category table
CREATE TABLE attribute_category (
    attribute_category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- Create the attribute_type table
CREATE TABLE attribute_type (
    attribute_type_id INT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    data_type ENUM('text', 'number', 'boolean') NOT NULL DEFAULT 'text'
);

-- Create the product_attribute table
CREATE TABLE product_attribute (
    attribute_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    attribute_category_id INT,
    attribute_type_id INT,
    attribute_value VARCHAR(255),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (attribute_category_id) REFERENCES attribute_category(attribute_category_id),
    FOREIGN KEY (attribute_type_id) REFERENCES attribute_type(attribute_type_id)
);

-- Populating data into the tables
-- Populating the brand table
INSERT INTO brand (brand_name, logo_url, website_url) VALUES
('Nike', 'nike_logo.png', 'www.nike.com'),
('Adidas', 'adidas_logo.png', 'www.adidas.com'),
('Apple', 'apple_logo.png', 'www.apple.com'),
('Samsung', 'samsung_logo.png', 'www.samsung.com');

-- Populating the product_category table
INSERT INTO product_category (category_name, description) VALUES
('Clothing', 'Apparel for men, women, and children'),
('Electronics', 'Smartphones, laptops, and accessories'),
('Shoes', 'Athletic and casual footwear');

-- Populating the color table
INSERT INTO color (color_name, color_code) VALUES
('Red', '#FF0000'),
('Blue', '#0000FF'),
('Black', '#000000'),
('White', '#FFFFFF'),
('Silver', '#C0C0C0');

-- Populating the size_category table
INSERT INTO size_category (category_name, description) VALUES
('Clothing Sizes', 'Standard clothing sizes (S, M, L, XL)'),
('Shoe Sizes (US)', 'United States shoe sizes'),
('Electronics - Storage', 'Storage capacities for electronic devices');

-- Populating the size_option table
INSERT INTO size_option (size_category_id, size_value) VALUES
(1, 'S'),
(1, 'M'),
(1, 'L'),
(1, 'XL'),
(2, '7'),
(2, '8'),
(2, '9'),
(2, '10'),
(3, '128GB'),
(3, '256GB'),
(3, '512GB');

-- Populating the product table
INSERT INTO product (category_id, brand_id, product_name, description, base_price) VALUES
(1, 1, 'T-Shirt', 'Classic cotton t-shirt', 25.00),
(1, 2, 'Hoodie', 'Comfortable fleece hoodie', 55.00),
(2, 3, 'iPhone 15', 'Latest smartphone from Apple', 999.00),
(2, 4, 'Galaxy S23', 'Flagship smartphone from Samsung', 899.00),
(3, 1, 'Running Shoes', 'High-performance running shoes', 90.00),
(3, 2, 'Sneakers', 'Casual everyday sneakers', 65.00);

-- Populating the product_item table
INSERT INTO product_item (product_id, sku, price, quantity_in_stock) VALUES
(1, 'NIKE-TS-RED-M', 25.00, 50),
(1, 'NIKE-TS-BLUE-L', 25.00, 30),
(2, 'ADIDAS-HD-BLK-S', 55.00, 20),
(3, 'APPL-IP15-128-SILV', 999.00, 15),
(3, 'APPL-IP15-256-SILV', 1099.00, 10),
(4, 'SMSNG-S23-256-BLK', 899.00, 25),
(5, 'NIKE-RS-BLU-9', 90.00, 40),
(6, 'ADIDAS-SNK-WHT-8', 65.00, 60);

-- Populating the product_image table
INSERT INTO product_image (product_id, image_url, alt_text) VALUES
(1, 'images/nike_tshirt_red.jpg', 'Red Nike T-Shirt'),
(1, 'images/nike_tshirt_front.jpg', 'Front view of Nike T-Shirt'),
(2, 'images/adidas_hoodie_black.jpg', 'Black Adidas Hoodie'),
(3, 'images/iphone15_silver.jpg', 'Silver iPhone 15'),
(4, 'images/galaxys23_black.jpg', 'Black Samsung Galaxy S23'),
(5, 'images/nike_runningshoes_blue.jpg', 'Blue Nike Running Shoes'),
(6, 'images/adidas_sneakers_white.jpg', 'White Adidas Sneakers');

-- Populating the product_variation table
INSERT INTO product_variation (product_id, size_category_id, color_id, variation_name) VALUES
(1, 1, 1, 'Red M'), -- T-Shirt, Clothing Sizes, Red, Medium
(1, 1, 2, 'Blue L') -- T-Shirt, Clothing Sizes, Blue,

-- Running sample queries
SELECT p.product_name, b.brand_name, pc.category_name
FROM product p
JOIN brand b ON p.brand_id = b.brand_id
JOIN product_category pc ON p.category_id = pc.category_id;

SELECT pi.product_name, pim.image_url
FROM product pi
JOIN product_image pim ON pi.product_id = pim.product_id;

SELECT pv.variation_name, p.product_name, c.color_name, sc.category_name, so.size_value
FROM product_variation pv
JOIN product p ON pv.product_id = p.product_id
LEFT JOIN color c ON pv.color_id = c.color_id
LEFT JOIN size_category sc ON pv.size_category_id = sc.size_category_id
LEFT JOIN size_option so ON sc.size_category_id = so.size_category_id;