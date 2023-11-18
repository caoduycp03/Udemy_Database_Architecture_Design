create database UdemyDatabaseSystem

use [UdemyDatabaseSystem]

create table Categories
(
[ID] varchar(4) primary key,
[Name] varchar(100) not null,
Traffic int,
[Desc] varchar(250)
)

create table Specializations
(
[ID] varchar(5) primary key,
[CategoryID] varchar(4) not null foreign key references Categories([ID]),
[Name] varchar(100) not null,
Traffic int,
[Desc] nvarchar(250)
)

create table Courses
(
[ID] varchar(6) primary key,
[SpecializationID] varchar(5) not null foreign key references Specializations([ID]),
[Name] varchar(100) not null,
[BasicContent] varchar(250),
[Language] varchar(10),
[NumberOfStars] smallint,
[NumberOfSubscribers] int,
Price money not null,
Discount float not null,
Requirements varchar(250),
check (Price >= 0 and Discount >=0 and Discount <= Price),
check (0 <= [NumberOfStars] and [NumberOfStars] <= 5)
)

create table Lectures
(
[Number] smallint not null,
CourseID varchar(6) not null foreign key references Courses([ID]),
[Title] varchar(100) not null,
[Type] varchar(10) not null,
[Duration] float,
[Desc] varchar(250),
primary key (Number, CourseID),
check(Duration > 0 and Type in ('Quiz', 'Test', 'Reading', 'Video', 'Article'))
)

create table Instructors
(
[ID] varchar(10) primary key,
[Name] varchar(100) not null,
[Gender] varchar(10) not null,
[Major] varchar(100) not null,
[DoB] date,
Country varchar(25),
[Degree] varchar(250) not null,
[NumberOfStudents] int,
[Email] varchar(50) unique not null,
[Desc] varchar(250),
check ((Gender = 'Male' or Gender = 'Female') and datediff(year, DoB, getDate()) >= 18)
)

create table Students
(
[ID] varchar(10) primary key,
[Name] varchar(100) not null,
[Gender] varchar(10) not null,
[DoB] date,
Country varchar(25),
[Job] varchar(25),
[Email] varchar(50) unique not null,
[Desc] varchar(250),
check ((Gender = 'Male' or Gender = 'Female') and datediff(year, DoB, getDate()) >= 18)
)

create table Forum
(
[TopicID] varchar(10) primary key,
[TopicTitle] varchar(100) not null,
[PostedBy] varchar(10) not null foreign key references Students(ID),
[AnsweredBy] varchar(10) not null foreign key references Instructors(ID),
[Likes] int
)

create table [Certificates]
(
[StudentID] varchar(10) not null foreign key references Students([ID]),
[CourseID] varchar(6) not null foreign key references Courses([ID]),
[CompletionDate] date not null,
primary key(StudentID, CourseID),
check([CompletionDate] <= getDate())
)

create table Instructors_Courses
(
[InstructorID] varchar(10) not null foreign key references Instructors(ID),
[CourseID] varchar(6) not null foreign key references Courses([ID]),
[PublishedDate] date not null,
[LastUpdated] date,
primary key(CourseID, InstructorID),
check([PublishedDate] <= getDate() and [LastUpdated] <= getDate() and [PublishedDate] <= [LastUpdated])
)

create table Instructors_Lectures
(
[InstructorID] varchar(10) not null foreign key references Instructors(ID),
LectureNum smallint not null,
CourseID varchar(6) not null,
[CreatedDate] date,
foreign key (LectureNum, CourseID) references Lectures(Number, CourseID),
primary key(InstructorID, CourseID, LectureNum),
check([CreatedDate] <= getDate())
)

create table Students_Courses
(
[StudentID] varchar(10) not null foreign key references Students([ID]),
[CourseID] varchar(6) not null foreign key references Courses([ID]),
[BillingDate] datetime not null,
[EnrollingDate] datetime not null,
[ExpiredDate] datetime not null,
[AvgMark] numeric(4,2) not null,
[isDone] bit not null,
[StudyHours] float,
check ([BillingDate] <= [EnrollingDate] and [EnrollingDate] < [ExpiredDate] and StudyHours >= 0)
)

create table Students_Lectures
(
[StudentID] varchar(10) not null foreign key references Students([ID]),
LectureNum smallint not null,
CourseID varchar(6) not null,
Mark numeric(4,2) not null,
[isDone] bit not null,
foreign key (LectureNum, CourseID) references Lectures(Number, CourseID),
primary key(StudentID, CourseID, LectureNum)
)


insert Categories(ID, [Name], Traffic, [Desc])
	   values('C1', 'Development', 10254, 'Computer Science'),
			 ('C2', 'Business', 5789, Null),
			 ('C3', 'Finance & Accounting', 3534, Null),
			 ('C4', 'IT & Software', 7684, 'Information Technology, Software, Hardware'),
			 ('C5', 'Office Productivity', 3543, 'Skills for working in office'),
			 ('C6', 'Personal Development', 4567, 'Life skills'),
			 ('C7', 'Health & Fitness', 4571, 'Physical and mental health')


insert Specializations(ID, CategoryID, [Name], Traffic, [Desc])
		values('S1', 'C1', 'Web Development', 1146, Null),
			  ('S2', 'C1', 'Data Sicence', 2321, Null),
		      ('S3', 'C1', 'Mobile Development', 908, Null),
		      ('S4', 'C1', 'Programming Language', 2121, Null),
		      ('S5', 'C1', 'Database Design', 1024, Null),
		      ('S6', 'C1', 'Software Testing', 933, Null),
		      ('S7', 'C1', 'Software Engineering', 1203, Null),
		      ('S8', 'C1', 'Software Development Tools', 322, Null),
		      ('S9', 'C1', 'No-Code Development', 246, Null)

insert Specializations(ID, CategoryID, [Name], Traffic, [Desc])
		values('S10', 'C2', 'Entrepreneurship', 1146, Null),
			  ('S11', 'C2', 'Communication', 1321, Null),
		      ('S12', 'C2', 'Management', 908, Null),
		      ('S13', 'C2', 'Sales', 1121, Null),
		      ('S14', 'C2', 'Business Strategy', 569, Null),
		      ('S15', 'C2', 'Operations', 724, Null)

insert Specializations(ID, CategoryID, [Name], Traffic, [Desc])
		values('S16', 'C3', 'Accounting & Bookkeeping', 973, Null),
			  ('S17', 'C3', 'Compliance', 1032, Null),
		      ('S18', 'C3', 'Cryptocurrency & Blockchain', 1908, Null)

insert Specializations(ID, CategoryID, [Name], Traffic, [Desc])
		values('S19', 'C4', 'IT Certifications', 373, Null),
			  ('S20', 'C4', 'Network & Security', 2032, Null),
		      ('S21', 'C4', 'Hardware', 1972, Null)

insert Specializations(ID, CategoryID, [Name], Traffic, [Desc])
		values('S22', 'C5', 'Microsoft', 2373, Null),
			  ('S23', 'C5', 'Apple', 2031, Null),
		      ('S24', 'C5', 'Google', 1970, Null)

insert Specializations(ID, CategoryID, [Name], Traffic, [Desc])
		values('S25', 'C6', 'Personal Transformation', 2373, Null),
			  ('S26', 'C6', 'Personal Productivity', 2031, Null),
		      ('S27', 'C6', 'Leadership', 1970, Null)

insert Specializations(ID, CategoryID, [Name], Traffic, [Desc])
		values('S28', 'C7', 'Fitness', 1243, Null),
			  ('S29', 'C7', 'Mental Health', 2035, Null),
		      ('S30', 'C7', 'Dance', 3970, Null)

insert Courses(ID, SpecializationID, [Name], BasicContent, [Language], NumberOfStars, NumberOfSubscribers, Price, Discount, Requirements)
		values('CO1', 'S1', 'The Web3 Rust Course - NEAR Smart Contracts Web Development', 
				'The Officially Partnered Industry Intro Certified NEAR Protocol Web Development Course from Zero to Certificate', 'English', 
				5, 1875, 84.99, 0.8, Null),
			  ('CO7', 'S27', 'Charisma: You Can Develop Charisma', 
				'Charisma - You can learn to speak like a Charismatic leadere', 'English', 
				4, 987, 94.99, 0.8, Null),
			  ('CO23', 'S30', 'Shuffle Dance Master Class Vol 1. | How to Shuffle Dance', 
				'The step-by-step system for learning how to Shuffle dance (Cutting Shapes, EDM Dancing)', 'English', 
				3, 1875, 49.99, 0.64, Null),
			  ('CO19', 'S1', 'Road to Blockchain', 
				'The Officially Partnered Industry Intro Certified NEAR Protocol Web Development Course from Zero to Certificate', 'English', 
	           5, 1875, 84.99, 0.8, Null),
			  ('CO108', 'S1', 'Road to Blockchain', 
				'The Officially Partnered Industry Intro Certified NEAR Protocol Web Development Course from Zero to Certificate', 'English', 
	           5, 1875, 84.99, 0.8, Null)

delete Courses
insert Instructors(ID, [Name], Gender, Major, [DoB], Country, Degree, NumberOfStudents, Email, [Desc])
		values('I1', 'Iana Komarnytska', 'Female', 'Belly Dancer', '1970-12-12', 'Canada', 'Professional Dance', 1794, 'consectetuer.ipsum@protonmail.com',
		'Iana Komarnytska is an award-winning dancer and choreographer based between Canada & Ukraine'),
			  ('I2', 'Jose Portilla', 'Male', 'Head of Data Science at Pierian Training', '1976-9-12', 'US', 'BS and MS in Mechanical Engineering from Santa Clara University',
			   3095167, 'ridiculus.mus@aol.net', 'Udemy Instructor Partner'),
			  ('I3', 'Lawrence M. Miller', 'Male', 'Institute for Leadership Excellence', '1965-12-22', 'US', 'Best Selling Instructor, Author & Leadership Coach',
			   225167, 'sed.turpis.nec@aol.org', 'Udemy Instructor Partner'),
			  ('I4', 'Kyle Pew', 'Male', 'Microsoft Certified Trainer - 1 Million+ Students', '1970-6-30', 'US', 'Microsoft Certified Trainer (MCT) and a certified Microsoft Office Master Instructor',
			   1368331, 'ut@yahoo.net', 'Udemy Instructor Partner'),
			  ('I5', 'Dr. Peter Dalmaris', 'Male', 'Educator, electrical engineer, electronics hobbyist, and Maker', '1969-8-12', 'US', 'Educator and Author of "Maker Education Revolution',
			   115862, 'sapien.molestie@hotmail.couk', Null)

insert Students([ID], [Name], [Gender], [DoB], Country, [Job], [Email], [Desc])
 values
  ('ST1','Todd Mccarthy', 'Male', '1997-9-12', 'China', 'Database Administrator I' ,'nullam.nisl.maecenas@yahoo.couk', null),
  ('ST2', 'Noah Bishop', 'Male', '1972-9-12', 'Netherlands','Engineer I', 'feugiat.metus@yahoo.ca', null),
  ('ST3', 'Fritz Shepherd', 'Male', '1996-9-12', 'Poland', 'Media Manager IV', 'arcu@google.couk', null),
  ('ST4', 'Tatum Pace', 'Male', '1970-9-12','Pakistan', 'Electrical Engineer', 'sed.eget@aol.couk', null),
  ('ST5', 'Drake Erickson', 'Male', '1965-9-12','Vietnam', 'Editor', 'donec.non.justo@protonmail.com', null),
  ('ST6', 'Brent Sampson', 'Male', '1965-9-12','United States', 'Software Engineer I' ,'lorem.tristique@outlook.edu', null),
  ('ST7', 'Uma Lane', 'Female', '2002-9-12','Netherlands', 'Accountant III', 'velit.cras@outlook.couk', null),
  ('ST8', 'Louis Chandler', 'Male', '2001-9-12', 'South Korea','Senior Developer' ,'eu@google.edu', null),
  ('ST9', 'Hiroko Vance', 'Female', '1989-9-12','Italy','Chief Design Engineer','magna.nec@outlook.ca', null),
  ('ST10','Kenyon Munoz', 'Male', '1998-9-12','Pakistan', 'Project Manager','sem.eget@yahoo.net', null);

delete Students_Courses
insert Students_Courses([StudentID],[CourseID],[BillingDate],[EnrollingDate],[ExpiredDate],[AvgMark],[isDone],[StudyHours])
VALUES
  ('ST1','CO1','2020-08-21','2022-01-08','2023-01-06', 9.8, 1, 13),
  ('ST2','CO3','2020-05-17','2022-01-22','2023-02-24', 6.8, 1, 2 ),
  ('ST3','CO2','2021-12-21','2022-07-08','2023-03-13', 5.7, 1, 3),
  ('ST4','CO3','2021-09-04','2022-09-22','2023-08-20', 7.2,1, 12),
  ('ST5','CO1','2020-11-14','2022-04-10','2023-01-30', 5.5,1, 5),
  ('ST6','CO3','2020-02-17','2022-04-29','2023-09-30', 3.7,1, 6),
  ('ST7','CO2','2020-11-27','2022-07-23','2023-09-15', 2.8,1, 1),
  ('ST8','CO3','2021-08-05','2022-04-28','2023-01-15', 9.6,1, 4),
  ('ST9','CO1','2020-04-27','2022-10-21','2023-08-04', 6.5,1, 5),
  ('ST10','CO2','2020-11-13','2022-09-03','2023-09-22', 7.8,1, 8);

insert Forum(TopicID, TopicTitle, PostedBy, [AnsweredBy], [Likes])
values('F3', 'Maybe the best forum with the best UI for the best learning community!', 'ST1', 'I3', 2546),
('F9', 'I didn’t received payment even the expected payment date has passed', 'ST3', 'I4', 2546),
('F2', 'I didn’t received payment even the expected payment date has passed','ST3', 'I4', 1234)

insert [Certificates] ([StudentID], [CourseID], [CompletionDate])
values('ST1' , 'CO1', '2022-05-08'),
	  ('ST1', 'CO7', '2022-07-23'),
	  ('ST1', 'CO23', '2021-12-11')
