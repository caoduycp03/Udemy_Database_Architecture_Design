--	Nhập tên học sinh để trả về mọi chứng chỉ mà họ có
create procedure sp_Certificate (@studentID varchar(10))
as
begin
select CourseID, Courses.[Name] [Course_Name], Specializations.[Name] [Specialization], Categories.[Name] [Category], CompletionDate
from Certificates, Courses, Specializations, Categories
where StudentID = @studentID and CourseID = Courses.ID and SpecializationID = Specializations.ID and CategoryID = Categories.ID
end
