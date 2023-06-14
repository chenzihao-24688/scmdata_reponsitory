﻿create or replace package scmdata.PKG_COMPANY_MANAGE is

  -- Author  : HX87
  -- Created : 2020/7/18 17:33:43
  -- Purpose : 企业管理包

  /*
   pi_user_id: sys_user表的user_id
   pi_company_id: 企业编号
   purpose：校验同意用户加入操作
  */
  FUNCTION F_CHECK_USER_JOIN_AGREE(pi_user_id in varchar2,
                                   pi_company_id in varchar2, 
                                   pi_role_ID in varchar2,
                                   pi_dept_id in varchar2) return varchar2;


  /*
   pi_user_id: sys_user表的user_id
   pi_company_id: 企业编号
   purpose：校验拒绝用户加入操作
  */
  FUNCTION F_CHECK_USER_JOIN_Refuse(pi_user_id in varchar2,pi_company_id in varchar2) return varchar2;
  
  /*
     pi_user_id: sys_user表的user_id
     pi_company_id: 企业编号
     PI_REPLY_SAY：回复意见
     PI_REPLY_ID：回复人
     pi_operate_type 操作类： 1 同意； 2 拒绝
     po_result   返回结果 0为成功；负数为失败
     po_message  返回结果 成功时为空；失败返回错误消息
   
   purpose：同意/拒绝加入企业过程
  */
  PROCEDURE P_USER_JOIN_AGREE(pi_user_id      in varchar2,
                              pi_company_id   in varchar2,
                              PI_REPLY_SAY    IN VARCHAR2 default '同意',
                              PI_REPLY_ID     IN VARCHAR2,
                              pi_operate_type in int,
                              pi_role_ID    in varchar2,
                              pi_dept_id    in varchar2,
                              po_result       out number,
                              po_message      out varchar2,
                              pi_role_group_id in varchar2 default null,
                              pi_job_id        in varchar2 default null);
                              
   /*
     pi_company_id: 企业编号
     PI_APPLY_ID：应用ID
     PI_TYPE：1 新增；  2 续订   
   purpose：校验应用购买
  */                            
  FUNCTION F_CHECK_APP_BUY(PI_COMPANY_ID      IN VARCHAR2,
                         PI_APPLY_ID          IN VARCHAR2,
                         PI_TYPE              IN NUMBER
                         ) RETURN VARCHAR2;
  /* PI_USER_ID   ：购买人员工号
     pi_company_id: 企业编号
     PI_APPLY_ID  ：应用ID
     PI_TYPE      ：1 新增；  2 续订  
     PO_RESULT    ：输出标识(数字)
     PO_MESSAGE   : 输出错误描述
   purpose：校验应用购买
  */                                               
  PROCEDURE P_APP_BUY(PI_USER_ID      IN VARCHAR2,
                      PI_COMPANY_ID   IN VARCHAR2,
                      PI_APPLY_ID     IN VARCHAR2,
                      PI_TYPE         IN NUMBER,
                      PO_RESULT       OUT NUMBER,
                      PO_MESSAGE      OUT VARCHAR2);
                      
  PROCEDURE P_PRIVILEGE_COND(P_PRIVID VARCHAR2);
  
  /* PI_USER_ID   ：购买人员工号
     pi_company_id: 企业编号
     PI_APPLY_ID  ：应用ID
     PI_TYPE      ：1 新增；  2 续订  
     PO_RESULT    ：输出标识(数字)
     PO_MESSAGE   : 输出错误描述
     PI_COMPANY_ROLE: 企业在平台的类别，need:采购方    supp:成品供应商   mrpp:面料供应商
   purpose：供应商批量自动购买应用
   by: hx 2021-11-20
  */  
  PROCEDURE P_APP_BUY_FOR_SUPP(PI_USER_ID      IN VARCHAR2,
                               PI_COMPANY_ID   IN VARCHAR2,
                               PI_TYPE         IN NUMBER,
                               PO_RESULT       OUT NUMBER,
                               PO_MESSAGE      OUT VARCHAR2,
                               PI_COMPANY_ROLE IN VARCHAR2);

  /*PI_SUPPLIER_CODE：      mrp物料供应商编号
    PO_RESULT       ：     输出标识(数字)  0 代表成功; 负数代表失败
    PO_MESSAGE      :      输出错误描述
    PO_COMPANY_ID   :      返回创建后的企业ID
  purpose：mrp供应商创建个人账号、企业注册
   by: hx 2023-2-23
  */
  PROCEDURE P_REGISTER_MRP(PI_SUPPLIER_CODE    IN VARCHAR2,
                           PO_RESULT           OUT NUMBER,
                           PO_MESSAGE          OUT VARCHAR2,
                           PO_COMPANY_ID       OUT VARCHAR2);
  /*PI_SUPPLIER_CODE：     供应商编号
    PI_COMPANY_ROLE :      企业类型 成品供应商supp ;  面辅料供应商mrp
    PO_RESULT       ：     输出标识(数字)  0 代表成功; 负数代表失败
    PO_MESSAGE      :      输出错误描述
    PO_COMPANY_ID   :      返回创建后的企业ID
  purpose：供应商反向注册
   by: hx 2023-2-23
  */     
  Procedure P_COMPANY_REVERSE_REGISTER(PI_SUPPLIER_CODE     IN VARCHAR2,
                                       PI_COMPANY_ROLE      IN VARCHAR2,
                                       PO_RESULT            OUT NUMBER,
                                       PO_MESSAGE           OUT VARCHAR2,
                                       PO_COMPANY_ID        OUT VARCHAR2
                                      );
                           
end PKG_COMPANY_MANAGE;
/

create or replace package body scmdata.PKG_COMPANY_MANAGE is
/*
   pi_user_id: sys_user表的user_id
   pi_company_id: 企业编号
   purpose：内部函数，通用校验 同意/拒绝用户加入企业
*/
Function F_CHECK_USER_JOIN_COMM(pi_user_id in varchar2,pi_company_id in varchar2) RETURN VARCHAR2
IS
 v_error varchar2(100);
 v_pause int;
BEGIN
  select max(pause) into v_pause from sys_user a where a.user_id=pi_user_id;
   if v_pause is null then
     v_error:='找不到该员工了，请尝试刷新下数据';
     return v_error;
   end if;
   select max(pause) into v_pause from sys_company a where a.company_id=pi_company_id;
   if v_pause is null then
     v_error:='未发现该企业的信息，无法进行此操作';
   elsif v_pause =1 then
     v_error:='企业已被禁用了哦，无法进行此操作';
   end if;
   
   select max(pause) into v_pause from sys_company_user a where a.company_id=pi_company_id and a.user_id=pi_user_id;
   if v_pause =1 then
     v_error:='该账户已加入过该企业，且已被禁用了';
   elsif v_pause =0 then
     v_error:='该账户已加入过该企业';
   end if;
   
   return v_error;
END;
function F_CHECK_USER_JOIN_AGREE(pi_user_id in varchar2,
                                 pi_company_id in varchar2, 
                                 pi_role_id in varchar2,
                                 pi_dept_id in varchar2
                                ) return varchar2
is 
 v_error varchar2(100);
 v_i int;
 v_pause int;
begin
   v_error:=F_CHECK_USER_JOIN_COMM(pi_user_id,pi_company_id);
   if v_error is not null then
     return v_error;
   else
     select max(pause) into v_pause from sys_user a where a.user_id=pi_user_id;

     if v_pause=1 then 
       v_error:='该账号已被平台停用，无法同意加入';
     end if;
     
     select max(1) into v_i from dual 
      where not exists(select 1 from sys_company_role a 
                        where a.company_id=pi_company_id and a.company_role_ID=pi_role_ID);
     if v_i =1 then
        v_error:='未找到该角色，请重新选择';
        return v_error;
     end if;
     
     select max(1) into v_i from dual 
      where not exists(select 1 from sys_company_dept a 
                        where a.company_id=pi_company_id and a.company_dept_id=pi_dept_id
                          and pause=0);
     if v_i =1 and pi_dept_id is not null then
        v_error:='未找到部门，可能已经被禁用，请重新选择';
         return v_error;
     end if;
     
   end if;
   
   return v_error;
end;

FUNCTION F_CHECK_USER_JOIN_Refuse(pi_user_id in varchar2,pi_company_id in varchar2) return varchar2
is
 v_error varchar2(100);
begin
  v_error:=F_CHECK_USER_JOIN_COMM(pi_user_id,pi_company_id);
   if v_error is not null then
     return v_error;
   else
     return v_error;
   end if;
   
   return v_error;
   
end;
                              
PROCEDURE P_USER_JOIN_AGREE(pi_user_id      in varchar2,
                            pi_company_id   in varchar2,
                            PI_REPLY_SAY    IN VARCHAR2 default '同意',
                            PI_REPLY_ID     IN VARCHAR2,
                            pi_operate_type in int,
                            pi_role_ID      in varchar2,
                            pi_dept_id      in varchar2,
                            po_result       out number,
                            po_message      out varchar2,
                            pi_role_group_id in varchar2 default null,
                            pi_job_id        in varchar2 default null)
is
 v_default           int;
 v_sort              int;
 v_company_name      sys_company.company_name%type;
 v_company_dept_id   sys_company_dept.company_dept_id%type;
 v_job_id            sys_company_job.job_id%type;
 v_inner_user_id     varchar2(32); 
begin
  if pi_operate_type =1 then --同意加入
  po_message:= F_CHECK_USER_JOIN_AGREE(pi_user_id,pi_company_id,pi_role_ID,pi_dept_id);
  if po_message is not null then
    po_result:=-1;
    return ;
  end if;
  select max(a.inner_user_id),max(b.company_dept_id),max(c.job_id)
    into v_inner_user_id,v_company_dept_id,v_job_id
    from sys_user_company_join a
    left join sys_company_dept b on a.dept_id=b.remarks and a.company_id=b.company_id
    left join sys_company_job c on a.stdjobcode=c.company_job_id and a.company_id=c.company_id
   where a.user_id=pi_user_id and a.company_id=pi_company_id;
  --插入企业用户员工信息
  insert into sys_company_user(company_user_id,company_id,user_id,sort,nick_name,company_user_name,sex,
                               phone,email,pause,update_id,update_time,nationality,id_card,education,
                               profession,language,birth_place,household_type,marriage,residence_address,
                               living_address,emergency_name,emergency_contact,emergency_phone,self_evaluation,
                               inner_user_id,job_id)
   select f_get_uuid(),pi_company_id,a.user_id,1,a.nick_name,nvl(a.username,a.nick_name),a.sex,a.phone,a.email,0,PI_REPLY_ID,sysdate,
          a.nationality,a.id_card,a.education,a.profession,a.language,a.birth_place,a.household_type,a.marriage,a.residence_address,
          a.living_address,a.emergency_name,a.emergency_contact,a.emergency_phone,null,v_inner_user_id,nvl(pi_job_id,v_job_id)
     from sys_user a
    where a.user_id=pi_user_id;
   
   select max(is_default),max(sort) into v_default,v_sort from   sys_user_company a where a.user_id=pi_user_id;
   
   if v_default =1 then v_default :=0; end if;--有默认企业，插入时变成0
   
   select max(a.COMPANY_NAME) into v_company_name from sys_company a where a.company_id=pi_company_id;
    insert into sys_user_company(user_company_id,user_id,company_id,company_alias,is_default,sort,join_time,pause)
    values(f_get_uuid(),pi_user_id,pi_company_id,v_company_name,nvl(v_default,1),nvl(v_sort+1,1),sysdate,0);
    
    --创建员工角色关系
    if pi_role_ID is not null then
    insert into sys_company_user_role(company_user_role_id,company_id ,user_id ,company_role_id)
     values( f_get_uuid(),pi_company_id,pi_user_id,pi_role_ID);
    end if;
    
    --员工归属到对应部门
    if pi_dept_id is not null or v_company_dept_id is not null then
      insert into sys_company_user_dept(user_dept_id,company_id,user_id,company_dept_id)
      values(f_get_uuid(),pi_company_id,pi_user_id,nvl(pi_dept_id,v_company_dept_id));
      
      --czh add 数据权限
      pkg_data_privs.authorize_emp(p_company_id => pi_company_id,p_dept_id => nvl(pi_dept_id,v_company_dept_id),p_user_id => pi_user_id);
     
    end if;
    
    --插入角色组
    if pi_role_group_id is not null then
      insert into sys_app_user_role_group_ra(user_role_group_ra_id,user_id,role_group_id,company_id,create_id,
                                             update_id)
      values(pkg_plat_comm.f_getkeyid_plat('UR_RA','SEQ_SYS_APP_USER_ROLE_GROUP_RA'),pi_user_id,pi_role_group_id,
                                           pi_company_id,pi_reply_id,pi_reply_id);
    end if;
    --更新用户申请记录
   update sys_user_company_join a 
      set a.reply_id=pi_reply_id,
          a.reply_say=PI_REPLY_SAY,
          a.reply_time=sysdate,
          a.join_status='1'
    where a.user_id=pi_user_id and a.join_status=0
      and a.company_id=pi_company_id;
  if sql%rowcount<>1 then
     po_result :=-2;
     po_message:='更新用户申请记录出错了哦，请尽快联系平台管理员来帮忙';
     return;
  end if;
  elsif pi_operate_type =2 then  --拒绝加入
    po_message:= F_CHECK_USER_JOIN_Refuse(pi_user_id,po_result);
    if po_message is not null then
      po_result:=-3;
      return ;
    end if;
       --更新用户申请记录
     update sys_user_company_join a 
        set a.reply_id=pi_reply_id,
            a.reply_say=PI_REPLY_SAY,
            a.reply_time=sysdate,
            a.join_status='2'
      where a.user_id=pi_user_id and a.join_status=0 
        and a.company_id=pi_company_id;
    if sql%rowcount<>1 then
       po_result :=-4;
       po_message:='更新用户申请记录出错了哦，请尽快联系平台管理员来帮忙';
       return;
    end if;
  
  else 
     po_result :=-5;
     po_message:='传入了无效的操作类型，无法识别';
     return;
  end if;
end;

FUNCTION F_CHECK_APP_BUY(PI_COMPANY_ID      IN VARCHAR2,
                         PI_APPLY_ID        IN VARCHAR2,
                         PI_TYPE         IN NUMBER
                         ) RETURN VARCHAR2
is
v_result       varchar2(200);
v_apply_status sys_group_apply.apply_status%type;
v_is_company   sys_group_apply.is_company%type;
v_i            int;
v_apply_name   sys_group_apply.apply_name%type;
v_apply_id     sys_company_apply.apply_id%type;
v_end_time     date;

begin
  --1.应用校验
  select max(a.apply_status),max(a.pause),max(a.is_company),max(a.apply_name)
    into v_apply_status,v_i,v_is_company,v_apply_name
    from sys_group_apply a 
   where a.apply_id=pi_apply_id ;
   if v_apply_name is null then 
     v_result:='未找到该应用，无法购买/续订，请刷新窗口再操作';
     return v_result;
   end if;
   if v_i =1 then 
     v_result:='应用'''||v_apply_name||'''已被禁用，请刷新窗口再操作';
     return v_result;
   end if;
   if v_apply_status<>'0' then
     v_result:='应用'''||v_apply_name||'''已被下架，请刷新窗口再操作';
     return v_result; 
   end if;
   if v_is_company <>1 then 
     v_result:=''''||v_apply_name||'''非企业应用，无法购买，请前往个人中心应用商城购买';
     return v_result; 
   end if;
  if pi_type not in (1,2) then
    v_result:='传入的操作类型无法识别，请确认后重新调用';
    return v_result;
  end if;

  --2.企业应用校验：
   select max(a.apply_id)
     into v_apply_id
     from sys_company_apply a
    where a.apply_id=pi_apply_id
      and a.company_id=PI_COMPANY_ID;
      
   select  max(a.end_time)
     into v_end_time
     from sys_company_apply_buylog a
    where a.apply_id=PI_APPLY_ID and a.company_id=PI_COMPANY_ID;
  if PI_TYPE=1 then
    if v_apply_id is not null then 
      v_result:='应用'''||v_apply_name||'''已购买，无法再次购买';
    end if;
  elsif pi_type=2 then
    if v_apply_id is  null then 
      v_result:='应用'''||v_apply_name||'''未购买，无法续订';
    else 
      if  trunc(v_end_time)=date'2099-12-31' then
        v_result:=''''||v_apply_name||'''是免费应用，无法续订';
      end if;
    end if;
  else
     v_result:='传入的操作类型无法识别，请确认后重新调用';
  end if;
   
  return v_result;
end;

PROCEDURE P_APP_BUY(PI_USER_ID      IN VARCHAR2,
                    PI_COMPANY_ID   IN VARCHAR2,
                    PI_APPLY_ID     IN VARCHAR2,
                    PI_TYPE         IN NUMBER,
                    PO_RESULT       OUT NUMBER,
                    PO_MESSAGE      OUT VARCHAR2)
is
  v_apply_name sys_group_apply.apply_name%type;
  v_i int;
begin
  po_message:=PKG_COMPANY_MANAGE.F_CHECK_APP_BUY(PI_COMPANY_ID,PI_APPLY_ID,PI_TYPE);
  if po_message is not null then
    po_result:=-1;
    return;
  end if;
  select max(a.apply_name)
    into v_apply_name
    from sys_group_apply a 
   where a.apply_id=pi_apply_id;
  if pi_type =1 then 
    insert into sys_company_apply(company_apply_id,company_id,apply_id,sort,expired_time)
     values(f_get_uuid(),PI_COMPANY_ID,PI_APPLY_ID,1,date'2099-12-31');
     --现阶段都是免费，暂不支持收费模式
    insert into sys_company_apply_buylog(apply_buylog_id,company_id,apply_id,apply_name,tips,apply_buylog_type,
                                         unit,num,price,pay_price,start_time,end_time,create_id,create_time)
    values(f_get_uuid(),PI_COMPANY_ID,PI_APPLY_ID,v_apply_name,null,'新增','个',1,0,0,sysdate,date'2099-12-31',PI_USER_ID,sysdate);
    
  elsif pi_type =2 then
    
    update sys_company_apply a set a.expired_time=date'2099-12-31' 
     where a.company_id=PI_COMPANY_ID and a.apply_id=PI_APPLY_ID;
     
    insert into sys_company_apply_buylog(apply_buylog_id,company_id,apply_id,apply_name,tips,apply_buylog_type,
                                         unit,num,price,pay_price,start_time,end_time,create_id,create_time)
    values(f_get_uuid(),PI_COMPANY_ID,PI_APPLY_ID,v_apply_name,null,'续费','个',1,0,0,sysdate,date'2099-12-31',PI_USER_ID,sysdate);
  end if; 
    --获取有强关联的应用，并自动购买
    for item in (select a.apply_id,a.rela_apply_id,b.apply_name
                   from sys_group_apply_rela a 
                  inner join sys_group_apply b on a.rela_apply_id=b.apply_id
                  where a.apply_id=pi_apply_id and a.force_bind=1
                    and a.pause=0)
    loop
      
      select max(1) into v_i from sys_company_apply  a where a.apply_id=item.rela_apply_id and a.company_id=PI_COMPANY_ID;
      if v_i is null then 
        insert into sys_company_apply(company_apply_id,company_id,apply_id,sort,expired_time)
         values(f_get_uuid(),PI_COMPANY_ID,item.rela_apply_id,1,date'2099-12-31');
        --现阶段都是免费，暂不支持收费模式
        insert into sys_company_apply_buylog(apply_buylog_id,company_id,apply_id,apply_name,tips,apply_buylog_type,
                                             unit,num,price,pay_price,start_time,end_time,create_id,create_time)
        values(f_get_uuid(),PI_COMPANY_ID,item.rela_apply_id,item.apply_name,null,decode(PI_TYPE,1,'新增',2,'续费'),'个',1,0,0,sysdate,date'2099-12-31',PI_USER_ID,sysdate);
        
      end if;
    end loop;
  
end;

PROCEDURE P_PRIVILEGE_COND(P_PRIVID VARCHAR2) 
IS
  V_COUNT    INT;
  v_i        int;
  V_COND_ID  VARCHAR2(50);
  V_COND_SQL VARCHAR2(2000);
  CURSOR C_PRIV IS
    SELECT T.PRIV_ID, T.PRIV_NAME, T.OBJ_TYPE, T.CTL_ID, T.ITEM_ID
      FROM SYS_APP_PRIVILEGE T
     WHERE T.PRIV_ID = P_PRIVID AND t.obj_type IS NOT NULL and t.cond_id is null;
  R_PRIV C_PRIV%ROWTYPE;
BEGIN
  FOR R_PRIV IN C_PRIV LOOP
    V_COND_ID  := 'cond_' || R_PRIV.CTL_ID||'_auto';
    V_COND_SQL := 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''' ||  R_PRIV.PRIV_ID || ''') as flag from dual ';
    --DBMS_OUTPUT.put_line(V_COND_SQL);
    SELECT COUNT(*) INTO V_COUNT  FROM nbw.SYS_COND_LIST    WHERE COND_ID like V_COND_ID||'%';

    IF V_COUNT = 0 THEN
      INSERT INTO nbw.SYS_COND_LIST
        (COND_ID, COND_SQL, COND_TYPE, DATA_SOURCE)
      VALUES
        (V_COND_ID, V_COND_SQL, 0, 'oracle_scmdata');

      INSERT INTO nbw.SYS_COND_RELA
        (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
      VALUES
        (V_COND_ID,R_PRIV.OBJ_TYPE,R_PRIV.CTL_ID,0,1,0,R_PRIV.ITEM_ID);
        
     update sys_app_privilege a set a.cond_id=v_cond_id where a.priv_id=R_PRIV.Priv_Id;
    elsif v_count>0 THEN --存在名称一样的
      
      --判断ITEM增删改查时，是否含有一样的obj_type
      
      select count(*) into v_i from nbw.sys_cond_rela a
       where a.obj_type=R_PRIV.Obj_Type and a.ctl_id=R_PRIV.Ctl_Id
         and a.obj_type in (11,12,13,14);
       
      if   R_PRIV.Item_Id is not null or v_i =0 then
        V_COND_ID  := 'cond_' || R_PRIV.CTL_ID||'_auto_'||v_count;
        
          INSERT INTO nbw.SYS_COND_LIST
            (COND_ID, COND_SQL, COND_TYPE, DATA_SOURCE)
          VALUES
            (V_COND_ID, V_COND_SQL, 0, 'oracle_scmdata');

          INSERT INTO nbw.SYS_COND_RELA
            (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
          VALUES
            (V_COND_ID,R_PRIV.OBJ_TYPE,R_PRIV.CTL_ID,0,1,0,R_PRIV.ITEM_ID);
            
         update sys_app_privilege a set a.cond_id=v_cond_id where a.priv_id=R_PRIV.Priv_Id;
      end if;
      
    END IF;

  END LOOP;
END;

PROCEDURE P_APP_BUY_FOR_SUPP(PI_USER_ID      IN VARCHAR2,
                             PI_COMPANY_ID   IN VARCHAR2,
                             PI_TYPE         IN NUMBER,
                             PO_RESULT       OUT NUMBER,
                             PO_MESSAGE      OUT VARCHAR2,
                             PI_COMPANY_ROLE IN VARCHAR2)
is
begin
  ----0：所有企业都允许;1.只有采购方;2.只有成品供应商;3.采购方%成品供应商；4.面料供应商';
  for item in (select * from sys_group_apply a 
                where 1=1
                  and a.system_id='SCM'
                  and (  PI_COMPANY_ROLE='supp' and a.APPLY_BELONG in (0,2,3) --成品供应商
                      or PI_COMPANY_ROLE='mrp'  and a.APPLY_BELONG in (0,4) --面料供应商
                      )
                order by a.sort
               ) loop
    po_message:=PKG_COMPANY_MANAGE.F_CHECK_APP_BUY(PI_COMPANY_ID,item.apply_id,PI_TYPE);
    if po_message is not null then
      po_result:=-1;
      return;
    end if;
    
    insert into sys_company_apply(company_apply_id,company_id,apply_id,sort,expired_time)
     values(f_get_uuid(),PI_COMPANY_ID,item.apply_id,1,date'2099-12-31');
     --现阶段都是免费，暂不支持收费模式
    insert into sys_company_apply_buylog(apply_buylog_id,company_id,apply_id,apply_name,tips,apply_buylog_type,
                                         unit,num,price,pay_price,start_time,end_time,create_id,create_time)
    values(f_get_uuid(),PI_COMPANY_ID,item.apply_id,item.apply_name,null,'新增','个',1,0,0,sysdate,date'2099-12-31',PI_USER_ID,sysdate);
  end loop;
  exception when others then
    PO_RESULT:=-2;
    PO_MESSAGE:=(RTRIM(substrb('PACKAGE_ERROR:'||SQLERRM||':PKG_COMPANY_MANAGE.P_APP_BUY_FOR_SUPP:'||to_char(SQLCODE), 1, 255)));
end;

 PROCEDURE P_REGISTER_MRP(PI_SUPPLIER_CODE    IN VARCHAR2,
                          PO_RESULT           OUT NUMBER,
                          PO_MESSAGE          OUT VARCHAR2,
                          PO_COMPANY_ID       OUT VARCHAR2)
is

pi_supplier_name   mrp.mrp_determine_supplier_archives.supplier_name%type;
pi_supplier_abbreviation mrp.mrp_determine_supplier_archives.supplier_abbreviation%type;
pi_LICENCE_NUM           mrp.mrp_determine_supplier_archives.unified_social_credit_code%type;
pi_phone                 mrp.mrp_determine_supplier_archives.contact_phone%type;
pi_contact               mrp.mrp_determine_supplier_archives.business_contact%type;
pi_address               mrp.mrp_determine_supplier_archives.detailed_address%type;
pi_company_id            sys_company.company_id%type;
p_I                      int;
v_user_id                sys_user.user_id%type;
v_company_role           varchar2(32):='mrpp';
begin
  /*初始化变量*/
  PO_MESSAGE:=null;
  PO_RESULT:=0;
  
  --获取物料供应商信息
  select max(a.supplier_name),max(a.supplier_abbreviation),max(a.unified_social_credit_code),
         max(a.contact_phone),max(a.business_contact),max(a.detailed_address),max(a.supplier_company_id)
    into pi_supplier_name,pi_supplier_abbreviation,pi_licence_num,pi_phone,pi_contact,pi_address,
         pi_company_id
    from mrp.MRP_DETERMINE_SUPPLIER_ARCHIVES a
   where a.supplier_code=PI_supplier_code;
   /*开始校验 供应商建档部分 begin*/
   --1.是否存在供应商
   if pi_supplier_name is null then
      PO_RESULT:=-10;
      PO_MESSAGE:='建档失败：物料供应商编号'''||PI_SUPPLIER_CODE||'''找不到相应的供应商';
    --2.平台是否存在档案
   elsif pi_company_id is not null then 
     select max(1)
       into p_i
       from sys_company a
      where a.company_id=PI_company_id;
      
      if p_i =1 then
        PO_RESULT:=-11;
        PO_MESSAGE:='建档失败：物料供应商编号'''||PI_SUPPLIER_CODE||'''在平台企业档案中存在';
      else
        PO_RESULT:=-12;
        PO_MESSAGE:='建档失败：编号'''||PI_SUPPLIER_CODE||'''的供应商已有企业编号，请确认';
      end if;
   end if;
   --校验企业社会信用代码
   if PI_LICENCE_NUM is null then
        PO_RESULT:=-13;
        PO_MESSAGE:='建档失败：物料供应商编号'''||PI_SUPPLIER_CODE||''' 企业社会信用代码缺失';
     
   elsif length(PI_LICENCE_NUM)<>18 then
       PO_RESULT:=-14;
        PO_MESSAGE:='建档失败：物料供应商编号'''||PI_SUPPLIER_CODE||''' 企业社会信用代码长度异常，需满足18位要求';
   end if;
    /*结束校验 供应商建档部分 end*/
    
    /*开始校验 企业归属人部分 begin*/
    if pi_phone is null then
       PO_RESULT:=-14;
       PO_MESSAGE:='建档失败：物料供应商编号'''||PI_SUPPLIER_CODE||'''所属的联系电话缺失,请在物料供应商档案补充';       
    end if;
    /*结束校验 企业归属人部分 end*/
    
    --存在错误消息，结束过程
    if po_message is not null then return; end if;
    
    --第一步: 创建个人账户：
    begin
     pkg_plat_comm.p_user_register(pi_moblie       => pi_phone,
                                   pi_uuid         => null,
                                   pi_devicesystem => null);
     
     select max(a.user_id)
       into v_user_id
       from sys_user a 
      where a.user_account=pi_phone;
     
     if v_user_id is null then
       PO_RESULT:=-20;
       PO_MESSAGE:='创建个人账户失败，请联系管理员';
     else
       --更新用户登录密码,用户名，初始密码888888
       update scmdata.sys_user a
       set a.password = '496d234c7d6f6f7a422d634747632d4273616173422d6d05',
           a.username=pi_supplier_abbreviation,
           a.nick_name=pi_supplier_abbreviation
     where a.user_id = v_user_id;
     
   
     end if;
     
     exception when others then
       PO_RESULT:=-21;
       PO_MESSAGE:=(RTRIM(substrb('PACKAGE_ERROR:'
                          ||SQLERRM||':PKG_COMPANY_MANAGE.P_REGISTER_MRP:'
                          ||to_char(SQLCODE), 1, 255)));
    end ;
    
    if po_message is not null then return; end if;
    --第二步：创建企业账户： 创建的企业账户非默认企业，需要更新
     scmdata.PKG_USER_MY_COMPANY.P_register_company(pi_user_id     => v_user_id,
                                           pi_logo        => '-1',
                                           pi_name        => pi_supplier_abbreviation,
                                           pi_logn_name   => pi_supplier_name,
                                           pi_LICENCE_NUM => pi_LICENCE_NUM,
                                           pi_tips        => null,
                                           po_result      => po_result,
                                           po_msg         => PO_MESSAGE,
                                           pi_company_role => v_company_role);
    /*创建企业后校验*/
    if po_message is not null then 
      return; 
    else
      --预防出现2家一样的信用代码公司出现,大概率不会，结构有做限制，以防万一
      select max(a.company_id),count(*)
        into po_company_id,p_i
        from sys_company a
       where a.licence_num=pi_LICENCE_NUM;
      if po_company_id is not null then
        if p_i>1 then
          PO_RESULT:=-22;
        PO_MESSAGE:='创建企业账户失败，该企业 "'||pi_supplier_name||' "社会信用代码 "'||pi_LICENCE_NUM||'" 已存在账户，请确认其唯一性';
        end if;
      else
        PO_RESULT:=-23;
        PO_MESSAGE:='创建企业账户失败，请联系管理员查看';
      end if;
    end if;
    
    --第三步，更改创建者简称，默认企业
     --更新企业用户表昵称,待定
     update scmdata.sys_company_user a
         set a.company_user_name = pi_supplier_abbreviation, 
             a.nick_name         = pi_supplier_abbreviation
       where a.user_id = v_user_id and a.company_id=po_company_id;
       
      --设置默认值 
     if scmdata.PKG_USER_DEFAULT_COMPANY.F_count_user_company(v_user_id) = 1 then
      scmdata.PKG_USER_DEFAULT_COMPANY.P_user_company_default_when_user_change(v_user_id,
                                                                       po_result,
                                                                       PO_MESSAGE);
     end if;
    
end;   

  Procedure P_COMPANY_REVERSE_REGISTER(PI_SUPPLIER_CODE     IN VARCHAR2,
                                       PI_COMPANY_ROLE      IN VARCHAR2,
                                       PO_RESULT            OUT NUMBER,
                                       PO_MESSAGE           OUT VARCHAR2,
                                       PO_COMPANY_ID        OUT VARCHAR2
                                      )
is
begin
  --初始化输出参数
   PO_RESULT:=0;
   PO_MESSAGE:=NULL;
   PO_COMPANY_ID:=NULL;
  
  --成品供应商反向注册暂未开发，留个口
  if pi_company_role='supp' then
    NULL;
  --物料供应商反正注册
  elsif pi_company_role='mrpp' then
    P_REGISTER_MRP(PI_SUPPLIER_CODE,PO_RESULT,PO_MESSAGE,PO_COMPANY_ID);
  --其他类型后续补充
  else
    PO_RESULT:=-1;
    PO_MESSAGE:='传入的企业类型'''||PI_COMPANY_ROLE||'''暂不支持，调用失败';
    PO_COMPANY_ID:=NULL;
  end if;
  EXCEPTION WHEN OTHERS THEN
    PO_RESULT:=-400;
    PO_MESSAGE:=(RTRIM(substrb('PACKAGE_ERROR:'||SQLERRM||':PKG_COMPANY_MANAGE.P_COMPANY_REVERSE_REGISTER:'||to_char(SQLCODE), 1, 255)));
    PO_COMPANY_ID:=NULL;
end;
end PKG_COMPANY_MANAGE;
/

