CREATE OR REPLACE PACKAGE SCMDATA.PKG_QCGROUP_CONFIG IS

  -- Author  : SANFU
  -- Created : 2022/4/6 14:25:59
  -- Purpose : qc配置相关

 /*----------------------------------------------------------------------------

 校验qc分组的分类+生产类别
 入参：
  V_COMID      企业id
  V_CATE       分类
  V_PROCATE    生产类别
  V_QCGRCATEID  qc品类、区域配置主键id
  V_QCGRID     qc组主键id

 -------------------------------------------------------------------------------*/

  PROCEDURE P_CHECK_QC_CATE_PROCATE(V_COMID      IN VARCHAR2,
                                    V_CATE       IN VARCHAR2,
                                    V_PROCATE    IN VARCHAR2,
                                    V_QCGRCATEID IN VARCHAR2,
                                    V_QCGRID     IN VARCHAR2
                                    /*V_AREAID     IN VARCHAR2*/);

/*----------------------------------------------------------------------------

 校验qc分组的分类+生产类别
 入参：
  V_COMID      企业id
  V_CATE       分类
  V_PROCATE    生产类别
  V_QCGRCATEID  qc品类、区域配置主键id
  V_AREACFID    qc组配置区域id

 -------------------------------------------------------------------------------*/

  PROCEDURE P_CHECK_QC_CATE_AREA_CONFIG(V_COMID      IN VARCHAR2,
                                        V_CATE       IN VARCHAR2,
                                        V_PROCATE    IN VARCHAR2,
                                        V_QCGRCATEID IN VARCHAR2,
                                        --V_QCGRCFGID  IN VARCHAR2,
                                        V_AREACFID   IN VARCHAR2);

 --提交时校验qc组别唯一性
  PROCEDURE P_CHECK_QCGROUPCONFIG_BY_SUBMIT(P_GC_REC SCMDATA.T_QC_GROUP_CONFIG%ROWTYPE);


 --qc组别配置的启停按钮
  PROCEDURE P_PAUSE_QC_GROUP_CONFIG(V_COMID    IN VARCHAR2,
                                    V_QCCFG_ID IN VARCHAR2,
                                    V_FIELD    IN VARCHAR2,
                                    V_UPID     IN VARCHAR2,
                                    V_STATUS   IN NUMBER);
 --qc组别品类、区域配置的启停按钮
  PROCEDURE P_PAUSE_QCGROUP_CATE_CONFIG(V_COMID        IN VARCHAR2,
                                        V_QCCATECFG_ID IN VARCHAR2,
                                        V_FIELD        IN VARCHAR2,
                                        V_UPID         IN VARCHAR2,
                                        V_STATUS       IN NUMBER);

END PKG_QCGROUP_CONFIG;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.PKG_QCGROUP_CONFIG IS

  --校验QC合作分类，生产类别不可重复
  PROCEDURE P_CHECK_QC_CATE_PROCATE(V_COMID      IN VARCHAR2,
                                    V_CATE       IN VARCHAR2,
                                    V_PROCATE    IN VARCHAR2,
                                    V_QCGRCATEID IN VARCHAR2,
                                    V_QCGRID     IN VARCHAR2
                                    /*V_AREAID     IN VARCHAR2*/) IS
    V_FLAG NUMBER;

  BEGIN
    SELECT COUNT(1)
      INTO V_FLAG
      FROM SCMDATA.T_QC_GROUP_CONFIG A
     INNER JOIN SCMDATA.T_QC_GROUP_CATE_CONFIG T
        ON A.QC_GROUP_ID = T.QC_GROUP_ID
       AND A.COMPANY_ID = T.COMPANY_ID
     WHERE T.COMPANY_ID = V_COMID
       AND T.QCGROUP_CATE_CONFIG_ID <> V_QCGRCATEID
       AND T.QC_GROUP_ID = V_QCGRID
       AND INSTR_PRIV(T.CATEGORY, V_CATE) > 0
       AND INSTR_PRIV(T.PRODUCT_CATE, V_PROCATE) > 0
       AND A.PAUSE = 1
       AND T.PAUSE = 1;
    IF V_FLAG > 0 THEN
      RAISE_APPLICATION_ERROR(-20002,
                              '合作分类、可生产类别，已经存在，请重新填写！');
    ELSE
      NULL;
    END IF;
  END P_CHECK_QC_CATE_PROCATE;

  --校验QC品类\区域配置
  PROCEDURE P_CHECK_QC_CATE_AREA_CONFIG(V_COMID      IN VARCHAR2,
                                        V_CATE       IN VARCHAR2,
                                        V_PROCATE    IN VARCHAR2,
                                        V_QCGRCATEID IN VARCHAR2,
                                        --V_QCGRCFGID  IN VARCHAR2,
                                        V_AREACFID   IN VARCHAR2) IS
    --v_effective_time       DATE;
    --v_end_time             DATE;
    V_CATE_NUM         NUMBER;
    V_CATE_QC_GROUP_ID VARCHAR2(3000);
    V_CATE_QC_GROUP    VARCHAR2(3000);
    V_TIPS             VARCHAR2(3000);

  BEGIN
    /*--校验合作分类，生产类别不可重复
    P_CHECK_QC_CATE_PROCATE(V_COMID      => V_COMID,
                            V_CATE       => V_CATE,
                            V_PROCATE    => V_PROCATE,
                            V_QCGRCATEID => V_QCGRCATEID,
                            V_QCGRID     => V_QCGRCFGID);*/

    /*SELECT MAX(a.effective_time), MAX(a.end_time)
     INTO v_effective_time, v_end_time
     FROM SCMDATA.T_QC_GROUP_CONFIG a
    WHERE a.qc_group_id  = V_QCGRCFGID
      AND a.company_id = V_COMID;  */

    --校验品类、区域唯一
    SELECT COUNT(1), LISTAGG(T.QC_GROUP_ID, ';')
      INTO V_CATE_NUM, V_CATE_QC_GROUP_ID
      FROM SCMDATA.T_QC_GROUP_CONFIG A
     INNER JOIN SCMDATA.T_QC_GROUP_CATE_CONFIG T
        ON A.QC_GROUP_ID = T.QC_GROUP_ID
       AND A.COMPANY_ID = T.COMPANY_ID
     WHERE T.COMPANY_ID = V_COMID
       AND T.QCGROUP_CATE_CONFIG_ID <> V_QCGRCATEID
       AND INSTR_PRIV(T.CATEGORY, V_CATE) > 0
       AND INSTR_PRIV(T.PRODUCT_CATE, V_PROCATE) > 0
       AND INSTR_PRIV(T.AREA_CONFIG_ID, V_AREACFID) > 0
       AND A.PAUSE = 1
       AND T.PAUSE = 1
    /*AND EXISTS
    (SELECT 1
             FROM dual
            WHERE (((v_effective_time BETWEEN a.effective_time AND
                  a.end_time) OR
                  (v_end_time BETWEEN a.effective_time AND a.end_time)) OR
                  ((a.effective_time BETWEEN v_effective_time AND
                  v_end_time) OR
                  (a.end_time BETWEEN v_effective_time AND v_end_time))))*/
    ;

    IF V_CATE_NUM > 0 THEN
      SELECT LISTAGG(T.QC_GROUP, ';')
        INTO V_CATE_QC_GROUP
        FROM SCMDATA.T_QC_GROUP_CONFIG T
       WHERE INSTR(V_CATE_QC_GROUP_ID, T.QC_GROUP_ID) > 0
        AND T.PAUSE = 1;
      V_TIPS := '当前分类+生产类别+所在区域已存在分组：[' || V_CATE_QC_GROUP || '],请检查！！';
      RAISE_APPLICATION_ERROR(-20002, V_TIPS);
    ELSE
      NULL;
    END IF;
  END P_CHECK_QC_CATE_AREA_CONFIG;

  --校验所在分组配置
  --在有效期间内（生效时间~失效时间），且状态为“正常”，所在分组名称不可重复，一个区域组长只属于一个分组；
  --有效期间内（生效时间~失效时间），且状态为“正常”，选择区域时，需剔除已选的区域，如：广州/汕头组已选了广东省广州市了，其他分组则不可选择广东省广州市；品类同理
  PROCEDURE P_CHECK_QCGROUPCONFIG_BY_SUBMIT(P_GC_REC SCMDATA.T_QC_GROUP_CONFIG%ROWTYPE) IS
    V_FLAG NUMBER;
  BEGIN
    IF P_GC_REC.PAUSE = 0 THEN
      --IF P_GC_REC.END_TIME > P_GC_REC.EFFECTIVE_TIME THEN
      SELECT COUNT(1)
        INTO V_FLAG
        FROM SCMDATA.T_QC_GROUP_CONFIG A
       WHERE A.COMPANY_ID = P_GC_REC.COMPANY_ID
         AND A.QC_GROUP_ID <> P_GC_REC.QC_GROUP_ID
         AND A.PAUSE = 1
         AND EXISTS
       (SELECT 1
                FROM DUAL
               WHERE (A.QC_GROUP = P_GC_REC.QC_GROUP OR
                     A.QC_GROUP_LEADER = P_GC_REC.QC_GROUP_LEADER));

      IF V_FLAG > 0 THEN
        RAISE_APPLICATION_ERROR(-20002,
                                '状态为“正常”的组别中,QC组别/QC主管不可重复!');
      ELSE
        NULL;
      END IF;
      /* ELSE
        RAISE_APPLICATION_ERROR(-20002, '失效时间应大于生效时间！');
      END IF;*/
    ELSE
      RAISE_APPLICATION_ERROR(-20002, '该配置已启用，不可重复操作！');
    END IF;

  END P_CHECK_QCGROUPCONFIG_BY_SUBMIT;

  --qc配置启停按钮
  PROCEDURE P_PAUSE_QC_GROUP_CONFIG(V_COMID    IN VARCHAR2,
                                    V_QCCFG_ID IN VARCHAR2,
                                    V_FIELD    IN VARCHAR2,
                                    V_UPID     IN VARCHAR2,
                                    V_STATUS   IN NUMBER) IS
    V_WHERE  VARCHAR2(4000);
    P_GC_REC SCMDATA.T_QC_GROUP_CATE_CONFIG%ROWTYPE;
  BEGIN
    --校验 品类、区域配置
    IF V_STATUS = 1 THEN
      FOR P_GC_REC IN (SELECT A.*
                         FROM SCMDATA.T_QC_GROUP_CONFIG T
                        INNER JOIN SCMDATA.T_QC_GROUP_CATE_CONFIG A
                           ON T.QC_GROUP_ID = A.QC_GROUP_ID
                          AND T.COMPANY_ID = V_COMID
                        WHERE T.QC_GROUP_ID = V_QCCFG_ID
                          AND T.PAUSE = 0
                          AND A.PAUSE = 1) LOOP

           P_CHECK_QC_CATE_AREA_CONFIG(V_COMID     => V_COMID,
                                        V_CATE     => P_GC_REC.CATEGORY,
                                        V_PROCATE  => P_GC_REC.PRODUCT_CATE,
                                        V_QCGRCATEID => P_GC_REC.QCGROUP_CATE_CONFIG_ID,
                                        --V_QCGRCFGID  IN VARCHAR2,
                                        V_AREACFID  => P_GC_REC.AREA_CONFIG_ID);


        /*P_CHECK_QC_CATE_PROCATE(V_COMID      => V_COMID,
                                V_CATE       => P_GC_REC.CATEGORY,
                                V_PROCATE    => P_GC_REC.PRODUCT_CATE,
                                V_QCGRCATEID => P_GC_REC.QCGROUP_CATE_CONFIG_ID,
                                V_QCGRID     => P_GC_REC.QC_GROUP_ID);*/

      END LOOP;
    END IF;
    V_WHERE := q'[ where company_id = ']' || V_COMID ||
               q'[' and qc_group_id  = ']' || V_QCCFG_ID || q'[']';

    EXECUTE IMMEDIATE 'begin
  pkg_plat_comm.p_pause(p_table       => :table,
                        p_pause_field => :field,
                        p_where       => :p_where,
                        p_user_id     => :user_id,
                        p_status      => :status);
                        end;'
      USING 't_qc_group_config', V_FIELD, V_WHERE, V_UPID, V_STATUS;
  END P_PAUSE_QC_GROUP_CONFIG;

  --p_field:pause
  --  QC组别品类、区域配置的启停按钮
  PROCEDURE P_PAUSE_QCGROUP_CATE_CONFIG(V_COMID        IN VARCHAR2,
                                        V_QCCATECFG_ID IN VARCHAR2,
                                        V_FIELD        IN VARCHAR2,
                                        V_UPID         IN VARCHAR2,
                                        V_STATUS       IN NUMBER) IS
    V_WHERE VARCHAR2(4000);
    --p_gc_rec scmdata.t_supplier_group_category_config%ROWTYPE;
  BEGIN
    --校验 品类、区域配置
    IF V_STATUS = 1 THEN
      FOR P_GC_REC IN (SELECT *
                         FROM SCMDATA.T_QC_GROUP_CATE_CONFIG T
                        WHERE T.QCGROUP_CATE_CONFIG_ID = V_QCCATECFG_ID
                          AND T.COMPANY_ID = V_COMID
                          AND T.PAUSE = 0) LOOP

        P_CHECK_QC_CATE_AREA_CONFIG(V_COMID      => V_COMID,
                                    V_CATE       => P_GC_REC.CATEGORY,
                                    V_PROCATE    => P_GC_REC.PRODUCT_CATE,
                                    V_QCGRCATEID => P_GC_REC.QCGROUP_CATE_CONFIG_ID,
                                    --V_QCGRCFGID  => P_GC_REC.QC_GROUP_ID,
                                    V_AREACFID   => P_GC_REC.AREA_CONFIG_ID);
      END LOOP;
    END IF;

    V_WHERE := q'[ where company_id = ']' || V_COMID ||
               q'[' and qcgroup_cate_config_id   = ']' || V_QCCATECFG_ID ||
               q'[']';

    EXECUTE IMMEDIATE 'begin
  pkg_plat_comm.p_pause(p_table       => :table,
                        p_pause_field => :field,
                        p_where       => :p_where,
                        p_user_id     => :user_id,
                        p_status      => :status);
                        end;'
      USING 't_qc_group_cate_config', V_FIELD, V_WHERE, V_UPID, V_STATUS;

  END P_PAUSE_QCGROUP_CATE_CONFIG;
END PKG_QCGROUP_CONFIG;
/

