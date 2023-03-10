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
    PaymentAmount decimal(10,2) not null,
    CustomerOrderId uniqueidentifier not null
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
/* Input test data */
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




/* populating Customer tables */

insert into Customer values
(@luka, 1),
(@marija, 2),
(@jona, 3);


/* populating Chef tables */

insert into Chef values
(@zoran, 'Zoran', 'Zoric', '099/888-7452', 'Sandora Petefija 100', true, '12345678914', 2023-01-01),
(@andrej, 'Andrej', 'Andrejic', '099/222-7452', 'J.J. Strossmayera 10', false, '12345678912', 2022-01-01),
(@gordan, 'Gordan', 'Gordic', '091/222-7452', 'Trg Trgova 10', true, '02345678912', 2021-01-01);


/* populating Waiter tables */

insert into Waiter values
(@toma, 'Toma', 'Tomic', '099/888-1111', 'Sandora Petefija 5','12345678914', 2023-12-12),
(@zdravko, 'Zdravko', 'Zdravkic', '099/111-7452', 'J.J. Strossmayera 3','12343678912', 2020-12-12),
(@ibrica, 'Ibrica', 'Ibricic', '092/222-7452', 'Trg Trgova 7', '02345678112', 2019-12-12);


