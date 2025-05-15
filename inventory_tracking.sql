-- Database: InventoryTrackingSystem

-- Table: Suppliers
CREATE TABLE Suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(255) NOT NULL UNIQUE,
    contact_name VARCHAR(255),
    phone VARCHAR(50),
    email VARCHAR(255) UNIQUE,
    address TEXT
);

-- Table: Categories
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- Table: Products
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    sku VARCHAR(100) UNIQUE, -- Stock Keeping Unit
    category_id INT,
    supplier_id INT,
    unit_price DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    reorder_level INT DEFAULT 0,
    description TEXT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT chk_unit_price CHECK (unit_price >= 0)
);

-- Table: Warehouses
CREATE TABLE Warehouses (
    warehouse_id INT AUTO_INCREMENT PRIMARY KEY,
    warehouse_name VARCHAR(255) NOT NULL UNIQUE,
    location TEXT
);

-- Table: Inventory
-- Stores the current stock level of each product in each warehouse
CREATE TABLE Inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    warehouse_id INT NOT NULL,
    quantity_on_hand INT NOT NULL DEFAULT 0,
    last_stock_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE (product_id, warehouse_id), -- Each product can only have one entry per warehouse
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT chk_quantity_on_hand CHECK (quantity_on_hand >= 0)
);

-- Table: Customers
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(50),
    address TEXT
);

-- Table: Orders
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) NOT NULL DEFAULT 'Pending', -- e.g., Pending, Processing, Shipped, Delivered, Cancelled
    shipping_address TEXT,
    total_amount DECIMAL(12, 2) DEFAULT 0.00,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Table: OrderItems
-- Junction table for Orders and Products (M:M relationship for products within an order)
CREATE TABLE OrderItems (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price_at_purchase DECIMAL(10, 2) NOT NULL, -- Price at the time of order
    subtotal DECIMAL(12, 2) GENERATED ALWAYS AS (quantity * unit_price_at_purchase) STORED,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE RESTRICT ON UPDATE CASCADE, -- Prevent deleting product if it's in an order
    CONSTRAINT chk_quantity CHECK (quantity > 0)
);

-- Table: PurchaseOrders
-- For ordering stock from suppliers
CREATE TABLE PurchaseOrders (
    po_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_id INT NOT NULL,
    order_date DATE NOT NULL DEFAULT (CURDATE()),
    expected_delivery_date DATE,
    status VARCHAR(50) NOT NULL DEFAULT 'Pending', -- e.g., Pending, Ordered, Shipped, Received, Cancelled
    total_amount DECIMAL(12, 2) DEFAULT 0.00,
    notes TEXT,
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Table: PurchaseOrderItems
-- Junction table for PurchaseOrders and Products
CREATE TABLE PurchaseOrderItems (
    po_item_id INT AUTO_INCREMENT PRIMARY KEY,
    po_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity_ordered INT NOT NULL,
    unit_cost DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(12, 2) GENERATED ALWAYS AS (quantity_ordered * unit_cost) STORED,
    quantity_received INT DEFAULT 0,
    FOREIGN KEY (po_id) REFERENCES PurchaseOrders(po_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT chk_po_quantity CHECK (quantity_ordered > 0),
    CONSTRAINT chk_received_quantity CHECK (quantity_received >= 0 AND quantity_received <= quantity_ordered)
);

-- Table: StockMovements
-- Tracks all movements of stock (e.g., receiving from supplier, shipping to customer, internal transfers)
CREATE TABLE StockMovements (
    movement_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    warehouse_id INT NOT NULL,
    movement_type VARCHAR(50) NOT NULL, -- e.g., 'Receipt', 'Shipment', 'Adjustment_In', 'Adjustment_Out', 'Transfer_Out', 'Transfer_In'
    quantity INT NOT NULL, -- Positive for incoming, negative for outgoing
    movement_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    reference_order_id INT NULL, -- Link to Sales Order if it's a shipment
    reference_po_id INT NULL,    -- Link to Purchase Order if it's a receipt
    notes TEXT,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (reference_order_id) REFERENCES Orders(order_id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (reference_po_id) REFERENCES PurchaseOrders(po_id) ON DELETE SET NULL ON UPDATE CASCADE
);


