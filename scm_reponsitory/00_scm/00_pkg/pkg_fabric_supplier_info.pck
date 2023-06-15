create or replace package scmdata.pkg_fabric_supplier_info is

  -- Author  : SANFU
  -- Created : 2021/10/13 16:34:40
  -- Purpose : 面料供应商管理
  --新增操作日志从表
  PROCEDURE insert_oper_log(p_supplier_info_id VARCHAR2,
                            oper_type          VARCHAR2,
                            p_reason           VARCHAR2,
                            p_user_id          VARCHAR2,
                            p_company_id       VARCHAR2,
                            p_create_time      DATE);

  --Purpose  : （新增，更新）保存时校验 
  PROCEDURE check_save_t_supplier_info(p_sp_data scmdata.t_fabric_supplier_info%ROWTYPE);

  -- Purpose  : 提交时触发 =》校验-供应商档案（主表，从表：合作范围必须有值） 

  PROCEDURE check_t_supplier_info(p_supplier_info_id VARCHAR2);

  --  Purpose  : 校验合同日期
  PROCEDURE check_contract_info(p_contract_rec scmdata.t_fabric_contract_info%ROWTYPE);

  --  Purpose  : 新增合同 
  PROCEDURE insert_contract_info(p_contract_rec scmdata.t_fabric_contract_info%ROWTYPE);

  --  Purpose  : 修改合同
  PROCEDURE update_contract_info(p_contract_rec scmdata.t_fabric_contract_info%ROWTYPE);

  --  Purpose  : 删除合同
  PROCEDURE delete_contract_info(p_contract_info_id VARCHAR2);

  --  Purpose  : 提交     生成供应商编码，未建档=》已建档
  PROCEDURE submit_t_supplier_info(p_supplier_info_id   VARCHAR2,
                                   p_default_company_id VARCHAR2,
                                   p_user_id            VARCHAR2);

  --  Purpose  :   更新供应商档案状态（0：正常，1：停用）
  PROCEDURE update_supplier_info_status(p_supplier_info_id VARCHAR2,
                                        p_reason           VARCHAR2,
                                        p_status           NUMBER,
                                        p_user_id          VARCHAR2,
                                        p_company_id       VARCHAR2);

  --  Purpose  :   更新供应商档案状态（0：正常，1：停用）
  PROCEDURE update_supp_info_bind_status(p_company_id       VARCHAR2,
                                         p_supplier_info_id VARCHAR2,
                                         p_user_id          VARCHAR2,
                                         p_status           NUMBER);

  -- Purpose  : 新增供应商 
  PROCEDURE insert_supplier_info(p_sp_data scmdata.t_fabric_supplier_info%ROWTYPE);

  -- Purpose  : 修改供应商 
  PROCEDURE update_supplier_info(p_sp_data t_fabric_supplier_info%ROWTYPE);
  -- Purpose  : 删除供应商 
  PROCEDURE delete_supplier_info(p_supplier_info_id VARCHAR2,
                                 p_company_id       VARCHAR2,
                                 p_user_id          VARCHAR2);
  --Purpose  : 校验导入数据
  PROCEDURE check_importdatas(p_company_id       IN VARCHAR2,
                              p_user_id          IN VARCHAR2,
                              p_supplier_temp_id IN VARCHAR2);

  --  Purpose  :  EXCEL导入 提交工艺单 将临时数据提交到业务表中
  PROCEDURE submit_supplier_info_temp(p_company_id IN VARCHAR2,
                                      p_user_id    IN VARCHAR2);

  --  Purpose  :  EXCEL导入 新增供应商主档临时数据
  PROCEDURE insert_supplier_info_temp(p_supp_rec scmdata.t_fabric_supplier_temp%ROWTYPE);

  --  Purpose  :  EXCEL导入 修改供应商主档临时数据
  PROCEDURE update_supplier_info_temp(p_supp_rec scmdata.t_fabric_supplier_temp%ROWTYPE);

end pkg_fabric_supplier_info;
/

create or replace package body scmdata.pkg_fabric_supplier_info is

  PROCEDURE insert_oper_log(p_supplier_info_id VARCHAR2,
                            oper_type          VARCHAR2,
                            p_reason           VARCHAR2,
                            p_user_id          VARCHAR2,
                            p_company_id       VARCHAR2,
                            p_create_time      DATE) IS
    -- v_name VARCHAR2(100);
  BEGIN
    /*    SELECT fc.company_user_name
     INTO v_name
     FROM scmdata.sys_company_user fc
    WHERE fc.company_id = p_company_id
      AND fc.user_id = p_user_id;*/
    --操作日志从表
    INSERT INTO scmdata.t_fabric_supplier_info_oper_log
      (log_id,
       fabric_supplier_info_id,
       oper_type,
       reason,
       create_id,
       create_time,
       company_id)
    VALUES
      (scmdata.f_get_uuid(),
       p_supplier_info_id,
       oper_type,
       p_reason,
       p_user_id,
       p_create_time,
       p_company_id);
  END insert_oper_log;

  PROCEDURE check_save_t_supplier_info(p_sp_data scmdata.t_fabric_supplier_info%ROWTYPE) IS
    v_scc_flag NUMBER;
    --v_supp_flag_tp NUMBER := 0;
  
  BEGIN
  
    --1 供应商名称不能为空
    IF p_sp_data.supplier_company_name IS NULL THEN
      raise_application_error(-20002, '供应商名称不能为空！');
      /*  ELSE
       --供应商档案：供应商名称可编辑。
       --无论新增修改，都得校验供应商名称是否重复  
       --1） 限制仅能填写中文及中文括号；     
      IF pkg_check_data_comm.f_check_varchar(pi_data => p_sp_data.supplier_company_name,
                                              pi_type => 0) <> 1 THEN
         raise_application_error(-20002,
                                 '供应商名称填写错误，仅能填写中文及中文括号！');
       END IF;*/
      /*  --2） 不能与当前企业供应商档案：待建档、已建档的供应商名称重复；  
      SELECT COUNT(1)
        INTO v_supp_flag_tp
        FROM scmdata.t_fabric_supplier_info t
       WHERE t.company_id = p_sp_data.company_id
         AND t.fabric_supplier_info_id <> p_sp_data.fabric_supplier_info_id
         AND t.supplier_company_name = p_sp_data.supplier_company_name;
      
      IF v_supp_flag_tp > 0 THEN
        raise_application_error(-20002,
                                '供应商名称与供应商档案已有名称重复！');
      END IF;*/
    end if;
    --2 统一社会信用代码
    IF p_sp_data.social_credit_code IS NULL and
       p_sp_data.supplier_rank in ('SUPPLIER_RANK_A', 'SUPPLIER_RANK_B') THEN
      raise_application_error(-20002,
                              '当供应商级别为A/B级时，统一社会信用代码不能为空！');
    ELSIF p_sp_data.social_credit_code IS not NULL then
      if scmdata.pkg_check_data_comm.f_check_soial_code(p_sp_data.social_credit_code) = 0 THEN
      
        raise_application_error(-20002,
                                '请输入正确的统一社会信用代码，且长度应为18位！');
      END IF;
    
      SELECT COUNT(1)
        INTO v_scc_flag
        FROM scmdata.t_fabric_supplier_info sp
       WHERE sp.social_credit_code = p_sp_data.social_credit_code
         AND sp.company_id = p_sp_data.company_id
         AND sp.fabric_supplier_info_id <>
             p_sp_data.fabric_supplier_info_id;
    
      IF v_scc_flag > 0 THEN
        raise_application_error(-20002, '统一社会信用代码不能重复！');
      END IF;
    END IF;
  end check_save_t_supplier_info;

  PROCEDURE check_t_supplier_info(p_supplier_info_id VARCHAR2) IS
    supplier_submit_exp EXCEPTION;
    --供应商档案
    supp_info_rec scmdata.t_fabric_supplier_info%ROWTYPE;
    -- v_flag        NUMBER;
  
  BEGIN
    --数据源
    --供应商档案
    SELECT *
      INTO supp_info_rec
      FROM scmdata.t_fabric_supplier_info sp
     WHERE sp.fabric_supplier_info_id = p_supplier_info_id;
  
    --1.校验供应商档案编号是否已经生成
  
    IF supp_info_rec.supplier_code IS NOT NULL THEN
      raise_application_error(-20002,
                              '该供应商档案已经生成，请勿重复提交！');
    END IF;
  
    --2.提交 =》校验数据是否有效
    check_save_t_supplier_info(p_sp_data => supp_info_rec);
  
  END check_t_supplier_info;

  PROCEDURE check_contract_info(p_contract_rec scmdata.t_fabric_contract_info%ROWTYPE) IS
  BEGIN
    IF p_contract_rec.contract_start_date >
       p_contract_rec.contract_stop_date THEN
      raise_application_error(-20002, '合同日期，结束日期必须≥开始日期');
    END IF;
  END check_contract_info;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-28 10:15:31
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  新增合同 
  * Obj_Name    : insert_contract_info
  * Arg_Number  : 1
  * p_contract_rec : 合同记录
  *============================================*/
  PROCEDURE insert_contract_info(p_contract_rec scmdata.t_fabric_contract_info%ROWTYPE) IS
  BEGIN
    --校验合同日期，结束日期必须≥开始日期
    check_contract_info(p_contract_rec => p_contract_rec);
  
    INSERT INTO t_fabric_contract_info
      (fabric_contract_info_id,
       fabric_supplier_info_id,
       company_id,
       contract_start_date,
       contract_stop_date,
       contract_sign_date,
       contract_file,
       contract_type,
       contract_num,
       operator_id,
       operate_time,
       change_id,
       change_time)
    VALUES
      (scmdata.f_get_uuid(),
       p_contract_rec.fabric_supplier_info_id,
       p_contract_rec.company_id,
       p_contract_rec.contract_start_date,
       p_contract_rec.contract_stop_date,
       p_contract_rec.contract_sign_date,
       p_contract_rec.contract_file,
       p_contract_rec.contract_type,
       p_contract_rec.contract_num,
       p_contract_rec.operator_id,
       SYSDATE,
       p_contract_rec.change_id,
       SYSDATE);
  
  END insert_contract_info;

  PROCEDURE update_contract_info(p_contract_rec scmdata.t_fabric_contract_info%ROWTYPE) IS
  BEGIN
    --校验合同日期，结束日期必须≥开始日期
    check_contract_info(p_contract_rec => p_contract_rec);
  
    UPDATE t_fabric_contract_info t
       SET t.contract_start_date = p_contract_rec.contract_start_date,
           t.contract_stop_date  = p_contract_rec.contract_stop_date,
           t.contract_sign_date  = p_contract_rec.contract_sign_date,
           t.contract_file       = p_contract_rec.contract_file,
           t.contract_type       = p_contract_rec.contract_type,
           t.contract_num        = p_contract_rec.contract_num,
           t.change_id           = p_contract_rec.change_id,
           t.change_time         = p_contract_rec.change_time
     WHERE t.fabric_contract_info_id =
           p_contract_rec.fabric_contract_info_id;
  
  END update_contract_info;

  PROCEDURE delete_contract_info(p_contract_info_id VARCHAR2) IS
  BEGIN
  
    DELETE t_fabric_contract_info t
     WHERE t.fabric_contract_info_id = p_contract_info_id;
  
  END delete_contract_info;

  PROCEDURE submit_t_supplier_info(p_supplier_info_id   VARCHAR2,
                                   p_default_company_id VARCHAR2,
                                   p_user_id            VARCHAR2) IS
    v_supplier_code VARCHAR2(100); --供应商编码
    supplier_code_exp EXCEPTION;
    --x_err_msg VARCHAR2(100);
  BEGIN
    --1.校验数据
    check_t_supplier_info(p_supplier_info_id);
    --2.生成供应商档案编号
    v_supplier_code := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => 't_fabric_supplier_info',
                                                          pi_column_name => 'supplier_code',
                                                          pi_company_id  => p_default_company_id,
                                                          pi_pre         => 'W',
                                                          pi_serail_num  => 4);
    --3.更新档案状态 待建档 =》已建档 ,新增（MA）供应商 => 未绑定，准入（AA）=> 已绑定
    IF v_supplier_code IS NULL THEN
      raise_application_error(-20002,
                              '生成供应商编码失败，请联系管平台理员！！');
    ELSE
      UPDATE scmdata.t_fabric_supplier_info sp
         SET sp.supplier_code    = v_supplier_code,
             sp.status           = 1,
             sp.bind_status      = decode(sp.supplier_info_origin,
                                          'AA',
                                          1,
                                          'MA',
                                          0,
                                          'QC',
                                          0,
                                          0),
             sp.create_supp_date = SYSDATE,
             sp.update_id        = p_user_id,
             sp.update_date      = SYSDATE
       WHERE sp.fabric_supplier_info_id = p_supplier_info_id;
    
    END IF;
  
    insert_oper_log(p_supplier_info_id,
                    '创建档案',
                    '创建档案',
                    p_user_id,
                    p_default_company_id,
                    SYSDATE);
  END submit_t_supplier_info;

  PROCEDURE update_supplier_info_status(p_supplier_info_id VARCHAR2,
                                        p_reason           VARCHAR2,
                                        p_status           NUMBER,
                                        p_user_id          VARCHAR2,
                                        p_company_id       VARCHAR2) IS
    v_status  NUMBER;
    oper_type VARCHAR2(100);
    --x_err_msg VARCHAR2(1000);
    supplier_info_exp EXCEPTION;
  BEGIN
  
    SELECT max(sp.pause)
      INTO v_status
      FROM scmdata.t_fabric_supplier_info sp
     WHERE sp.fabric_supplier_info_id = p_supplier_info_id;
  
    IF p_status <> v_status THEN
      IF p_status = 0 THEN
        oper_type := '启用';
      ELSIF p_status = 1 THEN
        oper_type := '停用';
        --新增逻辑lay：如果供应商合作状态停用了，那么它里面的合作范围也要跟着停用
        /*        UPDATE scmdata.t_coop_scope sp
          SET sp.pause       = 1,
              sp.update_id   = p_user_id,
              sp.update_time = SYSDATE
        WHERE sp.company_id = p_company_id
          AND sp.supplier_info_id = p_supplier_info_id
          AND sp.pause = 0;*/
      ELSE
        NULL;
      END IF;
      --新增启用、停用操作日志从表
      insert_oper_log(p_supplier_info_id,
                      oper_type,
                      p_reason,
                      p_user_id,
                      p_company_id,
                      SYSDATE);
    
      --启用，停用
      UPDATE scmdata.t_fabric_supplier_info sp
         SET sp.pause = p_status, sp.update_date = SYSDATE
       WHERE sp.fabric_supplier_info_id = p_supplier_info_id;
    ELSE
      --操作重复报提示信息
      raise_application_error(-20002, '不可重复操作！！');
    END IF;
  
  END update_supplier_info_status;

  PROCEDURE update_supp_info_bind_status(p_company_id       VARCHAR2,
                                         p_supplier_info_id VARCHAR2,
                                         p_user_id          VARCHAR2,
                                         p_status           NUMBER) IS
    v_status          NUMBER;
    oper_type         VARCHAR2(100);
    v_supp_company_id VARCHAR2(100);
    --x_err_msg         VARCHAR2(1000);
    supplier_info_exp EXCEPTION;
    supplier_bind_exp EXCEPTION;
  BEGIN
  
    SELECT sp.bind_status, sp.supplier_company_id
      INTO v_status, v_supp_company_id
      FROM scmdata.t_fabric_supplier_info sp
     WHERE sp.fabric_supplier_info_id = p_supplier_info_id
       AND sp.company_id = p_company_id;
  
    --对已注册供应商进行绑定，解绑
    IF p_status <> nvl(v_status, 0) THEN
      IF v_supp_company_id IS NULL THEN
        raise_application_error(-20002, '未注册供应商不能进行绑定！！');
      END IF;
      IF p_status = 0 THEN
        oper_type := '解绑';
      ELSIF p_status = 1 THEN
        oper_type := '绑定';
      ELSE
        NULL;
      END IF;
      --新增绑定、解绑操作日志从表
      insert_oper_log(p_supplier_info_id,
                      oper_type,
                      '',
                      p_user_id,
                      p_company_id,
                      SYSDATE);
    
      UPDATE scmdata.t_fabric_supplier_info sp
         SET sp.bind_status = p_status
       WHERE sp.company_id = p_company_id
         AND sp.fabric_supplier_info_id = p_supplier_info_id
         AND sp.supplier_company_id IS NOT NULL;
    ELSE
      --操作重复报提示信息
      raise_application_error(-20002, '不可重复操作！！');
    END IF;
  
  END update_supp_info_bind_status;

  PROCEDURE insert_supplier_info(p_sp_data scmdata.t_fabric_supplier_info%ROWTYPE) is
  begin
    check_save_t_supplier_info(p_sp_data);
    insert into scmdata.t_fabric_supplier_info
      (fabric_supplier_info_id,
       company_id,
       supplier_code,
       inside_supplier_code,
       supplier_company_id,
       supplier_company_name,
       supplier_company_abbreviation,
       legal_representative,
       company_create_date,
       social_credit_code,
       fabric_company_type,
       supplier_rank,
       fa_contact_name,
       fa_contact_phone,
       company_say,
       certificate_file,
       cooperation_type,
       cooperation_classification,
       cooperation_production,
       create_supp_date,
       company_address,
       company_province,
       company_city,
       company_county,
       supplier_info_origin,
       supplier_info_origin_id,
       status,
       bind_status,
       pause,
       create_id,
       create_date,
       update_id,
       update_date,
       remarks,
       file_id,
       file_remark,
       ask_date,
       cooperation_remarks,
       FA_CONTACT_FIX_LINE)
    values
      (p_sp_data.fabric_supplier_info_id,
       p_sp_data.company_id,
       null,
       p_sp_data.inside_supplier_code,
       null,
       p_sp_data.supplier_company_name,
       p_sp_data.supplier_company_abbreviation,
       null,
       null,
       p_sp_data.social_credit_code,
       p_sp_data.fabric_company_type,
       p_sp_data.supplier_rank,
       p_sp_data.fa_contact_name,
       p_sp_data.fa_contact_phone,
       null,
       null,
       p_sp_data.cooperation_type,
       p_sp_data.cooperation_classification,
       p_sp_data.cooperation_production,
       null,
       p_sp_data.company_address,
       p_sp_data.company_province,
       p_sp_data.company_city,
       p_sp_data.company_county,
       'MA',
       null,
       0,
       0,
       p_sp_data.pause,
       p_sp_data.update_id,
       sysdate,
       p_sp_data.update_id,
       sysdate,
       p_sp_data.remarks,
       p_sp_data.file_id,
       null,
       p_sp_data.ask_date,
       p_sp_data.cooperation_remarks,
       p_sp_data.FA_CONTACT_FIX_LINE);
  
  end insert_supplier_info;

  PROCEDURE update_supplier_info(p_sp_data t_fabric_supplier_info%ROWTYPE) is
  begin
    check_save_t_supplier_info(p_sp_data);
    update scmdata.t_fabric_supplier_info a
       set a.inside_supplier_code          = p_sp_data.inside_supplier_code,
           a.supplier_company_name         = p_sp_data.supplier_company_name,
           a.supplier_company_abbreviation = p_sp_data.supplier_company_abbreviation,
           a.social_credit_code            = p_sp_data.social_credit_code,
           a.fabric_company_type           = p_sp_data.fabric_company_type,
           a.supplier_rank                 = p_sp_data.supplier_rank,
           a.fa_contact_name               = p_sp_data.fa_contact_name,
           a.fa_contact_phone              = p_sp_data.fa_contact_phone,
           a.cooperation_type              = p_sp_data.cooperation_type,
           a.cooperation_classification    = p_sp_data.cooperation_classification,
           a.cooperation_production        = p_sp_data.cooperation_production,
           a.company_address               = p_sp_data.company_address,
           a.company_province              = p_sp_data.company_province,
           a.company_city                  = p_sp_data.company_city,
           a.company_county                = p_sp_data.company_county,
           --a.pause                         = p_sp_data.pause,
           a.update_date                   = sysdate,
           a.update_id                     = p_sp_data.update_id,
           a.remarks                       = p_sp_data.remarks,
           a.file_id                       = p_sp_data.file_id,
           a.ask_date                      = p_sp_data.ASK_DATE,
           a.cooperation_remarks           = p_sp_data.COOPERATION_REMARKS,
           a.Fa_Contact_Fix_Line           = p_sp_data.FA_CONTACT_FIX_LINE
     where a.fabric_supplier_info_id = p_sp_data.fabric_supplier_info_id;
  end update_supplier_info;
  PROCEDURE delete_supplier_info(p_supplier_info_id VARCHAR2,
                                 p_company_id       VARCHAR2,
                                 p_user_id          VARCHAR2) is
  begin
    delete from scmdata.t_fabric_contract_info a
     where a.fabric_supplier_info_id = p_supplier_info_id;
    delete from scmdata.t_fabric_supplier_info a
     where a.fabric_supplier_info_id = p_supplier_info_id;
  end delete_supplier_info;
  --Purpose  : 校验导入数据
  PROCEDURE check_importdatas(p_company_id       IN VARCHAR2,
                              p_user_id          IN VARCHAR2,
                              p_supplier_temp_id IN VARCHAR2) is
    p_fabric_supplier_temp scmdata.t_fabric_supplier_temp%rowtype;
    p_flag                 int;
    v_desc                 varchar2(200);
    v_msg                  varchar2(1000);
    v_notice_msg           varchar2(1000);
    v_err_num              int := 0;
    v_province             VARCHAR2(32);
    v_city                 VARCHAR2(32);
    v_county               VARCHAR2(32);
    v_num                  int;
  begin
    select *
      into p_fabric_supplier_temp
      from scmdata.t_fabric_supplier_temp a
     where a.fabric_supplier_temp_id = p_supplier_temp_id;
    --不校验重复，只做提示。只在输入后才做校验
    --如果有输入供应商编号，校验不能重复（报错）
    if p_fabric_supplier_temp.inside_supplier_code is not null then
    
      select max(1)
        into p_flag
        from scmdata.t_fabric_supplier_info a
       where a.inside_supplier_code =
             p_fabric_supplier_temp.inside_supplier_code
         and a.company_id = p_company_id;
      IF p_flag = 1 THEN
        v_err_num := v_err_num + 1;
        v_msg     := v_msg || v_err_num || '.供应商编号:[' ||
                     p_fabric_supplier_temp.inside_supplier_code ||
                     ']存在重复！';
      end if;
      select max(1)
        into p_flag
        from scmdata.t_fabric_supplier_temp a
       where a.inside_supplier_code =
             p_fabric_supplier_temp.inside_supplier_code
         and a.company_id = p_company_id
         and a.create_id = p_user_id
         and a.fabric_supplier_temp_id <> p_supplier_temp_id;
      IF p_flag = 1 THEN
        v_err_num := v_err_num + 1;
        v_msg     := v_msg || v_err_num || '.供应商编号:[' ||
                     p_fabric_supplier_temp.inside_supplier_code ||
                     ']在本次导入数据中存在重复！';
      end if;
    end if;
    --名称重复（做提示）
    if p_fabric_supplier_temp.supplier_company_name is not null then
    
      select max(1)
        into p_flag
        from scmdata.t_fabric_supplier_info a
       where a.supplier_company_name =
             p_fabric_supplier_temp.supplier_company_name
         and a.company_id = p_company_id;
      IF p_flag = 1 THEN
        v_err_num    := v_err_num + 1;
        v_notice_msg := v_notice_msg || v_err_num || '.供应商名称:[' ||
                        p_fabric_supplier_temp.supplier_company_name ||
                        ']存在重复！';
      end if;
      select max(1)
        into p_flag
        from scmdata.t_fabric_supplier_temp a
       where a.supplier_company_name =
             p_fabric_supplier_temp.supplier_company_name
         and a.company_id = p_company_id
         and a.create_id = p_user_id
         and a.fabric_supplier_temp_id <> p_supplier_temp_id;
      IF p_flag = 1 THEN
        v_err_num    := v_err_num + 1;
        v_notice_msg := v_notice_msg || v_err_num || '.供应商名称:[' ||
                        p_fabric_supplier_temp.supplier_company_name ||
                        ']在本次导入数据中存在重复！';
      end if;
    end if;
    --统一社会引用代码重复（报错）
    if p_fabric_supplier_temp.social_credit_code is not null then
      select max(1)
        into p_flag
        from scmdata.t_fabric_supplier_info a
       where a.social_credit_code =
             p_fabric_supplier_temp.social_credit_code
         and a.company_id = p_company_id;
      IF p_flag = 1 THEN
        v_err_num := v_err_num + 1;
        v_msg     := v_msg || v_err_num || '.统一社会信用代码:[' ||
                     p_fabric_supplier_temp.social_credit_code || ']存在重复！';
      end if;
      select max(1)
        into p_flag
        from scmdata.t_fabric_supplier_temp a
       where a.social_credit_code =
             p_fabric_supplier_temp.social_credit_code
         and a.company_id = p_company_id
         and a.create_id = p_user_id
         and a.fabric_supplier_temp_id <> p_supplier_temp_id;
      IF p_flag = 1 THEN
        v_err_num := v_err_num + 1;
        v_msg     := v_msg || v_err_num || '.统一社会信用代码:[' ||
                     p_fabric_supplier_temp.social_credit_code ||
                     ']在本次导入数据中存在重复！';
      end if;
      if scmdata.pkg_check_data_comm.f_check_soial_code(p_fabric_supplier_temp.social_credit_code) = 0 THEN
        v_err_num := v_err_num + 1;
        v_msg     := v_msg || v_err_num || '.统一社会信用代码:[' ||
                     p_fabric_supplier_temp.social_credit_code ||
                     ']错误，请输入正确的统一社会信用代码，且长度应为18位！';
      END IF;
    end if;
    if p_fabric_supplier_temp.supplier_rank in ('A级', 'B级') and
       p_fabric_supplier_temp.social_credit_code is null then
      v_err_num := v_err_num + 1;
      v_msg     := v_msg || v_err_num || '.供应商级别为:[' ||
                   p_fabric_supplier_temp.supplier_rank ||
                   ']时，统一社会信用代码必填！！';
    end if;
    --省市区数组处理
    v_num := 0;
    if p_fabric_supplier_temp.company_province_code is not null and
       not
        REGEXP_LIKE(p_fabric_supplier_temp.company_province_code, '^[0-9]*$') then
      v_err_num := v_err_num + 1;
      v_num     := v_num + 1;
      v_msg     := v_msg || v_err_num || '.省份编号:[' ||
                   p_fabric_supplier_temp.company_province_code ||
                   ']在数据字典中不存在，请填写正确的省份编号！';
    end if;
    if p_fabric_supplier_temp.company_city_code is not null and
       not REGEXP_LIKE(p_fabric_supplier_temp.company_city_code, '^[0-9]*$') then
      v_err_num := v_err_num + 1;
      v_num     := v_num + 1;
      v_msg     := v_msg || v_err_num || '.城市编号:[' ||
                   p_fabric_supplier_temp.company_city_code ||
                   ']在数据字典中不存在，请填写正确的城市编号！';
    end if;
    if p_fabric_supplier_temp.company_county_code is not null and
       not
        REGEXP_LIKE(p_fabric_supplier_temp.company_county_code, '^[0-9]*$') then
      v_err_num := v_err_num + 1;
      v_num     := v_num + 1;
      v_msg     := v_msg || v_err_num || '.区县编号:[' ||
                   p_fabric_supplier_temp.company_county_code ||
                   ']在数据字典中不存在，请填写正确的区县编号！';
    end if;
    --省市区（报错）
    IF p_fabric_supplier_temp.company_province_code IS NOT NULL and
       v_num = 0 THEN
      SELECT COUNT(1)
        INTO v_num
        FROM scmdata.dic_province p
       WHERE p.provinceid = p_fabric_supplier_temp.company_province_code;
    
      IF v_num = 0 THEN
        v_err_num := v_err_num + 1;
        v_msg     := v_msg || v_err_num || '.省份编号:[' ||
                     p_fabric_supplier_temp.company_province_code ||
                     ']在数据字典中不存在，请填写正确的省份编号！';
      ELSE
        SELECT MAX(p.province)
          INTO v_province
          FROM scmdata.dic_province p
         WHERE p.provinceid = p_fabric_supplier_temp.company_province_code;
      
        IF v_province <> p_fabric_supplier_temp.company_province THEN
          v_err_num := v_err_num + 1;
          v_msg     := v_msg || v_err_num || '.省份编号:[' ||
                       p_fabric_supplier_temp.company_province_code ||
                       ']与省份名称:[' ||
                       p_fabric_supplier_temp.company_province ||
                       ']对应关系不一致，请确认后填写！';
        ELSE
          --市
          IF p_fabric_supplier_temp.company_city_code IS NOT NULL THEN
          
            SELECT COUNT(1)
              INTO v_num
              FROM scmdata.dic_city c
             WHERE c.provinceid =
                   p_fabric_supplier_temp.company_province_code
               AND c.cityno = p_fabric_supplier_temp.company_city_code;
          
            IF v_num = 0 THEN
              v_err_num := v_err_num + 1;
              v_msg     := v_msg || v_err_num || '.城市编号:[' ||
                           p_fabric_supplier_temp.company_city_code ||
                           ']在数据字典中不存在/[' ||
                           p_fabric_supplier_temp.company_city || ']不属于[' ||
                           p_fabric_supplier_temp.company_province ||
                           ']，请填写正确的城市编号！';
            ELSE
              SELECT MAX(c.city)
                INTO v_city
                FROM scmdata.dic_city c
               WHERE c.provinceid =
                     p_fabric_supplier_temp.company_province_code
                 AND c.cityno = p_fabric_supplier_temp.company_city_code;
            
              IF v_city <> p_fabric_supplier_temp.company_city THEN
                v_err_num := v_err_num + 1;
                v_msg     := v_msg || v_err_num || '.城市编号:[' ||
                             p_fabric_supplier_temp.company_city_code ||
                             ']与城市名称:[' ||
                             p_fabric_supplier_temp.company_city ||
                             ']对应关系不一致，请确认后填写！';
              ELSE
                --区
                IF p_fabric_supplier_temp.company_county_code IS NOT NULL THEN
                
                  SELECT COUNT(1)
                    INTO v_num
                    FROM scmdata.dic_county d
                   WHERE d.cityno =
                         p_fabric_supplier_temp.company_city_code
                     AND d.countyid =
                         p_fabric_supplier_temp.company_county_code;
                
                  IF v_num = 0 THEN
                    v_err_num := v_err_num + 1;
                    v_msg     := v_msg || v_err_num || '.区县编号:[' ||
                                 p_fabric_supplier_temp.company_county_code ||
                                 ']在数据字典中不存在/[' ||
                                 p_fabric_supplier_temp.company_county ||
                                 ']不属于[' ||
                                 p_fabric_supplier_temp.company_city ||
                                 ']，请填写正确的区县编号！';
                  ELSE
                    SELECT MAX(d.county)
                      INTO v_county
                      FROM scmdata.dic_county d
                     WHERE d.cityno =
                           p_fabric_supplier_temp.company_city_code
                       AND d.countyid =
                           p_fabric_supplier_temp.company_county_code;
                  
                    IF v_county <> p_fabric_supplier_temp.company_county THEN
                      v_err_num := v_err_num + 1;
                      v_msg     := v_msg || v_err_num || '.区县编号:[' ||
                                   p_fabric_supplier_temp.company_county_code ||
                                   ']与区县名称:[' ||
                                   p_fabric_supplier_temp.company_county ||
                                   ']对应关系不一致，请确认后填写！';
                    END IF;
                  END IF;
                END IF;
              END IF;
            END IF;
          END IF;
        END IF;
      END IF;
    END IF;
    --供应商级别（字典报错）
    if p_fabric_supplier_temp.supplier_rank is not null then
      SELECT nvl(max(1), 0)
        INTO p_flag
        FROM scmdata.sys_group_dict t
       WHERE t.group_dict_type = 'SUPPLIER_RANK_DICT'
         AND t.group_dict_name = p_fabric_supplier_temp.supplier_rank;
      IF p_flag = 0 THEN
        v_err_num := v_err_num + 1;
        v_msg     := v_msg || v_err_num || '.供应商级别:[' ||
                     p_fabric_supplier_temp.supplier_rank ||
                     ']在数据字典中不存在，请填写正确的供应商级别！';
      end if;
    end if;
    if p_fabric_supplier_temp.fabric_company_type is not null then
      --公司类型（字典报错）
      SELECT nvl(max(1), 0)
        INTO p_flag
        FROM scmdata.sys_group_dict t
       WHERE t.group_dict_type = 'FABRIC_COMPANY_TYPE'
         AND t.group_dict_name = p_fabric_supplier_temp.fabric_company_type;
      IF p_flag = 0 THEN
        v_err_num := v_err_num + 1;
        v_msg     := v_msg || v_err_num || '.公司类型:[' ||
                     p_fabric_supplier_temp.fabric_company_type ||
                     ']在数据字典中不存在，请填写正确的公司类型！';
      end if;
    end if;
  
    --业务联系电话（格式报错）
    if p_fabric_supplier_temp.fa_contact_phone is not null then
      IF not REGEXP_LIKE(p_fabric_supplier_temp.ask_date_desc, '^\d{11}$') THEN
        v_err_num := v_err_num + 1;
        v_msg     := v_msg || v_err_num || '.联系人手机:[' ||
                     p_fabric_supplier_temp.fa_contact_phone ||
                     ']请填写11位正确的联系人手机！';
      END IF;
    end if;
    --合作申请日期（格式报错）
    if p_fabric_supplier_temp.ask_date_desc is not null then
      if not
          REGEXP_LIKE(p_fabric_supplier_temp.ask_date_desc,
                      '^([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8])))$') then
        v_err_num := v_err_num + 1;
        v_msg     := v_msg || v_err_num || '.合作申请日期:[' ||
                     p_fabric_supplier_temp.ask_date_desc ||
                     ']请填写正确的合作申请日期！';
      end if;
    end if;
    --合作范围（字典报错
    if p_fabric_supplier_temp.cooperation_production is not null then
      SELECT listagg(distinct b.group_dict_name, ';') within GROUP(ORDER BY 1)
        INTO v_desc
        from scmdata.sys_group_dict a
       inner join scmdata.sys_group_dict b
          on a.group_dict_value = b.group_dict_type
         and b.pause = 0
       where a.group_dict_type = 'PRODUCT_TYPE'
         and a.pause = 0
         AND instr(';' || p_fabric_supplier_temp.cooperation_production || ';',
                   ';' || b.group_dict_name || ';') > 0;
      SELECT nvl(length(regexp_replace(v_desc, '[^;]', '')), 0),
             nvl(length(regexp_replace(p_fabric_supplier_temp.cooperation_production,
                                       '[^;]',
                                       '')),
                 0)
        INTO v_num, p_flag
        FROM dual;
      if v_desc is null then
        v_err_num := v_err_num + 1;
        v_msg     := v_msg || v_err_num || '.合作范围:[' ||
                     p_fabric_supplier_temp.cooperation_production ||
                     ']不存在于数据字典中！';
      end if;
      IF v_num <> p_flag THEN
      
        v_err_num := v_err_num + 1;
        v_msg     := v_msg || v_err_num || '.部分合作范围不存在于数据字典中，当前对应为:[' ||
                     v_desc || ']';
      end if;
    end if;
    --合作类型（字典报错
    if p_fabric_supplier_temp.cooperation_classification is not null then
      SELECT nvl(max(1), 0)
        INTO p_flag
        FROM scmdata.sys_group_dict t
       WHERE t.group_dict_type = 'MATERIAL_OBJECT_TYPE'
         AND t.group_dict_name =
             p_fabric_supplier_temp.cooperation_classification;
    
      IF p_flag = 0 THEN
        v_err_num := v_err_num + 1;
        v_msg     := v_msg || v_err_num || '.合作类型:[' ||
                     p_fabric_supplier_temp.cooperation_classification ||
                     ']在数据字典中不存在，请填写正确的合作类型！';
      end if;
    end if;
  
    IF v_msg IS NOT NULL THEN
      UPDATE scmdata.t_fabric_supplier_temp t
         SET t.msg_type  = 'E',
             t.error_msg = v_msg || '警告：' || nvl(v_notice_msg, '无')
       WHERE t.fabric_supplier_temp_id = p_supplier_temp_id;
    elsif v_notice_msg is not null then
      UPDATE scmdata.t_fabric_supplier_temp t
         SET t.msg_type = 'W', t.error_msg = '警告：' || v_notice_msg
       WHERE t.fabric_supplier_temp_id = p_supplier_temp_id;
    ELSE
      UPDATE scmdata.t_fabric_supplier_temp t
         SET t.msg_type = 'N', t.error_msg = NULL
       WHERE t.fabric_supplier_temp_id = p_supplier_temp_id;
    END IF;
  end check_importdatas;

  --  Purpose  :  EXCEL导入 提交工艺单 将临时数据提交到业务表中
  PROCEDURE submit_supplier_info_temp(p_company_id IN VARCHAR2,
                                      p_user_id    IN VARCHAR2) is
    p_sp_data scmdata.t_fabric_supplier_info%ROWTYPE;
    --临时数据,校验信息                               
    CURSOR import_data_cur IS
      SELECT t.*
        FROM scmdata.t_fabric_supplier_temp t
       WHERE t.company_id = p_company_id
         AND t.create_id = p_user_id;
  BEGIN
  
    FOR data_rec IN import_data_cur LOOP
      --判断数据是否都校验成功，只有都校验成功了，才能进行提交
      IF data_rec.msg_type = 'E' OR data_rec.msg_type IS NULL THEN
        raise_application_error(-20002,
                                '请检查数据是否都已检验成功，修改正确后再提交!');
      ELSE
        p_sp_data.fabric_supplier_info_id       := f_get_uuid();
        p_sp_data.company_id                    := data_rec.company_id;
        p_sp_data.inside_supplier_code          := data_rec.inside_supplier_code;
        p_sp_data.supplier_company_name         := data_rec.supplier_company_name;
        p_sp_data.supplier_company_abbreviation := data_rec.supplier_company_abbreviation;
        p_sp_data.social_credit_code            := data_rec.SOCIAL_CREDIT_CODE;
        p_sp_data.company_address               := data_rec.COMPANY_ADDRESS;
        p_sp_data.FA_CONTACT_PHONE              := data_rec.FA_CONTACT_PHONE;
        p_sp_data.FA_CONTACT_NAME               := data_rec.FA_CONTACT_NAME;
        SELECT max(t.group_dict_value)
          INTO p_sp_data.fabric_company_type
          FROM scmdata.sys_group_dict t
         WHERE t.group_dict_type = 'FABRIC_COMPANY_TYPE'
           AND t.group_dict_name = data_rec.fabric_company_type;
        p_sp_data.company_province       := data_rec.company_province_code;
        p_sp_data.company_city           := data_rec.company_city_code;
        p_sp_data.company_county         := data_rec.company_county_code;
        p_sp_data.cooperation_type       := 'MATERIAL_TYPE';
        p_sp_data.COOPERATION_REMARKS    := data_rec.COOPERATION_REMARKS;
        p_sp_data.fa_contact_fix_line    := data_rec.fa_contact_fix_line;
        p_sp_data.COOPERATION_PRODUCTION := data_rec.COOPERATION_PRODUCTION;
        SELECT max(t.group_dict_value)
          INTO p_sp_data.SUPPLIER_RANK
          FROM scmdata.sys_group_dict t
         WHERE t.group_dict_type = 'SUPPLIER_RANK_DICT'
           AND t.group_dict_name = data_rec.SUPPLIER_RANK;
        SELECT max(t.group_dict_value)
          INTO p_sp_data.cooperation_classification
          FROM scmdata.sys_group_dict t
         WHERE t.group_dict_type = 'MATERIAL_OBJECT_TYPE'
           AND t.group_dict_name = data_rec.cooperation_classification;
        p_sp_data.create_id := data_rec.create_id;
        p_sp_data.pause     := 0;
        p_sp_data.ask_date  := to_date(data_rec.ask_date_desc, 'yyyy-mm-dd');
        --p_sp_data.update_date            = SYSDATE;
        p_sp_data.remarks := data_rec.remarks;
        --v_sp_data.file_id := :FILE_ID_PR;
        --新增
        scmdata.pkg_fabric_supplier_info.insert_supplier_info(p_sp_data => p_sp_data);
      
        pkg_fabric_supplier_info.submit_t_supplier_info(p_supplier_info_id   => p_sp_data.fabric_supplier_info_id,
                                                        p_default_company_id => p_sp_data.company_id,
                                                        p_user_id            => p_sp_data.create_id);
      end if;
    end loop;
    delete from scmdata.t_fabric_supplier_temp t
     where t.company_id = p_company_id
       AND t.create_id = p_user_id;
  end submit_supplier_info_temp;

  --  Purpose  :  EXCEL导入 新增供应商主档临时数据
  PROCEDURE insert_supplier_info_temp(p_supp_rec scmdata.t_fabric_supplier_temp%ROWTYPE) is
  begin
  
    insert into scmdata.t_fabric_supplier_temp
      (fabric_supplier_temp_id,
       company_id,
       supplier_code,
       inside_supplier_code,
       supplier_company_id,
       supplier_company_name,
       supplier_company_abbreviation,
       legal_representative,
       company_create_date,
       social_credit_code,
       fabric_company_type,
       supplier_rank,
       fa_contact_name,
       fa_contact_phone,
       company_say,
       certificate_file,
       cooperation_type,
       cooperation_classification,
       cooperation_production,
       create_supp_date,
       company_address,
       company_province,
       company_city,
       company_county,
       supplier_info_origin,
       supplier_info_origin_id,
       status,
       bind_status,
       pause,
       create_id,
       create_date,
       update_id,
       update_date,
       remarks,
       file_id,
       file_remark,
       ask_date,
       cooperation_remarks,
       msg_type,
       error_msg,
       company_province_code,
       company_city_code,
       company_county_code,
       ask_date_desc,
       FA_CONTACT_FIX_LINE)
    values
      (p_supp_rec.fabric_supplier_temp_id,
       p_supp_rec.company_id,
       null,
       p_supp_rec.inside_supplier_code,
       null,
       p_supp_rec.supplier_company_name,
       p_supp_rec.supplier_company_abbreviation,
       null,
       null,
       p_supp_rec.social_credit_code,
       p_supp_rec.fabric_company_type,
       p_supp_rec.supplier_rank,
       p_supp_rec.fa_contact_name,
       p_supp_rec.fa_contact_phone,
       null,
       null,
       null,
       p_supp_rec.cooperation_classification,
       p_supp_rec.cooperation_production,
       null,
       p_supp_rec.company_address,
       p_supp_rec.company_province,
       p_supp_rec.company_city,
       p_supp_rec.company_county,
       null,
       null,
       null,
       null,
       0,
       p_supp_rec.create_id,
       sysdate,
       p_supp_rec.create_id,
       sysdate,
       p_supp_rec.remarks,
       null,
       null,
       p_supp_rec.ask_date,
       null,
       null,
       null,
       p_supp_rec.company_province_code,
       p_supp_rec.company_city_code,
       p_supp_rec.company_county_code,
       p_supp_rec.ask_date_desc,
       p_supp_rec.Fa_Contact_Fix_Line);
  
    check_importdatas(p_company_id       => p_supp_rec.company_id,
                      p_user_id          => p_supp_rec.create_id,
                      p_supplier_temp_id => p_supp_rec.fabric_supplier_temp_id);
  end insert_supplier_info_temp;

  --  Purpose  :  EXCEL导入 修改供应商主档临时数据
  PROCEDURE update_supplier_info_temp(p_supp_rec scmdata.t_fabric_supplier_temp%ROWTYPE) is
  begin
    update scmdata.t_fabric_supplier_temp a
       set a.create_id                     = p_supp_rec.create_id,
           a.supplier_company_name         = p_supp_rec.supplier_company_name,
           a.supplier_company_abbreviation = p_supp_rec.supplier_company_abbreviation,
           a.social_credit_code            = p_supp_rec.social_credit_code,
           a.SUPPLIER_RANK                 = p_supp_rec.SUPPLIER_RANK,
           a.inside_supplier_code          = p_supp_rec.inside_supplier_code,
           a.company_province              = p_supp_rec.company_province,
           a.company_province_code         = p_supp_rec.company_province_code,
           a.company_city                  = p_supp_rec.company_city,
           a.company_city_code             = p_supp_rec.company_city_code,
           a.company_county                = p_supp_rec.company_county,
           a.company_county_code           = p_supp_rec.company_county_code,
           a.company_address               = p_supp_rec.company_address,
           a.fabric_company_type           = p_supp_rec.fabric_company_type,
           a.FA_CONTACT_NAME               = p_supp_rec.FA_CONTACT_NAME,
           a.FA_CONTACT_PHONE              = p_supp_rec.FA_CONTACT_PHONE,
           a.ask_date_desc                 = p_supp_rec.ask_date_desc,
           a.cooperation_classification    = p_supp_rec.cooperation_classification,
           a.COOPERATION_PRODUCTION        = p_supp_rec.COOPERATION_PRODUCTION,
           a.COOPERATION_REMARKS           = p_supp_rec.COOPERATION_REMARKS,
           a.remarks                       = p_supp_rec.remarks,
           a.Fa_Contact_Fix_Line           = p_supp_rec.Fa_Contact_Fix_Line
     where a.fabric_supplier_temp_id = p_supp_rec.fabric_supplier_temp_id;
    check_importdatas(p_company_id       => p_supp_rec.company_id,
                      p_user_id          => p_supp_rec.create_id,
                      p_supplier_temp_id => p_supp_rec.fabric_supplier_temp_id);
  end update_supplier_info_temp;

end pkg_fabric_supplier_info;
/

