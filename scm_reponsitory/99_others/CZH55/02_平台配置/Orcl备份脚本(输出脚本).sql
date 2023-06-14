--1.备份表

DECLARE
  v_owner        VARCHAR2(32) := upper('SCMDATA');
  v_org_tab      VARCHAR2(4000) := upper('t_ask_record;t_ask_scope;t_factory_ask;t_factory_report;t_factory_report_ability;t_supplier_info;t_supplier_shared;t_coop_scope;t_factory_ask_oper_log;t_contract_info;t_supplier_type');
  v_bak_tab      VARCHAR2(4000); --默认v_org_tab||'_bak'
  v_split        CHAR(1) := ';';
  v_user_id      VARCHAR2(32) := upper('czh55'); --工号
  v_flag         NUMBER;
  v_tab_comm     VARCHAR2(4000);
  v_sql          CLOB;
  v_tab_comm_sql CLOB;
  v_col_comm_sql CLOB;

BEGIN
  --记录至备份表
  FOR str_rec IN (SELECT regexp_substr(v_org_tab,
                                       '[^' || v_split || ']+',
                                       1,
                                       LEVEL,
                                       'i') AS org_tab
                    FROM dual
                  CONNECT BY LEVEL <=
                             length(v_org_tab) -
                             length(regexp_replace(v_org_tab, v_split, '')) + 1) LOOP
    INSERT INTO scmdata.t_table_bakup
    VALUES
      (scmdata.f_get_uuid(),
       v_owner,
       str_rec.org_tab,
       str_rec.org_tab || '_BAK',
       v_user_id,
       SYSDATE,
       'P');
  END LOOP;
  --动态sql 生成备份表
  FOR p_tab_rec IN (SELECT t.bak_id, t.owner, t.org_tab, t.bak_tab
                      FROM scmdata.t_table_bakup t
                     WHERE t.owner = v_owner
                       AND t.create_id = v_user_id
                       AND t.status IN ('P', 'F')) LOOP
    --判断是否存在表   
    SELECT COUNT(1)
      INTO v_flag
      FROM all_tab_comments t
     WHERE t.owner = p_tab_rec.owner
       AND t.table_name = p_tab_rec.org_tab;
  
    IF v_flag > 0 THEN
    
      /*EXECUTE IMMEDIATE*/
      v_sql := 'CREATE TABLE ' || v_owner || '.' || p_tab_rec.bak_tab || ' AS
        SELECT * FROM ' || v_owner || '.' ||
               p_tab_rec.org_tab || '';
    
      SELECT t.comments
        INTO v_tab_comm
        FROM all_tab_comments t
       WHERE t.owner = p_tab_rec.owner
         AND t.table_name = p_tab_rec.org_tab;
      -- Add comments to the table 
      IF v_tab_comm IS NOT NULL THEN
        /*EXECUTE IMMEDIATE*/
        v_tab_comm_sql := 'COMMENT ON TABLE ' || v_owner || '.' ||
                          p_tab_rec.bak_tab || ' IS ''' || v_tab_comm || '''';
      END IF;
      dbms_output.put_line('--'|| p_tab_rec.org_tab ||'  '||v_tab_comm|| chr(13));
      dbms_output.put_line(v_sql || ';' || chr(13));
      dbms_output.put_line(v_tab_comm_sql || ';' || chr(13));
      -- Add comments to the columns 
      FOR p_col_comm_rec IN (SELECT t.owner,
                                    t.table_name,
                                    t.column_name,
                                    t.comments
                               FROM all_col_comments t
                              WHERE t.owner = p_tab_rec.owner
                                AND t.table_name = p_tab_rec.org_tab) LOOP
      
        /*EXECUTE IMMEDIATE*/
        v_col_comm_sql := 'COMMENT ON column ' || v_owner || '.' ||
                          p_tab_rec.bak_tab || '.' ||
                          p_col_comm_rec.column_name || ' IS ''' ||
                          p_col_comm_rec.comments || '''';
      
        dbms_output.put_line(v_col_comm_sql || ';' || chr(13));
      
      END LOOP;
      UPDATE scmdata.t_table_bakup t
         SET t.status = 'S'
       WHERE t.bak_id = p_tab_rec.bak_id;
    ELSE
      UPDATE scmdata.t_table_bakup t
         SET t.status = 'F'
       WHERE t.bak_id = p_tab_rec.bak_id;
    END IF;
  END LOOP;

END;

/*
select * from scmdata.t_table_bakup;
delete from  scmdata.t_table_bakup;
drop table  scmdata.t_supplier_info_bak;*/

--2.版本控制：备份存储过程，函数，触发器，包

/*CREATE TABLE scmdata.t_table_bakup(bak_id VARCHAR2(32) NOT NULL primary key,
                                   owner VARCHAR2(32) NOT NULL,
                                   org_tab VARCHAR2(32) NOT NULL,
                                   bak_tab VARCHAR2(32) NOT NULL,
                                   create_id VARCHAR2(32) NOT NULL,
                                   create_time DATE DEFAULT SYSDATE);*/
