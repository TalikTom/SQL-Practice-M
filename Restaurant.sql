use Restaurant


/*----------------------------------------------------------------*/
/* Create tables */
/*----------------------------------------------------------------*/


create table Chef 
(
    Id uniqueidentifier not null PRIMARY KEY,
    FirstName varchar(255) not null,
    LastName varchar(255) not null,
    PhoneNumber varchar(255) not null,
    HomeAddress varchar(255) not null,
    Certified boolean not null,
    OIB char(11) not null,
    HireDate datetime not null
);


create table Waiter 
(
    Id uniqueidentifier not null PRIMARY KEY,
    FirstName varchar(255) not null,
    LastName varchar(255) not null,
    PhoneNumber varchar(255) not null,
    HomeAddress varchar(255) not null,
    OIB char(11) not null,
    HireDate datetime not null
);


create table Customer
(
    Id uniqueidentifier not null PRIMARY KEY,
    TableId int not null
);


create table CustomerDetails
(
    Id uniqueidentifier not null PRIMARY KEY,
    Commentary text
);


create table MenuItem
(
    Id uniqueidentifier not null PRIMARY KEY,
    Title varchar (255) not null,
    Quantity int not null,
    Price decimal(10,2) not null
);


create table Reservation
(
    Id uniqueidentifier not null PRIMARY KEY,
    ReservationTime datetime not null,
    NoOfGuests int not null,
    CustomerId uniqueidentifier not null
);


create table Order 
(
    Id uniqueidentifier not null PRIMARY KEY,
    CustomerId uniqueidentifier not null,
    ChefId uniqueidentifier not null,
    WaiterId uniqueidentifier not null
);


create table Payment 
(
    Id uniqueidentifier not null PRIMARY KEY,
    OrderId uniqueidentifier not null,
    PaymentTime datetime not null,
    PaymentAmount decimal(10,2) not null
);


create table Menu
(
    Id uniqueidentifier not null PRIMARY KEY,
    StartDate datetime not null,
    EndDate datetime,
    MenuItemId uniqueidentifier not null
);


create table OrderItem
(
    Id uniqueidentifier not null,
    Quantity int not null,
    Price decimal(10,2) not null,
    MenuItemId uniqueidentifier not null
);


/*----------------------------------------------------------------*/
/* Alter tables */
/*----------------------------------------------------------------*/


alter table Reservation add constraint FK_Reservation_Customer_CustomerId FOREIGN KEY (CustomerId)
      REFERENCES Customer (Id);
