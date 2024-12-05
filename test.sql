drop database schoolmanagement_db;
create database schoolmanagement_db;

select school.id as school_id,
    school.name as school_name,
    school.address as school_address,
     teacher.id as teacher_id,
     teacher.name as teacher_name,
     teacher.email as teacher_email,
     teacher.blood_group as teacher_blood_group,
     teacher.address as teacher_address,
     student.id as student_id,
     student.name as student_name,
     student.email as student_email,
     student.address as student_address,
     student.blood_group as student_bloodgroup
from school
inner join teacher
on school.id = teacher.school_id and teacher.id = 1
inner join student
on school.id = student.school_id;

-- SELECT 
--     school.id as school_id,
--     school.name as school_name,
--     school.address as school_address,
--     teacher.id AS teacher_id, 
--     teacher.name AS teacher_name, 
--     student.id AS student_id, 
--     student.name AS student_name
-- FROM school
-- LEFT JOIN teacher
-- ON school.id = teacher.school_id
-- LEFT JOIN student
-- ON school.id = student.school_id;