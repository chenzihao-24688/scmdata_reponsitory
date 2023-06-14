--1  建立序列
create sequence supplier_info_seq increment by 1 start with 1 maxvalue 99999 cache 50  cycle;

--2  采用Oracle 的函数，生产5位的流水号
select 'C'||lpad(supplier_info_seq.nextval,5,'0')  from dual;

--3 写存储过程 让序列归零
CREATE OR REPLACE Procedure Auto_Reset_Sequence(seqName In Varchar2) Is
    n Number;
Begin
    Begin
        Execute Immediate 'select ' || seqName || '.nextval from dual' into n;
        Execute Immediate 'alter sequence ' || seqName || ' increment by -' || n;
        Execute Immediate 'select ' || seqName || '.nextval from dual' into n;
        Execute Immediate 'alter sequence ' || seqName || ' increment by 1 ';
    End;
end Auto_Reset_Sequence;
