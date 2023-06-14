
update bw3.sys_field_list t
   set t.check_express = '^[+]{0,1}(\d+)$'
 where t.field_name in ('PRODUCT_LINE_NUM','PRODUCT_LINE_NUM_N','AR_PRODUCT_LINE_NUM_N','AR_MACHINE_NUM_Y');

DECLARE
v_sql CLOB := 'declare
  v_new_total         number;
  v_old_total         number;
  v_id                varchar2(32);
  v_factory_report_id varchar2(32);
  v_sum               number;
begin
  select count(ability_result)
    into v_new_total
    from (@batchdata)
   where trim(ability_result) is null;
  select max(factory_report_ability_id) into v_id from (@batchdata);
  select max(factory_report_id)
    into v_factory_report_id
    from scmdata.t_factory_report_ability
   where factory_report_ability_id = v_id;

  select count(*)
    into v_old_total
    from scmdata.t_factory_report_ability
   where factory_report_ability_id not in
         (select factory_report_ability_id from (@batchdata))
     and factory_report_id = v_factory_report_id
     and trim(ability_result) is null;
  v_sum := v_new_total + v_old_total;
  if v_sum > 0 then
    raise_application_error(-20002, ''����������Ϊ��'');
  end if;
end;';
BEGIN
insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_a_check_101_3', v_sql, null, null, 'oracle_scmdata', null, null);
END;

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_a_check_101_3', 13, 'a_check_101_3', 11, 2, 0, null);

declare
  v_sql  clob := 'DECLARE
  CS_JUGSTR VARCHAR2(2048);
  V_CPSUB   VARCHAR2(512);
  V_ABSUB   VARCHAR2(512);
  JUG_STR   VARCHAR2(4);
  V_NT      NUMBER := 0;
BEGIN
  SELECT LISTAGG(COOPERATION_SUBCATEGORY, '','')
    INTO CS_JUGSTR
    FROM SCMDATA.T_FACTORY_REPORT_ABILITY
   WHERE FACTORY_REPORT_ABILITY_ID <> :FACTORY_REPORT_ABILITY_ID
     AND FACTORY_REPORT_ID = :FACTORY_REPORT_ID
     AND COMPANY_ID = %DEFAULT_COMPANY_ID%;

  SELECT LISTAGG(COOPERATION_SUBCATEGORY, '';'')
    INTO V_CPSUB
    FROM SCMDATA.T_ASK_SCOPE
   WHERE (OBJECT_ID, BE_COMPANY_ID) IN
         (SELECT FACTORY_ASK_ID, COMPANY_ID
            FROM SCMDATA.T_FACTORY_REPORT
           WHERE FACTORY_REPORT_ID = :FACTORY_REPORT_ID
             AND COMPANY_ID = %DEFAULT_COMPANY_ID%);

  SELECT max(COOPERATION_SUBCATEGORY)
    INTO V_ABSUB
    FROM SCMDATA.T_FACTORY_REPORT_ABILITY
   WHERE FACTORY_REPORT_ABILITY_ID = :FACTORY_REPORT_ABILITY_ID
     AND COMPANY_ID = %DEFAULT_COMPANY_ID%;

  SCMDATA.PKG_FACTORY_INSPECTION.P_JUG_MULTI_SUBCATE(V_MULTI  => CS_JUGSTR,
                                                     V_SINGLE => :COOPERATION_SUBCATEGORY);

  IF TRIM(:INCOMPATIBLE_REASON) IS NULL AND :ABILITY_RESULT = ''DISAGREE'' THEN
    RAISE_APPLICATION_ERROR(-20002,
                            ''�������������Ϊ��ͨ��ʱ��������ԭ����'');
  ELSE
    /*ԭ����  IF INSTR(V_CPSUB||'';^^^^'',V_ABSUB||'';^^^^'') > 0 AND
    V_ABSUB <> :COOPERATION_SUBCATEGORY THEN
                RAISE_APPLICATION_ERROR(-20002,
                         ''�鳧����-��������Ӧ��-���������Χ�������������ݣ������޸�'');*/
    /*  lsl167�޸�
    ��Ӧ����ά�Ż�����Ʒ����ɾ�����������ٱ���һ�����ϵĲ�Ʒ���� */
    ---�޸Ŀ�ʼ ��������2022-03-31
    ---20221226�Ż�����
    ---20230310 lsl167 �޸�
    if substr(:FACTORY_REPORT_ABILITY_ID, 0, 2) <> ''RA'' then
      for i in (select regexp_substr(:COOPERATION_SUBCATEGORY,
                                     ''[^;]+'',
                                     1,
                                     level) v_char
                  from dual
                connect by level <= length(:COOPERATION_SUBCATEGORY) -
                           length(regexp_replace(:COOPERATION_SUBCATEGORY,
                                                          '';'',
                                                          '''')) + 1) loop
        if instr(V_CPSUB, i.v_char) > 0 then
          V_NT := V_NT + 1;
        end if;
      end loop;
      IF V_NT = 0 THEN
        RAISE_APPLICATION_ERROR(-20002,
                                ''�������鳧�д�������������Χ��ֻ�����������ɾ������ԭ���ݲ���ȫ��ɾ�������뱣��һ��ԭ��Ʒ���ࡣ'');
        ---�޸Ľ��� end
      
      END IF;
    end if;
    UPDATE SCMDATA.T_FACTORY_REPORT_ABILITY
       SET COOPERATION_TYPE           = :COOPERATION_TYPE,
           COOPERATION_CLASSIFICATION = :COOPERATION_CLASSIFICATION,
           COOPERATION_PRODUCT_CATE   = :COOPERATION_PRODUCT_CATE,
           COOPERATION_SUBCATEGORY    = :COOPERATION_SUBCATEGORY,
           ABILITY_RESULT             = :ABILITY_RESULT,
           INCOMPATIBLE_REASON        = :INCOMPATIBLE_REASON
     WHERE FACTORY_REPORT_ABILITY_ID = :FACTORY_REPORT_ABILITY_ID
       AND COMPANY_ID = %DEFAULT_COMPANY_ID%;
  
  END IF;
END;';
  v1_sql clob := 'DECLARE
  JUG_NUM   NUMBER(4);
  CCCP_SIN  VARCHAR2(256);
  CCCP_STR  VARCHAR2(2048);
  EXE_SQL CLOB := ''DELETE FROM SCMDATA.T_FACTORY_REPORT_ABILITY WHERE FACTORY_REPORT_ABILITY_ID=:A'';
BEGIN
  IF SUBSTR(:FACTORY_REPORT_ABILITY_ID,0,2) <> ''RA'' THEN
    RAISE_APPLICATION_ERROR(-20002,''���鳧����-���������Χ�д�������ݲ���ɾ��������ȡ�������±༭��'');
  END IF;

  SELECT COOPERATION_SUBCATEGORY
    INTO CCCP_SIN
    FROM SCMDATA.T_FACTORY_REPORT_ABILITY
   WHERE FACTORY_REPORT_ABILITY_ID = :FACTORY_REPORT_ABILITY_ID
     AND COMPANY_ID = %DEFAULT_COMPANY_ID%;

  SELECT LISTAGG(COOPERATION_SUBCATEGORY,'';^^^^'')
    INTO CCCP_STR
    FROM SCMDATA.T_ASK_SCOPE
   WHERE (OBJECT_ID, BE_COMPANY_ID) IN
         (SELECT FACTORY_ASK_ID, BE_COMPANY_ID
            FROM SCMDATA.T_FACTORY_ASK
           WHERE (FACTORY_ASK_ID, COMPANY_ID) IN
                 (SELECT FACTORY_ASK_ID, COMPANY_ID
                    FROM SCMDATA.T_FACTORY_REPORT
                   WHERE FACTORY_REPORT_ID = :FACTORY_REPORT_ID
                     AND COMPANY_ID = %DEFAULT_COMPANY_ID%));

  IF INSTR(CCCP_STR||'';^^^^'',CCCP_SIN||'';^^^^'') = 0 THEN
    EXECUTE IMMEDIATE EXE_SQL USING :FACTORY_REPORT_ABILITY_ID;
  ELSE
    RAISE_APPLICATION_ERROR(-20002,''���鳧����-���������Χ�д�������ݲ���ɾ��������ȡ�������±༭��'');
  END IF;
END;';
begin
  update bw3.sys_item_list t
     set t.update_sql = v_sql, t.delete_sql = v1_sql
   where t.item_id = 'a_check_101_3';
end;
/
