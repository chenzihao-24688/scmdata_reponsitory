--熊猫主数据-供应商档案接口开发
DELETE FROM t_supplier_base_itf;
DELETE FROM t_supplier_info_ctl;
delete from mdmdata.dic_supplier_base t where t.sup_id_base like '%Z%';
/*
delete from  mdmdata.t_supplier_base_itf;
delete from mdmdata.t_supplier_info_ctl;

delete from mdmdata.dic_supplier_base t where t.sup_id_base like '%Z%';


delete from  mdmdata.t_supplier_coop_itf;
delete from   mdmdata.t_supplier_coop_ctl;   
*/
--SELECT * FROM mdmdata.dic_supplier_base t where t.sup_id_base like '%Z%';
--select * from t_supplier_base_itf;
--select * from T_SUPPLIER_INFO_CTL;
--1.
select * from mdmdata.dic_supplier_base t where t.sup_id_base like '%Z%';
DECLARE
  v_itf_id VARCHAR2(100);
BEGIN
  v_itf_id := sys_guid();
  INSERT INTO t_supplier_base_itf
    (itf_id,
     supplier_code,
     sup_id_base,
     sup_name,
     legalperson,
     linkman,
     phonenumber,
     address,
     sup_type,
     sup_type_name,
     sup_status,
     countyid,
     provinceid,
     cityno,
     tax_id,
     cooperation_model,
     create_id,
     create_time,
     update_id,
     update_time,
     publish_id,
     publish_time,
     data_status,
     fetch_flag)
  VALUES
    (v_itf_id,
     :supplier_code,
     '',
     :supplier_company_name,
     :legal_representative,
     :company_contact_person,
     :company_contact_phone,
     :company_address,
     '',
     '',
     '',
     :company_county,
     :company_province,
     :company_city,
     :social_credit_code,
     :cooperation_model_sp,
     :create_id,
     :insert_time,
     :update_id,
     :update_time,
     :userid,
     SYSDATE,
     '新增',
     0);
END;

--2.供应商档案 接口表数据=>业务表
DECLARE
  v_sup_id_base VARCHAR2(100);
  CURSOR sup_cur IS
    SELECT t.itf_id,
           t.supplier_code,
           t.sup_name,
           t.legalperson,
           t.linkman,
           t.phonenumber,
           t.address,
           t.create_time,
           t.countyid,
           t.provinceid,
           t.cityno,
           t.tax_id,
           t.sup_type
      FROM t_supplier_base_itf t
     WHERE t.supplier_code IN ('C02988','C02987');
BEGIN
  --接口表数据=>业务表
  FOR sup_rec IN sup_cur LOOP
    v_sup_id_base := 'Z' || substr(sup_rec.supplier_code, 3, 6);
    dbms_output.put_line(v_sup_id_base);
    INSERT INTO mdmdata.dic_supplier_base
      (sup_id_base,
       sup_name,
       legalperson,
       linkman,
       phonenumber,
       address,
       createtime,
       inserttime,
       sup_status,
       countyid,
       provinceid,
       cityno,
       tax_id,
       suppaymode,
       supsettlement,
       company_type,
       sup_type,
       ticketspecies,
       taxpayer)
    VALUES
      (v_sup_id_base,
       sup_rec.sup_name,
       sup_rec.legalperson,
       sup_rec.linkman,
       sup_rec.phonenumber,
       sup_rec.address,
       sup_rec.create_time,
       sup_rec.create_time,
       'A',
       sup_rec.countyid,
       sup_rec.provinceid,
       sup_rec.cityno,
       sup_rec.tax_id,
       'test',
       'test',
       'test',
       nvl(sup_rec.sup_type, 'test'),
       'test',
       0);
  
    --同步接口表，已获取mdm生成的供应商编号
    UPDATE mdmdata.t_supplier_base_itf itf
       SET itf.sup_id_base = v_sup_id_base, itf.update_time = SYSDATE   
     WHERE itf.itf_id = sup_rec.itf_id;
  END LOOP;

END;
