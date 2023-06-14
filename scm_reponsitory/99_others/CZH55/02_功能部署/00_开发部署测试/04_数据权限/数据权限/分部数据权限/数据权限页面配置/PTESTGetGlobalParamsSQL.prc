create or replace procedure PTESTGetGlobalParamsSQL(p_userid in varchar2,p_sql out varchar2)
is
 lValue varchar(2000);
 lValue1 varchar(2000);
 lValue2 varchar(2000);
 luser_id varchar2(32);
 lValue3 varchar(2000);
 vFlag number(1);
 begin
 select max(user_account),max(user_type),max(user_id)
  into lValue,lValue1 ,luser_id
  from sys_user  where upper(user_account)=upper(p_userid);
 if lValue is not null then
   p_sql:='select ''user_account'' name,''账号'' caption,'''||lValue||''' value from dual'||chr(13)||chr(10);
   p_sql:=p_sql||'union all'||chr(13)||chr(10)||'select ''user_type'',''用户类型'','''||lValue1||''' from dual'||chr(13)||chr(10);
   p_sql:=p_sql||'union all'||chr(13)||chr(10)||'select ''userid'',''' || lValue ||''','''|| lValue || '''from dual'||chr(13)||chr(10);
   p_sql:=p_sql||'union all'||chr(13)||chr(10)||'select ''AuthorID'',''' || p_userid ||''','''|| p_userid || '''from dual'||chr(13)||chr(10);
   p_sql:=p_sql||'union all'||chr(13)||chr(10)||'select ''user_id'',''' || luser_id ||''','''|| luser_id || '''from dual'||chr(13)||chr(10);
   p_sql:=p_sql||'union all'||chr(13)||chr(10)||'select ''Current_UserID'',''' || luser_id ||''','''|| luser_id || '''from dual'||chr(13)||chr(10);
   select max(a.company_id),max(b.logn_name),max(b.company_name)
     into lValue,lValue1,lValue2 from sys_user_company a
    inner join sys_company b on a.company_id=b.company_id
    where user_id=luser_id and is_default=1;
   if lValue is not null then 
     p_sql:=p_sql||'union all'||chr(13)||chr(10)||'select ''company_id'',''企业ID'','''||lValue||''' from dual'||chr(13)||chr(10);
     p_sql:=p_sql||'union all'||chr(13)||chr(10)||'select ''logn_name'',''企业全称'','''||lValue1||''' from dual'||chr(13)||chr(10);
     p_sql:=p_sql||'union all'||chr(13)||chr(10)||'select ''company_name'',''企业简称'','''||lValue2||''' from dual'||chr(13)||chr(10);
     p_sql:=p_sql||'union all'||chr(13)||chr(10)||'select ''default_company_id'',''默认企业ID'','''||lValue||''' from dual'||chr(13)||chr(10);       
   else
     p_sql:=p_sql||'union all'||chr(13)||chr(10)||'select ''company_id'',''企业ID'',null from dual'||chr(13)||chr(10);
     p_sql:=p_sql||'union all'||chr(13)||chr(10)||'select ''logn_name'',''企业全称'',null from dual'||chr(13)||chr(10);
     p_sql:=p_sql||'union all'||chr(13)||chr(10)||'select ''company_name'',''企业简称'',null from dual'||chr(13)||chr(10);
   end if;
   
   select max(company_dept_id) into lValue1 from sys_company_user_dept where user_id=luser_id and company_id=lValue;
   if lValue1 is not null then
     p_sql:=p_sql||'union all'||chr(13)||chr(10)||'select ''default_dept_id'',''默认部门ID'','''||lValue1||''' from dual'||chr(13)||chr(10);
     --czh add合作分类数据权限
     SELECT MAX(coop_class_priv) coop_class_priv
       INTO lvalue3
       FROM (SELECT listagg(DISTINCT t.cooperation_classification, ';') within GROUP(ORDER BY t.cooperation_classification) coop_class_priv
               FROM sys_company_data_priv t
              WHERE t.company_id = lvalue
                AND t.user_id = luser_id
              GROUP BY t.cooperation_type);
        
     p_sql:=p_sql||'union all'||chr(13)||chr(10)||'select ''coop_class_priv'',''合作分类数据权限'','''||lValue3||''' from dual'||chr(13)||chr(10); 
     
   else
     p_sql:=p_sql||'union all'||chr(13)||chr(10)||'select ''default_dept_id'',''默认部门ID'',null from dual'||chr(13)||chr(10);
   end if;
   /*select dep_id into lValue from users where userid=p_userid;
   select min(dep_name) into lCaption from depart where dep_id=lValue;
   p_sql:=p_sql||'union all'||chr(13)||chr(10)||'select ''dep_id'','''||lCaption||''','''||lValue||''' from dual'||chr(13)||chr(10);
   p_sql:=p_sql||'union all'||chr(13)||chr(10)||'select ''DepartID'','''||lCaption||''','''||lValue||''' from dual'||chr(13)||chr(10);
   select USERNAME into lValue from users where userid=p_userid;
   p_sql:=p_sql||'union all'||chr(13)||chr(10)||'select ''USERNAME'','''||lCaption||''','''||lValue||''' from dual'||chr(13)||chr(10);
*/
   
   --p_sql:=p_sql||'union all'||chr(13)||chr(10)||'select ''district_id'','''||lCaption||''','''||lValue||''' from dual'||chr(13)||chr(10);

   SELECT nvl(max(1),0)
    INTO vFlag
    FROM  scmdata.sys_company_user_role b
   INNER JOIN scmdata.sys_company_role c
      ON b.company_id = c.company_id
    and b.company_role_id = c.company_role_id
    where  b.company_id = lValue
     AND b.user_id = luser_id
     AND c.company_role_name in ('超级管理员','管理员');
      p_sql:=p_sql||'union all'||chr(13)||chr(10)||'select ''is_company_admin'',''是否企业管理员'','''||vFlag||''' from dual'||chr(13)||chr(10);
 end if;
end;
/
