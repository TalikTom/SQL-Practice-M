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
   Title varchar(255) not null
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


/* declaring member id's */

declare @luka as uniqueidentifier set @luka = newid();
declare @marija as uniqueidentifier set @marija = newid();
declare @jona as uniqueidentifier set @jona = newid();


/* declaring genre id's */

declare @horror as uniqueidentifier set @horror = newid();
declare @classics as uniqueidentifier set @classics = newid();
declare @fantasy as uniqueidentifier set @fantasy = newid();
declare @humor as uniqueidentifier set @humor = newid();
declare @satire as uniqueidentifier set @satire = newid();
declare @adventure as uniqueidentifier set @adventure = newid();
declare @crime as uniqueidentifier set @crime = newid();
declare @science as uniqueidentifier set @science = newid();
declare @mystery as uniqueidentifier set @mystery = newid();
declare @historical as uniqueidentifier set @historical = newid();



/* populating Member tables */

insert into Member values
(@luka, 'Luka', 'Agic', '12345678912'),
(@marija, 'Jona', 'Agic', '12345678914'),
(@jona, 'Marija', 'Agic', '12345678913');



/* populating Membership tables */

insert into Membership (Id, StartDate, AccountNo) values 
(@luka, '2023-01-01','1234567'),
(@marija, '2021-01-01','1234564'),
(@jona, '2022-01-01','1234562');



/* populating Loan tables */

insert into Loan values 
(newid(), '2023-01-01', @luka),
(newid(), '2023-01-01', @marija),
(newid(), '2023-01-01', @jona);



/* populating Book tables */

insert into Book values 
(newId(), 'The road', '1998', 'A83DEF98-2EE4-42E9-906D-CA3783DBF95B'),
(newId(), 'The Adventures of Tom Sawyer', '1978', 'A83DEF98-2EE4-42E9-906D-CA3783DBF95B'),
(newId(), 'Lord of the rings', '1990', 'A83DEF98-2EE4-42E9-906D-CA3783DBF95B'),
(newId(), 'The Hitchhikers Guide to the Galaxy', '1980', 'A83DEF98-2EE4-42E9-906D-CA3783DBF95B'),
(newId(), 'Don Quijote', '1955', 'A83DEF98-2EE4-42E9-906D-CA3783DBF95B'),
(newId(), 'Moby-Dick', '1998', 'A83DEF98-2EE4-42E9-906D-CA3783DBF95B'),
(newId(), 'Partners in Crime', '1929', 'A83DEF98-2EE4-42E9-906D-CA3783DBF95B'),
(newId(), '1984', '1984', 'A83DEF98-2EE4-42E9-906D-CA3783DBF95B'),
(newId(), 'Sherlock Holmes', '1950', 'A83DEF98-2EE4-42E9-906D-CA3783DBF95B'),
(newId(), 'The Art of War', '1950', 'A83DEF98-2EE4-42E9-906D-CA3783DBF95B');



/* populating Category tables */

insert into Category values 
(@horror, 'Horror'),
(@classics, 'Classics'),
(@fantasy, 'Fantasy'),
(@humor, 'Humor'),
(@satire, 'Satire'),
(@adventure, 'Adventure'),
(@crime, 'Crime'),
(@science, 'Science fiction'),
(@mystery, 'Mystery'),
(@history, 'History');



/* populating BookCategory tables */

insert into BookCategory values 
(newid(), (SELECT "Id" FROM "Book" WHERE "Title" = 'The Road'), @horror),
(newid(), (SELECT "Id" FROM "Book" WHERE "Title" = 'The Adventures of Tom Sawyer'), @classics),
(newid(), (SELECT "Id" FROM "Book" WHERE "Title" = 'Lord of the rings'), @fantasy),
(newid(), (SELECT "Id" FROM "Book" WHERE "Title" = 'The Hitchhikers Guide to the Galaxy'), @humor),
(newid(), (SELECT "Id" FROM "Book" WHERE "Title" = 'Don Quijote'), @satire),
(newid(), (SELECT "Id" FROM "Book" WHERE "Title" = 'Moby-Dick'), @adventure),
(newid(), (SELECT "Id" FROM "Book" WHERE "Title" = 'Partners in Crime'), @crime),
(newid(), (SELECT "Id" FROM "Book" WHERE "Title" = '1984'), @science),
(newid(), (SELECT "Id" FROM "Book" WHERE "Title" = 'Sherlock Holmes'), @mystery),
(newid(), (SELECT "Id" FROM "Book" WHERE "Title" = 'The Art of War'), @history);


/*********************************/
/* Read */

/* practice joins */

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
on f.Id = e.Id
where e.Id = @luka and e.EndDate is not null
order by a.Title, c.ReleaseYear;


select a.AccountNo, b.FirstName
from Membership a
full outer join Member b
on a.Id = b.Id
where b.FirstName like 'Luka%'
order by b.FirstName;

SELECT TOP 1 "StartDate" FROM membership  
ORDER BY "StartDate" DESC; 

/* Update */

UPDATE "Book"
SET "Title" = 'The Origin of Species'
WHERE "Title" = '1984';

UPDATE "Category"
SET "Title" = 'Horour'
WHERE Id = @horror;

/* Delete */

DELETE FROM Category; /* deletes everything from a table, if not constrained */

DELETE FROM Member WHERE Id= @luka;


/*********************************/
/* Aggregate functions */

SELECT title, COUNT() as NumberOfCategories
FROM Category 
GROUP BY Title;

/* Count distinct categories in comparison to book containing Love in the title */

SELECT COUNT(distinct title) FROM Category a
INNER JOIN BookCategory b 
ON a.Id = b.CategoryId
INNER JOIN Book c
ON b.BookId = c.Id
WHERE b.Title like 'Love%';


/*********************************/

/* View practice */

/* Create view that selects the title of the book with the first name and last name of the person who borrowed the book */

CREATE VIEW person_book 
AS   
SELECT CONCAT_WS(' ' , m.FirstName, m.LastName) full_name, b.Title, c.Title, CURRENT_TIMESTAMP as "CurrentTime"
FROM Member m  
inner join Loan l 
ON m.Id = l.MemberId  
inner join Book b 
ON l.Id = b.LoanId
inner join BookCategory bc 
ON bc.BookId = b.Id
inner join Category c
on bc.CategoryId = c.Id
ORDER BY m.FirstName;


/* Create view that selects horror category books */

CREATE VIEW horror_books
AS   
SELECT b.Title, c.Title
FROM Book b 
inner join BookCategory bc 
ON bc.BookId = b.Id
inner join Category c
on bc.CategoryId = c.Id
WHERE c.Title = 'Horror';


/*********************************/
/* Testing SQL functions */


SELECT LOWER(Member.FirstName) AS LowercaseMemberName
FROM Member

UPDATE member
SET 
    FirstName = LOWER(FirstName);

/* SELECT average release year */

SELECT AVG(book.ReleaseYear) AS AverageReleaseYear FROM Book;

/* Custom function, returns preset value when called, input: book category */

CREATE FUNCTION whichBook
(@Category nvarchar(15))
RETURNS varchar(30)
AS
BEGIN
declare @Return varchar(30)
select @return = case @Category
when 'Horror' then 'It'
when 'Adventure' then 'The Adventures of Tom Sawyer'
when 'Satire' then 'Don Quijote'
when 'Advanture' then 'Moby-Dick'
else 'Unknown'
end
return @return
end

print dbo.whichBook('Adventure')

