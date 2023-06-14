--批量导入跟单员
DECLARE
  v_type       VARCHAR2(256);
  v_cate       VARCHAR2(256);
  p_company_id VARCHAR2(32) := 'b6cc680ad0f599cde0531164a8c0337f';
  v_flw_order varchar2(4000);
BEGIN
  FOR i IN (SELECT t.col_1,
                   t.col_2,
                   t.col_3,
                   t.col_4,
                   t.col_5,
                   t.col_6,
                   t.col_7
              FROM scmdata.t_excel_import t) LOOP
    --查找供应商分类
    SELECT listagg(DISTINCT sp.cooperation_type, ';'),
           listagg(DISTINCT sa.coop_classification, ';') within GROUP(ORDER BY sa.coop_classification) coop_classification
      INTO v_type, v_cate
      FROM scmdata.t_supplier_info sp
      LEFT JOIN scmdata.t_coop_scope sa
        ON sa.company_id = sp.company_id
       AND sa.supplier_info_id = sp.supplier_info_id
     WHERE sp.company_id = p_company_id
       AND sp.supplier_code = i.col_4;
  
    --导入员工所在部门是否与分布存在映射关系
    SELECT listagg(a.user_id, ';') user_id
      INTO v_flw_order
      FROM sys_company_user a
     INNER JOIN sys_user b
        ON a.user_id = b.user_id
      LEFT JOIN sys_company_user_dept c
        ON a.user_id = c.user_id
       AND a.company_id = c.company_id
      LEFT JOIN sys_company_dept d
        ON c.company_dept_id = d.company_dept_id
       AND c.company_id = d.company_id
      LEFT JOIN scmdata.sys_company_dept_cate_map e
        ON d.company_id = e.company_id
       AND d.company_dept_id = e.company_dept_id
     WHERE a.company_id = p_company_id
       AND instr(i.col_2, a.inner_user_id) > 0
       AND e.cooperation_type = v_type
       AND instr_priv(v_cate, e.cooperation_classification) > 0
       AND a.pause = 0
       AND b.pause = 0
       AND e.pause = 0;
    IF v_flw_order is not null THEN
      UPDATE scmdata.t_supplier_info t
         SET t.gendan_perid = v_flw_order
       WHERE t.company_id = p_company_id
         AND t.supplier_code = i.col_4;
    ELSE
      NULL;
    END IF;
  END LOOP;
END;
