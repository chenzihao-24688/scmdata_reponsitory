declare
  v_pkg_name   varchar2(100) := upper(&p1);
  v_obj_name   varchar2(100) := upper(&p2);
  v_arg_number number;
  cursor data_cur is
    select t.PACKAGE_NAME,
           t.OBJECT_NAME,
           t.ARGUMENT_NAME,
           count(t.ARGUMENT_NAME) over(PARTITION BY t.OBJECT_NAME) arg_number,
           row_number() over(partition by t.OBJECT_NAME order by t.POSITION asc) rank_position
      from sys.user_arguments t
     where t.PACKAGE_NAME = v_pkg_name
       and t.OBJECT_NAME = v_obj_name;

begin
  select count(1)
    into v_arg_number
    from sys.user_arguments t
   where t.PACKAGE_NAME = v_pkg_name
     and t.OBJECT_NAME = v_obj_name;

  dbms_output.put_line('/*============================================*');
  dbms_output.put_line(' * Author   : SANFU');
  dbms_output.put_line(' * Created  : ' ||
                       TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'));

  dbms_output.put_line(' * ALERTER  : ');
  dbms_output.put_line(' * ALERTER_TIME  : ');
  dbms_output.put_line(' * Purpose   : ');
  dbms_output.put_line(' * Obj_Name  : ' || v_obj_name);
  dbms_output.put_line(' * Arg_number  : ' || v_arg_number);
  for rec in data_cur loop
    dbms_output.put_line(' * ' || rec.ARGUMENT_NAME || ' :');
  end loop;
  dbms_output.put_line(' *============================================*/');
end;

-- Author  : SANFU
-- Created : 2020/7/4 11:04:50
-- Purpose : 用户管理

--获取包中过程，函数参数
select t.PACKAGE_NAME, t.OBJECT_NAME, count(1)
  from sys.user_arguments t
 where t.PACKAGE_NAME LIKE 'SF%'
 group by t.PACKAGE_NAME, t.OBJECT_NAME;

select * from sys.user_arguments t where t.PACKAGE_NAME LIKE 'PKG_PERSONAL';

select name,
       course,
       row_number() over(partition by course order by score desc) rank
  from student;

select t.PACKAGE_NAME,
       t.OBJECT_NAME,
       t.ARGUMENT_NAME,
       count(t.ARGUMENT_NAME) over(PARTITION BY t.OBJECT_NAME) obj_name,
       row_number() over(partition by t.OBJECT_NAME order by t.POSITION asc) rank_position
  from sys.user_arguments t
 where t.PACKAGE_NAME = 'PKG_PERSONAL';
