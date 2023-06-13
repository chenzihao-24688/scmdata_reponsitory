create or replace package SF_GET_ARGUMENTS_PKG is

  -- Author  : SANFU
  -- Created : 2020/7/22 14:40:49
  -- Purpose : 动态获取包中存储过程或者函数的参数

  PROCEDURE get_arguments(p_pkg_name in VARCHAR2, p_obj_name in VARCHAR2);

  PROCEDURE pf_get_arguments(p_pkg_name in VARCHAR2,
                             p_obj_name in VARCHAR2);

end SF_GET_ARGUMENTS_PKG;
/
create or replace package body SF_GET_ARGUMENTS_PKG is

  /*============================================*
  * Author   : CZH
  * Created  : 2020-07-22 15:00:12
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 
  * Arg_number  : 2
  * P_PKG_NAME :包名
  * P_OBJ_NAME :存储过程名或函数名
  *============================================*/
  PROCEDURE get_arguments(p_pkg_name in VARCHAR2, p_obj_name in VARCHAR2) IS
    v_pkg_name   varchar2(100) := upper(p_pkg_name);
    v_obj_name   varchar2(100) := upper(p_obj_name);
    v_arg_number NUMBER;
    cursor data_cur is
      select t.PACKAGE_NAME,
             t.OBJECT_NAME,
             t.ARGUMENT_NAME,
             t.IN_OUT,
             count(t.ARGUMENT_NAME) over(PARTITION BY t.OBJECT_NAME) arg_number,
             row_number() over(partition by t.OBJECT_NAME order by t.POSITION asc) rank_position
        from sys.user_arguments t
       where t.PACKAGE_NAME = v_pkg_name
         and t.OBJECT_NAME = v_obj_name
         and t.POSITION <> 0;
  
  begin
    select count(1)
      into v_arg_number
      from sys.user_arguments t
     where t.PACKAGE_NAME = v_pkg_name
       and t.OBJECT_NAME = v_obj_name
       and t.POSITION <> 0;
  
    dbms_output.put_line('/*============================================*');
    dbms_output.put_line(' * Author   : SANFU');
    dbms_output.put_line(' * Created  : ' ||
                         TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'));
  
    dbms_output.put_line(' * ALERTER  : ');
    dbms_output.put_line(' * ALERTER_TIME  : ');
    dbms_output.put_line(' * Purpose  : ');
    dbms_output.put_line(' * Obj_Name    : ' || v_obj_name);
    dbms_output.put_line(' * Arg_Number  : ' || v_arg_number);
    for rec in data_cur loop
      dbms_output.put_line(' * ' || rec.ARGUMENT_NAME || ' :');
    end loop;
    dbms_output.put_line(' *============================================*/');
  end get_arguments;

  --获取参数
  PROCEDURE pf_get_arguments(p_pkg_name in VARCHAR2,
                             p_obj_name in VARCHAR2) IS
    v_pkg_name varchar2(100) := upper(p_pkg_name);
    v_obj_name varchar2(100) := upper(p_obj_name);
    v_attr     varchar2(100);
    cursor data_cur is
      select t.PACKAGE_NAME,
             t.OBJECT_NAME,
             t.ARGUMENT_NAME,
             t.IN_OUT,
             count(t.ARGUMENT_NAME) over(PARTITION BY t.OBJECT_NAME) arg_number,
             row_number() over(partition by t.OBJECT_NAME order by t.POSITION asc) rank_position
        from sys.user_arguments t
       where t.PACKAGE_NAME = v_pkg_name
         and t.OBJECT_NAME = v_obj_name
         and t.POSITION <> 0;
  
  begin
    dbms_output.put_line(v_pkg_name || '.' || v_obj_name || '(');
    for rec in data_cur loop
      if rec.in_out = 'IN' then
        v_attr := '';
      elsif rec.in_out = 'OUT' then
        v_attr := '';
      elsif rec.in_out = 'IN/OUT' then
        v_attr := '';
      end if;
      if data_cur%ROWCOUNT = rec.arg_number then
        dbms_output.put_line(lower(rec.ARGUMENT_NAME) || '        =>' ||
                             '   ' || v_attr || lower(rec.ARGUMENT_NAME));
      else
        dbms_output.put_line(lower(rec.ARGUMENT_NAME) || '        =>' ||
                             '   ' || v_attr || lower(rec.ARGUMENT_NAME) || ',');
      end if;
    
    end loop;
  
    dbms_output.put_line(');');
  end pf_get_arguments;
end SF_GET_ARGUMENTS_PKG;
/
