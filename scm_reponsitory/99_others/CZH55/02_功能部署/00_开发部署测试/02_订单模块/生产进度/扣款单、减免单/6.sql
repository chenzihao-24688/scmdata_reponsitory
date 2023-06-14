???prompt Importing table nbw.sys_file_template...
set feedback off
set define off
insert into nbw.sys_file_template (ELEMENT_ID, CAPTION, ICON_NAME, TEMP_TYPE, FILE_ID, SELECT_SQL, KEY_FIELD, BEFORE_SQL, EXECUTE_SQL, EXECUTE_FIELDS, AFTER_SQL, AFTER_FIELDS, REFRESH_FLAG, MULTI_SELECT_FLAG)
values ('word_a_product_130_1', '生成扣款单', null, 2, 'KIT_TEMPLATE_FILE_ID', 'SELECT ''DT0001'' template_code,
       a.company_id,
       (SELECT sp.supplier_company_name
          FROM scmdata.t_supplier_info sp
         WHERE sp.company_id = a.company_id
           AND sp.supplier_code = a.supplier_code) supplier_company_name,
       a.order_code,
       (SELECT SUM(td.actual_discount_price)
          FROM scmdata.t_deduction td
         WHERE td.company_id = a.company_id
           AND td.order_id = a.order_code) total_money
  FROM scmdata.t_ordered a
 WHERE a.company_id = %default_company_id%
   AND a.order_code = :order_code', 'order_code', 'DELETE sys_group_template_attachment t
 WHERE attachment_id = :company_id
   AND template_code = :template_code', 'SELECT a.template_code,
       a.param_name,
       a.field_name,
       b.template_name,
       b.kit_template_file_id
  FROM sys_group_template_detail a
 INNER JOIN sys_group_template b
    ON a.template_code = b.kit_template_code
 WHERE a.template_code = :template_code', 'template_code', 'INSERT INTO sys_group_template_attachment
  (attachment_id, template_code, attachname, file_id)
VALUES
  (:company_id, :template_code, :UNIQUE, :file_id)', null, 1, 1);

insert into nbw.sys_file_template (ELEMENT_ID, CAPTION, ICON_NAME, TEMP_TYPE, FILE_ID, SELECT_SQL, KEY_FIELD, BEFORE_SQL, EXECUTE_SQL, EXECUTE_FIELDS, AFTER_SQL, AFTER_FIELDS, REFRESH_FLAG, MULTI_SELECT_FLAG)
values ('word_a_product_130_2', '生成扣款减免单', null, 2, 'KIT_TEMPLATE_FILE_ID', 'WITH total_cal AS
 (SELECT SUM(td.actual_discount_price) total_money,
         SUM(td.adjust_price) total_reduction_price,
         SUM(td.actual_discount_price) total_actual_discount_price
    FROM scmdata.t_deduction td
   WHERE td.company_id = %default_company_id%
     AND td.order_id = :order_code)
SELECT ''DT0002'' template_code,
       a.company_id,
       a.order_code,
       (SELECT sp.supplier_company_name
          FROM scmdata.t_supplier_info sp
         WHERE sp.company_id = a.company_id
           AND sp.supplier_code = a.supplier_code) supplier_company_name,
       (SELECT td1.total_money FROM total_cal td1) total_money,
       '''' total_reduratio,
       (SELECT td2.total_reduction_price FROM total_cal td2) total_reduprice,
       (SELECT td3.total_actual_discount_price FROM total_cal td3) total_actprice
  FROM scmdata.t_ordered a
 WHERE a.company_id = %default_company_id%
   AND a.order_code = :order_code', 'order_code', 'DELETE sys_group_template_attachment t
 WHERE attachment_id = :company_id
   AND template_code = :template_code', 'SELECT a.template_code,
       a.param_name,
       a.field_name,
       b.template_name,
       b.kit_template_file_id
  FROM sys_group_template_detail a
 INNER JOIN sys_group_template b
    ON a.template_code = b.kit_template_code
 WHERE a.template_code = :template_code', 'template_code', 'INSERT INTO sys_group_template_attachment
  (attachment_id, template_code, attachname, file_id)
VALUES
  (:company_id, :template_code, :UNIQUE, :file_id)', null, 1, 1);

prompt Done.
