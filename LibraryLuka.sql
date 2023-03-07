use LibraryLuka;

create table member
(
    id uniqueidentifier PRIMARY KEY not null,
    firstName varchar(50) not null,
    lastName varchar(50) not null,
    oib char(11)
);

create table membership
(
    id uniqueidentifier PRIMARY KEY not null,
    startDate datetime not null,
    endDate datetime,
    accountNo int not null
);

create table loan
(
    id uniqueidentifier PRIMARY KEY not null,
    startDate datetime not null
);

create table book 
(
    id uniqueidentifier PRIMARY KEY not null,
    title varchar(255) not null,
    releaseYear int not null
);

create table category 
( 
   id uniqueidentifier PRIMARY KEY not null,
   name varchar(255) not null, 
);


create table book_category
(
    id uniqueidentifier PRIMARY KEY not null,
    book_id uniqueidentifier not null,
    category_id uniqueidentifier not null
);