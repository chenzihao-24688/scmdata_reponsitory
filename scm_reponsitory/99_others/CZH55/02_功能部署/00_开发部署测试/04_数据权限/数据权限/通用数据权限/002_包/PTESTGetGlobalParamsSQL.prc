create or replace procedure PTESTGetGlobalParamsSQL(p_userid in varchar2,p_sql out varchar2)
is
 lValue varchar(2000);
 lValue1 varchar(2000);
 lValue2 varchar(2000);
 luser_id varchar2(32);
 lValue3 varchar(2000);
 vFlag number(1);
 --czh add data privs 
 --begin
 data_privs_json_strs clob;
 --data_privs_arrs scmdata.pkg_data_privs.data_privs_tab := scmdata.pkg_data_privs.data_privs_tab();
 v_dflag number;
 --分部权限全局变量
 /* coop_data_class_item_id varchar(2000);
 coop_data_class_privs varchar(2000);
 coop_type_priv varchar2(256);
 coop_class_priv varchar2(256);
 --仓库
 store_item_id varchar(2000);
 store_privs varchar(2000);
 store_priv  varchar2(256);*/
 --end
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
     --begin
     SELECT MAX(coop_class_priv) coop_class_priv
       INTO lvalue3
       FROM (SELECT listagg(DISTINCT t.cooperation_classification, ';') within GROUP(ORDER BY t.cooperation_classification) coop_class_priv
               FROM sys_company_data_priv t
              WHERE t.company_id = lvalue
                AND t.user_id = luser_id
              GROUP BY t.cooperation_type);
        
     p_sql:=p_sql||'union all'||chr(13)||chr(10)||'select ''coop_class_priv'',''合作分类数据权限'','''||lValue3||''' from dual'||chr(13)||chr(10); 
     --end
     --czh add 新通用数据权限配置 
     --begin
     v_dflag := scmdata.pkg_data_privs.check_is_data_privs(p_company_id => lvalue,p_user_id => luser_id,v_type => 0);
     IF v_dflag > 0 THEN
       data_privs_json_strs := scmdata.pkg_data_privs.get_json_strs(p_company_id => lvalue,p_user_id => luser_id);
       p_sql:=p_sql||'union all'||chr(13)||chr(10)||'select ''data_privs_json_strs'',''数据权限JSON'','''||data_privs_json_strs||''' from dual'||chr(13)||chr(10); 
     END IF;
     --end
     --czh add 原通用数据权限配置 
    /* v_dflag := scmdata.pkg_data_privs.check_is_data_privs(p_company_id => lvalue,p_user_id => luser_id);
     IF v_dflag > 0 THEN
     data_privs_arrs := scmdata.pkg_data_privs.get_privs_var(p_company_id => lvalue,p_user_id => luser_id);
      --分部
      scmdata.pkg_data_privs.get_golbal_data_privs(p_level_type    => 'CLASS_TYPE',
                                                   data_privs_arrs => data_privs_arrs,
                                                   po_item_id      => coop_data_class_item_id,
                                                   po_col          => coop_data_class_privs);                                                   
      --获取分部权限字段
      coop_type_priv := scmdata.sf_get_arguments_pkg.get_strarraystrofindex(coop_data_class_privs,',',0);
      coop_class_priv := scmdata.sf_get_arguments_pkg.get_strarraystrofindex(coop_data_class_privs,',',1); 
      p_sql:=p_sql||'union all'||chr(13)||chr(10)||'select ''coop_data_class_item_id'',''合作分类数据权限ITEM_ID'','''||coop_data_class_item_id||''' from dual'||chr(13)||chr(10);
      p_sql:=p_sql||'union all'||chr(13)||chr(10)||'select ''coop_type_priv'',''合作类型'','''||coop_type_priv||''' from dual'||chr(13)||chr(10);    
      p_sql:=p_sql||'union all'||chr(13)||chr(10)||'select ''coop_class_priv'',''合作分类'','''||coop_class_priv||''' from dual'||chr(13)||chr(10); 
      
      --仓库
      scmdata.pkg_data_privs.get_golbal_data_privs(p_level_type    => 'COMPANY_STORE_TYPE',
                                                   data_privs_arrs => data_privs_arrs,
                                                   po_item_id      => store_item_id,
                                                   po_col          => store_privs);                                                                     
      --获取仓库权限字段
      store_priv := scmdata.sf_get_arguments_pkg.get_strarraystrofindex(store_privs,',',10);    
      p_sql:=p_sql||'union all'||chr(13)||chr(10)||'select ''store_item_id'',''仓库数据权限ITEM_ID'','''||store_item_id||''' from dual'||chr(13)||chr(10);
      p_sql:=p_sql||'union all'||chr(13)||chr(10)||'select ''store_priv'',''仓库数据权限'','''||store_priv||''' from dual'||chr(13)||chr(10);       
      ELSE
       NULL;
      END IF;   */  
            
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
 
  --add by hx87 2021-07-15 begin
   --MaintenanceFlag   --显示速狮节点ID
    select max(pkg_plat_comm.f_hasaction_group(luser_id,'999'))
      into vFlag
      from dual;
    if vFlag is null then
    vFlag:='0';
   end if;
   lValue := 'maintenanceflag';
   lValue1 := '运维权限';
   p_sql:=p_sql||'union all'||chr(13)||chr(10)||'select '''||lValue||''','''||lValue1||''', '''||vFlag||''' from dual'||chr(13)||chr(10);
   --end
   
end;
/
