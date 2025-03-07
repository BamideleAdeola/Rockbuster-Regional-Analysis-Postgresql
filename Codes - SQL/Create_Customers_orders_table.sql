-- Create customers table
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL
);

-- Insert sample data into customers table
INSERT INTO customers (name, email) VALUES
('John Doe', 'john@example.com'),
('Jane Smith', 'jane@example.com'),
('Alice Wong', 'alice@example.com'),
('Bob Brown', 'bob@example.com');

-- Create orders table
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL
);

-- Insert sample data into orders table
INSERT INTO orders (customer_id, order_date, amount) VALUES
(1, '2023-10-01', 100.00),
(2, '2023-10-02', 200.00),
(1, '2023-10-03', 150.00);



