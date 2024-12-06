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

select database();

show tables;

desc school;
desc student;
select upper(name) from student;
select curtime();
select current_timestamp();
select current_time();
select current_date();
select cast(101 as binary);
select cast(101 as decimal(4,1));
select cast(110 as date);
select convert(110 , date);

select name,max(id) as sum from student group by name;
select max(id) from student;
select * from student order by id desc;
select * from student order by name;
select * from student having blood_group='B+';
select name,blood_group,email from student having blood_group='B+';
select * from student where blood_group in (select blood_group from student WHERE blood_group='B+');

select if(1>5,'I am Kalees','I am not Kalees')

select ifnull(10,null);

select ifnull(null,64);

select name,
    case
        when blood_group = 'B+' then 'I have B positive bloodgroup'
        when blood_group = 'A+' theN 'I have A positive bloodgroup'
        else 'i am not have B or A bloodgroup'
    end as my_blood
from student;

delimiter $$

create procedure hi_kalees()
begin
    select('Hii Kalees');
end$$

delimiter;


call hi_kalees();

delimiter $$

create procedure msg()
begin
    select 'Hii I am Kalees' as message ;
end$$

delimiter;

call msg();

delimiter $$
create procedure arg_pr(in name varchar(255))
BEGIN
    select concat('Hii ',name,' !');
END $$
delimiter;

call arg_pr('Kalees');

delimiter $$
create procedure addNums(in a int, in b int, out c int)
begin
set c = a + b;
END $$
delimiter;

set @a = 50;
set @b = 11;
call addNums(@a,@b,@c);
select @c;

show procedure status where Db='schoolmanagement_db';

show create procedure msg;

drop procedure hi_kalees;

show procedure status;

show create procedure arg_pr;

delimiter $$
create procedure mul_table(in num int)
BEGIN
declare i int default 1;
while i <=10 DO
select concat(i,' x ',num,' = ',num*i);
set i = i+1;
end WHILE;
end $$
delimiter;

call mul_table(5);

drop procedure mul_table;

delimiter $$
create procedure show_tables()
BEGIN
select * from student;
select * from school;
select * from teacher;
end $$
delimiter;
call show_tables();

alter table student auto_increment = 10;

insert into student(name,email,blood_group,address,school_id) values ('Ganesh','ganesh@gmail.com','O+','Viruthunagar',1);

create table example1(
    id int auto_increment,
    name varchar(255),
    primary key (id)
)

alter table example1 auto_increment = 100;

insert into example1(name) values ('Kaleeswaran');

select * from example1;

delimiter $$
create function square(num int)
returns int
DETERMINISTIC
BEGIN
return num * num;
end $$
delimiter;

select square(5);


create table accounts(
    acc_id int auto_increment,
    name varchar(255) not null,
    balance decimal(10,2) not null,
    primary key (acc_id)
)

alter table accounts auto_increment = 101;

insert into accounts(name,balance) values ('kalees',1000),('arun',1200);

delimiter $$
create function addMoney(amount int,user_id int)
returns INT
DETERMINISTIC
BEGIN
update accounts set balance = balance + amount where acc_id = user_id;
return 1;
end $$
delimiter;

delimiter $$
create function subMoney(amount int,user_id int)
returns INT
DETERMINISTIC
BEGIN
update accounts set balance = balance - amount where acc_id = user_id;
return 1;
end $$
delimiter;

start TRANSACTION;

select addMoney(500,101);
select subMoney(500,102);
select * from accounts;

commit;
rollback;

delimiter $$
create procedure sendMoney(in sender int, in receiver int, in amount int)
BEGIN
start TRANSACTION;
select subMoney(amount,sender);
select addMoney(amount,receiver);
select * from accounts where acc_id in (sender,receiver);
commit;
end $$
delimiter;

drop procedure sendMoney;

call sendMoney(102,101,1000);

set @msg = (select square(5));

select @msg;

select square(4) into @num;
select @num;

delimiter $$
create function getBalance(user_id int)
returns decimal(10,2)
DETERMINISTIC
BEGIN
set @balance = (select balance from accounts where acc_id = user_id);
return @balance;
end $$
delimiter;

select getBalance(10);
select getBalance(102);


create table student_log(
    id int auto_increment,
    log_msg varchar(255) not null,
    primary key(id)
)

alter table student_log auto_increment=1001;

delimiter $$
create trigger trigger_1
after insert on student
for each row 
BEGIN
insert into student_log(log_msg) values (concat('New student ',NEW.name,' added with the id of ',NEW.id)) ;
end $$
delimiter;

insert into student(name,email,blood_group,address,school_id) values ('Kumar','kumar@gmail.com','B+','Tenkasi',1);
insert into student(name,email,blood_group,address,school_id) values ('Ganesh Pandian','ganeshpandian@gmail.com','O+','Viruthunagar',1);

drop trigger trigger_1;

create view student_info AS
select id as STUDENT_ID,name as STUDENT_NAME,email as STUDENT_EMAIL from student;

select * from student_info;

drop view student_info;

select user,host from mysql.user;

declare outputemail varchar(255) default '';

declare emailcursor cursor for select email from student;

open emailcursor;

fetch emailcursor into outputemail;

select outputemail;

explain select * from student;

mysqldump -u root -p schoolmanagement_db > backup_db.sql;