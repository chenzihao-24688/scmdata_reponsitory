--如何查看（sqlplus:Explain，Autotrace   plsql developer:F5）
--1.Explain （解释 oracle自带  sqlplus内）
--1.1 基本格式
--explain plan set statement_id = 'testplan' for select ....    (select , insert , update 等dml语句)

--1.2 查看方式
SELECT lpad('', 5 * (LEVEL - 1)) || operation operation,
       options,
       object_name,
       cost,
       position
  FROM plan_table
 START WITH id = 0
        AND statement_id = 'testplan'
CONNECT BY PRIOR id = parent_id;

--1.3 删除上次解析数据
delete from plan_table where statement_id = 'testplan'


--2.Autotrace(自动跟踪 oracle自带sqlplus内)
--2.1 基本格式
--SQL > set autotrace on;(sqlplus 中使用)

--紧接着：SQL > select * from dual;

--产生结果数据，执行计划，统计信息

--3. 使用plsql developer:F5 查看


--4. 怎么看
/*
执行计划其实是一棵树，层次最深的最先执行，层次相同的，上面的先执行。
显示时按层次缩进，因此从最里边的看起。最后一组就是驱动表。

先从最开头一直往右看，直到看到最右边的并列的地方，对于不并列的，靠右的先执行：对于并列的，靠上的先执行。
即并列的缩进块，从上往下执行，非并列的缩进块，从下往上执行。

*/





