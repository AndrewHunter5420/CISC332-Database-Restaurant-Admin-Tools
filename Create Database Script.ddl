/*
This file drops any existing restaurantDB database, deleting all 
tables and tuples, creates a new restaurantDB database, creates all 
tables, and inserts some sample tuples for testing purposes.

By running this script in XAMPP, the database will be reset to the 
state is was before making changes to the database.
*/

drop database if exists restaurantDB;
create database restaurantDB;
USE restaurantDB;

CREATE TABLE Customer (
    email VARCHAR(50) PRIMARY KEY,
    street VARCHAR(50),
    city VARCHAR(20),
    postalCode CHAR(6),
    phoneNumber CHAR(10),
    firstName VARCHAR(50),
    lastName VARCHAR(50),
    totalCredits INTEGER
);

CREATE TABLE Resturant (
    name VARCHAR(50) PRIMARY KEY,
    street VARCHAR(50),
    city VARCHAR(20),
    postalCode CHAR(6),
    url VARCHAR(100)
);

CREATE TABLE FoodItem (
    name VARCHAR(50) PRIMARY KEY
);

CREATE TABLE Employee (
    id INTEGER PRIMARY KEY,
    email VARCHAR(50),
    firstName VARCHAR(50),
    lastName VARCHAR(50)
);

CREATE TABLE Deliverer (
    id INTEGER NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(id) REFERENCES Employee(id)
        on delete cascade
);

CREATE TABLE Chef (
    id INTEGER NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(id) REFERENCES Employee(id)
        on delete cascade
);

CREATE TABLE Manager (
    id INTEGER NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(id) REFERENCES Employee(id)
        on delete cascade
);

# Note: Use Waiter instead of Server, because Server is key word
CREATE TABLE Waiter (
    id INTEGER NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(id) REFERENCES Employee(id)
        on delete cascade
);

CREATE TABLE Schedule (
    DateOfShift DATE NOT NULL,
    startTime TIME,
    endTime TIME,
    employeeID INTEGER NOT NULL,
    PRIMARY KEY (DATEOfShift, employeeID),
    FOREIGN KEY (employeeID) REFERENCES Employee(id)
        on delete cascade
);

# Note: Use TheORder instead of Order, because Order is key word
CREATE TABLE TheOrder (
    id INTEGER PRIMARY KEY,
    orderDate DATE,
    placementTime TIME,
    deliveryTime TIME,
    price FLOAT(6, 2),
    tip FLOAT(6, 2),
    delivererID INTEGER,
    FOREIGN KEY (delivererID) REFERENCES Deliverer(id)
        on delete set null
);

CREATE TABLE PlaceOrder (
    customerEmail VARCHAR(50) NOT NULL,
    resturantName VARCHAR(50) NOT NULL,
    orderID INTEGER NOT NULL,
    PRIMARY KEY (customerEmail, resturantName, orderID),
    FOREIGN KEY (customerEmail) REFERENCES Customer(email)
        on delete cascade,
    FOREIGN KEY (resturantName) REFERENCES Resturant(name)
        on delete cascade,
    FOREIGN KEY (orderID) REFERENCES TheOrder(id)
        on delete cascade
);

CREATE TABLE Payment (
    customerEmail VARCHAR(50) NOT NULL,
    resturantName VARCHAR(50) NOT NULL,
    placementDate DATE NOT Null,
    placementTime TIME NOT Null,
    amount FLOAT(6, 2),
    PRIMARY KEY (customerEmail, resturantName, placementDate, placementTime),
    FOREIGN KEY (customerEmail) REFERENCES Customer(email)
        on delete cascade,
    FOREIGN KEY (resturantName) REFERENCES Resturant(name)
        on delete cascade
);

CREATE TABLE ItemsOrdered (
    orderID INTEGER NOT NULL,
    itemName VARCHAR(50) NOT NULL,
    PRIMARY KEY (orderID, itemName),
    FOREIGN KEY (orderID) REFERENCES TheOrder(id)
        on delete cascade,
    FOREIGN KEY (itemName) REFERENCES FoodItem(name)
        on delete cascade
);

CREATE TABLE ItemInMenu (
    resturantName VARCHAR(50) NOT NULL,
    itemName VARCHAR(50) NOT NULL,
    price FLOAT (6, 2),
    PRIMARY KEY (resturantName, itemName),
    FOREIGN KEY (resturantName) REFERENCES Resturant(name)
        on delete cascade,
    FOREIGN KEY (itemName) REFERENCES FoodItem(name)
        on delete cascade
);

CREATE TABLE Credentials (
    credential VARCHAR(100) NOT NULL,
    chefID INTEGER NOT NULL,
    PRIMARY KEY (credential, chefID),
    FOREIGN KEY (chefID) REFERENCES Chef(id)
        on delete cascade
);

insert into Customer values
    ('bob@gmail.com', '1000 Sample Street', 'Toronto', 'A1A1A1', '9051001000', 'Bob', 'Penny', 100),
    ('flossie_admans@gmail.com', '1001 Sample Street', 'Toronto', 'A1A1A2', '9051001001', 'Flossie', 'Adams', 100),
    ('travis@gmail.com', '1002 Sample Street', 'Toronto', 'A1A A3', '9051001002', 'Travis', 'Tobias', 0),
    ('reene_rey1234@gmail.com', '2510 Sample Street', 'Kingston', 'A1B1A1', '9051002000', 'Reene', 'Rey', 1001),
    ('boothman@gmail.com', '2000 Sample Street', 'Toronto', 'A1A1A5', '9051001005', 'Tera', 'Boothman', 25),
    ('tanner_b@gmail.com', '2000 Sample Street', 'Toronto', 'A1A1A5', '9051001005', 'Tanner', 'Boothman', 30)
;

insert into Resturant values
    ('Original Resturant Name 1', '9990 Sample Stree', 'Kingston', 'A1A9Z0', 'resturant1.com'),
    ('Original Resturant Name 2', '9991 Sample Stree', 'Kingston', 'A1A9Z1', 'resturant2.com'),
    ('Original Resturant Name 3', '9992 Sample Stree', 'Kingston', 'A1A9Z2', 'resturant3.com'),
    ('Original Resturant Name 4', '9993 Sample Stree', 'Kingston', 'A1A9Z3', 'resturant4.com'),
    ('Original Resturant Name 5', '9994 Sample Stree', 'Kingston', 'A1A9Z4', 'resturant5.com'),
    ('Original Resturant Name 6', '9995 Sample Stree', 'Kingston', 'A1A9Z5', 'resturant6.com')
;

insert into FoodItem values
    ('Pizza'),
    ('Meatballs'),
    ('Poutine'),
    ('Mashed Potatoes'),
    ('Chocolate Cake'),
    ('Churros')
;

insert into Employee values
    (4000, 'charlton@gmail.com', 'Charlton', 'Benton'),
    (2100, 'kristy@gmail.com', 'Kristy', 'Baines'),
    (2101, 'daniel@gmail.com', 'Daniel', 'Emerson'),
    (2102, 'Barbara@gmail.com', 'Barbara', 'Sims'),
    (5000, 'Lilah@gmail.com', 'Lilah', 'Parish'),
    (1001, 'mary@gmail.com', 'Mary', 'Jervis'),
    (1002, 'lotus@gmail.com', 'Lotus', 'Bull'),
    (1003, 'tessa@gmail.com', 'Tessa', 'Blythe')
;

insert into Chef values
    (2100),
    (2101),
    (2102)
;

insert into Deliverer values
    (1001),
    (1002),
    (1003)
;

insert into Manager values
(4000)
;

insert into Waiter values
    (5000)
;

insert into Schedule values
    ('2023-04-03', '14:00:00', '22:00:00', 5000),
    ('2023-04-03', '14:00:00', '22:00:00', 2102),
    ('2023-04-04', '14:00:00', '15:00:00', 2100),
    ('2023-04-05', '14:00:00', '15:00:00', 2100),
    ('2023-04-06', '14:00:00', '15:00:00', 2100),
    ('2023-04-07', '14:00:00', '15:00:00', 2100),
    ('2023-04-08', '14:00:00', '22:00:00', 2100),
    ('2023-04-09', '16:00:00', '24:00:00', 2100),
    ('2023-04-04', '16:00:00', '24:00:00', 4000),
    ('2023-04-04', '16:00:00', '24:00:00', 2101),
    ('2023-04-04', '16:00:00', '24:00:00', 2102),
    ('2023-04-04', '16:00:00', '24:00:00', 1001),
    ('2023-04-04', '16:00:00', '24:00:00', 1002)
;

insert into TheOrder values
    (0001, '2023-02-09', '20:31:59', '21:17:23', 17.98, 5.00, 1001),
    (0002, '2023-02-09', '20:31:59', '21:17:23', 11.99, 2.00, 1002),
    (0003, '2023-02-10', '20:31:59', '1:18:23', 4.99, 1.00, 1001),
    (0004, '2023-02-10', '20:31:59', '21:18:23', 12.48, 5.00, 1003),
    (0005, '2023-02-11', '20:31:59', '21:18:23', 11.99, 3.00, 1002),
    (0006, '2023-02-15', '20:31:59', '21:18:23', 5.99, 3.00, 1001)
;

insert into PlaceOrder values
    ('bob@gmail.com', 'Original Resturant Name 1', 0001),
    ('bob@gmail.com', 'Original Resturant Name 2', 0002),
    ('bob@gmail.com', 'Original Resturant Name 1', 0003),
    ('flossie_admans@gmail.com', 'Original Resturant Name 3', 0004),
    ('bob@gmail.com', 'Original Resturant Name 2', 0005),
    ('flossie_admans@gmail.com', 'Original Resturant Name 1', 0006)
;

insert into Payment values
    ('bob@gmail.com', 'Original Resturant Name 1', '2023-02-09', '20:31:59', 62.45),
    ('bob@gmail.com', 'Original Resturant Name 2', '2023-02-09', '20:31:59', 23.45),
    ('bob@gmail.com', 'Original Resturant Name 2', '2023-02-10', '20:31:59', 21.37),
    ('flossie_admans@gmail.com', 'Original Resturant Name 3', '2023-02-10', '20:31:59', 21.37),
    ('bob@gmail.com', 'Original Resturant Name 1', '2023-02-10', '20:31:59', 21.37),
    ('flossie_admans@gmail.com', 'Original Resturant Name 1', '2023-02-10', '20:31:59', 21.37)
;

insert into ItemsOrdered values
    (0001, 'Pizza'),
    (0001, 'Poutine'),
    (0002, 'Meatballs'),
    (0003, 'Mashed Potatoes'),
    (0004, 'Chocolate Cake'),
    (0004, 'Churros'),
    (0005, 'Meatballs'),
    (0006, 'Churros')
;

insert into ItemInMenu values
    ('Original Resturant Name 1', 'Pizza', 12.99),
    ('Original Resturant Name 1', 'Poutine', 4.99),
    ('Original Resturant Name 1', 'Mashed Potatoes', 4.99),
    ('Original Resturant Name 1', 'Churros', 5.99),
    ('Original Resturant Name 2', 'Meatballs', 11.99),
    ('Original Resturant Name 2', 'Mashed Potatoes', 6.99),
    ('Original Resturant Name 3', 'Chocolate Cake', 6.99),
    ('Original Resturant Name 3', 'Churros', 5.49)
;

insert into Credentials values
    ('Certified Foodservice Professional', 2100),
    ('Master Certified Food Executive', 2100),
    ('Master Certified Food Executive', 2101),
    ('Certified Chef de Cuisine', 2100),
    ('Certified Chef de Cuisine', 2101),
    ('Certified Chef de Cuisine', 2102)
;