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
    Certified bit not null,
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
    Price decimal(10,2) not null,
    OrderItemId uniqueidentifier not null,
    MenuId uniqueidentifier not null
);


create table Reservation
(
    Id uniqueidentifier not null PRIMARY KEY,
    ReservationTime datetime not null,
    NoOfGuests int not null,
    CustomerId uniqueidentifier not null
);


create table CustomerOrder 
(
    Id uniqueidentifier not null PRIMARY KEY,
    CustomerId uniqueidentifier not null,
    ChefId uniqueidentifier not null,
    WaiterId uniqueidentifier not null
);


create table CustomerOrderItem
(
    Id uniqueidentifier not null PRIMARY KEY,
    CustomerOrderId uniqueidentifier not null,
    OrderItemId uniqueidentifier not null
);


create table Payment 
(
    Id uniqueidentifier not null PRIMARY KEY,
    PaymentTime datetime not null,
    PaymentAmount decimal(10,2) not null
);


create table Menu
(
    Id uniqueidentifier not null PRIMARY KEY,
    StartDate datetime not null,
    EndDate datetime
);


create table OrderItem
(
    Id uniqueidentifier not null PRIMARY KEY,
    Quantity int not null,
    Price decimal(10,2) not null
);


/*----------------------------------------------------------------*/
/* Alter tables */
/*----------------------------------------------------------------*/


alter table Reservation add constraint FK_Reservation_Customer_CustomerId FOREIGN KEY (CustomerId)
      REFERENCES Customer (Id);


alter table CustomerOrder add constraint FK_Chef_CustomerOrder_ChefId FOREIGN KEY (ChefId)
      REFERENCES Chef (Id);
alter table CustomerOrder add constraint FK_Waiter_CustomerOrder_WaiterId FOREIGN KEY (WaiterId)
      REFERENCES Waiter (Id);
alter table CustomerOrder add constraint FK_Customer_CustomerOrder_CustomerId FOREIGN KEY (CustomerId)
      REFERENCES Customer (Id);


alter table CustomerDetails add constraint FK_Customer_CustomerDetails_CustomerId FOREIGN KEY (Id)
REFERENCES Customer (Id);


alter table Payment add constraint FK_CustomerOrder_Payment_Id FOREIGN KEY (Id)
      REFERENCES CustomerOrder (Id);


alter table MenuItem add constraint FK_MenuItem_Menu_MenuId FOREIGN KEY (MenuId)
      REFERENCES Menu (Id);      

alter table MenuItem add constraint FK_OrderItem_MenuItem_OrderItemId FOREIGN KEY (OrderItemId)
      REFERENCES OrderItem (Id);    

     
alter table CustomerOrderItem add constraint FK_CustomerOrder_CustomerOrderItem_CustomerOrderId FOREIGN KEY (CustomerOrderId)
      REFERENCES CustomerOrder (Id);    
alter table CustomerOrderItem add constraint FK_OrderItem_CustomerOrderItem_OrderItemId FOREIGN KEY (OrderItemId)
      REFERENCES OrderItem (Id);    




/*----------------------------------------------------------------*/
/* Insert test data - declaring variables */
/*----------------------------------------------------------------*/


/* declaring customer id's */

declare @luka as uniqueidentifier set @luka = newid();
declare @marija as uniqueidentifier set @marija = newid();
declare @jona as uniqueidentifier set @jona = newid();


/* declaring chef id's */

declare @zoran as uniqueidentifier set @zoran = newid();
declare @andrej as uniqueidentifier set @andrej = newid();
declare @gordan as uniqueidentifier set @gordan = newid();


/* declaring waiter id's */

declare @toma as uniqueidentifier set @toma = newid();
declare @zdravko as uniqueidentifier set @zdravko = newid();
declare @ibrica as uniqueidentifier set @ibrica = newid();


/* declaring menu id */

declare @menu1 as uniqueidentifier set @menu1 = newid();


/* declaring menu_items id's */

declare @pekingduck as uniqueidentifier set @pekingduck = newid();
declare @beefwellington as uniqueidentifier set @beefwellington = newid();
declare @pasta as uniqueidentifier set @pasta = newid();


/* declaring menu_items id's */

declare @order1 as uniqueidentifier set @order1 = newid();
declare @order2 as uniqueidentifier set @order2 = newid();
declare @order3 as uniqueidentifier set @order3 = newid();


/* declaring CustomerOrder id's */

declare @customerorder1 as uniqueidentifier set @customerorder1 = newid();
declare @customerorder2 as uniqueidentifier set @customerorder2 = newid();
declare @customerorder3 as uniqueidentifier set @customerorder3 = newid();


/*------------------------  */
/* Insert test data - insert dummy data */
/*------------------------  */

/* populating Customer table */

insert into Customer values
(@luka, 1),
(@marija, 2),
(@jona, 3);


/* populating CustomerDetails table */

insert into CustomerDetails values
(@luka, 'Big tipper'),
(@jona, 'Rude and loud');


/* populating Reservation table */

insert into Reservation values
(newId(), '2023-02-02 19:00:00', 5, @luka),
(newId(), '2023-01-01 16:45:00', 2, @marija),
(newId(), '2023-03-03 19:00:00', 3, @jona);


/* populating Chef table */

insert into Chef values
(@zoran, 'Zoran', 'Zoric', '099/888-7452', 'Sandora Petefija 100', 1, '12345678914', '2023-01-01'),
(@andrej, 'Andrej', 'Andrejic', '099/222-7452', 'J.J. Strossmayera 10', 0, '12345678912', '2022-01-01'),
(@gordan, 'Gordan', 'Gordic', '091/222-7452', 'Trg Trgova 10', 1, '02345678912', '2021-01-01');


/* populating Waiter table */

insert into Waiter values
(@toma, 'Toma', 'Tomic', '099/888-1111', 'Sandora Petefija 5','12345678914', '2023-12-12'),
(@zdravko, 'Zdravko', 'Zdravkic', '099/111-7452', 'J.J. Strossmayera 3','12343678912', '2020-12-12'),
(@ibrica, 'Ibrica', 'Ibricic', '092/222-7452', 'Trg Trgova 7', '02345678112', '2019-12-12');


/* populating Menu table */

insert into Menu values
(@menu1, '2022-01-01', '2023-12-12');


/* populating OrderItem table */

insert into OrderItem values
(@order1, 1, 50.53),
(@order2, 1, 50.53),
(@order3, 1, 50.53);


/* populating MenuItem table */

insert into MenuItem values
(@pekingduck, 'Peking Duck', 10, 50.53, @order1, @menu1),
(@beefwellington, 'Beef Wellington', 10, 99.99, @order2, @menu1),
(@pasta, 'Pasta', 10, 10.60, @order3, @menu1);


/* populating CustomerOrder table */

insert into CustomerOrder values
(@customerorder1, @luka, @zoran, @toma),
(@customerorder2, @marija, @andrej, @zdravko),
(@customerorder3, @jona, @andrej, @ibrica);


/* populating Payment table */

insert into Payment values
(@customerorder1, '2023-02-02 19:45:00', 500),
(@customerorder2, '2023-03-03 17:45:00', 800),
(@customerorder3, '2023-01-01 16:45:00', 300);



/*----------------------------------------------------------------*/
/* PRACTICE TIME */
/*----------------------------------------------------------------*/


/* View and join table */

/* View that selects waiter and chef related to the table where the food was served */

CREATE VIEW Responsibility
AS
SELECT w.FirstName as WaitersName, c.FirstName as ChefsName, cu.TableId
FROM Waiter w
inner join CustomerOrder co
ON w.Id = co.WaiterId
inner join Chef c
ON co.ChefId = c.ID
inner join customer cu
ON co.CustomerId = cu.Id;


/* View that selects waiter and payment time */

CREATE VIEW PaymentWaiter
AS
SELECT p.PaymentTime, CONCAT_WS(' ' , w.FirstName, w.LastName) full_name
FROM Payment p
inner join CustomerOrder co
ON p.Id = co.Id
inner join Waiter w
ON co.WaiterId = w.Id


/* join all tables together */

SELECT w.FirstName as WaitersFirstName, mi.Title as MenuTitleName, p.PaymentAmount as PaymentAmount, r.NoOfGuests as NumberOfGuests, c.FirstName as ChefsFirstName
FROM menu m
INNER JOIN MenuItem mi 
ON m.Id = mi.MenuId
INNER JOIN OrderItem oi
ON mi.OrderItemId = oi.Id
INNER JOIN CustomerOrderItem coi
ON oi.Id = coi.OrderItemId
INNER JOIN CustomerOrder co
ON coi.CustomerOrderId = co.Id
INNER JOIN Payment p
ON co.Id = p.Id
INNER JOIN Chef c
ON co.ChefId = c.Id
INNER JOIN Waiter w
ON co.WaiterId = w.Id 
INNER JOIN Customer cu 
ON co.CustomerId = cu.Id 
INNER JOIN Reservation r
ON cu.Id = r.CustomerId
INNER JOIN CustomerDetails cd 
ON cu.Id = cd.Id
WHERE w.FirstName = @toma;


/* Basic SQL */

/* Update */

UPDATE Chef
SET Certified = 1;
WHERE FirstName = 'Andrej';


/* Delete */

DELETE FROM Customer WHERE Id = @luka;


/* Alter table add columns */

ALTER TABLE Customer
ADD FullName varchar(255);


/* Alter table modify column name */

ALTER TABLE Waiter
RENAME COLUMN HireDate to StartDate;


/* Functions */

create function total(@number1 FLOAT, @number2 FLOAT)
returns FLOAT
A
BEGIN
    DECLARE @result FLOAT;
    SET @result = @number1 * @number2;
    RETURN @result;
END