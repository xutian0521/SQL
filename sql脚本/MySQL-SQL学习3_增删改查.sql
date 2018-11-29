USE Test; --使用Test库
SELECT * FROM Person;  --查询所有记录

INSERT INTO Person(LastName, Age) VALUES('zs', 18); 
INSERT INTO Person(LastName, Age) VALUES('ls', 20);


UPDATE Person set LastName='ls_',age='25' WHERE Id=1; --更新

DELETE FROM Person WHERE Id=2; --删除