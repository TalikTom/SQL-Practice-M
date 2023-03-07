use LibraryLuka;

create table Member
(
    Id uniqueidentifier PRIMARY KEY not null,
    FirstName varchar(50) not null,
    LastName varchar(50) not null,
    Oib char(11)
);

create table Membership
(
    Id uniqueidentifier PRIMARY KEY not null,
    StartDate datetime not null,
    EndDate datetime,
    AccountNo int not null,
    MemberID uniqueidentifier not null
);

create table Loan
(
    Id uniqueidentifier PRIMARY KEY not null,
    StartDate datetime not null,
    MemberID uniqueidentifier not null
);

create table Book 
(
    Id uniqueidentifier PRIMARY KEY not null,
    Title varchar(255) not null,
    ReleaseYear int not null,
    LoanID uniqueidentifier not null
);

create table Category 
( 
   Id uniqueidentifier PRIMARY KEY not null,
   Title varchar(255) not null, 
);


create table BookCategory
(
    Id uniqueidentifier PRIMARY KEY not null,
    BookID uniqueidentifier not null,
    CategoryID uniqueidentifier not null
);

alter table Membership add constraint FK_Membership_Member_memberID FOREIGN KEY (MemberID)
      REFERENCES Member (Id);

alter table Loan add constraint FK_Loan_Member_memberID FOREIGN KEY (MemberID)
      REFERENCES Member (Id);

alter table Book add constraint FK_Book_Loan_loanID FOREIGN KEY (LoanID)
      REFERENCES Loan (Id);

alter table BookCategory add constraint FK_BookCategory_Book_bookID FOREIGN KEY (BookID)
      REFERENCES Book (Id);   

alter table BookCategory add constraint FK_BookCategory_Category_categoryID FOREIGN KEY (CategoryID)
      REFERENCES Category (Id);   