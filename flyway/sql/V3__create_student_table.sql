CREATE TABLE student(
    id INT AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    blood_group CHAR(4),
    address VARCHAR(255) NOT NULL,
    school_id INT NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY email (email),
    CONSTRAINT fk_school_id_student FOREIGN KEY (school_id) REFERENCES school(id)
);