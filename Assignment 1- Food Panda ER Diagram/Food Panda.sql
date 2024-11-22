CREATE DATABASE FoodPanda;

CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(15),
    Address VARCHAR(255),
    Password VARCHAR(255) NOT NULL,
    Role VARCHAR(50) CHECK (Role IN ('Customer', 'Owner', 'Delivery'))
);
CREATE TABLE Restaurant (
    RestaurantID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(255),
    PhoneNumber VARCHAR(15),
    CuisineType VARCHAR(100),
    Rating DECIMAL(2,1)
);
CREATE TABLE Menu (
    MenuID INT PRIMARY KEY IDENTITY(1,1),
    RestaurantID INT,
    MenuName VARCHAR(100),
    FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantID)
);
CREATE TABLE Dish (
    DishID INT PRIMARY KEY IDENTITY(1,1),
    MenuID INT,
    DishName VARCHAR(100),
    Price DECIMAL(10,2),
    Description TEXT,
    Image VARCHAR(255),
    AvailabilityStatus BIT,
    FOREIGN KEY (MenuID) REFERENCES Menu(MenuID) 
);
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
    RestaurantID INT,
    OrderStatus VARCHAR(50) CHECK (OrderStatus IN ('Pending', 'Delivered', 'Cancelled')),
    TotalAmount DECIMAL(10,2),
    PaymentMethod VARCHAR(50) CHECK (PaymentMethod IN ('Card', 'Cash')),
    DeliveryAddress VARCHAR(255),
    OrderDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantID) 
);
CREATE TABLE OrderItem (
    OrderItemID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT,
    DishID INT,
    Quantity INT,
    Price DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ,
    FOREIGN KEY (DishID) REFERENCES Dish(DishID) 
);
CREATE TABLE DeliveryPerson (
    DeliveryPersonID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(15),
    VehicleDetails VARCHAR(100)
);
CREATE TABLE Delivery (
    DeliveryID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT,
    DeliveryPersonID INT,
    DeliveryStatus VARCHAR(50) CHECK (DeliveryStatus IN ('Pending', 'Delivered')),
    DeliveryDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (DeliveryPersonID) REFERENCES DeliveryPerson(DeliveryPersonID)
);
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT,
    PaymentMethod VARCHAR(50),
    PaymentStatus VARCHAR(50) CHECK (PaymentStatus IN ('Success', 'Failure')),
    PaymentDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) 
);
CREATE TABLE Review (
    ReviewID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
    RestaurantID INT,
    Rating DECIMAL(2,1) CHECK (Rating >= 0 AND Rating <= 5),
    Comments TEXT,
    ReviewDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ,
    FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantID)
);

