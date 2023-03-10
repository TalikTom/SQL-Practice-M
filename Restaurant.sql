use Restaurant


create table Chef 
(
    Id uniqueidentifier not null PRIMARY KEY,
    FirstName varchar(255) not null,
    LastName varchar(255) not null,
    PhoneNumber varchar(255) not null,
    HomeAddress varchar(255) not null,
    Certified boolean not null,
    HireDate datetime not null
)

create table Waiter 
(
    Id uniqueidentifier not null PRIMARY KEY,
    FirstName varchar(255) not null,
    LastName varchar(255) not null,
    PhoneNumber varchar(255) not null,
    HomeAddress varchar(255) not null,
    HireDate datetime not null
)

create table Customer
(
    Id uniqueidentifier not null PRIMARY KEY,
    TableId int not null
)


create table CustomerDetails
(
    Id uniqueidentifier not null PRIMARY KEY,
    Commentary text
)

create table Reservation
(
    Id uniqueidentifier not null PRIMARY KEY,
    ReservationTime datetime not null,
    NoOfGuests int not null,
    CustomerId uniqueidentifier not null

)

create table Payment 
(
    Id uniqueidentifier not null PRIMARY KEY,
    CustomerId uniqueidentifier not null,
    ChefId uniqueidentifier not null,
    WaiterId uniqueidentifier not null
)


create table MenuItem
(
    Id uniqueidentifier not null PRIMARY KEY,
    Title varchar (255) not null,
    Quantity int not null,
    Price decimal not null
)


create table Menu
(
    Id uniqueidentifier not null PRIMARY KEY,
    StartDate datetime not null,
    EndDate datetime,
    MenuItemId uniqueidentifier not null
)