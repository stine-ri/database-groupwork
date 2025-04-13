-- Sample data for language table
INSERT INTO book_language (language_name) VALUES 
('English'), ('Spanish'), ('French');
-- Sample data for publisher table
INSERT INTO publisher (publisher_name) VALUES
('Penguin Random House'), ('HarperCollins'), ('Simon & Schuster');

-- Sample data for author table
INSERT INTO author (author_name, biography) VALUES
('J.K. Rowling', 'British author best known for the Harry Potter series'),
('George R.R. Martin', 'American novelist known for A Song of Ice and Fire'),
('Stephen King', 'American author of horror, supernatural fiction, suspense');

-- Sample data for book table
INSERT INTO book (title, isbn, publisher_id, language_id, num_pages, publication_date, price, stock_quantity) VALUES
('Harry Potter and the Philosopher''s Stone', '9780747532743', 1, 1, 223, '1997-06-26', 12.99, 50),
('A Game of Thrones', '9780553103540', 2, 1, 694, '1996-08-01', 15.99, 30),
('The Shining', '9780307743657', 3, 1, 447, '1977-01-28', 9.99, 25);

-- Sample data for book_author table
INSERT INTO book_author (book_id, author_id) VALUES
(1, 1), (2, 2), (3, 3);

-- Sample data for country table
INSERT INTO country (country_name, country_code) VALUES
('United States', 'US'), ('United Kingdom', 'UK'), ('France', 'FR');

-- Sample data for address_status table
INSERT INTO address_status (status_name) VALUES
('Primary'), ('Secondary'), ('Business');

-- Sample data for address table
INSERT INTO address (street_number, street_name, city, country_id, postal_code) VALUES
('123', 'Main Street', 'New York', 1, '10001'),
('456', 'Oxford Street', 'London', 2, 'W1D 1BS'),
('789', 'Champs-Élysées', 'Paris', 3, '75008');

-- Sample data for customer table
INSERT INTO customer (first_name, last_name, email, phone) VALUES
('John', 'Doe', 'john.doe@example.com', '555-0101'),
('Jane', 'Smith', 'jane.smith@example.com', '555-0102'),
('Pierre', 'Dupont', 'pierre.dupont@example.com', '555-0103');

-- Sample data for customer_address table
INSERT INTO customer_address (customer_id, address_id, status_id) VALUES
(1, 1, 1), (2, 2, 1), (3, 3, 1);

-- Sample data for shipping_method table
INSERT INTO shipping_method (method_name, cost, delivery_time_days) VALUES
('Standard', 4.99, 5), ('Express', 9.99, 2), ('Overnight', 19.99, 1);

-- Sample data for order_status table
INSERT INTO order_status (status_name, description) VALUES
('Processing', 'Order received and being prepared'),
('Shipped', 'Order has been dispatched'),
('Delivered', 'Order has been delivered');

-- Sample data for cust_order table
INSERT INTO cust_order (customer_id, shipping_method_id, address_id, total_amount) VALUES
(1, 1, 1, 17.98),
(2, 2, 2, 25.98),
(3, 3, 3, 29.98);

-- Sample data for order_line table
INSERT INTO order_line (order_id, book_id, quantity, price) VALUES
(1, 1, 1, 12.99),
(1, 3, 1, 9.99),
(2, 2, 1, 15.99),
(3, 1, 2, 12.99);

-- Sample data for order_history table
INSERT INTO order_history (order_id, status_id, notes) VALUES
(1, 1, 'Payment received'),
(2, 1, 'Payment received'),
(3, 1, 'Payment received'),
(1, 2, 'Shipped via USPS'),
(2, 2, 'Shipped via FedEx');