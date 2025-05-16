-- 🛒 E-Commerce Database Design Script
-- Description: SQL schema for product management
-- Author: [Daisy Wangari / Group 248]

-- STEP 1: Create the database
CREATE DATABASE ecommerce_db;
USE ecommerce_db;

-- TABLE: brand
-- Stores data about product brands

CREATE TABLE brand (
    brand_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

-- TABLE: product_category
-- Classifies products into categories (e.g., clothing, electronics)

CREATE TABLE product_category (
    product_category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

-- TABLE: product
-- General product details

CREATE TABLE product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL,
    base_price DECIMAL(10, 2) NOT NULL,
    brand_id INT,
    product_category_id INT,
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id),
    FOREIGN KEY (product_category_id) REFERENCES product_category(product_category_id)
);

-- TABLE: product_item
-- Specific purchasable item (variant of a product)

CREATE TABLE product_item (
    product_item_id INT PRIMARY KEY AUTO_INCREMENT,
    sku VARCHAR(50) NOT NULL UNIQUE,
    price DECIMAL(10, 2),
    stock_quantity INT,
    product_id INT,
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- TABLE: color
-- Manages color options for products

CREATE TABLE color (
    color_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    hex_value VARCHAR(7)  -- e.g., #FFFFFF
);

-- TABLE: size_category
-- Groups size types (e.g., clothing, shoes)

CREATE TABLE size_category (
    size_category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
);

-- TABLE: size_option
-- Specific size values (e.g., S, M, L, 42)

CREATE TABLE size_option (
    size_option_id INT PRIMARY KEY AUTO_INCREMENT,
    value VARCHAR(10),
    size_category_id INT,
    FOREIGN KEY (size_category_id) REFERENCES size_category(size_category_id)
);

-- TABLE: product_variation
-- Links a product_item to size and color

CREATE TABLE product_variation (
    product_item_id INT,
    color_id INT,
    size_option_id INT,
    PRIMARY KEY (product_item_id, color_id, size_option_id),
    FOREIGN KEY (product_item_id) REFERENCES product_item(product_item_id),
    FOREIGN KEY (color_id) REFERENCES color(color_id),
    FOREIGN KEY (size_option_id) REFERENCES size_option(size_option_id)
);

-- TABLE: product_image
-- Stores URLs or references to product images

CREATE TABLE product_image (
    image_id INT PRIMARY KEY AUTO_INCREMENT,
    image_url TEXT,
    is_primary BOOLEAN DEFAULT FALSE,
    product_item_id INT,
    FOREIGN KEY (product_item_id) REFERENCES product_item(product_item_id)
);

-- TABLE: attribute_category
-- Groups attributes into categories (e.g., physical, technical)

CREATE TABLE attribute_category (
    attribute_category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

-- TABLE: attribute_type
-- Defines types of attribute values (e.g., text, number, boolean)

CREATE TABLE attribute_type (
    attribute_type_id INT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(50)
);

-- TABLE: product_attribute
-- Stores custom product attributes

CREATE TABLE product_attribute (
    product_attribute_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    value TEXT,
    product_id INT,
    attribute_category_id INT,
    attribute_type_id INT,
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (attribute_category_id) REFERENCES attribute_category(attribute_category_id),
    FOREIGN KEY (attribute_type_id) REFERENCES attribute_type(attribute_type_id)
);

-- Sample Data Insertion for E-Commerce DB
-- Insert into brand
INSERT INTO brand (name, description) VALUES
('Nike', 'Sportswear and apparel brand'),
('Adidas', 'German sportswear manufacturer'),
('Apple', 'Electronics and devices'),
('Samsung', 'Electronics and appliances'),
('Sony', 'Consumer electronics'),
('Puma', 'Athletic wear'),
('LG', 'Home and electronics'),
('Reebok', 'Athletic footwear'),
('Under Armour', 'Performance apparel'),
('Dell', 'Computer hardware company');

-- Insert into product_category
INSERT INTO product_category (name, description) VALUES
('Clothing', 'Apparel items'),
('Electronics', 'Electronic gadgets and devices'),
('Shoes', 'Footwear for all ages'),
('Home Appliances', 'Kitchen and home use items'),
('Accessories', 'Add-on items'),
('Computers', 'PCs, laptops and components'),
('Fitness', 'Gym and exercise equipment'),
('Toys', 'Children play items'),
('Beauty', 'Cosmetics and skincare'),
('Books', 'Printed and digital books');

-- Insert into product
INSERT INTO product (name, base_price, brand_id, product_category_id) VALUES
('Running Shoes', 120.00, 1, 3),
('Smartphone', 999.99, 3, 2),
('Laptop', 850.50, 10, 6),
('Blender', 65.00, 7, 4),
('Wireless Headphones', 150.00, 5, 2),
('T-Shirt', 25.00, 2, 1),
('Smartwatch', 199.99, 4, 2),
('Backpack', 49.99, 6, 5),
('Gaming Console', 499.99, 5, 2),
('Yoga Mat', 30.00, 9, 7);

-- Insert into product_item
INSERT INTO product_item (sku, price, stock_quantity, product_id) VALUES
('RS1001', 120.00, 50, 1),
('SP2001', 999.99, 100, 2),
('LT3001', 850.50, 30, 3),
('BL4001', 65.00, 80, 4),
('WH5001', 150.00, 60, 5),
('TS6001', 25.00, 200, 6),
('SW7001', 199.99, 90, 7),
('BP8001', 49.99, 110, 8),
('GC9001', 499.99, 40, 9),
('YM1002', 30.00, 70, 10);

-- Insert into color
INSERT INTO color (name, hex_value) VALUES
('Red', '#FF0000'),
('Blue', '#0000FF'),
('Green', '#008000'),
('Black', '#000000'),
('White', '#FFFFFF'),
('Yellow', '#FFFF00'),
('Gray', '#808080'),
('Pink', '#FFC0CB'),
('Orange', '#FFA500'),
('Purple', '#800080');

-- Insert into size_category
INSERT INTO size_category (name) VALUES
('Clothing Sizes'),
('Shoe Sizes'),
('Appliance Sizes'),
('Tech Sizes'),
('Backpack Sizes'),
('Kids Sizes'),
('Accessory Sizes'),
('Fitness Equipment Sizes'),
('Beauty Product Sizes'),
('Book Formats');

-- Insert into size_option
INSERT INTO size_option (value, size_category_id) VALUES
('S', 1),
('M', 1),
('L', 1),
('XL', 1),
('42', 2),
('43', 2),
('Small', 3),
('Medium', 3),
('Compact', 4),
('Standard', 4);

-- Insert into product_variation
INSERT INTO product_variation (product_item_id, color_id, size_option_id) VALUES
(1, 1, 5),
(1, 2, 6),
(2, 4, 9),
(3, 5, 10),
(4, 3, 7),
(5, 4, 9),
(6, 2, 2),
(7, 6, 9),
(8, 1, 10),
(9, 5, 10);

-- Insert into product_image
INSERT INTO product_image (image_url, is_primary, product_item_id) VALUES
('http://example.com/img1.jpg', TRUE, 1),
('http://example.com/img2.jpg', TRUE, 2),
('http://example.com/img3.jpg', TRUE, 3),
('http://example.com/img4.jpg', TRUE, 4),
('http://example.com/img5.jpg', TRUE, 5),
('http://example.com/img6.jpg', TRUE, 6),
('http://example.com/img7.jpg', TRUE, 7),
('http://example.com/img8.jpg', TRUE, 8),
('http://example.com/img9.jpg', TRUE, 9),
('http://example.com/img10.jpg', TRUE, 10);

-- Insert into attribute_category
INSERT INTO attribute_category (name) VALUES
('Physical'),
('Technical'),
('Material'),
('Performance'),
('Visual'),
('Audio'),
('Connectivity'),
('Power'),
('Software'),
('Packaging');

-- Insert into attribute_type
INSERT INTO attribute_type (type_name) VALUES
('Text'),
('Number'),
('Boolean'),
('Date'),
('Enum'),
('Decimal'),
('JSON'),
('Time'),
('Range'),
('URL');

-- Insert into product_attribute
INSERT INTO product_attribute (name, value, product_id, attribute_category_id, attribute_type_id) VALUES
('Material', 'Leather', 1, 1, 1),
('Battery Life', '10', 2, 2, 2),
('Wireless', 'true', 5, 2, 3),
('Weight', '1.5', 3, 1, 2),
('Color', 'Black', 2, 5, 1),
('Fabric', 'Cotton', 6, 1, 1),
('Connectivity', 'Bluetooth', 5, 7, 1),
('Warranty', '1 year', 4, 8, 1),
('Release Date', '2023-03-15', 9, 2, 4),
('Eco Friendly', 'true', 10, 1, 3);
