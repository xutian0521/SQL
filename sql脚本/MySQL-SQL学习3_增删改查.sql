USE Test; --使用Test库
SELECT * FROM Person;  --查询所有记录

--插入
INSERT INTO Person(LastName, Age) VALUES('zs', 18); 
INSERT INTO Person(LastName, Age) VALUES('ls', 20);
(##INSERT INTO t_Movie(Title,FanHao,Source,Cover,CreateTime) VALUES('电影2','HQ-456','http://192.168.2.100/','2.jpg','2019-1-15 16:56:58');)

--更新
UPDATE Person set LastName='ls_',age='25' WHERE Id=1;

--删除
DELETE FROM Person WHERE Id=2; 