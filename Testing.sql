create database DoAnDatabase
use DoAnDatabase

-- Create the Users table
CREATE TABLE Users (
    UserID CHAR(6) PRIMARY KEY,
    Username VARCHAR(50) UNIQUE,
    Pass VARCHAR(80), -- Ensure passwords are hashed in application logic
    Email VARCHAR(100) UNIQUE,
    Role NVARCHAR(20) CHECK (Role IN ('Admin', 'User')) DEFAULT 'User',
    FName NVARCHAR(50),
    LName NVARCHAR(50),
    Address NVARCHAR(150),
    Phone VARCHAR(15),
    Sex VARCHAR(7),
    DateOfBirth DATE,
    MoneyLeft money,
    Avatar VARCHAR(MAX),
    CreatedAt DATE DEFAULT GETDATE(),
);

--------------------------------------------------------------------------------------------------

-- Create the Hotel table
CREATE TABLE Hotel (
    HotelID CHAR(6) PRIMARY KEY,
    HotelName NVARCHAR(50),
    HotelAddress NVARCHAR(255),
    City NVARCHAR(50),
    Country NVARCHAR(50),
    Description TEXT,
    ProductImage VARCHAR(MAX)
);
GO

-- Create the Room table
CREATE TABLE Room (
    RoomID CHAR(6) PRIMARY KEY,
    HotelID CHAR(6),
    RoomNumber VARCHAR(10) UNIQUE,
    RoomType VARCHAR(50) CHECK (RoomType IN ('VIP', 'Standard')),
    Capacity INT,
    IsAvailable BIT DEFAULT 1,
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID)
);
GO

-- Create the Booking_Room table, chac kh can status trong bang nay
CREATE TABLE Booking_Room (
    RoomBookingID CHAR(6) PRIMARY KEY,
    UserID CHAR(6),
    TotalPrice DECIMAL(10, 2),
    Status VARCHAR(50),
	CreatedDate DATE DEFAULT CAST(GETDATE() AS DATE),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
GO

-- Create the Booking_Room_Detail table
CREATE TABLE Booking_Room_Detail (
    RoomBookingID CHAR(6),
    RoomID CHAR(6),
    Price DECIMAL(10, 2),
    DateFrom DATETIME,
    DateTo DATETIME,
    Status VARCHAR(50),
	PRIMARY KEY (RoomID, RoomBookingID),
    FOREIGN KEY (RoomBookingID) REFERENCES Booking_Room(RoomBookingID),
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID)
);

--------------------------------------------------------------------------------------------------

CREATE TABLE Plane(
    PlaneID CHAR(6) PRIMARY KEY,
    PlaneName NVARCHAR(50),
    Airline NVARCHAR(50),
    ImageFileName NVARCHAR(100),
    NoSeat INT CHECK (NoSeat > 0)
);

-- Create the Flight table
CREATE TABLE Flight (
    FlightID CHAR(6) PRIMARY KEY,
    PlaneID CHAR(6),
    DateStart DATE,
    DateEnd DATE,
    DepartureCity NVARCHAR(100),
    ArrivalCity NVARCHAR(100),
    NoSeatLeft INT,
    FOREIGN KEY (PlaneID) REFERENCES Plane(PlaneID)
);

-- Create the Seat table , muc dich thay đổi ghế theo từng chuyến bay cụ thể
CREATE TABLE Seat (
    SeatID CHAR(6) PRIMARY KEY,
    FlightID CHAR(6),
    SeatNumber INT CHECK (SeatNumber > 0),
    SeatType VARCHAR(50) CHECK (SeatType IN ('VIP', 'Standard')),
    IsAvailable BIT DEFAULT 1,
    FOREIGN KEY (FlightID) REFERENCES Flight(FlightID)
);

-- Create table Booking_Ticket // nhu booking_room
CREATE TABLE Booking_Ticket (
    TicketBookingID CHAR(6) PRIMARY KEY,
	UserID CHAR(6),
	TotalPrice DECIMAL(10, 2),	
	Status BIT DEFAULT 0,
	CreatedDate DATE DEFAULT CAST(GETDATE() AS DATE),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Create the Booking_Ticket_Detail table ????
CREATE TABLE Booking_Ticket_Detail (
    BookingTicketID CHAR(6),
    SeatID CHAR(6),
    Price DECIMAL(10, 2),
    Status VARCHAR(50),
	PRIMARY KEY (SeatID, BookingTicketID),
    FOREIGN KEY (BookingTicketID) REFERENCES Booking_Ticket(TicketBookingID),
    FOREIGN KEY (SeatID) REFERENCES Seat(SeatID)
);


--------------------------------------------------------------------------------------------------

-- Create table Transactions
CREATE TABLE Transactions (
    TransactionID CHAR(6) PRIMARY KEY,
    UserID CHAR(6),
    RoomBookingID CHAR(6),
    TicketBookingID CHAR(6),
    TransactionDate DATE,
    Amount MONEY CHECK (Amount >= 0),
    Status VARCHAR(50),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (TicketBookingID) REFERENCES Booking_Ticket(TicketBookingID),
    FOREIGN KEY (RoomBookingID) REFERENCES Booking_Room(RoomBookingID)
);

INSERT INTO Users (UserID, Username, Pass, Email, FName, LName, Address, Phone, DateOfBirth, CreatedAt, Role)
VALUES 
('US0001', 'admin', '123', 'jdoe@example.com', 'John', 'Doe', '123 Maple St, Anytown', '1234567890', '1990-01-01', GETDATE(), 'Admin'),
('US0002', 'user', '456', 'asmith@example.com', 'Alice', 'Smith', '456 Oak St, Othertown', '2345678901', '1985-02-15', GETDATE(), 'User')

INSERT INTO Hotel (HotelID, HotelName, HotelAddress, Description, ProductImage, City, Country)
VALUES 
	('HT0001', 'Hotel Sunshine', '123 Beach Rd, Miami', 'A beachside hotel with a stunning view.', 'sunshine.jpg', 'Miami', 'USA'),
	('HT0002', 'Mountain View Resort', '456 Alpine St, Denver', 'A luxurious resort in the mountains.', 'mountainview.jpg', 'Denver', 'USA'),
	('HT0003', 'City Lights Hotel', '789 Downtown Ave, New York', 'Experience the city life in our modern hotel.', 'citylights.jpg', 'New York', 'USA'),
	('HT0004', 'Tropical Paradise', '101 Ocean Blvd, Honolulu', 'An oasis in the heart of the city.', 'tropicalparadise.jpg', 'Honolulu', 'USA'),
	('HT0005', 'Historic Inn', '202 Main St, Boston', 'Stay at a piece of history.', 'histo_ricinn.jpg', 'Boston', 'USA'),
	('HT0006', 'Luxury Stay', '303 Royal Dr, Los Angeles', 'A royal experience in the city.', 'luxurystay.jpg', 'Los Angeles', 'USA'),
	('HT0007', 'Countryside Retreat', '404 Greenway Rd, Austin', 'Relax in our countryside retreat.', 'countryside.jpg', 'Austin', 'USA'),
	('HT0008', 'Urban Escape', '505 Skyline Blvd, San Francisco', 'Escape the hustle and bustle in our serene hotel.', 'urbanescape.jpg', 'San Francisco', 'USA'),
	('HT0009', 'Desert Oasis', '606 Desert St, Phoenix', 'An oasis in the desert.', 'desertoasis.jpg', 'Phoenix', 'USA'),
	('HT0010', 'Lakefront Lodge', '707 Lake Rd, Chicago', 'Stay by the lake in comfort and style.', 'lakefront.jpg', 'Chicago', 'USA'),
	('HT0011', 'Coastal Comfort', '808 Seaside Dr, Seattle', 'Relax by the coast in our comfortable hotel.', 'coastalcomfort.jpg', 'Seattle', 'USA'),
	('HT0012', 'Riverside Hotel', '909 Riverside Blvd, New Orleans', 'Enjoy the charm of the riverfront in our boutique hotel.', 'riversidehotel.jpg', 'New Orleans', 'USA'),

	('HT0013', 'Forest Haven', '111 Pine St, Portland', 'A tranquil retreat in the woods.', 'foresthaven.jpg', 'Portland', 'USA'),
	('HT0014', 'Golden Gate Inn', '222 Bay St, San Francisco', 'Charming inn with a view of the Golden Gate Bridge.', 'goldengateinn.jpg', 'San Francisco', 'USA'),
	('HT0015', 'Desert Mirage', '333 Cactus Blvd, Las Vegas', 'Luxury and entertainment in the desert.', 'desertmirage.jpg', 'Las Vegas', 'USA'),
	('HT0016', 'Beachfront Bliss', '444 Ocean Ave, Santa Monica', 'Experience the beach life in style.', 'beachfrontbliss.jpg', 'Santa Monica', 'USA'),
	('HT0017', 'Snowy Peaks Lodge', '555 Snowy Ln, Aspen', 'A cozy lodge in the snowy mountains.', 'snowypeaks.jpg', 'Aspen', 'USA'),
	('HT0018', 'Urban Chic Hotel', '666 Main St, Dallas', 'Modern elegance in the heart of the city.', 'urbanchic.jpg', 'Dallas', 'USA'),
	('HT0019', 'Historic Charm Hotel', '777 Heritage Rd, Philadelphia', 'A hotel with historic charm and modern amenities.', 'historiccharm.jpg', 'Philadelphia', 'USA'),
	('HT0020', 'Lakeview Resort', '888 Lakeview Dr, Lake Tahoe', 'Enjoy the beauty of the lake from our resort.', 'lakeview.jpg', 'Lake Tahoe', 'USA'),
	('HT0021', 'City Center Hotel', '999 Downtown St, Atlanta', 'Conveniently located in the city center.', 'citycenter.jpg', 'Atlanta', 'USA'),
	('HT0022', 'Seaside Sanctuary', '1010 Coastal Blvd, San Diego', 'A peaceful sanctuary by the sea.', 'seasidesanctuary.jpg', 'San Diego', 'USA'),
	('HT0023', 'Mountain Lodge', '1111 Summit Rd, Salt Lake City', 'A perfect base for mountain adventures.', 'mountainlodge.jpg', 'Salt Lake City', 'USA'),
	('HT0024', 'Urban Comfort', '1212 City Blvd, Houston', 'Comfort and convenience in the city.', 'urbancomfort.jpg', 'Houston', 'USA');


INSERT INTO Room (RoomID, HotelID, RoomNumber, RoomType, IsAvailable)
VALUES
    ('RM0001', 'HT0001', '101', 'VIP', 1),
    ('RM0002', 'HT0001', '102', 'Standard', 1),
    ('RM0003', 'HT0002', '201', 'VIP', 1),
    ('RM0004', 'HT0002', '202', 'Standard', 1),
    ('RM0005', 'HT0003', '301', 'VIP', 1),
    ('RM0006', 'HT0003', '302', 'Standard', 1),
    ('RM0007', 'HT0004', '401', 'VIP', 1),
    ('RM0008', 'HT0004', '402', 'Standard', 1),
    ('RM0009', 'HT0005', '501', 'VIP', 1),
    ('RM0010', 'HT0005', '502', 'Standard', 1),
    ('RM0011', 'HT0006', '601', 'VIP', 1),
    ('RM0012', 'HT0006', '602', 'Standard', 1),
    ('RM0013', 'HT0007', '701', 'VIP', 1),
    ('RM0014', 'HT0007', '702', 'Standard', 1),
    ('RM0015', 'HT0008', '801', 'VIP', 1),
    ('RM0016', 'HT0008', '802', 'Standard', 1),
    ('RM0017', 'HT0009', '901', 'VIP', 1),
    ('RM0018', 'HT0009', '902', 'Standard', 1),
    ('RM0019', 'HT0010', '1001', 'VIP', 1),
    ('RM0020', 'HT0010', '1002', 'Standard', 1);

----------------------------------------------------------------------------------------

INSERT INTO Plane(PlaneID, PlaneName, Airline, ImageFileName, NoSeat)
VALUES
    ('PL0001', 'Boeing 737', 'Boeing', 'boeing737.jpg', 180),
    ('PL0002', 'Airbus A320', 'Airbus', 'airbusa320.jpg', 160),
    ('PL0003', 'Boeing 777', 'Boeing', 'boeing777.jpg', 277),
    ('PL0004', 'Airbus A380', 'Airbus', 'airbusa380.jpg', 274),
    ('PL0005', 'Boeing 747', 'Boeing', 'boeing747.jpg', 275),
    ('PL0006', 'Embraer 190', 'Embraer', 'embraer190.jpg', 214),
    ('PL0007', 'Bombardier CRJ900', 'Bombardier', 'bombardiercrj900.jpg', 290),
    ('PL0008', 'Cessna 172', 'Cessna', 'cessna172.jpg', 224),
    ('PL0009', 'Gulfstream G650', 'Gulfstream', 'gulfstreamg650.jpg', 218),
    ('PL0010', 'Boeing 787', 'Boeing', 'boeing787.jpg', 242),
    ('PL0011', 'Airbus A321', 'Airbus', 'airbusa321.jpg', 185),
    ('PL0012', 'Boeing 767', 'Boeing', 'boeing767.jpg', 276),
    ('PL0013', 'Airbus A330', 'Airbus', 'airbusa330.jpg', 278),
    ('PL0014', 'Boeing 737 MAX', 'Boeing', 'boeing737max.jpg', 210),
    ('PL0015', 'Bombardier Q400', 'Bombardier', 'bombardierq400.jpg', 276),
    ('PL0016', 'Cessna Citation X', 'Cessna', 'cessnacitationx.jpg', 212),
    ('PL0017', 'Embraer ERJ145', 'Embraer', 'embraererj145.jpg', 50),
    ('PL0018', 'Airbus A350', 'Airbus', 'airbusa350.jpg', 279),
    ('PL0019', 'Boeing 757', 'Boeing', 'boeing757.jpg', 280),
    ('PL0020', 'Bombardier Global 7500', 'Bombardier', 'bombardierglobal7500.jpg', 219),
    ('PL0021', 'Embraer E175', 'Embraer', 'embraere175.jpg', 88),
    ('PL0022', 'Gulfstream G500', 'Gulfstream', 'gulfstreamg500.jpg', 219),
    ('PL0023', 'Airbus A220', 'Airbus', 'airbusa220.jpg', 140),
    ('PL0024', 'Boeing 787-10', 'Boeing', 'boeing78710.jpg', 281);

INSERT INTO Flight (FlightID, PlaneID, DateStart, DateEnd, DepartureCity, ArrivalCity)
VALUES 
('FL0001', 'PL0001', '2024-07-01', '2024-07-01', 'New York', 'Los Angeles'),
('FL0002', 'PL0002', '2024-07-02', '2024-07-02', 'Chicago', 'Miami'),
('FL0003', 'PL0003', '2024-07-03', '2024-07-03', 'Dallas', 'San Francisco'),
('FL0004', 'PL0004', '2024-07-04', '2024-07-04', 'Seattle', 'Chicago'),
('FL0005', 'PL0005', '2024-07-05', '2024-07-05', 'Boston', 'Orlando'),
('FL0006', 'PL0006', '2024-07-06', '2024-07-06', 'Atlanta', 'Las Vegas'),
('FL0007', 'PL0007', '2024-07-07', '2024-07-07', 'Denver', 'Houston'),
('FL0008', 'PL0008', '2024-07-08', '2024-07-08', 'Miami', 'New York'),
('FL0009', 'PL0009', '2024-07-09', '2024-07-09', 'San Diego', 'Denver'),
('FL0010', 'PL0010', '2024-07-10', '2024-07-10', 'San Francisco', 'Boston');


INSERT INTO Seat (SeatID, FlightID, SeatNumber, SeatType, IsAvailable)
VALUES
    ('ST0001', 'FL0001', 1, 'Standard', 1),
    ('ST0002', 'FL0001', 2, 'VIP', 1),
    ('ST0003', 'FL0002', 1, 'Standard', 1),
    ('ST0004', 'FL0002', 2, 'VIP', 1),
    ('ST0005', 'FL0003', 1, 'Standard', 1),
    ('ST0006', 'FL0003', 2, 'Standard', 1),
    ('ST0007', 'FL0004', 1, 'Standard', 1),
    ('ST0008', 'FL0004', 2, 'Standard', 1),
    ('ST0009', 'FL0005', 1, 'Standard', 1),
    ('ST0010', 'FL0005', 2, 'Standard', 1),
    ('ST0011', 'FL0006', 1, 'Standard', 1),
    ('ST0012', 'FL0006', 2, 'Standard', 1),
    ('ST0013', 'FL0007', 1, 'Standard', 1),
    ('ST0014', 'FL0007', 2, 'Standard', 1),
    ('ST0015', 'FL0008', 1, 'Standard', 1),
    ('ST0016', 'FL0008', 2, 'Standard', 1),
    ('ST0017', 'FL0009', 1, 'Standard', 1),
    ('ST0018', 'FL0009', 2, 'Standard', 1);


