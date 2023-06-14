DECLARE
  v_sql CLOB;
BEGIN
  v_sql := 'DECLARE
  v_itf_id       VARCHAR2(32);
  v_ctl_id       VARCHAR2(32);
  v_flag         VARCHAR2(32);
  v_supp_info_id VARCHAR2(100);
  v_itf_flag     NUMBER;
  supp_itf_rec   t_supplier_base_itf%ROWTYPE;
  supp_ctl_rec   t_supplier_info_ctl%ROWTYPE;
BEGIN

  SELECT COUNT(1)
    INTO v_itf_flag
    FROM t_supplier_base_itf t
   WHERE t.sup_id_base = :sup_id_base;

  --判断接口表是否已经存在181回传供应商编码

  IF v_itf_flag > 0 THEN
    null;
  ELSE
    --1.接口表
    v_itf_id := sys_guid();
    -- 1.记录接口表信息
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
       fetch_flag,
       pause,
       supp_date,
       memo)
    VALUES
      (v_itf_id,
       :supplier_code,
       :sup_id_base,
       :sup_name,
       '''',
       '''',
       '''',
       '''',
       '''',
       '''',
       '''',
       '''',
       '''',
       '''',
       '''',
       '''',
       :create_id,
       to_date(:create_date_itf, ''yyyy-mm-dd hh24:mi:ss''),
       :update_id,
       to_date(:update_time, ''yyyy-mm-dd hh24:mi:ss''),
       ''181'',
       sysdate,
       ''I'',
       1,
       '''',
       '''',
       '''');
    --2.记录接口表信息到监控表

    v_ctl_id := sys_guid();

    INSERT INTO t_supplier_info_ctl
      (ctl_id,
       itf_id,
       itf_type,
       batch_id,
       batch_num,
       batch_time,
       sender,
       receiver,
       send_time,
       receive_time,
       return_type,
       return_msg)
    VALUES
      (v_ctl_id,
       v_itf_id,
       ''供应商获取回传编号'',
       '''',
       '''',
       '''',
       ''181'',
       ''scm'',
       to_date(:send_time, ''yyyy-mm-dd hh24:mi:ss''),
       SYSDATE,
       ''Y'', --根据校验数据确定,待确定
       ''数据校验成功'' --根据校验数据确定,待确定
       );

    --3.关联供应商档案
    UPDATE scmdata.t_supplier_info sp
       SET sp.inside_supplier_code = :sup_id_base
     WHERE sp.company_id = ''b6cc680ad0f599cde0531164a8c0337f'' and
     sp.supplier_code = :supplier_code;

  END IF;
END;';
  UPDATE bw3.sys_action t
     SET t.port_sql = v_sql
   WHERE t.element_id = 'action_a_supp_110_9';
END;
