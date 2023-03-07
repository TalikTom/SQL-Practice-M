use LibraryLuka;

create table Member
(
    id uniqueidentifier PRIMARY KEY not null,
    firstName varchar(50) not null,
    lastName varchar(50) not null,
    oib char(11)
);

create table Membership
(
    id uniqueidentifier PRIMARY KEY not null,
    startDate datetime not null,
    endDate datetime,
    accountNo int not null,
    membershipID uniqueidentifier not null
);

create table Loan
(
    id uniqueidentifier PRIMARY KEY not null,
    startDate datetime not null,
    memberID uniqueidentifier not null
);

create table Book 
(
    id uniqueidentifier PRIMARY KEY not null,
    title varchar(255) not null,
    releaseYear int not null,
    loanID uniqueidentifier not null
);

create table Category 
( 
   id uniqueidentifier PRIMARY KEY not null,
   name varchar(255) not null, 
);


create table BookCategory
(
    id uniqueidentifier PRIMARY KEY not null,
    bookID uniqueidentifier not null,
    categoryID uniqueidentifier not null
);

alter table Membership add constraint FK_Membership_Membership_membershipID FOREIGN KEY (membership)
      REFERENCES Membership (id);

alter table Loan add constraint FK_Loan_Member_memberID FOREIGN KEY (memberID)
      REFERENCES Member (id);

alter table Book add constraint FK_Book_Loan_loanID FOREIGN KEY (loanID)
      REFERENCES Loan (id);

alter table BookCategory add constraint FK_BookCategory_Book_bookID FOREIGN KEY (bookID)
      REFERENCES book (id);   

alter table BookCategory add constraint FK_BookCategory_Category_categoryID FOREIGN KEY (categoryID)
      REFERENCES category (id);   