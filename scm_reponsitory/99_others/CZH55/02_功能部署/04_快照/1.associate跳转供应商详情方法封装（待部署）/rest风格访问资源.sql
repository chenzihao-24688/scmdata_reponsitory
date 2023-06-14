SELECT ROWID, t.*
  FROM nbw.sys_action t
 WHERE t.element_id = 'action_a_product_118_5_all';

SELECT ROWID,t.* from nbw.sys_element T WHERE t.element_id IN ('associate_a_supp_160_1','associate_a_supp_160_1_1');
SELECT ROWID,t.* from nbw.sys_associate t WHERE t.element_id IN ('associate_a_supp_150_2','associate_a_supp_160_1','associate_a_supp_160_1_1','associate_a_supp_151_7');
SELECT ROWID,t.* from nbw.sys_item_element_rela t WHERE t.element_id IN ('associate_a_supp_150_2','','associate_a_supp_160_1','associate_a_supp_160_1_1','associate_a_supp_151_7');
SELECT ROWID,t.* from nbw.sys_item_list t WHERE t.item_id IN ('a_supp_151','a_supp_161','a_report_140','a_supp_161_1');
--修改增删改查逻辑
SELECT ROWID,t.* from nbw.sys_item t WHERE t.item_id IN ('a_supp_151_1', 'a_supp_161_1', 'a_supp_171_1','a_supp_151_7','a_supp_161_3');
SELECT ROWID,t.* from nbw.sys_item_list t WHERE t.item_id IN ('a_supp_151','a_supp_161','a_report_140','a_supp_161_1','a_supp_151_1', 'a_supp_161_1', 'a_supp_171_1','a_supp_151_7','a_supp_161_3');
SELECT ROWID,t.* from nbw.sys_element_hint t WHERE t.item_id = 'a_report_140';
SELECT rowid,t.* from nbw.sys_item_rela t WHERE t.item_id = 'a_supp_161';
SELECT ROWID,t.* from nbw.sys_action t WHERE t.element_id in ('action_a_supp_151_1','action_a_supp_161_1_1','action_a_supp_161_1_2','action_a_supp_151_7_1','action_a_supp_151_7_2');
select :SUPPLIER_INFO_ID ||'/'||'GET' SUPPLIER_INFO_ID from dual;
--GET,POST,PUT,DELETE

SELECT ROWID, t.*
         FROM nbw.sys_item_list t
        WHERE t.item_id like '%a_supp_1%';
        
SELECT rowid,t.* from nbw.sys_item_rela t WHERE t.item_id IN ('a_supp_151','a_supp_161','a_supp_171');   
