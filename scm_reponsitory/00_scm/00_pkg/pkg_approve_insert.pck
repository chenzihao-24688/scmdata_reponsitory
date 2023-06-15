CREATE OR REPLACE PACKAGE SCMDATA.pkg_approve_insert IS

  --批版记录表单行插入-新增
  PROCEDURE p_insert_approve_version
  (
    comp_id IN VARCHAR2,
    good_id IN VARCHAR2,
    av_id   IN VARCHAR2,
    oi_str  IN VARCHAR2,
    cre_id  IN VARCHAR2
  );

  --风险评估表单行插入-新增
  PROCEDURE p_insert_risk_assessment
  (
    comp_id IN VARCHAR2,
    atype   IN VARCHAR2,
    av_id   IN VARCHAR2,
    user_id IN VARCHAR2
  );

  --插入空的风险评估汇总
  PROCEDURE p_insert_risk_assessment_empty
  (
    comp_id IN VARCHAR2,
    atype   IN VARCHAR2,
    av_id   IN VARCHAR2
  );

  --批版尺寸表新增插入
  PROCEDURE p_insert_approve_size
  (
    comp_id   IN VARCHAR2,
    av_id     IN VARCHAR2,
    position  IN VARCHAR2,
    meamethod IN VARCHAR2,
    stdsize   IN VARCHAR2
  );

  --复版新增
  PROCEDURE p_approve_reversion_insert
  (
    comp_id VARCHAR2,
    av_id   VARCHAR2
  );

  --生成批版数据
  PROCEDURE p_insert_nes_approve
  (
    comp_id IN VARCHAR2,
    good_id IN VARCHAR2,
    oi_str  IN VARCHAR2,
    cre_id  IN VARCHAR2
  );

  --带条件生成批版数据
  PROCEDURE p_generate_nes_approve_info
  (
    comp_id IN VARCHAR2,
    goo_id  IN VARCHAR2,
    oi_str  IN VARCHAR2 DEFAULT 'SI',
    cre_id  IN VARCHAR2 DEFAULT 'ADMIN'
  );

  --批版条件校验
  PROCEDURE p_approver_result_verify
  (
    v_avid IN VARCHAR2,
    v_cpid IN VARCHAR2,
    v_usid IN VARCHAR2
  );

  --生成批版不合格处理picklist
  FUNCTION f_get_apunqual_treatment_picklist(v_assesstype IN VARCHAR2)
    RETURN VARCHAR2;

  --生成批版不合格处理执行语句
  FUNCTION f_generate_ap_utsentance
  (
    v_codes IN VARCHAR2,
    v_type  IN VARCHAR2
  ) RETURN VARCHAR2;

  --插入批版记录表主表（创建者为系统管理员）
  ----新增复版/页面新增的创建人记录为当前操作人 by dyy153 20220617
  PROCEDURE p_insert_approve_version_without_creator
  (
    v_apvid  IN VARCHAR2 DEFAULT NULL,
    v_stcode IN VARCHAR2 DEFAULT NULL,
    v_spcode IN VARCHAR2 DEFAULT NULL,
    v_compid IN VARCHAR2,
    v_goodid IN VARCHAR2,
    v_origin IN VARCHAR2,
    v_apvoid IN VARCHAR2 DEFAULT NULL,
    cre_id   IN VARCHAR2 DEFAULT 'ADMIN'
  );

  --复版带入批版风险评估表数据
  PROCEDURE p_insert_apriskassement_by_reap
  (
    v_apvid  IN VARCHAR2,
    v_apid   IN VARCHAR2,
    v_compid IN VARCHAR2
  );

  --插入批版附件表
  PROCEDURE p_insert_approve_file
  (
    v_apvid  IN VARCHAR2,
    v_compid IN VARCHAR2
  );

  --插入空的批版附件记录
  PROCEDURE p_insert_empty_apfile
  (
    v_apvid  IN VARCHAR2,
    v_compid IN VARCHAR2,
    v_type   IN VARCHAR2
  );

END pkg_approve_insert;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_approve_insert IS

  --批版记录表单行插入-新增
  PROCEDURE p_insert_approve_version
  (
    comp_id IN VARCHAR2,
    good_id IN VARCHAR2,
    av_id   IN VARCHAR2,
    oi_str  IN VARCHAR2,
    cre_id  IN VARCHAR2
  ) IS
    s_code     VARCHAR2(32);
    sp_code    VARCHAR2(32);
    b_code     VARCHAR2(32);
    v_cate     VARCHAR2(32);
    v_procate  VARCHAR2(32);
    v_app_type VARCHAR2(32);
  BEGIN
    SELECT style_number,
           supplier_code,
           category,
           product_cate
      INTO s_code,
           sp_code,
           v_cate,
           v_procate
      FROM scmdata.t_commodity_info
     WHERE company_id = comp_id
       AND goo_id = good_id;
  
    b_code := scmdata.f_getkeyid_plat('BILL_CODE', 'seq_billcode', 2);
  
    IF v_cate = '03'
       OR (v_cate = '08' AND v_procate = '113' OR v_procate = '114') THEN
      v_app_type := '';
    ELSE
      v_app_type := 'CONFIRM_VERSION';
    END IF;
  
    INSERT INTO scmdata.t_approve_version
      (approve_version_id, company_id, bill_code, approve_status, approve_number, approve_result, goo_id, style_code, approve_user_id, approve_time, create_time, origin, create_id, supplier_code, approve_type)
    VALUES
      (av_id, comp_id, b_code, 'AS00', 0, 'AS00', good_id, s_code, NULL, NULL, SYSDATE, oi_str, cre_id, sp_code, v_app_type);
    --COMMIT;
  END p_insert_approve_version;

  --风险评估表单行插入-新增
  PROCEDURE p_insert_risk_assessment
  (
    comp_id IN VARCHAR2,
    atype   IN VARCHAR2,
    av_id   IN VARCHAR2,
    user_id IN VARCHAR2
  ) IS
  BEGIN
    INSERT INTO scmdata.t_approve_risk_assessment
      (approve_risk_assessment_id, approve_version_id, company_id, assess_type, assess_say, risk_warning, assess_result, unqualified_say, assess_user_id, assess_time)
    VALUES
      (scmdata.f_get_uuid(), av_id, comp_id, atype, ' ', ' ', ' ', ' ', user_id, SYSDATE);
    --COMMIT;
  END p_insert_risk_assessment;

  --插入空的风险评估汇总
  PROCEDURE p_insert_risk_assessment_empty
  (
    comp_id IN VARCHAR2,
    atype   IN VARCHAR2,
    av_id   IN VARCHAR2
  ) IS
  BEGIN
    INSERT INTO scmdata.t_approve_risk_assessment
      (approve_risk_assessment_id, approve_version_id, company_id, assess_type, assess_say, risk_warning, assess_result, unqualified_say, assess_user_id, assess_time)
    VALUES
      (scmdata.f_get_uuid(), av_id, comp_id, atype, ' ', ' ', ' ', ' ', ' ', NULL);
    --COMMIT;
  END p_insert_risk_assessment_empty;

  --批版尺寸表新增插入
  PROCEDURE p_insert_approve_size
  (
    comp_id   IN VARCHAR2,
    av_id     IN VARCHAR2,
    position  IN VARCHAR2,
    meamethod IN VARCHAR2,
    stdsize   IN VARCHAR2
  ) IS
  BEGIN
    INSERT INTO scmdata.t_approve_size
      (approve_size_id, approve_version_id, company_id, position, measuring_method, std_size, template_size, craftsman_size, deviation)
    VALUES
      (scmdata.f_get_uuid(), av_id, comp_id, position, meamethod, CAST(stdsize AS
             NUMBER(32,
                    8)), 0, 0, 0);
    --COMMIT;
  END p_insert_approve_size;

  --插入必要值
  PROCEDURE p_insert_nes_approve
  (
    comp_id IN VARCHAR2,
    good_id IN VARCHAR2,
    oi_str  IN VARCHAR2,
    cre_id  IN VARCHAR2
  ) IS
    av_id VARCHAR2(32);
    judge NUMBER(1);
  BEGIN
    SELECT MAX(1)
      INTO judge
      FROM (SELECT company_id,
                   category,
                   product_cate,
                   samll_category
              FROM scmdata.t_commodity_info
             WHERE company_id = comp_id
               AND goo_id = good_id) a
     INNER JOIN scmdata.t_approve_config b
        ON a.company_id = b.company_id
       AND a.category = b.industry_classification
       AND a.product_cate = b.production_category
       AND instr(b.product_subclass || ';', a.samll_category) > 0
       AND b.pause = 0;
    IF judge > 0 THEN
      av_id := scmdata.f_getkeyid_plat('AP_VERSION',
                                       'seq_approve_version',
                                       '99');
    
      p_insert_approve_version(comp_id => comp_id,
                               good_id => good_id,
                               av_id   => av_id,
                               oi_str  => oi_str,
                               cre_id  => cre_id);
    
      p_insert_risk_assessment_empty(comp_id, 'EVAL11', av_id);
      p_insert_risk_assessment_empty(comp_id, 'EVAL12', av_id);
      p_insert_risk_assessment_empty(comp_id, 'EVAL13', av_id);
      p_insert_risk_assessment_empty(comp_id, 'EVAL14', av_id);
      p_insert_approve_file(v_apvid => av_id, v_compid => comp_id);
    END IF;
  END p_insert_nes_approve;

  --复版新增
  PROCEDURE p_approve_reversion_insert
  (
    comp_id VARCHAR2,
    av_id   VARCHAR2
  ) IS
  BEGIN
    p_insert_risk_assessment_empty(comp_id, 'EVAL11', av_id);
    p_insert_risk_assessment_empty(comp_id, 'EVAL12', av_id);
    p_insert_risk_assessment_empty(comp_id, 'EVAL13', av_id);
    p_insert_risk_assessment_empty(comp_id, 'EVAL14', av_id);
  END p_approve_reversion_insert;

  --带条件生成批版数据
  PROCEDURE p_generate_nes_approve_info
  (
    comp_id IN VARCHAR2,
    goo_id  IN VARCHAR2,
    oi_str  IN VARCHAR2 DEFAULT 'SI',
    cre_id  IN VARCHAR2 DEFAULT 'ADMIN'
  ) IS
    judge NUMBER(4);
  BEGIN
    judge := scmdata.pkg_plat_comm.f_company_has_app(pi_company_id => comp_id,
                                                     pi_apply_id   => 'apply_6');
    IF judge = 1 THEN
      scmdata.pkg_approve_insert.p_insert_nes_approve(comp_id => comp_id,
                                                      good_id => goo_id,
                                                      oi_str  => oi_str,
                                                      cre_id  => cre_id);
    END IF;
  END p_generate_nes_approve_info;

  --批版条件校验
  PROCEDURE p_approver_result_verify
  (
    v_avid IN VARCHAR2,
    v_cpid IN VARCHAR2,
    v_usid IN VARCHAR2
  ) IS
  
    ass_results    VARCHAR2(256);
    v_gooid        VARCHAR2(32);
    v_supcode      VARCHAR2(32);
    ev0_cnt        NUMBER(1);
    ev1_cnt        NUMBER(1);
    ev2_cnt        NUMBER(1);
    ev3_cnt        NUMBER(1);
    ev4_cnt        NUMBER(1);
    app_result     VARCHAR2(8);
    app_status     VARCHAR2(8);
    v_cfid         VARCHAR2(32);
    v_err_re       NUMBER(1);
    v_rela_gooid   VARCHAR2(32);
    empty_result   VARCHAR2(256);
    v_judge        NUMBER(1);
    v_apptype      VARCHAR2(32);
    v_apptype_name VARCHAR2(32);
  BEGIN
  
    --dyy153 20220516 批版类型不为空校验 begin
    SELECT COUNT(1)
      INTO v_judge
      FROM scmdata.t_approve_version t
     WHERE t.approve_version_id = v_avid
       AND t.company_id = v_cpid
       AND t.approve_type IS NULL;
  
    IF v_judge = 1 THEN
      raise_application_error(-20002, '“批版类型”为必填项，请检查！');
    END IF;
    --dyy153 20220516   批版类型不为空校验 end
  
    --zwh73 20211228 复版原因校验 begin
    /*20220516  dyy153修改
    当批版次数≥2，且待批版列表的“货号+批版类型”在已批版列表中已存在，“复版原因”为必填 */
    SELECT MAX(x.goo_id),
           MAX(x.rela_goo_id),
           MAX(x.supplier_code),
           MAX(y.approve_type),
           MAX(z.group_dict_name)
      INTO v_gooid,
           v_rela_gooid,
           v_supcode,
           v_apptype,
           v_apptype_name
      FROM scmdata.t_commodity_info x
     INNER JOIN scmdata.t_approve_version y
        ON x.goo_id = y.goo_id
       AND x.company_id = y.company_id
       AND y.approve_version_id = v_avid
       AND y.company_id = v_cpid
     INNER JOIN scmdata.sys_group_dict z
        ON z.group_dict_value = y.approve_type
       AND z.group_dict_type = 'APPROVE_TYPE';
  
    SELECT nvl(MAX(1), 0)
      INTO v_err_re
      FROM scmdata.t_approve_version a
     WHERE a.approve_version_id = v_avid
       AND a.approve_number >= 2
       AND a.re_version_reason IS NULL
       AND a.company_id = v_cpid
       AND EXISTS (SELECT 1
              FROM scmdata.t_approve_version t
             WHERE t.approve_status IN ('AS01', 'AS02')
               AND t.goo_id = v_gooid
               AND t.approve_type = v_apptype);
    IF v_err_re = 1 THEN
      raise_application_error(-20002,
                              v_rela_gooid || ' 的 ' || v_apptype_name ||
                              ' 为复版， 主表-复版原因为必填，请检查！');
    END IF;
  
    --zwh73 20211228 复版原因校验 end
  
    SELECT listagg(assess_result, ';') || ';'
      INTO ass_results
      FROM scmdata.t_approve_risk_assessment
     WHERE approve_version_id = v_avid
       AND company_id = v_cpid;
  
    ev0_cnt := regexp_count(ass_results, ' ');
    ev1_cnt := regexp_count(ass_results, 'EVRT01');
    ev2_cnt := regexp_count(ass_results, 'EVRT02');
    ev3_cnt := regexp_count(ass_results, 'EVRT03');
    ev4_cnt := regexp_count(ass_results, 'EVRT04');
  
    IF ev0_cnt + ev4_cnt = 4 THEN
      app_status := 'AS01';
      app_result := 'AS02';
    ELSIF ev0_cnt = 0
          AND ev1_cnt + ev3_cnt + ev4_cnt = 4 THEN
      app_status := 'AS01';
      app_result := 'AS03';
    ELSIF ev0_cnt = 0
          AND ev2_cnt >= 1 THEN
      app_status := 'AS01';
      app_result := 'AS04';
    ELSE
      --zwh73 begin 20211229
      SELECT listagg(b.group_dict_name, ';') || ';'
        INTO empty_result
        FROM scmdata.t_approve_risk_assessment a
       INNER JOIN scmdata.sys_group_dict b
          ON a.assess_type = b.group_dict_value
         AND b.group_dict_type = 'BAD_FACTOR'
       WHERE approve_version_id = v_avid
         AND a.company_id = v_cpid
         AND assess_result = ' ';
      raise_application_error(-20002,
                              empty_result || '评语、评估结果未填，请检查！');
    
      --  RAISE_APPLICATION_ERROR(-20002, '请将结果填写完成！');
      --zwh73 end 20211229
    
    END IF;
  
    UPDATE scmdata.t_approve_version
       SET approve_status  = app_status,
           approve_result  = app_result,
           approve_time    = SYSDATE,
           approve_user_id = v_usid,
           approve_number  = decode(approve_number, 0, 1, approve_number),
           supplier_code   = v_supcode
     WHERE approve_version_id = v_avid;
  
    FOR i IN (SELECT a.approve_file_id,
                     b.goo_id,
                     a.company_id,
                     c.commodity_info_id,
                     a.file_type,
                     a.file_id,
                     a.pic_id,
                     a.create_id,
                     a.create_time,
                     a.update_id,
                     a.update_time,
                     a.commodity_file_id
                FROM (SELECT approve_file_id,
                             approve_version_id,
                             company_id,
                             file_type,
                             file_id,
                             pic_id,
                             create_id,
                             create_time,
                             update_id,
                             update_time,
                             commodity_file_id
                        FROM scmdata.t_approve_file
                       WHERE approve_version_id = v_avid
                         AND company_id = v_cpid
                         AND file_type IN ('01', '02')) a
                LEFT JOIN scmdata.t_approve_version b
                  ON a.approve_version_id = b.approve_version_id
                 AND a.company_id = b.company_id
                LEFT JOIN scmdata.t_commodity_info c
                  ON b.goo_id = c.goo_id
                 AND b.company_id = c.company_id) LOOP
    
      v_cfid := scmdata.f_get_uuid();
    
      IF i.create_id <> 'ADMIN' THEN
        IF i.commodity_file_id IS NULL THEN
          INSERT INTO scmdata.t_commodity_file
            (commodity_file_id, commodity_info_id, goo_id, company_id, file_type, file_id, picture_id, create_id, create_time, update_id, update_time)
          VALUES
            (v_cfid, i.commodity_info_id, i.goo_id, i.company_id, i.file_type, i.file_id, i.pic_id, i.create_id, i.create_time, i.update_id, i.update_time);
        
          UPDATE scmdata.t_approve_file
             SET commodity_file_id = v_cfid
           WHERE approve_file_id = i.approve_file_id
             AND company_id = i.company_id;
        ELSE
          UPDATE scmdata.t_commodity_file
             SET update_id   = nvl(i.update_id, i.create_id),
                 update_time = SYSDATE,
                 file_id     = i.file_id,
                 picture_id  = i.pic_id
           WHERE commodity_file_id = i.commodity_file_id
             AND company_id = i.company_id
             AND file_type = i.file_type;
        END IF;
      END IF;
    END LOOP;
  
    UPDATE scmdata.t_production_progress pr
       SET pr.approve_edition = app_result
     WHERE company_id = v_cpid
       AND goo_id = v_gooid;
  
    UPDATE scmdata.t_qc_goo_collect
       SET approve_result = app_result
     WHERE company_id = v_cpid
       AND goo_id = v_gooid;
  
    --zwh73 2022/4/16 生成已批版报表
    scmdata.pkg_approve_report.p_log_approve_report(p_approve_vesrion_id => v_avid);
  
    --zwh73 20220609 同步生成印绣花面料检测审核
    scmdata.pkg_fabric_evaluate.p_sync_yxh_by_approve(pi_approve_version_id => v_avid);
  END p_approver_result_verify;

  --生成批版不合格处理picklist
  FUNCTION f_get_apunqual_treatment_picklist(v_assesstype IN VARCHAR2)
    RETURN VARCHAR2 IS
    v_exesql  VARCHAR2(4000);
    v_dictype VARCHAR2(32);
  BEGIN
    IF v_assesstype = 'EVAL11' THEN
      v_dictype := 'APUNQUAL_TREATMENT';
      v_exesql  := f_generate_ap_utsentance(v_codes => ',RFBV,RGMV,SPMD,RDM,EVPS,UQCG,',
                                            v_type  => v_dictype);
    ELSIF v_assesstype = 'EVAL12' THEN
      v_dictype := 'APUNQUAL_TREATMENT_GY';
      v_exesql  := f_generate_ap_utsentance(v_codes => ',RMEV,RGMV,SPMD,',
                                            v_type  => v_dictype);
    ELSIF v_assesstype = 'EVAL13' THEN
      v_dictype := 'APUNQUAL_TREATMENT_GY';
      v_exesql  := f_generate_ap_utsentance(v_codes => ',RSMB,RGMV,RDM,RST,REM,RWA,SPMD,',
                                            v_type  => v_dictype);
    ELSIF v_assesstype = 'EVAL14' THEN
      v_dictype := 'APUNQUAL_TREATMENT_GY';
      v_exesql  := f_generate_ap_utsentance(v_codes => ',RGMV,SPMD,',
                                            v_type  => v_dictype);
    END IF;
    RETURN v_exesql;
  END f_get_apunqual_treatment_picklist;

  --生成批版不合格处理执行语句
  FUNCTION f_generate_ap_utsentance
  (
    v_codes IN VARCHAR2,
    v_type  IN VARCHAR2
  ) RETURN VARCHAR2 IS
    v_exesql VARCHAR2(4000);
  BEGIN
    v_exesql := 'SELECT APUNQUAL_TREATMENT,APUNQUAL_TREATMENT_DESC FROM (' ||
                'SELECT GROUP_DICT_VALUE APUNQUAL_TREATMENT, GROUP_DICT_NAME APUNQUAL_TREATMENT_DESC, GROUP_DICT_SORT AP_SORT ' ||
                'FROM SCMDATA.SYS_GROUP_DICT ' ||
                'WHERE GROUP_DICT_TYPE = ''' || v_type || ''' ' ||
                'AND INSTR(''' || v_codes ||
                ''','',''||GROUP_DICT_VALUE||'','')>0 ' ||
                'UNION ALL SELECT ''/'' APUNQUAL_TREATMENT, ''/'' APUNQUAL_TREATMENT_DESC, 99 AP_SORT FROM DUAL) ' ||
                'ORDER BY AP_SORT';
    RETURN v_exesql;
  END f_generate_ap_utsentance;

  --插入批版记录表主表（创建者为系统管理员）
  ----新增复版/页面新增的创建人记录为当前操作人 by dyy153 20220617
  PROCEDURE p_insert_approve_version_without_creator
  (
    v_apvid  IN VARCHAR2 DEFAULT NULL,
    v_stcode IN VARCHAR2 DEFAULT NULL,
    v_spcode IN VARCHAR2 DEFAULT NULL,
    v_compid IN VARCHAR2,
    v_goodid IN VARCHAR2,
    v_origin IN VARCHAR2,
    v_apvoid IN VARCHAR2 DEFAULT NULL,
    cre_id   IN VARCHAR2 DEFAULT 'ADMIN'
  ) IS
    v_apnum    NUMBER(4);
    v_appvid   VARCHAR2(32) := v_apvid;
    v_stycode  VARCHAR2(32) := v_stcode;
    v_supcode  VARCHAR2(32) := v_spcode;
    v_cate     VARCHAR2(32);
    v_procate  VARCHAR2(32);
    v_app_type VARCHAR2(32);
    v_bcode    VARCHAR2(32) := scmdata.f_getkeyid_plat('BILL_CODE',
                                                       'seq_billcode',
                                                       99);
  BEGIN
    IF v_appvid IS NULL THEN
      v_appvid := scmdata.f_getkeyid_plat('AP_VERSION',
                                          'seq_approve_version',
                                          '99');
    END IF;
  
    SELECT decode(MAX(approve_number), NULL, 0, MAX(approve_number) + 1)
      INTO v_apnum
      FROM scmdata.t_approve_version
     WHERE approve_version_id = v_apvoid
       AND company_id = v_compid;
  
    IF v_stycode IS NOT NULL
       OR v_supcode IS NOT NULL THEN
      SELECT style_number,
             supplier_code,
             category,
             product_cate
        INTO v_stycode,
             v_supcode,
             v_cate,
             v_procate
        FROM scmdata.t_commodity_info
       WHERE goo_id = v_goodid
         AND company_id = v_compid;
    
      IF v_cate = '03'
         OR (v_cate = '08' AND v_procate = '113' OR v_procate = '114') THEN
        v_app_type := '';
      ELSE
        v_app_type := 'CONFIRM_VERSION';
      END IF;
    
      INSERT INTO scmdata.t_approve_version
        (approve_version_id, company_id, bill_code, approve_status, approve_number, approve_result, goo_id, style_code, create_time, origin, create_id, supplier_code, approve_type)
      VALUES
        (v_appvid, v_compid, v_bcode, 'AS00', v_apnum, 'AS00', v_goodid, v_stycode, SYSDATE, v_origin, cre_id, v_supcode, v_app_type);
    END IF;
  END p_insert_approve_version_without_creator;

  --复版带入批版风险评估表数据
  PROCEDURE p_insert_apriskassement_by_reap
  (
    v_apvid  IN VARCHAR2,
    v_apid   IN VARCHAR2,
    v_compid IN VARCHAR2
  ) IS
  
  BEGIN
    FOR i IN (SELECT *
                FROM scmdata.t_approve_risk_assessment
               WHERE approve_version_id = v_apvid
                 AND company_id = v_compid) LOOP
      INSERT INTO scmdata.t_approve_risk_assessment
        (approve_risk_assessment_id, approve_version_id, company_id, unqual_treatment, assess_type, assess_say, risk_warning, assess_result, unqualified_say, assess_user_id, assess_time, remarks)
      VALUES
        (scmdata.f_get_uuid(), v_apid, v_compid, i.unqual_treatment, i.assess_type, i.assess_say, i.risk_warning, i.assess_result, i.unqualified_say, i.assess_user_id, i.assess_time, i.remarks);
    END LOOP;
  END p_insert_apriskassement_by_reap;

  --插入批版附件表
  PROCEDURE p_insert_approve_file
  (
    v_apvid  IN VARCHAR2,
    v_compid IN VARCHAR2
  ) IS
  BEGIN
    p_insert_empty_apfile(v_apvid  => v_apvid,
                          v_compid => v_compid,
                          v_type   => '01');
    p_insert_empty_apfile(v_apvid  => v_apvid,
                          v_compid => v_compid,
                          v_type   => '02');
  END p_insert_approve_file;

  --插入空的批版附件记录
  PROCEDURE p_insert_empty_apfile
  (
    v_apvid  IN VARCHAR2,
    v_compid IN VARCHAR2,
    v_type   IN VARCHAR2
  ) IS
    v_file  VARCHAR2(256);
    v_pic   VARCHAR2(256);
    v_cid   VARCHAR2(32);
    v_cdate DATE;
    v_cfid  VARCHAR2(32);
  BEGIN
    SELECT MAX(file_id),
           MAX(picture_id),
           MAX(create_id),
           MAX(create_time),
           MAX(commodity_file_id)
      INTO v_file,
           v_pic,
           v_cid,
           v_cdate,
           v_cfid
      FROM scmdata.t_commodity_file
     WHERE file_type = v_type
       AND (commodity_info_id, company_id) IN
           (SELECT commodity_info_id,
                   company_id
              FROM scmdata.t_commodity_info z
             WHERE EXISTS (SELECT 1
                      FROM scmdata.t_approve_version
                     WHERE approve_version_id = v_apvid
                       AND company_id = v_compid
                       AND goo_id = z.goo_id
                       AND company_id = z.company_id));
    INSERT INTO scmdata.t_approve_file
      (approve_file_id, approve_version_id, company_id, file_type, file_id, pic_id, create_id, create_time, commodity_file_id)
    VALUES
      (scmdata.f_get_uuid(), v_apvid, v_compid, v_type, v_file, v_pic, nvl(v_cid,
            'ADMIN'), nvl(v_cdate, SYSDATE), v_cfid);
  END p_insert_empty_apfile;

END pkg_approve_insert;
/

