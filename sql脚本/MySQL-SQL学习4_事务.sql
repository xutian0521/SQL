begin transaction; --开始事务 (start transaction 也可以)

commit; --提交事务

ROLLBACK --回滚事务

--mysql 事务隔离级别：read uncommitted(读取未提交), read commit(读取已提交), repeatable read(可以重复读), serializable

select @@tx_isolation --查看当前事务的隔离级别
set global transaction isolation level read commit --设置全局的事务隔离级别
--不同的隔离级别会引发不同的问题：
    --read uncommitted: 会引发脏读(Dirty Read)：一个事务可以读取另一个事务还未提交的数据 =>改成 read commit 可解决脏读
    --read committed: 会引发不可重复读(NonRepeatable Read)：在同一事务中多次读取的结果不一致 =>改成  repeatable read 可解决不可重复读
    --repeatable read：会引发幻读(Phantom Read)


