-- 1. Queries using order by
-- xếp hạng những giáo viên có nhiều học sinh nhất
select * from Instructors
order by NumberOfStudents desc

-- 2. Queries using Inner Join
-- tìm ra specialization của các course
select C.ID [CourseID], C.[Name] [Course_Name], C.SpecializationID, S.[Name] [Specialization_Name]
from Courses C inner join Specializations S
on C.SpecializationID = S.ID

-- 3. Queries using aggregate functions
-- Tìm ra các học sinh trên 40 tuổi
select * from Students
where DATEDIFF(year, DoB, GETDATE()) >= 40

-- 4. Queries using GROUP BY and HAVING clauses
-- Đếm số học sinh đến từ Vietnam
select Country, [NumberOfStudents] = 4
from Students
group by Country
having Country = 'Vietnam'

-- Đếm số lượng Courses trong 1 specialization và specialization có số lưu lượng truy cập >= 2000 (theo udemy, specialization luôn có ít nhất 1 course)
select S.ID [SpecializationID], S.[Name] [Specialization_Name], [NumberOfCourses] = 
	case when count(C.ID) is null then 0
		else count(C.ID) end,
	Traffic, S.[Desc]
from Specializations S left outer join Courses C
on S.ID = C.SpecializationID
group by S.ID, S.[Name], Traffic, S.[Desc]
having Traffic >= 2100

-- 5. Queries that use sub – queries as relation
-- Tìm ra 5 người có điểm cao nhất và 5 người có điểm thấp nhất

with S as(
select top 5 StudentID, [Name], AvgMark
from Students S, Students_Courses C
where S.ID = C.StudentID
order by AvgMark desc), 

R as(
select top 5 StudentID, [Name], AvgMark
from Students S, Students_Courses C
where S.ID = C.StudentID
order by AvgMark)

select * from (select * from S union select * from R) M
order by AvgMark desc

-- 6. A query that uses a sub-query in the WHERE clause
-- Tìm những topic có nhiều lượt like nhất

select * from Forum
where Likes = (select top 1 Likes from Forum order by Likes desc)

-- Tìm ra Course có nhiều học sinh nhất, nếu bằng thì xếp theo số sao
select ID, [Name], BasicContent, NumberOfSubscribers, NumberOfStars, Price, Discount
from Courses
where NumberOfSubscribers = (select top 1 NumberOfSubscribers from Courses)
order by NumberOfStars desc

-- 7. Queries that use partial matching in the WHERE clause:
-- tìm những topic có chứa chữ 'Dance' hoặc 'dance'
select * from Courses
where [Name] like '%Dance%' or [Name] like '%dance%'

-- 8. Queries that use self-join:
-- Tìm những course khác nhau có tên giống nhau
select C1.ID [Course1_ID], C2.ID [Course2_ID], C1.[Name] [Duplicate_name]
from Courses C1, Courses C2
where C1.[Name] = C2.[Name] and C1.ID != C2.ID