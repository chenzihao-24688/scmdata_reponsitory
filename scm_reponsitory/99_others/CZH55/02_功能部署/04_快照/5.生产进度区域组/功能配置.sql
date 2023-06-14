--select  noshow_fields
SELECT ROWID, t.*
  FROM bw3.sys_item_list t
 WHERE t.item_id IN ('a_product_110', 'a_product_150', 'a_product_116','a_report_120');

--look_a_supp_151
SELECT * from bw3.sys_look_up t WHERE t.element_id = 'look_a_supp_151';
SELECT ROWID,t.* from bw3.sys_item_element_rela t WHERE t.item_id IN ('a_product_110', 'a_product_150', 'a_product_116','a_report_120') AND t.element_id = 'look_a_supp_151';
--caption ·Ö×éÃû³Æ
SELECT rowid,t.* from bw3.sys_field_list t WHERE t.field_name = 'GROUP_NAME_DESC';

--pkg
scmdata.pkg_production_progress
scmdata.pkg_db_job
