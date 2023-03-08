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
    AccountNo int not null
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

alter table Membership add constraint FK_Membership_Member_MemberID FOREIGN KEY (Id)
      REFERENCES Member (Id);

alter table Loan add constraint FK_Loan_Member_MemberID FOREIGN KEY (MemberId)
      REFERENCES Member (Id);

alter table Book add constraint FK_Book_Loan_LoanID FOREIGN KEY (LoanId)
      REFERENCES Loan (Id);

alter table BookCategory add constraint FK_BookCategory_Book_BookID FOREIGN KEY (BookId)
      REFERENCES Book (Id);   

alter table BookCategory add constraint FK_BookCategory_Category_CategoryID FOREIGN KEY (CategoryId)
      REFERENCES Category (Id);   


declare @id as uniqueidentifier set @id = newid();

insert into Member values
(@id, 'Luka', 'Agic', '12345678912'),
(newid(), 'Jona', 'Agic', '12345678914'),
(newid(), 'Marija', 'Agic', '12345678913');

insert into Membership (Id, StartDate, AccountNo) values (
@id, '2023-01-01','1234567');

insert into Loan values (newid(), '2023-01-01', @id);

insert into Book values (newId(), 'The road', '1998', 'A83DEF98-2EE4-42E9-906D-CA3783DBF95B');

insert into Category values (newid(), 'Horror');

insert into BookCategory values (newid(), 'EE8668F2-EBD9-471C-8AFC-697B7C99F616', '3CE0933F-0788-4BC6-9761-B4117AC224E8');

select a.title, b.CategoryId , c.ReleaseYear, f.AccountNo 
from Category a
inner join BookCategory b
on a.Id = b.CategoryId
inner join book c
on c.Id = b.BookId
inner join loan d 
on d.Id = c.LoanId
inner join Member e 
on e.Id = d.MemberId
inner join Membership f 
on f.Id = e.Id;