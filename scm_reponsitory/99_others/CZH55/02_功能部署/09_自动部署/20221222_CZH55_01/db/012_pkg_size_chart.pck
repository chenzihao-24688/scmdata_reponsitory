CREATE OR REPLACE PACKAGE scmdata.pkg_size_chart IS

  -- Author  : SANFU
  -- Created : 2022/9/23 14:08:00
  -- Purpose : �ߴ��(��Ʒ�����ߴ��)

  --��ѯT_SIZE_CHART_TMP
  FUNCTION f_query_t_size_chart_tmp RETURN CLOB;
  --����T_SIZE_CHART_TMP
  PROCEDURE p_insert_t_size_chart_tmp(p_t_siz_rec t_size_chart_tmp%ROWTYPE);

  --�޸�T_SIZE_CHART_TMP
  PROCEDURE p_update_t_size_chart_tmp(p_t_siz_rec t_size_chart_tmp%ROWTYPE);

  --ɾ���ߴ���ʱ��������
  PROCEDURE p_delete_t_size_chart_tmp(p_size_chart_tmp_id VARCHAR2);
  --ɾ��T_SIZE_CHART_TMP
  PROCEDURE p_delete_t_size_chart_tmp(p_company_id VARCHAR2,
                                      p_goo_id     VARCHAR2);
  --ɾ�� ���гߴ����ʱ����
  PROCEDURE p_delete_t_size_chart_all_tmp_data(p_company_id VARCHAR2,
                                               p_goo_id     VARCHAR2);
  --�ߴ���ʱ��ɾ��У��
  PROCEDURE p_check_size_chart_tmp_by_delete(p_company_id VARCHAR2,
                                             p_goo_id     VARCHAR2);
  --У���Ƿ���ѡ��ģ�����ɵ�����
  PROCEDURE p_check_is_has_size_chart_moudle_data(p_company_id VARCHAR2,
                                                  p_goo_id     VARCHAR2);
  --��ѯ T_SIZE_CHART_DETAILS_TMP
  FUNCTION f_query_t_size_chart_dt_tmp(p_user_id    VARCHAR2,
                                       p_company_id VARCHAR2) RETURN CLOB;
  --���� T_SIZE_CHART_DETAILS_TMP
  PROCEDURE p_insert_t_size_chart_dt_tmp(p_t_siz_rec t_size_chart_details_tmp%ROWTYPE);
  --�޸� T_SIZE_CHART_DETAILS_TMP
  PROCEDURE p_update_t_size_chart_dt_tmp(p_t_siz_rec t_size_chart_details_tmp%ROWTYPE);
  --ɾ���ߴ���ʱ��(������)������
  PROCEDURE p_delete_t_size_chart_dt_tmp(p_company_id          VARCHAR2,
                                         p_goo_id              VARCHAR2,
                                         p_position            VARCHAR2,
                                         p_quantitative_method VARCHAR2);
  --ɾ�� T_SIZE_CHART_DETAILS_TMP
  PROCEDURE p_delete_t_size_chart_dt_tmp(p_company_id VARCHAR2,
                                         p_goo_id     VARCHAR2);

  --�ߴ���ʱ�������룩ɾ��У��
  PROCEDURE p_check_size_chart_dt_tmp_by_delete(p_company_id VARCHAR2,
                                                p_goo_id     VARCHAR2);
  --�ߴ��ģ��У��
  PROCEDURE p_check_size_chart_moudle(p_goo_id     VARCHAR2,
                                      p_company_id VARCHAR2);
  --ѡ��ģ��
  FUNCTION f_get_size_chart_moudle(p_goo_id     VARCHAR2,
                                   p_company_id VARCHAR2) RETURN CLOB;
  --��ȡ�����Ӧ����ҵ�ֵ�ID
  FUNCTION f_get_size_company_dict(p_company_id VARCHAR2,
                                   p_size_name  VARCHAR2) RETURN VARCHAR2;
  --ͨ���������ͻ�ȡ����
  FUNCTION f_get_size_company_dict_by_type(p_company_id VARCHAR2,
                                           p_type       VARCHAR2) RETURN CLOB;
  --���ɳߴ���ʱ��
  PROCEDURE p_generate_size_chart_tmp(p_company_id        VARCHAR2,
                                      p_goo_id            VARCHAR2,
                                      p_user_id           VARCHAR2,
                                      p_size_chart_moudle VARCHAR2);
  --�ύУ��
  PROCEDURE p_check_size_chart_moudle_by_submit(p_goo_id     VARCHAR2,
                                                p_company_id VARCHAR2);
  --У����ʱ�����ֻ��������
  PROCEDURE p_check_size_chart_by_update(p_measure_value VARCHAR2);

  --�ж��Ƿ��Ѵ��ڳߴ����ʱ������
  FUNCTION f_check_is_has_size_chart_tmp_data(p_company_id          VARCHAR2,
                                              p_goo_id              VARCHAR2,
                                              p_position            VARCHAR2,
                                              p_quantitative_method VARCHAR2)
    RETURN INT;

  --����ģ���������򣬼�������������Ӧ�ĳ���ֵ
  FUNCTION f_get_size_by_jump_size_rule(p_company_id        VARCHAR2,
                                        p_size_chart_moudle VARCHAR2,
                                        p_position          VARCHAR2,
                                        p_size_name         VARCHAR2,
                                        p_base_size         NUMBER)
    RETURN NUMBER;

  --�ύʱ������ݻ���+ģ���������򣬼�������������Ӧ�ĳ���ֵ
  PROCEDURE p_generate_size_chart_dt_tmp(p_company_id VARCHAR2,
                                         p_goo_id     VARCHAR2,
                                         p_user_id    VARCHAR2);
  --�ж��Ƿ���ڳߴ��ҵ���
  FUNCTION f_check_is_has_size_chart(p_company_id VARCHAR2,
                                     p_goo_id     VARCHAR2) RETURN INT;
  --�ж��Ƿ��Ѵ��ڳߴ��(ҵ���)����
  FUNCTION f_check_is_has_size_chart_data(p_company_id          VARCHAR2,
                                          p_goo_id              VARCHAR2,
                                          p_position            VARCHAR2,
                                          p_quantitative_method VARCHAR2)
    RETURN INT;
  --��ѯT_SIZE_CHART
  FUNCTION f_query_t_size_chart RETURN CLOB;
  --����T_SIZE_CHART
  PROCEDURE p_insert_t_size_chart(p_t_siz_rec scmdata.t_size_chart%ROWTYPE);
  --�޸�T_SIZE_CHART
  PROCEDURE p_update_t_size_chart(p_t_siz_rec scmdata.t_size_chart%ROWTYPE);
  --ɾ��T_SIZE_CHART
  PROCEDURE p_delete_t_size_chart(p_t_siz_rec scmdata.t_size_chart%ROWTYPE);

  --����T_SIZE_CHART_DETAILS
  PROCEDURE p_insert_t_size_chart_details(p_t_siz_rec scmdata.t_size_chart_details%ROWTYPE);
  --�޸�T_SIZE_CHART_DETAILS
  PROCEDURE p_update_t_size_chart_details(p_t_siz_rec scmdata.t_size_chart_details%ROWTYPE);
  --ɾ��T_SIZE_CHART_DETAILS
  PROCEDURE p_delete_t_size_chart_details(p_t_siz_rec scmdata.t_size_chart_details%ROWTYPE);
  --ɾ���ߴ��ҵ���������
  PROCEDURE p_delete_t_size_chart_row_data(p_company_id          VARCHAR2,
                                           p_goo_id              VARCHAR2,
                                           p_position            VARCHAR2,
                                           p_quantitative_method VARCHAR2);
  --ɾ���ߴ��ҵ�����������
  PROCEDURE p_delete_t_size_chart_all_data(p_company_id VARCHAR2,
                                           p_goo_id     VARCHAR2);
  --�ύУ��������Ƿ�Ϊ��
  PROCEDURE p_check_size_chart_by_submit(p_company_id VARCHAR2,
                                         p_goo_id     VARCHAR2);
  --���ɳߴ��ҵ���
  PROCEDURE p_generate_size_chart(p_company_id VARCHAR2, p_goo_id VARCHAR2);
  --�ߴ�����루ҵ���ɾ��У��
  PROCEDURE p_check_t_size_chart_by_delete(p_company_id VARCHAR2,
                                           p_goo_id     VARCHAR2);
  --��Ʒ�������ɳߴ���ͬ��������ͬ�������浥��
  PROCEDURE p_sync_gd_size_chart_to_apv(p_company_id VARCHAR2,
                                        p_goo_id     VARCHAR2);
  --�ߴ����� �޸ģ�ɾ��У��
  PROCEDURE p_check_t_size_chart_import_tmp_by_update(p_seq_num NUMBER,
                                                      p_type    INT DEFAULT 0);

  --�ߴ絼��� �ύУ��
  PROCEDURE p_check_t_size_chart_import_tmp_by_submit(p_company_id VARCHAR2,
                                                      p_goo_id     VARCHAR2,
                                                      p_type       INT DEFAULT 0);

  --�ж��Ƿ��Ѵ��ڳߴ絼��� ������
  FUNCTION f_check_is_has_size_chart_import_data(p_company_id          VARCHAR2,
                                                 p_goo_id              VARCHAR2,
                                                 p_position            VARCHAR2,
                                                 p_quantitative_method VARCHAR2)
    RETURN INT;

  /*============================================*
  * Author   : CZH
  * Created  : 23-9�� -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ��ѯ t_size_chart_import_tmp
  * Obj_Name    : f_query_t_size_chart_import_tmp
  *============================================*/
  FUNCTION f_query_t_size_chart_import_tmp(p_company_id VARCHAR2,
                                           p_goo_id     VARCHAR2) RETURN CLOB;
  /*============================================*
  * Author   : CZH
  * Created  : 11-10��-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ���� t_size_chart_import_tmp
  * Obj_Name    : p_insert_t_size_chart_import_tmp
  *============================================*/
  PROCEDURE p_insert_t_size_chart_import_tmp(p_t_siz_rec scmdata.t_size_chart_import_tmp%ROWTYPE);

  /*============================================*
  * Author   : CZH
  * Created  : 11-10��-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : �޸� t_size_chart_import_tmp
  * Obj_Name    : p_update_t_size_chart_import_tmp
  *============================================*/
  PROCEDURE p_update_t_size_chart_import_tmp(p_t_siz_rec scmdata.t_size_chart_import_tmp%ROWTYPE);

  /*============================================*
  * Author   : CZH
  * Created  : 11-10��-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ɾ�� t_size_chart_import_tmp
  * Obj_Name    : p_delete_t_size_chart_import_tmp
  *============================================*/
  PROCEDURE p_delete_t_size_chart_import_tmp(p_t_siz_rec scmdata.t_size_chart_import_tmp%ROWTYPE);
  /*============================================*
  * Author   : CZH
  * Created  : 11-10��-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ����t_size_chart_details_import_tmp
  * Obj_Name    : P_INSERT_t_size_chart_details_import_tmp
  *============================================*/
  PROCEDURE p_insert_t_size_chart_details_import_tmp(p_t_siz_rec scmdata.t_size_chart_details_import_tmp%ROWTYPE);

  /*============================================*
  * Author   : CZH
  * Created  : 11-10��-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : �޸�t_size_chart_details_import_tmp
  * Obj_Name    : P_UPDATE_t_size_chart_details_import_tmp
  *============================================*/
  PROCEDURE p_update_t_size_chart_details_import_tmp(p_t_siz_rec scmdata.t_size_chart_details_import_tmp%ROWTYPE);

  /*============================================*
  * Author   : CZH
  * Created  : 11-10��-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ɾ��t_size_chart_details_import_tmp
  * Obj_Name    : P_DELETE_t_size_chart_details_import_tmp
  *============================================*/
  PROCEDURE p_delete_t_size_chart_details_import_tmp(p_t_siz_rec scmdata.t_size_chart_details_import_tmp%ROWTYPE);

  --ɾ���ߴ絼���������
  PROCEDURE p_delete_t_size_chart_import_tmp_row_data(p_company_id          VARCHAR2,
                                                      p_goo_id              VARCHAR2,
                                                      p_position            VARCHAR2,
                                                      p_quantitative_method VARCHAR2);

  --ɾ���ߴ絼��� ��������
  PROCEDURE p_delete_t_size_chart_import_tmp_all_data(p_company_id VARCHAR2,
                                                      p_goo_id     VARCHAR2);
  --ɾ���ߴ絼����ʼ�����ɵ�����
  PROCEDURE p_delete_t_size_chart_import_first_generate_data(p_company_id VARCHAR2,
                                                             p_goo_id     VARCHAR2,
                                                             p_seq_num    INT);
  --������Ʒ����-����� ��ʼ���ߴ絼���
  PROCEDURE p_first_generate_size_chart_imp_tmp_data(p_company_id VARCHAR2,
                                                     p_goo_id     VARCHAR2,
                                                     p_user_id    VARCHAR2);

  --���óߴ絼���
  PROCEDURE p_reset_size_chart_imp_tmp_data(p_company_id VARCHAR2,
                                            p_goo_id     VARCHAR2,
                                            p_user_id    VARCHAR2);

  --��Ʒ�����ߴ���룬���ύ�����������ߴ��ҵ���
  PROCEDURE p_generate_size_chart_by_good_import(p_company_id VARCHAR2,
                                                 p_goo_id     VARCHAR2);
  --����ߴ���룬���ύ�����������ߴ��ҵ���
  PROCEDURE p_generate_size_chart_by_apv_import(p_company_id VARCHAR2,
                                                p_goo_id     VARCHAR2);
  --��ȡ��Ʒ��������ĳ��������
  --��ĸ�룬������
  FUNCTION f_get_good_size_chart_type(p_company_id VARCHAR2,
                                      p_goo_id     VARCHAR2) RETURN VARCHAR2;

  --�ߴ�����ӳ�����
  PROCEDURE p_insert_size_chart_col(p_company_id VARCHAR2,
                                    p_goo_id     VARCHAR2,
                                    p_user_id    VARCHAR2,
                                    p_size_col   VARCHAR2);

  --�Զ����ɳߴ���ر����
  FUNCTION f_get_size_chart_seq_num(p_company_id VARCHAR2,
                                    p_goo_id     VARCHAR2,
                                    p_table      VARCHAR2) RETURN NUMBER;
  --���У��
  PROCEDURE p_check_new_seq_no(p_new_seq_num VARCHAR2);

  --�������
  --����ĳߴ���в����ɾ����ţ�����������
  --5
  --1,2,3,4,5,6,7,8,9,10
  PROCEDURE p_reset_size_chart_seq_num(p_company_id    VARCHAR2,
                                       p_goo_id        VARCHAR2,
                                       p_orgin_seq_num NUMBER, --ԭ���
                                       p_new_seq_num   NUMBER DEFAULT NULL, --1����Ҫ�����λ�� 
                                       p_type          INT,
                                       p_table         VARCHAR2,
                                       p_table_pk_id   VARCHAR2,
                                       p_is_check      INT DEFAULT 0);

  --�жϳߴ���������Ƿ����
  FUNCTION f_is_has_size_chart_row_data(p_company_id          VARCHAR2,
                                        p_goo_id              VARCHAR2,
                                        p_position            VARCHAR2,
                                        p_quantitative_method VARCHAR2,
                                        p_table               VARCHAR2)
    RETURN INT;
  --���ݲ�λ�ж��Ƿ���ڿ���
  PROCEDURE p_is_has_grammage(p_company_id VARCHAR2,
                              p_goo_id     VARCHAR2,
                              p_table      VARCHAR2,
                              p_grammage   VARCHAR2 DEFAULT NULL,
                              p_type       INT DEFAULT 0);
  --���������ж�
  PROCEDURE p_is_has_grammage_row_data(p_company_id          VARCHAR2,
                                       p_goo_id              VARCHAR2,
                                       p_position            VARCHAR2,
                                       p_quantitative_method VARCHAR2,
                                       p_table1              VARCHAR2,
                                       p_table2              VARCHAR2,
                                       p_table1_pk_id        VARCHAR2 DEFAULT 'size_chart_id');

END pkg_size_chart;
/
CREATE OR REPLACE PACKAGE BODY scmdata.pkg_size_chart IS
  /*============================================*
  * Author   : CZH
  * Created  : 23-9�� -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ��ѯT_SIZE_CHART_TMP
  * Obj_Name    : F_QUERY_T_SIZE_CHART_TMP
  *============================================*/
  FUNCTION f_query_t_size_chart_tmp RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := 'SELECT t.size_chart_tmp_id,
       t.company_id,
       t.goo_id,
       LPAD(t.seq_num,2,''0'') seq_num,
       t.position,
       t.quantitative_method,
       t.base_code,
       t.base_value,
       abs(t.plus_toleran_range) plus_toleran_range,
       abs(t.negative_toleran_range) negative_toleran_range
  FROM t_size_chart_tmp t
 WHERE t.goo_id = :goo_id
   AND t.company_id = %default_company_id%
 ORDER BY t.seq_num ASC';
    RETURN v_sql;
  END f_query_t_size_chart_tmp;

  /*============================================*
  * Author   : CZH
  * Created  : 23-9�� -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ����T_SIZE_CHART_TMP
  * Obj_Name    : P_INSERT_T_SIZE_CHART_TMP
  *============================================*/
  PROCEDURE p_insert_t_size_chart_tmp(p_t_siz_rec t_size_chart_tmp%ROWTYPE) IS
  BEGIN
    INSERT INTO t_size_chart_tmp
      (size_chart_tmp_id, company_id, goo_id, seq_num, position,
       quantitative_method, base_code, base_value, plus_toleran_range,
       negative_toleran_range, pause, create_id, create_time, update_id,
       update_time, memo)
    VALUES
      (p_t_siz_rec.size_chart_tmp_id, p_t_siz_rec.company_id,
       p_t_siz_rec.goo_id, p_t_siz_rec.seq_num, p_t_siz_rec.position,
       p_t_siz_rec.quantitative_method, p_t_siz_rec.base_code,
       p_t_siz_rec.base_value, p_t_siz_rec.plus_toleran_range,
       p_t_siz_rec.negative_toleran_range, p_t_siz_rec.pause,
       p_t_siz_rec.create_id, p_t_siz_rec.create_time, p_t_siz_rec.update_id,
       p_t_siz_rec.update_time, p_t_siz_rec.memo);
  END p_insert_t_size_chart_tmp;

  /*============================================*
  * Author   : CZH
  * Created  : 23-9�� -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : �޸�T_SIZE_CHART_TMP
  * Obj_Name    : P_UPDATE_T_SIZE_CHART_TMP
  *============================================*/
  PROCEDURE p_update_t_size_chart_tmp(p_t_siz_rec t_size_chart_tmp%ROWTYPE) IS
  BEGIN
    UPDATE t_size_chart_tmp t
       SET t.seq_num                = p_t_siz_rec.seq_num,
           t.position               = p_t_siz_rec.position,
           t.quantitative_method    = p_t_siz_rec.quantitative_method,
           t.base_code              = p_t_siz_rec.base_code,
           t.base_value             = p_t_siz_rec.base_value,
           t.plus_toleran_range     = p_t_siz_rec.plus_toleran_range,
           t.negative_toleran_range = p_t_siz_rec.negative_toleran_range,
           t.pause                  = p_t_siz_rec.pause,
           t.create_id              = p_t_siz_rec.create_id,
           t.create_time            = p_t_siz_rec.create_time,
           t.update_id              = p_t_siz_rec.update_id,
           t.update_time            = p_t_siz_rec.update_time,
           t.memo                   = p_t_siz_rec.memo
     WHERE t.size_chart_tmp_id = p_t_siz_rec.size_chart_tmp_id;
  END p_update_t_size_chart_tmp;

  --ɾ���ߴ���ʱ��������
  PROCEDURE p_delete_t_size_chart_tmp(p_size_chart_tmp_id VARCHAR2) IS
  BEGIN
    DELETE FROM t_size_chart_tmp t
     WHERE t.size_chart_tmp_id = p_size_chart_tmp_id;
  END p_delete_t_size_chart_tmp;

  /*============================================*
  * Author   : CZH
  * Created  : 23-9�� -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ɾ�� T_SIZE_CHART_DETAILS_TMP
  * Obj_Name    : P_DELETE_T_SIZE_CHART_TMP
  *============================================*/
  PROCEDURE p_delete_t_size_chart_tmp(p_company_id VARCHAR2,
                                      p_goo_id     VARCHAR2) IS
  BEGIN
    DELETE FROM t_size_chart_tmp t
     WHERE t.company_id = p_company_id
       AND t.goo_id = p_goo_id;
  END p_delete_t_size_chart_tmp;

  /*============================================*
  * Author   : CZH
  * Created  : 23-9�� -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ɾ�� ���гߴ����ʱ����
  * Obj_Name    : P_DELETE_T_SIZE_CHART_TMP
  *============================================*/
  PROCEDURE p_delete_t_size_chart_all_tmp_data(p_company_id VARCHAR2,
                                               p_goo_id     VARCHAR2) IS
  BEGIN
  
    DELETE FROM scmdata.t_size_chart_details_tmp a
     WHERE a.size_chart_id IN
           (SELECT t.size_chart_tmp_id
              FROM t_size_chart_tmp t
             WHERE t.company_id = p_company_id
               AND t.goo_id = p_goo_id);
  
    DELETE FROM t_size_chart_tmp t
     WHERE t.company_id = p_company_id
       AND t.goo_id = p_goo_id;
  
  END p_delete_t_size_chart_all_tmp_data;

  --�ߴ���ʱ��ɾ��У��
  PROCEDURE p_check_size_chart_tmp_by_delete(p_company_id VARCHAR2,
                                             p_goo_id     VARCHAR2) IS
    v_cnt INT;
  BEGIN
    SELECT COUNT(1)
      INTO v_cnt
      FROM t_size_chart_tmp t
     WHERE t.company_id = p_company_id
       AND t.goo_id = p_goo_id;
    IF v_cnt <= 1 THEN
      raise_application_error(-20002,
                              '����ɾ���������ݣ����������һ������');
    END IF;
  END p_check_size_chart_tmp_by_delete;

  --У���Ƿ���ѡ��ģ�����ɵ�����
  PROCEDURE p_check_is_has_size_chart_moudle_data(p_company_id VARCHAR2,
                                                  p_goo_id     VARCHAR2) IS
    v_flag INT;
  BEGIN
    SELECT COUNT(1)
      INTO v_flag
      FROM t_size_chart_tmp t
     WHERE t.company_id = p_company_id
       AND t.goo_id = p_goo_id;
    IF v_flag > 0 THEN
      NULL;
    ELSE
      raise_application_error(-20002, '��������������ѡ��ģ��');
    END IF;
  END p_check_is_has_size_chart_moudle_data;

  /*============================================*
  * Author   : CZH
  * Created  : 23-9�� -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ��ѯ T_SIZE_CHART_DETAILS_TMP
  * Obj_Name    : F_QUERY_T_SIZE_CHART_DT_TMP
  *============================================*/
  FUNCTION f_query_t_size_chart_dt_tmp(p_user_id    VARCHAR2,
                                       p_company_id VARCHAR2) RETURN CLOB IS
    v_sql    CLOB;
    v_goo_id VARCHAR2(32);
  BEGIN
    v_goo_id := scmdata.pkg_variable.f_get_varchar(v_objid   => p_user_id,
                                                   v_compid  => p_company_id,
                                                   v_varname => 'SIZE_CHART_GOO_ID');
  
    v_sql := 'SELECT t.size_chart_dt_tmp_id,
       a.size_chart_tmp_id,
       a.company_id,
       a.goo_id,
       LPAD(a.seq_num,2,''0'') seq_num,
       a.position,
       a.quantitative_method,
       a.base_code,
       a.base_value,
       abs(a.plus_toleran_range) plus_toleran_range,
       abs(a.negative_toleran_range) negative_toleran_range,
       b.company_dict_name measure,
       t.measure_value
  FROM scmdata.t_size_chart_tmp a
  INNER JOIN t_size_chart_details_tmp t
    ON t.size_chart_id = a.size_chart_tmp_id
  INNER JOIN scmdata.sys_company_dict b
    ON b.company_dict_id = t.measure
 WHERE a.goo_id = ''' || v_goo_id || '''
   AND a.company_id = ''' || p_company_id || '''
 ORDER BY a.seq_num ASC, b.company_dict_sort  ASC';
    RETURN v_sql;
  END f_query_t_size_chart_dt_tmp;

  /*============================================*
  * Author   : CZH
  * Created  : 23-9�� -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ���� T_SIZE_CHART_DETAILS_TMP
  * Obj_Name    : P_INSERT_T_SIZE_CHART_DT_TMP
  *============================================*/
  PROCEDURE p_insert_t_size_chart_dt_tmp(p_t_siz_rec t_size_chart_details_tmp%ROWTYPE) IS
  BEGIN
    INSERT INTO t_size_chart_details_tmp
      (size_chart_dt_tmp_id, size_chart_id, measure, measure_value, pause,
       create_id, create_time, update_id, update_time, memo)
    VALUES
      (p_t_siz_rec.size_chart_dt_tmp_id, p_t_siz_rec.size_chart_id,
       p_t_siz_rec.measure, p_t_siz_rec.measure_value, p_t_siz_rec.pause,
       p_t_siz_rec.create_id, p_t_siz_rec.create_time, p_t_siz_rec.update_id,
       p_t_siz_rec.update_time, p_t_siz_rec.memo);
  END p_insert_t_size_chart_dt_tmp;
  /*============================================*
  * Author   : CZH
  * Created  : 23-9�� -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  :  �޸� T_SIZE_CHART_DETAILS_TMP
  * Obj_Name    : P_UPDATE_T_SIZE_CHART_DT_TMP
  *============================================*/
  PROCEDURE p_update_t_size_chart_dt_tmp(p_t_siz_rec t_size_chart_details_tmp%ROWTYPE) IS
  BEGIN
    UPDATE t_size_chart_details_tmp t
       SET t.measure_value = p_t_siz_rec.measure_value,
           t.pause         = p_t_siz_rec.pause,
           t.create_id     = p_t_siz_rec.create_id,
           t.create_time   = p_t_siz_rec.create_time,
           t.update_id     = p_t_siz_rec.update_id,
           t.update_time   = p_t_siz_rec.update_time,
           t.memo          = p_t_siz_rec.memo
     WHERE t.size_chart_id = p_t_siz_rec.size_chart_id
       AND t.measure = p_t_siz_rec.measure;
  END p_update_t_size_chart_dt_tmp;

  --ɾ���ߴ���ʱ��(������)������
  PROCEDURE p_delete_t_size_chart_dt_tmp(p_company_id          VARCHAR2,
                                         p_goo_id              VARCHAR2,
                                         p_position            VARCHAR2,
                                         p_quantitative_method VARCHAR2) IS
  BEGIN
    --ɾ��У��
    p_check_size_chart_dt_tmp_by_delete(p_company_id => p_company_id,
                                        p_goo_id     => p_goo_id);
  
    DELETE FROM t_size_chart_details_tmp a
     WHERE a.size_chart_id IN
           (SELECT t.size_chart_tmp_id
              FROM scmdata.t_size_chart_tmp t
             WHERE t.company_id = p_company_id
               AND p_goo_id = t.goo_id
               AND t.position = p_position
               AND t.quantitative_method = p_quantitative_method);
  
    DELETE FROM scmdata.t_size_chart_tmp t
     WHERE t.company_id = p_company_id
       AND p_goo_id = t.goo_id
       AND t.position = p_position
       AND t.quantitative_method = p_quantitative_method;
  END p_delete_t_size_chart_dt_tmp;

  /*============================================*
  * Author   : CZH
  * Created  : 23-9�� -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ɾ�� T_SIZE_CHART_DETAILS_TMP
  * Obj_Name    : P_DELETE_T_SIZE_CHART_TMP
  *============================================*/
  PROCEDURE p_delete_t_size_chart_dt_tmp(p_company_id VARCHAR2,
                                         p_goo_id     VARCHAR2) IS
  BEGIN
    DELETE FROM scmdata.t_size_chart_details_tmp a
     WHERE a.size_chart_id IN
           (SELECT t.size_chart_tmp_id
              FROM t_size_chart_tmp t
             WHERE t.company_id = p_company_id
               AND t.goo_id = p_goo_id);
  END p_delete_t_size_chart_dt_tmp;

  --�ߴ���ʱ�������룩ɾ��У��
  PROCEDURE p_check_size_chart_dt_tmp_by_delete(p_company_id VARCHAR2,
                                                p_goo_id     VARCHAR2) IS
    v_cnt INT;
  BEGIN
    NULL;
    SELECT COUNT(DISTINCT a.seq_num)
      INTO v_cnt
      FROM t_size_chart_tmp a
     INNER JOIN t_size_chart_details_tmp b
        ON b.size_chart_id = a.size_chart_tmp_id
     WHERE a.company_id = p_company_id
       AND a.goo_id = p_goo_id;
    IF v_cnt <= 1 THEN
      raise_application_error(-20002,
                              '����ɾ���������ݣ����������һ������');
    END IF;
  END p_check_size_chart_dt_tmp_by_delete;

  --�ߴ��ģ��У��
  PROCEDURE p_check_size_chart_moudle(p_goo_id     VARCHAR2,
                                      p_company_id VARCHAR2) IS
    v_cate  VARCHAR2(32);
    v_pcate VARCHAR2(32);
    v_scate VARCHAR2(32);
    v_flag  NUMBER;
  BEGIN
    /*    ����У�飺   
    1.�����ڴ�����ҳ��ѡ�е������У���ȡ���Ŷ�Ӧ�ķ���+�������+��Ʒ���ࣩ�����[ѡ��ģ��]��ťʱ��ҪУ��ߴ���������Ƿ���ڸ÷���+�������+��Ʒ����ĳߴ�����ã���״̬=�����á���    
      1.1�������Ӧ�ķ���+�������+��Ʒ����δ���óߴ�ģ��ʱ��������ʾ��Ϣ���û��Ŷ�Ӧ�Ĳ�Ʒ������δ���óߴ��ģ�壬�������ã�    
      1.2�������Ӧ�ķ���+�������+��Ʒ���������óߴ�ģ��ʱ���򵯴���ʾ�ߴ��ģ��ѡ�񣨾����߼���������ͼ2-1 ˵������       
    2.�����Ӧ�ķ���+�������+��Ʒ���������ɳߴ�����[���ɳߴ��ģ��]ʱ��ѡ��ߴ��ģ��󣬸���ԭ���ĳߴ�����ݣ������߼���������ͼ2-1 ˵������*/
    SELECT MAX(tc.category), MAX(tc.product_cate), MAX(tc.samll_category)
      INTO v_cate, v_pcate, v_scate
      FROM scmdata.t_commodity_info tc
     WHERE tc.goo_id = p_goo_id
       AND tc.company_id = p_company_id;
  
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_size_chart_config t
     WHERE t.category = v_cate
       AND t.product_cate = v_pcate
       AND instr(t.subcategory, v_scate) > 0
       AND t.pause = 0
       AND t.wether_del = 0
       AND t.usable = 1;
  
    IF v_flag > 0 THEN
      NULL;
    ELSE
      raise_application_error(-20002,
                              '�û��Ŷ�Ӧ�Ĳ�Ʒ������δ���óߴ��ģ�壬��������');
    END IF;
  END p_check_size_chart_moudle;
  --ѡ��ģ��
  FUNCTION f_get_size_chart_moudle(p_goo_id     VARCHAR2,
                                   p_company_id VARCHAR2) RETURN CLOB IS
    v_sql   CLOB;
    v_cate  VARCHAR2(32);
    v_pcate VARCHAR2(32);
    v_scate VARCHAR2(32);
  BEGIN
    --ѡ��ģ�壬��ɾ��ԭ��ʱ������
    /*p_delete_t_size_chart_tmp(p_company_id => p_company_id,
    p_goo_id     => p_goo_id);*/
  
    --��ѯģ��
    SELECT MAX(tc.category), MAX(tc.product_cate), MAX(tc.samll_category)
      INTO v_cate, v_pcate, v_scate
      FROM scmdata.t_commodity_info tc
     WHERE tc.goo_id = p_goo_id
       AND tc.company_id = p_company_id;
  
    v_sql := 'SELECT t.size_chart_config_id   size_chart_config_code,
           t.size_chart_config_name size_chart_config_value
      FROM scmdata.t_size_chart_config t
     WHERE t.category = ''' || v_cate || '''
       AND t.product_cate = ''' || v_pcate || '''
       AND instr(t.subcategory, ''' || v_scate ||
             ''') > 0
       AND t.pause = 0
       AND t.wether_del = 0
       AND t.usable = 1';
    RETURN v_sql;
  END f_get_size_chart_moudle;

  --��ȡ�����Ӧ����ҵ�ֵ�ID
  FUNCTION f_get_size_company_dict(p_company_id VARCHAR2,
                                   p_size_name  VARCHAR2) RETURN VARCHAR2 IS
    v_company_dict_id VARCHAR2(32);
  BEGIN
    SELECT MAX(t.company_dict_id)
      INTO v_company_dict_id
      FROM scmdata.sys_company_dict t
     WHERE t.company_dict_type IN ('SL_GDV', 'SL_GDN')
       AND t.company_id = p_company_id
       AND t.extend_01 = 'SIZE_CHART'
       AND t.company_dict_name = p_size_name;
    RETURN v_company_dict_id;
  END f_get_size_company_dict;

  --ͨ���������ͻ�ȡ����
  FUNCTION f_get_size_company_dict_by_type(p_company_id VARCHAR2,
                                           p_type       VARCHAR2) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[SELECT t.company_dict_id measure_id,t.company_dict_name  measure
      FROM scmdata.sys_company_dict t
     WHERE t.company_dict_type = ']' || p_type || q'['
       AND t.company_id = ']' || p_company_id || q'['
       AND t.extend_01 = 'SIZE_CHART']';
    RETURN v_sql;
  END f_get_size_company_dict_by_type;

  --����ѡ��ģ�� ���ɳߴ���ʱ��
  PROCEDURE p_generate_size_chart_tmp(p_company_id        VARCHAR2,
                                      p_goo_id            VARCHAR2,
                                      p_user_id           VARCHAR2,
                                      p_size_chart_moudle VARCHAR2) IS
    p_size_chart_tmp      scmdata.t_size_chart_tmp%ROWTYPE;
    v_size_chart_word_rec scmdata.t_size_chart_config_word_detail%ROWTYPE;
    v_size_chart_num_rec  scmdata.t_size_chart_config_word_detail%ROWTYPE;
    v_base_size_type      VARCHAR2(32);
    v_base_code           VARCHAR2(32);
  BEGIN
    --ѡ��ģ�壬��ɾ��ԭ��ʱ������
    p_delete_t_size_chart_tmp(p_company_id => p_company_id,
                              p_goo_id     => p_goo_id);
  
    SELECT MAX(t.base_size_type), MAX(t.base_size_value)
      INTO v_base_size_type, v_base_code
      FROM scmdata.t_size_chart_config t
     WHERE t.size_chart_config_id = p_size_chart_moudle
       AND t.company_id = p_company_id;
    --��ĸ
    IF v_base_size_type = 'SL_GDV' THEN
      FOR v_size_chart_word_rec IN (SELECT *
                                      FROM scmdata.t_size_chart_config_word_detail tw
                                     WHERE tw.size_chart_config_id =
                                           p_size_chart_moudle
                                       AND tw.company_id = p_company_id) LOOP
        p_size_chart_tmp.size_chart_tmp_id      := scmdata.f_get_uuid();
        p_size_chart_tmp.company_id             := p_company_id;
        p_size_chart_tmp.goo_id                 := p_goo_id;
        p_size_chart_tmp.seq_num                := v_size_chart_word_rec.seq_no;
        p_size_chart_tmp.position               := v_size_chart_word_rec.position;
        p_size_chart_tmp.quantitative_method    := v_size_chart_word_rec.method;
        p_size_chart_tmp.base_code              := v_base_code;
        p_size_chart_tmp.base_value             := 0;
        p_size_chart_tmp.plus_toleran_range     := v_size_chart_word_rec.tolerance_plus;
        p_size_chart_tmp.negative_toleran_range := v_size_chart_word_rec.tolerance_minus;
        p_size_chart_tmp.pause                  := 0;
        p_size_chart_tmp.create_id              := p_user_id;
        p_size_chart_tmp.create_time            := SYSDATE;
        p_size_chart_tmp.update_id              := p_user_id;
        p_size_chart_tmp.update_time            := SYSDATE;
        p_size_chart_tmp.memo                   := NULL;
      
        p_insert_t_size_chart_tmp(p_t_siz_rec => p_size_chart_tmp);
      END LOOP;
      --����
    ELSIF v_base_size_type = 'SL_GDN' THEN
      FOR v_size_chart_num_rec IN (SELECT *
                                     FROM scmdata.t_size_chart_config_num_detail tn
                                    WHERE tn.size_chart_config_id =
                                          p_size_chart_moudle
                                      AND tn.company_id = p_company_id) LOOP
      
        p_size_chart_tmp.size_chart_tmp_id      := scmdata.f_get_uuid();
        p_size_chart_tmp.company_id             := p_company_id;
        p_size_chart_tmp.goo_id                 := p_goo_id;
        p_size_chart_tmp.seq_num                := v_size_chart_num_rec.seq_no;
        p_size_chart_tmp.position               := v_size_chart_num_rec.position;
        p_size_chart_tmp.quantitative_method    := v_size_chart_num_rec.method;
        p_size_chart_tmp.base_code              := v_base_code;
        p_size_chart_tmp.base_value             := 0;
        p_size_chart_tmp.plus_toleran_range     := v_size_chart_num_rec.tolerance_plus;
        p_size_chart_tmp.negative_toleran_range := v_size_chart_num_rec.tolerance_minus;
        p_size_chart_tmp.pause                  := 0;
        p_size_chart_tmp.create_id              := p_user_id;
        p_size_chart_tmp.create_time            := SYSDATE;
        p_size_chart_tmp.update_id              := p_user_id;
        p_size_chart_tmp.update_time            := SYSDATE;
        p_size_chart_tmp.memo                   := NULL;
        p_insert_t_size_chart_tmp(p_t_siz_rec => p_size_chart_tmp);
      END LOOP;
    ELSE
      NULL;
    END IF;
  END p_generate_size_chart_tmp;

  --ѡ��ģ���
  --�ύУ��
  PROCEDURE p_check_size_chart_moudle_by_submit(p_goo_id     VARCHAR2,
                                                p_company_id VARCHAR2) IS
    v_flag INT;
  BEGIN
    FOR i IN (SELECT t.base_value
                FROM scmdata.t_size_chart_tmp t
               WHERE t.goo_id = p_goo_id
                 AND t.company_id = p_company_id) LOOP
      IF i.base_value IS NULL OR i.base_value = 0 THEN
        raise_application_error(-20002,
                                '��ǰ�ߴ����ڻ���δ����������ݺ����ύ');
      ELSE
        NULL;
      END IF;
    END LOOP;
  
    SELECT COUNT(1)
      INTO v_flag
      FROM (SELECT DISTINCT t.sizename, t.goo_id, t.company_id, t.sizecode
              FROM scmdata.t_commodity_color_size t
             WHERE t.goo_id = p_goo_id
               AND t.company_id = p_company_id) v
     WHERE v.sizename IN (SELECT DISTINCT a.base_code
                            FROM scmdata.t_size_chart_tmp a
                           WHERE a.goo_id = p_goo_id
                             AND a.company_id = p_company_id);
    IF v_flag = 0 THEN
      raise_application_error(-20002, '�����еĳ���û�и�ģ�������еĻ���');
    END IF;
  END p_check_size_chart_moudle_by_submit;

  --����ģ���������򣬼�������������Ӧ�ĳ���ֵ
  FUNCTION f_get_size_by_jump_size_rule(p_company_id        VARCHAR2,
                                        p_size_chart_moudle VARCHAR2,
                                        p_position          VARCHAR2,
                                        p_size_name         VARCHAR2,
                                        p_base_size         NUMBER)
    RETURN NUMBER IS
    v_size            NUMBER;
    v_base_size_type  VARCHAR2(32);
    v_jump_size_value NUMBER;
  BEGIN
    SELECT MAX(t.base_size_type)
      INTO v_base_size_type
      FROM scmdata.t_size_chart_config t
     WHERE t.size_chart_config_id = p_size_chart_moudle
       AND t.company_id = p_company_id;
    --��ĸ
    IF v_base_size_type = 'SL_GDV' THEN
      SELECT MAX(v.jump_size_value)
        INTO v_jump_size_value
        FROM (SELECT size_chart_config_word_detail_id,
                     size_chart_config_id,
                     position,
                     size_name,
                     jump_size_value
                FROM (SELECT t.size_chart_config_word_detail_id,
                             t.size_chart_config_id,
                             t.position,
                             t.xs,
                             t.s,
                             t.m,
                             t.l,
                             t.xl,
                             t.xxl,
                             t.xxxl,
                             t.xxxxl
                        FROM scmdata.t_size_chart_config_word_detail t
                       WHERE t.size_chart_config_id = p_size_chart_moudle) unpivot((jump_size_value) FOR size_name IN(xs,
                                                                                                                      s,
                                                                                                                      m,
                                                                                                                      l,
                                                                                                                      xl,
                                                                                                                      xxl,
                                                                                                                      xxxl,
                                                                                                                      xxxxl))) v
       WHERE v.size_name = p_size_name
         AND v.position = p_position;
      --����
    ELSIF v_base_size_type = 'SL_GDN' THEN
      SELECT MAX(v.jump_size_value)
        INTO v_jump_size_value
        FROM (SELECT size_chart_config_num_detail_id,
                     size_chart_config_id,
                     position,
                     scmdata.pkg_plat_comm.f_get_val_by_delimit(p_character => size_name,
                                                                p_separate  => '_',
                                                                p_is_pre    => 0) size_name,
                     jump_size_value
                FROM (SELECT t.size_chart_config_num_detail_id,
                             t.size_chart_config_id,
                             t.position,
                             t.num_27,
                             t.num_28,
                             t.num_29,
                             t.num_30,
                             t.num_31,
                             t.num_32,
                             t.num_33,
                             t.num_34,
                             t.num_35,
                             t.num_36,
                             t.num_37,
                             t.num_38
                        FROM scmdata.t_size_chart_config_num_detail t
                       WHERE t.size_chart_config_id = p_size_chart_moudle) unpivot((jump_size_value) FOR size_name IN(num_27,
                                                                                                                      num_28,
                                                                                                                      num_29,
                                                                                                                      num_30,
                                                                                                                      num_31,
                                                                                                                      num_32,
                                                                                                                      num_33,
                                                                                                                      num_34,
                                                                                                                      num_35,
                                                                                                                      num_36,
                                                                                                                      num_37,
                                                                                                                      num_38))) v
       WHERE v.size_name = p_size_name
         AND v.position = p_position;
    ELSE
      NULL;
    END IF;
    --���ݻ���+������򣬻�ȡ��Ӧ����ֵ
    IF v_jump_size_value IS NULL THEN
      v_size := NULL;
    ELSE
      v_size := p_base_size + v_jump_size_value;
    END IF;
    RETURN v_size;
  END f_get_size_by_jump_size_rule;

  --У����ʱ�����ֻ��������
  PROCEDURE p_check_size_chart_by_update(p_measure_value VARCHAR2) IS
    v_flag INT;
  BEGIN
    IF p_measure_value IS NULL THEN
      raise_application_error(-20002, '���벻��Ϊ�գ�����');
    ELSE
      IF p_measure_value = '0' THEN
        raise_application_error(-20002, '���벻��Ϊ0������');
      END IF;
      SELECT COUNT(1)
        INTO v_flag
        FROM (SELECT 1
                FROM dual
               WHERE regexp_like(p_measure_value,
                                 '^(0|[1-9]\d{0,9})(\.\d{1,4})?$'));
      IF v_flag > 0 THEN
        NULL;
      ELSE
        raise_application_error(-20002, '�����֧�������֣�����');
      END IF;
    END IF;
  END p_check_size_chart_by_update;

  --�ж��Ƿ��Ѵ��ڳߴ��(��ʱ��)����
  FUNCTION f_check_is_has_size_chart_tmp_data(p_company_id          VARCHAR2,
                                              p_goo_id              VARCHAR2,
                                              p_position            VARCHAR2,
                                              p_quantitative_method VARCHAR2)
    RETURN INT IS
    v_flag INT;
  BEGIN
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_size_chart_tmp t
     WHERE t.company_id = p_company_id
       AND t.goo_id = p_goo_id
       AND t.position = p_position
       AND t.quantitative_method = p_quantitative_method;
    RETURN v_flag;
  END f_check_is_has_size_chart_tmp_data;

  --�ߴ��ģ�壬�ύ���ɳߴ���ʱ��
  PROCEDURE p_generate_size_chart_dt_tmp(p_company_id VARCHAR2,
                                         p_goo_id     VARCHAR2,
                                         p_user_id    VARCHAR2) IS
    p_size_chart_dt_tmp scmdata.t_size_chart_details_tmp%ROWTYPE;
    v_measure_value     NUMBER;
    v_size_chart_moudle VARCHAR2(32);
    v_sizename          VARCHAR2(32);
  BEGIN
    --�ύУ��
    p_check_size_chart_moudle_by_submit(p_goo_id     => p_goo_id,
                                        p_company_id => p_company_id);
    --ɾ�������ɵĳߴ��
    p_delete_t_size_chart_dt_tmp(p_goo_id     => p_goo_id,
                                 p_company_id => p_company_id);
    --�ύʱЯ�����������ɳߴ��ҳ��
    scmdata.pkg_variable.p_ins_or_upd_variable(v_objid   => p_user_id,
                                               v_compid  => p_company_id,
                                               v_varname => 'SIZE_CHART_GOO_ID',
                                               v_vartype => 'VARCHAR',
                                               v_varchar => p_goo_id);
  
    v_size_chart_moudle := scmdata.pkg_variable.f_get_varchar(v_objid   => p_user_id,
                                                              v_compid  => p_company_id,
                                                              v_varname => 'SIZE_CHART_MOUDLE');
  
    --�ߴ��ģ��
    FOR size_chart_rec IN (SELECT ts.*
                             FROM scmdata.t_size_chart_tmp ts
                            WHERE ts.goo_id = p_goo_id
                              AND ts.company_id = p_company_id) LOOP
      --��ȡ����  ����Ʒ����-�ӱ�-ɫ���-�����л�ȡ�����ݻ��Ŷ�̬չʾ
      FOR size_chart_dt_rec IN (SELECT DISTINCT t.sizename,
                                                t.goo_id,
                                                t.company_id,
                                                t.sizecode
                                  FROM scmdata.t_commodity_color_size t
                                 WHERE t.goo_id = p_goo_id
                                   AND t.company_id = p_company_id
                                 ORDER BY t.sizecode ASC) LOOP
      
        p_size_chart_dt_tmp.size_chart_dt_tmp_id := scmdata.f_get_uuid();
        p_size_chart_dt_tmp.size_chart_id        := size_chart_rec.size_chart_tmp_id;
      
        v_sizename := f_get_size_company_dict(p_company_id => p_company_id,
                                              p_size_name  => size_chart_dt_rec.sizename);
      
        p_size_chart_dt_tmp.measure := v_sizename; --������ҵ�ֵ�ID
        --�����������������ֵ��������д�Ļ���+ѡ��ĳߴ��ģ���Ӧ����������Զ�����;
        --ģ����û�����ö�Ӧ��������������óߴ����ֶ�¼�룻
        --����
        IF size_chart_dt_rec.sizename = size_chart_rec.base_code THEN
          v_measure_value := size_chart_rec.base_value;
        ELSE
          v_measure_value := f_get_size_by_jump_size_rule(p_company_id        => p_company_id,
                                                          p_size_chart_moudle => v_size_chart_moudle,
                                                          p_position          => size_chart_rec.position,
                                                          p_size_name         => size_chart_dt_rec.sizename,
                                                          p_base_size         => size_chart_rec.base_value);
        END IF;
        p_size_chart_dt_tmp.measure_value := v_measure_value;
        p_size_chart_dt_tmp.pause         := 0;
        p_size_chart_dt_tmp.create_id     := p_user_id;
        p_size_chart_dt_tmp.create_time   := SYSDATE;
        p_size_chart_dt_tmp.update_id     := p_user_id;
        p_size_chart_dt_tmp.update_time   := SYSDATE;
        p_size_chart_dt_tmp.memo          := NULL;
        p_insert_t_size_chart_dt_tmp(p_t_siz_rec => p_size_chart_dt_tmp);
      END LOOP;
    END LOOP;
  END p_generate_size_chart_dt_tmp;

  --�ж��Ƿ���ڳߴ��ҵ���
  FUNCTION f_check_is_has_size_chart(p_company_id VARCHAR2,
                                     p_goo_id     VARCHAR2) RETURN INT IS
    v_flag INT;
  BEGIN
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_size_chart t
     WHERE t.company_id = p_company_id
       AND t.goo_id = p_goo_id;
    RETURN v_flag;
  END f_check_is_has_size_chart;

  --�ж��Ƿ��Ѵ��ڳߴ��(ҵ���)������
  FUNCTION f_check_is_has_size_chart_data(p_company_id          VARCHAR2,
                                          p_goo_id              VARCHAR2,
                                          p_position            VARCHAR2,
                                          p_quantitative_method VARCHAR2)
    RETURN INT IS
    v_flag INT;
  BEGIN
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_size_chart t
     WHERE t.company_id = p_company_id
       AND t.goo_id = p_goo_id
       AND t.position = p_position
       AND t.quantitative_method = p_quantitative_method;
    RETURN v_flag;
  END f_check_is_has_size_chart_data;

  /*============================================*
  * Author   : CZH
  * Created  : 23-9�� -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ��ѯT_SIZE_CHART
  * Obj_Name    : F_QUERY_T_SIZE_CHART_TMP
  *============================================*/
  FUNCTION f_query_t_size_chart RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := 'SELECT a.size_chart_id,
       a.company_id,
       a.goo_id,
       LPAD(a.seq_num,2,''0'') seq_num,
       a.position,
       a.quantitative_method,
       a.base_code,
       a.base_value,
       abs(a.plus_toleran_range) plus_toleran_range,
       abs(a.negative_toleran_range) negative_toleran_range,
       c.company_dict_name measure,
       b.measure_value
  FROM scmdata.t_size_chart a
 INNER JOIN scmdata.t_size_chart_details b
    ON b.size_chart_id = a.size_chart_id
 INNER JOIN scmdata.sys_company_dict c
    ON c.company_dict_id = b.measure
 WHERE a.goo_id = :goo_id
   AND a.company_id = %default_company_id%
 ORDER BY a.seq_num ASC, c.company_dict_sort ASC';
    RETURN v_sql;
  END f_query_t_size_chart;
  /*============================================*
  * Author   : CZH
  * Created  : 11-10��-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ����T_SIZE_CHART
  * Obj_Name    : P_INSERT_T_SIZE_CHART
  *============================================*/
  PROCEDURE p_insert_t_size_chart(p_t_siz_rec scmdata.t_size_chart%ROWTYPE) IS
  BEGIN
    INSERT INTO t_size_chart
      (size_chart_id, company_id, goo_id, seq_num, position,
       quantitative_method, base_code, base_value, plus_toleran_range,
       negative_toleran_range, pause, create_id, create_time, update_id,
       update_time, memo)
    VALUES
      (p_t_siz_rec.size_chart_id, p_t_siz_rec.company_id,
       p_t_siz_rec.goo_id, p_t_siz_rec.seq_num, p_t_siz_rec.position,
       p_t_siz_rec.quantitative_method, p_t_siz_rec.base_code,
       p_t_siz_rec.base_value, p_t_siz_rec.plus_toleran_range,
       p_t_siz_rec.negative_toleran_range, p_t_siz_rec.pause,
       p_t_siz_rec.create_id, p_t_siz_rec.create_time, p_t_siz_rec.update_id,
       p_t_siz_rec.update_time, p_t_siz_rec.memo);
  END p_insert_t_size_chart;

  /*============================================*
  * Author   : CZH
  * Created  : 11-10��-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : �޸�T_SIZE_CHART
  * Obj_Name    : P_UPDATE_T_SIZE_CHART
  *============================================*/
  PROCEDURE p_update_t_size_chart(p_t_siz_rec scmdata.t_size_chart%ROWTYPE) IS
  BEGIN
    UPDATE t_size_chart t
       SET t.seq_num                = p_t_siz_rec.seq_num,
           t.position               = p_t_siz_rec.position,
           t.quantitative_method    = p_t_siz_rec.quantitative_method,
           t.base_code              = p_t_siz_rec.base_code,
           t.base_value             = p_t_siz_rec.base_value,
           t.plus_toleran_range     = p_t_siz_rec.plus_toleran_range,
           t.negative_toleran_range = p_t_siz_rec.negative_toleran_range,
           t.pause                  = p_t_siz_rec.pause,
           t.create_id              = p_t_siz_rec.create_id,
           t.create_time            = p_t_siz_rec.create_time,
           t.update_id              = p_t_siz_rec.update_id,
           t.update_time            = p_t_siz_rec.update_time,
           t.memo                   = p_t_siz_rec.memo
     WHERE t.size_chart_id = p_t_siz_rec.size_chart_id;
  END p_update_t_size_chart;

  /*============================================*
  * Author   : CZH
  * Created  : 11-10��-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ɾ��T_SIZE_CHART
  * Obj_Name    : P_DELETE_T_SIZE_CHART
  *============================================*/
  PROCEDURE p_delete_t_size_chart(p_t_siz_rec scmdata.t_size_chart%ROWTYPE) IS
  BEGIN
    DELETE FROM t_size_chart t
     WHERE t.size_chart_id = p_t_siz_rec.size_chart_id;
  END p_delete_t_size_chart;
  /*============================================*
  * Author   : CZH
  * Created  : 11-10��-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ����T_SIZE_CHART_DETAILS
  * Obj_Name    : P_INSERT_T_SIZE_CHART_DETAILS
  *============================================*/
  PROCEDURE p_insert_t_size_chart_details(p_t_siz_rec scmdata.t_size_chart_details%ROWTYPE) IS
  BEGIN
    INSERT INTO t_size_chart_details
      (size_chart_dt_id, size_chart_id, measure, measure_value, pause,
       create_id, create_time, update_id, update_time, memo)
    VALUES
      (p_t_siz_rec.size_chart_dt_id, p_t_siz_rec.size_chart_id,
       p_t_siz_rec.measure, p_t_siz_rec.measure_value, p_t_siz_rec.pause,
       p_t_siz_rec.create_id, p_t_siz_rec.create_time, p_t_siz_rec.update_id,
       p_t_siz_rec.update_time, p_t_siz_rec.memo);
  END p_insert_t_size_chart_details;

  /*============================================*
  * Author   : CZH
  * Created  : 11-10��-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : �޸�T_SIZE_CHART_DETAILS
  * Obj_Name    : P_UPDATE_T_SIZE_CHART_DETAILS
  *============================================*/
  PROCEDURE p_update_t_size_chart_details(p_t_siz_rec scmdata.t_size_chart_details%ROWTYPE) IS
  BEGIN
    UPDATE t_size_chart_details t
       SET t.measure_value = p_t_siz_rec.measure_value,
           t.pause         = p_t_siz_rec.pause,
           t.create_id     = p_t_siz_rec.create_id,
           t.create_time   = p_t_siz_rec.create_time,
           t.update_id     = p_t_siz_rec.update_id,
           t.update_time   = p_t_siz_rec.update_time,
           t.memo          = p_t_siz_rec.memo
     WHERE t.size_chart_id = p_t_siz_rec.size_chart_id
       AND t.measure = p_t_siz_rec.measure;
  END p_update_t_size_chart_details;

  /*============================================*
  * Author   : CZH
  * Created  : 11-10��-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ɾ��T_SIZE_CHART_DETAILS
  * Obj_Name    : P_DELETE_T_SIZE_CHART_DETAILS
  *============================================*/
  PROCEDURE p_delete_t_size_chart_details(p_t_siz_rec scmdata.t_size_chart_details%ROWTYPE) IS
  BEGIN
    DELETE FROM t_size_chart_details t
     WHERE t.size_chart_dt_id = p_t_siz_rec.size_chart_dt_id;
  END p_delete_t_size_chart_details;

  --ɾ���ߴ��ҵ���������
  PROCEDURE p_delete_t_size_chart_row_data(p_company_id          VARCHAR2,
                                           p_goo_id              VARCHAR2,
                                           p_position            VARCHAR2,
                                           p_quantitative_method VARCHAR2) IS
  BEGIN
    --ɾ��У��
    p_check_t_size_chart_by_delete(p_company_id => p_company_id,
                                   p_goo_id     => p_goo_id);
  
    DELETE FROM t_size_chart_details a
     WHERE a.size_chart_id IN
           (SELECT t.size_chart_id
              FROM scmdata.t_size_chart t
             WHERE t.company_id = p_company_id
               AND t.goo_id = p_goo_id
               AND t.position = p_position
               AND t.quantitative_method = p_quantitative_method);
  
    DELETE FROM scmdata.t_size_chart t
     WHERE t.company_id = p_company_id
       AND p_goo_id = t.goo_id
       AND t.position = p_position
       AND t.quantitative_method = p_quantitative_method;
  END p_delete_t_size_chart_row_data;

  --ɾ���ߴ��ҵ�����������
  PROCEDURE p_delete_t_size_chart_all_data(p_company_id VARCHAR2,
                                           p_goo_id     VARCHAR2) IS
  BEGIN
    DELETE FROM t_size_chart_details a
     WHERE a.size_chart_id IN
           (SELECT t.size_chart_id
              FROM scmdata.t_size_chart t
             WHERE t.company_id = p_company_id
               AND p_goo_id = t.goo_id);
  
    DELETE FROM scmdata.t_size_chart t
     WHERE t.company_id = p_company_id
       AND p_goo_id = t.goo_id;
  END p_delete_t_size_chart_all_data;

  --�ύУ��������Ƿ�Ϊ��
  PROCEDURE p_check_size_chart_by_submit(p_company_id VARCHAR2,
                                         p_goo_id     VARCHAR2) IS
    v_flag INT;
  BEGIN
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_size_chart_tmp t
     INNER JOIN scmdata.t_size_chart_details_tmp a
        ON a.size_chart_id = t.size_chart_tmp_id
     WHERE t.goo_id = p_goo_id
       AND t.company_id = p_company_id
       AND a.measure_value IS NULL;
  
    IF v_flag > 0 THEN
      raise_application_error(-20002, '���ڳ���Ϊ��,���������ݺ��ύ');
    END IF;
  END p_check_size_chart_by_submit;
  --���ɳߴ��ҵ���
  PROCEDURE p_generate_size_chart(p_company_id VARCHAR2, p_goo_id VARCHAR2) IS
    p_t_siz_rec     t_size_chart%ROWTYPE;
    p_t_siz_dt_rec  t_size_chart_details%ROWTYPE;
    v_size_chart_id VARCHAR2(32);
  BEGIN
    --У�������
    p_check_size_chart_by_submit(p_company_id => p_company_id,
                                 p_goo_id     => p_goo_id);
    --���ɳߴ��ǰ��ɾ���û��Ŷ�Ӧ�����гߴ������
    p_delete_t_size_chart_all_data(p_company_id => p_company_id,
                                   p_goo_id     => p_goo_id);
    --���ɳߴ��                              
    FOR p_t_siz_tmp_rec IN (SELECT *
                              FROM scmdata.t_size_chart_tmp t
                             WHERE t.goo_id = p_goo_id
                               AND t.company_id = p_company_id) LOOP
      v_size_chart_id                    := scmdata.f_get_uuid();
      p_t_siz_rec.size_chart_id          := v_size_chart_id;
      p_t_siz_rec.company_id             := p_t_siz_tmp_rec.company_id;
      p_t_siz_rec.goo_id                 := p_t_siz_tmp_rec.goo_id;
      p_t_siz_rec.seq_num                := p_t_siz_tmp_rec.seq_num;
      p_t_siz_rec.position               := p_t_siz_tmp_rec.position;
      p_t_siz_rec.quantitative_method    := p_t_siz_tmp_rec.quantitative_method;
      p_t_siz_rec.base_code              := p_t_siz_tmp_rec.base_code;
      p_t_siz_rec.base_value             := p_t_siz_tmp_rec.base_value;
      p_t_siz_rec.plus_toleran_range     := p_t_siz_tmp_rec.plus_toleran_range;
      p_t_siz_rec.negative_toleran_range := p_t_siz_tmp_rec.negative_toleran_range;
      p_t_siz_rec.pause                  := p_t_siz_tmp_rec.pause;
      p_t_siz_rec.create_id              := p_t_siz_tmp_rec.create_id;
      p_t_siz_rec.create_time            := p_t_siz_tmp_rec.create_time;
      p_t_siz_rec.update_id              := p_t_siz_tmp_rec.update_id;
      p_t_siz_rec.update_time            := p_t_siz_tmp_rec.update_time;
      p_t_siz_rec.memo                   := p_t_siz_tmp_rec.memo;
    
      p_insert_t_size_chart(p_t_siz_rec => p_t_siz_rec);
    
      FOR p_t_siz_dt_tmp_rec IN (SELECT *
                                   FROM scmdata.t_size_chart_details_tmp dt
                                  WHERE dt.size_chart_id =
                                        p_t_siz_tmp_rec.size_chart_tmp_id) LOOP
      
        p_t_siz_dt_rec.size_chart_dt_id := scmdata.f_get_uuid();
        p_t_siz_dt_rec.size_chart_id    := v_size_chart_id;
        p_t_siz_dt_rec.measure          := p_t_siz_dt_tmp_rec.measure;
        p_t_siz_dt_rec.measure_value    := p_t_siz_dt_tmp_rec.measure_value;
        p_t_siz_dt_rec.pause            := p_t_siz_dt_tmp_rec.pause;
        p_t_siz_dt_rec.create_id        := p_t_siz_dt_tmp_rec.create_id;
        p_t_siz_dt_rec.create_time      := p_t_siz_dt_tmp_rec.create_time;
        p_t_siz_dt_rec.update_id        := p_t_siz_dt_tmp_rec.update_id;
        p_t_siz_dt_rec.update_time      := p_t_siz_dt_tmp_rec.update_time;
        p_t_siz_dt_rec.memo             := p_t_siz_dt_tmp_rec.memo;
        p_insert_t_size_chart_details(p_t_siz_rec => p_t_siz_dt_rec);
      END LOOP;
    END LOOP;
    --��Ʒ�������ɳߴ���ͬ��������ͬ�������浥��
    p_sync_gd_size_chart_to_apv(p_company_id => p_company_id,
                                p_goo_id     => p_goo_id);
  END p_generate_size_chart;

  --�ߴ�����루ҵ���ɾ��У��
  PROCEDURE p_check_t_size_chart_by_delete(p_company_id VARCHAR2,
                                           p_goo_id     VARCHAR2) IS
    v_cnt INT;
  BEGIN
    SELECT COUNT(DISTINCT a.seq_num)
      INTO v_cnt
      FROM t_size_chart a
     INNER JOIN t_size_chart_details b
        ON b.size_chart_id = a.size_chart_id
     WHERE a.company_id = p_company_id
       AND a.goo_id = p_goo_id;
    IF v_cnt <= 1 THEN
      raise_application_error(-20002,
                              '����ɾ���������ݣ����������һ������');
    END IF;
  END p_check_t_size_chart_by_delete;

  --��Ʒ�������ɳߴ���ͬ��������ͬ�������浥��
  PROCEDURE p_sync_gd_size_chart_to_apv(p_company_id VARCHAR2,
                                        p_goo_id     VARCHAR2) IS
    p_t_siz_rec     t_approve_version_size_chart%ROWTYPE;
    p_t_siz_dt_rec  t_approve_version_size_chart_details%ROWTYPE;
    v_size_chart_id VARCHAR2(32);
    v_flag          INT;
  BEGIN
    --������������ɵĳߴ������
    scmdata.pkg_approve_version_size_chart.p_delete_t_approve_version_size_chart_all_data(p_company_id => p_company_id,
                                                                                          p_goo_id     => p_goo_id);
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_size_chart t
     WHERE t.goo_id = p_goo_id
       AND t.company_id = p_company_id;
  
    IF v_flag > 0 THEN
      --ͬ����Ʒ�����ߴ��������                              
      FOR p_t_siz_tmp_rec IN (SELECT *
                                FROM scmdata.t_size_chart t
                               WHERE t.goo_id = p_goo_id
                                 AND t.company_id = p_company_id) LOOP
        v_size_chart_id                    := scmdata.f_get_uuid();
        p_t_siz_rec.size_chart_id          := v_size_chart_id;
        p_t_siz_rec.company_id             := p_t_siz_tmp_rec.company_id;
        p_t_siz_rec.goo_id                 := p_t_siz_tmp_rec.goo_id;
        p_t_siz_rec.seq_num                := p_t_siz_tmp_rec.seq_num;
        p_t_siz_rec.position               := p_t_siz_tmp_rec.position;
        p_t_siz_rec.quantitative_method    := p_t_siz_tmp_rec.quantitative_method;
        p_t_siz_rec.base_code              := p_t_siz_tmp_rec.base_code;
        p_t_siz_rec.base_value             := p_t_siz_tmp_rec.base_value;
        p_t_siz_rec.plus_toleran_range     := p_t_siz_tmp_rec.plus_toleran_range;
        p_t_siz_rec.negative_toleran_range := p_t_siz_tmp_rec.negative_toleran_range;
        p_t_siz_rec.pause                  := p_t_siz_tmp_rec.pause;
        p_t_siz_rec.create_id              := p_t_siz_tmp_rec.create_id;
        p_t_siz_rec.create_time            := p_t_siz_tmp_rec.create_time;
        p_t_siz_rec.update_id              := p_t_siz_tmp_rec.update_id;
        p_t_siz_rec.update_time            := p_t_siz_tmp_rec.update_time;
        p_t_siz_rec.memo                   := p_t_siz_tmp_rec.memo;
      
        scmdata.pkg_approve_version_size_chart.p_insert_t_approve_version_size_chart(p_t_siz_rec => p_t_siz_rec);
      
        FOR p_t_siz_dt_tmp_rec IN (SELECT *
                                     FROM scmdata.t_size_chart_details dt
                                    WHERE dt.size_chart_id =
                                          p_t_siz_tmp_rec.size_chart_id) LOOP
        
          p_t_siz_dt_rec.size_chart_dt_id := scmdata.f_get_uuid();
          p_t_siz_dt_rec.size_chart_id    := v_size_chart_id;
          p_t_siz_dt_rec.measure          := p_t_siz_dt_tmp_rec.measure;
          p_t_siz_dt_rec.measure_value    := p_t_siz_dt_tmp_rec.measure_value;
          p_t_siz_dt_rec.pause            := p_t_siz_dt_tmp_rec.pause;
          p_t_siz_dt_rec.create_id        := p_t_siz_dt_tmp_rec.create_id;
          p_t_siz_dt_rec.create_time      := p_t_siz_dt_tmp_rec.create_time;
          p_t_siz_dt_rec.update_id        := p_t_siz_dt_tmp_rec.update_id;
          p_t_siz_dt_rec.update_time      := p_t_siz_dt_tmp_rec.update_time;
          p_t_siz_dt_rec.memo             := p_t_siz_dt_tmp_rec.memo;
          scmdata.pkg_approve_version_size_chart.p_insert_t_approve_version_size_chart_details(p_t_siz_rec => p_t_siz_dt_rec);
        END LOOP;
      END LOOP;
    END IF;
  END p_sync_gd_size_chart_to_apv;

  --�ߴ����
  --�ߴ����� �޸ģ�ɾ��У��
  PROCEDURE p_check_t_size_chart_import_tmp_by_update(p_seq_num NUMBER,
                                                      p_type    INT DEFAULT 0) IS
  BEGIN
    IF p_seq_num = 0 THEN
      IF p_type = 0 THEN
        raise_application_error(-20002, '�����޸ĳ�ʼ����ʾ����');
      ELSE
        raise_application_error(-20002, '����ɾ����ʼ����ʾ����');
      END IF;
    END IF;
  END p_check_t_size_chart_import_tmp_by_update;

  --�ߴ絼��� �ύУ��
  PROCEDURE p_check_t_size_chart_import_tmp_by_submit(p_company_id VARCHAR2,
                                                      p_goo_id     VARCHAR2,
                                                      p_type       INT DEFAULT 0) IS
    v_cnt INT;
  BEGIN
    SELECT COUNT(DISTINCT a.seq_num)
      INTO v_cnt
      FROM t_size_chart_import_tmp a
     INNER JOIN t_size_chart_details_import_tmp b
        ON b.size_chart_id = a.size_chart_tmp_id
     WHERE a.company_id = p_company_id
       AND a.goo_id = p_goo_id
       AND a.seq_num <> 0;
    IF v_cnt < 1 THEN
      IF p_type = 0 THEN
        raise_application_error(-20002, '�����ύ�����������һ������');
      ELSE
        raise_application_error(-20002, '����ɾ�������������һ������');
      END IF;
    END IF;
  END p_check_t_size_chart_import_tmp_by_submit;

  --�ж��Ƿ��Ѵ��ڳߴ絼��� ������
  FUNCTION f_check_is_has_size_chart_import_data(p_company_id          VARCHAR2,
                                                 p_goo_id              VARCHAR2,
                                                 p_position            VARCHAR2,
                                                 p_quantitative_method VARCHAR2)
    RETURN INT IS
    v_flag INT;
  BEGIN
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_size_chart_import_tmp t
     WHERE t.company_id = p_company_id
       AND t.goo_id = p_goo_id
       AND t.position = p_position
       AND t.quantitative_method = p_quantitative_method;
    RETURN v_flag;
  END f_check_is_has_size_chart_import_data;

  /*============================================*
  * Author   : CZH
  * Created  : 23-9�� -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ��ѯ t_size_chart_import_tmp
  * Obj_Name    : f_query_t_size_chart_import_tmp
  *============================================*/
  FUNCTION f_query_t_size_chart_import_tmp(p_company_id VARCHAR2,
                                           p_goo_id     VARCHAR2) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := 'SELECT a.size_chart_tmp_id,
       a.company_id,
       a.goo_id,
       LPAD(a.seq_num,2,''0'') seq_num,
       a.position,
       a.quantitative_method,
       a.base_code,
       a.base_value,
       abs(a.plus_toleran_range) plus_toleran_range,
       abs(a.negative_toleran_range) negative_toleran_range,
       c.company_dict_name measure,
       b.measure_value
  FROM scmdata.t_size_chart_import_tmp a
 INNER JOIN scmdata.t_size_chart_details_import_tmp b
    ON b.size_chart_id = a.size_chart_tmp_id
 INNER JOIN scmdata.sys_company_dict c
    ON c.company_dict_id = b.measure
 WHERE a.goo_id = ''' || p_goo_id || '''
   AND a.company_id = ''' || p_company_id || ''' 
 ORDER BY a.seq_num ASC,c.company_dict_sort ASC';
    RETURN v_sql;
  END f_query_t_size_chart_import_tmp;
  /*============================================*
  * Author   : CZH
  * Created  : 11-10��-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ���� t_size_chart_import_tmp
  * Obj_Name    : p_insert_t_size_chart_import_tmp
  *============================================*/
  PROCEDURE p_insert_t_size_chart_import_tmp(p_t_siz_rec scmdata.t_size_chart_import_tmp%ROWTYPE) IS
  BEGIN
    INSERT INTO t_size_chart_import_tmp
      (size_chart_tmp_id, company_id, goo_id, seq_num, position,
       quantitative_method, base_code, base_value, plus_toleran_range,
       negative_toleran_range, pause, create_id, create_time, update_id,
       update_time, memo)
    VALUES
      (p_t_siz_rec.size_chart_tmp_id, p_t_siz_rec.company_id,
       p_t_siz_rec.goo_id, p_t_siz_rec.seq_num, p_t_siz_rec.position,
       p_t_siz_rec.quantitative_method, p_t_siz_rec.base_code,
       p_t_siz_rec.base_value, p_t_siz_rec.plus_toleran_range,
       p_t_siz_rec.negative_toleran_range, p_t_siz_rec.pause,
       p_t_siz_rec.create_id, p_t_siz_rec.create_time, p_t_siz_rec.update_id,
       p_t_siz_rec.update_time, p_t_siz_rec.memo);
  END p_insert_t_size_chart_import_tmp;

  /*============================================*
  * Author   : CZH
  * Created  : 11-10��-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : �޸� t_size_chart_import_tmp
  * Obj_Name    : p_update_t_size_chart_import_tmp
  *============================================*/
  PROCEDURE p_update_t_size_chart_import_tmp(p_t_siz_rec scmdata.t_size_chart_import_tmp%ROWTYPE) IS
  BEGIN
    UPDATE t_size_chart_import_tmp t
       SET t.seq_num                = p_t_siz_rec.seq_num,
           t.position               = p_t_siz_rec.position,
           t.quantitative_method    = p_t_siz_rec.quantitative_method,
           t.base_code              = p_t_siz_rec.base_code,
           t.base_value             = p_t_siz_rec.base_value,
           t.plus_toleran_range     = p_t_siz_rec.plus_toleran_range,
           t.negative_toleran_range = p_t_siz_rec.negative_toleran_range,
           t.pause                  = p_t_siz_rec.pause,
           t.create_id              = p_t_siz_rec.create_id,
           t.create_time            = p_t_siz_rec.create_time,
           t.update_id              = p_t_siz_rec.update_id,
           t.update_time            = p_t_siz_rec.update_time,
           t.memo                   = p_t_siz_rec.memo
     WHERE t.size_chart_tmp_id = p_t_siz_rec.size_chart_tmp_id;
  END p_update_t_size_chart_import_tmp;

  /*============================================*
  * Author   : CZH
  * Created  : 11-10��-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ɾ�� t_size_chart_import_tmp
  * Obj_Name    : p_delete_t_size_chart_import_tmp
  *============================================*/
  PROCEDURE p_delete_t_size_chart_import_tmp(p_t_siz_rec scmdata.t_size_chart_import_tmp%ROWTYPE) IS
  BEGIN
    DELETE FROM t_size_chart_import_tmp t
     WHERE t.size_chart_tmp_id = p_t_siz_rec.size_chart_tmp_id;
  END p_delete_t_size_chart_import_tmp;
  /*============================================*
  * Author   : CZH
  * Created  : 11-10��-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ����t_size_chart_details_import_tmp
  * Obj_Name    : P_INSERT_t_size_chart_details_import_tmp
  *============================================*/
  PROCEDURE p_insert_t_size_chart_details_import_tmp(p_t_siz_rec scmdata.t_size_chart_details_import_tmp%ROWTYPE) IS
  BEGIN
    INSERT INTO t_size_chart_details_import_tmp
      (size_chart_dt_tmp_id, size_chart_id, measure, measure_value, pause,
       create_id, create_time, update_id, update_time, memo)
    VALUES
      (p_t_siz_rec.size_chart_dt_tmp_id, p_t_siz_rec.size_chart_id,
       p_t_siz_rec.measure, p_t_siz_rec.measure_value, p_t_siz_rec.pause,
       p_t_siz_rec.create_id, p_t_siz_rec.create_time, p_t_siz_rec.update_id,
       p_t_siz_rec.update_time, p_t_siz_rec.memo);
  END p_insert_t_size_chart_details_import_tmp;

  /*============================================*
  * Author   : CZH
  * Created  : 11-10��-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : �޸�t_size_chart_details_import_tmp
  * Obj_Name    : P_UPDATE_t_size_chart_details_import_tmp
  *============================================*/
  PROCEDURE p_update_t_size_chart_details_import_tmp(p_t_siz_rec scmdata.t_size_chart_details_import_tmp%ROWTYPE) IS
  BEGIN
    UPDATE t_size_chart_details_import_tmp t
       SET t.measure_value = p_t_siz_rec.measure_value,
           t.pause         = p_t_siz_rec.pause,
           t.create_id     = p_t_siz_rec.create_id,
           t.create_time   = p_t_siz_rec.create_time,
           t.update_id     = p_t_siz_rec.update_id,
           t.update_time   = p_t_siz_rec.update_time,
           t.memo          = p_t_siz_rec.memo
     WHERE t.size_chart_id = p_t_siz_rec.size_chart_id
       AND t.measure = p_t_siz_rec.measure;
  END p_update_t_size_chart_details_import_tmp;

  /*============================================*
  * Author   : CZH
  * Created  : 11-10��-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ɾ��t_size_chart_details_import_tmp
  * Obj_Name    : P_DELETE_t_size_chart_details_import_tmp
  *============================================*/
  PROCEDURE p_delete_t_size_chart_details_import_tmp(p_t_siz_rec scmdata.t_size_chart_details_import_tmp%ROWTYPE) IS
  BEGIN
    DELETE FROM t_size_chart_details_import_tmp t
     WHERE t.size_chart_dt_tmp_id = p_t_siz_rec.size_chart_dt_tmp_id;
  END p_delete_t_size_chart_details_import_tmp;

  --ɾ���ߴ絼���������
  PROCEDURE p_delete_t_size_chart_import_tmp_row_data(p_company_id          VARCHAR2,
                                                      p_goo_id              VARCHAR2,
                                                      p_position            VARCHAR2,
                                                      p_quantitative_method VARCHAR2) IS
  BEGIN
    --У��ߴ絼���
    p_check_t_size_chart_import_tmp_by_submit(p_company_id => p_company_id,
                                              p_goo_id     => p_goo_id,
                                              p_type       => 1);
  
    DELETE FROM t_size_chart_details_import_tmp a
     WHERE a.size_chart_id IN
           (SELECT t.size_chart_tmp_id
              FROM scmdata.t_size_chart_import_tmp t
             WHERE t.company_id = p_company_id
               AND t.goo_id = p_goo_id
               AND t.position = p_position
               AND t.quantitative_method = p_quantitative_method);
  
    DELETE FROM scmdata.t_size_chart_import_tmp t
     WHERE t.company_id = p_company_id
       AND p_goo_id = t.goo_id
       AND t.position = p_position
       AND t.quantitative_method = p_quantitative_method;
  END p_delete_t_size_chart_import_tmp_row_data;

  --ɾ���ߴ絼��� ��������
  PROCEDURE p_delete_t_size_chart_import_tmp_all_data(p_company_id VARCHAR2,
                                                      p_goo_id     VARCHAR2) IS
  BEGIN
    DELETE FROM t_size_chart_details_import_tmp a
     WHERE a.size_chart_id IN
           (SELECT t.size_chart_tmp_id
              FROM scmdata.t_size_chart_import_tmp t
             WHERE t.company_id = p_company_id
               AND p_goo_id = t.goo_id);
  
    DELETE FROM scmdata.t_size_chart_import_tmp t
     WHERE t.company_id = p_company_id
       AND p_goo_id = t.goo_id;
  END p_delete_t_size_chart_import_tmp_all_data;

  --ɾ���ߴ絼����ʼ�����ɵ�����
  PROCEDURE p_delete_t_size_chart_import_first_generate_data(p_company_id VARCHAR2,
                                                             p_goo_id     VARCHAR2,
                                                             p_seq_num    INT) IS
    v_flag INT;
  BEGIN
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_size_chart_import_tmp t
     WHERE t.company_id = p_company_id
       AND t.goo_id = p_goo_id
       AND t.seq_num = p_seq_num;
    IF v_flag > 0 THEN
      DELETE FROM t_size_chart_details_import_tmp a
       WHERE a.size_chart_id IN
             (SELECT t.size_chart_tmp_id
                FROM scmdata.t_size_chart_import_tmp t
               WHERE t.company_id = p_company_id
                 AND t.goo_id = p_goo_id
                 AND t.seq_num = p_seq_num);
    
      DELETE FROM scmdata.t_size_chart_import_tmp t
       WHERE t.company_id = p_company_id
         AND p_goo_id = t.goo_id
         AND t.seq_num = p_seq_num;
    ELSE
      NULL;
    END IF;
  END p_delete_t_size_chart_import_first_generate_data;

  --���óߴ絼���
  PROCEDURE p_reset_size_chart_imp_tmp_data(p_company_id VARCHAR2,
                                            p_goo_id     VARCHAR2,
                                            p_user_id    VARCHAR2) IS
  BEGIN
    --�����������
    p_delete_t_size_chart_import_tmp_all_data(p_company_id => p_company_id,
                                              p_goo_id     => p_goo_id);
    --������Ʒ����-����� ��ʼ���ߴ絼���
    p_first_generate_size_chart_imp_tmp_data(p_company_id => p_company_id,
                                             p_goo_id     => p_goo_id,
                                             p_user_id    => p_user_id);
  END p_reset_size_chart_imp_tmp_data;

  --������Ʒ����-����� ��ʼ���ߴ絼���
  PROCEDURE p_first_generate_size_chart_imp_tmp_data(p_company_id VARCHAR2,
                                                     p_goo_id     VARCHAR2,
                                                     p_user_id    VARCHAR2) IS
    p_t_siz_rec     t_size_chart_import_tmp%ROWTYPE;
    p_t_siz_dt_rec  t_size_chart_details_import_tmp%ROWTYPE;
    v_size_chart_id VARCHAR2(32);
    v_sizename      VARCHAR2(32);
  BEGIN
    v_size_chart_id                    := scmdata.f_get_uuid();
    p_t_siz_rec.size_chart_tmp_id      := v_size_chart_id;
    p_t_siz_rec.company_id             := p_company_id;
    p_t_siz_rec.goo_id                 := p_goo_id;
    p_t_siz_rec.seq_num                := 0;
    p_t_siz_rec.position               := '����Ҳ๤�����ȵ���������ģ�壬�ٽ��гߴ����';
    p_t_siz_rec.quantitative_method    := NULL;
    p_t_siz_rec.base_code              := NULL;
    p_t_siz_rec.base_value             := NULL;
    p_t_siz_rec.plus_toleran_range     := NULL;
    p_t_siz_rec.negative_toleran_range := NULL;
    p_t_siz_rec.pause                  := 0;
    p_t_siz_rec.create_id              := p_user_id;
    p_t_siz_rec.create_time            := SYSDATE;
    p_t_siz_rec.update_id              := p_user_id;
    p_t_siz_rec.update_time            := SYSDATE;
    p_t_siz_rec.memo                   := NULL;
    --�����ߴ������
    scmdata.pkg_size_chart.p_insert_t_size_chart_import_tmp(p_t_siz_rec => p_t_siz_rec);
  
    FOR size_chart_dt_rec IN (SELECT DISTINCT t.sizename,
                                              t.goo_id,
                                              t.company_id,
                                              t.sizecode
                                FROM scmdata.t_commodity_color_size t
                               WHERE t.goo_id = p_goo_id
                                 AND t.company_id = p_company_id
                               ORDER BY t.sizecode ASC) LOOP
      p_t_siz_dt_rec.size_chart_dt_tmp_id := scmdata.f_get_uuid();
      p_t_siz_dt_rec.size_chart_id        := v_size_chart_id;
      v_sizename                          := scmdata.pkg_size_chart.f_get_size_company_dict(p_company_id => p_company_id,
                                                                                            p_size_name  => size_chart_dt_rec.sizename);
      p_t_siz_dt_rec.measure              := v_sizename;
      p_t_siz_dt_rec.measure_value        := NULL;
      p_t_siz_dt_rec.pause                := 0;
      p_t_siz_dt_rec.create_id            := p_user_id;
      p_t_siz_dt_rec.create_time          := SYSDATE;
      p_t_siz_dt_rec.update_id            := p_user_id;
      p_t_siz_dt_rec.update_time          := SYSDATE;
      p_t_siz_dt_rec.memo                 := NULL;
      --��������
      scmdata.pkg_size_chart.p_insert_t_size_chart_details_import_tmp(p_t_siz_rec => p_t_siz_dt_rec);
    END LOOP;
  END p_first_generate_size_chart_imp_tmp_data;

  --��Ʒ�����ߴ���룬���ύ�����������ߴ��ҵ���
  PROCEDURE p_generate_size_chart_by_good_import(p_company_id VARCHAR2,
                                                 p_goo_id     VARCHAR2) IS
    p_t_siz_rec     t_size_chart%ROWTYPE;
    p_t_siz_dt_rec  t_size_chart_details%ROWTYPE;
    v_size_chart_id VARCHAR2(32);
  BEGIN
    --�ύУ��ߴ絼���
    p_check_t_size_chart_import_tmp_by_submit(p_company_id => p_company_id,
                                              p_goo_id     => p_goo_id);
  
    --���ɳߴ��ǰ��ɾ���û��Ŷ�Ӧ�����гߴ������
    p_delete_t_size_chart_all_data(p_company_id => p_company_id,
                                   p_goo_id     => p_goo_id);
    --���ɳߴ��                              
    FOR p_t_siz_tmp_rec IN (SELECT *
                              FROM scmdata.t_size_chart_import_tmp t
                             WHERE t.goo_id = p_goo_id
                               AND t.company_id = p_company_id) LOOP
      v_size_chart_id                    := scmdata.f_get_uuid();
      p_t_siz_rec.size_chart_id          := v_size_chart_id;
      p_t_siz_rec.company_id             := p_t_siz_tmp_rec.company_id;
      p_t_siz_rec.goo_id                 := p_t_siz_tmp_rec.goo_id;
      p_t_siz_rec.seq_num                := p_t_siz_tmp_rec.seq_num;
      p_t_siz_rec.position               := p_t_siz_tmp_rec.position;
      p_t_siz_rec.quantitative_method    := p_t_siz_tmp_rec.quantitative_method;
      p_t_siz_rec.base_code              := p_t_siz_tmp_rec.base_code;
      p_t_siz_rec.base_value             := p_t_siz_tmp_rec.base_value;
      p_t_siz_rec.plus_toleran_range     := p_t_siz_tmp_rec.plus_toleran_range;
      p_t_siz_rec.negative_toleran_range := p_t_siz_tmp_rec.negative_toleran_range;
      p_t_siz_rec.pause                  := p_t_siz_tmp_rec.pause;
      p_t_siz_rec.create_id              := p_t_siz_tmp_rec.create_id;
      p_t_siz_rec.create_time            := p_t_siz_tmp_rec.create_time;
      p_t_siz_rec.update_id              := p_t_siz_tmp_rec.update_id;
      p_t_siz_rec.update_time            := p_t_siz_tmp_rec.update_time;
      p_t_siz_rec.memo                   := p_t_siz_tmp_rec.memo;
    
      p_insert_t_size_chart(p_t_siz_rec => p_t_siz_rec);
    
      FOR p_t_siz_dt_tmp_rec IN (SELECT *
                                   FROM scmdata.t_size_chart_details_import_tmp dt
                                  WHERE dt.size_chart_id =
                                        p_t_siz_tmp_rec.size_chart_tmp_id) LOOP
      
        p_t_siz_dt_rec.size_chart_dt_id := scmdata.f_get_uuid();
        p_t_siz_dt_rec.size_chart_id    := v_size_chart_id;
        p_t_siz_dt_rec.measure          := p_t_siz_dt_tmp_rec.measure;
        p_t_siz_dt_rec.measure_value    := p_t_siz_dt_tmp_rec.measure_value;
        p_t_siz_dt_rec.pause            := p_t_siz_dt_tmp_rec.pause;
        p_t_siz_dt_rec.create_id        := p_t_siz_dt_tmp_rec.create_id;
        p_t_siz_dt_rec.create_time      := p_t_siz_dt_tmp_rec.create_time;
        p_t_siz_dt_rec.update_id        := p_t_siz_dt_tmp_rec.update_id;
        p_t_siz_dt_rec.update_time      := p_t_siz_dt_tmp_rec.update_time;
        p_t_siz_dt_rec.memo             := p_t_siz_dt_tmp_rec.memo;
        p_insert_t_size_chart_details(p_t_siz_rec => p_t_siz_dt_rec);
      END LOOP;
    END LOOP;
    --��Ʒ�������ɳߴ���ͬ��������ͬ�������浥��
    p_sync_gd_size_chart_to_apv(p_company_id => p_company_id,
                                p_goo_id     => p_goo_id);
  END p_generate_size_chart_by_good_import;

  --����ߴ���룬���ύ�����������ߴ��ҵ���
  PROCEDURE p_generate_size_chart_by_apv_import(p_company_id VARCHAR2,
                                                p_goo_id     VARCHAR2) IS
    p_t_siz_rec     t_approve_version_size_chart%ROWTYPE;
    p_t_siz_dt_rec  t_approve_version_size_chart_details%ROWTYPE;
    v_size_chart_id VARCHAR2(32);
  BEGIN
    --�ύУ��ߴ絼���
    p_check_t_size_chart_import_tmp_by_submit(p_company_id => p_company_id,
                                              p_goo_id     => p_goo_id);
  
    --���ɳߴ��ǰ��ɾ���û��Ŷ�Ӧ�����гߴ������
    p_delete_t_size_chart_all_data(p_company_id => p_company_id,
                                   p_goo_id     => p_goo_id);
    --���ɳߴ��                              
    FOR p_t_siz_tmp_rec IN (SELECT *
                              FROM scmdata.t_size_chart_import_tmp t
                             WHERE t.goo_id = p_goo_id
                               AND t.company_id = p_company_id) LOOP
      v_size_chart_id                    := scmdata.f_get_uuid();
      p_t_siz_rec.size_chart_id          := v_size_chart_id;
      p_t_siz_rec.company_id             := p_t_siz_tmp_rec.company_id;
      p_t_siz_rec.goo_id                 := p_t_siz_tmp_rec.goo_id;
      p_t_siz_rec.seq_num                := p_t_siz_tmp_rec.seq_num;
      p_t_siz_rec.position               := p_t_siz_tmp_rec.position;
      p_t_siz_rec.quantitative_method    := p_t_siz_tmp_rec.quantitative_method;
      p_t_siz_rec.base_code              := p_t_siz_tmp_rec.base_code;
      p_t_siz_rec.base_value             := p_t_siz_tmp_rec.base_value;
      p_t_siz_rec.plus_toleran_range     := p_t_siz_tmp_rec.plus_toleran_range;
      p_t_siz_rec.negative_toleran_range := p_t_siz_tmp_rec.negative_toleran_range;
      p_t_siz_rec.pause                  := p_t_siz_tmp_rec.pause;
      p_t_siz_rec.create_id              := p_t_siz_tmp_rec.create_id;
      p_t_siz_rec.create_time            := p_t_siz_tmp_rec.create_time;
      p_t_siz_rec.update_id              := p_t_siz_tmp_rec.update_id;
      p_t_siz_rec.update_time            := p_t_siz_tmp_rec.update_time;
      p_t_siz_rec.memo                   := p_t_siz_tmp_rec.memo;
    
      scmdata.pkg_approve_version_size_chart.p_insert_t_approve_version_size_chart(p_t_siz_rec => p_t_siz_rec);
    
      FOR p_t_siz_dt_tmp_rec IN (SELECT *
                                   FROM scmdata.t_size_chart_details_import_tmp dt
                                  WHERE dt.size_chart_id =
                                        p_t_siz_tmp_rec.size_chart_tmp_id) LOOP
      
        p_t_siz_dt_rec.size_chart_dt_id := scmdata.f_get_uuid();
        p_t_siz_dt_rec.size_chart_id    := v_size_chart_id;
        p_t_siz_dt_rec.measure          := p_t_siz_dt_tmp_rec.measure;
        p_t_siz_dt_rec.measure_value    := p_t_siz_dt_tmp_rec.measure_value;
        p_t_siz_dt_rec.pause            := p_t_siz_dt_tmp_rec.pause;
        p_t_siz_dt_rec.create_id        := p_t_siz_dt_tmp_rec.create_id;
        p_t_siz_dt_rec.create_time      := p_t_siz_dt_tmp_rec.create_time;
        p_t_siz_dt_rec.update_id        := p_t_siz_dt_tmp_rec.update_id;
        p_t_siz_dt_rec.update_time      := p_t_siz_dt_tmp_rec.update_time;
        p_t_siz_dt_rec.memo             := p_t_siz_dt_tmp_rec.memo;
        scmdata.pkg_approve_version_size_chart.p_insert_t_approve_version_size_chart_details(p_t_siz_rec => p_t_siz_dt_rec);
      END LOOP;
    END LOOP;
  END p_generate_size_chart_by_apv_import;

  --��ȡ��Ʒ��������ĳ��������
  --��ĸ�룬������
  FUNCTION f_get_good_size_chart_type(p_company_id VARCHAR2,
                                      p_goo_id     VARCHAR2) RETURN VARCHAR2 IS
    v_rtn_val VARCHAR2(32);
  BEGIN
    SELECT CASE
             WHEN regexp_like(sizename, '^[0-9]+[0-9]$') THEN
              'SL_GDN'
             ELSE
              'SL_GDV'
           END
      INTO v_rtn_val
      FROM (SELECT DISTINCT t.sizename
              FROM scmdata.t_commodity_color_size t
             WHERE t.goo_id = p_goo_id
               AND t.company_id = p_company_id)
     WHERE rownum = 1;
    RETURN v_rtn_val;
  END f_get_good_size_chart_type;
  --�ߴ�����ӳ�����
  PROCEDURE p_insert_size_chart_col(p_company_id VARCHAR2,
                                    p_goo_id     VARCHAR2,
                                    p_user_id    VARCHAR2,
                                    p_size_col   VARCHAR2) IS
    p_t_siz_dt_rec scmdata.t_size_chart_details_import_tmp%ROWTYPE;
    v_flag         INT;
  BEGIN
    SELECT COUNT(1)
      INTO v_flag
      FROM (SELECT listagg(DISTINCT a.measure, ';') measure
              FROM scmdata.t_size_chart_import_tmp t
             INNER JOIN scmdata.t_size_chart_details_import_tmp a
                ON a.size_chart_id = t.size_chart_tmp_id
             WHERE t.goo_id = p_goo_id
               AND t.company_id = p_company_id) v
     WHERE instr(v.measure, p_size_col) > 0;
  
    IF v_flag > 0 THEN
      raise_application_error(-20002, '��ǰ�����Ѵ��ڣ��������');
    END IF;
  
    FOR size_chart_rec IN (SELECT t.size_chart_tmp_id
                             FROM scmdata.t_size_chart_import_tmp t
                            WHERE t.goo_id = p_goo_id
                              AND t.company_id = p_company_id) LOOP
      p_t_siz_dt_rec.size_chart_dt_tmp_id := scmdata.f_get_uuid();
      p_t_siz_dt_rec.size_chart_id        := size_chart_rec.size_chart_tmp_id;
      p_t_siz_dt_rec.measure              := p_size_col;
      p_t_siz_dt_rec.measure_value        := NULL;
      p_t_siz_dt_rec.pause                := 0;
      p_t_siz_dt_rec.create_id            := p_user_id;
      p_t_siz_dt_rec.create_time          := SYSDATE;
      p_t_siz_dt_rec.update_id            := p_user_id;
      p_t_siz_dt_rec.update_time          := SYSDATE;
      p_t_siz_dt_rec.memo                 := '';
      p_insert_t_size_chart_details_import_tmp(p_t_siz_rec => p_t_siz_dt_rec);
    END LOOP;
  END p_insert_size_chart_col;

  --�Զ����ɳߴ���ر����
  --Ĭ�ϼ�1
  FUNCTION f_get_size_chart_seq_num(p_company_id VARCHAR2,
                                    p_goo_id     VARCHAR2,
                                    p_table      VARCHAR2) RETURN NUMBER IS
    v_sql     CLOB;
    v_seq_num NUMBER;
  BEGIN
    v_sql := q'[SELECT NVL(MAX(t.seq_num),0) + 1
    FROM ]' || p_table || q'[ t
   WHERE t.goo_id = :goo_id
     AND t.company_id = :company_id
     AND t.seq_num <> 99]';
  
    EXECUTE IMMEDIATE v_sql
      INTO v_seq_num
      USING p_goo_id, p_company_id;
    RETURN v_seq_num;
  END f_get_size_chart_seq_num;

  --���У��
  PROCEDURE p_check_new_seq_no(p_new_seq_num VARCHAR2) IS
    v_flag INT;
  BEGIN
    IF p_new_seq_num = 99 THEN
      raise_application_error(-20002, '���Ϊ99�Ľ����ڿ��ز�λ��������Ϊ������λ����ţ����޸ģ�');
    END IF;
  
    SELECT COUNT(1)
      INTO v_flag
      FROM dual
     WHERE regexp_like(p_new_seq_num, '^[1-9][0-9]?$');
  
    IF v_flag = 0 THEN
      raise_application_error(-20002,
                              '����š�ֻ����д�������������������λ��');
    END IF;
  END p_check_new_seq_no;

  --�������
  --����ĳߴ���в����ɾ����ţ�����������
  --5
  --1,2,3,4,5,6,7,8,9,10
  PROCEDURE p_reset_size_chart_seq_num(p_company_id    VARCHAR2,
                                       p_goo_id        VARCHAR2,
                                       p_orgin_seq_num NUMBER, --ԭ���
                                       p_new_seq_num   NUMBER DEFAULT NULL, --1����Ҫ�����λ�� 
                                       p_type          INT,
                                       p_table         VARCHAR2,
                                       p_table_pk_id   VARCHAR2,
                                       p_is_check      INT DEFAULT 0) IS
    v_orgin_size_chart_id VARCHAR2(32);
    v_sql                 CLOB;
    v_flag                INT;
    v_max_seq_num         INT;
  BEGIN
    IF p_is_check = 1 THEN
      IF p_orgin_seq_num = 99 THEN
        raise_application_error(-20002, '�����ء����Ĭ��Ϊ99�����ɵ�����');
      END IF;
      SELECT COUNT(1)
        INTO v_flag
        FROM dual
       WHERE regexp_like(p_new_seq_num, '^[1-9][0-9]?$');
    
      IF v_flag = 0 THEN
        raise_application_error(-20002,
                                '����š�ֻ����д�������������������λ��');
      ELSE
        EXECUTE IMMEDIATE 'SELECT MAX(t.seq_num)
        FROM scmdata.' || p_table || ' t
       WHERE t.goo_id = :goo_id
         AND t.company_id = :company_id
         AND t.seq_num <> 99'
          INTO v_max_seq_num
          USING p_goo_id, p_company_id;
      
        IF p_new_seq_num > v_max_seq_num THEN
          raise_application_error(-20002,
                                  '���ɵ�����ţ��������Ų��ܴ��ڵ�ǰ�ߴ��������');
        END IF;
      END IF;
    END IF;
    --������� 
    IF p_type = 0 THEN
      --��ȡԭ��Ŷ�Ӧ��ID
      EXECUTE IMMEDIATE 'SELECT MAX(t.' || p_table_pk_id || ')
        FROM scmdata.' || p_table || ' t
       WHERE t.goo_id = :goo_id
         AND t.company_id = :company_id
         AND t.seq_num = :orgin_seq_num
         AND t.seq_num <> 99'         
        INTO v_orgin_size_chart_id
        USING p_goo_id, p_company_id, p_orgin_seq_num;
    
      --2������λ�ú�������ݣ�������Ųһλ
    
      IF p_orgin_seq_num > p_new_seq_num THEN
        EXECUTE IMMEDIATE 'UPDATE scmdata.' || p_table || ' t
         SET t.seq_num = (CASE WHEN t.seq_num = 99 THEN 99 ELSE t.seq_num + 1 END)
       WHERE t.goo_id = :goo_id
         AND t.company_id = :company_id
         AND t.seq_num >= :new_seq_num
         AND t.seq_num < :orgin_seq_num'
          USING p_goo_id, p_company_id, p_new_seq_num, p_orgin_seq_num;
      ELSIF p_orgin_seq_num < p_new_seq_num THEN
        EXECUTE IMMEDIATE 'UPDATE scmdata.' || p_table || ' t
         SET t.seq_num = (CASE WHEN t.seq_num = 99 THEN 99 ELSE t.seq_num - 1 END)
       WHERE t.goo_id = :goo_id
         AND t.company_id = :company_id
         AND t.seq_num > :orgin_seq_num
         AND t.seq_num <= :new_seq_num'
          USING p_goo_id, p_company_id, p_orgin_seq_num, p_new_seq_num;
      ELSE
        NULL;
      END IF;
    
      --3���������ݲ嵽��λ��
      EXECUTE IMMEDIATE 'UPDATE scmdata.' || p_table || ' t
         SET t.seq_num = :new_seq_num
       WHERE t.goo_id = :goo_id
         AND t.company_id = :company_id
         AND t.' || p_table_pk_id ||
                        ' = :orgin_size_chart_id'
        USING p_new_seq_num, p_goo_id, p_company_id, v_orgin_size_chart_id;
      --ɾ�����
    ELSIF p_type = 1 THEN
      --2������λ�ú�������ݣ�����ǰŲһλ       
      v_sql := q'[UPDATE ]' || p_table || q'[ a
         SET a.seq_num = (CASE WHEN a.seq_num = 99 THEN 99 ELSE a.seq_num - 1 END)
       WHERE a.]' || p_table_pk_id ||
               q'[ IN
             (SELECT t.]' || p_table_pk_id || q'[ 
                FROM ]' || p_table ||
               q'[ t
               WHERE t.goo_id = :goo_id
                 AND t.company_id = :company_id
                 AND t.seq_num > :orgin_seq_num)]';
    
      EXECUTE IMMEDIATE v_sql
        USING p_goo_id, p_company_id, p_orgin_seq_num;
    END IF;
  
  END p_reset_size_chart_seq_num;

  --�жϳߴ���������Ƿ����
  FUNCTION f_is_has_size_chart_row_data(p_company_id          VARCHAR2,
                                        p_goo_id              VARCHAR2,
                                        p_position            VARCHAR2,
                                        p_quantitative_method VARCHAR2,
                                        p_table               VARCHAR2)
    RETURN INT IS
    v_flag INT;
    v_sql  CLOB;
  BEGIN
    v_sql := q'[
    SELECT COUNT(1)
      FROM ]' || p_table ||
             q'[ t
     WHERE t.goo_id = :goo_id
       AND t.company_id = :company_id
       AND t.position = :position
       AND t.quantitative_method = :quantitative_method]';
  
    EXECUTE IMMEDIATE v_sql
      INTO v_flag
      USING p_goo_id, p_company_id, p_position, p_quantitative_method;
  
    RETURN v_flag;
  END f_is_has_size_chart_row_data;
  --���ݲ�λ�ж��Ƿ���ڿ���
  PROCEDURE p_is_has_grammage(p_company_id VARCHAR2,
                              p_goo_id     VARCHAR2,
                              p_table      VARCHAR2,
                              p_grammage   VARCHAR2 DEFAULT NULL,
                              p_type       INT DEFAULT 0) IS
    v_flag         INT;
    v_old_grammage VARCHAR2(256);
    v_sql          CLOB;
  BEGIN
    v_sql := q'[SELECT COUNT(1), MAX(t.position)
      FROM scmdata.]' || p_table || q'[ t
     WHERE t.company_id = :company_id
       AND t.goo_id = :goo_id
       AND t.seq_num = 99]';
  
    EXECUTE IMMEDIATE v_sql
      INTO v_flag, v_old_grammage
      USING p_company_id, p_goo_id;
  
    IF v_flag > 0 THEN
      IF p_type = 0 THEN
        IF v_old_grammage = p_grammage THEN
          NULL;
        ELSE
          raise_application_error(-20002,
                                  '�Ѵ��ڿ��أ���ɾ�����غ���������');
        END IF;
      ELSIF p_type = 1 THEN
        raise_application_error(-20002, '�Ѵ��ڿ��أ���ɾ�����غ���������');
      ELSE
        NULL;
      END IF;
    END IF;
  END p_is_has_grammage;
  --���������ж�
  PROCEDURE p_is_has_grammage_row_data(p_company_id          VARCHAR2,
                                       p_goo_id              VARCHAR2,
                                       p_position            VARCHAR2,
                                       p_quantitative_method VARCHAR2,
                                       p_table1              VARCHAR2,
                                       p_table2              VARCHAR2,
                                       p_table1_pk_id        VARCHAR2 DEFAULT 'size_chart_id') IS
    v_all_measure_sql      CLOB;
    v_grammage_measure_sql CLOB;
    v_all_measure_cnt      INT;
    v_grammage_measure_cnt INT;
  BEGIN
    v_all_measure_sql := q'[SELECT COUNT(DISTINCT ts.measure)
      FROM scmdata.]' || p_table1 ||
                         q'[ t
     INNER JOIN scmdata.]' || p_table2 ||
                         q'[ ts
        ON ts.size_chart_id = t.]' ||
                         p_table1_pk_id || q'[
     WHERE t.company_id = :company_id
       AND t.goo_id = :goo_id
       AND t.position <> :position
       AND t.quantitative_method <> :quantitative_method]';
  
    EXECUTE IMMEDIATE v_all_measure_sql
      INTO v_all_measure_cnt
      USING p_company_id, p_goo_id, p_position, p_quantitative_method;
  
    v_grammage_measure_sql := q'[SELECT COUNT(1)
      FROM scmdata.]' || p_table1 ||
                              q'[ t
     INNER JOIN scmdata.]' || p_table2 ||
                              q'[ ts
        ON ts.size_chart_id = t.]' ||
                              p_table1_pk_id || q'[
     WHERE t.company_id = :company_id
       AND t.goo_id = :goo_id
       AND t.position = :position
       AND t.quantitative_method = :quantitative_method]';
    EXECUTE IMMEDIATE v_grammage_measure_sql
      INTO v_grammage_measure_cnt
      USING p_company_id, p_goo_id, p_position, p_quantitative_method;
  
    IF v_grammage_measure_cnt > v_all_measure_cnt THEN
      raise_application_error(-20002, '�Ѵ��ڿ��أ�����������');
    ELSE
      NULL;
    END IF;
  
  END p_is_has_grammage_row_data;

END pkg_size_chart;
/
