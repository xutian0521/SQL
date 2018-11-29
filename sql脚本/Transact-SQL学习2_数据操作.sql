------------------------------------------创建数据库----------------------------------------------------

USE master;
CREATE DATABASE [Test]
ON

GO
ALTER DATABASE [Test] COLLATE Chinese_PRC_CI_AS
GO

ALTER DATABASE [Test] SET RECOVERY FULL
GO

ALTER DATABASE [Test] SET COMPATIBILITY_LEVEL = 120
GO

EXEC [Test].dbo.sp_changedbowner N'sa'

------------------------------------------表操作------------------------------------------------------------

USE demo;
CREATE TABLE dbo.t_TestTable
(
	Id INT NOT NULL IDENTITY(1,1),
	Description nvarchar(50) NULL
) ON [PRIMARY] -- ON [PRIMARY]是表示表是建立在主文件组上。PRIMARY表示主文件组。如果没有指定默认文件组，则主文件组是默认文件组，ON [PRIMARY]也可以省略掉了。
 
ALTER TABLE dbo.t_TestTable ADD CONSTRAINT PK_t_TestTable PRIMARY KEY CLUSTERED(Id)-- 添加(PRIMARY KEY)主键约束同时并添加聚集索引(Clustered Index)


 /* 为了防止任何可能出现的数据丢失问题，您应该先仔细检查此脚本，然后再在数据库设计器的上下文之外运行此脚本。*/

BEGIN TRANSACTION
GO
CREATE TABLE dbo.Table_1
	(
	Id int NOT NULL IDENTITY (1, 1),
	Description nvarchar(50) NULL
	)  ON [PRIMARY]  
GO
ALTER TABLE dbo.Table_1 ADD CONSTRAINT
	PK_Table_1 PRIMARY KEY CLUSTERED
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.Table_1 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
