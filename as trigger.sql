-- Tự động cập nhật điểm trung bình
create trigger tg_AvgMark on Students_Lectures
after insert, delete, update
as
begin
update Students_Courses
set AvgMark = (select avg(Mark) from Students_Lectures
			   where Students_Courses.StudentID = StudentID
			   and Students_Courses.CourseID = CourseID
			   group by StudentID, CourseID)
where StudentID in (select StudentID from inserted union select StudentID from deleted)
end