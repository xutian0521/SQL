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
alter table Person modify column Id bigint not NULL AUTO_INCREMENT comment '主键', PRIMARY KEY(Id), add column Descr varchar(500) null comment '描述';
-- 修改表(删除一个字段)
ALTER TABLE `Test`.`Person` DROP COLUMN `FirstName`;
-- 删除表
drop table Person;

