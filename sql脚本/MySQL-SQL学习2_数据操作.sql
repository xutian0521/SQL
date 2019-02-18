DROP DATABASE Test; -- 删除数据库
CREATE DATABASE Test CHARACTER SET utf8 COLLATE utf8_bin; -- 创建数据库 character set 字符集, collate 校对
ALTER DATABASE Test CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'; -- 修改数据库

use Test;
CREATE TABLE Person -- 创建表
(
     Id int  not NULL AUTO_INCREMENT comment '主键', PRIMARY KEY(Id),
     LastName VARCHAR(200) comment '姓',
     FirstName VARCHAR(150) NOT NULL DEFAULT '',
     Age int(0) null 
);
-- 修改表(修改已有字段，新增字段)
alter table Person modify column Id bigint not NULL AUTO_INCREMENT comment '主键', PRIMARY KEY(Id);
alter table Person add column Descr varchar(500) null comment '描述';
(##ALTER TABLE t_Movie ADD `Remark` VARCHAR(500) NULL;)
-- 修改表(删除一个字段)
ALTER TABLE `Test`.`Person` DROP COLUMN `FirstName`;
-- 删除表
drop table Person;
rename table Person to PersonNew; --重命名表名
alter table Person change Id IdNew; -- 重命名表字段  需要把以前定义的类型再写一遍
(##ALTER TABLE t_Movie CHANGE `Src` `Source` varchar(500) COLLATE utf8_bin DEFAULT NULL;)

desc Person; --显示表结构
show create TABLE Person; --显示表结构创建的sql语句
select database(); -- 显示当前使用的数据库

