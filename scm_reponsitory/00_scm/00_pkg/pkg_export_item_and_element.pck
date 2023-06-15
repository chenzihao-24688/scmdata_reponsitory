CREATE OR REPLACE PACKAGE SCMDATA.pkg_export_item_and_element AUTHID CURRENT_USER IS
  --获取跳跃的节点
  FUNCTION f_get_jump_items(ins_items IN CLOB) RETURN CLOB;

  --单条 SQL 构成
  FUNCTION f_get_core(ownatab  IN VARCHAR2,
                      cond_str IN VARCHAR2,
                      cldlval  IN CLOB,
                      clcoval  IN VARCHAR2,
                      wouqcols IN VARCHAR2,
                      wouqvals IN VARCHAR2,
                      wiuqcols IN VARCHAR2,
                      wiuqvals IN VARCHAR2) RETURN CLOB;

  --关联表值获取
  FUNCTION f_get_unqvals_from_rela(mas_tab    IN VARCHAR2,
                                   sla_tab    IN VARCHAR2,
                                   cond_col   IN VARCHAR2,
                                   rela_col   IN VARCHAR2,
                                   rela_vals  IN VARCHAR2,
                                   extra_cond IN VARCHAR2,
                                   startnum   IN NUMBER DEFAULT 0,
                                   endnum     IN NUMBER DEFAULT 0)
    RETURN CLOB;

  --获取正确顺序列及带格式列
  FUNCTION f_get_ordcols_fmtcols_clbcol(v_owner IN VARCHAR2,
                                        v_tab   IN VARCHAR2,
                                        v_cols  IN VARCHAR2,
                                        v_uqcol IN VARCHAR2) RETURN CLOB;

  --获取 DECLARE定义语句 及 VAL补充值（用于 改写占位符 和 USING后填充）
  FUNCTION f_get_dlval_clval(ins_clcols IN VARCHAR2) RETURN CLOB;

  --处理信息（运行主程序）
  PROCEDURE p_processing_info(opuser    IN VARCHAR2,
                              optime    IN DATE,
                              unq_col   IN VARCHAR2,
                              unq_vals  IN VARCHAR2,
                              rela_tabs IN VARCHAR2);

  --单唯一列下获取执行 SQL
  PROCEDURE p_get_execute_sql_by_single_unqcol(opuser          IN VARCHAR2,
                                               optime          IN DATE,
                                               ins_ucol        IN VARCHAR2,
                                               ins_uvals       IN VARCHAR2,
                                               ins_clval       IN VARCHAR2,
                                               ins_dlval       IN CLOB,
                                               ins_cowner      IN VARCHAR2,
                                               ins_ctab        IN VARCHAR2,
                                               ins_ordwiuqcols IN VARCHAR2,
                                               ins_ordwouqcols IN VARCHAR2,
                                               ins_fmtwiwqcols IN VARCHAR2,
                                               ins_fmtwowqcols IN VARCHAR2);

  --多唯一列下获取执行 SQL
  PROCEDURE p_get_execute_sql_by_multi_unqcol(opuser          IN VARCHAR2,
                                              optime          IN DATE,
                                              ins_ucols       IN VARCHAR2,
                                              ins_uvals       IN VARCHAR2,
                                              ins_clval       IN VARCHAR2,
                                              ins_dlval       IN CLOB,
                                              ins_cowner      IN VARCHAR2,
                                              ins_ctab        IN VARCHAR2,
                                              ins_ordwiuqcols IN VARCHAR2,
                                              ins_ordwouqcols IN VARCHAR2,
                                              ins_fmtwiwqcols IN VARCHAR2,
                                              ins_fmtwowqcols IN VARCHAR2);

  --获取根节点下所有更新数据
  PROCEDURE p_get_all_data_from_rootitem(root_itemid IN VARCHAR2,
                                         operator    IN VARCHAR2,
                                         oper_time   IN DATE);
END pkg_export_item_and_element;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_export_item_and_element IS
  --获取跳跃的节点
  FUNCTION f_get_jump_items(ins_items IN CLOB) RETURN CLOB IS
    items CLOB := ins_items;
    rets  CLOB;
    ret1  CLOB;
    ret2  CLOB;
    ret   CLOB;
  BEGIN
    SELECT listagg(aitem, ',') || ',' || listagg(titem, ',')
      INTO rets
      FROM (SELECT a.item_id aitem, c.item_id titem
              FROM NBW.sys_item_element_rela a
             INNER JOIN NBW.sys_associate b
                ON a.element_id = b.element_id
              LEFT JOIN NBW.sys_tree_list c
                ON b.node_id = c.node_id) t
     WHERE connect_by_iscycle = 0
     START WITH regexp_count(items, aitem) > 0
    CONNECT BY nocycle PRIOR t.titem = t.aitem
           AND PRIOR t.titem <> t.aitem;

    rets := regexp_replace(rets, '^,{0,}', '');

    IF rets IS NOT NULL THEN
      SELECT xmlagg(xmlparse(content COL || ',' wellformed) ORDER BY 1).getclobval() --listagg(DISTINCT col, ',')
        INTO items
        FROM (SELECT DISTINCT col from (SELECT to_char(regexp_substr(items || ',' || rets, '[^,]+', 1, LEVEL)) col
                FROM dual
              CONNECT BY LEVEL <=
                         regexp_count(items || ',' || rets, '\,') + 1));
    END IF;

    SELECT listagg(aitem, ',') || ',' || listagg(tcoitem, ',') || ',' ||
           listagg(tcaitem, ',')
      INTO ret1
      FROM (SELECT a.item_id            aitem,
                   d.to_confirm_item_id tcoitem,
                   d.to_cancel_item_id  tcaitem
              FROM NBW.sys_item_element_rela a
             INNER JOIN NBW.sys_action b
                ON a.element_id = b.element_id
             INNER JOIN NBW.sys_cond_rela c
                ON b.element_id = c.ctl_id
             INNER JOIN NBW.sys_cond_operate d
                ON c.cond_id = d.cond_id) x
     START WITH regexp_count(items, x.aitem) > 0
    CONNECT BY nocycle PRIOR x.aitem = x.tcoitem
           AND x.aitem = x.tcoitem;

    SELECT listagg(aitem, ',') || ',' || listagg(tcoitem, ',') || ',' ||
           listagg(tcaitem, ',')
      INTO ret2
      FROM (SELECT a.item_id            aitem,
                   d.to_confirm_item_id tcoitem,
                   d.to_cancel_item_id  tcaitem
              FROM NBW.sys_item_element_rela a
             INNER JOIN NBW.sys_action b
                ON a.element_id = b.element_id
             INNER JOIN NBW.sys_cond_rela c
                ON b.element_id = c.ctl_id
             INNER JOIN NBW.sys_cond_operate d
                ON c.cond_id = d.cond_id) x
     START WITH regexp_count(items, x.aitem) > 0
    CONNECT BY nocycle PRIOR x.aitem = x.tcaitem
           AND x.aitem <> x.tcaitem;

    ret := ret1 || ',' || ret2;

    ret := regexp_replace(ret, '^,{0,}', '');

    IF ret IS NOT NULL THEN
      SELECT xmlagg(xmlparse(content COL || ',' wellformed) ORDER BY 1).getclobval() --listagg(DISTINCT col, ',')
        INTO items
        FROM (SELECT DISTINCT col FROM (SELECT to_char(regexp_substr(items || ',' || ret, '[^,]+', 1, LEVEL)) col
                FROM dual
              CONNECT BY LEVEL <=
                         regexp_count(items || ',' || ret, '\,') + 1));

    END IF;
    RETURN items;
  END;

  --单条 SQL 构成
  FUNCTION f_get_core(ownatab  IN VARCHAR2,
                      cond_str IN VARCHAR2,
                      cldlval  IN CLOB,
                      clcoval  IN VARCHAR2,
                      wouqcols IN VARCHAR2,
                      wouqvals IN VARCHAR2,
                      wiuqcols IN VARCHAR2,
                      wiuqvals IN VARCHAR2) RETURN CLOB IS
    ret_sql      CLOB;
    using_clause VARCHAR2(128);
    jug_cond     VARCHAR2(1024);
    update_val   CLOB;
    insert_val   CLOB;
    oat          VARCHAR2(64);
  BEGIN
    oat := REPLACE(ownatab, 'NBW.', 'NBW.');
    IF cldlval IS NOT NULL THEN
      using_clause := ' USING ' || ltrim(clcoval, ',');
    END IF;
    jug_cond := REPLACE(cond_str, '''', '''''');
    --UPDATE_VAL
    IF length(TRIM(wouqvals)) > 0 THEN
      update_val := REPLACE(wouqvals, '''', '''''') ||
                    REPLACE(clcoval, ',', ',:');
    ELSE
      update_val := ltrim(REPLACE(clcoval, ',', ',:'), ',');
    END IF;
    --INSERT_VAL
    IF length(TRIM(wouqvals)) > 0 THEN
      insert_val := REPLACE(wiuqvals, '''', '''''') ||
                    REPLACE(clcoval, ',', ',:');
    ELSE
      insert_val := ltrim(REPLACE(clcoval, ',', ',:'), ',');
    END IF;
    ret_sql := 'BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;' || cldlval || chr(10) || '
  BEGIN
    EXE_SQL := ''SELECT COUNT(1) FROM ' || oat || ' WHERE ' ||
               jug_cond || ''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := ''UPDATE ' || oat || ' SET (' ||
               ltrim(TRIM(wouqcols), ',') || ') = (SELECT ' || update_val ||
               ' FROM DUAL) WHERE ' || REPLACE(cond_str, '''', '''''') || ''';
       WHILE REGEXP_COUNT(EXE_SQL,'',,'') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,'',,'','',NULL,'');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,''SELECT ,'',''SELECT NULL,''),'', FROM'','',NULL FROM'');
       EXECUTE IMMEDIATE EXE_SQL' || using_clause || ';
     ELSE
       EXE_SQL := ''INSERT INTO ' || oat || ' (' ||
               ltrim(TRIM(wiuqcols), ',') || ') SELECT ' || insert_val ||
               ' FROM DUAL'';
       WHILE REGEXP_COUNT(EXE_SQL,'',,'') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,'',,'','',NULL,'');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,''SELECT ,'',''SELECT NULL,''),'', FROM'','',NULL FROM'');
       EXECUTE IMMEDIATE EXE_SQL' || using_clause || ';
     END IF;
  END;
END;
/';
    RETURN ret_sql;
  END f_get_core;

  --关联表值获取
  FUNCTION f_get_unqvals_from_rela(mas_tab    IN VARCHAR2,
                                   sla_tab    IN VARCHAR2,
                                   cond_col   IN VARCHAR2,
                                   rela_col   IN VARCHAR2,
                                   rela_vals  IN VARCHAR2,
                                   extra_cond IN VARCHAR2,
                                   startnum   IN NUMBER DEFAULT 0,
                                   endnum     IN NUMBER DEFAULT 0)
    RETURN CLOB IS
    retvals_c  CLOB;
    cond_sql   VARCHAR2(4000);
    exesql_c   VARCHAR2(4000);
    cur        SYS_REFCURSOR;
    v_tmpcol01 VARCHAR2(64);
    v_tmpcol02 VARCHAR2(64);
    v_col01    CLOB;
    v_col02    CLOB;
  BEGIN
    IF startnum <> 0
       AND endnum <> 0 THEN
      cond_sql := 'WHERE RN BETWEEN ' || startnum || ' AND ' || endnum;
    END IF;
    /*EXESQL_C := 'SELECT LISTAGG(COL1,'','') WITHIN GROUP(ORDER BY RN)||''^^^^^^''||LISTAGG(COL2,'','') WITHIN GROUP(ORDER BY RN)
     FROM (SELECT '||COND_COL||' COL1,'||RELA_COL||' COL2, ROWNUM RN FROM '||MAS_TAB||' A
    WHERE EXISTS (SELECT 1 FROM '||SLA_TAB||' WHERE '||COND_COL||' = A.'||COND_COL||' '||EXTRA_COND||')
      AND REGEXP_COUNT('''||RELA_VALS||''','',''||'||RELA_COL||'||'','') > 0
      AND PAUSE = 0) '||COND_SQL;
    EXECUTE IMMEDIATE EXESQL_C INTO RETVALS_C;*/

    exesql_c := 'SELECT DISTINCT COL1,COL2 FROM (SELECT ' || cond_col ||
                ' COL1,' || rela_col || ' COL2, ROWNUM RN FROM ' || mas_tab || ' A
    WHERE EXISTS (SELECT 1 FROM ' || sla_tab || ' WHERE ' ||
                cond_col || ' = A.' || cond_col || ' ' || extra_cond || ')
      AND REGEXP_COUNT(''' || rela_vals || ''','',''||' ||
                rela_col || '||'','') > 0) ' || cond_sql;

    OPEN cur FOR exesql_c;
    LOOP
      FETCH cur
        INTO v_tmpcol01, v_tmpcol02;
      IF v_col01 IS NULL THEN
        v_col01 := v_tmpcol01;
        v_col02 := v_tmpcol02;
      ELSE
        v_col01 := v_col01 || ',' || v_tmpcol01;
        v_col02 := v_col02 || ',' || v_tmpcol02;
      END IF;
      EXIT WHEN cur%NOTFOUND;
    END LOOP;
    CLOSE cur;

    retvals_c := v_col01 || '^^^^^^' || v_col02;
    RETURN retvals_c;
  END f_get_unqvals_from_rela;

  --获取正确顺序列及带格式列
  FUNCTION f_get_ordcols_fmtcols_clbcol(v_owner IN VARCHAR2,
                                        v_tab   IN VARCHAR2,
                                        v_cols  IN VARCHAR2,
                                        v_uqcol IN VARCHAR2) RETURN CLOB IS
    icols       VARCHAR2(4000); --INPUT COLUMNS
    ccol        VARCHAR2(4000); --CURRENT COLUMN
    judge_str   VARCHAR2(32); --JUDGE STRING
    ordwiuq_col VARCHAR2(4000); --ORDER COLUMN
    ordwouq_col VARCHAR2(4000); --ORDER COLUMN
    wiuq_fmtcol VARCHAR2(4000); --FORMAT COLUMN WITHIN UNQUE COLUMN
    wouq_fmtcol VARCHAR2(4000); --FORMAT COLUMN WITHOUT UNQUE COLUMN
    clob_col    VARCHAR2(4000); --CLOB COLUMN
    ret_union   CLOB; --RESULT UNION
    err_info    CLOB; --ERROR INFO
  BEGIN
    icols := upper(v_cols) || ',';
    WHILE length(icols) > 0 LOOP
      --获取单列名称
      ccol := substr(icols, 1, instr(icols, ',') - 1);
      --删除单列名
      icols := substr(icols, instr(icols, ',') + 1, length(icols));
      BEGIN
        --查出数据类型
        SELECT data_type
          INTO judge_str
          FROM scmdata.all_tab_columns_backup
         WHERE owner = v_owner
           AND table_name = v_tab
           AND column_name = ccol;
      EXCEPTION
        WHEN OTHERS THEN
          err_info := 'ERR_MESSAGE: ' || SQLERRM || chr(10) ||
                      'ERR_MENTION: WRONG TABLE COLUMN' || chr(10) ||
                      'ERR_COL: ' || ccol || chr(10) || 'ERR_COLS: ' ||
                      icols || chr(10) || 'TABLE_NAME: ' || v_owner || '.' ||
                      v_tab;
          raise_application_error(-20002, err_info);
      END;
      --组成返回字段
      IF judge_str = 'VARCHAR2'
         OR judge_str = 'BLOB' THEN
        IF regexp_count(',' || v_uqcol || ',', ',' || ccol || ',') = 0 THEN
          wiuq_fmtcol := wiuq_fmtcol || '||'',''||' || '''q''''[''||' || ccol ||
                         '||'']''''''';
          wouq_fmtcol := wouq_fmtcol || '||'',''||' || '''q''''[''||' || ccol ||
                         '||'']''''''';
          ordwiuq_col := ordwiuq_col || ',' || ccol;
          ordwouq_col := ordwouq_col || ',' || ccol;
        ELSE
          wiuq_fmtcol := wiuq_fmtcol || '||'',''||' || '''''''''||' || ccol ||
                         '||''''''''';
          ordwiuq_col := ordwiuq_col || ',' || ccol;
        END IF;
      ELSIF judge_str = 'DATE' THEN
        IF regexp_count(',' || v_uqcol || ',', ',' || ccol || ',') = 0 THEN
          --WIUQ_FMTCOL := WIUQ_FMTCOL||'||'',''||'||'TO_CHAR(''''||CAST('''||CCOL||''' AS DATE)||'''',''''yyyy-MM-dd HH24-mi-ss'''')';
          --WOUQ_FMTCOL := WOUQ_FMTCOL||'||'',''||'||'TO_CHAR(''''||CAST('''||CCOL||''' AS DATE)||'''',''''yyyy-MM-dd HH24-mi-ss'''')';
          wiuq_fmtcol := wiuq_fmtcol || '||'',''||' ||
                         ' ''REPL''||TO_CHAR(CAST(' || ccol ||
                         ' AS DATE),''yyyy-MM-dd HH24-mi-ss'')||''REPR'' ';
          wouq_fmtcol := wouq_fmtcol || '||'',''||' ||
                         ' ''REPL''||TO_CHAR(CAST(' || ccol ||
                         ' AS DATE),''yyyy-MM-dd HH24-mi-ss'')||''REPR'' ';
          ordwiuq_col := ordwiuq_col || ',' || ccol;
          ordwouq_col := ordwouq_col || ',' || ccol;
        ELSE
          wiuq_fmtcol := wiuq_fmtcol || '||'',''||' ||
                         'TO_CHAR(''''||CAST(''' || ccol ||
                         ''' AS DATE)||'''',''''yyyy-MM-dd HH24-mi-ss'''')';
          ordwiuq_col := ordwiuq_col || ',' || ccol;
        END IF;
      ELSIF judge_str = 'NUMBER'
            OR judge_str = 'INTEGER' THEN
        IF regexp_count(',' || v_uqcol || ',', ',' || ccol || ',') = 0 THEN
          wiuq_fmtcol := wiuq_fmtcol || '||'',''||' || ccol;
          wouq_fmtcol := wouq_fmtcol || '||'',''||' || ccol;
          ordwiuq_col := ordwiuq_col || ',' || ccol;
          ordwouq_col := ordwouq_col || ',' || ccol;
        ELSE
          wiuq_fmtcol := wiuq_fmtcol || '||'',''||' || ccol;
          ordwiuq_col := ordwiuq_col || ',' || ccol;
        END IF;
      ELSIF judge_str = 'CLOB' THEN
        clob_col := clob_col || ',' || ccol;
      END IF;
    END LOOP;
    ret_union := nvl(ltrim(ordwiuq_col, ','), ' ') || '^^^^^^' ||
                 nvl(ltrim(ordwouq_col, ','), ' ') || '^^^^^^' ||
                 nvl(substr(wiuq_fmtcol, 8, length(wiuq_fmtcol)), ' ') ||
                 '^^^^^^' ||
                 nvl(substr(wouq_fmtcol, 8, length(wiuq_fmtcol)), ' ') ||
                 '^^^^^^' || nvl(clob_col, ' ');
    RETURN ret_union;
  END f_get_ordcols_fmtcols_clbcol;

  --获取 DECLARE定义语句 及 VAL补充值（用于 改写占位符 和 USING后填充）
  FUNCTION f_get_dlval_clval(ins_clcols IN VARCHAR2) RETURN CLOB IS
    clcolswc VARCHAR2(4000);
    clcol    VARCHAR2(512);
    counter  NUMBER(4);
    dlval    CLOB;
    clval    VARCHAR2(4000);
  BEGIN
    clcolswc := ltrim(ins_clcols, ',') || ',';
    counter  := 1;
    WHILE length(clcolswc) > 0 LOOP
      IF clcolswc <> ',' THEN
        clcol    := substr(clcolswc, 1, instr(clcolswc, ',') - 1);
        clcolswc := substr(clcolswc,
                           instr(clcolswc, ',') + 1,
                           length(clcolswc));
        dlval    := dlval || chr(10) || '  CV' || counter || ' CLOB:=' ||
                    'q''''^''||' || clcol || '||''^'''';';
        clval    := clval || ',' || 'CV' || counter;
        counter  := counter + 1;
      ELSE
        EXIT;
      END IF;
    END LOOP;
    RETURN dlval || '^^^^^^' || clval;
  END f_get_dlval_clval;

  --处理信息（运行主程序）
  PROCEDURE p_processing_info(opuser    IN VARCHAR2,
                              optime    IN DATE,
                              unq_col   IN VARCHAR2,
                              unq_vals  IN VARCHAR2,
                              rela_tabs IN VARCHAR2) IS
    rtabs        VARCHAR2(256);
    rtab         VARCHAR2(64);
    uvals        CLOB;
    wiuqcol      VARCHAR2(4000);
    ofccols      CLOB; -- ORDCOLS,FMTCOLS,CLOBCOLS
    clcols       VARCHAR2(4000); -- CLOB COLUMNS
    ordwiuqcols  VARCHAR2(4000); -- ORDER COLUMNS
    ordwouqcols  VARCHAR2(4000); -- ORDER COLUMNS
    fmtwiuq_cols VARCHAR2(4000); -- FORMAT COLUMNS WITHIN UNIQUE COLUMN
    fmtwouq_cols VARCHAR2(4000); -- FORMAT COLUMNS WITHOUT UNIQUE COLUMN
    clunion      CLOB; -- CLOB COLUMN UNION
    dlval        CLOB; -- DECLARE CLAUSE VALUE
    clval        VARCHAR2(4000); -- CLOB COLUMN VALUE
    cowner       VARCHAR2(32);
    ctab         VARCHAR2(32);
  BEGIN
    --赋值
    rtabs := upper(rela_tabs) || ',';
    uvals := unq_vals || ',';
    --单条件情况
    WHILE length(rtabs) > 0 LOOP
      --分离出单表
      rtab  := substr(rtabs, 1, instr(rtabs, ',') - 1);
      rtabs := substr(rtabs, instr(rtabs, ',') + 1, length(rtabs));
      --分离表归属和表名
      cowner := substr(rtab, 1, instr(rtab, '.') - 1);
      ctab   := substr(rtab, instr(rtab, '.') + 1, length(rtab));
      --获取所有列
      SELECT listagg(column_name, ',')
        INTO wiuqcol
        FROM scmdata.all_tab_columns_backup
       WHERE owner = cowner
         AND table_name = ctab;
      --获取 ORDCOLS,FMTCOLS,CLOBCOLS
      ofccols := f_get_ordcols_fmtcols_clbcol(v_owner => cowner,
                                              v_tab   => ctab,
                                              v_cols  => wiuqcol,
                                              v_uqcol => unq_col);
      --CLOB列
      clcols := substr(ofccols,
                       instr(ofccols, '^^^^^^', 1, 4) + 6,
                       length(ofccols));
      --顺序列
      ordwiuqcols := substr(ofccols, 1, instr(ofccols, '^^^^^^') - 1) ||
                     clcols;
      ordwouqcols := substr(ofccols,
                            instr(ofccols, '^^^^^^', 1, 1) + 6,
                            instr(ofccols, '^^^^^^', 1, 2) -
                            instr(ofccols, '^^^^^^', 1, 1) - 6) || clcols;
      --格式化列,带唯一列,不带唯一列,均不带 CLOB 列
      fmtwiuq_cols := substr(ofccols,
                             instr(ofccols, '^^^^^^', 1, 2) + 6,
                             instr(ofccols, '^^^^^^', 1, 3) -
                             instr(ofccols, '^^^^^^', 1, 2) - 6);
      fmtwouq_cols := substr(ofccols,
                             instr(ofccols, '^^^^^^', 1, 3) + 6,
                             instr(ofccols, '^^^^^^', 1, 4) -
                             instr(ofccols, '^^^^^^', 1, 3) - 6);
      --获取CLOB值列
      IF length(TRIM(clcols)) > 0 THEN
        clunion := f_get_dlval_clval(ins_clcols => clcols);
        dlval   := substr(clunion, 1, instr(clunion, '^^^^^^') - 1);
        clval   := substr(clunion,
                          instr(clunion, '^^^^^^') + 6,
                          length(clunion));
      END IF;
      --判断唯一列是否为单列
      IF instr(unq_col, ',') = 0 THEN
        scmdata.pkg_export_item_and_element.p_get_execute_sql_by_single_unqcol(opuser          => opuser,
                                                                               optime          => optime,
                                                                               ins_ucol        => unq_col,
                                                                               ins_uvals       => uvals,
                                                                               ins_clval       => clval,
                                                                               ins_dlval       => dlval,
                                                                               ins_cowner      => cowner,
                                                                               ins_ctab        => ctab,
                                                                               ins_ordwiuqcols => ordwiuqcols,
                                                                               ins_ordwouqcols => ordwouqcols,
                                                                               ins_fmtwiwqcols => fmtwiuq_cols,
                                                                               ins_fmtwowqcols => fmtwouq_cols);
      ELSE
        scmdata.pkg_export_item_and_element.p_get_execute_sql_by_multi_unqcol(opuser          => opuser,
                                                                              optime          => optime,
                                                                              ins_ucols       => unq_col,
                                                                              ins_uvals       => uvals,
                                                                              ins_clval       => clval,
                                                                              ins_dlval       => dlval,
                                                                              ins_cowner      => cowner,
                                                                              ins_ctab        => ctab,
                                                                              ins_ordwiuqcols => ordwiuqcols,
                                                                              ins_ordwouqcols => ordwouqcols,
                                                                              ins_fmtwiwqcols => fmtwiuq_cols,
                                                                              ins_fmtwowqcols => fmtwouq_cols);
      END IF;
    END LOOP;
  END p_processing_info;

  --单唯一列下获取执行 SQL
  PROCEDURE p_get_execute_sql_by_single_unqcol(opuser          IN VARCHAR2,
                                               optime          IN DATE,
                                               ins_ucol        IN VARCHAR2,
                                               ins_uvals       IN VARCHAR2,
                                               ins_clval       IN VARCHAR2,
                                               ins_dlval       IN CLOB,
                                               ins_cowner      IN VARCHAR2,
                                               ins_ctab        IN VARCHAR2,
                                               ins_ordwiuqcols IN VARCHAR2,
                                               ins_ordwouqcols IN VARCHAR2,
                                               ins_fmtwiwqcols IN VARCHAR2,
                                               ins_fmtwowqcols IN VARCHAR2) IS
    uval          VARCHAR2(64);
    ucol          VARCHAR2(4000) := ins_ucol;
    uvals         CLOB := ins_uvals;
    clval         VARCHAR2(4000) := ins_clval;
    dlval         CLOB := ins_dlval;
    cowner        VARCHAR2(32) := ins_cowner;
    ctab          VARCHAR2(32) := ins_ctab;
    ordwiuqcols   VARCHAR2(4000) := ins_ordwiuqcols;
    ordwouqcols   VARCHAR2(4000) := ins_ordwouqcols;
    fmtwiuq_cols  VARCHAR2(4000) := ins_fmtwiwqcols;
    fmtwouq_cols  VARCHAR2(4000) := ins_fmtwowqcols;
    rfmtwiuq_vals VARCHAR2(4000);
    rfmtwouq_vals VARCHAR2(4000);
    rdlval        CLOB;
    tcond         VARCHAR2(512);
    exe_sql       CLOB;
    abex_sql      CLOB;
    jug_num       NUMBER(4);
    oatable       VARCHAR2(64);
  BEGIN
    oatable := cowner || '.' || ctab;
    --为单列
    WHILE length(uvals) > 0 LOOP
      --分离出唯一列值
      uval  := substr(uvals, 1, instr(uvals, ',') - 1);
      uvals := substr(uvals, instr(uvals, ',') + 1, length(uvals));
      --构造条件
      tcond   := ucol || ' = ''' || uval || '''';
      exe_sql := 'SELECT COUNT(1) FROM ' || oatable || ' WHERE ' || tcond;
      EXECUTE IMMEDIATE exe_sql
        INTO jug_num;
      IF jug_num > 0 THEN
        --格式化列赋值
        exe_sql := 'SELECT ' || fmtwiuq_cols || ' FROM ' || oatable ||
                   ' WHERE ' || tcond;
        EXECUTE IMMEDIATE exe_sql
          INTO rfmtwiuq_vals;
        rfmtwiuq_vals := REPLACE(REPLACE(rfmtwiuq_vals,
                                         'REPL',
                                         'TO_DATE('''),
                                 'REPR',
                                 ''',''yyyy-MM-dd HH24-mi-ss'')');
        IF length(TRIM(fmtwouq_cols)) > 0 THEN
          exe_sql := 'SELECT ' || fmtwouq_cols || ' FROM ' || oatable ||
                     ' WHERE ' || tcond;
          EXECUTE IMMEDIATE exe_sql
            INTO rfmtwouq_vals;
          rfmtwouq_vals := REPLACE(REPLACE(rfmtwouq_vals,
                                           'REPL',
                                           'TO_DATE('''),
                                   'REPR',
                                   ''',''yyyy-MM-dd hh24-mi-ss'')');
        END IF;
        --DECLARE 部分 CLOB定义语句 赋值
        IF length(TRIM(clval)) > 0 THEN
          exe_sql := 'SELECT ''' || dlval || ''' FROM ' || oatable ||
                     ' WHERE ' || tcond;
          EXECUTE IMMEDIATE exe_sql
            INTO rdlval;
        END IF;
        --构建可执行 SQL，需要提前构造 COND_STR ，以支持多条件
        abex_sql := f_get_core(ownatab  => oatable,
                               cond_str => tcond,
                               cldlval  => rdlval,
                               clcoval  => clval,
                               wouqcols => ordwouqcols,
                               wouqvals => rfmtwouq_vals,
                               wiuqcols => ordwiuqcols,
                               wiuqvals => rfmtwiuq_vals);
        --插入
        INSERT INTO scmdata.t_export
          (ex_id,
           ex_time,
           ex_user,
           ex_data,
           tab_name)
        VALUES
          (scmdata.f_get_uuid(),
           optime,
           opuser,
           abex_sql,
           oatable);
        COMMIT;
        --DBMS_OUTPUT.PUT_LINE(ABEX_SQL);
      END IF;
    END LOOP;
  END p_get_execute_sql_by_single_unqcol;

  --多唯一列下获取执行 SQL
  PROCEDURE p_get_execute_sql_by_multi_unqcol(opuser          IN VARCHAR2,
                                              optime          IN DATE,
                                              ins_ucols       IN VARCHAR2,
                                              ins_uvals       IN VARCHAR2,
                                              ins_clval       IN VARCHAR2,
                                              ins_dlval       IN CLOB,
                                              ins_cowner      IN VARCHAR2,
                                              ins_ctab        IN VARCHAR2,
                                              ins_ordwiuqcols IN VARCHAR2,
                                              ins_ordwouqcols IN VARCHAR2,
                                              ins_fmtwiwqcols IN VARCHAR2,
                                              ins_fmtwowqcols IN VARCHAR2) IS
    ucols         VARCHAR2(4000) := ins_ucols;
    uvals         CLOB := ins_uvals;
    clval         VARCHAR2(4000) := ins_clval;
    dlval         CLOB := ins_dlval;
    cowner        VARCHAR2(32) := ins_cowner;
    ctab          VARCHAR2(32) := ins_ctab;
    ordwiuqcols   VARCHAR2(4000) := ins_ordwiuqcols;
    ordwouqcols   VARCHAR2(4000) := ins_ordwouqcols;
    fmtwiuq_cols  VARCHAR2(4000) := ins_fmtwiwqcols;
    fmtwouq_cols  VARCHAR2(4000) := ins_fmtwowqcols;
    rfmtwiuq_vals VARCHAR2(4000);
    rfmtwouq_vals VARCHAR2(4000);
    rdlval        CLOB;
    TYPE val_conditions IS TABLE OF VARCHAR2(4000) INDEX BY VARCHAR2(64);
    valcond  val_conditions;
    collidx  VARCHAR2(32);
    collval  VARCHAR2(4000);
    cnt      NUMBER(8);
    maxcnt   NUMBER(8);
    tmpidx   VARCHAR2(64);
    tmpval   VARCHAR2(64);
    tmpvval  VARCHAR2(4000);
    tcond    VARCHAR2(512);
    exe_sql  CLOB;
    abex_sql CLOB;
    jug_num  NUMBER(4);
    oatable  VARCHAR2(64);
  BEGIN
    oatable := cowner || '.' || ctab;
    ucols   := ucols || ',';
    uvals   := uvals || '^^^^^^';
    cnt     := 1;
    WHILE cnt < regexp_count(ucols, ',') + 1 LOOP
      IF cnt = 1 THEN
        collidx := substr(ucols, 1, instr(ucols, ',') - 1);
        collval := substr(uvals, 1, instr(uvals, '^^^^^^') - 1);
        valcond(collidx) := collval;
      ELSE
        collidx := substr(ucols,
                          instr(ucols, ',', 1, cnt - 1) + 1,
                          instr(ucols, ',', 1, cnt) -
                          instr(ucols, ',', 1, cnt - 1) - 1);
        collval := substr(uvals,
                          instr(uvals, '^^^^^^', 1, cnt - 1) + 6,
                          instr(uvals, '^^^^^^', 1, cnt) -
                          instr(uvals, '^^^^^^', 1, cnt - 1) - 6);
        valcond(collidx) := collval;
      END IF;
      cnt := cnt + 1;
    END LOOP;
    maxcnt := regexp_count(valcond(valcond.first) || ',', ',');
    FOR i IN 1 .. maxcnt LOOP
      tmpidx := valcond.first;
      WHILE tmpidx IS NOT NULL LOOP
        tmpvval := valcond(tmpidx) || ',';
        IF i = 1 THEN
          tmpval := substr(tmpvval, 1, instr(tmpvval, ',') - 1);
        ELSE
          tmpval := substr(tmpvval,
                           instr(tmpvval, ',', 1, i - 1) + 1,
                           instr(tmpvval, ',', 1, i) -
                           instr(tmpvval, ',', 1, i - 1) - 1);
        END IF;
        IF tmpval IS NOT NULL THEN
          tcond := tcond || ' AND ' || tmpidx || ' = ''' || tmpval || '''';
        END IF;
        tmpidx := valcond.next(tmpidx);
      END LOOP;
      IF tcond IS NOT NULL THEN
        tcond   := substr(tcond, 5, length(tcond));
        exe_sql := 'SELECT COUNT(1) FROM ' || oatable || ' WHERE ' || tcond;
        EXECUTE IMMEDIATE exe_sql
          INTO jug_num;
        IF jug_num > 0 THEN
          --格式化列赋值
          exe_sql := 'SELECT ' || fmtwiuq_cols || ' FROM ' || oatable ||
                     ' WHERE ' || tcond;
          EXECUTE IMMEDIATE exe_sql
            INTO rfmtwiuq_vals;
          rfmtwiuq_vals := REPLACE(REPLACE(rfmtwiuq_vals,
                                           'REPL',
                                           'TO_DATE('''),
                                   'REPR',
                                   ''',''yyyy-MM-dd HH24-mi-ss'')');
          IF length(TRIM(fmtwouq_cols)) > 0 THEN
            exe_sql := 'SELECT ' || fmtwouq_cols || ' FROM ' || oatable ||
                       ' WHERE ' || tcond;
            EXECUTE IMMEDIATE exe_sql
              INTO rfmtwouq_vals;
            rfmtwouq_vals := REPLACE(REPLACE(rfmtwouq_vals,
                                             'REPL',
                                             'TO_DATE('''),
                                     'REPR',
                                     ''',''yyyy-MM-dd hh24-mi-ss'')');
          END IF;
          --DECLARE 部分 CLOB定义语句 赋值
          IF length(TRIM(clval)) > 0 THEN
            exe_sql := 'SELECT ''' || dlval || ''' FROM ' || oatable ||
                       ' WHERE ' || tcond;
            EXECUTE IMMEDIATE exe_sql
              INTO rdlval;
          END IF;
          --构建可执行 SQL，需要提前构造 COND_STR ，以支持多条件
          abex_sql := f_get_core(ownatab  => oatable,
                                 cond_str => tcond,
                                 cldlval  => rdlval,
                                 clcoval  => clval,
                                 wouqcols => ordwouqcols,
                                 wouqvals => rfmtwouq_vals,
                                 wiuqcols => ordwiuqcols,
                                 wiuqvals => rfmtwiuq_vals);
          --插入
          INSERT INTO scmdata.t_export
            (ex_id,
             ex_time,
             ex_user,
             ex_data,
             tab_name)
          VALUES
            (scmdata.f_get_uuid(),
             optime,
             opuser,
             abex_sql,
             oatable);
          COMMIT;
          --DBMS_OUTPUT.PUT_LINE(ABEX_SQL);
        END IF;
      END IF;
      tcond := '';
    END LOOP;
  END p_get_execute_sql_by_multi_unqcol;

  --获取根节点下所有更新数据
  PROCEDURE p_get_all_data_from_rootitem(root_itemid IN VARCHAR2,
                                         operator    IN VARCHAR2,
                                         oper_time   IN DATE) IS
    itmvals_c CLOB;
    tmpvals_c CLOB;
    exesql_c  CLOB;
    unqvals_c CLOB;
    tmpnodes  CLOB;
    ins_str   CLOB;
    /*tmp_str   CLOB;
    tcnt      NUMBER(4);
    tpos      NUMBER(8);*/
    v_cnt     NUMBER(4);
  BEGIN
    --获取根节点下所有 ITEMS
    itmvals_c := scmdata.pkg_archive_common.f_get_allitems_by_rootitem(root_itemid => root_itemid);

    IF TRIM(itmvals_c) IS NOT NULL THEN
      itmvals_c := root_itemid || ',' || itmvals_c;
    ELSE
      itmvals_c := root_itemid;
    END IF;

    --获取跳跃的 ITEMS
    itmvals_c := scmdata.pkg_export_item_and_element.f_get_jump_items(ins_items => itmvals_c);

    --获取 SYS_ITEM,SYS_ITEM_LIST 数据
    scmdata.pkg_export_item_and_element.p_processing_info(opuser    => operator,
                                                          optime    => oper_time,
                                                          unq_col   => 'ITEM_ID',
                                                          unq_vals  => itmvals_c,
                                                          rela_tabs => 'NBW.SYS_ITEM,NBW.SYS_ITEM_LIST');

    --获取 SYS_TREE_LIST 数据
    exesql_c := 'SELECT LISTAGG(COL1,'','') WITHIN GROUP(ORDER BY RN)||''^^^^^^''||LISTAGG(COL2,'','') WITHIN GROUP(ORDER BY RN)
                   FROM (SELECT ITEM_ID COL1,NODE_ID COL2,ROWNUM RN
                           FROM NBW.SYS_TREE_LIST
                          WHERE REGEXP_COUNT(''' ||
                itmvals_c || ''',ITEM_ID) > 0)';
    EXECUTE IMMEDIATE exesql_c
      INTO tmpvals_c;
    tmpvals_c := regexp_replace(tmpvals_c, ',$', '');
    IF tmpvals_c <> '^^^^^^' THEN
      tmpnodes := substr(tmpvals_c,
                         instr(tmpvals_c, '^^^^^^') + 1,
                         length(tmpvals_c));
      scmdata.pkg_export_item_and_element.p_processing_info(opuser    => operator,
                                                            optime    => oper_time,
                                                            unq_col   => 'ITEM_ID,NODE_ID',
                                                            unq_vals  => tmpvals_c,
                                                            rela_tabs => 'NBW.SYS_TREE_LIST');
    END IF;

    --获取 SYS_DETAIL_GROUP 数据
    exesql_c := 'SELECT LISTAGG(COL1,'','') WITHIN GROUP(ORDER BY RN)||''^^^^^^''||LISTAGG(COL2,'','') WITHIN GROUP(ORDER BY RN)
                   FROM (SELECT ITEM_ID COL1,GROUP_NAME COL2,ROWNUM RN
                           FROM NBW.SYS_DETAIL_GROUP
                          WHERE REGEXP_COUNT(''' ||
                itmvals_c || ''',ITEM_ID) > 0)';
    EXECUTE IMMEDIATE exesql_c
      INTO tmpvals_c;
    tmpvals_c := regexp_replace(tmpvals_c, ',$', '');
    IF tmpvals_c <> '^^^^^^' THEN
      scmdata.pkg_export_item_and_element.p_processing_info(opuser    => operator,
                                                            optime    => oper_time,
                                                            unq_col   => 'ITEM_ID,GROUP_NAME',
                                                            unq_vals  => tmpvals_c,
                                                            rela_tabs => 'NBW.SYS_DETAIL_GROUP');
    END IF;

    /*--SHORTCUT
    SELECT LISTAGG(NODE_ID,',') INTO ITMVALS_C FROM BW3.SYS_TREE_LIST WHERE REGEXP_COUNT(ITMVALS_C||',',ITEM_ID||',') > 0;
    TMPVALS_C := SCMDATA.PKG_EXPORT_ITEM_AND_ELEMENT.F_GET_UNQVALS_FROM_RELA(MAS_TAB    => 'BW3.SYS_SHORTCUT_NODE_RELA',
                                                                             SLA_TAB    => 'BW3.SYS_SHORTCUT',
                                                                             COND_COL   => 'SHORT_ID',
                                                                             RELA_COL   => 'NODE_ID',
                                                                             RELA_VALS  => ITMVALS_C,
                                                                             EXTRA_COND => NULL);
    IF TMPVALS_C <> '^^^^^^' THEN
      UNQVALS_C := SUBSTR(TMPVALS_C,1,INSTR(TMPVALS_C,'^^^^^^')-1);
      ---获取相关 SHORTCUT 数据
      SCMDATA.PKG_EXPORT_ITEM_AND_ELEMENT.P_PROCESSING_INFO(OPUSER    => OPERATOR,
                                                            OPTIME    => OPER_TIME,
                                                            UNQ_COL   => 'SHORT_ID',
                                                            UNQ_VALS  => UNQVALS_C,
                                                            RELA_TABS => 'SYS_SHORTCUT');
      SCMDATA.PKG_EXPORT_ITEM_AND_ELEMENT.P_PROCESSING_INFO(OPUSER    => OPERATOR,
                                                            OPTIME    => OPER_TIME,
                                                            UNQ_COL   => 'SHORT_ID,NODE_ID',
                                                            UNQ_VALS  => TMPVALS_C,
                                                            RELA_TABS => 'SYS_SHORTCUT_NODE_RELA');
    END IF;*/

    --WEB_UNION
    exesql_c := 'SELECT LISTAGG(COL1,'','') WITHIN GROUP(ORDER BY RN)||''^^^^^^''||LISTAGG(COL2,'','') WITHIN GROUP(ORDER BY RN)
                   FROM (SELECT ITEM_ID COL1,UNION_ITEM_ID COL2,ROWNUM RN
                           FROM NBW.SYS_WEB_UNION
                          WHERE REGEXP_COUNT(''' ||
                itmvals_c || ''',ITEM_ID) > 0)';
    EXECUTE IMMEDIATE exesql_c
      INTO tmpvals_c;
    tmpvals_c := regexp_replace(tmpvals_c, ',$', '');
    IF tmpvals_c <> '^^^^^^' THEN
      scmdata.pkg_export_item_and_element.p_processing_info(opuser    => operator,
                                                            optime    => oper_time,
                                                            unq_col   => 'ITEM_ID,UNION_ITEM_ID',
                                                            unq_vals  => tmpvals_c,
                                                            rela_tabs => 'NBW.SYS_WEB_UNION');
    END IF;

    --SYS_ITEM_RELA
    exesql_c := 'SELECT LISTAGG(COL1,'','') WITHIN GROUP(ORDER BY RN)||''^^^^^^''||LISTAGG(COL2,'','') WITHIN GROUP(ORDER BY RN)
                   FROM (SELECT ITEM_ID COL1,RELATE_ID COL2,ROWNUM RN
                           FROM NBW.SYS_ITEM_RELA
                          WHERE REGEXP_COUNT(''' ||
                itmvals_c || ''',ITEM_ID) > 0)';
    EXECUTE IMMEDIATE exesql_c
      INTO tmpvals_c;
    tmpvals_c := regexp_replace(tmpvals_c, ',$', '');
    IF tmpvals_c <> '^^^^^^' THEN
      scmdata.pkg_export_item_and_element.p_processing_info(opuser    => operator,
                                                            optime    => oper_time,
                                                            unq_col   => 'ITEM_ID,RELATE_ID',
                                                            unq_vals  => tmpvals_c,
                                                            rela_tabs => 'NBW.SYS_ITEM_RELA');
    END IF;

    --COND
    ins_str := itmvals_c || ',' || tmpnodes || ',';

    FOR i IN (SELECT DISTINCT cond_id || '^^^^^^' || ctl_id || '^^^^^^' ||
                              obj_type || '^^^^^^' || ctl_type|| '^^^^^^' || item_id AS tmp
                FROM NBW.sys_cond_rela
               WHERE regexp_count(',' || ins_str || ',', ',' || ctl_id || ',') > 0) LOOP
      unqvals_c := substr(i.tmp, 1, instr(i.tmp, '^^^^^^') - 1);
      ---获取相关 COND 数据
      scmdata.pkg_export_item_and_element.p_processing_info(opuser    => operator,
                                                            optime    => oper_time,
                                                            unq_col   => 'COND_ID',
                                                            unq_vals  => unqvals_c,
                                                            rela_tabs => 'NBW.SYS_COND_LIST,NBW.SYS_COND_OPERATE');
      scmdata.pkg_export_item_and_element.p_processing_info(opuser    => operator,
                                                            optime    => oper_time,
                                                            unq_col   => 'COND_ID,CTL_ID,OBJ_TYPE,CTL_TYPE,ITEM_ID',
                                                            unq_vals  => i.tmp,
                                                            rela_tabs => 'NBW.SYS_COND_RELA');
    END LOOP;
    /*INS_STR := ITMVALS_C || ',' || TMPNODES ||',';

    WHILE LENGTH(INS_STR) > 0 LOOP
      TMP_STR   := SUBSTR(INS_STR, 1, 128);
      TCNT      := REGEXP_COUNT(TMP_STR, ',');
      TPOS      := INSTR(TMP_STR, ',', 1, TCNT);
      TMP_STR   := SUBSTR(INS_STR, 1, TPOS - 1);
      INS_STR   := SUBSTR(INS_STR, TPOS + 1, LENGTH(INS_STR));
      TMPVALS_C := SCMDATA.PKG_EXPORT_ITEM_AND_ELEMENT.F_GET_UNQVALS_FROM_RELA(MAS_TAB    => 'BW3.SYS_COND_RELA',
                                                                               SLA_TAB    => 'BW3.SYS_COND_LIST',
                                                                               COND_COL   => 'COND_ID',
                                                                               RELA_COL   => 'CTL_ID',
                                                                               RELA_VALS  => TMP_STR,
                                                                               EXTRA_COND => NULL);
      IF TMPVALS_C <> '^^^^^^' THEN
        UNQVALS_C := SUBSTR(TMPVALS_C, 1, INSTR(TMPVALS_C, '^^^^^^') - 1);
        ---获取相关 COND 数据
        SCMDATA.PKG_EXPORT_ITEM_AND_ELEMENT.P_PROCESSING_INFO(OPUSER    => OPERATOR,
                                                              OPTIME    => OPER_TIME,
                                                              UNQ_COL   => 'COND_ID',
                                                              UNQ_VALS  => UNQVALS_C,
                                                              RELA_TABS => 'BW3.SYS_COND_LIST,BW3.SYS_COND_OPERATE');
        SCMDATA.PKG_EXPORT_ITEM_AND_ELEMENT.P_PROCESSING_INFO(OPUSER    => OPERATOR,
                                                              OPTIME    => OPER_TIME,
                                                              UNQ_COL   => 'COND_ID,CTL_ID',
                                                              UNQ_VALS  => TMPVALS_C,
                                                              RELA_TABS => 'BW3.SYS_COND_RELA');
      END IF;
    END LOOP;

    V_CNT := 0;
    FOR ITEMELERELA IN (SELECT ELEMENT_ID
                          FROM BW3.SYS_ITEM_ELEMENT_RELA
                         WHERE REGEXP_COUNT(ITMVALS_C, ITEM_ID) > 0) LOOP
      IF V_CNT < 6 THEN
        V_CNT := V_CNT + 1;
        TMPVALS_C := TMPVALS_C ||','||ITEMELERELA.ELEMENT_ID;
      ELSE
        V_CNT := 0;
        INS_STR := LTRIM(TMPVALS_C,',')||',';
        WHILE LENGTH(INS_STR) > 0 LOOP
          TMP_STR   := SUBSTR(INS_STR, 1, 128);
          TCNT      := REGEXP_COUNT(TMP_STR, ',');
          TPOS      := INSTR(TMP_STR, ',', 1, TCNT);
          TMP_STR   := SUBSTR(INS_STR, 1, TPOS - 1);
          INS_STR   := SUBSTR(INS_STR, TPOS + 1, LENGTH(INS_STR));
          TMPVALS_C := SCMDATA.PKG_EXPORT_ITEM_AND_ELEMENT.F_GET_UNQVALS_FROM_RELA(MAS_TAB    => 'BW3.SYS_COND_RELA',
                                                                                   SLA_TAB    => 'BW3.SYS_COND_LIST',
                                                                                   COND_COL   => 'COND_ID',
                                                                                   RELA_COL   => 'CTL_ID',
                                                                                   RELA_VALS  => TMP_STR,
                                                                                   EXTRA_COND => NULL);
          IF TMPVALS_C <> '^^^^^^' THEN
            UNQVALS_C := SUBSTR(TMPVALS_C, 1, INSTR(TMPVALS_C, '^^^^^^') - 1);
            ---获取相关 COND 数据
            SCMDATA.PKG_EXPORT_ITEM_AND_ELEMENT.P_PROCESSING_INFO(OPUSER    => OPERATOR,
                                                                  OPTIME    => OPER_TIME,
                                                                  UNQ_COL   => 'COND_ID',
                                                                  UNQ_VALS  => UNQVALS_C,
                                                                  RELA_TABS => 'BW3.SYS_COND_LIST,BW3.SYS_COND_OPERATE');
            SCMDATA.PKG_EXPORT_ITEM_AND_ELEMENT.P_PROCESSING_INFO(OPUSER    => OPERATOR,
                                                                  OPTIME    => OPER_TIME,
                                                                  UNQ_COL   => 'COND_ID,CTL_ID',
                                                                  UNQ_VALS  => TMPVALS_C,
                                                                  RELA_TABS => 'BW3.SYS_COND_RELA');
          END IF;
        END LOOP;
        TMPVALS_C := '';
      END IF;
    END LOOP;*/

    --ACTION
    ---获取 UNQVALS1_C, UNQVALS2_C
    tmpvals_c := scmdata.pkg_export_item_and_element.f_get_unqvals_from_rela(mas_tab    => 'NBW.SYS_ITEM_ELEMENT_RELA',
                                                                             sla_tab    => 'NBW.SYS_ELEMENT',
                                                                             cond_col   => 'ELEMENT_ID',
                                                                             rela_col   => 'ITEM_ID',
                                                                             rela_vals  => itmvals_c,
                                                                             extra_cond => 'AND ELEMENT_TYPE=''action''');
    IF tmpvals_c <> '^^^^^^' THEN
      unqvals_c := substr(tmpvals_c, 1, instr(tmpvals_c, '^^^^^^') - 1);
      ---获取相关 ACTION 数据
      scmdata.pkg_export_item_and_element.p_processing_info(opuser    => operator,
                                                            optime    => oper_time,
                                                            unq_col   => 'ELEMENT_ID',
                                                            unq_vals  => unqvals_c,
                                                            rela_tabs => 'NBW.SYS_ELEMENT,NBW.SYS_ACTION');
      scmdata.pkg_export_item_and_element.p_processing_info(opuser    => operator,
                                                            optime    => oper_time,
                                                            unq_col   => 'ELEMENT_ID,ITEM_ID',
                                                            unq_vals  => tmpvals_c,
                                                            rela_tabs => 'NBW.SYS_ITEM_ELEMENT_RELA');
    END IF;

    --ASSOCIATE
    ---获取 UNQVALS1_C, UNQVALS2_C
    tmpvals_c := scmdata.pkg_export_item_and_element.f_get_unqvals_from_rela(mas_tab    => 'NBW.SYS_ITEM_ELEMENT_RELA',
                                                                             sla_tab    => 'NBW.SYS_ELEMENT',
                                                                             cond_col   => 'ELEMENT_ID',
                                                                             rela_col   => 'ITEM_ID',
                                                                             rela_vals  => itmvals_c,
                                                                             extra_cond => 'AND ELEMENT_TYPE=''associate''');
    IF tmpvals_c <> '^^^^^^' THEN
      unqvals_c := substr(tmpvals_c, 1, instr(tmpvals_c, '^^^^^^') - 1);
      ---获取相关 ASSOCIATE 数据
      scmdata.pkg_export_item_and_element.p_processing_info(opuser    => operator,
                                                            optime    => oper_time,
                                                            unq_col   => 'ELEMENT_ID',
                                                            unq_vals  => unqvals_c,
                                                            rela_tabs => 'NBW.SYS_ELEMENT,NBW.SYS_ASSOCIATE');
      scmdata.pkg_export_item_and_element.p_processing_info(opuser    => operator,
                                                            optime    => oper_time,
                                                            unq_col   => 'ELEMENT_ID,ITEM_ID',
                                                            unq_vals  => tmpvals_c,
                                                            rela_tabs => 'NBW.SYS_ITEM_ELEMENT_RELA');
      scmdata.pkg_export_item_and_element.p_processing_info(opuser    => operator,
                                                            optime    => oper_time,
                                                            unq_col   => 'ELEMENT_ID,ITEM_ID',
                                                            unq_vals  => tmpvals_c,
                                                            rela_tabs => 'NBW.SYS_ELEMENT_HINT');
    END IF;

    --WORD
    ---获取 UNQVALS1_C, UNQVALS2_C
    /*tmpvals_c := scmdata.pkg_export_item_and_element.f_get_unqvals_from_rela(mas_tab    => 'BW3.SYS_ITEM_ELEMENT_RELA',
                                                                             sla_tab    => 'BW3.SYS_ELEMENT',
                                                                             cond_col   => 'ELEMENT_ID',
                                                                             rela_col   => 'ITEM_ID',
                                                                             rela_vals  => itmvals_c,
                                                                             extra_cond => 'AND ELEMENT_TYPE=''word''');
    IF tmpvals_c <> '^^^^^^' THEN
      unqvals_c := substr(tmpvals_c, 1, instr(tmpvals_c, '^^^^^^') - 1);

      scmdata.pkg_export_item_and_element.p_processing_info(opuser    => operator,
                                                            optime    => oper_time,
                                                            unq_col   => 'ELEMENT_ID',
                                                            unq_vals  => unqvals_c,
                                                            rela_tabs => 'BW3.SYS_ELEMENT,BW3.SYS_FILE_TEMPLATE');

      scmdata.pkg_export_item_and_element.p_processing_info(opuser    => operator,
                                                            optime    => oper_time,
                                                            unq_col   => 'ELEMENT_ID',
                                                            unq_vals  => unqvals_c,
                                                            rela_tabs => 'BW3.SYS_FILE_TEMPLATE_TABLE');

      scmdata.pkg_export_item_and_element.p_processing_info(opuser    => operator,
                                                            optime    => oper_time,
                                                            unq_col   => 'ELEMENT_ID,ITEM_ID',
                                                            unq_vals  => tmpvals_c,
                                                            rela_tabs => 'BW3.SYS_ITEM_ELEMENT_RELA');
    END IF;*/

    --PICKLIST
    ---获取 UNQVALS1_C, UNQVALS2_C
    tmpvals_c := scmdata.pkg_export_item_and_element.f_get_unqvals_from_rela(mas_tab    => 'NBW.SYS_ITEM_ELEMENT_RELA',
                                                                             sla_tab    => 'NBW.SYS_ELEMENT',
                                                                             cond_col   => 'ELEMENT_ID',
                                                                             rela_col   => 'ITEM_ID',
                                                                             rela_vals  => itmvals_c,
                                                                             extra_cond => 'AND (ELEMENT_TYPE=''pick'' OR ELEMENT_TYPE=''picklist'')');
    IF tmpvals_c <> '^^^^^^' THEN
      ---获取ELEMENT_ID
      unqvals_c := substr(tmpvals_c, 1, instr(tmpvals_c, '^^^^^^') - 1);
      ---获取相关 PICKLIST 数据
      scmdata.pkg_export_item_and_element.p_processing_info(opuser    => operator,
                                                            optime    => oper_time,
                                                            unq_col   => 'ELEMENT_ID',
                                                            unq_vals  => unqvals_c,
                                                            rela_tabs => 'NBW.SYS_ELEMENT,NBW.SYS_PICK_LIST');
      scmdata.pkg_export_item_and_element.p_processing_info(opuser    => operator,
                                                            optime    => oper_time,
                                                            unq_col   => 'ELEMENT_ID,ITEM_ID',
                                                            unq_vals  => tmpvals_c,
                                                            rela_tabs => 'NBW.SYS_ITEM_ELEMENT_RELA');
    END IF;

    --ASSIGN
    ---获取 UNQVALS1_C, UNQVALS2_C
    tmpvals_c := scmdata.pkg_export_item_and_element.f_get_unqvals_from_rela(mas_tab    => 'NBW.SYS_ITEM_ELEMENT_RELA',
                                                                             sla_tab    => 'NBW.SYS_ELEMENT',
                                                                             cond_col   => 'ELEMENT_ID',
                                                                             rela_col   => 'ITEM_ID',
                                                                             rela_vals  => itmvals_c,
                                                                             extra_cond => 'AND ELEMENT_TYPE=''assign''');
    IF tmpvals_c <> '^^^^^^' THEN
      ---获取ELEMENT_ID
      unqvals_c := substr(tmpvals_c, 1, instr(tmpvals_c, '^^^^^^') - 1);
      ---获取相关 PICKLIST 数据
      scmdata.pkg_export_item_and_element.p_processing_info(opuser    => operator,
                                                            optime    => oper_time,
                                                            unq_col   => 'ELEMENT_ID',
                                                            unq_vals  => unqvals_c,
                                                            rela_tabs => 'NBW.SYS_ELEMENT,NBW.SYS_ASSIGN');
      scmdata.pkg_export_item_and_element.p_processing_info(opuser    => operator,
                                                            optime    => oper_time,
                                                            unq_col   => 'ELEMENT_ID,ITEM_ID',
                                                            unq_vals  => tmpvals_c,
                                                            rela_tabs => 'NBW.SYS_ITEM_ELEMENT_RELA');
    END IF;

    --LOOKUP
    ---获取 UNQVALS1_C, UNQVALS2_C
    tmpvals_c := scmdata.pkg_export_item_and_element.f_get_unqvals_from_rela(mas_tab    => 'NBW.SYS_ITEM_ELEMENT_RELA',
                                                                             sla_tab    => 'NBW.SYS_ELEMENT',
                                                                             cond_col   => 'ELEMENT_ID',
                                                                             rela_col   => 'ITEM_ID',
                                                                             rela_vals  => itmvals_c,
                                                                             extra_cond => 'AND ELEMENT_TYPE=''lookup''');
    v_cnt     := 0;
    WHILE (tmpvals_c <> '^^^^^^') LOOP
      tmpvals_c := scmdata.pkg_export_item_and_element.f_get_unqvals_from_rela(mas_tab    => 'NBW.SYS_ITEM_ELEMENT_RELA',
                                                                               sla_tab    => 'NBW.SYS_ELEMENT',
                                                                               cond_col   => 'ELEMENT_ID',
                                                                               rela_col   => 'ITEM_ID',
                                                                               rela_vals  => itmvals_c,
                                                                               extra_cond => 'AND ELEMENT_TYPE=''lookup''',
                                                                               startnum   => v_cnt + 1,
                                                                               endnum     => v_cnt + 10);
      IF tmpvals_c <> '^^^^^^' THEN
        ---获取ELEMENT_ID
        unqvals_c := substr(tmpvals_c, 1, instr(tmpvals_c, '^^^^^^') - 1);
        ---获取相关 LOOKUP 数据
        scmdata.pkg_export_item_and_element.p_processing_info(opuser    => operator,
                                                              optime    => oper_time,
                                                              unq_col   => 'ELEMENT_ID',
                                                              unq_vals  => unqvals_c,
                                                              rela_tabs => 'NBW.SYS_ELEMENT,NBW.SYS_LOOK_UP');
        scmdata.pkg_export_item_and_element.p_processing_info(opuser    => operator,
                                                              optime    => oper_time,
                                                              unq_col   => 'ELEMENT_ID,ITEM_ID',
                                                              unq_vals  => tmpvals_c,
                                                              rela_tabs => 'NBW.SYS_ITEM_ELEMENT_RELA');
      END IF;
      v_cnt := v_cnt + 10;
    END LOOP;

    --DEFAULT
    ---获取 UNQVALS1_C, UNQVALS2_C
    tmpvals_c := scmdata.pkg_export_item_and_element.f_get_unqvals_from_rela(mas_tab    => 'NBW.SYS_ITEM_ELEMENT_RELA',
                                                                             sla_tab    => 'NBW.SYS_ELEMENT',
                                                                             cond_col   => 'ELEMENT_ID',
                                                                             rela_col   => 'ITEM_ID',
                                                                             rela_vals  => itmvals_c,
                                                                             extra_cond => 'AND ELEMENT_TYPE=''default''');
    IF tmpvals_c <> '^^^^^^' THEN
      ---获取ELEMENT_ID
      unqvals_c := substr(tmpvals_c, 1, instr(tmpvals_c, '^^^^^^') - 1);
      ---获取相关 DEFAULT 数据
      scmdata.pkg_export_item_and_element.p_processing_info(opuser    => operator,
                                                            optime    => oper_time,
                                                            unq_col   => 'ELEMENT_ID',
                                                            unq_vals  => unqvals_c,
                                                            rela_tabs => 'NBW.SYS_DEFAULT');
      scmdata.pkg_export_item_and_element.p_processing_info(opuser    => operator,
                                                            optime    => oper_time,
                                                            unq_col   => 'ELEMENT_ID,ITEM_ID',
                                                            unq_vals  => tmpvals_c,
                                                            rela_tabs => 'NBW.SYS_ITEM_ELEMENT_RELA');
    END IF;
  END p_get_all_data_from_rootitem;

END pkg_export_item_and_element;
/

