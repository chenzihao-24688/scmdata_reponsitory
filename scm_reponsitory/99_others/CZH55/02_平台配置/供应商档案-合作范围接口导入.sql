select * from bwptest1.sys_data_source;
select rowid,t.* from bwptest1.sys_item t where t.item_id in('czh2007','czh2008','itf_a_supp_140','itf_a_supp_141','itf_a_supp_142');   
select rowid,t.* from bwptest1.sys_tree_list t where t.item_id in('czh2007','czh2008','itf_a_supp_140','itf_a_supp_141');   
select rowid,t.* from bwptest1.sys_item_list t where t.item_id in('czh2007','czh2008','itf_a_supp_140','itf_a_supp_141','itf_a_supp_142'); --czh2008 czh2007

SELECT ROWID, t.* FROM bwptest1.sys_method t where t.method_id in ('method_czh2006','method_czh2007','method_itf_a_supp_140','method_itf_a_supp_141'); --czh2007
SELECT ROWID, t.* FROM bwptest1.sys_port_http t where t.port_name in('port_czh2006','port_czh2007','port_itf_a_supp_140','port_itf_a_supp_141');
SELECT ROWID, t.* FROM bwptest1.sys_port_method t where t.method_id in ('method_czh2006','method_czh2007','method_itf_a_supp_140','method_itf_a_supp_141');
SELECT ROWID, t.* FROM bwptest1.sys_port_map t where t.port_name in('port_czh2006','port_czh2007','port_itf_a_supp_140','port_itf_a_supp_141');
SELECT ROWID, t.* FROM bwptest1.sys_action t where t.element_id in ('action_czh2006','action_czh2007','action_itf_a_supp_140','action_itf_a_supp_141');
SELECT ROWID, t.* FROM bwptest1.sys_port_submap t ; --a_supp_100

SELECT ROWID, t.* FROM bwptest1.sys_element t where t.element_id in ('action_czh2006','action_czh2007','action_itf_a_supp_140','action_itf_a_supp_141');
SELECT ROWID, t.* FROM bwptest1.sys_action t where t.element_id in ('action_czh2006','action_czh2007','action_itf_a_supp_140','action_itf_a_supp_141');
SELECT ROWID, t.* FROM bwptest1.sys_item_element_rela t where t.element_id in ('action_czh2006','action_czh2007','action_itf_a_supp_140','action_itf_a_supp_141');

select rowid,t.* from bwptest1.sys_param_list t where t.param_name = 'BATCH_TIME';
SELECT * FROM bwptest1.sys_field_list t WHERE t.field_name = 'BATCH_TIME'; --SUP_ID_BASE czh2000

select * from mdmdata.t_supplier_coop_itf;
select * from  mdmdata.t_supplier_coop_ctl;

delete from  mdmdata.t_supplier_coop_itf;
delete from   mdmdata.t_supplier_coop_ctl;           

SELECT '' supplier_code,
       '' supplier_company_name,
       '' legal_representative,
       '' company_contact_person,
       '' company_contact_phone,
       '' company_address,
       '' company_type,
       '' company_province,
       '' company_city,
       '' company_county,
       '' social_credit_code
  FROM dual;

SELECT t.sup_id_base,
       t.sup_name,
       t.tax_id,
       t.legalperson,
       t.linkman,
       t.phonenumber,
       t.address,
       t.sup_type,
       t.sup_status,     
       t.provinceid,
       t.cityno,
       t.countyid,     
       t.company_type,
       t.itf_id,
       t.create_id,
       t.create_time,
       t.update_id,
       t.update_time,
       t.publish_id,
       t.publish_time
  FROM nsfdata.t_supplier_base_itf t;
  
SELECT t.ctl_id,
       t.itf_id,
       t.itf_type,
       t.batch_id,
       t.batch_num,
       t.batch_time,
       t.sender,
       t.receiver,
       t.send_time,
       t.receive_time,
       t.return_type,
       t.return_msg,
       t.create_id,
       t.create_time,
       t.update_id,
       t.update_time,
       t.publish_id,
       t.publish_time
  FROM nsfdata.t_supplier_info_ctl t;
