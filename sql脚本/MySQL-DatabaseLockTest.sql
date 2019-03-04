-- 测试表
CREATE TABLE `Person` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `LastName` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT 'lastname',
  `Age` int(11) NOT NULL,
  `Descr` varchar(150) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`Id`)
) 

--------------------------------------------------------------------------共享锁----------------------------------------------------------------
-- ####【务测试法】 粒度 [行级] (行锁)
-- 当前行被加共享锁 与其他锁直接是否冲突
use Test;
start transaction;
a.> SELECT * FROM Person WHERE Id=3; --相当于nolock
b.> SELECT * FROM Person WHERE Id=3 LOCK IN SHARE MODE;  --加共享锁


--******
-- ####【务测试法】 粒度 [表级] (表锁)
-- 当前行被加共享锁 与其他锁直接是否冲突
use Test;
start transaction;
c.> SELECT * FROM Person WHERE LastName ='ls'; --相当于nolock
d.> SELECT * FROM Person WHERE LastName ='ls' LOCK IN SHARE MOD


--******
-----------------------------------------------------------
-- 另一个窗口测试 锁是否冲突
use Test;
SELECT * FROM Person WHERE Id=3 ; --a.> YES b.>YES c.> YES d.> YES
SELECT * FROM Person WHERE Id=3 FOR UPDATE;  --a.> YES b.> 冲突  c.> YES d.> 冲突
SELECT * FROM Person WHERE Id=3 LOCK IN SHARE MODE;  --a.> YES b.>YES  c.> YES d.> YES

UPDATE Person  SET Age=71 WHERE Id =3; --a.> YES b.>冲突 c.> YES d.> 冲突
INSERT INTO Person(Id,LastName,Age) VALUES(1,'testName',51); --a.> YES b.>冲突 c.> YES d.> 冲突
DELETE FROM Person WHERE Id =1; --a.> YES b.>冲突 c.> YES d.> 冲突


--------------------------------------------------------------------------排它锁----------------------------------------------------------------

-- ####【务测试法】 粒度 [行级]
-- 当前行被加排它锁 与其他锁直接是否冲突
use Test;
start transaction;
a.> UPDATE Person  SET Age=71 WHERE Id =3; 
    INSERT INTO Person(Id,LastName,Age) VALUES(1,'testName',51);
    DELETE FROM Person WHERE Id =1;

--******
-- ####【务测试法】 粒度 [表级] (表锁)
-- 当前行被加共享锁 与其他锁直接是否冲突
use Test;
start transaction;
b.> UPDATE Person  SET Age=71 WHERE LastName ='ls'; 
--******

-----------------------------------------------------------
-- 另一个窗口测试 锁是否冲突
use Test;
SELECT * FROM Person WHERE Id=3 ; --a.> YES b.> YES
SELECT * FROM Person WHERE Id=3 FOR UPDATE;  --a.> 冲突 b.> 冲突 
SELECT * FROM Person WHERE Id=3 LOCK IN SHARE MODE;  --a.> 冲突 b.> 冲突

UPDATE Person  SET Age=71 WHERE Id =3; --a.> 冲突 b.> 冲突
INSERT INTO Person(Id,LastName,Age) VALUES(1,'testName',51); --a.> 冲突 b.> 冲突
DELETE FROM Person WHERE Id =1; --a.> 冲突 b.> 冲突


-- 需要用到的一些查询

select @@tx_isolation --查看当前事物隔离级别
set session transaction isolation level --设置事务隔离级别
show status like 'Table%';--查看表锁
show OPEN TABLES where In_use > 0; --查看正在被锁定的的表
show status like 'innodb_row_lock%'; --查看行锁