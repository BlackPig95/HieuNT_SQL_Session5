create database examsqlcompany;
use examsqlcompany;
create table Department
(
    Id   int primary key auto_increment,
    Name varchar(100) not null unique check ( char_length(Name) >= 6 )
);
create table Levels
(
    Id              int primary key auto_increment,
    Name            varchar(100) not null unique,
    BasicSalary     float        not null check ( Basicsalary >= 3500000 ),
    AllowanceSalary float default (500000)
);
create table Employee
(
    Id           int primary key auto_increment,
    Name         varchar(150) not null,
    Email        varchar(150) not null unique check (Email REGEXP
                                                     '^[a-zA-Z0-9][+a-zA-Z0-9._-]*@[a-zA-Z0-9][a-zA-Z0-9._-]*[a-zA-Z0-9]*\\.[a-zA-Z]{2,4}$'),
    Phone        varchar(50)  not null unique,
    Address      varchar(255),
    Gender       tinyint      not null check ( Gender in (0, 1, 2) ),
    Birthday     date         not null,
    LevelId      int          not null references Levels (Id),
    DepartmentId int          not null references Department (Id)
);
create table TimeSheet
(
    Id             int primary key auto_increment,
    AttendanceDate date  not null default (curdate()),
    EmployeeId     int   not null references Employee (Id),
    Value          float not null default (1) check ( Value in (0, 0.5, 1) )
);
create table Salary
(
    Id          int primary key auto_increment,
    EmployeeId  int   not null references Employee (Id),
    BonusSalary float default (0),
    Insurance   float not null
);
DELIMITER $$
Create trigger when_insert_into_salary
    BEFORE insert
    on Salary
    for each row
begin
    declare basicSalary int;
    #     select l.BasicSalary into basicSalary
#     from Levels l
#              join Employee E on l.Id = E.LevelId
#     where E.Id
#               = new.EmployeeId;
    set basicSalary = (select l.BasicSalary
                       from Levels l
                                join Employee E on l.Id = E.LevelId
                       where E.Id = new.EmployeeId);
    set new.Insurance = basicSalary * 0.1;
end $$
delimiter ;
# Yêu cầu dữ liệu mẫu ( Sử dụng lệnh SQL để thêm mới ):
# 1.	Bảng Department ít nhất là 3 bản ghi dữ liệu phù hợp
insert into department (Name)
    value ('Marketing dept'),
    ('HR dept'),
    ('IT dept'),
    ('Operation dept'),
    ('Sales dept');
# 2.	Bảng Levels ít nhất là 3 bản ghi dữ liệu phù hợp
insert into Levels (Name, BasicSalary, AllowanceSalary)
VALUES ('Leader', 10000000, 1000000),
       ('Senior', 8000000, 8000000),
       ('Junior', 7000000, 7000000);
insert into Levels (Name, BasicSalary)
VALUES ('Fresher', 4000000);
# 3.	Bảng Employee Ít nhất 15 bản ghi dữ liệu phù hợp
insert into Employee (Name, Email, Phone, Address, Gender, Birthday, LevelId, DepartmentId)
VALUES ('Employee 1', 'email1@gmail.com', 'phone1', 'address1', 1, '1995-2-2', 2, 1),
       ('Employee 2', 'email2@gmail.com', 'phone2', 'address2', 2, '1994-1-1', 3, 2),
       ('Employee 3', 'email3@gmail.com', 'phone3', 'address3', 1, '1995-5-4', 3, 3),
       ('Employee 4', 'email4@gmail.com', 'phone4', 'address4', 2, '1996-12-2', 2, 4),
       ('Employee 5', 'email5@gmail.com', 'phone5', 'address5', 0, '1998-3-7', 4, 5),
       ('Employee 6', 'email6@gmail.com', 'phone6', 'address6', 0, '1990-11-20', 1, 1),
       ('Employee 7', 'email7@gmail.com', 'phone7', 'address7', 2, '1992-4-25', 2, 2),
       ('Employee 8', 'email8@gmail.com', 'phone8', 'address8', 1, '1993-6-4', 1, 3),
       ('Employee 9', 'email9@gmail.com', 'phone9', 'address9', 0, '1996-6-6', 4, 4),
       ('Employee 10', 'email10@gmail.com', 'phone10', 'address10', 0, '1995-5-5', 3, 5),
       ('Employee 11', 'email11@gmail.com', 'phone11', 'address11', 1, '1994-4-3', 4, 1),
       ('Employee 12', 'email12@gmail.com', 'phone12', 'address12', 1, '1993-2-1', 1, 2),
       ('Employee 13', 'email13@gmail.com', 'phone13', 'address13', 1, '1991-2-4', 2, 3),
       ('Employee 14', 'email14@gmail.com', 'phone14', 'address14', 0, '1990-2-2', 4, 4),
       ('Employee 15', 'email15@gmail.com', 'phone15', 'address15', 1, '1995-12-12', 3, 5);
# 4.	Bảng Timesheets ít nhất 30 bản ghi dữ liệu phù hợp
insert into TimeSheet (AttendanceDate, EmployeeId, Value)
VALUES ('2024-3-23', 1, 1),
       ('2024-3-23', 2, 1),
       ('2024-3-23', 3, 0.5),
       ('2024-3-23', 4, 0),
       ('2024-3-23', 5, 1),
       ('2024-3-23', 6, 0.5),
       ('2024-3-23', 7, 0.5),
       ('2024-3-23', 8, 0),
       ('2024-3-23', 9, 0),
       ('2024-3-23', 10, 1),
       ('2024-3-23', 11, 1),
       ('2024-3-23', 12, 1),
       ('2024-3-23', 13, 0.5),
       ('2024-3-23', 14, 1),
       ('2024-3-23', 15, 0.5),
       ('2024-4-24', 1, 0.5),
       ('2024-4-24', 2, 1),
       ('2024-4-24', 3, 1),
       ('2024-4-24', 4, 0),
       ('2024-4-24', 5, 1),
       ('2024-4-24', 6, 0.5),
       ('2024-4-24', 7, 1),
       ('2024-4-24', 8, 1),
       ('2024-4-24', 9, 1),
       ('2024-4-24', 10, 1),
       ('2024-4-24', 11, 0.5),
       ('2024-4-24', 12, 0),
       ('2024-4-24', 13, 1),
       ('2024-4-24', 14, 1),
       ('2024-4-24', 15, 1);
# 5.	Bảng Salary ít nhất 3 bản ghi dữ liệu phù hợp
insert into Salary (EmployeeId, BonusSalary, Insurance)
VALUES (1, 250000, 1000),
       (2, 230000, 1000),
       (3, 170000, 1000),
       (4, 320000, 1000),
       (5, 50000, 1000),
       (6, 550000, 1000),
       (7, 150000, 1000),
       (8, 300000, 1000),
       (9, 225000, 1000),
       (10, 200000, 1000);
# Yêu cầu truy vấn dữ liệu
# Yêu cầu 1 ( Sử dụng lệnh SQL để truy vấn cơ bản ):
# 1.	Lấy ra danh sách Employee có sắp xếp tăng dần theo Name
# gồm các cột sau: Id, Name, Email, Phone, Address, Gender, BirthDay,
# Age, DepartmentName, LevelName
select e.Id,
       e.Name,
       e.Email,
       e.Phone,
       e.Address,
       e.Gender,
       e.Birthday,
       (year(curdate()) - year(e.Birthday)) as age,
       d.Name,
       l.Name
from Employee e
         join Department D on e.DepartmentId = D.Id
         join Levels L on e.LevelId = L.Id
order by e.Name;
# 2.	Lấy ra danh sách Salary gồm:
# Id, EmployeeName, Phone, Email, BaseSalary,  BasicSalary,
# AllowanceSalary, BonusSalary, Insurrance, TotalSalary
select e.id,
       e.Name,
       e.Phone,
       e.Email,
       l.BasicSalary                                                                     as basicsalary,
       l.AllowanceSalary                                                                 as allowance,
       s.BonusSalary                                                                     as bonus,
       s.Insurance                                                                       as insurance,
       (BasicSalary + AllowanceSalary + ifnull(BonusSalary, 0) + coalesce(Insurance, 0)) as totalsalary
from employee e
         left join salary s on s.EmployeeId = e.Id
         join Levels L on e.LevelId = L.Id;
# 3.	Truy vấn danh sách Department gồm: Id, Name, TotalEmployee
select d.Id, d.Name, count(e.DepartmentId)
from Department d
         join Employee E on d.Id = E.DepartmentId
group by e.DepartmentId;
# 4.	Cập nhật cột BonusSalary lên 10% cho tất cả các Nhân viên có
# số ngày công >= 20 ngày trong tháng 10 năm 2020
update salary s
set BonusSalary = 0.1 * (select l.BasicSalary
                         from Levels l
                                  join Employee E on l.Id = E.LevelId
                         where s.EmployeeId = e.Id)
where s.EmployeeId in (select t.EmployeeId
                       from TimeSheet t
                       where t.AttendanceDate between '2024-1-1' and '2024-12-12'
                       group by t.EmployeeId
                       having sum(t.Value) >= 1.5);
# 5.	Truy vấn xóa Phòng ban chưa có nhân viên nào
select d.Id, d.Name
from Department d
where d.Id not in (select de.Id
                   from Department de
                            join Employee E on de.Id = E.DepartmentId);
# Yêu cầu 2 ( Sử dụng lệnh SQL tạo View )
# 1.	View v_getEmployeeInfo thực hiện lấy ra danh sách Employee  gồm:
# Id, Name, Email, Phone, Address, Gender, BirthDay, DepartmentNamr, LevelName,
# Trong đó cột Gender hiển thị như sau:
# a.	0 là nữ
# b.	1 là nam
create view v_getEmployeeInfo
as
select e.id,
       e.Name  as EmployeeName,
       e.Email,
       e.Phone,
       e.Address,
       case e.Gender
           when 1 then 'Nam'
           when 0 then 'Nu'
           end as Gender,
       e.Birthday,
       d.Name  as DepartmentName,
       l.Name     LevelName
from Employee e
         join Department D on e.DepartmentId = D.Id
         join Levels L on e.LevelId = L.Id;
select *
from v_getEmployeeInfo;
# 2.	View v_getEmployeeSalaryMax hiển thị danh sách nhân viên có
# số ngày công trong một tháng bất kỳ > 18 gòm:
# Id, Name, Email, Phone, Birthday, TotalDay
# (TotalDay là tổng số ngày công trong tháng đó)
create view v_getEmployeeSalaryMax
as
select e.id,
       e.name                  employeename,
       e.Email,
       e.Phone,
       e.Birthday,
       count(ts.Value) >= 1 as totalDay
from Employee e
         join TimeSheet TS on e.Id = TS.EmployeeId
where ts.EmployeeId in (select TimeSheet.EmployeeId
                        from timesheet
                        where month(TimeSheet.AttendanceDate) = 3)
group by ts.EmployeeId;

create view v_getEmployeeDayByMonth
as
select e.id,
       e.name                      employeename,
       e.Email,
       e.Phone,
       e.Birthday,
       month(ts.AttendanceDate) as Month,
       sum(ts.EmployeeId) >= 1  as totalDay
from Employee e
         join TimeSheet TS on e.Id = TS.EmployeeId
where ts.EmployeeId in (select TimeSheet.EmployeeId
                        from timesheet
                        where month(TimeSheet.AttendanceDate) >= 1
                          and month(TimeSheet.AttendanceDate) <= 12)
group by ts.EmployeeId, ts.AttendanceDate;
select *
from v_getEmployeeSalaryMax;
select *
from v_getEmployeeDayByMonth;
# Yêu cầu 3 ( Sử dụng lệnh SQL tạo thủ tục Stored Procedure )
# 1.	Thủ tục addEmployeetInfo thực hiện thêm mới nhân viên,
# khi gọi thủ tục truyền đầy đủ các giá trị của bảng Employee
# ( Trừ cột tự động tăng )
DELIMITER $$
create procedure addEmployeetInfo(in newName varchar(150), in newEmail varchar(150),
                                  in newPhone varchar(50), in newAddress varchar(255),
                                  in newGender tinyint, in newdob date,
                                  in newLevelId int, in newDeptId int)
begin
    insert into Employee (Name, Email, Phone, Address, Gender, Birthday, LevelId, DepartmentId)
    VALUES (newName, newEmail, newPhone, newAddress, newGender, newdob, newLevelId, newDeptId);
end $$
DELIMITER ;
call addEmployeetInfo('newEmp', 'newEmpEmail@gmail.com', 'newEmpPhone', 'newEmpAdd', 1, '1999-9-9', 4, 3);
select *
from Employee;
# 2.	Thủ tục getSalaryByEmployeeId hiển thị danh sách các bảng lương
# từng nhân viên theo id của nhân viên gồm:
# Id, EmployeeName, Phone, Email,  BasicSalary, AllowanceSalary,
# BonusSalary, Insurrance, TotalDay, TotalSalary
# (trong đó TotalDay là tổng số ngày công, TotalSalary
# là tổng số lương thực lãnh)
# Khi gọi thủ tục truyền vào id của nhân viên
DELIMITER $$
create procedure getSalaryByEmployeeId(in empId int)
begin
    select e.id,
           e.Name,
           e.Phone,
           e.Email,
           l.BasicSalary,
           l.AllowanceSalary,
           s.BonusSalary,
           s.Insurance,
           count(t.EmployeeId)                as totalday,
           (l.BasicSalary + l.AllowanceSalary
               + s.BonusSalary + s.Insurance) as totalsalary
    from Employee e
             join Salary s on e.Id = s.EmployeeId
             join TimeSheet t on e.Id = t.EmployeeId
             join Levels l on e.LevelId = l.Id
    where e.Id = empId
    group by e.Id, s.BonusSalary, s.Insurance;
end $$
DELIMITER ;
call getSalaryByEmployeeId(6);
# 3.	Thủ tục getEmployeePaginate lấy ra danh sách nhân viên có
# phân trang gồm:
# Id, Name, Email, Phone, Address, Gender, BirthDay,
# Khi gọi thủ tuc truyền vào limit và page
DELIMITER $$
create procedure getEmployeePaginate(in _page int, in _limit int)
begin
    declare offset int;
    set offset = (_page - 1) * _limit;
    select e.id,
           e.name,
           e.Email,
           e.phone,
           e.Address,
           e.Gender,
           e.Birthday
    from Employee e
    limit offset,_limit;
end $$
DELIMITER ;
call getEmployeePaginate(3, 3);
# Yêu cầu 4 ( Sử dụng lệnh SQL tạo Trigger )
# 1.	Tạo trigger tr_Check_ Insurrance_value sao cho khi thêm
# hoặc sửa trên bảng Salary nếu cột Insurrance có giá trị != 10%
# của BasicSalary thì không cho thêm mới hoặc chỉnh sửa và in
# thông báo ‘Giá trị cảu Insurrance phải = 10% của BasicSalary’
create trigger tr_Check_Insurrance_value_before_insert
    before insert
    on salary
    for each row
begin
    declare baseSalary float;
    select BasicSalary
    into baseSalary
    from levels l
             join employee e on l.Id = e.levelId
    where e.Id = NEW.employeeId;
    if baseSalary * 0.1 <> NEW.Insurance then
        signal sqlstate '45000' set message_text = 'Giá trị của Insurance phải = 10% của BasicSalary';
    end if;
end;

insert into salary(employeeId, BonusSalary, Insurance) VALUE (17, 1000000, 10000);


# 2.	Tạo trigger tr_check_basic_salary khi thêm mới hoặc
# chỉnh sửa bảng Levels nếu giá trị cột BasicSalary > 10000000
# thì tự động dưa về giá trị 10000000 và thông báo
# ‘Lương cơ bản không vượt quá 10 triệu’

DELIMITER $$
create trigger tr_check_basic_salary
    before insert
    on levels
    for each row
begin
    declare over_10mil condition for sqlstate '45000';
    declare continue handler for over_10mil
        begin

        end;
    if NEW.BasicSalary > 10000000
    then
        begin
            signal sqlstate '45000' set message_text= '10tr';
            set NEW.BasicSalary = 10000000;
        end;
    end if;
end $$
DELIMITER ;
insert into Levels (Name, BasicSalary)
VALUES ('test5',200000000);