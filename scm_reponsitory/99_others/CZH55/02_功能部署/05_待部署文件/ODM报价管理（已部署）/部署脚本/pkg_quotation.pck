CREATE OR REPLACE PACKAGE pkg_quotation IS

  -- Author  : CZH55
  -- Created : 2022/7/25 17:01:01
  -- Purpose : ODM���۹���
  --У��
  PROCEDURE p_check_quotation(p_company_id VARCHAR2,
                              p_quota_rec  plm.quotation%ROWTYPE);
  --ֽ�����У��
  PROCEDURE p_check_bag_paper(p_company_id      VARCHAR2,
                              p_quotation_class VARCHAR2,
                              p_bag_paper       VARCHAR2);

  --��ȡ���۷���ĩ��lookup
  FUNCTION f_get_quotation_class_lookup(p_company_id VARCHAR2,
                                        p_val        VARCHAR2,
                                        p_desc       VARCHAR2) RETURN CLOB;

  --���ݱ��۷���㼶 ��ȡ��Ӧ���۷���lookup
  FUNCTION f_get_quotation_class_lookup_by_out_type(p_company_id VARCHAR2,
                                                    p_val        VARCHAR2,
                                                    p_desc       VARCHAR2,
                                                    p_out_type   INT)
    RETURN CLOB;

  --����ĩ������ ��ȡ���۷���
  FUNCTION f_get_quotation_class_by_id(p_company_id               VARCHAR2,
                                       p_quotation_classification VARCHAR2,
                                       p_out_type                 INT DEFAULT 1,
                                       p_is_name                  INT DEFAULT 0)
    RETURN VARCHAR2;
  --�������Ϸ���ĩ����ȡ���Ϸ������ƣ�ƴ�ӣ�
  FUNCTION f_get_material_class_look_up(p_company_id VARCHAR2,
                                        p_val        VARCHAR2,
                                        p_desc       VARCHAR2) RETURN CLOB;

  FUNCTION f_query_quotation(p_company_id     VARCHAR2,
                             p_sup_company_id VARCHAR2,
                             p_item_id        VARCHAR2 DEFAULT NULL)
    RETURN CLOB;

  --ͬ��۵���Ϣ
  FUNCTION f_query_same_quotation(p_quotation_id VARCHAR2) RETURN CLOB;

  FUNCTION f_query_quotation_by_id(p_quotation_id    VARCHAR2,
                                   p_type            INT,
                                   p_company_id      VARCHAR2 DEFAULT NULL,
                                   p_quotation_class VARCHAR2 DEFAULT NULL)
    RETURN CLOB;

  PROCEDURE p_insert_quotation(p_quota_rec plm.quotation%ROWTYPE);

  PROCEDURE p_update_quotation(p_quota_rec       plm.quotation%ROWTYPE,
                               p_type            INT,
                               p_company_id      VARCHAR2 DEFAULT NULL,
                               p_quotation_class VARCHAR2 DEFAULT NULL);

  --У����������
  PROCEDURE p_check_working_procedure(p_qt_rec       plm.quotation%ROWTYPE,
                                      p_type         INT,
                                      p_out_err_type INT DEFAULT 0,
                                      po_error_msg   OUT CLOB);
  --У����������
  PROCEDURE p_check_other_fees(p_qt_rec       plm.quotation%ROWTYPE,
                               p_type         INT,
                               p_out_err_type INT DEFAULT 0,
                               po_error_msg   OUT CLOB);
  --У�鸽��
  PROCEDURE p_check_files(p_qt_rec       plm.quotation%ROWTYPE,
                          p_out_err_type INT DEFAULT 0,
                          po_error_msg   OUT CLOB);
  --�ύ���۵�У�� 
  PROCEDURE p_check_quotation_by_submit(p_company_id   VARCHAR2,
                                        p_quotation_id VARCHAR2,
                                        p_out_err_msg  OUT CLOB);
  --�ύ���۵�
  PROCEDURE p_submit_quotation(p_company_id   VARCHAR2,
                               p_quotation_id VARCHAR2,
                               p_user_id      VARCHAR2);

  --ȡ�����۵�
  PROCEDURE p_cancel_quotation(p_quotation_id VARCHAR2, p_user_id VARCHAR2);
  --��ȡ״̬lookup
  FUNCTION f_get_quotation_lookup RETURN CLOB;

  --ͨ�����۷���У��Ĳ�BOM���Ƿ��кĲ���ϸ
  FUNCTION f_check_is_exist_material_details(p_quotation_classification VARCHAR2)
    RETURN INT;

  --ͨ������sku��ȡmrpȷ����Ӧ�̱�źͼ��
  PROCEDURE p_get_mrp_internal_sup_info(p_material_sku IN VARCHAR2,
                                        po_sup_code    OUT VARCHAR2);

  --ѡ��Ӧ��picklist
  FUNCTION p_get_mrp_internal_sup_info_pick(p_material_sku IN VARCHAR2)
    RETURN CLOB;
  --�Ĳ���ϸ
  --����ĲĽ��
  PROCEDURE p_cal_consumables_detail_total_amount(p_quotation_id VARCHAR2);
  --У��Ĳ�������ϸ
  PROCEDURE p_check_consumables_consumption_detail(p_consu_rec plm.consumables_consumption_detail%ROWTYPE,
                                                   p_type      INT);

  FUNCTION f_query_consumables_consumption_detail(p_quotation_id              VARCHAR2,
                                                  p_is_exist_material_details INT)
    RETURN CLOB;

  PROCEDURE p_insert_consumables_consumption_detail(p_consu_rec plm.consumables_consumption_detail%ROWTYPE);

  PROCEDURE p_update_consumables_consumption_detail(p_consu_rec plm.consumables_consumption_detail%ROWTYPE,
                                                    p_type      INT);
  --ɾ��
  PROCEDURE p_delete_consumables_consumption_detail(p_quotation_id        VARCHAR2,
                                                    p_consumables_name_id VARCHAR2);
  --���⹤��
  --ͨ�����⹤��id��ȡ����
  FUNCTION f_get_special_craft_by_id(p_craft_classification VARCHAR2,
                                     p_type                 INT DEFAULT 0)
    RETURN VARCHAR2;
  --���⹤�շ��൯��
  FUNCTION f_get_special_craft_pick RETURN CLOB;

  --ͨ�����⹤��һ������ ��ȡ���⹤�ռ۸�
  FUNCTION f_get_craft_price(p_process_name_pt   VARCHAR2,
                             p_craft_unit_price  NUMBER,
                             p_craft_consumption NUMBER,
                             p_washing_percent   NUMBER) RETURN NUMBER;
  --���㹤�ս��
  PROCEDURE p_cal_craft_price_total_amount(p_quotation_id VARCHAR2);

  --У�����⹤��
  PROCEDURE p_check_special_craft_quotation(p_speci_rec plm.special_craft_quotation%ROWTYPE);

  FUNCTION f_query_special_craft_quotation(p_quotation_id VARCHAR2)
    RETURN CLOB;

  PROCEDURE p_insert_special_craft_quotation(p_speci_rec plm.special_craft_quotation%ROWTYPE);
  PROCEDURE p_update_special_craft_quotation(p_speci_rec plm.special_craft_quotation%ROWTYPE);
  --���±�ע
  PROCEDURE p_update_special_craft_quotation_remark(p_speci_rec plm.special_craft_quotation%ROWTYPE);
  PROCEDURE p_delete_special_craft_quotation(p_company_id VARCHAR2,
                                             p_user_id    VARCHAR2,
                                             p_speci_rec  plm.special_craft_quotation%ROWTYPE);

  --��װ���˷�
  --Ь�ɱ�����
  --Ь��ѡ�� pick
  FUNCTION f_get_shoe_cost_configuration_pick(p_quotation_id              VARCHAR2,
                                              p_shoe_craft_category       VARCHAR2,
                                              p_shoe_packing_type         VARCHAR2,
                                              p_shoe_packing_number       VARCHAR2,
                                              p_shoe_transportation_route VARCHAR2)
    RETURN CLOB;
  FUNCTION f_query_shoes_fee(p_quotation_id VARCHAR2) RETURN CLOB;
  PROCEDURE p_insert_shoes_fee(p_shoes_rec plm.shoes_fee%ROWTYPE);
  PROCEDURE p_insert_shoes_fee_all(p_shoe_rec plm.shoes_fee%ROWTYPE);
  PROCEDURE p_update_shoes_fee(p_shoes_rec plm.shoes_fee%ROWTYPE,
                               p_type      INT);

  --���㹤����
  PROCEDURE p_cal_working_procedure_total_amount(p_quotation_id VARCHAR2);
  --������������
  PROCEDURE p_cal_others_total_amount(p_quotation_id VARCHAR2, p_type INT);
  --������ϸ
  --��������
  PROCEDURE p_insert_material_detail_quotation(p_material_rec plm.material_detail_quotation%ROWTYPE);

  --���ݱ��۵�ID �����µı��۵�
  PROCEDURE p_generate_copy_new_quotation(p_quotation_id VARCHAR2,
                                          p_user_id      VARCHAR2);

  --�����˼۵�
  PROCEDURE p_insert_examine_price(p_exprice_rec plm.examine_price%ROWTYPE);
  --���⹤�պ˼���Ϣ
  PROCEDURE p_insert_special_craft_examine_price(p_special_craft special_craft_examine_price%ROWTYPE);
  --���ɺ˼۵�
  PROCEDURE p_generate_examine_price(p_company_id   VARCHAR2,
                                     p_quotation_id VARCHAR2,
                                     p_user_id      VARCHAR2);

  --ͨ��ƽ̨Ψһ����ȡ��Ӧ����ҵID
  FUNCTION f_get_sup_company_id_by_uqid(p_company_id VARCHAR2,
                                        p_uq_id      VARCHAR2)
    RETURN VARCHAR2;

  --��������
  PROCEDURE p_insert_plm_file(p_plm_f_rec plm.plm_file%ROWTYPE);
  --���¸���
  PROCEDURE p_update_plm_file(p_plm_f_rec plm.plm_file%ROWTYPE);
  --ɾ������
  PROCEDURE p_delete_plm_file(p_plm_f_rec plm.plm_file%ROWTYPE);
  /*  --���±��۵�����
  PROCEDURE p_update_quotation_file(p_quotation_id VARCHAR2,
                                    p_file_type    INT,
                                    p_file_blob    BLOB,
                                    p_file_name    VARCHAR2,
                                    p_file_md5     VARCHAR2);*/

  --�������ϲ��˼�����
  PROCEDURE p_insert_fabric_depart_examine_price_job(p_fabric_rec mrp.fabric_depart_examine_price_job%ROWTYPE);

  --�������ϲ�������ϸ�˼���Ϣ
  PROCEDURE p_insert_fabric_material_detail_examine_price(p_fabric_material_rec mrp.fabric_material_detail_examine_price%ROWTYPE);
END pkg_quotation;
/
CREATE OR REPLACE PACKAGE BODY pkg_quotation IS
  --У��
  PROCEDURE p_check_quotation(p_company_id VARCHAR2,
                              p_quota_rec  plm.quotation%ROWTYPE) IS
    v_err_msg VARCHAR2(2000);
    v_str     VARCHAR2(2000);
  BEGIN
    --������У��
    IF p_quota_rec.item_no IS NULL THEN
      v_str := '�����(��)��';
    END IF;
    IF p_quota_rec.quotation_classification IS NULL THEN
      v_str := v_str || '�����۷��ࡱ';
    END IF;
    IF p_quota_rec.color IS NULL THEN
      v_str := v_str || '����ɫ(��)��';
    END IF;
    v_err_msg := '������' || v_str || 'δ��;';
  
    IF v_str IS NOT NULL THEN
      raise_application_error(-20002, v_err_msg);
    END IF;
    --ֽ�����У��
    p_check_bag_paper(p_company_id      => p_company_id,
                      p_quotation_class => p_quota_rec.quotation_classification,
                      p_bag_paper       => p_quota_rec.bag_paper_lattice_number);
  
  END p_check_quotation;
  --ֽ�����У��
  PROCEDURE p_check_bag_paper(p_company_id      VARCHAR2,
                              p_quotation_class VARCHAR2,
                              p_bag_paper       VARCHAR2) IS
    v_quotation_class_code VARCHAR2(256);
  BEGIN
    v_quotation_class_code := f_get_quotation_class_by_id(p_company_id               => p_company_id,
                                                          p_quotation_classification => p_quotation_class,
                                                          p_out_type                 => 2,
                                                          p_is_name                  => 0);
    IF v_quotation_class_code IN
       ('PLM_READY_PRICE_CLASSIFICATION00010002',
        'PLM_READY_PRICE_CLASSIFICATION00010004') THEN
      IF p_bag_paper IS NULL THEN
        raise_application_error(-20002,
                                '�������۷���-�������ࡿ=�а�/Ů��ʱ��ֽ���������!');
      END IF;
    ELSE
      NULL;
    END IF;
  END p_check_bag_paper;
  --���۵�
  --��ȡ���۷���ĩ�� lookup(ƴ��)
  FUNCTION f_get_quotation_class_lookup(p_company_id VARCHAR2,
                                        p_val        VARCHAR2,
                                        p_desc       VARCHAR2) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[SELECT v.quotation_classification_n1 || '/' ||
           v.quotation_classification_n2 || '/' ||
           v.quotation_classification_n3 ]' || p_desc ||
             q'[ ,
           v.quotation_classification_v3 ]' || p_val || q'[
      FROM (SELECT a.company_dict_name quotation_classification_n1,
                   b.company_dict_name quotation_classification_n2,
                   nvl2(d.company_dict_name,
                        c.company_dict_name || '/' || d.company_dict_name,
                        c.company_dict_name) quotation_classification_n3,
                   nvl(d.company_dict_id, c.company_dict_id) quotation_classification_v3
              FROM scmdata.sys_company_dict a
             INNER JOIN scmdata.sys_company_dict b
                ON b.company_dict_type = a.company_dict_value
               AND b.company_id = a.company_id
             INNER JOIN scmdata.sys_company_dict c
                ON c.company_dict_type = b.company_dict_value
               AND c.company_id = b.company_id
              LEFT JOIN scmdata.sys_company_dict d
                ON d.company_dict_type = c.company_dict_value
               AND d.company_id = c.company_id
             WHERE a.company_dict_type = 'PLM_READY_PRICE_CLASSIFICATION'
             AND a.company_id = ']' || p_company_id ||
             q'[') v]';
    RETURN v_sql;
  END f_get_quotation_class_lookup;

  --���ݱ��۷���㼶 ��ȡ��Ӧ���۷���lookup
  FUNCTION f_get_quotation_class_lookup_by_out_type(p_company_id VARCHAR2,
                                                    p_val        VARCHAR2,
                                                    p_desc       VARCHAR2,
                                                    p_out_type   INT)
    RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[SELECT ]' || CASE
               WHEN p_out_type = 1 THEN
                'v.quotation_classification_v1 ' || p_val ||
                ',v.quotation_classification_n1 ' || p_desc
               WHEN p_out_type = 2 THEN
                'v.quotation_classification_v2 ' || p_val ||
                ',v.quotation_classification_n2 ' || p_desc
               WHEN p_out_type = 3 THEN
                'v.quotation_classification_v3 ' || p_val ||
                ',v.quotation_classification_n3 ' || p_desc
               WHEN p_out_type = 4 THEN
                'v.quotation_classification_v4 ' || p_val ||
                ',v.quotation_classification_n4 ' || p_desc
               ELSE
                'NULL'
             END || q'[
      FROM (SELECT a.company_dict_name quotation_classification_n1,
                   b.company_dict_name quotation_classification_n2,
                   c.company_dict_name quotation_classification_n3,
                   d.company_dict_name quotation_classification_n4,
                   a.company_dict_value quotation_classification_v1,
                   b.company_dict_value quotation_classification_v2,
                   c.company_dict_value quotation_classification_v3,
                   d.company_dict_value quotation_classification_v4
              FROM scmdata.sys_company_dict a
             INNER JOIN scmdata.sys_company_dict b
                ON b.company_dict_type = a.company_dict_value
               AND b.company_id = a.company_id
             INNER JOIN scmdata.sys_company_dict c
                ON c.company_dict_type = b.company_dict_value
               AND c.company_id = b.company_id
              LEFT JOIN scmdata.sys_company_dict d
                ON d.company_dict_type = c.company_dict_value
               AND d.company_id = c.company_id
             WHERE a.company_dict_type = 'PLM_READY_PRICE_CLASSIFICATION'
             AND a.company_id = ']' || p_company_id || q'[') v]';
  
    RETURN v_sql;
  END f_get_quotation_class_lookup_by_out_type;

  --����ĩ������ ��ȡ���۷���
  FUNCTION f_get_quotation_class_by_id(p_company_id               VARCHAR2,
                                       p_quotation_classification VARCHAR2,
                                       p_out_type                 INT DEFAULT 1,
                                       p_is_name                  INT DEFAULT 0)
    RETURN VARCHAR2 IS
    v_sql  CLOB;
    vo_val VARCHAR2(256);
  BEGIN
    v_sql := q'[SELECT MAX(]' || CASE
               WHEN p_out_type = 1 THEN
                (CASE
                  WHEN p_is_name = 0 THEN
                   'quotation_classification_v1'
                  ELSE
                   'quotation_classification_n1'
                END)
               WHEN p_out_type = 2 THEN
                (CASE
                  WHEN p_is_name = 0 THEN
                   'quotation_classification_v2'
                  ELSE
                   'quotation_classification_n2'
                END)
               WHEN p_out_type = 3 THEN
                (CASE
                  WHEN p_is_name = 0 THEN
                   'quotation_classification_v3'
                  ELSE
                   'quotation_classification_n3'
                END)
               WHEN p_out_type = 4 THEN
                (CASE
                  WHEN p_is_name = 0 THEN
                   'quotation_classification_v4'
                  ELSE
                   'quotation_classification_n4'
                END)
               ELSE
                'NULL'
             END || q'[)
      FROM (SELECT a.company_dict_value quotation_classification_v1,
                   a.company_dict_name quotation_classification_n1,
                   b.company_dict_value quotation_classification_v2,
                   b.company_dict_name quotation_classification_n2,
                   c.company_dict_value quotation_classification_v3,
                   c.company_dict_name quotation_classification_n3,
                   d.company_dict_value quotation_classification_v4,
                   d.company_dict_name quotation_classification_n4,
                   nvl(d.company_dict_id, c.company_dict_id) quotation_classification_m3
              FROM scmdata.sys_company_dict a
             INNER JOIN scmdata.sys_company_dict b
                ON b.company_dict_type = a.company_dict_value
               AND b.company_id = a.company_id
             INNER JOIN scmdata.sys_company_dict c
                ON c.company_dict_type = b.company_dict_value
               AND c.company_id = b.company_id
              LEFT JOIN scmdata.sys_company_dict d
                ON d.company_dict_type = c.company_dict_value
               AND d.company_id = c.company_id
             WHERE a.company_dict_type = 'PLM_READY_PRICE_CLASSIFICATION'
               AND a.company_id = :company_id) v
     WHERE v.quotation_classification_m3 = :quotation_classification]';
  
    EXECUTE IMMEDIATE v_sql
      INTO vo_val
      USING p_company_id, p_quotation_classification;
    RETURN vo_val;
  END f_get_quotation_class_by_id;

  --�������Ϸ���ĩ����ȡ���Ϸ������ƣ�ƴ�ӣ�
  FUNCTION f_get_material_class_look_up(p_company_id VARCHAR2,
                                        p_val        VARCHAR2,
                                        p_desc       VARCHAR2) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[SELECT nvl(t4.company_dict_id, t3.company_dict_id) ]' ||
             p_val || q'[,
           (t1.company_dict_name || '/' || t2.company_dict_name || '/' ||
           t3.company_dict_name || (CASE
             WHEN t4.company_dict_name IS NOT NULL THEN
              '/' || t4.company_dict_name
             ELSE
              NULL
           END)) ]' || p_desc || q'[
      FROM scmdata.sys_company_dict t1
     INNER JOIN scmdata.sys_company_dict t2
        ON t1.company_id = t2.company_id
       AND t1.company_dict_type = 'MRP_MATERIAL_CLASSIFICATION'
       AND t2.company_dict_type = t1.company_dict_value
     INNER JOIN scmdata.sys_company_dict t3
        ON t2.company_id = t3.company_id
       AND t3.company_dict_type = t2.company_dict_value
       AND t3.pause = 0
      LEFT JOIN scmdata.sys_company_dict t4
        ON t3.company_id = t4.company_id
       AND t4.company_dict_type = t3.company_dict_value
       AND t4.pause = 0
      WHERE t1.company_id = ']' || p_company_id || q'[']';
    RETURN v_sql;
  END f_get_material_class_look_up;

  --���۵���ѯ
  FUNCTION f_query_quotation(p_company_id     VARCHAR2,
                             p_sup_company_id VARCHAR2,
                             p_item_id        VARCHAR2 DEFAULT NULL)
    RETURN CLOB IS
    v_sql       CLOB;
    v_where_sql CLOB;
    v_order_sql VARCHAR2(256);
  BEGIN
    v_sql := q'[SELECT t.quotation_status,
       t.quotation_id,
       --fa.file_blob  PICTURE,
       fa.file_unique  style_picture_name,
       '������ϸ' quotation_details,
       t.item_no,
       t.sanfu_article_no,
       va.quotation_classification_n,
       t.quotation_classification,
       t.color color_qt,
       t.bag_paper_lattice_number,
        --��Ь��ŮЬ
       (CASE
         WHEN va.quotation_classification_v2 IN
              ('PLM_READY_PRICE_CLASSIFICATION00010001',
               'PLM_READY_PRICE_CLASSIFICATION00010003') THEN
             nvl(t.material_amount,0) + nvl(t.consumables_amount,0) + 
             nvl(t.craft_amount,0) + nvl(t.working_procedure_amount,0) + 
             nvl(t.other_amount,0) + nvl(t.affreightment_amount,0) 
         ELSE
             nvl(t.material_amount,0) + nvl(t.consumables_amount,0) + 
             nvl(t.craft_amount,0) + nvl(t.working_procedure_amount,0) + 
             nvl(t.other_amount,0)
       END) quotation_total,
       (SELECT COUNT(1)
         FROM plm.quotation a
       WHERE a.quotation_id <> t.quotation_id
          AND a.item_no = t.item_no
          AND a.quotation_source = '��Ӧ�̱���') same_quotation_num,
       ep.call_back_remark,
       t.whether_add_color_quotation,
       t.whether_sanfu_fabric,
       t.quotation_source,
       t.create_time,
       t.update_time submit_time
  FROM plm.quotation t
  LEFT JOIN plm.examine_price ep
    ON ep.relate_quotation_id = t.quotation_id
  LEFT JOIN (SELECT v.quotation_classification_n1 || '/' ||
                    v.quotation_classification_n2 || '/' ||
                    v.quotation_classification_n3 quotation_classification_n,
                    v.quotation_classification_v3,
                    v.quotation_classification_v2
               FROM (SELECT a.company_dict_name quotation_classification_n1,
                            b.company_dict_value quotation_classification_v2,
                            b.company_dict_name quotation_classification_n2,
                            nvl2(d.company_dict_name,
                                 c.company_dict_name || '/' ||
                                 d.company_dict_name,
                                 c.company_dict_name) quotation_classification_n3,
                            nvl(d.company_dict_id, c.company_dict_id) quotation_classification_v3
                       FROM scmdata.sys_company_dict a
                      INNER JOIN scmdata.sys_company_dict b
                         ON b.company_dict_type = a.company_dict_value
                        AND b.company_id = a.company_id
                      INNER JOIN scmdata.sys_company_dict c
                         ON c.company_dict_type = b.company_dict_value
                        AND c.company_id = b.company_id
                       LEFT JOIN scmdata.sys_company_dict d
                         ON d.company_dict_type = c.company_dict_value
                        AND d.company_id = c.company_id
                      WHERE a.company_dict_type =
                            'PLM_READY_PRICE_CLASSIFICATION'
                        AND a.company_id = ']' || p_company_id ||
             q'[') v) va
    ON va.quotation_classification_v3 = t.quotation_classification
    LEFT JOIN plm.plm_file fa
    ON fa.thirdpart_id = t.quotation_id
   AND fa.file_type = 1
 WHERE t.platform_unique_key IN
       (SELECT sp.supplier_info_id
          FROM scmdata.t_supplier_info sp
         WHERE sp.company_id = ']' || p_company_id ||
             q'[' 
        AND sp.supplier_company_id = ']' || p_sup_company_id ||
             q'[' AND sp.pause IN (0,2) )  AND t.quotation_source = '��Ӧ�̱���' ]';
  
    IF p_item_id = 'a_quotation_110' THEN
      v_where_sql := ' AND t.quotation_status IN (0, 4)';
      v_order_sql := ' ORDER BY t.create_time desc';
    ELSIF p_item_id = 'a_quotation_210' THEN
      v_where_sql := ' AND t.quotation_status IN (1,2,3)';
      v_order_sql := ' ORDER BY t.update_time desc';
    ELSIF p_item_id = 'a_quotation_310' THEN
      v_where_sql := ' AND t.quotation_status IN (5)';
      v_order_sql := ' ORDER BY t.create_time desc';
    ELSE
      NULL;
    END IF;
    v_sql := v_sql || v_where_sql || v_order_sql;
    RETURN v_sql;
  END f_query_quotation;
  --ͬ��۵���Ϣ
  FUNCTION f_query_same_quotation(p_quotation_id VARCHAR2) RETURN CLOB IS
    v_sql     CLOB;
    v_item_no VARCHAR2(90);
  BEGIN
  
    SELECT MAX(t.item_no)
      INTO v_item_no
      FROM plm.quotation t
     WHERE t.quotation_id = p_quotation_id;
  
    v_sql := q'[SELECT t.color color_qt,t.quotation_id FROM plm.quotation t WHERE t.quotation_id <> ']' ||
             p_quotation_id || q'[' AND t.item_no = ']' || v_item_no ||
             q'[']';
  
    RETURN v_sql;
  END f_query_same_quotation;

  --ͨ�����۵�id��ѯ���۵�
  FUNCTION f_query_quotation_by_id(p_quotation_id    VARCHAR2,
                                   p_type            INT,
                                   p_company_id      VARCHAR2 DEFAULT NULL,
                                   p_quotation_class VARCHAR2 DEFAULT NULL)
    RETURN CLOB IS
    v_sql                  CLOB;
    v_quotation_class_code VARCHAR2(256);
    v_where                CLOB;
  BEGIN
    v_where := q'[ WHERE t.quotation_id = ']' || p_quotation_id ||
               q'[' AND t.quotation_source = '��Ӧ�̱���']';
  
    v_quotation_class_code := f_get_quotation_class_by_id(p_company_id               => p_company_id,
                                                          p_quotation_classification => p_quotation_class,
                                                          p_out_type                 => 2,
                                                          p_is_name                  => 0);
    --���۵�
    IF p_type = 0 THEN
      v_sql := q'[SELECT t.quotation_status,
       t.quotation_id,
       t.item_no,
       t.sanfu_article_no,
       va.quotation_classification_n,
       t.quotation_classification,]' || --��Ь��ŮЬ
               CASE
                 WHEN v_quotation_class_code IN
                      ('PLM_READY_PRICE_CLASSIFICATION00010001',
                       'PLM_READY_PRICE_CLASSIFICATION00010003') THEN
                  'nvl(t.material_amount,0) + nvl(t.consumables_amount,0) + 
                   nvl(t.craft_amount,0) + nvl(t.working_procedure_amount,0) + 
                   nvl(t.other_amount,0) + nvl(t.affreightment_amount,0) quotation_total,'
                 ELSE
                  'nvl(t.material_amount,0) + nvl(t.consumables_amount,0) + 
                   nvl(t.craft_amount,0) + nvl(t.working_procedure_amount,0) + 
                   nvl(t.other_amount,0) quotation_total,'
               END || q'[
       t.color color_qt,       
       t.consumables_quotation_remark,
       t.bag_paper_lattice_number,
       t.material_amount,
       t.consumables_amount, 
       t.craft_amount,  
       t.working_procedure_amount, 
       t.other_amount, ]' || --��Ь��ŮЬ
               CASE
                 WHEN v_quotation_class_code IN
                      ('PLM_READY_PRICE_CLASSIFICATION00010001',
                       'PLM_READY_PRICE_CLASSIFICATION00010003') THEN
                  't.affreightment_amount,'
                 ELSE
                  NULL
               END || q'[ 
       t.whether_add_color_quotation,
       ep.call_back_remark,
       t.whether_sanfu_fabric
  FROM plm.quotation t
  LEFT JOIN plm.examine_price ep
    ON ep.relate_quotation_id = t.quotation_id
  LEFT JOIN (SELECT v.quotation_classification_n1 || '/' ||
                    v.quotation_classification_n2 || '/' ||
                    v.quotation_classification_n3 quotation_classification_n,
                    v.quotation_classification_v3
               FROM (SELECT a.company_dict_name quotation_classification_n1,
                            b.company_dict_name quotation_classification_n2,
                            nvl2(d.company_dict_name,
                                 c.company_dict_name || '/' ||
                                 d.company_dict_name,
                                 c.company_dict_name) quotation_classification_n3,
                            nvl(d.company_dict_id, c.company_dict_id) quotation_classification_v3
                       FROM scmdata.sys_company_dict a
                      INNER JOIN scmdata.sys_company_dict b
                         ON b.company_dict_type = a.company_dict_value
                        AND b.company_id = a.company_id
                      INNER JOIN scmdata.sys_company_dict c
                         ON c.company_dict_type = b.company_dict_value
                        AND c.company_id = b.company_id
                       LEFT JOIN scmdata.sys_company_dict d
                         ON d.company_dict_type = c.company_dict_value
                        AND d.company_id = c.company_id
                      WHERE a.company_dict_type =
                            'PLM_READY_PRICE_CLASSIFICATION'
                        AND a.company_id = ']' || p_company_id ||
               q'[') v) va
    ON va.quotation_classification_v3 = t.quotation_classification]';
      --��������
    ELSIF p_type = 1 THEN
      --��Ь��ŮЬ
      IF v_quotation_class_code IN
         ('PLM_READY_PRICE_CLASSIFICATION00010001',
          'PLM_READY_PRICE_CLASSIFICATION00010003') THEN
        v_sql := q'[SELECT t.crop_salary,
                           t.skiving_salary,
                           t.forming_salary,
                           t.working_procedure_machining_total working_procedure_machining_total_n,
                           t.working_procedure_machining_remark
                  FROM plm.quotation t]';
      ELSE
        v_sql := q'[SELECT t.working_procedure_machining_total,
                           t.working_procedure_machining_remark
                       FROM plm.quotation t]';
      END IF;
      --��������
    ELSIF p_type = 2 THEN
      --��Ь��ŮЬ
      IF v_quotation_class_code IN
         ('PLM_READY_PRICE_CLASSIFICATION00010001',
          'PLM_READY_PRICE_CLASSIFICATION00010003') THEN
        v_sql := q'[SELECT t.processing_profit ,t.management_expense ,t.development_fee ,
                           t.euipment_depreciation, t.rent_and_utilities  
                    FROM plm.quotation t]';
        --�а���Ů��
      ELSIF v_quotation_class_code IN
            ('PLM_READY_PRICE_CLASSIFICATION00010002',
             'PLM_READY_PRICE_CLASSIFICATION00010004') THEN
        v_sql := q'[SELECT t.freight freight_ot,t.management_expense,t.processing_profit FROM plm.quotation t]';
      ELSE
        v_sql := q'[SELECT t.freight freight_ot,t.design_fee,t.processing_profit  FROM plm.quotation t]';
      END IF;
      --����
    ELSIF p_type = 3 THEN
      --v_sql := q'[SELECT t.style_picture style_picture_fj,t.pattern_file,t.marker_file FROM plm.quotation t]';
      v_sql := q'[
      SELECT to_blob(null)   style_picture_fj,
       to_blob(null)   pattern_file,
       to_blob(null)   marker_file,
       fa.file_unique    style_picture_name,
       fb.file_unique    pattern_file_name,
       fc.file_unique    marker_file_name    
  FROM plm.quotation t
 LEFT JOIN plm.plm_file fa
    ON fa.thirdpart_id = t.quotation_id
   AND fa.file_type = 1
 LEFT JOIN plm.plm_file fb
    ON fb.thirdpart_id = t.quotation_id
   AND fb.file_type = 2
 LEFT JOIN plm.plm_file fc
    ON fc.thirdpart_id = t.quotation_id
   AND fc.file_type = 3]';
    ELSE
      NULL;
    END IF;
    IF v_sql IS NOT NULL THEN
      v_sql := v_sql || v_where;
    END IF;
    RETURN v_sql;
  END f_query_quotation_by_id;
  --�������۵�
  PROCEDURE p_insert_quotation(p_quota_rec plm.quotation%ROWTYPE) IS
  BEGIN
  
    INSERT INTO quotation
      (quotation_id, quotation_status, cancel_reason, create_time,
       create_id, update_time, update_id, cooperation_mode, quotation_source,
       whether_sanfu_fabric, whether_add_color_quotation,
       related_colored_quotation, quotation_total, material_amount,
       consumables_amount, craft_amount, working_procedure_amount,
       other_amount, affreightment_amount, platform_unique_key, item_no,
       color, sanfu_article_no, quotation_classification,
       paper_quotation_picture, style_picture, pattern_file, marker_file,
       consumables_quotation_classification, consumables_combination_no,
       consumables_combination_name, consumables_total_amount,
       consumables_quotation_remark, working_procedure_machining_total,
       crop_salary, skiving_salary, forming_salary,
       working_procedure_machining_remark, bag_paper_lattice_number,
       management_expense, development_fee, euipment_depreciation,
       rent_and_utilities, processing_profit, freight, design_fee,
       whether_del)
    VALUES
      (p_quota_rec.quotation_id, p_quota_rec.quotation_status,
       p_quota_rec.cancel_reason, p_quota_rec.create_time,
       p_quota_rec.create_id, p_quota_rec.update_time, p_quota_rec.update_id,
       p_quota_rec.cooperation_mode, p_quota_rec.quotation_source,
       p_quota_rec.whether_sanfu_fabric,
       p_quota_rec.whether_add_color_quotation,
       p_quota_rec.related_colored_quotation, p_quota_rec.quotation_total,
       p_quota_rec.material_amount, p_quota_rec.consumables_amount,
       p_quota_rec.craft_amount, p_quota_rec.working_procedure_amount,
       p_quota_rec.other_amount, p_quota_rec.affreightment_amount,
       p_quota_rec.platform_unique_key, p_quota_rec.item_no,
       p_quota_rec.color, p_quota_rec.sanfu_article_no,
       p_quota_rec.quotation_classification,
       p_quota_rec.paper_quotation_picture, p_quota_rec.style_picture,
       p_quota_rec.pattern_file, p_quota_rec.marker_file,
       p_quota_rec.consumables_quotation_classification,
       p_quota_rec.consumables_combination_no,
       p_quota_rec.consumables_combination_name,
       p_quota_rec.consumables_total_amount,
       p_quota_rec.consumables_quotation_remark,
       p_quota_rec.working_procedure_machining_total,
       p_quota_rec.crop_salary, p_quota_rec.skiving_salary,
       p_quota_rec.forming_salary,
       p_quota_rec.working_procedure_machining_remark,
       p_quota_rec.bag_paper_lattice_number, p_quota_rec.management_expense,
       p_quota_rec.development_fee, p_quota_rec.euipment_depreciation,
       p_quota_rec.rent_and_utilities, p_quota_rec.processing_profit,
       p_quota_rec.freight, p_quota_rec.design_fee, 0);
  END p_insert_quotation;
  --�޸ı��۵�
  PROCEDURE p_update_quotation(p_quota_rec       plm.quotation%ROWTYPE,
                               p_type            INT,
                               p_company_id      VARCHAR2 DEFAULT NULL,
                               p_quotation_class VARCHAR2 DEFAULT NULL) IS
    v_quotation_class_code VARCHAR2(256);
    vo_err_msg             CLOB;
  BEGIN
    --0.���۵�
    IF p_type = 0 THEN
      --�ж��Ƿ��ɫ
      --��
      IF p_quota_rec.whether_add_color_quotation = 0 THEN
        --�жϱ��۵�״̬�Ƿ��Ѵ��
        --��
        IF p_quota_rec.quotation_status = 4 THEN
          UPDATE quotation t
             SET t.color                        = p_quota_rec.color,
                 t.consumables_quotation_remark = p_quota_rec.consumables_quotation_remark,
                 t.update_time                  = p_quota_rec.update_time,
                 t.update_id                    = p_quota_rec.update_id
           WHERE t.quotation_id = p_quota_rec.quotation_id;
          --��
        ELSE
          UPDATE quotation t
             SET t.item_no                      = p_quota_rec.item_no,
                 t.color                        = p_quota_rec.color,
                 t.sanfu_article_no             = p_quota_rec.sanfu_article_no,
                 t.bag_paper_lattice_number     = p_quota_rec.bag_paper_lattice_number,
                 t.consumables_quotation_remark = p_quota_rec.consumables_quotation_remark,
                 t.update_time                  = p_quota_rec.update_time,
                 t.update_id                    = p_quota_rec.update_id
           WHERE t.quotation_id = p_quota_rec.quotation_id;
        END IF;
      ELSIF p_quota_rec.whether_add_color_quotation = 1 THEN
        UPDATE quotation t
           SET t.color                        = p_quota_rec.color,
               t.consumables_quotation_remark = p_quota_rec.consumables_quotation_remark,
               t.update_time                  = p_quota_rec.update_time,
               t.update_id                    = p_quota_rec.update_id
         WHERE t.quotation_id = p_quota_rec.quotation_id;
      ELSE
        NULL;
      END IF;
      --1.�Ĳ�������ϸ
    ELSIF p_type = 1 THEN
      UPDATE quotation t
         SET t.consumables_quotation_classification = p_quota_rec.consumables_quotation_classification,
             t.consumables_combination_no           = p_quota_rec.consumables_combination_no,
             t.consumables_combination_name         = p_quota_rec.consumables_combination_name,
             t.consumables_total_amount             = p_quota_rec.consumables_amount,
             t.consumables_amount                   = p_quota_rec.consumables_amount,
             t.consumables_quotation_remark         = p_quota_rec.consumables_quotation_remark,
             t.update_time                          = p_quota_rec.update_time,
             t.update_id                            = p_quota_rec.update_id
       WHERE t.quotation_id = p_quota_rec.quotation_id;
      --1.1.�޸ı��۵�-�ĲĽ��
      pkg_quotation.p_cal_consumables_detail_total_amount(p_quotation_id => p_quota_rec.quotation_id);
      --2.��������
    ELSIF p_type = 2 THEN
      --�жϱ��۵�״̬�Ƿ��Ѵ��
      --��
      IF p_quota_rec.quotation_status = 4 OR
         p_quota_rec.whether_add_color_quotation = 1 THEN
        UPDATE quotation t
           SET t.working_procedure_machining_remark = p_quota_rec.working_procedure_machining_remark,
               t.update_time                        = p_quota_rec.update_time,
               t.update_id                          = p_quota_rec.update_id
         WHERE t.quotation_id = p_quota_rec.quotation_id;
        --��
      ELSE
        v_quotation_class_code := f_get_quotation_class_by_id(p_company_id               => p_company_id,
                                                              p_quotation_classification => p_quotation_class,
                                                              p_out_type                 => 2,
                                                              p_is_name                  => 0);
        --2.1 ��Ь��ŮЬ
        IF v_quotation_class_code IN
           ('PLM_READY_PRICE_CLASSIFICATION00010001',
            'PLM_READY_PRICE_CLASSIFICATION00010003') THEN
          --У������
          p_check_working_procedure(p_qt_rec       => p_quota_rec,
                                    p_type         => 0,
                                    p_out_err_type => 1,
                                    po_error_msg   => vo_err_msg);
        
          IF vo_err_msg IS NOT NULL THEN
            raise_application_error(-20002, vo_err_msg);
          END IF;
        
          UPDATE quotation t
             SET t.crop_salary                        = p_quota_rec.crop_salary,
                 t.skiving_salary                     = p_quota_rec.skiving_salary,
                 t.forming_salary                     = p_quota_rec.forming_salary,
                 t.working_procedure_machining_total  = p_quota_rec.working_procedure_machining_total,
                 t.working_procedure_machining_remark = p_quota_rec.working_procedure_machining_remark,
                 t.update_time                        = p_quota_rec.update_time,
                 t.update_id                          = p_quota_rec.update_id
           WHERE t.quotation_id = p_quota_rec.quotation_id;
          --2.2 �а���Ů��������
        ELSE
          --У������
          p_check_working_procedure(p_qt_rec       => p_quota_rec,
                                    p_type         => 1,
                                    p_out_err_type => 1,
                                    po_error_msg   => vo_err_msg);
        
          IF vo_err_msg IS NOT NULL THEN
            raise_application_error(-20002, vo_err_msg);
          END IF;
          UPDATE quotation t
             SET t.working_procedure_machining_total  = p_quota_rec.working_procedure_machining_total,
                 t.working_procedure_machining_remark = p_quota_rec.working_procedure_machining_remark,
                 t.update_time                        = p_quota_rec.update_time,
                 t.update_id                          = p_quota_rec.update_id
           WHERE t.quotation_id = p_quota_rec.quotation_id;
        END IF;
        --�޸ı��۵�-������
        pkg_quotation.p_cal_working_procedure_total_amount(p_quotation_id => p_quota_rec.quotation_id);
      END IF;
      --3.��������
    ELSIF p_type = 3 THEN
      v_quotation_class_code := f_get_quotation_class_by_id(p_company_id               => p_company_id,
                                                            p_quotation_classification => p_quotation_class,
                                                            p_out_type                 => 2,
                                                            p_is_name                  => 0);
      IF p_quota_rec.whether_add_color_quotation = 1 THEN
        --��Ь��ŮЬ ��������
        IF v_quotation_class_code IN
           ('PLM_READY_PRICE_CLASSIFICATION00010001',
            'PLM_READY_PRICE_CLASSIFICATION00010003') THEN
          NULL;
        ELSE
          UPDATE quotation t
             SET t.processing_profit = p_quota_rec.processing_profit,
                 t.update_time       = p_quota_rec.update_time,
                 t.update_id         = p_quota_rec.update_id
           WHERE t.quotation_id = p_quota_rec.quotation_id;
        END IF;
      ELSE
        IF p_quota_rec.quotation_status = 4 THEN
          --��Ь��ŮЬ ��������
          IF v_quotation_class_code IN
             ('PLM_READY_PRICE_CLASSIFICATION00010001',
              'PLM_READY_PRICE_CLASSIFICATION00010003') THEN
            NULL;
          ELSE
            UPDATE quotation t
               SET t.processing_profit = p_quota_rec.processing_profit,
                   t.update_time       = p_quota_rec.update_time,
                   t.update_id         = p_quota_rec.update_id
             WHERE t.quotation_id = p_quota_rec.quotation_id;
          END IF;
        ELSE
          --3.1 ��Ь��ŮЬ
          IF v_quotation_class_code IN
             ('PLM_READY_PRICE_CLASSIFICATION00010001',
              'PLM_READY_PRICE_CLASSIFICATION00010003') THEN
          
            --У������
            p_check_other_fees(p_qt_rec       => p_quota_rec,
                               p_type         => 0,
                               p_out_err_type => 1,
                               po_error_msg   => vo_err_msg);
            IF vo_err_msg IS NOT NULL THEN
              raise_application_error(-20002, vo_err_msg);
            END IF;
          
            UPDATE quotation t
               SET t.processing_profit     = p_quota_rec.processing_profit,
                   t.management_expense    = p_quota_rec.management_expense,
                   t.development_fee       = p_quota_rec.development_fee,
                   t.euipment_depreciation = p_quota_rec.euipment_depreciation,
                   t.rent_and_utilities    = p_quota_rec.rent_and_utilities,
                   t.update_time           = p_quota_rec.update_time,
                   t.update_id             = p_quota_rec.update_id
             WHERE t.quotation_id = p_quota_rec.quotation_id;
            --�޸ı��۵�-��������
            pkg_quotation.p_cal_others_total_amount(p_quotation_id => p_quota_rec.quotation_id,
                                                    p_type         => 0);
            --3.2 �а���Ů��
          ELSIF v_quotation_class_code IN
                ('PLM_READY_PRICE_CLASSIFICATION00010002',
                 'PLM_READY_PRICE_CLASSIFICATION00010004') THEN
            --У������
            p_check_other_fees(p_qt_rec       => p_quota_rec,
                               p_type         => 1,
                               p_out_err_type => 1,
                               po_error_msg   => vo_err_msg);
            IF vo_err_msg IS NOT NULL THEN
              raise_application_error(-20002, vo_err_msg);
            END IF;
            UPDATE quotation t
               SET t.freight            = p_quota_rec.freight,
                   t.management_expense = p_quota_rec.management_expense,
                   t.processing_profit  = p_quota_rec.processing_profit,
                   t.update_time        = p_quota_rec.update_time,
                   t.update_id          = p_quota_rec.update_id
             WHERE t.quotation_id = p_quota_rec.quotation_id;
            --�޸ı��۵�-��������
            pkg_quotation.p_cal_others_total_amount(p_quotation_id => p_quota_rec.quotation_id,
                                                    p_type         => 1);
            --3.3 ����
          ELSE
            --У������
            p_check_other_fees(p_qt_rec       => p_quota_rec,
                               p_type         => 2,
                               p_out_err_type => 1,
                               po_error_msg   => vo_err_msg);
            IF vo_err_msg IS NOT NULL THEN
              raise_application_error(-20002, vo_err_msg);
            END IF;
          
            UPDATE quotation t
               SET t.freight           = p_quota_rec.freight,
                   t.design_fee        = p_quota_rec.design_fee,
                   t.processing_profit = p_quota_rec.processing_profit,
                   t.update_time       = p_quota_rec.update_time,
                   t.update_id         = p_quota_rec.update_id
             WHERE t.quotation_id = p_quota_rec.quotation_id;
            --�޸ı��۵�-��������
            pkg_quotation.p_cal_others_total_amount(p_quotation_id => p_quota_rec.quotation_id,
                                                    p_type         => 2);
          END IF;
        END IF;
      END IF;
      --4.����
    ELSIF p_type = 4 THEN
      UPDATE quotation t
         SET t.style_picture = p_quota_rec.style_picture,
             t.pattern_file  = p_quota_rec.pattern_file,
             t.marker_file   = p_quota_rec.marker_file,
             t.update_time   = p_quota_rec.update_time,
             t.update_id     = p_quota_rec.update_id
       WHERE t.quotation_id = p_quota_rec.quotation_id;
      --У������
      /*    p_check_files(p_qt_rec       => p_quota_rec,
                          p_out_err_type => 1,
                          po_error_msg   => vo_err_msg);
            IF vo_err_msg IS NOT NULL THEN
              raise_application_error(-20002, vo_err_msg);
            END IF;
      */
    
    ELSE
      NULL;
    END IF;
  END p_update_quotation;

  --У����������
  PROCEDURE p_check_working_procedure(p_qt_rec       plm.quotation%ROWTYPE,
                                      p_type         INT,
                                      p_out_err_type INT DEFAULT 0,
                                      po_error_msg   OUT CLOB) IS
    v_str     VARCHAR2(2000);
    v_err_msg CLOB;
  BEGIN
    --��Ь��ŮЬ
    IF p_type = 0 THEN
      IF p_qt_rec.crop_salary IS NULL OR p_qt_rec.skiving_salary IS NULL OR
         p_qt_rec.forming_salary IS NULL THEN
        IF p_qt_rec.crop_salary IS NULL THEN
          v_str := ' ���öϹ��ʡ� ';
        END IF;
        IF p_qt_rec.skiving_salary IS NULL THEN
          v_str := v_str || ' ���복���ʡ� ';
        END IF;
        IF p_qt_rec.forming_salary IS NULL THEN
          v_str := v_str || ' �����͹��ʡ� ';
        END IF;
        IF v_str IS NOT NULL THEN
          IF p_out_err_type = 0 THEN
            v_err_msg := '����������TABҳ,������' || v_str || 'δ��;';
          ELSE
            v_err_msg := '������' || v_str || 'δ��;';
          END IF;
        END IF;
      END IF;
      --�а���Ů��������
    ELSIF p_type = 1 THEN
      IF p_qt_rec.working_procedure_machining_total IS NULL THEN
        IF p_out_err_type = 0 THEN
          v_err_msg := '����������TABҳ,������ ������ӹ��ܱ��ۡ� δ��;';
        ELSE
          v_err_msg := '������ ������ӹ��ܱ��ۡ� δ��;';
        END IF;
      END IF;
    ELSE
      NULL;
    END IF;
    po_error_msg := v_err_msg;
  END p_check_working_procedure;

  --У����������
  PROCEDURE p_check_other_fees(p_qt_rec       plm.quotation%ROWTYPE,
                               p_type         INT,
                               p_out_err_type INT DEFAULT 0,
                               po_error_msg   OUT CLOB) IS
    v_str     VARCHAR2(2000);
    v_err_msg CLOB;
  BEGIN
    --��Ь��ŮЬ
    IF p_type = 0 THEN
      IF p_qt_rec.processing_profit IS NULL OR
         p_qt_rec.management_expense IS NULL OR
         p_qt_rec.development_fee IS NULL OR
         p_qt_rec.euipment_depreciation IS NULL OR
         p_qt_rec.rent_and_utilities IS NULL THEN
        IF p_qt_rec.processing_profit IS NULL THEN
          v_str := ' ���ӹ����� ';
        END IF;
        IF p_qt_rec.management_expense IS NULL THEN
          v_str := v_str || ' ������ѡ� ';
        END IF;
        IF p_qt_rec.development_fee IS NULL THEN
          v_str := v_str || ' ���������á� ';
        END IF;
        IF p_qt_rec.euipment_depreciation IS NULL THEN
          v_str := v_str || ' ����ģ/�ͷ��/��ˮ/�豸�۾ɡ� ';
        END IF;
        IF p_qt_rec.rent_and_utilities IS NULL THEN
          v_str := v_str || ' ������/ˮ�硰 ';
        END IF;
      END IF;
      --�а���Ů��
    ELSIF p_type = 1 THEN
      IF p_qt_rec.freight IS NULL OR p_qt_rec.design_fee IS NULL OR
         p_qt_rec.processing_profit IS NULL THEN
        IF p_qt_rec.freight IS NULL THEN
          v_str := ' ���˷ѡ� ';
        END IF;
        IF p_qt_rec.management_expense IS NULL THEN
          v_str := v_str || ' ������ѡ� ';
        END IF;
        IF p_qt_rec.processing_profit IS NULL THEN
          v_str := v_str || ' ���ӹ����� ';
        END IF;
      END IF;
      --����
    ELSIF p_type = 2 THEN
      IF p_qt_rec.freight IS NULL OR p_qt_rec.design_fee IS NULL OR
         p_qt_rec.processing_profit IS NULL THEN
        IF p_qt_rec.freight IS NULL THEN
          v_str := ' ���˷ѡ� ';
        END IF;
        IF p_qt_rec.design_fee IS NULL THEN
          v_str := v_str || ' ����Ʒѡ� ';
        END IF;
        IF p_qt_rec.processing_profit IS NULL THEN
          v_str := v_str || ' ���ӹ����� ';
        END IF;
      END IF;
    ELSE
      NULL;
    END IF;
    IF v_str IS NOT NULL THEN
      IF p_out_err_type = 0 THEN
        v_err_msg := '���������á�TABҳ,������' || v_str || 'δ��;';
      ELSE
        v_err_msg := '������' || v_str || 'δ��;';
      END IF;
    END IF;
    po_error_msg := v_err_msg;
  END p_check_other_fees;
  --У�鸽��
  PROCEDURE p_check_files(p_qt_rec       plm.quotation%ROWTYPE,
                          p_out_err_type INT DEFAULT 0,
                          po_error_msg   OUT CLOB) IS
    v_err_msg     CLOB;
    v_file_unique VARCHAR2(32);
  BEGIN
    SELECT MAX(t.file_unique)
      INTO v_file_unique
      FROM plm.plm_file t
     WHERE t.thirdpart_id = p_qt_rec.style_picture
       AND t.file_type = 1;
    IF v_file_unique IS NULL THEN
      IF p_out_err_type = 0 THEN
        v_err_msg := '��������TABҳ,������ ����ʽͼƬ�� δ��;';
      ELSE
        v_err_msg := '������ ����ʽͼƬ�� δ��;';
      END IF;
    END IF;
    po_error_msg := v_err_msg;
  END p_check_files;

  --�ύ���۵�У�� 
  PROCEDURE p_check_quotation_by_submit(p_company_id   VARCHAR2,
                                        p_quotation_id VARCHAR2,
                                        p_out_err_msg  OUT CLOB) IS
    p_qt_rec                 plm.quotation%ROWTYPE;
    p_shoe_rec               plm.shoes_fee%ROWTYPE;
    v_quotation_class_code   VARCHAR2(256);
    v_str                    VARCHAR2(2000);
    v_err_msg                CLOB;
    v_work_procedure_err_msg CLOB;
    v_other_fees_err_msg     CLOB;
    v_files_err_msg          CLOB;
    v_flag                   INT;
  BEGIN
    --�����������У�� 
    --��ȡ���۵������Ϣ
    SELECT t.*
      INTO p_qt_rec
      FROM plm.quotation t
     WHERE t.quotation_id = p_quotation_id;
    --0.�Ĳ���ϸ
    SELECT COUNT(1)
      INTO v_flag
      FROM plm.consumables_consumption_detail t
     WHERE t.quotation_id = p_quotation_id;
  
    IF v_flag = 0 THEN
      v_err_msg := '���Ĳ�������ϸ��TABҳ,��������Ϣ,�����;';
    END IF;
  
    --��ȡ���۷������
    v_quotation_class_code := f_get_quotation_class_by_id(p_company_id               => p_company_id,
                                                          p_quotation_classification => p_qt_rec.quotation_classification,
                                                          p_out_type                 => 2,
                                                          p_is_name                  => 0);
  
    --1.��Ь��ŮЬ
    IF v_quotation_class_code IN
       ('PLM_READY_PRICE_CLASSIFICATION00010001',
        'PLM_READY_PRICE_CLASSIFICATION00010003') THEN
      --1.1 ��������
      p_check_working_procedure(p_qt_rec     => p_qt_rec,
                                p_type       => 0,
                                po_error_msg => v_work_procedure_err_msg);
    
      v_err_msg := v_err_msg || v_work_procedure_err_msg;
    
      --1.2 ��װ�Ѽ��˷�
      SELECT t.*
        INTO p_shoe_rec
        FROM plm.shoes_fee t
       WHERE t.quotation_id = p_quotation_id;
    
      IF p_shoe_rec.shoe_packing_type = '1def0fcc33ce4d3ba56848deb779c927' THEN
        IF p_shoe_rec.shoe_box_amount IS NULL THEN
          v_str := ' ��Ь��װ-�� ';
        END IF;
      ELSIF p_shoe_rec.shoe_packing_type =
            '9025227ad3d745e5a2eb9e916c248094' THEN
        IF p_shoe_rec.egg_lattice_amount IS NULL THEN
          v_str := ' ������װ-�� ';
        END IF;
      ELSE
        NULL;
      END IF;
      IF p_shoe_rec.outer_box_amount IS NULL OR p_shoe_rec.freight IS NULL THEN
        IF p_shoe_rec.outer_box_amount IS NULL THEN
          v_str := v_str || ' ������-�� ';
        END IF;
        IF p_shoe_rec.freight IS NULL THEN
          v_str := v_str || ' ���˷�-�� ';
        END IF;
      END IF;
    
      IF v_str IS NOT NULL THEN
        v_err_msg := v_err_msg || '����װ�Ѽ��˷ѡ�TABҳ,������' || v_str || 'δ��;';
      END IF;
    
      --1.3 ��������
      p_check_other_fees(p_qt_rec       => p_qt_rec,
                         p_type         => 0,
                         p_out_err_type => 0,
                         po_error_msg   => v_other_fees_err_msg);
    
      v_err_msg := v_err_msg || v_other_fees_err_msg;
    
      --2.�а���Ů��
    ELSIF v_quotation_class_code IN
          ('PLM_READY_PRICE_CLASSIFICATION00010002',
           'PLM_READY_PRICE_CLASSIFICATION00010004') THEN
      --2.1 ��������
      p_check_working_procedure(p_qt_rec     => p_qt_rec,
                                p_type       => 1,
                                po_error_msg => v_work_procedure_err_msg);
      v_err_msg := v_err_msg || v_work_procedure_err_msg;
      --2.2 ��������
      p_check_other_fees(p_qt_rec       => p_qt_rec,
                         p_type         => 1,
                         p_out_err_type => 0,
                         po_error_msg   => v_other_fees_err_msg);
      v_err_msg := v_err_msg || v_other_fees_err_msg;
      --3.����
    ELSE
      --3.1 ��������
      p_check_working_procedure(p_qt_rec     => p_qt_rec,
                                p_type       => 1,
                                po_error_msg => v_work_procedure_err_msg);
      v_err_msg := v_err_msg || v_work_procedure_err_msg;
      --3.2 ��������
      p_check_other_fees(p_qt_rec       => p_qt_rec,
                         p_type         => 2,
                         p_out_err_type => 0,
                         po_error_msg   => v_other_fees_err_msg);
      v_err_msg := v_err_msg || v_other_fees_err_msg;
    END IF;
    --4. ����
    p_check_files(p_qt_rec       => p_qt_rec,
                  p_out_err_type => 0,
                  po_error_msg   => v_files_err_msg);
    v_err_msg := v_err_msg || v_files_err_msg;
  
    p_out_err_msg := v_err_msg;
  END p_check_quotation_by_submit;

  --�ύ���۵�
  PROCEDURE p_submit_quotation(p_company_id   VARCHAR2,
                               p_quotation_id VARCHAR2,
                               p_user_id      VARCHAR2) IS
    v_status            INT;
    vo_material_err_msg CLOB;
    vo_other_err_msg    CLOB;
    vo_err_msg          CLOB;
  BEGIN
    --1.����У��
    --1.1 ������ϸ
    plm.pkg_outside_material.p_submit_material_detail(v_quoid    => p_quotation_id,
                                                      po_err_msg => vo_material_err_msg);
  
    --1.2 ��������
    p_check_quotation_by_submit(p_company_id   => p_company_id,
                                p_quotation_id => p_quotation_id,
                                p_out_err_msg  => vo_other_err_msg);
  
    vo_err_msg := vo_material_err_msg || vo_other_err_msg;
    IF vo_err_msg IS NOT NULL THEN
      raise_application_error(-20002,
                              '�����ύ�����������ݺ��ٽ��в�����' || vo_err_msg);
    END IF;
  
    --2.�ύУ�� ���۵�״̬
    SELECT t.quotation_status
      INTO v_status
      FROM quotation t
     WHERE t.quotation_id = p_quotation_id;
  
    --��״̬���Ƿ�����Ѵ��
    IF v_status = 4 THEN
      --��
      --�ɱ��۵�״̬��Ϊ����ȡ����
      UPDATE quotation t
         SET t.quotation_status = 5,
             t.quotation_total = (CASE
                                   WHEN t.quotation_classification IN
                                        ('PLM_READY_PRICE_CLASSIFICATION00010001',
                                         'PLM_READY_PRICE_CLASSIFICATION00010003') THEN
                                    t.material_amount + t.consumables_amount +
                                    t.craft_amount +
                                    t.working_procedure_amount +
                                    t.other_amount + t.affreightment_amount
                                   ELSE
                                    t.material_amount + t.consumables_amount +
                                    t.craft_amount +
                                    t.working_procedure_amount +
                                    t.other_amount
                                 END),
             t.cancel_reason    = '������ύ',
             t.update_id        = p_user_id,
             t.update_time      = SYSDATE
       WHERE t.quotation_id = p_quotation_id;
      --�����µı��۵�
      p_generate_copy_new_quotation(p_quotation_id => p_quotation_id,
                                    p_user_id      => p_user_id);
    ELSE
      --��
      --�޸ı��۵�Ϊ���ύ
      UPDATE quotation t
         SET t.quotation_status = 1,
             t.quotation_total = (CASE
                                   WHEN t.quotation_classification IN
                                        ('PLM_READY_PRICE_CLASSIFICATION00010001',
                                         'PLM_READY_PRICE_CLASSIFICATION00010003') THEN
                                    nvl(t.material_amount, 0) +
                                    nvl(t.consumables_amount, 0) +
                                    nvl(t.craft_amount, 0) +
                                    nvl(t.working_procedure_amount, 0) +
                                    nvl(t.other_amount, 0) +
                                    nvl(t.affreightment_amount, 0)
                                   ELSE
                                    nvl(t.material_amount, 0) +
                                    nvl(t.consumables_amount, 0) +
                                    nvl(t.craft_amount, 0) +
                                    nvl(t.working_procedure_amount, 0) +
                                    nvl(t.other_amount, 0)
                                 END),
             t.update_id        = p_user_id,
             t.update_time      = SYSDATE
       WHERE t.quotation_id = p_quotation_id;
      --4.���ɺ˼۵�
      p_generate_examine_price(p_company_id   => p_company_id,
                               p_quotation_id => p_quotation_id,
                               p_user_id      => p_user_id);
    END IF;
  
  END p_submit_quotation;

  --ȡ�����۵�
  PROCEDURE p_cancel_quotation(p_quotation_id VARCHAR2, p_user_id VARCHAR2) IS
  BEGIN
    UPDATE quotation t
       SET t.quotation_status = 5,
           t.cancel_reason    = '��Ӧ��ȡ��',
           t.update_id        = p_user_id,
           t.update_time      = SYSDATE
     WHERE t.quotation_id = p_quotation_id;
  END p_cancel_quotation;

  --��ȡ״̬lookup
  FUNCTION f_get_quotation_lookup RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[
    SELECT 0 quotation_status, 'δ�ύ' quotation_status_desc
      FROM dual
    UNION ALL
    SELECT 1 quotation_status, '���˼�' quotation_status_desc
      FROM dual
    UNION ALL
    SELECT 2 quotation_status, '�˼���' quotation_status_desc
      FROM dual
    UNION ALL
    SELECT 3 quotation_status, '�����' quotation_status_desc
      FROM dual
    UNION ALL
    SELECT 4 quotation_status, '�Ѵ��' quotation_status_desc
      FROM dual
    UNION ALL
    SELECT 5 quotation_status, '��ȡ��' quotation_status_desc
      FROM dual]';
    RETURN v_sql;
  END f_get_quotation_lookup;

  --ͨ�����۷���У��Ĳ�BOM���Ƿ��кĲ���ϸ
  FUNCTION f_check_is_exist_material_details(p_quotation_classification VARCHAR2)
    RETURN INT IS
    v_flag INT;
  BEGIN
    SELECT COUNT(1)
      INTO v_flag
      FROM plm.relate_quotation_classification_mapping rq
     INNER JOIN plm.consumable_bom cb
        ON cb.consumable_combination_id = rq.thirdpart_id
       AND cb.consumable_status = 1
     INNER JOIN plm.consumable_bom_details cbd
        ON cbd.consumable_combination_id = cb.consumable_combination_id
     WHERE rq.quotation_classification_id = p_quotation_classification
       AND rq.relate_type = 1;
    RETURN v_flag;
  END f_check_is_exist_material_details;

  --ͨ�����۷����ȡ�Ĳ�BOM���кĲ���ϸ
  PROCEDURE p_get_bom_material_details(p_quotation_classification   IN VARCHAR2,
                                       po_consumable_combination_id OUT VARCHAR2,
                                       po_consumable_name           OUT VARCHAR2) IS
    v_consumable_combination_id VARCHAR2(256);
    v_consumable_name           VARCHAR2(256);
  BEGIN
    SELECT MAX(cbd.consumable_combination_id), MAX(cbd.consumable_name)
      INTO v_consumable_combination_id, v_consumable_name
      FROM plm.relate_quotation_classification_mapping rq
     INNER JOIN plm.consumable_bom cb
        ON cb.consumable_combination_id = rq.thirdpart_id
     INNER JOIN plm.consumable_bom_details cbd
        ON cbd.consumable_combination_id = cb.consumable_combination_id
     WHERE rq.quotation_classification_id = p_quotation_classification
       AND rq.relate_type = 1;
  
    po_consumable_combination_id := v_consumable_combination_id;
    po_consumable_name           := v_consumable_name;
  
  END p_get_bom_material_details;

  --ͨ������sku��ȡmrpȷ����Ӧ�̱�źͼ��
  PROCEDURE p_get_mrp_internal_sup_info(p_material_sku IN VARCHAR2,
                                        po_sup_code    OUT VARCHAR2) IS
    v_sup_code VARCHAR2(32);
  BEGIN
    SELECT MAX(t.supplier_code)
      INTO v_sup_code
      FROM mrp.mrp_internal_supplier_material t
     WHERE t.material_sku = p_material_sku
       AND t.optimization = 1;
    po_sup_code := v_sup_code;
  END p_get_mrp_internal_sup_info;
  --ѡ��Ӧ��picklist
  FUNCTION p_get_mrp_internal_sup_info_pick(p_material_sku IN VARCHAR2)
    RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[SELECT * FROM (SELECT * FROM (SELECT ms.material_sku consumables_material_sku,
       sa.supplier_code mrp_supplier_code,
       pc.url material_picture,
       spu.material_name material_name_cd,
       spu.material_classification,
       spu.material_specifications,
       sa.supplier_abbreviation,
       ms.supplier_material_name, 
       sa.business_contact,
       sa.contact_phone    contact_phone_cd,
       sa.detailed_address detailed_address_qt,
       pc.upload_time
  FROM mrp.mrp_internal_supplier_material ms
 INNER JOIN mrp.mrp_determine_supplier_archives sa
    ON sa.supplier_code = ms.supplier_code
  LEFT JOIN mrp.mrp_internal_material_sku sku
    ON ms.material_sku = sku.material_sku
  LEFT JOIN mrp.mrp_internal_material_spu spu
    ON sku.material_spu = spu.material_spu
  LEFT JOIN mrp.mrp_picture pc
    ON pc.thirdpart_id = spu.material_spu
  AND pc.picture_type = 1
 WHERE ms.material_sku =  ']' || p_material_sku ||
             q'[')v 
  ORDER BY v.upload_time DESC)
 WHERE ROWNUM = 1]';
    RETURN v_sql;
  END p_get_mrp_internal_sup_info_pick;

  --�Ĳ���ϸ
  --����ĲĽ��
  PROCEDURE p_cal_consumables_detail_total_amount(p_quotation_id VARCHAR2) IS
    v_total_price NUMBER;
  BEGIN
    SELECT SUM(t.suggested_purchase__price)
      INTO v_total_price
      FROM plm.consumables_consumption_detail t
     WHERE t.quotation_id = p_quotation_id;
  
    UPDATE plm.quotation t
       SET t.consumables_amount       = v_total_price,
           t.consumables_total_amount = v_total_price
     WHERE t.quotation_id = p_quotation_id;
  
  END p_cal_consumables_detail_total_amount;

  --У��Ĳ�������ϸ
  PROCEDURE p_check_consumables_consumption_detail(p_consu_rec plm.consumables_consumption_detail%ROWTYPE,
                                                   p_type      INT) IS
    v_str VARCHAR2(1000);
  BEGIN
    IF p_type = 0 THEN
      IF p_consu_rec.consumables_material_supplier_code IS NULL THEN
        raise_application_error(-20002, '������ ��ѡ��Ӧ�̡� δ��');
      END IF;
    ELSIF p_type = 1 THEN
      --����������������ɹ����ۡ�
      IF p_consu_rec.consumables_material_consumption IS NULL THEN
        v_str := ' �������� ';
      END IF;
      IF p_consu_rec.suggested_purchase_unit_price IS NULL THEN
        v_str := v_str || ' ������ɹ����ۡ� ';
      END IF;
      IF v_str IS NOT NULL THEN
        raise_application_error(-20002, '������' || v_str || 'δ��');
      END IF;
    ELSE
      NULL;
    END IF;
  END p_check_consumables_consumption_detail;

  FUNCTION f_query_consumables_consumption_detail(p_quotation_id              VARCHAR2,
                                                  p_is_exist_material_details INT)
    RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[SELECT t.consumables_name_id,
       qt.quotation_classification   material_quotation_class,
       t.consumables_material_name,
       t.consumables_material_source,
       t.consumables_material_consumption,
       t.consumables_material_unit,
       t.suggested_purchase_unit_price,
       t.suggested_purchase__price
       ]' || CASE
               WHEN p_is_exist_material_details = 1 THEN
                ',
       pc.file_unique         material_pic,
       t.consumables_material_sku,
       sa.supplier_abbreviation,
       t.consumables_material_supplier_code mrp_supplier_code,
       spu.material_name material_name_cd,
       spu.material_classification,
       spu.material_specifications,
       ms.supplier_material_name, 
       sa.business_contact,
       sa.contact_phone contact_phone_cd,
       sa.detailed_address detailed_address_qt'
               ELSE
                NULL
             END || q'[
  FROM plm.consumables_consumption_detail t
  LEFT JOIN plm.quotation qt 
    ON qt.quotation_id = t.quotation_id   
  LEFT JOIN mrp.mrp_internal_supplier_material ms
    ON ms.supplier_code = t.consumables_material_supplier_code
   AND ms.material_sku = t.consumables_material_sku
  LEFT JOIN mrp.mrp_internal_material_sku sku
    ON ms.material_sku = sku.material_sku
  LEFT JOIN mrp.mrp_internal_material_spu spu
    ON sku.material_spu = spu.material_spu
  LEFT JOIN mrp.mrp_determine_supplier_archives sa
    ON sa.supplier_code = ms.supplier_code
  LEFT JOIN (SELECT mp.thirdpart_id, MAX(mp.file_unique) file_unique 
               FROM mrp.mrp_picture mp
             GROUP BY mp.thirdpart_id
             ORDER BY mp.upload_time) pc
    ON pc.thirdpart_id = spu.material_spu  
  WHERE t.quotation_id  = ']' || p_quotation_id || q'['
  ORDER BY t.create_time DESC]';
    RETURN v_sql;
  END f_query_consumables_consumption_detail;

  PROCEDURE p_insert_consumables_consumption_detail(p_consu_rec plm.consumables_consumption_detail%ROWTYPE) IS
    v_num INT;
  BEGIN
    --���
    SELECT nvl(MAX(t.consumables_material_no), 0) + 1
      INTO v_num
      FROM plm.consumables_consumption_detail t
     WHERE t.quotation_id = p_consu_rec.quotation_id;
  
    INSERT INTO consumables_consumption_detail
      (consumables_name_id, consumables_material_no,
       consumables_material_name, consumables_material_source,
       consumables_material_consumption, consumables_material_unit,
       suggested_purchase_unit_price, consumables_material_sku,
       consumables_material_supplier_code, suggested_purchase__price,
       quotation_id, whether_del, create_time, create_id, update_time,
       update_id)
    VALUES
      (p_consu_rec.consumables_name_id, v_num,
       p_consu_rec.consumables_material_name,
       p_consu_rec.consumables_material_source,
       p_consu_rec.consumables_material_consumption,
       p_consu_rec.consumables_material_unit,
       p_consu_rec.suggested_purchase_unit_price,
       p_consu_rec.consumables_material_sku,
       p_consu_rec.consumables_material_supplier_code,
       p_consu_rec.suggested_purchase__price, p_consu_rec.quotation_id,
       nvl(p_consu_rec.whether_del, 0), p_consu_rec.create_time,
       p_consu_rec.create_id, p_consu_rec.update_time, p_consu_rec.update_id);
  END p_insert_consumables_consumption_detail;

  PROCEDURE p_update_consumables_consumption_detail(p_consu_rec plm.consumables_consumption_detail%ROWTYPE,
                                                    p_type      INT) IS
  BEGIN
    IF p_type = 0 THEN
      UPDATE consumables_consumption_detail t
         SET t.consumables_material_supplier_code = p_consu_rec.consumables_material_supplier_code,
             t.consumables_material_sku           = p_consu_rec.consumables_material_sku,
             t.update_time                        = p_consu_rec.update_time,
             t.update_id                          = p_consu_rec.update_id
       WHERE t.consumables_name_id = p_consu_rec.consumables_name_id
         AND t.quotation_id = p_consu_rec.quotation_id;
    ELSIF p_type = 1 THEN
      UPDATE consumables_consumption_detail t
         SET t.consumables_material_no            = p_consu_rec.consumables_material_no,
             t.consumables_material_name          = p_consu_rec.consumables_material_name,
             t.consumables_material_source        = p_consu_rec.consumables_material_source,
             t.consumables_material_consumption   = p_consu_rec.consumables_material_consumption,
             t.consumables_material_unit          = p_consu_rec.consumables_material_unit,
             t.suggested_purchase_unit_price      = p_consu_rec.suggested_purchase_unit_price,
             t.consumables_material_sku           = p_consu_rec.consumables_material_sku,
             t.consumables_material_supplier_code = p_consu_rec.consumables_material_supplier_code,
             t.suggested_purchase__price          = p_consu_rec.suggested_purchase__price,
             t.whether_del                        = nvl(p_consu_rec.whether_del,
                                                        0),
             t.update_time                        = p_consu_rec.update_time,
             t.update_id                          = p_consu_rec.update_id
       WHERE t.consumables_name_id = p_consu_rec.consumables_name_id
         AND t.quotation_id = p_consu_rec.quotation_id;
    ELSE
      NULL;
    END IF;
  END p_update_consumables_consumption_detail;
  --ɾ��
  PROCEDURE p_delete_consumables_consumption_detail(p_quotation_id        VARCHAR2,
                                                    p_consumables_name_id VARCHAR2) IS
  BEGIN
    DELETE FROM plm.consumables_consumption_detail t
     WHERE t.consumables_name_id = p_consumables_name_id
       AND t.quotation_id = p_quotation_id;
  END p_delete_consumables_consumption_detail;

  --���⹤��
  --ͨ�����⹤��id��ȡ����
  FUNCTION f_get_special_craft_by_id(p_craft_classification VARCHAR2,
                                     p_type                 INT DEFAULT 0)
    RETURN VARCHAR2 IS
    v_craft_classification_desc VARCHAR2(256);
    v_process_name_pt           VARCHAR2(256);
    v_rtn_val                   VARCHAR2(256);
  BEGIN
    --��ȡ������һ����������
    SELECT MAX(va.craft_classification_desc), MAX(va.process_name_pt)
      INTO v_craft_classification_desc, v_process_name_pt
      FROM (SELECT v.process_id_pt,
                   v.process_name_pt,
                   v.process_id      craft_classification,
                   v.process_name    craft_classification_desc,
                   v.lv
              FROM (SELECT PRIOR t.process_id process_id_pt,
                           PRIOR t.process_name process_name_pt,
                           t.process_id,
                           t.process_name,
                           LEVEL lv
                      FROM plm.special_process t
                     START WITH t.parent_process_id = '0'
                    CONNECT BY PRIOR t.process_id = t.parent_process_id) v
             WHERE v.lv = 2) va
     WHERE va.craft_classification = p_craft_classification;
  
    IF p_type = 1 THEN
      v_rtn_val := v_process_name_pt;
    ELSE
      v_rtn_val := v_craft_classification_desc;
    END IF;
    RETURN v_rtn_val;
  END f_get_special_craft_by_id;
  --���⹤�շ��൯��
  FUNCTION f_get_special_craft_pick RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[SELECT v.process_id_pt,
       v.process_name_pt,
       v.process_id      craft_classification,
       v.process_name    craft_classification_desc,
       v.lv
  FROM (SELECT PRIOR t.process_id process_id_pt,
               PRIOR t.process_name process_name_pt,
               t.process_id,
               t.process_name,
               LEVEL lv,
               t.process_status 
          FROM plm.special_process t
         START WITH t.parent_process_id = '0'
        CONNECT BY PRIOR t.process_id = t.parent_process_id) v
 WHERE v.lv = 2 AND v.process_status = 1]';
    RETURN v_sql;
  END f_get_special_craft_pick;
  --ͨ�����⹤��һ������ ��ȡ���⹤�ռ۸�
  FUNCTION f_get_craft_price(p_process_name_pt   VARCHAR2,
                             p_craft_unit_price  NUMBER,
                             p_craft_consumption NUMBER,
                             p_washing_percent   NUMBER) RETURN NUMBER IS
    v_price NUMBER;
  BEGIN
  
    IF p_process_name_pt IN ('����ϴˮ', '����ϴˮ', 'ţ��ϴˮ') THEN
      v_price := (p_craft_unit_price * p_craft_consumption *
                 nvl(p_washing_percent, 100)) / 100;
    ELSE
      v_price := p_craft_unit_price * p_craft_consumption;
    END IF;
    RETURN v_price;
  
  END f_get_craft_price;

  --���㹤�ս��
  PROCEDURE p_cal_craft_price_total_amount(p_quotation_id VARCHAR2) IS
    v_total_price NUMBER;
  BEGIN
    SELECT SUM(t.craft_price)
      INTO v_total_price
      FROM plm.special_craft_quotation t
     WHERE t.quotation_id = p_quotation_id;
  
    UPDATE plm.quotation t
       SET t.craft_amount = v_total_price
     WHERE t.quotation_id = p_quotation_id;
  
  END p_cal_craft_price_total_amount;

  --У�����⹤��
  PROCEDURE p_check_special_craft_quotation(p_speci_rec plm.special_craft_quotation%ROWTYPE) IS
    v_str               VARCHAR2(1000);
    v_process_name_pt_1 VARCHAR2(256);
  BEGIN
    IF p_speci_rec.craft_classification IS NOT NULL THEN
      IF p_speci_rec.craft_unit_price IS NULL THEN
        v_str := ' �����ۡ� ';
      END IF;
      IF p_speci_rec.craft_consumption IS NULL THEN
        v_str := v_str || ' �������� ';
      END IF;
    
      SELECT MAX(va.process_name_pt)
        INTO v_process_name_pt_1
        FROM (SELECT v.process_id_pt,
                     v.process_name_pt,
                     v.process_id      craft_classification,
                     v.process_name    craft_classification_desc,
                     v.lv
                FROM (SELECT PRIOR t.process_id process_id_pt,
                             PRIOR t.process_name process_name_pt,
                             t.process_id,
                             t.process_name,
                             LEVEL lv
                        FROM plm.special_process t
                       START WITH t.parent_process_id = '0'
                      CONNECT BY PRIOR t.process_id = t.parent_process_id) v
               WHERE v.lv = 2) va
       WHERE va.craft_classification = p_speci_rec.craft_classification;
    
      IF v_process_name_pt_1 IN ('����ϴˮ', '����ϴˮ', 'ţ��ϴˮ') THEN
        IF p_speci_rec.washing_percent IS NULL THEN
          v_str := v_str || '��ϴˮ%��';
          raise_application_error(-20002,
                                  '�������⹤�ա�һ������=������ϴˮ/����ϴˮ/ţ��ϴˮ��ʱ, ' ||
                                  v_str || '����');
        END IF;
      ELSE
        IF v_str IS NOT NULL THEN
          raise_application_error(-20002,
                                  '�� �����⹤�ա� ��ֵʱ��' || v_str || '����');
        END IF;
      END IF;
    END IF;
  END p_check_special_craft_quotation;

  FUNCTION f_query_special_craft_quotation(p_quotation_id VARCHAR2)
    RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[SELECT t.quotation_special_craft_detail_id,
       t.related_colored_detail_id,
       t.quotation_special_craft_detail_no,
       sp.process_name CRAFT_CLASSIFICATION_DESC,
       t.craft_classification,
       t.craft_unit_price,
       t.craft_consumption,
       t.washing_percent,
       t.craft_price,
       t.craft_factory_name,
       t.craft_quotation_remark
  FROM special_craft_quotation t
  LEFT JOIN plm.special_process sp
    ON sp.process_id = t.craft_classification
 WHERE t.quotation_id = ']' || p_quotation_id || q'['
 ORDER BY t.create_time DESC]';
    RETURN v_sql;
  END f_query_special_craft_quotation;

  PROCEDURE p_insert_special_craft_quotation(p_speci_rec plm.special_craft_quotation%ROWTYPE) IS
  BEGIN
    INSERT INTO special_craft_quotation
      (quotation_special_craft_detail_id, related_colored_detail_id,
       quotation_special_craft_detail_no, craft_classification,
       craft_unit_price, craft_consumption, craft_price, washing_percent,
       craft_factory_name, craft_quotation_remark, quotation_id, whether_del,
       create_time, create_id, update_time, update_id)
    VALUES
      (p_speci_rec.quotation_special_craft_detail_id,
       p_speci_rec.related_colored_detail_id,
       p_speci_rec.quotation_special_craft_detail_no,
       p_speci_rec.craft_classification, p_speci_rec.craft_unit_price,
       p_speci_rec.craft_consumption, p_speci_rec.craft_price,
       p_speci_rec.washing_percent, p_speci_rec.craft_factory_name,
       p_speci_rec.craft_quotation_remark, p_speci_rec.quotation_id,
       p_speci_rec.whether_del, p_speci_rec.create_time,
       p_speci_rec.create_id, p_speci_rec.update_time, p_speci_rec.update_id);
  END p_insert_special_craft_quotation;

  PROCEDURE p_update_special_craft_quotation(p_speci_rec plm.special_craft_quotation%ROWTYPE) IS
  BEGIN
    UPDATE special_craft_quotation t
       SET t.related_colored_detail_id         = p_speci_rec.related_colored_detail_id,
           t.quotation_special_craft_detail_no = p_speci_rec.quotation_special_craft_detail_no,
           t.craft_classification              = p_speci_rec.craft_classification,
           t.craft_unit_price                  = p_speci_rec.craft_unit_price,
           t.craft_consumption                 = p_speci_rec.craft_consumption,
           t.craft_price                       = p_speci_rec.craft_price,
           t.washing_percent                   = p_speci_rec.washing_percent,
           t.craft_factory_name                = p_speci_rec.craft_factory_name,
           t.craft_quotation_remark            = p_speci_rec.craft_quotation_remark,
           t.whether_del                       = p_speci_rec.whether_del,
           t.update_time                       = p_speci_rec.update_time,
           t.update_id                         = p_speci_rec.update_id
     WHERE t.quotation_special_craft_detail_id =
           p_speci_rec.quotation_special_craft_detail_id
       AND t.quotation_id = p_speci_rec.quotation_id;
  END p_update_special_craft_quotation;

  --���±�ע
  PROCEDURE p_update_special_craft_quotation_remark(p_speci_rec plm.special_craft_quotation%ROWTYPE) IS
  BEGIN
    UPDATE special_craft_quotation t
       SET t.craft_quotation_remark = p_speci_rec.craft_quotation_remark,
           t.update_time            = p_speci_rec.update_time,
           t.update_id              = p_speci_rec.update_id
     WHERE t.quotation_special_craft_detail_id =
           p_speci_rec.quotation_special_craft_detail_id
       AND t.quotation_id = p_speci_rec.quotation_id;
  END p_update_special_craft_quotation_remark;

  PROCEDURE p_delete_special_craft_quotation(p_company_id VARCHAR2,
                                             p_user_id    VARCHAR2,
                                             p_speci_rec  plm.special_craft_quotation%ROWTYPE) IS
  BEGIN
    --��¼������־
    DECLARE
      v_old_craft_classification_name VARCHAR2(256);
      v_uq_id                         VARCHAR2(32);
      vo_log_id                       VARCHAR2(32);
      v_sup_company_id                VARCHAR2(32);
    BEGIN
      v_old_craft_classification_name := plm.pkg_quotation.f_get_special_craft_by_id(p_craft_classification => p_speci_rec.craft_classification);
    
      SELECT MAX(t.platform_unique_key)
        INTO v_uq_id
        FROM plm.quotation t
       WHERE t.quotation_id = p_speci_rec.quotation_id;
    
      v_sup_company_id := plm.pkg_quotation.f_get_sup_company_id_by_uqid(p_company_id => p_company_id,
                                                                         p_uq_id      => v_uq_id);
    
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => p_company_id,
                                             p_apply_module       => 'a_quotation_111_3',
                                             p_base_table         => 'special_craft_quotation',
                                             p_apply_pk_id        => p_speci_rec.quotation_id,
                                             p_action_type        => 'DELETE',
                                             p_log_type           => '03',
                                             p_field_desc         => 'ɾ�����⹤��',
                                             p_log_msg            => 'ɾ�����⹤�գ�' ||
                                                                     v_old_craft_classification_name,
                                             p_operate_field      => 'quotation_special_craft_detail_id',
                                             p_field_type         => 'VARCHAR',
                                             p_old_code           => NULL,
                                             p_new_code           => NULL,
                                             p_old_value          => 1,
                                             p_new_value          => 0,
                                             p_user_id            => p_user_id,
                                             p_operate_company_id => v_sup_company_id,
                                             p_seq_no             => 1,
                                             po_log_id            => vo_log_id,
                                             p_type               => 1);
    END record_plat_log;
  
    DELETE FROM special_craft_quotation t
     WHERE t.quotation_special_craft_detail_id =
           p_speci_rec.quotation_special_craft_detail_id
       AND t.quotation_id = p_speci_rec.quotation_id;
  
  END p_delete_special_craft_quotation;
  --Ь�Ӱ�װ��&�˷ѱ�����Ϣ��
  --Ь�ɱ�����
  --��װ���� pick
  /*  FUNCTION f_get_shoe_packing_number_pick(p_company_id VARCHAR2,
                                          p_dict_type  VARCHAR2) RETURN CLOB IS
  BEGIN
      SELECT * from scmdata.sys_company_dict t WHERE t.company_id =  p_company_id AND t.;
       
  END f_get_shoe_packing_number_pick;*/

  --����·�� pick
  --Ь��ѡ�� pick
  FUNCTION f_get_shoe_cost_configuration_pick(p_quotation_id              VARCHAR2,
                                              p_shoe_craft_category       VARCHAR2,
                                              p_shoe_packing_type         VARCHAR2,
                                              p_shoe_packing_number       VARCHAR2,
                                              p_shoe_transportation_route VARCHAR2)
    RETURN CLOB IS
    v_sql              CLOB;
    v_flag             INT;
    v_quotation_status INT;
  BEGIN
    SELECT MAX(t.quotation_status)
      INTO v_quotation_status
      FROM plm.quotation t
     WHERE t.quotation_id = p_quotation_id;
  
    IF p_shoe_craft_category IS NULL OR p_shoe_packing_type IS NULL THEN
      RETURN NULL;
    END IF;
    --���۵�״̬ Ϊ�Ѵ�أ����ɱ༭�ֶ�
    IF v_quotation_status = 4 THEN
      raise_application_error(-20002,
                              '��ǰ���۵�״̬Ϊ���Ѵ�ء����ֶΡ�Ь��ѡ�񡱲��ɱ༭');
    ELSE
      --��д��Ь��ѡ��ǰ��������д����װ��������������·�ߡ�
      IF p_shoe_packing_number IS NULL OR
         p_shoe_transportation_route IS NULL THEN
        raise_application_error(-20002,
                                '��д��Ь��ѡ��ǰ��������д����װ��������������·�ߡ�');
      ELSE
        SELECT COUNT(1)
          INTO v_flag
          FROM shoe_cost_configuration t
         WHERE t.process_category = p_shoe_craft_category
           AND t.pack_category = p_shoe_packing_type
           AND t.shoe_pack_count = p_shoe_packing_number
           AND t.transportation_route = p_shoe_transportation_route
           AND t.shoe_cost_status = 1;
      
        IF v_flag > 0 THEN
          v_sql := q'[SELECT t.shoe_box_material_name,
             t.shoe_box_specification shoe_box_specifications,
             t.shoe_box_material_name || '/' || t.shoe_box_specification shoe_select,]' ||
                   (CASE
                     WHEN p_shoe_packing_type = '9025227ad3d745e5a2eb9e916c248094' THEN
                      q'[t.shoe_box_unit_price egg_lattice_amount,]'
                     WHEN p_shoe_packing_type = '1def0fcc33ce4d3ba56848deb779c927' THEN
                      q'[t.shoe_box_unit_price shoe_box_amount,]'
                     ELSE
                      NULL
                   END) || q'[
             t.out_box_unit_price outer_box_amount,
             t.freight_split freight_sf,
             0 is_update_field
        FROM shoe_cost_configuration t
       WHERE t.process_category = :shoe_craft_category
         AND t.pack_category = :shoe_packing_type
         AND t.shoe_pack_count = :shoe_packing_number
         AND t.transportation_route = :shoe_transportation_route
         AND t.shoe_cost_status = 1]';
        ELSE
          v_sql := q'[SELECT DISTINCT v.shoe_box_material_name,
                v.shoe_box_specification shoe_box_specifications,
                v.shoe_select,
                v.egg_lattice_amount,
                v.shoe_box_amount,
                v.outer_box_amount,
                v.freight_sf,
                1 is_update_field
  FROM (SELECT t.shoe_box_material_name,
               t.shoe_box_specification,
               t.shoe_box_material_name || '/' || t.shoe_box_specification shoe_select,
               NULL egg_lattice_amount,
               NULL shoe_box_amount,
               NULL outer_box_amount,
               NULL freight_sf
          FROM shoe_cost_configuration t
         WHERE t.shoe_cost_status = 1) v]';
        END IF;
      END IF;
    END IF;
    RETURN v_sql;
  END f_get_shoe_cost_configuration_pick;

  FUNCTION f_query_shoes_fee(p_quotation_id VARCHAR2) RETURN CLOB IS
    v_sql  CLOB;
    v_type INT;
  BEGIN
  
    SELECT MAX(CASE
                 WHEN t.shoe_packing_type = '9025227ad3d745e5a2eb9e916c248094' THEN
                  0 --����
                 WHEN t.shoe_packing_type = '1def0fcc33ce4d3ba56848deb779c927' THEN
                  1 --Ь��
                 ELSE
                  NULL
               END)
      INTO v_type
      FROM shoes_fee t
     WHERE t.quotation_id = p_quotation_id;
  
    v_sql := q'[SELECT t.shoe_fee_id,
       t.shoe_craft_category,
       t.shoe_packing_type,
       t.shoe_packing_number,
       t.shoe_transportation_route,
       t.shoe_box_material_name,
       t.shoe_box_specifications,
       t.shoe_box_material_name || t.shoe_box_specifications   shoe_select,]' || CASE
             --����װ
               WHEN v_type = 0 THEN
                't.egg_lattice_amount,'
             --Ь��װ
               WHEN v_type = 1 THEN
                't.shoe_box_amount,'
               ELSE
                NULL
             END || q'[
       t.outer_box_amount,
       t.freight freight_sf,
       t.shoe_box_quotation_remark,
       t.is_update_field
   FROM shoes_fee t 
  WHERE t.quotation_id = ']' || p_quotation_id || q'['
  ORDER BY t.create_time DESC]';
    RETURN v_sql;
  END f_query_shoes_fee;

  PROCEDURE p_insert_shoes_fee(p_shoes_rec plm.shoes_fee%ROWTYPE) IS
  BEGIN
    INSERT INTO shoes_fee
      (shoe_fee_id, shoe_craft_category, shoe_packing_type,
       shoe_packing_number, shoe_transportation_route,
       shoe_box_material_name, shoe_box_specifications, quotation_id,
       whether_del, create_time, create_id, update_time, update_id,
       is_update_field)
    VALUES
      (p_shoes_rec.shoe_fee_id, p_shoes_rec.shoe_craft_category,
       p_shoes_rec.shoe_packing_type, p_shoes_rec.shoe_packing_number,
       p_shoes_rec.shoe_transportation_route,
       p_shoes_rec.shoe_box_material_name,
       p_shoes_rec.shoe_box_specifications, p_shoes_rec.quotation_id,
       p_shoes_rec.whether_del, p_shoes_rec.create_time,
       p_shoes_rec.create_id, p_shoes_rec.update_time, p_shoes_rec.update_id,
       p_shoes_rec.is_update_field);
  END p_insert_shoes_fee;

  PROCEDURE p_insert_shoes_fee_all(p_shoe_rec plm.shoes_fee%ROWTYPE) IS
  BEGIN
    INSERT INTO shoes_fee
      (shoe_fee_id, shoe_craft_category, shoe_packing_type,
       shoe_packing_number, shoe_transportation_route,
       shoe_box_material_name, shoe_box_specifications, shoe_box_amount,
       shoe_box_quotation_remark, egg_lattice_amount,
       egg_lattice_quotation_remark, outer_box_amount,
       outer_box_quotation_remark, freight, freight_quotation_remark,
       quotation_id, whether_del, create_time, create_id, update_time,
       update_id, shoe_examin_epriceresult, is_update_field)
    VALUES
      (p_shoe_rec.shoe_fee_id, p_shoe_rec.shoe_craft_category,
       p_shoe_rec.shoe_packing_type, p_shoe_rec.shoe_packing_number,
       p_shoe_rec.shoe_transportation_route,
       p_shoe_rec.shoe_box_material_name, p_shoe_rec.shoe_box_specifications,
       p_shoe_rec.shoe_box_amount, p_shoe_rec.shoe_box_quotation_remark,
       p_shoe_rec.egg_lattice_amount,
       p_shoe_rec.egg_lattice_quotation_remark, p_shoe_rec.outer_box_amount,
       p_shoe_rec.outer_box_quotation_remark, p_shoe_rec.freight,
       p_shoe_rec.freight_quotation_remark, p_shoe_rec.quotation_id,
       p_shoe_rec.whether_del, p_shoe_rec.create_time, p_shoe_rec.create_id,
       p_shoe_rec.update_time, p_shoe_rec.update_id,
       p_shoe_rec.shoe_examin_epriceresult, p_shoe_rec.is_update_field);
  
  END p_insert_shoes_fee_all;

  PROCEDURE p_update_shoes_fee(p_shoes_rec plm.shoes_fee%ROWTYPE,
                               p_type      INT) IS
  BEGIN
    --���۵��Ѵ��
    IF p_type = 0 THEN
      UPDATE shoes_fee t
         SET t.shoe_box_quotation_remark = p_shoes_rec.shoe_box_quotation_remark,
             t.update_time               = p_shoes_rec.update_time,
             t.update_id                 = p_shoes_rec.update_id
       WHERE t.shoe_fee_id = p_shoes_rec.shoe_fee_id
         AND t.quotation_id = p_shoes_rec.quotation_id;
      --���۵�����״̬
    ELSIF p_type = 1 THEN
      UPDATE shoes_fee t
         SET t.shoe_packing_number       = p_shoes_rec.shoe_packing_number,
             t.shoe_transportation_route = p_shoes_rec.shoe_transportation_route,
             t.shoe_box_material_name    = p_shoes_rec.shoe_box_material_name,
             t.shoe_box_specifications   = p_shoes_rec.shoe_box_specifications,
             t.shoe_box_amount           = p_shoes_rec.shoe_box_amount,
             t.egg_lattice_amount        = p_shoes_rec.egg_lattice_amount,
             t.outer_box_amount          = p_shoes_rec.outer_box_amount,
             t.freight                   = p_shoes_rec.freight,
             t.shoe_box_quotation_remark = p_shoes_rec.shoe_box_quotation_remark,
             t.is_update_field           = p_shoes_rec.is_update_field,
             t.update_time               = p_shoes_rec.update_time,
             t.update_id                 = p_shoes_rec.update_id
       WHERE t.shoe_fee_id = p_shoes_rec.shoe_fee_id
         AND t.quotation_id = p_shoes_rec.quotation_id;
    ELSE
      NULL;
    END IF;
  
  END p_update_shoes_fee;

  --���㹤����
  PROCEDURE p_cal_working_procedure_total_amount(p_quotation_id VARCHAR2) IS
  BEGIN
    UPDATE plm.quotation t
       SET t.working_procedure_amount = t.working_procedure_machining_total
     WHERE t.quotation_id = p_quotation_id;
  END p_cal_working_procedure_total_amount;

  --������������
  PROCEDURE p_cal_others_total_amount(p_quotation_id VARCHAR2, p_type INT) IS
  BEGIN
    --Ь��
    IF p_type = 0 THEN
      UPDATE plm.quotation t
         SET t.other_amount = nvl(t.freight, 0) +
                              nvl(t.management_expense, 0) +
                              nvl(t.development_fee, 0) +
                              nvl(t.euipment_depreciation, 0) +
                              nvl(t.rent_and_utilities, 0)
       WHERE t.quotation_id = p_quotation_id;
      --����
    ELSIF p_type = 1 THEN
      UPDATE plm.quotation t
         SET t.other_amount = nvl(t.freight, 0) +
                              nvl(t.management_expense, 0) +
                              nvl(t.processing_profit, 0)
       WHERE t.quotation_id = p_quotation_id;
      --����
    ELSIF p_type = 2 THEN
      UPDATE plm.quotation t
         SET t.other_amount = nvl(t.freight, 0) + nvl(t.design_fee, 0) +
                              nvl(t.processing_profit, 0)
       WHERE t.quotation_id = p_quotation_id;
    ELSE
      NULL;
    END IF;
  END p_cal_others_total_amount;
  --������ϸ
  --��������
  PROCEDURE p_insert_material_detail_quotation(p_material_rec plm.material_detail_quotation%ROWTYPE) IS
  BEGIN
    INSERT INTO material_detail_quotation
      (material_detail_quotation_id,
       related_colored_material_detail_quotation_id,
       quotation_material_detail_no, quotation_material_type,
       quotation_application_site, whether_inner_material,
       quotation_material_sku, quotation_material_supplier_code,
       quotation_unit, quotation_unit_price,
       quotation_unit_price_consumption, quotation_loss_rate,
       quotation_amount, quotation_remark, quotation_id, whether_del,
       create_time, create_id, update_time, update_id)
    VALUES
      (p_material_rec.material_detail_quotation_id,
       p_material_rec.related_colored_material_detail_quotation_id,
       p_material_rec.quotation_material_detail_no,
       p_material_rec.quotation_material_type,
       p_material_rec.quotation_application_site,
       p_material_rec.whether_inner_material,
       p_material_rec.quotation_material_sku,
       p_material_rec.quotation_material_supplier_code,
       p_material_rec.quotation_unit, p_material_rec.quotation_unit_price,
       p_material_rec.quotation_unit_price_consumption,
       p_material_rec.quotation_loss_rate, p_material_rec.quotation_amount,
       p_material_rec.quotation_remark, p_material_rec.quotation_id,
       p_material_rec.whether_del, p_material_rec.create_time,
       p_material_rec.create_id, p_material_rec.update_time,
       p_material_rec.update_id);
  END;

  --���ݱ��۵�ID �����µı��۵�
  PROCEDURE p_generate_copy_new_quotation(p_quotation_id VARCHAR2,
                                          p_user_id      VARCHAR2) IS
    p_new_qt_rec plm.quotation%ROWTYPE;
    v_new_quoid  VARCHAR2(13);
    v_flag       INT;
  BEGIN
    IF p_quotation_id IS NOT NULL THEN
      SELECT COUNT(1)
        INTO v_flag
        FROM plm.quotation t
       WHERE t.quotation_id = p_quotation_id;
      IF v_flag > 0 THEN
        --1.���۵������۵���ϸ�����������������á�������
        SELECT *
          INTO p_new_qt_rec
          FROM plm.quotation t
         WHERE t.quotation_id = p_quotation_id;
      
        v_new_quoid := plm.pkg_plat_comm.f_get_keycode(v_table_name  => 'QUOTATION',
                                                       v_column_name => 'QUOTATION_ID',
                                                       v_pre         => 'BJ' ||
                                                                        to_char(SYSDATE,
                                                                                'YYYYMMDD'),
                                                       v_serail_num  => 3);
      
        p_new_qt_rec.quotation_id     := v_new_quoid;
        p_new_qt_rec.quotation_status := 1;
        p_new_qt_rec.create_id        := p_user_id;
        p_new_qt_rec.create_time      := SYSDATE;
        p_new_qt_rec.update_id        := p_user_id;
        p_new_qt_rec.update_time      := SYSDATE;
        p_insert_quotation(p_quota_rec => p_new_qt_rec);
      
        --2.������ϸ
        SELECT COUNT(1)
          INTO v_flag
          FROM plm.material_detail_quotation t
         WHERE t.quotation_id = p_quotation_id;
        IF v_flag > 0 THEN
          FOR material_rec IN (SELECT *
                                 FROM plm.material_detail_quotation t
                                WHERE t.quotation_id = p_quotation_id) LOOP
          
            material_rec.material_detail_quotation_id := plm.pkg_plat_comm.f_get_keycode(v_table_name  => 'MATERIAL_DETAIL_QUOTATION',
                                                                                         v_column_name => 'MATERIAL_DETAIL_QUOTATION_ID',
                                                                                         v_pre         => v_new_quoid || 'WL',
                                                                                         v_serail_num  => 2);
          
            material_rec.quotation_id := v_new_quoid;
            material_rec.create_id    := p_user_id;
            material_rec.create_time  := SYSDATE;
            material_rec.update_id    := p_user_id;
            material_rec.update_time  := SYSDATE;
            p_insert_material_detail_quotation(p_material_rec => material_rec);
          END LOOP;
        ELSE
          NULL;
        END IF;
        --3.�Ĳ�����
        SELECT COUNT(1)
          INTO v_flag
          FROM plm.consumables_consumption_detail t
         WHERE t.quotation_id = p_quotation_id;
        IF v_flag > 0 THEN
          FOR consuma_rec IN (SELECT *
                                FROM plm.consumables_consumption_detail t
                               WHERE t.quotation_id = p_quotation_id) LOOP
            consuma_rec.consumables_name_id := plm.pkg_plat_comm.f_get_keycode(v_table_name  => 'CONSUMABLES_CONSUMPTION_DETAIL',
                                                                               v_column_name => 'CONSUMABLES_NAME_ID',
                                                                               v_pre         => v_new_quoid || 'HC',
                                                                               v_serail_num  => 2);
            consuma_rec.quotation_id        := v_new_quoid;
            consuma_rec.create_id           := p_user_id;
            consuma_rec.create_time         := SYSDATE;
            consuma_rec.update_id           := p_user_id;
            consuma_rec.update_time         := SYSDATE;
            p_insert_consumables_consumption_detail(p_consu_rec => consuma_rec);
          END LOOP;
        ELSE
          NULL;
        END IF;
        --4.���⹤��
        SELECT COUNT(1)
          INTO v_flag
          FROM plm.special_craft_quotation t
         WHERE t.quotation_id = p_quotation_id;
        IF v_flag > 0 THEN
          FOR special_rec IN (SELECT *
                                FROM plm.special_craft_quotation t
                               WHERE t.quotation_id = p_quotation_id) LOOP
            special_rec.quotation_special_craft_detail_id := plm.pkg_plat_comm.f_get_keycode(v_table_name  => 'SPECIAL_CRAFT_QUOTATION',
                                                                                             v_column_name => 'QUOTATION_SPECIAL_CRAFT_DETAIL_ID',
                                                                                             v_pre         => v_new_quoid || 'GY',
                                                                                             v_serail_num  => 2);
            special_rec.quotation_id                      := v_new_quoid;
            special_rec.create_id                         := p_user_id;
            special_rec.create_time                       := SYSDATE;
            special_rec.update_id                         := p_user_id;
            special_rec.update_time                       := SYSDATE;
            p_insert_special_craft_quotation(p_speci_rec => special_rec);
          END LOOP;
        ELSE
          NULL;
        END IF;
        --5.��װ���˷�
        SELECT COUNT(1)
          INTO v_flag
          FROM plm.shoes_fee t
         WHERE t.quotation_id = p_quotation_id;
        IF v_flag > 0 THEN
          FOR shoes_rec IN (SELECT *
                              FROM plm.shoes_fee t
                             WHERE t.quotation_id = p_quotation_id) LOOP
            shoes_rec.shoe_fee_id  := v_new_quoid;
            shoes_rec.quotation_id := v_new_quoid;
            shoes_rec.create_id    := p_user_id;
            shoes_rec.create_time  := SYSDATE;
            shoes_rec.update_id    := p_user_id;
            shoes_rec.update_time  := SYSDATE;
            p_insert_shoes_fee_all(p_shoe_rec => shoes_rec);
          END LOOP;
        ELSE
          NULL;
        END IF;
      ELSE
        NULL;
      END IF;
    ELSE
      NULL;
    END IF;
  END p_generate_copy_new_quotation;
  --�˼۵�
  --�����˼۵�
  PROCEDURE p_insert_examine_price(p_exprice_rec plm.examine_price%ROWTYPE) IS
  BEGIN
    INSERT INTO examine_price
      (examine_price_id, relate_quotation_id,
       relate_add_color_examine_price_id, current_quotation,
       examine_price_status, cancel_reason, cooperation_mode,
       platform_unique_key, create_time, finish_time, matching_status,
       matching_goods_skc_code, manual_order_number, whether_special_adopt,
       whether_cancel, current_tier_price, total_amount, material_amount,
       consumables_amount, craft_amount, working_procedure_amount,
       other_amount, affreightment_amount, abnormal_cause,
       fabric_depart_examine_price_job_id,
       fabric_depart_examine_price_job_status,
       fabric_depart_examine_price_job_man,
       fabric_depart_examine_price_job_finish_time, examine_depart_job_id,
       examine_depart_job_status, examine_depart_job_man,
       examine_depart_job_finish_time,
       technology_depart_examine_price_job_id,
       technology_depart_examine_price_job_status,
       technology_depart_examine_price_job_man,
       technology_depart_examine_price_job_finish_time,
       consumables_examine_price_result,
       consumables_quotation_classification, consumables_combination_no,
       consumables_combination_name, consumables_total_amount,
       consumables_examine_price_remark,
       working_procedure_machining_examine_result,
       working_procedure_machining_examine_total, crop_salary,
       skiving_salary, forming_salary, crop_process_cost, sew_process_cost,
       standard_sewing_hours, working_procedure_machining_examine_remark,
       bag_paper_lattice_number, bag_paper_lattice_number_examine_result,
       management_expense, development_fee, euipment_depreciation,
       rent_and_utilities, processing_profit, freight, design_fee,
       management_expense_examine_result, development_fee_examine_result,
       euipment_depreciation_examine_result,
       rent_and_utilities_examine_result, processing_profit_examine_result,
       freight_examine_result, design_fee_examine_result, tier_category_code,
       tier_category_name, call_back_remark, create_id, update_time,
       update_id, whether_del, produce_process_status,
       produce_process_coefficient)
    VALUES
      (p_exprice_rec.examine_price_id, p_exprice_rec.relate_quotation_id,
       p_exprice_rec.relate_add_color_examine_price_id,
       p_exprice_rec.current_quotation, p_exprice_rec.examine_price_status,
       p_exprice_rec.cancel_reason, p_exprice_rec.cooperation_mode,
       p_exprice_rec.platform_unique_key, p_exprice_rec.create_time,
       p_exprice_rec.finish_time, p_exprice_rec.matching_status,
       p_exprice_rec.matching_goods_skc_code,
       p_exprice_rec.manual_order_number,
       p_exprice_rec.whether_special_adopt, p_exprice_rec.whether_cancel,
       p_exprice_rec.current_tier_price, p_exprice_rec.total_amount,
       p_exprice_rec.material_amount, p_exprice_rec.consumables_amount,
       p_exprice_rec.craft_amount, p_exprice_rec.working_procedure_amount,
       --0,
       --����ʾ��Ҫ��������Ĭ��Ϊ0
       p_exprice_rec.other_amount, p_exprice_rec.affreightment_amount,
       p_exprice_rec.abnormal_cause,
       p_exprice_rec.fabric_depart_examine_price_job_id,
       p_exprice_rec.fabric_depart_examine_price_job_status,
       p_exprice_rec.fabric_depart_examine_price_job_man,
       p_exprice_rec.fabric_depart_examine_price_job_finish_time,
       p_exprice_rec.examine_depart_job_id,
       p_exprice_rec.examine_depart_job_status,
       p_exprice_rec.examine_depart_job_man,
       p_exprice_rec.examine_depart_job_finish_time,
       p_exprice_rec.technology_depart_examine_price_job_id,
       p_exprice_rec.technology_depart_examine_price_job_status,
       p_exprice_rec.technology_depart_examine_price_job_man,
       p_exprice_rec.technology_depart_examine_price_job_finish_time,
       p_exprice_rec.consumables_examine_price_result,
       p_exprice_rec.consumables_quotation_classification,
       p_exprice_rec.consumables_combination_no,
       p_exprice_rec.consumables_combination_name,
       p_exprice_rec.consumables_total_amount,
       p_exprice_rec.consumables_examine_price_remark,
       p_exprice_rec.working_procedure_machining_examine_result,
       p_exprice_rec.working_procedure_machining_examine_total,
       p_exprice_rec.crop_salary, p_exprice_rec.skiving_salary,
       p_exprice_rec.forming_salary, p_exprice_rec.crop_process_cost,
       p_exprice_rec.sew_process_cost, p_exprice_rec.standard_sewing_hours,
       p_exprice_rec.working_procedure_machining_examine_remark,
       p_exprice_rec.bag_paper_lattice_number,
       p_exprice_rec.bag_paper_lattice_number_examine_result,
       p_exprice_rec.management_expense, p_exprice_rec.development_fee,
       p_exprice_rec.euipment_depreciation, p_exprice_rec.rent_and_utilities,
       p_exprice_rec.processing_profit, p_exprice_rec.freight,
       p_exprice_rec.design_fee,
       p_exprice_rec.management_expense_examine_result,
       p_exprice_rec.development_fee_examine_result,
       p_exprice_rec.euipment_depreciation_examine_result,
       p_exprice_rec.rent_and_utilities_examine_result,
       p_exprice_rec.processing_profit_examine_result,
       p_exprice_rec.freight_examine_result,
       p_exprice_rec.design_fee_examine_result,
       p_exprice_rec.tier_category_code, p_exprice_rec.tier_category_name,
       p_exprice_rec.call_back_remark, p_exprice_rec.create_id,
       p_exprice_rec.update_time, p_exprice_rec.update_id,
       p_exprice_rec.whether_del, p_exprice_rec.produce_process_status,
       p_exprice_rec.produce_process_coefficient);
  END p_insert_examine_price;

  --���⹤�պ˼���Ϣ
  PROCEDURE p_insert_special_craft_examine_price(p_special_craft special_craft_examine_price%ROWTYPE) IS
  BEGIN
    INSERT INTO special_craft_examine_price
      (examine_price_special_craft_detail_id, related_colored_detail_id,
       special_craft_detail_no, craft_classification,
       craft_classification_department, special_craft_examine_price_result,
       craft_unit, craft_unit_price, craft_consumption, craft_price,
       washing_percent, craft_factory_name, craft_examine_price_remark,
       related_colored_quotation_detail_id, examine_price_id, whether_append)
    VALUES
      (p_special_craft.examine_price_special_craft_detail_id,
       p_special_craft.related_colored_detail_id,
       p_special_craft.special_craft_detail_no,
       p_special_craft.craft_classification,
       p_special_craft.craft_classification_department,
       p_special_craft.special_craft_examine_price_result,
       p_special_craft.craft_unit, p_special_craft.craft_unit_price,
       p_special_craft.craft_consumption, p_special_craft.craft_price,
       p_special_craft.washing_percent, p_special_craft.craft_factory_name,
       p_special_craft.craft_examine_price_remark,
       p_special_craft.related_colored_quotation_detail_id,
       p_special_craft.examine_price_id, p_special_craft.whether_append);
  END p_insert_special_craft_examine_price;

  --���ɺ˼۵�
  PROCEDURE p_generate_examine_price(p_company_id   VARCHAR2,
                                     p_quotation_id VARCHAR2,
                                     p_user_id      VARCHAR2) IS
    v_exprice_id           VARCHAR2(13);
    p_qt_rec               plm.quotation%ROWTYPE;
    v_quotation_class_code VARCHAR2(256);
  BEGIN
    --��ȡ���۵������Ϣ
    SELECT t.*
      INTO p_qt_rec
      FROM plm.quotation t
     WHERE t.quotation_id = p_quotation_id;
    --��ȡ���۷������
    v_quotation_class_code := f_get_quotation_class_by_id(p_company_id               => p_company_id,
                                                          p_quotation_classification => p_qt_rec.quotation_classification,
                                                          p_out_type                 => 2,
                                                          p_is_name                  => 0);
    --���ɺ˼۵�ID
    v_exprice_id := plm.pkg_plat_comm.f_get_keycode(v_table_name  => 'EXAMINE_PRICE',
                                                    v_column_name => 'EXAMINE_PRICE_ID',
                                                    v_pre         => 'HJ' ||
                                                                     to_char(SYSDATE,
                                                                             'YYYYMMDD'),
                                                    v_serail_num  => 3);
  
    DECLARE
      v_relate_color_examine_price_id VARCHAR2(13);
      p_exprice_rec                   plm.examine_price%ROWTYPE;
      v_commodity_color_code          VARCHAR2(32);
      v_cnt                           INT;
    BEGIN
      --1.���ɺ˼۵���ϸ
      p_exprice_rec.examine_price_id    := v_exprice_id;
      p_exprice_rec.relate_quotation_id := p_quotation_id;
      --������ɫ�˼�ID
      IF p_qt_rec.related_colored_quotation IS NOT NULL THEN
        SELECT MAX(t.examine_price_id)
          INTO v_relate_color_examine_price_id
          FROM plm.examine_price t
         WHERE t.relate_quotation_id = p_qt_rec.related_colored_quotation;
      ELSE
        v_relate_color_examine_price_id := NULL;
      END IF;
    
      p_exprice_rec.relate_add_color_examine_price_id := v_relate_color_examine_price_id;
      p_exprice_rec.current_quotation                 := p_qt_rec.quotation_total;
      p_exprice_rec.examine_price_status              := 0;
      p_exprice_rec.cancel_reason                     := p_qt_rec.cancel_reason;
      p_exprice_rec.cooperation_mode                  := 'ODM';
      p_exprice_rec.platform_unique_key               := p_qt_rec.platform_unique_key;
    
      SELECT MAX(t.commodity_color_code)
        INTO v_commodity_color_code
        FROM scmdata.t_commodity_color t
       WHERE t.rela_goo_id = p_qt_rec.sanfu_article_no
         AND t.colorname = p_qt_rec.color;
    
      p_exprice_rec.matching_status := CASE
                                         WHEN v_commodity_color_code IS NOT NULL THEN
                                          1
                                         ELSE
                                          0
                                       END;
      --����ҵ������˼�ƥ��״̬��=��ƥ�䣬����������ƥ��˼۵��߼�����PRD-�ɱ�����-��ǰ����ƥ��˼۵��߼�˵�� ���߼��ݲ�����      
      p_exprice_rec.matching_goods_skc_code := v_commodity_color_code;
    
      --���ɺ˼�����ID �������£�
      --�������۷���-�������ࡿ=�а�/Ů��ʱ�����������ϲ��˼�����ID��M+�˼۵�ID�������ϲ��˼�����״̬
      --�������۷���-�������ࡿ=��Ь/ŮЬʱ�������ɼ������˼�����ID��J+�˼۵�ID�����������˼�����״̬
      --�������۷���-�������ࡿ=�а�/Ů��ʱ�������ɺ˼۲��˼�����ID��H+�˼۵�ID�����˼۲��˼�����״̬
      --���۷��� һ������ Ь��
      --��Ь��ŮЬ
      IF v_quotation_class_code IN
         ('PLM_READY_PRICE_CLASSIFICATION00010001',
          'PLM_READY_PRICE_CLASSIFICATION00010003') THEN
        --���ϲ��˼�����ID
        p_exprice_rec.fabric_depart_examine_price_job_id     := 'M' ||
                                                                v_exprice_id;
        p_exprice_rec.fabric_depart_examine_price_job_status := 0; --����ʾ��Ҫ�����ϲ��˼�����״̬Ĭ��ͨ��
        --�˼۲��˼�����ID
        p_exprice_rec.examine_depart_job_id     := 'H' || v_exprice_id;
        p_exprice_rec.examine_depart_job_status := 0;
        --�а���Ů��
      ELSIF v_quotation_class_code IN
            ('PLM_READY_PRICE_CLASSIFICATION00010002',
             'PLM_READY_PRICE_CLASSIFICATION00010004') THEN
        --�������˼�����ID
        p_exprice_rec.technology_depart_examine_price_job_id     := 'J' ||
                                                                    v_exprice_id;
        p_exprice_rec.technology_depart_examine_price_job_status := 0;
        --���۷��� һ������ ��Ů��
      ELSE
        --���ϲ��˼�����ID
        p_exprice_rec.fabric_depart_examine_price_job_id     := 'M' ||
                                                                v_exprice_id;
        p_exprice_rec.fabric_depart_examine_price_job_status := 0; --����ʾ��Ҫ�����ϲ��˼�����״̬Ĭ��ͨ��
        --�˼۲��˼�����ID
        p_exprice_rec.examine_depart_job_id     := 'H' || v_exprice_id;
        p_exprice_rec.examine_depart_job_status := 0;
        
        --�������˼�����ID �������⹤��1&2�����������⹤�տ��д��ڼ����������ɣ���������
        FOR craft_rec IN (SELECT t.craft_classification
                            FROM plm.special_craft_quotation t
                           WHERE t.quotation_id = p_quotation_id) LOOP
        
          SELECT COUNT(1)
            INTO v_cnt
            FROM plm.special_process sp
           WHERE sp.process_id = craft_rec.craft_classification
             AND sp.department = 'TECHNOLOGY_DEPART';
        
          IF v_cnt > 0 THEN       
            p_exprice_rec.technology_depart_examine_price_job_id     := 'J' ||
                                                                        v_exprice_id;
            p_exprice_rec.technology_depart_examine_price_job_status := 0;
            EXIT;
          ELSE
            CONTINUE;
          END IF;
        END LOOP;
      END IF;
    
      p_exprice_rec.create_id                   := p_user_id;
      p_exprice_rec.create_time                 := SYSDATE;
      p_exprice_rec.update_time                 := SYSDATE;
      p_exprice_rec.update_id                   := p_user_id;
      p_exprice_rec.whether_cancel              := 0;
      p_exprice_rec.whether_del                 := 0;
      p_exprice_rec.whether_special_adopt       := 0;
      p_exprice_rec.whether_examine             := 0;
      p_exprice_rec.produce_process_status      := 0;
      p_exprice_rec.produce_process_coefficient := 1.5;
      p_insert_examine_price(p_exprice_rec => p_exprice_rec);
      --�������ϵ������Ϣ 
      --�������ϲ��˼�����
      DECLARE
        p_fabric_rec mrp.fabric_depart_examine_price_job%ROWTYPE;
      BEGIN
        p_fabric_rec.examine_price_id                            := v_exprice_id;
        p_fabric_rec.relate_add_color_examine_price_id           := v_relate_color_examine_price_id;
        p_fabric_rec.fabric_depart_examine_price_job_id          := p_exprice_rec.fabric_depart_examine_price_job_id;
        p_fabric_rec.fabric_depart_examine_price_job_status      := p_exprice_rec.fabric_depart_examine_price_job_status;
        p_fabric_rec.fabric_depart_examine_price_job_man         := NULL;
        p_fabric_rec.fabric_depart_examine_price_job_finish_time := NULL;
        p_insert_fabric_depart_examine_price_job(p_fabric_rec => p_fabric_rec);
      END generate_fabric;
    END generate_exprice_details;
    --2.������ϸ
    --����������ϸ
    --�������ϲ�������ϸ�˼���Ϣ
    --�������ϲ�������ϸ�Ƽ��ڲ��ȼ���Ϣ
    --�������ϲ�������ϸ�Ƽ�����������Ϣ  
    plm.pkg_outside_material.p_cre_material_examine_price(pi_examine_price_id => v_exprice_id,
                                                          pi_user_id          => p_user_id);
  
    --3.���⹤�� A : ID => A1:ID X , B: ID AID => B1:ID AID A1ID
    DECLARE
      v_related_colored_detail_id VARCHAR2(256);
      p_special_craft             plm.special_craft_examine_price%ROWTYPE;
      v_department                VARCHAR2(256);
    BEGIN
      FOR craft_rec IN (SELECT t.quotation_special_craft_detail_id,
                               t.related_colored_detail_id,
                               t.quotation_special_craft_detail_no,
                               t.craft_classification,
                               z.whether_add_color_quotation
                          FROM plm.special_craft_quotation t
                         INNER JOIN plm.quotation z
                            ON z.quotation_id = t.quotation_id
                         WHERE t.quotation_id = p_quotation_id) LOOP
      
        p_special_craft.examine_price_special_craft_detail_id := plm.pkg_plat_comm.f_get_keycode(v_table_name  => 'SPECIAL_CRAFT_EXAMINE_PRICE',
                                                                                                 v_column_name => 'EXAMINE_PRICE_SPECIAL_CRAFT_DETAIL_ID',
                                                                                                 v_pre         => v_exprice_id || 'GY',
                                                                                                 v_serail_num  => 2);
        p_special_craft.related_colored_quotation_detail_id   := craft_rec.quotation_special_craft_detail_id;
        --������ɫ�˼����⹤����ϸID
        IF craft_rec.related_colored_detail_id IS NOT NULL THEN
          SELECT MAX(t.examine_price_special_craft_detail_id)
            INTO v_related_colored_detail_id
            FROM plm.special_craft_examine_price t
           WHERE t.related_colored_quotation_detail_id =
                 craft_rec.related_colored_detail_id;
        ELSE
          v_related_colored_detail_id := NULL;
        
        END IF;
        --��ɫ���������⹤��Ϊ��ɫ
        IF craft_rec.whether_add_color_quotation = 1 AND
           craft_rec.related_colored_detail_id IS NULL THEN
          p_special_craft.whether_append := 1;
        ELSE
          p_special_craft.whether_append := 0;
        END IF;
        p_special_craft.related_colored_detail_id := v_related_colored_detail_id;
        p_special_craft.special_craft_detail_no   := craft_rec.quotation_special_craft_detail_no;
        --���շ����Ӧ����
        --У�顾���۷��ࡿ���С����շ����Ӧ���š��ж�
        --1 �������۷���-�������ࡿ�����а�/Ů��ʱ�������շ����Ӧ���š�=����������         
        --2 �������۷���-�������ࡿ������Ь/ŮЬʱ�������շ����Ӧ���š�=���˼۲��� 
        --3 �������۷���-�������ࡿ�������а�/Ů��/��Ь/ŮЬ��ʱ
        --�á��������⹤����ϸID����Ӧ���������⹤�շ���(1&2��)����Σ��ڡ����⹤�տ⡿���ҳ���Ӧ���������š�
        --���⹤�տ� SPECIAL_PROCESS
        --��Ь��ŮЬ    
        IF v_quotation_class_code IN
           ('PLM_READY_PRICE_CLASSIFICATION00010001',
            'PLM_READY_PRICE_CLASSIFICATION00010003') THEN
          v_department := 'EXAMINE_DEPART';
          --�а���Ů��
        ELSIF v_quotation_class_code IN
              ('PLM_READY_PRICE_CLASSIFICATION00010002',
               'PLM_READY_PRICE_CLASSIFICATION00010004') THEN
          v_department := 'TECHNOLOGY_DEPART';
        ELSE
          SELECT MAX(t.department)
            INTO v_department
            FROM plm.special_process t
           WHERE t.classification_level = 2
             AND t.process_id = craft_rec.craft_classification;
        END IF;
        p_special_craft.craft_classification_department := v_department;
        p_special_craft.examine_price_id                := v_exprice_id;
      
        p_insert_special_craft_examine_price(p_special_craft => p_special_craft);
      END LOOP;
    END generate_special_craft_examine_price;
  
  END p_generate_examine_price;
  --ͨ��ƽ̨Ψһ����ȡ��Ӧ����ҵID
  FUNCTION f_get_sup_company_id_by_uqid(p_company_id VARCHAR2,
                                        p_uq_id      VARCHAR2)
    RETURN VARCHAR2 IS
    v_sup_company_id VARCHAR2(32);
  BEGIN
    SELECT MAX(sp.supplier_company_id)
      INTO v_sup_company_id
      FROM scmdata.t_supplier_info sp
     WHERE sp.company_id = p_company_id
       AND sp.supplier_info_id = p_uq_id;
    RETURN v_sup_company_id;
  END f_get_sup_company_id_by_uqid;

  --��������
  PROCEDURE p_insert_plm_file(p_plm_f_rec plm.plm_file%ROWTYPE) IS
  BEGIN
    INSERT INTO plm_file
      (file_id, thirdpart_id, file_name, source_name, url, bucket,
       upload_time, file_type, file_blob, file_unique, file_size)
    VALUES
      (p_plm_f_rec.file_id, p_plm_f_rec.thirdpart_id, p_plm_f_rec.file_name,
       p_plm_f_rec.source_name, p_plm_f_rec.url, p_plm_f_rec.bucket,
       p_plm_f_rec.upload_time, p_plm_f_rec.file_type, p_plm_f_rec.file_blob,
       p_plm_f_rec.file_unique, p_plm_f_rec.file_size);
  END p_insert_plm_file;
  --���¸���
  PROCEDURE p_update_plm_file(p_plm_f_rec plm.plm_file%ROWTYPE) IS
  BEGIN
    UPDATE plm_file t
       SET t.file_name   = p_plm_f_rec.file_name,
           t.source_name = p_plm_f_rec.source_name,
           t.upload_time = p_plm_f_rec.upload_time,
           t.file_blob   = p_plm_f_rec.file_blob,
           t.file_unique = p_plm_f_rec.file_unique,
           t.file_size   = p_plm_f_rec.file_size
     WHERE t.thirdpart_id = p_plm_f_rec.thirdpart_id
       AND t.file_type = p_plm_f_rec.file_type;
  END p_update_plm_file;
  --ɾ������
  PROCEDURE p_delete_plm_file(p_plm_f_rec plm.plm_file%ROWTYPE) IS
  BEGIN
    DELETE FROM plm_file t
     WHERE t.thirdpart_id = p_plm_f_rec.thirdpart_id
       AND t.file_type = p_plm_f_rec.file_type;
  END p_delete_plm_file;
  /*  --���±��۵�����
  PROCEDURE p_update_quotation_file(p_quotation_id VARCHAR2,
                                    p_file_type    INT,
                                    p_file_blob    BLOB,
                                    p_file_name    VARCHAR2,
                                    p_file_md5     VARCHAR2) IS
    p_plm_f_rec plm.plm_file%ROWTYPE;
  BEGIN
    --��ʽͼƬ��ֽ���ļ�������ļ�     
    p_plm_f_rec.thirdpart_id := p_quotation_id;
    p_plm_f_rec.upload_time  := SYSDATE;
    p_plm_f_rec.file_type    := p_file_type;
    p_plm_f_rec.file_blob    := p_file_blob;
    p_plm_f_rec.file_name    := p_file_name;
    p_plm_f_rec.file_md5     := p_file_md5;
    p_update_plm_file(p_plm_f_rec => p_plm_f_rec);
  END p_update_quotation_file;*/

  --�������ϲ��˼�����
  PROCEDURE p_insert_fabric_depart_examine_price_job(p_fabric_rec mrp.fabric_depart_examine_price_job%ROWTYPE) IS
  BEGIN
    INSERT INTO mrp.fabric_depart_examine_price_job
      (examine_price_id, relate_add_color_examine_price_id,
       fabric_depart_examine_price_job_id,
       fabric_depart_examine_price_job_status,
       fabric_depart_examine_price_job_man,
       fabric_depart_examine_price_job_finish_time)
    VALUES
      (p_fabric_rec.examine_price_id,
       p_fabric_rec.relate_add_color_examine_price_id,
       p_fabric_rec.fabric_depart_examine_price_job_id,
       p_fabric_rec.fabric_depart_examine_price_job_status,
       p_fabric_rec.fabric_depart_examine_price_job_man,
       p_fabric_rec.fabric_depart_examine_price_job_finish_time);
  END p_insert_fabric_depart_examine_price_job;

  --�������ϲ�������ϸ�˼���Ϣ
  PROCEDURE p_insert_fabric_material_detail_examine_price(p_fabric_material_rec mrp.fabric_material_detail_examine_price%ROWTYPE) IS
  BEGIN
    INSERT INTO mrp.fabric_material_detail_examine_price
      (examine_price_material_detail_id,
       relate_material_detail_quotation_id,
       relate_add_color_examine_price_material_detail_id,
       examine_price_material_detail_no, whether_inner_material,
       examine_price_material_sku, examine_price_material_supplier_code,
       examine_unit_price_result, unit, unit_price, examine_price_id)
    VALUES
      (p_fabric_material_rec.examine_price_material_detail_id,
       p_fabric_material_rec.relate_material_detail_quotation_id,
       p_fabric_material_rec.relate_add_color_examine_price_material_detail_id,
       p_fabric_material_rec.examine_price_material_detail_no,
       p_fabric_material_rec.whether_inner_material,
       p_fabric_material_rec.examine_price_material_sku,
       p_fabric_material_rec.examine_price_material_supplier_code,
       p_fabric_material_rec.examine_unit_price_result,
       p_fabric_material_rec.unit, p_fabric_material_rec.unit_price,
       p_fabric_material_rec.examine_price_id);
  
  END p_insert_fabric_material_detail_examine_price;

END pkg_quotation;
/
