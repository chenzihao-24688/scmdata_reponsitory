create or replace package PKG_COMPANY_MANAGE is

  -- Author  : HX87
  -- Created : 2020/7/18 17:33:43
  -- Purpose : ��ҵ�����

  /*
   pi_user_id: sys_user���user_id
   pi_company_id: ��ҵ���
   purpose��У��ͬ���û��������
  */
  FUNCTION F_CHECK_USER_JOIN_AGREE(pi_user_id in varchar2,
                                   pi_company_id in varchar2, 
                                   pi_role_ID in varchar2,
                                   pi_dept_id in varchar2) return varchar2;


  /*
   pi_user_id: sys_user���user_id
   pi_company_id: ��ҵ���
   purpose��У��ܾ��û��������
  */
  FUNCTION F_CHECK_USER_JOIN_Refuse(pi_user_id in varchar2,pi_company_id in varchar2) return varchar2;
  
  /*
     pi_user_id: sys_user���user_id
     pi_company_id: ��ҵ���
     PI_REPLY_SAY���ظ����
     PI_REPLY_ID���ظ���
     pi_operate_type �����ࣺ 1 ͬ�⣻ 2 �ܾ�
     po_result   ���ؽ�� 0Ϊ�ɹ�������Ϊʧ��
     po_message  ���ؽ�� �ɹ�ʱΪ�գ�ʧ�ܷ��ش�����Ϣ
   
   purpose��ͬ��/�ܾ�������ҵ����
  */
  PROCEDURE P_USER_JOIN_AGREE(pi_user_id      in varchar2,
                              pi_company_id   in varchar2,
                              PI_REPLY_SAY    IN VARCHAR2 default 'ͬ��',
                              PI_REPLY_ID     IN VARCHAR2,
                              pi_operate_type in int,
                              pi_role_ID    in varchar2,
                              pi_dept_id    in varchar2,
                              po_result       out number,
                              po_message      out varchar2);
                              
   /*
     pi_company_id: ��ҵ���
     PI_APPLY_ID��Ӧ��ID
     PI_TYPE��1 ������  2 ����   
   purpose��У��Ӧ�ù���
  */                            
  FUNCTION F_CHECK_APP_BUY(PI_COMPANY_ID      IN VARCHAR2,
                         PI_APPLY_ID          IN VARCHAR2,
                         PI_TYPE              IN NUMBER
                         ) RETURN VARCHAR2;
  /* PI_USER_ID   ��������Ա����
     pi_company_id: ��ҵ���
     PI_APPLY_ID  ��Ӧ��ID
     PI_TYPE      ��1 ������  2 ����  
     PO_RESULT    �������ʶ(����)
     PO_MESSAGE   : �����������
   purpose��У��Ӧ�ù���
  */                                               
  PROCEDURE P_APP_BUY(PI_USER_ID      IN VARCHAR2,
                      PI_COMPANY_ID   IN VARCHAR2,
                      PI_APPLY_ID     IN VARCHAR2,
                      PI_TYPE         IN NUMBER,
                      PO_RESULT       OUT NUMBER,
                      PO_MESSAGE      OUT VARCHAR2);
  PROCEDURE P_PRIVILEGE_COND(P_PRIVID VARCHAR2);
end PKG_COMPANY_MANAGE;
/
create or replace package body PKG_COMPANY_MANAGE is
/*
   pi_user_id: sys_user���user_id
   pi_company_id: ��ҵ���
   purpose���ڲ�������ͨ��У�� ͬ��/�ܾ��û�������ҵ
*/
Function F_CHECK_USER_JOIN_COMM(pi_user_id in varchar2,pi_company_id in varchar2) RETURN VARCHAR2
IS
 v_error varchar2(100);
 v_pause int;
BEGIN
  select max(pause) into v_pause from sys_user a where a.user_id=pi_user_id;
   if v_pause is null then
     v_error:='�Ҳ�����Ա���ˣ��볢��ˢ��������';
   elsif v_pause =1 then
     v_error:='Ա���ѱ�������Ŷ���޷���ͬ�������ҵ��';
   end if;
   return v_error;
   
   select max(pause) into v_pause from sys_company a where a.company_id=pi_company_id;
   if v_pause is null then
     v_error:='δ���ָ���ҵ����Ϣ���޷����д˲���';
   elsif v_pause =1 then
     v_error:='��ҵ�ѱ�������Ŷ���޷����д˲���';
   end if;
   
   select max(pause) into v_pause from sys_company_user a where a.company_id=pi_company_id and a.user_id=pi_user_id;
   if v_pause =1 then
     v_error:='���˻��Ѽ��������ҵ�����ѱ�������';
   elsif v_pause =0 then
     v_error:='���˻��Ѽ��������ҵ';
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
begin
   v_error:=F_CHECK_USER_JOIN_COMM(pi_user_id,pi_company_id);
   if v_error is not null then
     return v_error;
   else
     select max(1) into v_i from dual 
      where not exists(select 1 from sys_company_role a 
                        where a.company_id=pi_company_id and a.company_role_ID=pi_role_ID);
     if v_i =1 then
        v_error:='δ�ҵ��ý�ɫ��������ѡ��';
        return v_error;
     end if;
     
     select max(1) into v_i from dual 
      where not exists(select 1 from sys_company_dept a 
                        where a.company_id=pi_company_id and a.company_dept_id=pi_dept_id
                          and pause=0);
     if v_i =1 and pi_dept_id is not null then
        v_error:='δ�ҵ����ţ������Ѿ������ã�������ѡ��';
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
                            PI_REPLY_SAY    IN VARCHAR2 default 'ͬ��',
                            PI_REPLY_ID     IN VARCHAR2,
                            pi_operate_type in int,
                            pi_role_ID      in varchar2,
                            pi_dept_id      in varchar2,
                            po_result       out number,
                            po_message      out varchar2)
is
 v_default      int;
 v_sort         int;
 v_company_name sys_company.company_name%type;
begin
  if pi_operate_type =1 then --ͬ�����
  po_message:= F_CHECK_USER_JOIN_AGREE(pi_user_id,pi_company_id,pi_role_ID,pi_dept_id);
  if po_message is not null then
    po_result:=-1;
    return ;
  end if;
  --������ҵ�û�Ա����Ϣ
  insert into sys_company_user(company_user_id,company_id,user_id,sort,nick_name,company_user_name,sex,
                               phone,email,pause,update_id,update_time,nationality,id_card,education,
                               profession,language,birth_place,household_type,marriage,residence_address,
                               living_address,emergency_name,emergency_contact,emergency_phone,self_evaluation,
                               inner_user_id)
   select f_get_uuid(),pi_company_id,a.user_id,1,a.nick_name,nvl(a.username,a.nick_name),a.sex,a.phone,a.email,0,PI_REPLY_ID,sysdate,
          a.nationality,a.id_card,a.education,a.profession,a.language,a.birth_place,a.household_type,a.marriage,a.residence_address,
          a.living_address,a.emergency_name,a.emergency_contact,a.emergency_phone,null,null
     from sys_user a
    where a.user_id=pi_user_id;
   
   select max(is_default),max(sort) into v_default,v_sort from   sys_user_company a where a.user_id=pi_user_id;
   
   if v_default =1 then v_default :=0; end if;--��Ĭ����ҵ������ʱ���0
   
   select max(a.COMPANY_NAME) into v_company_name from sys_company a where a.company_id=pi_company_id;
    insert into sys_user_company(user_company_id,user_id,company_id,company_alias,is_default,sort,join_time,pause)
    values(f_get_uuid(),pi_user_id,pi_company_id,v_company_name,nvl(v_default,1),nvl(v_sort+1,1),sysdate,0);
    
    --����Ա����ɫ��ϵ
    if pi_role_ID is not null then
    insert into sys_company_user_role(company_user_role_id,company_id ,user_id ,company_role_id)
     values( f_get_uuid(),pi_company_id,pi_user_id,pi_role_ID);
    end if;
    
    --Ա����������Ӧ����
    if pi_dept_id is not null then
      insert into sys_company_user_dept(user_dept_id,company_id,user_id,company_dept_id)
      values(f_get_uuid(),pi_company_id,pi_user_id,pi_dept_id);
      
      --czh add ����Ȩ��
      pkg_data_privs.authorize_emp(p_company_id => pi_company_id,p_dept_id => pi_dept_id,p_user_id => pi_user_id);
     
    end if;
    --�����û������¼
   update sys_user_company_join a 
      set a.reply_id=pi_reply_id,
          a.reply_say=PI_REPLY_SAY,
          a.reply_time=sysdate,
          a.join_status='1'
    where a.user_id=pi_user_id and a.join_status=0
      and a.company_id=pi_company_id;
  if sql%rowcount<>1 then
     po_result :=-2;
     po_message:='�����û������¼������Ŷ���뾡����ϵƽ̨����Ա����æ';
     return;
  end if;
  elsif pi_operate_type =2 then  --�ܾ�����
    po_message:= F_CHECK_USER_JOIN_Refuse(pi_user_id,po_result);
    if po_message is not null then
      po_result:=-3;
      return ;
    end if;
       --�����û������¼
     update sys_user_company_join a 
        set a.reply_id=pi_reply_id,
            a.reply_say=PI_REPLY_SAY,
            a.reply_time=sysdate,
            a.join_status='2'
      where a.user_id=pi_user_id and a.join_status=0 
        and a.company_id=pi_company_id;
    if sql%rowcount<>1 then
       po_result :=-4;
       po_message:='�����û������¼������Ŷ���뾡����ϵƽ̨����Ա����æ';
       return;
    end if;
  
  else 
     po_result :=-5;
     po_message:='��������Ч�Ĳ������ͣ��޷�ʶ��';
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
  --1.Ӧ��У��
  select max(a.apply_status),max(a.pause),max(a.is_company),max(a.apply_name)
    into v_apply_status,v_i,v_is_company,v_apply_name
    from sys_group_apply a 
   where a.apply_id=pi_apply_id ;
   if v_apply_name is null then 
     v_result:='δ�ҵ���Ӧ�ã��޷�����/��������ˢ�´����ٲ���';
     return v_result;
   end if;
   if v_i =1 then 
     v_result:='Ӧ��'''||v_apply_name||'''�ѱ����ã���ˢ�´����ٲ���';
     return v_result;
   end if;
   if v_apply_status<>'0' then
     v_result:='Ӧ��'''||v_apply_name||'''�ѱ��¼ܣ���ˢ�´����ٲ���';
     return v_result; 
   end if;
   if v_is_company <>1 then 
     v_result:=''''||v_apply_name||'''����ҵӦ�ã��޷�������ǰ����������Ӧ���̳ǹ���';
     return v_result; 
   end if;
  if pi_type not in (1,2) then
    v_result:='����Ĳ��������޷�ʶ����ȷ�Ϻ����µ���';
    return v_result;
  end if;

  --2.��ҵӦ��У�飺
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
      v_result:='Ӧ��'''||v_apply_name||'''�ѹ����޷��ٴι���';
    end if;
  elsif pi_type=2 then
    if v_apply_id is  null then 
      v_result:='Ӧ��'''||v_apply_name||'''δ�����޷�����';
    else 
      if  trunc(v_end_time)=date'2099-12-31' then
        v_result:=''''||v_apply_name||'''�����Ӧ�ã��޷�����';
      end if;
    end if;
  else
     v_result:='����Ĳ��������޷�ʶ����ȷ�Ϻ����µ���';
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
     --�ֽ׶ζ�����ѣ��ݲ�֧���շ�ģʽ
    insert into sys_company_apply_buylog(apply_buylog_id,company_id,apply_id,apply_name,tips,apply_buylog_type,
                                         unit,num,price,pay_price,start_time,end_time,create_id,create_time)
    values(f_get_uuid(),PI_COMPANY_ID,PI_APPLY_ID,v_apply_name,null,'����','��',1,0,0,sysdate,date'2099-12-31',PI_USER_ID,sysdate);
    
  elsif pi_type =2 then
    
    update sys_company_apply a set a.expired_time=date'2099-12-31' 
     where a.company_id=PI_COMPANY_ID and a.apply_id=PI_APPLY_ID;
     
    insert into sys_company_apply_buylog(apply_buylog_id,company_id,apply_id,apply_name,tips,apply_buylog_type,
                                         unit,num,price,pay_price,start_time,end_time,create_id,create_time)
    values(f_get_uuid(),PI_COMPANY_ID,PI_APPLY_ID,v_apply_name,null,'����','��',1,0,0,sysdate,date'2099-12-31',PI_USER_ID,sysdate);
  end if; 
    --��ȡ��ǿ������Ӧ�ã����Զ�����
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
        --�ֽ׶ζ�����ѣ��ݲ�֧���շ�ģʽ
        insert into sys_company_apply_buylog(apply_buylog_id,company_id,apply_id,apply_name,tips,apply_buylog_type,
                                             unit,num,price,pay_price,start_time,end_time,create_id,create_time)
        values(f_get_uuid(),PI_COMPANY_ID,item.rela_apply_id,item.apply_name,null,decode(PI_TYPE,1,'����',2,'����'),'��',1,0,0,sysdate,date'2099-12-31',PI_USER_ID,sysdate);
        
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
    SELECT COUNT(*) INTO V_COUNT  FROM NBW.SYS_COND_LIST    WHERE COND_ID like V_COND_ID||'%';

    IF V_COUNT = 0 THEN
      INSERT INTO NBW.SYS_COND_LIST
        (COND_ID, COND_SQL, COND_TYPE, DATA_SOURCE)
      VALUES
        (V_COND_ID, V_COND_SQL, 0, 'oracle_scmdata');

      INSERT INTO NBW.SYS_COND_RELA
        (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
      VALUES
        (V_COND_ID,R_PRIV.OBJ_TYPE,R_PRIV.CTL_ID,0,1,0,R_PRIV.ITEM_ID);
        
     update sys_app_privilege a set a.cond_id=v_cond_id where a.priv_id=R_PRIV.Priv_Id;
    elsif v_count>0 THEN --��������һ����
      
      --�ж�ITEM��ɾ�Ĳ�ʱ���Ƿ���һ����obj_type
      select count(*) into v_i from nbw.sys_cond_rela a
       where a.obj_type=R_PRIV.Obj_Type and a.ctl_id=R_PRIV.Ctl_Id
         and a.obj_type in (11,12,13,14);
       
      if   R_PRIV.Item_Id is not null or v_i =0 then
        V_COND_ID  := 'cond_' || R_PRIV.CTL_ID||'_auto_'||v_count;
        
          INSERT INTO NBW.SYS_COND_LIST
            (COND_ID, COND_SQL, COND_TYPE, DATA_SOURCE)
          VALUES
            (V_COND_ID, V_COND_SQL, 0, 'oracle_scmdata');

          INSERT INTO NBW.SYS_COND_RELA
            (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
          VALUES
            (V_COND_ID,R_PRIV.OBJ_TYPE,R_PRIV.CTL_ID,0,1,0,R_PRIV.ITEM_ID);
            
         update sys_app_privilege a set a.cond_id=v_cond_id where a.priv_id=R_PRIV.Priv_Id;
      end if;
      
    END IF;

  END LOOP;
END;
   
end PKG_COMPANY_MANAGE;
/
