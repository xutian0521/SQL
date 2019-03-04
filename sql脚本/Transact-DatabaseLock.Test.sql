T1:
begin tran
select * from table(updlock) (加更新锁)
update table set column1='hello'
T2:
begin tran
select * from table(updlock)
update table set column1='world'.

SELECT * FROM sys.sysdatabases WHERE name LIKE '%test%'