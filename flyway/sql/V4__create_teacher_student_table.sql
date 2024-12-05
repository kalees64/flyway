CREATE TABLE teacher_student(
    teacher_id INT NOT NULL,
    student_id INT NOT NULL,
    CONSTRAINT fk_teacher_id FOREIGN KEY (teacher_id) REFERENCES teacher(id),
    CONSTRAINT fk_student_id FOREIGN KEY (student_id) REFERENCES student(id)
);