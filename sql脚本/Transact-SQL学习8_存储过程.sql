USE master;
GO --每个被GO分隔的语句都是一个单独的事务，一个语句执行失败不会影响其它语句执行。

DECLARE @max INT,@ctime DATETIME;

SET @max=1;
SET @ctime =' 2018-8-7 17:02:32'
WHILE @max < 10
--BEGIN
	SET @max=@max+1;
	PRINT @max;
--END 


PRINT '终于循环完了'
SELECT @max AS max,@ctime;