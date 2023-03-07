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
    MemberId uniqueidentifier not null
);

create table Loan
(
    Id uniqueidentifier PRIMARY KEY not null,
    StartDate datetime not null,
    MemberId uniqueidentifier not null
);

create table Book 
(
    Id uniqueidentifier PRIMARY KEY not null,
    Title varchar(255) not null,
    ReleaseYear int not null,
    LoanId uniqueidentifier not null
);

create table Category 
( 
   Id uniqueidentifier PRIMARY KEY not null,
   Title varchar(255) not null, 
);


create table BookCategory
(
    Id uniqueidentifier PRIMARY KEY not null,
    BookId uniqueidentifier not null,
    CategoryId uniqueidentifier not null
);

alter table Membership add constraint FK_Membership_Member_MemberID FOREIGN KEY (MemberId)
      REFERENCES Member (Id);

alter table Loan add constraint FK_Loan_Member_MemberID FOREIGN KEY (MemberId)
      REFERENCES Member (Id);

alter table Book add constraint FK_Book_Loan_LoanID FOREIGN KEY (LoanId)
      REFERENCES Loan (Id);

alter table BookCategory add constraint FK_BookCategory_Book_BookID FOREIGN KEY (BookId)
      REFERENCES Book (Id);   

alter table BookCategory add constraint FK_BookCategory_Category_CategoryID FOREIGN KEY (CategoryId)
      REFERENCES Category (Id);   