USE master;
GO
--查询所有数据库
select * from sys.sysdatabases;
--读取库中的所有表名
select * from sysobjects where xtype='U'; --xtype='U':表示所有用户表，xtype='S':表示所有系统表。

--读取指定表的所有列名
select name from syscolumns where id=(select max(id) from sysobjects where xtype='u' and name='spt_monitor');