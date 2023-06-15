create or replace package scmdata.pkg_user_sync is

procedure P_USER_INFO_PAUSE(pi_user_id     IN   varchar2,
                            pi_company_id  IN   varchar2,
                            po_result      OUT  number,
                            po_msg         OUT  varchar2
                            );
procedure P_USER_INFO_INSERT(PI_INNER_USER_ID IN VARCHAR2,
                             PI_USER_NAME     IN VARCHAR2,
                             PI_COMPANY_ID    IN VARCHAR2,
                             PI_SEX           IN VARCHAR2,
                             PI_BIRTH         IN VARCHAR2,
                             PI_MOBILE        IN VARCHAR2,
                             PI_DEPART        IN VARCHAR2,
                             PI_DEP_ID        IN VARCHAR2,
                             PI_STDJOBCODE    IN VARCHAR2,
                             PI_STDJOBNAME    IN VARCHAR2,
                             PI_DIRECTORID    IN VARCHAR2,
                             PO_RESULT        OUT NUMBER,
                             PO_MSG           OUT VARCHAR2
                            );
procedure P_USER_INFO_HANDLE;


end;
/

create or replace package body scmdata.pkg_user_sync is
--常量：三福企业
v_company_id constant varchar2(32) :='b6cc680ad0f599cde0531164a8c0337f';

--内部过程，离职员工处理
procedure P_USER_INFO_PAUSE(pi_user_id     IN   varchar2,
                            pi_company_id  IN   varchar2,
                            po_result      OUT  number,
                            po_msg         OUT  varchar2
                            )
is
C_str_Current_Program varchar2(100) :='PKG_USER_SYNC.P_USER_INFO_PAUSE';
begin
 
 update sys_company_user a set a.pause=1,a.update_time=sysdate,a.update_id='ADMIN'
  where a.user_id =pi_user_id and a.company_id=pi_company_id;
 update sys_user_company a set a.pause=1
  where a.user_id =pi_user_id and a.company_id=pi_company_id;
        /*在多企业下，禁用当前企业：
            情况1： 存在多个默认 ：不处理
            情况2：不存在默认： 选择一个
            情况3：只有一个默认：不处理
          在当企业下：不处理
          结论：通过sum(is_default)来识别：
                 存在其他企业，则有值：=0需要设置一家企业默认值，属于情况2；>0属于情况1与情况3
                 不存在其他企业，没值，不进循环，无需处理
        */
 for item in (select t.user_id,max(t.user_company_id) user_company_id,sum(t.is_default) default_count 
                from sys_user_company t
               where t.user_id =pi_user_id  and t.company_id<>pi_company_id and t.pause=0
                 group by t.user_id) loop
     --设置其他企业为默认企业
     update sys_user_company a 
        set a.is_default=1  
      where a.user_id =item.user_id and a.user_company_id=item.user_company_id and item.default_count=0;
        --如果更新成功，则将当前禁用的企业默认值取消
     if sql%rowcount=1 then
       update sys_user_company a 
          set a.is_default=0
        where a.user_id =item.user_id and a.company_id= pi_company_id and item.default_count=0;
     end if;
 

  end loop;
  --2023-2-22 hx87 add: 现阶段控制，未来根据平台发展可能放开：三福员工离职直接禁用平台账户
  update sys_user a set a.pause=1,a.update_time=sysdate where a.user_id=pi_user_id;
  
  po_result:=0;
  
  exception when others then
     po_result:=-1;
     po_msg:=(RTRIM(substrb('PACKAGE_ERROR:' || SQLERRM || ':' ||C_str_Current_Program || ':' ||
                             to_char(SQLCODE),1,255)));

end;
--新用户插入
PROCEDURE P_USER_INFO_INSERT(PI_INNER_USER_ID IN VARCHAR2,
                             PI_USER_NAME     IN VARCHAR2,
                             PI_COMPANY_ID    IN VARCHAR2,
                             PI_SEX           IN VARCHAR2,
                             PI_BIRTH         IN VARCHAR2,
                             PI_MOBILE        IN VARCHAR2,
                             PI_DEPART        IN VARCHAR2,
                             PI_DEP_ID        IN VARCHAR2,
                             PI_STDJOBCODE    IN VARCHAR2,
                             PI_STDJOBNAME    IN VARCHAR2,
                             PI_DIRECTORID    IN VARCHAR2,
                             PO_RESULT        OUT NUMBER,
                             PO_MSG           OUT VARCHAR2
                            )
IS
  C_str_Current_Program constant varchar2(300):='PKG_USER_SYNC.P_INSERT_USER_INFO';
   v_user_id         VARCHAR2(32); --用户表主键
   v_user_count      number(3);
BEGIN
    
  
   select max(user_id),count(*) into v_user_id,v_user_count
   from sys_user a where a.user_account=pi_mobile;
   
   if v_user_id is null then --不存在平台账户，才调用
     --1.调用注册平台账户方法,内含校验
     scmdata.pkg_plat_comm.p_user_register(PI_mobile,null,null);
   else
     po_result:=-2;
     po_msg:='该手机号已注册平台';
     return;
   end if;
   --验证是否注册成功，获取id与用户数
  select max(user_id),count(*) into v_user_id,v_user_count
   from sys_user a where a.user_account=pi_mobile;
   
  if v_user_count<>1 then 
    po_result:=-1;
    po_msg:='该手机号注册平台用户失败，调用注册方法失败';
    return;
  else 
    update sys_user a 
       set a.nick_name=PI_USER_NAME,
           a.sex=PI_SEX,
           a.birthday=PI_BIRTH
     where a.user_id=v_user_id;
  end if;
  --2.调用申请加入企业方法
  PKG_USER_MY_COMPANY.P_user_company_join(v_user_id,pi_company_id,'系统接口接入，自动申请加入',po_result,
                                         po_msg);
  --3.完善申请信息，同步至企业内部表
   if nvl(po_result,0)=0 then
     
     update sys_user_company_join a
        set a.dept_id       =PI_DEP_ID,
            a.inner_user_id =PI_INNER_USER_ID,
            a.dept_name     =PI_DEPART,
            a.stdjobcode    =PI_STDJOBCODE,
            a.stdjobname    =PI_STDJOBNAME
     where company_id = pi_company_id
         and user_id = v_user_id;
   else--存在错误，直接返回
     return;
   end if;
   --执行成功
   po_result:=0;
   po_msg:=null;
  exception when others then
    po_result:=-1;
    po_msg:=(RTRIM(substrb('PACKAGE_ERROR:' || SQLERRM || ':' ||C_str_Current_Program || ':' ||
                             to_char(SQLCODE),1,255)));
END;

procedure P_USER_INFO_HANDLE
is
  v_pause         int;
  v_user_count    int;
  v_inner_user_id varchar2(32);
  v_user_id       varchar2(32);
  v_flag          int;
  v_result        number(2);
  v_msg           varchar2(300);
begin
  for item in (select * from cmx_sys_users_itf a where a.process_time is null order by a.batch_id asc,a.userid asc) loop
    --初始化置空
     v_flag:=null;
    --1.查找是否存在员工记录
    select max(t.pause),count(*) ,max(t.inner_user_id),max(t.user_id)
      into v_pause,v_user_count ,v_inner_user_id,v_user_id
      from sys_company_user t
     where t.inner_user_id=item.userid 
       and t.company_id=v_company_id;
       
    --2.不存在有2种情况：a.实际不存在，2.实际存在，内部员工号未填导致无法匹配到
    if v_pause is null  then--找不到记录，进行插入操作，进入待确认数据，生成平台用户信息，直接进入三福企业

       
       if item.mobile is not null then 
         --插入员工申请： 调用注册与申请方法
         P_USER_INFO_INSERT(item.userid,item.username,v_company_id,item.sex,item.birth,item.mobile,
                            item.depart,item.dep_id,item.stdjobcode,item.stdjobname,item.directorid,
                            v_result,v_msg);
       else  
         v_result:=-1;
         v_msg:='手机号为空，无法系统插入至待加入名单';
       end if;   
        
       if v_result =0 then v_flag:=1; else v_flag:=0; end if;
       
    else--匹配到，进行多重验证
      if v_user_count>1 then--匹配多条数据，不处理
         v_flag:=0;
      elsif v_pause=1 and item.quittime is not null then --已停用，且离职的数据，不处理
         v_flag:=0;
      elsif v_pause in (0,2) and item.quittime is not null then --未停用，已离职的数据，处理
         v_flag:=1;
    end if;
    
    if v_flag=1 and v_inner_user_id is not null then --需要更新信息，离职处理，且内部员工号有值的情况下，才触发自动禁用
       p_user_info_pause(v_user_id,v_company_id,v_result,v_msg);
       if v_result <>0 then
         --标记失败,记录错误
         v_flag:=0;
       end if;
    end if;
    
    end if;--最外层判断
    
    if v_flag =1 then  --处理接口表，打上标记
      update cmx_sys_users_itf t
         set t.process_time=sysdate,t.process_status='S'
       WHERE T.BATCH_ID=ITEM.BATCH_ID AND T.USERID=ITEM.USERID;
    ELSE
       update cmx_sys_users_itf t
         set t.process_time=sysdate,
             t.process_status= case when v_msg is null or v_msg is not null and v_result=-2 then 'D' 
                               else  'F' end,
             T.error_msg =v_msg
       WHERE T.BATCH_ID=ITEM.BATCH_ID AND T.USERID=ITEM.USERID;
    END IF;
    
  end loop;--循环结束
end;

end;
/

