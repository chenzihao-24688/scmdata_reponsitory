--2.��Ӧ�̵��� �ӿڱ�����=>ҵ���  mdmdata
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
           t.tax_id/*,
           t.sup_type*/
      FROM t_supplier_base_itf t
     WHERE t.supplier_code IN ('C03042');--©�����龰�������ֶεĹ�Ӧ�̱�Żش�
BEGIN
  --�ӿڱ�����=>ҵ���
  FOR sup_rec IN sup_cur LOOP
    
    v_sup_id_base := substr(sup_rec.supplier_code, 3, 6);
    
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
       nvl(sup_rec.legalperson,'test'),
       nvl(sup_rec.linkman,'test'),
       nvl(sup_rec.phonenumber,'18172543571'),
       nvl(sup_rec.address,'test'),
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
       nvl(null, 'test'),
       'test',
       0);
  
    --ͬ���ӿڱ��ѻ�ȡmdm���ɵĹ�Ӧ�̱��
    UPDATE mdmdata.t_supplier_base_itf itf
       SET itf.sup_id_base = to_number(v_sup_id_base), itf.update_time = SYSDATE   
     WHERE itf.itf_id = sup_rec.itf_id;
  END LOOP;

END;
--select * from mdmdata.dic_supplier_base sb where sb.sup_id_base like '%Z%';

--delete from mdmdata.dic_supplier_base sb where sb.sup_id_base in ('Z0001','Z0003'); 

--ɾ��mdm��Ӧ�̽ӿ�����
/*delete from  mdmdata.t_supplier_base_itf;
delete from mdmdata.t_supplier_info_ctl;

delete from  mdmdata.t_supplier_coop_itf;
delete from   mdmdata.t_supplier_coop_ctl;   */

select * from   mdmdata.t_supplier_base_itf;
select * from  mdmdata.t_supplier_info_ctl;


mdmdata.t_supplier_base_itf;
mdmdata.t_supplier_info_ctl;

mdmdata.t_supplier_coop_itf;
mdmdata.t_supplier_coop_ctl;
