--1.创建一个数据库
create database School;

--删除数据库(删除数据库表结构)
drop database School;

--创建数据库的时候，指定一些数据库的相关参数，不如大小，增长方式，文件保存路径
create database School
on primary 
(
	--数据库的逻辑名称
	name='School',
	size=10mb,
	filename='c:\School.mdf',
	filegrowth=10%,
	maxsize=100mb
)
log on --日志文件*.ldf
(
	name='School_log',
	filename='c:\School_log.ldf',
	size=5mb,
	filegrowth=2mb,
	maxsize=50mb
)
--切换数据库
use School --点击F5执行sql语句，先

--=============================为数据库创建表====================
--1.创建一个班级表
create table TblClass
(
	--创建好了一列
	--列名，数据类型，约束(自动编号)
	ClassId int identity(1,1) primary key,
	ClsName Varchar(50) not null,
	ClsDesc Varchar(100)
)

--删除TblClass表
drop table TblClass

--创建一个TblStudent表
create table TblStudent
(
	stuId int identity(1,1)primary key,
	stuName nvarchar(50) not null,
	stuGender bit not null,
	sutAddress varchar(200),
	stuAge int,
	stuBirthday datetime,
	sutIdNumger varchar(20),
	stuChsId int
)
--创建老师表TblTeacher
create table TblTeacher
(
	tid int identity(1,1) primary key,
	tname varchar(50),
	tGender bit default(1),
	tage int,
	tsalary money,
	tbirthday datetime
)
drop table TblTeacher
--===============================插入语句==========================

--通过sql语句向TblClass表中插入数据

insert into TblClass(ClsName,ClsDesc)
values('黑马三期','没有二期牛逼')

--1.最基本的插入
insert into TblTeacher(tname,tgender,tage,tsalary,tbirthday)
values('杨忠科',1,18,10000,'2010-9-9')

--2.只向某些列插入数据
insert into TblTeacher(tname,tsalary)
values('赵晓虎',1)

--3.为自动编号插入数据
set identity_insert TblTeacher on
insert into TblTeacher(tid,tname,tsalary)
values(100,'bob',50000)
set identity_insert TblTeacher off
--insert into ...values 每次只能插入一条

--union关键字本身就具有去掉重复的意思
--union all 就不会去掉重复
insert into TblTeacher
select 'chris',1,20,200000,'1999-9-9' union 
select 'james',1,17,200000,'1999-9-9' union 
select 'tom',1,17,200000,'1999-9-9' 

use school
select *from TblStudent
select *from TblClass
select *from TblTeacher

--将一个表中的数据备份到另一个表中
--将TblTeacher 表中的数据备份到NewTblTeacher
--这种写法会把TblTeacher表中所有数据都插入到NewTblTeacher表中
--前提是NewTblTeacher表不存在，如果这这个表存在则报错
select *into NewTblTeacher from TblTeacher

select *from NewTblTeacher
select *from TblTeacher
--向一个已经存在的表中插入数据，数据的来源是另一张表。
insert into NewTblTeacher(tname,tage)
select tname,tage from TblTeacher

create table t3
(
	autoId int identity(1,1),
	userName varchar(40)
)
 
--修改表，中的列 
alter table t3 alter column userName nvarchar(50)


--============================更新语句=================================

select *from TblTeacher
--将所有年龄小于20岁的人的年龄都改成19
update TblTeacher set tage=19 where tage<20

--将年龄为20岁的人的年龄+1
update TblTeacher set tage=tage+1 where tage=20

--把所有人的工资都改成2000
update TblTeacher set tsalary=2000

--把表中所有的年龄为19岁的同学的姓名两边加上★，性别=女，工资都+500
update TblTeacher set tname='★'+tname+'★',tgender=0,tsalary=tsalary+500
where tage=19

--将年龄为19岁的，并且把性别为0的，人的姓名两边再加两个☆
update TblTeacher set tname= replace(tname,'★','☆')
where tage=19 and tgender=0



--====================删除操作=============================================
--删除一行或多行
delete from TblTeacher where tage=19 or tage is null

--使用delete from 表名 ,与truancate table 表名，都能把表的数据全部删除
--区别
--1.delete 语句删除数据的时候，自动编号没有恢复默认值，但是truancate语句会从新设置自动编号
--2.通过truancate 语句删除表中数据的时候，只能一次性都清空，不能根据条件来删除，而delete可以根据条件来删除
--3.truancate语句清空表中的数据时，速度（性能）比delete语句多的多的的多。


--删除所有数据
delete from TblTeacher






--==============================练习======================
create table UserLogin
(
	Id int identity(1,1) primary key,
	username varchar(50),
	password varchar(50)
)
select *from UserLogin where username='xt' and password='123'

insert into userlogin(username,password)
values('xt','123')
insert into userlogin(username,password)
values('yzk','456')

--=========================增加删除约束============================
--首先创建两个表
create table Employees
(
	EmpId int identity(1,1),
	EmpName varchar(50),
	EmpGender char(2),
	EmpAge int,
	EmpEmail varchar(100),
	EmpAddress varchar(500)
)
create table Department
(
	DepId int identity(1,1),
	DemName varchar(50)
)

--============手动增加约束======================
--手动删除一列(删除EmpAddress列)
alter table Employees drop column EmpAddress

--手动增加一列(增加一列EmpAddr varchar(1000))
alter table Employees add EmpAddr varchar(1000)

--手动修改一下EmpEmail的数据类型(varchar(200))(原本是varchar(1000))
alter table Employees alter column EmpEmail varchar(200)

--为EmpId增加一个主键约束
alter table Employees
add constraint PK_Employees_EmpId primary key(EmpId)

--非空约束,为EmpName增加一个非空约束,修改列为not null
--增加一个非空约束其实就是修改列
alter table Employees
alter column EmpName varchar(50)  not null

--为EmpName增加一个唯一约束
alter table Employees
add constraint UQ_Employees_EmpName unique(EmpName)



--为性别增加一个默认约束,默认为'男'
alter table Employees
add constraint  DF_EmpLoyees_EmpGender default('男')
for EmpGender

--为年龄增加一个检查约束：年龄必须在0-120岁之间,含0与120岁。
alter table Employees 
add constraint CK_Employees_EmpAge
check(EmpAge>=0 and EmpAge<=120)

--增加外键约束,表Employees中有一列EmpDeptId引用TblDepartment表中的EeptId
alter table Employees add DeptId int not null
alter table Department add constraint 
PK_Department_DeptId primary key(DepId)

alter table Employees add constraint
FK_Employees_Department foreign key(DeptId)
references Department(DepId) on delete cascade

--先删除原来的外键 然后on delete cascade 级联删除
alter table Employees drop constraint
FK_Employees_Department

--删除摸个名字的约束

--一条语句删除多个约束，约束名用 逗号隔开
alter table Employees drop constraint
FK_Employees_Department,
CK_Employees_EmpAge,
UQ_Employees_EmpName

--用一条语句为表增加多个约束。
alter table Employees add
constraint UQ_Employees_EmpName unique(EmpName),
constraint CK_Employees_EmpAge check(EmpAge>=0 and EmpAge<=120)





--==========================函数================================
--======================常用函数================================
--getdate() 日期函数
select getdate()
print getdate()
--最大值 最小值
select max(tage) as 最大年龄 from TblTeacher

select min(tage) as 最大年龄 from TblTeacher

--求和
select sum(tage) 总年龄 from TblTeacher

--求平均值
select avg(tage) 平均年龄 from TblTeacher

--记录数(记数)
select count(*) as 总人数  from TblTeacher






--========================数据检索(select查询)===========================

select * from TblTeacher
--查询使用别名
select 
	tid as 教师ID,
	tname as 名字,
	tGender 性别,
	tage 年龄,
	工资=tsalary,
	生日=tbirthday
from TblTeacher

--查询使用升降序
select *from TblTeacher order by tage asc
select *from TblTeacher order by tage desc

--查询显示前5条
select top 5 *from TblTeacher order by tage desc
select top 30 percent *from TblTeacher order by tage desc

--查询并在查询结果里去除重复

select distinct *from TblTeacher

---------------------------带条件查询------------------------
--Select...from...whrer... 和Between...and...在之间(between效率高)
--select  --可理解为查询
	  --列名(这里是你查询想看到并且显示出来的哪些列)
--from  --数据源(表名,子查询结果,视图,...)
--where --条件(筛选一些行) 

select *from TblTeacher
where tage between 18 and 24 and tGender='男'
--推荐使用between...and...
--between 18 and 24 相对于>=18 and <=24

--查询年龄是18 19 20 的所有人
select *from TblTeacher
where tage=18 or tage=19 or tage=20

--可以简化这样写
select *from TblTeacher
where tage in(18,19,20)

------------------------------模糊查询----------------------

--查询出所有姓'赵'的
--通配符%表示:任意多个任意字符
select *from TblTeacher
where tname like '赵%'

--查询所有姓'赵'的，并且名字总字符个数,必须是3个
--通配符_ :表示任意的单个字符。
select *from TblTeacher
where tname like '赵__'
--也可以这样写
select *from TblTeacher
where tname like '赵%' and len(tname)=3

--通配符[],
--[]通配符,表示中括号中的任意个字符，只选一个匹配
--[^]表示出了中括号中的任意单个字符。
--查询名字中含'赵' 或'天'的人的名字
select * from TblTeacher
where tname like '%[赵天]%'

--转义符[]表示里面的内容是普通字符串


--查询出所有不姓赵的
select * from TblTeacher
where tname not like '赵%'


--查询出工资是空值的 所有人
--数据库中的null 其实是在数据库中储存的是unknow 就是不知道的意思
select *from TblTeacher where tsalary is  null
select *from TblTeacher where tsalary is  not null


---------------------------排序----------------------------
--先按工作排序 再按年龄排序，                                                
select * from TblTeacher 
order by  tsalary desc ,tage desc 
--order by后面可以跟表达式，比如
select * from TblTeacher 
order by  tsalary/2 desc ,(tage-9)*2 desc 



-------------------------分组------------------------------------
--统计出男的女的个数
select
	tgender as 性别,
	count(*) as 人数
from TblTeacher 
group by tgender

--having 对组进行筛选 ，组先统计出每个组的个数，然后having
--在进行筛选


------------------------SQL语句的执行顺序----------------------------------
5>…Select 5-1>选择列,5-2>distinct,5-3>top
1>…From 表
2>…Where 条件
3>…Group by 列
4>…Having 筛选条件
6>…Order by 列




--======================类型转换========================================

select 100+'100'

select cast(100 as varchar(10))+'hello'
select convert(varchar(10),100)+'hello'


--------------------------联合--------------------------------------------

union all 
