SELECT NOW(); -- 获得当前日期+时间（date + time）函数

SHOW DATABASES; -- 查询所有数据库
SELECT DATABASE();  -- 显示当前数据库

use LittleSexy; --使用当前数据库

SHOW TABLES; -- 显示所有表

SELECT * FROM t_User;

SELECT * FROM t_Page;

USE Test;
show variables like 'char%'; -- 查看数据库的编码格式
show variables like 'character_set_database'; -- 查看当前数据库编码
show variables like 'collation%'; -- 查看数据库的排序规则


show create table tablename; -- 查看字段的排序规则
SHOW FULL COLUMNS FROM tablename; -- 查看字段编码