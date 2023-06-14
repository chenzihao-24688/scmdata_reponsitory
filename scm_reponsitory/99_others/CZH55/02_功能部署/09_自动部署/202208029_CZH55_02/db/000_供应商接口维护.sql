DECLARE
v_sql CLOB;
BEGIN
v_sql := '{DECLARE
  v_sql       VARCHAR2(4000);
  CURSOR supp_data IS
    SELECT *
      FROM scmdata.t_supplier_info sp
     WHERE sp.update_date >= sp.create_date
       AND sp.publish_date IS NULL
       AND sp.company_id = ''b6cc680ad0f599cde0531164a8c0337f'' --%default_company_id% --''b6cc680ad0f599cde0531164a8c0337f''
       AND sp.status = 1;

  CURSOR supp_data_sc IS
    SELECT *
      FROM scmdata.t_supplier_info sp
     WHERE sp.update_date > sp.publish_date
       AND sp.publish_date > sp.create_date
       AND sp.publish_date IS NOT NULL
       AND sp.company_id = ''b6cc680ad0f599cde0531164a8c0337f''
       AND sp.status = 1;
BEGIN
  --sp.create_date =< sp.update_date  and sp.publish_date IS NULL
  --sp.create_date < publish_date < sp.update_date  and sp.publish_date IS NOT NULL

IF :PUBLISH_FLAG IS NOT NULL AND  :PUBLISH_FLAG = ''Y'' THEN
  FOR supp_rec IN supp_data LOOP
    UPDATE scmdata.t_supplier_info t
       SET t.publish_id = :PUBLISH_ID,
           t.publish_date = to_date(:PUBLISH_TIME, ''yyyy-mm-dd hh24:mi:ss'')
     WHERE t.supplier_info_id = supp_rec.supplier_info_id;
  END LOOP;

  FOR supp_rec IN supp_data_sc LOOP
    UPDATE scmdata.t_supplier_info t
       SET t.publish_id = :PUBLISH_ID,
           t.publish_date = to_date(:PUBLISH_TIME, ''yyyy-mm-dd hh24:mi:ss'')
     WHERE t.supplier_info_id = supp_rec.supplier_info_id;
  END LOOP;
END IF;

  v_sql := ''SELECT sp.supplier_code,
       sp.pause,
       decode(sp.pause, 0, ''''Õý³£'''', 1, ''''Í£ÓÃ'''') coop_status,
       sp.inside_supplier_code,
       sp.supplier_company_name,
       sp.legal_representative,
       sp.company_contact_person,
       sp.company_contact_phone,
       sp.company_address,
       sp.company_type,
       sp.cooperation_model cooperation_model_sp,
       sp.company_province,
       sp.company_city,
       sp.company_county,
       sp.social_credit_code,
       sp.remarks,
       sp.create_supp_date supp_date,
       a.inner_user_id create_id,
       sp.create_date insert_time,
       b.inner_user_id update_id,
       sp.update_date update_time,
       sp.publish_id,
       sp.publish_date publish_time,
       sp.publish_date send_time
  FROM scmdata.t_supplier_info sp
 LEFT JOIN sys_company_user a
    ON a.company_id = sp.company_id
   AND a.user_id = sp.create_id
 LEFT JOIN sys_company_user b
    ON b.company_id = sp.company_id
   AND b.user_id = sp.update_id
 WHERE sp.company_id = '''''' || ''b6cc680ad0f599cde0531164a8c0337f'' || ''''''
   AND sp.status = 1
   /*AND ((sp.publish_id IS NULL AND sp.publish_date IS NULL) OR (sp.update_date > sp.create_date AND sp.update_date > sp.publish_date))*/
   AND EXISTS (SELECT 1
          FROM scmdata.t_coop_scope t
         WHERE t.supplier_info_id = sp.supplier_info_id)
 ORDER BY sp.create_date DESC, sp.supplier_code ASC'';
  --dbms_output.put_line(v_sql);
@strresult := v_sql;
END;
}';
UPDATE bw3.sys_item_list t SET t.select_sql = v_sql WHERE t.item_id = 'a_supp_140'; 
END;
/
