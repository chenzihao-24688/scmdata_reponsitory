--http://172.28.40.189:9090
--http://172.28.40.62:9090/lion/scm/api/v1
select * from bw3.sys_data_source;
select rowid,t.* from bw3.sys_item t where t.item_id in('czh2006','czh2007','czh2008','czh2009','itf_a_supp_140','itf_a_supp_141');
select rowid,t.* from bw3.sys_tree_list t where t.item_id in('czh2006','czh2007','czh2008','czh2009','itf_a_supp_140','itf_a_supp_141');   
select rowid,t.* from bw3.sys_item_list t where t.item_id in('czh2006','czh2007','czh2008','czh2009','itf_a_supp_140','itf_a_supp_141'); --czh2008 czh2007

select rowid,t.* from bw3.xxl_job_info t ; 

select rowid,t.* from bw3.sys_open_info t;
SELECT ROWID, t.* FROM bw3.sys_open_interface t;
SELECT ROWID, t.* FROM bw3.sys_method t where t.method_id in ('method_czh2006','method_czh2007','method_itf_a_supp_140','method_itf_a_supp_141'); --czh2007
SELECT ROWID, t.* FROM bw3.sys_port_http t where t.port_name in('port_czh2006','port_czh2007','port_itf_a_supp_140','port_itf_a_supp_141');
SELECT ROWID, t.* FROM bw3.sys_port_method t where t.method_id in ('method_czh2006','method_czh2007','method_itf_a_supp_140','method_itf_a_supp_141');
SELECT ROWID, t.* FROM bw3.sys_port_map t where t.port_name in('port_czh2006','port_czh2007','port_itf_a_supp_140','port_itf_a_supp_141');
SELECT ROWID, t.* FROM bw3.sys_action t where t.element_id in ('action_czh2006','action_czh2007','action_itf_a_supp_140','action_itf_a_supp_141');
SELECT ROWID, t.* FROM bw3.sys_port_submap t ; --a_supp_100

SELECT ROWID, t.* FROM bw3.sys_element t where t.element_id like '%action_itf_a_supp%';
SELECT ROWID, t.* FROM bw3.sys_action t where t.element_id like '%action_itf_a_supp%';
SELECT ROWID, t.* FROM bw3.sys_item_element_rela t where t.element_id like '%action_itf_a_supp%';

SELECT ROWID, t.* FROM bw3.sys_element t where t.element_id like '%czh%';
SELECT ROWID, t.* FROM bw3.sys_action t where t.element_id like '%czh%';
SELECT ROWID, t.* FROM bw3.sys_item_element_rela t where t.element_id like '%czh%';

select rowid,t.* from bw3.sys_param_list t where t.param_name = 'BATCH_TIME';
SELECT rowid,t.* FROM bw3.sys_field_list t WHERE t.field_name = 'PUBLISH_TIME'; --SUP_ID_BASE czh2000
select * from nsfdata.supplier_base t where t.sup_id_base like '%Z%';

select rowid,t.* from bw3.sys_item_list t where t.item_id = 'itf_a_supp_140'; 

select * from mdmdata.t_supplier_base_itf;
select * from  mdmdata.t_supplier_info_ctl;

select * from nsfdata.t_supplier_base_itf;
select * from  nsfdata.t_supplier_info_ctl;

delete from  mdmdata.t_supplier_base_itf;
delete from   mdmdata.t_supplier_info_ctl;           

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

INSERT INTO bw3.sys_field_list (field_name,caption,requiered_flag,read_only_flag,no_edit,no_copy,no_sort,alignment,ime_care,ime_open)
VALUES('SUPP_DATE', '建档时间', 0, 0, 0, 0, 0, 0, 0, 0);

INSERT INTO bw3.sys_field_list (field_name,caption,requiered_flag,read_only_flag,no_edit,no_copy,no_sort,alignment,ime_care,ime_open)
VALUES('REMARKS', '备注', 0, 0, 0, 0, 0, 0, 0, 0);
