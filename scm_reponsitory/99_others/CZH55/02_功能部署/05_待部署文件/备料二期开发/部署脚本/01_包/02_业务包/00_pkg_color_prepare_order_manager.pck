CREATE OR REPLACE PACKAGE mrp.pkg_color_prepare_order_manager IS

  -- Author  : CZH55
  -- Created : 2023/4/25 17:39:55
  -- Purpose : ��Ʒ�����Ϲ�Ӧ��ɫ�����ϵ�����-ҵ������

  --ɫ�����ϵ� �����ѯ  
  FUNCTION f_query_color_prepare_order_header(p_company_id     VARCHAR2,
                                              p_prepare_object INT,
                                              p_prepare_status INT)
    RETURN CLOB;

  --ɫ������������ �����ѯ  
  FUNCTION f_query_color_prepare_product_order_header(p_company_id     VARCHAR2,
                                                      p_prepare_object INT)
    RETURN CLOB;

  --���� ����ɫ�����ϵ�
  --����������
  PROCEDURE p_generate_color_prepare_order(p_group_key        VARCHAR2,
                                           p_product_order_id VARCHAR2,
                                           p_company_id       VARCHAR2,
                                           p_user_id          VARCHAR2);

  --�ӱ� ����ɫ�����ϵ�
  --����������
  PROCEDURE p_generate_color_prepare_order_sub(p_cpo_rec          mrp.color_prepare_order%ROWTYPE,
                                               p_user_id          VARCHAR2,
                                               p_product_order_id VARCHAR2);
  --����ɫ������������
  PROCEDURE p_generate_color_prepare_product_order(p_cpo_rec          mrp.color_prepare_order%ROWTYPE,
                                                   p_product_order_id VARCHAR2,
                                                   p_order_num        NUMBER,
                                                   p_order_cnt        NUMBER,
                                                   p_relate_skc       VARCHAR2,
                                                   p_company_id       VARCHAR2,
                                                   p_user_id          VARCHAR2);
  --���� �ӵ���ť
  PROCEDURE p_receive_orders(p_company_id VARCHAR2,
                             p_user_id    VARCHAR2,
                             p_cpo_rec    mrp.color_prepare_order%ROWTYPE);

  --�ӱ� �ӵ���ť
  PROCEDURE p_receive_orders_sub(p_company_id VARCHAR2,
                                 p_user_id    VARCHAR2,
                                 p_cpop_id    VARCHAR2,
                                 p_cpo_rec    mrp.color_prepare_order%ROWTYPE,
                                 p_order_num  NUMBER,
                                 p_order_cnt  NUMBER,
                                 p_relate_skc VARCHAR2);

  --��Ʒ��Ӧ�� ����תɫ��
  PROCEDURE p_fabric_gray_convert_color(p_cpop_rec mrp.color_prepare_product_order%ROWTYPE,
                                        p_user_id  VARCHAR2);
  --���Ϲ�Ӧ�� ����תɫ��
  PROCEDURE p_material_fabric_gray_convert_color(p_cpop_rec mrp.color_prepare_product_order%ROWTYPE,
                                                 p_user_id  VARCHAR2);

  --��ȡ����spu
  FUNCTION f_get_material_spu(p_material_sku      VARCHAR2,
                              p_sup_code          VARCHAR2 DEFAULT NULL,
                              p_is_inner_material INT) RETURN VARCHAR2;

  --��ȡ���Ϲ�Ӧ�� ����spu
  FUNCTION f_get_mt_material_spu(p_material_sku VARCHAR2) RETURN VARCHAR2;

  --��ȡƷ�Ʋ֡���Ӧ�̲���
  --1 Ʒ�Ʋ�
  --2 ��Ӧ�̲�
  FUNCTION f_get_brand_stock(p_company_id          VARCHAR2,
                             p_prepare_object      INT,
                             p_pro_supplier_code   VARCHAR2 DEFAULT NULL,
                             p_mater_supplier_code VARCHAR2,
                             p_unit                VARCHAR2,
                             p_material_spu        VARCHAR2,
                             p_store_type          INT) RETURN NUMBER;

  --��ȡƷ�Ʋ֡���Ӧ�̲���  DYY
  FUNCTION f_get_stock_num(p_company_id          VARCHAR2,
                           p_sup_mode            INT, --0 ��Ʒ 1 ����
                           p_type                VARCHAR2, --sku/spu
                           p_pro_supplier_code   VARCHAR2 DEFAULT NULL,
                           p_mater_supplier_code VARCHAR2,
                           p_unit                VARCHAR2,
                           p_material_id         VARCHAR2,
                           p_store_type          INT --1 Ʒ�Ʋ� 2 ��Ӧ�̲�
                           ) RETURN NUMBER;

  --���Ʒ��Ӧ�� ȡȾ����
  FUNCTION f_get_dye_loss_late(p_pro_supplier_code   VARCHAR2 DEFAULT NULL,
                               p_mater_supplier_code VARCHAR2,
                               p_material_sku        VARCHAR2,
                               p_is_inner_material   INT) RETURN NUMBER;

  --���Ϲ�Ӧ�� ��ȡȾ����
  FUNCTION f_get_mt_dye_loss_late(p_mater_supplier_code VARCHAR2,
                                  p_material_sku        VARCHAR2)
    RETURN NUMBER;

  --У�顰Ʒ�Ʋ�/��Ӧ�̲� ������桱ת��Ϊɫ���Ƿ���
  PROCEDURE p_check_color_fabric_is_enough(p_brand_stock      NUMBER,
                                           p_plan_product_num NUMBER,
                                           p_sup_store_num    NUMBER DEFAULT 0,
                                           p_dye_loss_late    NUMBER,
                                           p_store_type       INT,
                                           po_is_enough_flag  OUT INT,
                                           po_num             OUT NUMBER);

  --�ݱ��϶��󣨳�Ʒ�����Ϲ�Ӧ�̣����ɡ���Ӧ�̿��-��������ⵥ����Ϣ
  PROCEDURE p_generate_brand_inout_bound_by_pro(p_cpop_rec     mrp.color_prepare_product_order%ROWTYPE,
                                                p_store_type   INT,
                                                p_material_spu VARCHAR2,
                                                p_num          NUMBER,
                                                p_user_id      VARCHAR2,
                                                po_bound_num   OUT VARCHAR2);

  --���Ϲ�Ӧ�����ɡ���Ӧ�̿��-��������ⵥ����Ϣ
  PROCEDURE p_generate_brand_inout_bound_by_mt(p_cpop_rec     mrp.color_prepare_product_order%ROWTYPE,
                                               p_store_type   INT,
                                               p_material_spu VARCHAR2,
                                               p_num          NUMBER,
                                               p_user_id      VARCHAR2,
                                               po_bound_num   OUT VARCHAR2);
  --Ʒ�Ʋ�-������������ⵥ
  PROCEDURE p_generate_brand_inout_bound(p_cpop_rec     mrp.color_prepare_product_order%ROWTYPE,
                                         p_store_type   INT,
                                         p_material_spu VARCHAR2,
                                         p_num          NUMBER,
                                         p_user_id      VARCHAR2,
                                         po_bound_num   OUT VARCHAR2);

  --��Ʒ��Ӧ�� ��Ӧ�̲�-������������ⵥ
  PROCEDURE p_generate_sup_brand_inout_bound_by_pro(p_cpop_rec     mrp.color_prepare_product_order%ROWTYPE,
                                                    p_store_type   INT,
                                                    p_material_spu VARCHAR2,
                                                    p_sup_num      NUMBER,
                                                    p_user_id      VARCHAR2);

  --���Ϲ�Ӧ�� ��Ӧ�̲�-������������ⵥ
  PROCEDURE p_generate_sup_brand_inout_bound_by_mt(p_cpop_rec     mrp.color_prepare_product_order%ROWTYPE,
                                                   p_store_type   INT,
                                                   p_material_spu VARCHAR2,
                                                   p_sup_num      NUMBER,
                                                   p_user_id      VARCHAR2);
  --��Ӧ�̲�-������������ⵥ
  PROCEDURE p_generate_sup_brand_inout_bound(p_cpop_rec      mrp.color_prepare_product_order%ROWTYPE,
                                             p_store_type    INT,
                                             p_material_spu  VARCHAR2,
                                             p_brand_stock   NUMBER,
                                             p_dye_loss_late NUMBER,
                                             p_user_id       VARCHAR2);

  --���¡���Ӧ�̿��-�����ֿ����ϸ����Ӧ����
  PROCEDURE p_generate_grey_stock(p_sgiob_rec   mrp.supplier_grey_in_out_bound%ROWTYPE,
                                  p_inout_stock NUMBER,
                                  p_user_id     VARCHAR2);

  --���Ϲ�Ӧ�� ���¡���Ӧ�̿��-�����ֿ����ϸ����Ӧ����
  PROCEDURE p_generate_material_grey_stock(p_mgiob_rec   mrp.material_grey_in_out_bound%ROWTYPE,
                                           p_inout_stock NUMBER,
                                           p_user_id     VARCHAR2);

  --ȡ�����ϵ�
  PROCEDURE p_cancle_color_prepare_order(p_prepare_order_id VARCHAR2,
                                         p_cancel_reason    VARCHAR2,
                                         p_user_id          VARCHAR2);

  --�޸Ķ�������
  PROCEDURE p_update_order_num(p_prepare_order_id VARCHAR2,
                               p_order_num        VARCHAR2,
                               p_user_id          VARCHAR2);

  --�޸�Ԥ�Ƶ�������
  PROCEDURE p_update_expect_arrival_time(p_prepare_order_id    VARCHAR2,
                                         p_prepare_status      INT,
                                         p_expect_arrival_time DATE,
                                         p_user_id             VARCHAR2);

  --������ ȡ������
  PROCEDURE p_cancel_product_order(p_product_order_id VARCHAR2,
                                   p_user_id          VARCHAR2,
                                   p_cancel_reason    VARCHAR2);

  --��ɶ���
  PROCEDURE p_finish_product_order(p_product_order_id     VARCHAR2,
                                   p_cur_finished_num     VARCHAR2,
                                   p_is_finished_preorder NUMBER,
                                   p_company_id           VARCHAR2,
                                   p_user_id              VARCHAR2);

  --��Ʒ��Ӧ�� ɫ�����
  PROCEDURE p_color_cloth_storage(p_cppo_rec   mrp.color_prepare_product_order%ROWTYPE,
                                  p_company_id VARCHAR2,
                                  p_user_id    VARCHAR2,
                                  p_batch_num  NUMBER,
                                  po_bound_num OUT VARCHAR2);

  --���Ϲ�Ӧ�� ɫ�����
  PROCEDURE p_material_color_cloth_storage(p_cppo_rec   mrp.color_prepare_product_order%ROWTYPE,
                                           p_company_id VARCHAR2,
                                           p_user_id    VARCHAR2,
                                           p_batch_num  NUMBER,
                                           po_bound_num OUT VARCHAR2);

  --�Ƿ��ҵ�ɫ�����
  --���ֱ��϶��� 
  --p_prepare_object��0 ��Ʒ��Ӧ�� 1 ���Ϲ�Ӧ��
  FUNCTION f_is_find_color_stock(p_pro_supplier_code   VARCHAR2 DEFAULT NULL,
                                 p_mater_supplier_code VARCHAR2,
                                 p_material_sku        VARCHAR2,
                                 p_unit                VARCHAR2,
                                 p_prepare_object      INT) RETURN NUMBER;

  --��Ʒ��Ӧ�� ɫ���ֿ��
  PROCEDURE p_sync_supplier_color_cloth_stock(p_sciob_rec  mrp.supplier_color_in_out_bound%ROWTYPE,
                                              p_company_id VARCHAR2,
                                              p_user_id    VARCHAR2);

  --���Ϲ�Ӧ�� ɫ���ֿ��
  PROCEDURE p_sync_material_color_cloth_stock(p_mciob_rec  mrp.material_color_in_out_bound%ROWTYPE,
                                              p_company_id VARCHAR2,
                                              p_user_id    VARCHAR2);

  --���Ͻ��Ȳ�ѯ  
  FUNCTION f_query_prepare_order_process(p_order_num VARCHAR2) RETURN CLOB;

  --����״̬ͬ�����������ȱ�
  PROCEDURE p_sync_prepare_status(p_order_num  VARCHAR2,
                                  p_company_id VARCHAR2);

END pkg_color_prepare_order_manager;
/
CREATE OR REPLACE PACKAGE BODY mrp.pkg_color_prepare_order_manager IS

  --ɫ�����ϵ� �����ѯ  
  FUNCTION f_query_color_prepare_order_header(p_company_id     VARCHAR2,
                                              p_prepare_object INT,
                                              p_prepare_status INT)
    RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[
SELECT va.group_key,
       va.material_name           cr_material_name_n, --��������
       va.is_delay                cr_is_delay_n, --�Ƿ�����
       mp.file_unique             cr_features_n,
       va.supplier_color          cr_supplier_color_n, --��ɫ   
       va.supplier_shades         cr_supplier_shades_n, --ɫ��
       va.unit                    cr_unit_n, --��λ   
       va.order_cnt               cr_order_cnt_n, --������
       va.order_num               cr_order_num_n, --��������
       ]' || (CASE
               WHEN p_prepare_status IN (3) THEN
                ' va.finish_num cr_finish_num_n, --���������
                  va.finish_num/va.order_num cr_finish_rate_n, --�����'
               ELSE
                NULL
             END) || q'[
       va.practical_door_with     cr_practical_door_with_n, --ʵ���ŷ�
       va.gram_weight             cr_gram_weight_n, --����
       va.material_specifications cr_material_specifications_n, --���    
       va.material_sku            cr_material_sku_n --����sku
  FROM ]' || (CASE
               WHEN p_prepare_object = 0 THEN
                'scmdata.t_supplier_info'
               WHEN p_prepare_object = 1 THEN
                'mrp.mrp_determine_supplier_archives'
               ELSE
                NULL
             END) || q'[ sp
 INNER JOIN mrp.v_color_prepare_order va
    ON ]' || (CASE
               WHEN p_prepare_object = 0 THEN
                'va.pro_supplier_code = sp.supplier_info_id'
               WHEN p_prepare_object = 1 THEN
                'va.mater_supplier_code = sp.supplier_code'
               ELSE
                NULL
             END) || q'[
   AND va.company_id = sp.company_id
   AND va.prepare_status = ]' || p_prepare_status || q'[
   AND va.prepare_object = ]' || p_prepare_object || q'[
 LEFT JOIN mrp.mrp_picture mp 
  ON to_char(mp.picture_id) = va.features
 WHERE sp.company_id = ']' || p_company_id || q'[' 
   AND sp.supplier_company_id = %default_company_id%
 ORDER BY va.order_time DESC
]';
    RETURN v_sql;
  END f_query_color_prepare_order_header;

  --ɫ������������ �����ѯ  
  FUNCTION f_query_color_prepare_product_order_header(p_company_id     VARCHAR2,
                                                      p_prepare_object INT)
    RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[SELECT t.product_order_id, --ɫ����������
       t.supplier_material_name cr_material_name_n, --��Ӧ����������
       decode(sign(to_number(SYSDATE - va.min_expect_arrival_time)),
              1,
              '��',
              '��') cr_is_delay_n, --�Ƿ����� ����
       mp.file_unique cr_features_n, --����ͼ��ͼƬID����һ��
       t.supplier_color cr_supplier_color_n, --��Ӧ����ɫ
       t.supplier_shades cr_supplier_shades_n, --��Ӧ��ɫ��
       t.unit cr_unit_n, --��λ
       t.contain_color_prepare_num cr_order_cnt_n, --��ɫ�����ϵ���
       t.plan_product_quantity cr_order_num_n, --�ƻ���������
       t.batch_finish_num cr_finish_num_n, --���������
       t.batch_finish_percent cr_finish_rate_n, --�����
       t.practical_door_with cr_practical_door_with_n, --ʵ���ŷ�
       t.gram_weight cr_gram_weight_n, --����
       t.material_specifications cr_material_specifications_n, --���Ϲ��  
       t.material_sku cr_material_sku_n --����SKU
  FROM ]' || (CASE
               WHEN p_prepare_object = 0 THEN
                'scmdata.t_supplier_info'
               WHEN p_prepare_object = 1 THEN
                'mrp.mrp_determine_supplier_archives'
               ELSE
                NULL
             END) || q'[ sp
 INNER JOIN mrp.color_prepare_product_order t
    ON ]' || (CASE
               WHEN p_prepare_object = 0 THEN
                't.pro_supplier_code = sp.supplier_info_id'
               WHEN p_prepare_object = 1 THEN
                't.mater_supplier_code = sp.supplier_code'
               ELSE
                NULL
             END) || q'[
   AND t.company_id = sp.company_id
   AND t.product_status = 1
   AND t.prepare_object = ]' || p_prepare_object || q'[
  LEFT JOIN (SELECT MIN(po.expect_arrival_time) min_expect_arrival_time,
                    po.product_order_id,
                    po.company_id
               FROM mrp.color_prepare_order po
              WHERE po.whether_del = 0
              GROUP BY po.product_order_id, po.company_id) va
    ON va.product_order_id = t.product_order_id
   AND va.company_id = t.company_id
  LEFT JOIN mrp.mrp_picture mp 
   ON to_char(mp.picture_id) = t.features
 WHERE t.company_id = ']' || p_company_id || q'['
   AND sp.supplier_company_id = %default_company_id%
   AND t.whether_del = 0
 ORDER BY t.receive_time DESC
]';
    RETURN v_sql;
  END f_query_color_prepare_product_order_header;

  --���� ����ɫ�����ϵ�
  --����������
  PROCEDURE p_generate_color_prepare_order(p_group_key        VARCHAR2,
                                           p_product_order_id VARCHAR2,
                                           p_company_id       VARCHAR2,
                                           p_user_id          VARCHAR2) IS
  BEGIN
    FOR cpo_rec IN (SELECT t.*
                      FROM mrp.color_prepare_order t
                     WHERE t.company_id = p_company_id
                       AND t.group_key = p_group_key
                       AND t.prepare_status = 1) LOOP
      cpo_rec.prepare_status       := 2;
      cpo_rec.receive_id           := p_user_id;
      cpo_rec.receive_time         := SYSDATE;
      cpo_rec.product_order_id     := p_product_order_id;
      cpo_rec.batch_finish_num     := 0;
      cpo_rec.batch_finish_percent := 0;
      cpo_rec.complete_num         := cpo_rec.order_num;
      mrp.pkg_color_prepare_order.p_update_color_prepare_order(p_color_rec => cpo_rec);
    END LOOP;
  END p_generate_color_prepare_order;

  --�ӱ� ����ɫ�����ϵ�
  --����������
  PROCEDURE p_generate_color_prepare_order_sub(p_cpo_rec          mrp.color_prepare_order%ROWTYPE,
                                               p_user_id          VARCHAR2,
                                               p_product_order_id VARCHAR2) IS
    v_cpo_rec mrp.color_prepare_order%ROWTYPE;
  BEGIN
    v_cpo_rec                      := p_cpo_rec;
    v_cpo_rec.prepare_status       := 2;
    v_cpo_rec.receive_id           := p_user_id;
    v_cpo_rec.receive_time         := SYSDATE;
    v_cpo_rec.product_order_id     := p_product_order_id;
    v_cpo_rec.batch_finish_num     := 0;
    v_cpo_rec.batch_finish_percent := 0;
    v_cpo_rec.complete_num         := p_cpo_rec.order_num;
  
    mrp.pkg_color_prepare_order.p_update_color_prepare_order(p_color_rec => v_cpo_rec);
  END p_generate_color_prepare_order_sub;

  --����ɫ������������
  PROCEDURE p_generate_color_prepare_product_order(p_cpo_rec          mrp.color_prepare_order%ROWTYPE,
                                                   p_product_order_id VARCHAR2,
                                                   p_order_num        NUMBER,
                                                   p_order_cnt        NUMBER,
                                                   p_relate_skc       VARCHAR2,
                                                   p_company_id       VARCHAR2,
                                                   p_user_id          VARCHAR2) IS
    v_cpop_rec mrp.color_prepare_product_order%ROWTYPE;
  BEGIN
    v_cpop_rec.product_order_id        := p_product_order_id; --ɫ����������
    v_cpop_rec.product_status          := 1; --������״̬��1�����У�2����ɣ�3��ȡ��
    v_cpop_rec.prepare_object          := p_cpo_rec.prepare_object; --���϶���
    v_cpop_rec.material_sku            := p_cpo_rec.material_sku; --����SKU
    v_cpop_rec.pro_supplier_code       := p_cpo_rec.pro_supplier_code; --��Ʒ��Ӧ�̱��
    v_cpop_rec.mater_supplier_code     := p_cpo_rec.mater_supplier_code; --���Ϲ�Ӧ�̱��
    v_cpop_rec.whether_inner_mater     := p_cpo_rec.whether_inner_mater; --�Ƿ��ڲ����ϣ�0��1��
    v_cpop_rec.material_name           := p_cpo_rec.material_name; --��������
    v_cpop_rec.material_color          := p_cpo_rec.material_color; --������ɫ
    v_cpop_rec.unit                    := p_cpo_rec.unit; --��λ
    v_cpop_rec.supplier_material_name  := p_cpo_rec.supplier_material_name; --��Ӧ����������
    v_cpop_rec.supplier_color          := p_cpo_rec.supplier_color; --��Ӧ����ɫ
    v_cpop_rec.supplier_shades         := p_cpo_rec.supplier_shades; --��Ӧ��ɫ��
    v_cpop_rec.practical_door_with     := p_cpo_rec.practical_door_with; --ʵ���ŷ�
    v_cpop_rec.gram_weight             := p_cpo_rec.gram_weight; --����
    v_cpop_rec.material_specifications := p_cpo_rec.material_specifications; --���Ϲ��
    v_cpop_rec.features                := p_cpo_rec.features; --����ͼ��ͼƬID����һ��
    v_cpop_rec.ingredients             := p_cpo_rec.ingredients; --���ϳɷݣ��ɷ�ID��ҳ������ʾ
  
    v_cpop_rec.plan_product_quantity     := p_order_num; --�ƻ���������
    v_cpop_rec.contain_color_prepare_num := p_order_cnt; --��ɫ�����ϵ���
  
    --v_cpop_rec.actual_finish_num := p_cpo_rec.actual_finish_num; --ʵ���������
  
    v_cpop_rec.receive_id           := p_user_id; --�ӵ���
    v_cpop_rec.receive_time         := SYSDATE; --�ӵ�����
    v_cpop_rec.finish_id            := NULL; --�������
    v_cpop_rec.finish_num           := NULL; --���������
    v_cpop_rec.finish_time          := NULL; --���������
    v_cpop_rec.batch_finish_num     := 0; --��������ۼ�����
    v_cpop_rec.batch_finish_percent := 0; --��������ۼưٷֱ�
    v_cpop_rec.complete_num         := p_order_num; --���������
    v_cpop_rec.relate_skc           := p_relate_skc; --����SKC
  
    /*v_cpop_rec.cancel_id     := p_cpo_rec.cancel_id; --ȡ����
    v_cpop_rec.cancel_time   := p_cpo_rec.cancel_time; --ȡ������
    v_cpop_rec.cancel_reason := p_cpo_rec.cancel_reason; --ȡ��ԭ��*/
  
    v_cpop_rec.company_id  := p_company_id; --��ҵ����
    v_cpop_rec.create_id   := p_user_id; --������
    v_cpop_rec.create_time := SYSDATE; --����ʱ��
    v_cpop_rec.update_id   := p_user_id; --������
    v_cpop_rec.update_time := SYSDATE; --����ʱ��
    v_cpop_rec.whether_del := 0; --�Ƿ�ɾ����0��1��
  
    mrp.pkg_color_prepare_product_order.p_insert_color_prepare_product_order(p_color_rec => v_cpop_rec);
  END p_generate_color_prepare_product_order;

  --���� �ӵ���ť
  PROCEDURE p_receive_orders(p_company_id VARCHAR2,
                             p_user_id    VARCHAR2,
                             p_cpo_rec    mrp.color_prepare_order%ROWTYPE) IS
    v_cpop_id   VARCHAR2(32);
    v_cpop_rec  mrp.color_prepare_product_order%ROWTYPE;
    v_order_num NUMBER := 0;
    v_order_cnt NUMBER := 0;
    v_skc_strs  VARCHAR2(500);
  BEGIN
    --ɫ����������                   
    v_cpop_id := mrp.pkg_plat_comm.f_get_docuno(pi_table_name  => 'COLOR_PREPARE_PRODUCT_ORDER',
                                                pi_column_name => 'PRODUCT_ORDER_ID',
                                                pi_pre         => (CASE
                                                                    WHEN p_cpo_rec.prepare_object = 0 THEN
                                                                     'CKSC'
                                                                    WHEN p_cpo_rec.prepare_object = 1 THEN
                                                                     'WKSC'
                                                                    ELSE
                                                                     NULL
                                                                  END) ||
                                                                  to_char(trunc(SYSDATE),
                                                                          'YYYYMMDD'),
                                                pi_serail_num  => 5);
    --1.����ɫ������������
    SELECT SUM(t.order_num),
           COUNT(t.prepare_order_id),
           listagg(t.goods_skc, '/')
      INTO v_order_num, v_order_cnt, v_skc_strs
      FROM mrp.color_prepare_order t
     WHERE t.company_id = p_company_id
       AND t.group_key = p_cpo_rec.group_key
       AND t.prepare_status = 1;
  
    p_generate_color_prepare_product_order(p_cpo_rec          => p_cpo_rec,
                                           p_product_order_id => v_cpop_id,
                                           p_order_num        => v_order_num,
                                           p_order_cnt        => v_order_cnt,
                                           p_relate_skc       => v_skc_strs,
                                           p_company_id       => p_company_id,
                                           p_user_id          => p_user_id);
  
    --2.����ɫ�����ϵ�
    p_generate_color_prepare_order(p_group_key        => p_cpo_rec.group_key,
                                   p_product_order_id => v_cpop_id,
                                   p_company_id       => p_company_id,
                                   p_user_id          => p_user_id);
  
    --3.�������ɵġ�ɫ����������������Ϣ�����ɡ���������ⵥ����Ϣ    
    SELECT t.*
      INTO v_cpop_rec
      FROM mrp.color_prepare_product_order t
     WHERE t.product_order_id = v_cpop_id;
  
    --4.���ֱ��϶��� ������תɫ  
    IF v_cpop_rec.prepare_object = 0 THEN
      --��Ʒ��Ӧ��
      p_fabric_gray_convert_color(p_cpop_rec => v_cpop_rec,
                                  p_user_id  => p_user_id);
    ELSIF v_cpop_rec.prepare_object = 1 THEN
      --���Ϲ�Ӧ��
      p_material_fabric_gray_convert_color(p_cpop_rec => v_cpop_rec,
                                           p_user_id  => p_user_id);
    ELSE
      NULL;
    END IF;
  END p_receive_orders;

  --�ӱ� �ӵ���ť
  PROCEDURE p_receive_orders_sub(p_company_id VARCHAR2,
                                 p_user_id    VARCHAR2,
                                 p_cpop_id    VARCHAR2,
                                 p_cpo_rec    mrp.color_prepare_order%ROWTYPE,
                                 p_order_num  NUMBER,
                                 p_order_cnt  NUMBER,
                                 p_relate_skc VARCHAR2) IS
    v_cpop_rec mrp.color_prepare_product_order%ROWTYPE;
  BEGIN
    --1.����ɫ������������
    p_generate_color_prepare_product_order(p_cpo_rec          => p_cpo_rec,
                                           p_product_order_id => p_cpop_id,
                                           p_order_num        => p_order_num,
                                           p_order_cnt        => p_order_cnt,
                                           p_relate_skc       => p_relate_skc,
                                           p_company_id       => p_company_id,
                                           p_user_id          => p_user_id);
    --2.�������ɵġ�ɫ����������������Ϣ�����ɡ���������ⵥ����Ϣ    
    SELECT t.*
      INTO v_cpop_rec
      FROM mrp.color_prepare_product_order t
     WHERE t.product_order_id = p_cpop_id;
  
    --3.���ֱ��϶��� ������תɫ
    --��Ʒ��Ӧ��
    IF v_cpop_rec.prepare_object = 0 THEN
      p_fabric_gray_convert_color(p_cpop_rec => v_cpop_rec,
                                  p_user_id  => p_user_id);
    ELSIF v_cpop_rec.prepare_object = 1 THEN
      p_material_fabric_gray_convert_color(p_cpop_rec => v_cpop_rec,
                                           p_user_id  => p_user_id);
    ELSE
      NULL;
    END IF;
  END p_receive_orders_sub;

  --��Ʒ��Ӧ�� ����תɫ��
  PROCEDURE p_fabric_gray_convert_color(p_cpop_rec mrp.color_prepare_product_order%ROWTYPE,
                                        p_user_id  VARCHAR2) IS
    v_material_spu  VARCHAR2(256);
    v_brand_stock   NUMBER(18, 2);
    v_dye_loss_late NUMBER(11, 2);
    v_num           NUMBER; --Ʒ�Ʋ���
    v_flag          INT;
    v_sgiob_rec     mrp.supplier_grey_in_out_bound%ROWTYPE;
    vo_bound_num    VARCHAR2(32); --��������ⵥ����
  BEGIN
    --1.1 ��ȡ����spu
    v_material_spu := f_get_material_spu(p_material_sku      => p_cpop_rec.material_sku,
                                         p_sup_code          => p_cpop_rec.pro_supplier_code,
                                         p_is_inner_material => p_cpop_rec.whether_inner_mater);
  
    --1.2 ��ȡƷ�Ʋ���
    v_brand_stock := f_get_brand_stock(p_company_id          => p_cpop_rec.company_id,
                                       p_prepare_object      => p_cpop_rec.prepare_object,
                                       p_pro_supplier_code   => p_cpop_rec.pro_supplier_code,
                                       p_mater_supplier_code => p_cpop_rec.mater_supplier_code,
                                       p_unit                => p_cpop_rec.unit,
                                       p_material_spu        => v_material_spu,
                                       p_store_type          => 1);
  
    --1.3��ȡȾ����
    v_dye_loss_late := f_get_dye_loss_late(p_pro_supplier_code   => (CASE
                                                                      WHEN p_cpop_rec.whether_inner_mater = 1 THEN
                                                                       NULL
                                                                      ELSE
                                                                       p_cpop_rec.pro_supplier_code
                                                                    END),
                                           p_mater_supplier_code => p_cpop_rec.mater_supplier_code,
                                           p_material_sku        => p_cpop_rec.material_sku,
                                           p_is_inner_material   => p_cpop_rec.whether_inner_mater);
  
    --1.4 У��Ʒ�Ʋ����Ƿ����0
    --����0����Ʒ�Ʋ��п��     
    IF v_brand_stock > 0 THEN
      --У�顰Ʒ�Ʋ�������桱ת��Ϊɫ���Ƿ���
      p_check_color_fabric_is_enough(p_brand_stock      => v_brand_stock,
                                     p_plan_product_num => p_cpop_rec.plan_product_quantity,
                                     p_dye_loss_late    => v_dye_loss_late,
                                     p_store_type       => 1,
                                     po_is_enough_flag  => v_flag,
                                     po_num             => v_num);
      --��Ʒ��Ӧ������Ʒ�Ʋ� ����ⵥ
      p_generate_brand_inout_bound(p_cpop_rec     => p_cpop_rec,
                                   p_store_type   => 1,
                                   p_material_spu => v_material_spu,
                                   p_num          => v_num,
                                   p_user_id      => p_user_id,
                                   po_bound_num   => vo_bound_num);
    
      --�ǣ���������ɵġ���Ӧ�̿��-��������ⵥ����Ϣ�����¡���Ӧ�̿��-�����ֿ����ϸ����Ӧ����
      SELECT gs.*
        INTO v_sgiob_rec
        FROM mrp.supplier_grey_in_out_bound gs
       WHERE gs.bound_num = vo_bound_num
         AND gs.whether_del = 0;
    
      --���³�Ʒ��Ӧ�̿��-�����ֿ����ϸ
      p_generate_grey_stock(p_sgiob_rec   => v_sgiob_rec,
                            p_inout_stock => v_num, --�������
                            p_user_id     => p_user_id);
    
      --�ж�Ʒ�Ʋֿ���Ƿ���
      IF v_flag = 1 THEN
        NULL;
      ELSE
        --����Ʒ�Ʋֿ�治���������ӹ�Ӧ�ֿ̲�
        --���ɹ�Ӧ�̲� ����ⵥ
        p_generate_sup_brand_inout_bound(p_cpop_rec      => p_cpop_rec,
                                         p_store_type    => 2,
                                         p_material_spu  => v_material_spu,
                                         p_brand_stock   => v_brand_stock,
                                         p_dye_loss_late => v_dye_loss_late,
                                         p_user_id       => p_user_id);
      
      END IF;
    ELSE
      --1.5 ����Ʒ�Ʋ��޿�棬ֱ�Ӵӹ�Ӧ�ֿ̲�
      --���ɹ�Ӧ�̲� ����ⵥ
      p_generate_sup_brand_inout_bound(p_cpop_rec      => p_cpop_rec,
                                       p_store_type    => 2,
                                       p_material_spu  => v_material_spu,
                                       p_brand_stock   => v_brand_stock,
                                       p_dye_loss_late => v_dye_loss_late,
                                       p_user_id       => p_user_id);
    
    END IF;
  END p_fabric_gray_convert_color;

  --���Ϲ�Ӧ�� ����תɫ��
  PROCEDURE p_material_fabric_gray_convert_color(p_cpop_rec mrp.color_prepare_product_order%ROWTYPE,
                                                 p_user_id  VARCHAR2) IS
    v_material_spu  VARCHAR2(256);
    v_brand_stock   NUMBER(18, 2);
    v_dye_loss_late NUMBER(11, 2);
    v_flag          INT;
    v_num           NUMBER; --Ʒ�Ʋ���
    v_mgiob_rec     mrp.material_grey_in_out_bound%ROWTYPE;
    vo_bound_num    VARCHAR2(32); --��������ⵥ����
  BEGIN
    --1.1 ��ȡ����spu
    v_material_spu := f_get_mt_material_spu(p_material_sku => p_cpop_rec.material_sku);
  
    --1.2 ��ȡƷ�Ʋ���
    v_brand_stock := f_get_brand_stock(p_company_id          => p_cpop_rec.company_id,
                                       p_prepare_object      => p_cpop_rec.prepare_object,
                                       p_mater_supplier_code => p_cpop_rec.mater_supplier_code,
                                       p_unit                => p_cpop_rec.unit,
                                       p_material_spu        => v_material_spu,
                                       p_store_type          => 1);
  
    --1.3��ȡȾ����
    v_dye_loss_late := f_get_mt_dye_loss_late(p_mater_supplier_code => p_cpop_rec.mater_supplier_code,
                                              p_material_sku        => p_cpop_rec.material_sku);
  
    --1.4 У��Ʒ�Ʋ����Ƿ����0
    --����0����Ʒ�Ʋ��п��     
    IF v_brand_stock > 0 THEN
      --У�顰Ʒ�Ʋ�������桱ת��Ϊɫ���Ƿ���
      p_check_color_fabric_is_enough(p_brand_stock      => v_brand_stock,
                                     p_plan_product_num => p_cpop_rec.plan_product_quantity,
                                     p_dye_loss_late    => v_dye_loss_late,
                                     p_store_type       => 1,
                                     po_is_enough_flag  => v_flag,
                                     po_num             => v_num);
      --���Ϲ�Ӧ�� ����Ʒ�Ʋ� ����ⵥ
      p_generate_brand_inout_bound(p_cpop_rec     => p_cpop_rec,
                                   p_store_type   => 1,
                                   p_material_spu => v_material_spu,
                                   p_num          => v_num,
                                   p_user_id      => p_user_id,
                                   po_bound_num   => vo_bound_num);
    
      --�ǣ���������Ϲ�Ӧ�� ���ɵġ���Ӧ�̿��-��������ⵥ����Ϣ�����¡���Ӧ�̿��-�����ֿ����ϸ����Ӧ����   
      SELECT gs.*
        INTO v_mgiob_rec
        FROM mrp.material_grey_in_out_bound gs
       WHERE gs.bound_num = vo_bound_num
         AND gs.whether_del = 0;
    
      --�������Ϲ�Ӧ�̿��-�����ֿ����ϸ
      p_generate_material_grey_stock(p_mgiob_rec   => v_mgiob_rec,
                                     p_inout_stock => v_num, --�������
                                     p_user_id     => p_user_id);
    
      --�ж�Ʒ�Ʋֿ���Ƿ���
      IF v_flag = 1 THEN
        NULL;
      ELSE
        --����Ʒ�Ʋֿ�治���������ӹ�Ӧ�ֿ̲�
        --�ݱ��϶��󣨳�Ʒ�����Ϲ�Ӧ�̣����ɹ�Ӧ�̲� ����ⵥ
        p_generate_sup_brand_inout_bound(p_cpop_rec      => p_cpop_rec,
                                         p_store_type    => 2,
                                         p_material_spu  => v_material_spu,
                                         p_brand_stock   => v_brand_stock,
                                         p_dye_loss_late => v_dye_loss_late,
                                         p_user_id       => p_user_id);
      
      END IF;
    ELSE
      --1.5 ����Ʒ�Ʋ��޿�棬ֱ�Ӵӹ�Ӧ�ֿ̲�
      --�ݱ��϶��󣨳�Ʒ�����Ϲ�Ӧ�̣����ɹ�Ӧ�̲� ����ⵥ
      p_generate_sup_brand_inout_bound(p_cpop_rec      => p_cpop_rec,
                                       p_store_type    => 2,
                                       p_material_spu  => v_material_spu,
                                       p_brand_stock   => v_brand_stock,
                                       p_dye_loss_late => v_dye_loss_late,
                                       p_user_id       => p_user_id);
    
    END IF;
  END p_material_fabric_gray_convert_color;

  --��ȡ��Ʒ��Ӧ�� ����spu
  FUNCTION f_get_material_spu(p_material_sku      VARCHAR2,
                              p_sup_code          VARCHAR2 DEFAULT NULL,
                              p_is_inner_material INT) RETURN VARCHAR2 IS
    v_material_spu VARCHAR2(256);
  BEGIN
    IF p_is_inner_material = 0 THEN
      SELECT MAX(t.material_spu)
        INTO v_material_spu
        FROM mrp.mrp_outside_material_sku t
       WHERE t.material_sku = p_material_sku
         AND t.create_finished_supplier_code = p_sup_code
         AND t.whether_del = 0;
    ELSIF p_is_inner_material = 1 THEN
      SELECT MAX(t.material_spu)
        INTO v_material_spu
        FROM mrp.mrp_internal_material_sku t
       WHERE t.material_sku = p_material_sku;
    ELSE
      NULL;
    END IF;
    IF v_material_spu IS NULL THEN
      raise_application_error(-20002,
                              '��������SPU����Ϊ�գ�����ϵ����Ա��');
    END IF;
    RETURN v_material_spu;
  END f_get_material_spu;

  --��ȡ���Ϲ�Ӧ�� ����spu
  FUNCTION f_get_mt_material_spu(p_material_sku VARCHAR2) RETURN VARCHAR2 IS
    v_material_spu VARCHAR2(256);
  BEGIN
    SELECT MAX(t.material_spu)
      INTO v_material_spu
      FROM mrp.mrp_internal_material_sku t
     WHERE t.material_sku = p_material_sku;
  
    RETURN v_material_spu;
  END f_get_mt_material_spu;

  --��ȡƷ�Ʋ֡���Ӧ�̲���
  --1 Ʒ�Ʋ�
  --2 ��Ӧ�̲�
  FUNCTION f_get_brand_stock(p_company_id          VARCHAR2,
                             p_prepare_object      INT,
                             p_pro_supplier_code   VARCHAR2 DEFAULT NULL,
                             p_mater_supplier_code VARCHAR2,
                             p_unit                VARCHAR2,
                             p_material_spu        VARCHAR2,
                             p_store_type          INT) RETURN NUMBER IS
    v_brand_stock NUMBER(18, 2);
    v_sql         CLOB;
  BEGIN
    v_sql := q'[SELECT nvl((CASE
                 WHEN :p_store_type = 1 THEN
                  MAX(t.brand_stock)
                 WHEN :p_store_type = 2 THEN
                  MAX(t.supplier_stock)
                 ELSE
                  NULL
               END),
               0)     
      FROM ]' || (CASE
               WHEN p_prepare_object = 0 THEN
                ' mrp.supplier_grey_stock '
               WHEN p_prepare_object = 1 THEN
                ' mrp.material_grey_stock '
               ELSE
                NULL
             END) || q'[ t
     WHERE ]' || (CASE
               WHEN p_prepare_object = 0 THEN
                ' t.pro_supplier_code = :p_pro_supplier_code AND '
               ELSE
                NULL
             END) || q'[
        t.mater_supplier_code = :p_mater_supplier_code
       AND t.unit = :p_unit
       AND t.material_spu = :p_material_spu
       AND t.whether_del = 0
       AND t.company_id = :p_company_id]';
  
    IF p_prepare_object = 0 THEN
      EXECUTE IMMEDIATE v_sql
        INTO v_brand_stock
        USING p_store_type, p_store_type, p_pro_supplier_code, p_mater_supplier_code, p_unit, p_material_spu, p_company_id;
    ELSIF p_prepare_object = 1 THEN
      EXECUTE IMMEDIATE v_sql
        INTO v_brand_stock
        USING p_store_type, p_store_type, p_mater_supplier_code, p_unit, p_material_spu, p_company_id;
    ELSE
      NULL;
    END IF;
    RETURN v_brand_stock;
  END f_get_brand_stock;

  --��ȡƷ�Ʋ֡���Ӧ�̲���  DYY
  FUNCTION f_get_stock_num(p_company_id          VARCHAR2,
                           p_sup_mode            INT, --0 ��Ʒ 1 ����
                           p_type                VARCHAR2, --sku/spu
                           p_pro_supplier_code   VARCHAR2 DEFAULT NULL,
                           p_mater_supplier_code VARCHAR2,
                           p_unit                VARCHAR2,
                           p_material_id         VARCHAR2,
                           p_store_type          INT --1 Ʒ�Ʋ� 2 ��Ӧ�̲�
                           ) RETURN NUMBER IS
    v_stock NUMBER(18, 2);
    v_sql   CLOB;
  BEGIN
    --IF p_type =  'SPU' AND p_prepare_object = 0 THEN 
    v_sql := 'SELECT nvl((CASE
                 WHEN :p_store_type = 1 THEN
                  MAX(t.brand_stock)
                 WHEN :p_store_type = 2 THEN
                  MAX(t.supplier_stock)
                 ELSE
                  NULL
               END),
               0)     
      FROM ' || CASE
               WHEN p_type = 'SPU' AND p_sup_mode = 0 THEN
                '  mrp.supplier_grey_stock t '
               WHEN p_type = 'SPU' AND p_sup_mode = 1 THEN
                '  MRP.MATERIAL_GREY_STOCK t '
               WHEN p_type = 'SKU' AND p_sup_mode = 0 THEN
                '   MRP.SUPPLIER_COLOR_CLOTH_STOCK T '
               WHEN p_type = 'SKU' AND p_sup_mode = 1 THEN
                ' MRP.MATERIAL_COLOR_CLOTH_STOCK t'
             END || '
     WHERE ' || (CASE
               WHEN p_sup_mode = 0 THEN
                ' t.pro_supplier_code = :p_pro_supplier_code AND '
               ELSE
                NULL
             END) || q'[
        t.mater_supplier_code = :p_mater_supplier_code
       AND t.unit = :p_unit
       AND ]' || (CASE
               WHEN p_type = 'SPU' THEN
                't.material_spu = :p_material_id '
               WHEN p_type = 'SKU' THEN
                't.MATERIAL_SKU =:p_material_id '
             END) || 'AND t.whether_del = 0
       AND t.company_id = :p_company_id ';
  
    IF p_sup_mode = 0 THEN
      EXECUTE IMMEDIATE v_sql
        INTO v_stock
        USING p_store_type, p_store_type, p_pro_supplier_code, p_mater_supplier_code, p_unit, p_material_id, p_company_id;
    ELSIF p_sup_mode = 1 THEN
      EXECUTE IMMEDIATE v_sql
        INTO v_stock
        USING p_store_type, p_store_type, p_mater_supplier_code, p_unit, p_material_id, p_company_id;
    ELSE
      NULL;
    END IF;
    RETURN v_stock;
  END f_get_stock_num;

  --��Ʒ��Ӧ�� ��ȡȾ����
  FUNCTION f_get_dye_loss_late(p_pro_supplier_code   VARCHAR2 DEFAULT NULL,
                               p_mater_supplier_code VARCHAR2,
                               p_material_sku        VARCHAR2,
                               p_is_inner_material   INT) RETURN NUMBER IS
    v_dye_loss_late NUMBER(11, 2);
  BEGIN
    IF p_is_inner_material = 0 THEN
      SELECT nvl(MAX(t.dye_loss_late), 0)
        INTO v_dye_loss_late
        FROM mrp.mrp_outside_supplier_material t
       WHERE t.supplier_code = p_mater_supplier_code
         AND t.create_finished_supplier_code = p_pro_supplier_code
         AND t.material_sku = p_material_sku
         AND t.whether_del = 0;
    ELSIF p_is_inner_material = 1 THEN
      SELECT nvl(MAX(t.dye_loss_late), 0)
        INTO v_dye_loss_late
        FROM mrp.mrp_internal_supplier_material t
       WHERE t.supplier_code = p_mater_supplier_code
         AND t.material_sku = p_material_sku;
    ELSE
      v_dye_loss_late := 0;
    END IF;
    RETURN v_dye_loss_late;
  END f_get_dye_loss_late;

  --���Ϲ�Ӧ�� ��ȡȾ����
  FUNCTION f_get_mt_dye_loss_late(p_mater_supplier_code VARCHAR2,
                                  p_material_sku        VARCHAR2)
    RETURN NUMBER IS
    v_dye_loss_late NUMBER(11, 2);
  BEGIN
  
    SELECT nvl(MAX(t.dye_loss_late), 0)
      INTO v_dye_loss_late
      FROM mrp.mrp_internal_supplier_material t
     WHERE t.supplier_code = p_mater_supplier_code
       AND t.material_sku = p_material_sku;
  
    RETURN v_dye_loss_late;
  END f_get_mt_dye_loss_late;

  --У�顰Ʒ�Ʋ�/��Ӧ�̲� ������桱ת��Ϊɫ���Ƿ���
  PROCEDURE p_check_color_fabric_is_enough(p_brand_stock      NUMBER,
                                           p_plan_product_num NUMBER,
                                           p_sup_store_num    NUMBER DEFAULT 0,
                                           p_dye_loss_late    NUMBER,
                                           p_store_type       INT,
                                           po_is_enough_flag  OUT INT,
                                           po_num             OUT NUMBER) IS
    v_num  NUMBER;
    v_flag INT;
  BEGIN
    --Ʒ�Ʋ�
    IF p_store_type = 1 THEN
      --У�顰Ʒ�Ʋ�������桱ת��Ϊɫ���Ƿ��ã�
      --У�鹫ʽ����Ʒ�Ʋ�������桿 - �����ɵġ�ɫ��������������-�ƻ�����������/(1-��Ⱦ����/100��) �� 0 
      v_num := p_brand_stock -
               (p_plan_product_num / (1 - (p_dye_loss_late / 100)));
      -- ����0ʱ ����:��ɫ��������������-�ƻ�����������/(1-��Ⱦ���ʡ���
      --��<0ʱ ����:��Ʒ�Ʋ�������桿
      IF v_num >= 0 THEN
        v_flag := 1;
        v_num  := p_plan_product_num / (1 - (p_dye_loss_late / 100));
      ELSE
        v_flag := 0;
        v_num  := p_brand_stock;
      END IF;
    ELSIF p_store_type = 2 THEN
      --У�顱��Ӧ�̲�������桰ת��Ϊɫ���Ƿ��ã�    
      --У�鹫ʽ������Ӧ�̲�������桿-�����ɵġ�ɫ��������������-�ƻ�����������/(1-��Ⱦ����/100��-��Ʒ�Ʋ�������桿 ) �� 0 ��  
      --����0ʱ����������=�����ɵġ�ɫ��������������-�ƻ�����������/(1-��Ⱦ����/100��-��Ʒ�Ʋ�������桿 )  ��   
      --����0ʱ������=����Ӧ�ֿ̲��������
      v_num := p_sup_store_num -
               ((p_plan_product_num / (1 - (p_dye_loss_late / 100))) -
               p_brand_stock);
      IF v_num >= 0 THEN
        v_flag := 1;
        v_num  := (p_plan_product_num / (1 - (p_dye_loss_late / 100))) -
                  p_brand_stock;
      ELSE
        v_flag := 0;
        v_num  := p_sup_store_num;
      END IF;
    ELSE
      v_flag := 0;
    END IF;
    po_is_enough_flag := v_flag;
    po_num            := v_num;
  END p_check_color_fabric_is_enough;

  --��Ʒ��Ӧ�����ɡ���Ӧ�̿��-��������ⵥ����Ϣ
  PROCEDURE p_generate_brand_inout_bound_by_pro(p_cpop_rec     mrp.color_prepare_product_order%ROWTYPE,
                                                p_store_type   INT,
                                                p_material_spu VARCHAR2,
                                                p_num          NUMBER,
                                                p_user_id      VARCHAR2,
                                                po_bound_num   OUT VARCHAR2) IS
    v_bound_num VARCHAR2(32);
    v_sgiob_rec mrp.supplier_grey_in_out_bound%ROWTYPE;
  BEGIN
    v_bound_num           := mrp.pkg_plat_comm.f_get_docuno(pi_table_name  => 'SUPPLIER_GREY_IN_OUT_BOUND',
                                                            pi_column_name => 'BOUND_NUM',
                                                            pi_pre         => 'CPCK' ||
                                                                              to_char(trunc(SYSDATE),
                                                                                      'YYYYMMDD'),
                                                            pi_serail_num  => 5);
    v_sgiob_rec.bound_num := v_bound_num;
  
    v_sgiob_rec.ascription          := 0; --����������0����1���
    v_sgiob_rec.bound_type          := 4; --������������ͣ�1ɫ�����ϳ���/ 2�̿�����/ 3��ʱ��תɫ����/ 4�������ϳ��� /11Ʒ�Ʊ������/ 12��Ӧ���ֻ����/ 13��ӯ���/ 14��ʱ�������/15 ��Ӧ��ɫ�����
    v_sgiob_rec.pro_supplier_code   := p_cpop_rec.pro_supplier_code; --��Ʒ��Ӧ�̱��
    v_sgiob_rec.mater_supplier_code := p_cpop_rec.mater_supplier_code; --���Ϲ�Ӧ�̱��
    v_sgiob_rec.material_spu        := p_material_spu; --����SPU
    v_sgiob_rec.whether_inner_mater := p_cpop_rec.whether_inner_mater; --�Ƿ��ڲ����ϣ�0��1��
    v_sgiob_rec.unit                := p_cpop_rec.unit; --��λ
    v_sgiob_rec.num                 := p_num; --����
    v_sgiob_rec.stock_type          := p_store_type; --�ֿ����ͣ�1Ʒ�Ʋ֣�2��Ӧ�̲�
  
    v_sgiob_rec.relate_num                := p_cpop_rec.product_order_id; --��������
    v_sgiob_rec.relate_num_type           := 1; --�����������ͣ�1ɫ��������/ 2�����̵㵥/ 3ɫ�����ϵ�/ 4����������/5���ϲɹ���/6ɫ����ⵥ
    v_sgiob_rec.relate_skc                := p_cpop_rec.relate_skc; --����SKC
    v_sgiob_rec.company_id                := p_cpop_rec.company_id; --������ҵ�ġ���ҵID��
    v_sgiob_rec.create_id                 := p_user_id; --������
    v_sgiob_rec.create_time               := SYSDATE; --����ʱ��
    v_sgiob_rec.update_id                 := p_user_id; --������
    v_sgiob_rec.update_time               := SYSDATE; --����ʱ��
    v_sgiob_rec.whether_del               := 0; --�Ƿ�ɾ����0��1��
    v_sgiob_rec.relate_purchase_order_num := NULL; --�����ɹ�����
  
    mrp.pkg_supplier_grey_in_out_bound.p_insert_supplier_grey_in_out_bound(p_suppl_rec => v_sgiob_rec);
    po_bound_num := v_bound_num;
  END p_generate_brand_inout_bound_by_pro;

  --���Ϲ�Ӧ�����ɡ���Ӧ�̿��-��������ⵥ����Ϣ
  PROCEDURE p_generate_brand_inout_bound_by_mt(p_cpop_rec     mrp.color_prepare_product_order%ROWTYPE,
                                               p_store_type   INT,
                                               p_material_spu VARCHAR2,
                                               p_num          NUMBER,
                                               p_user_id      VARCHAR2,
                                               po_bound_num   OUT VARCHAR2) IS
    v_bound_num VARCHAR2(32);
    v_mciob_rec mrp.material_grey_in_out_bound%ROWTYPE;
  BEGIN
    v_bound_num           := mrp.pkg_plat_comm.f_get_docuno(pi_table_name  => 'MATERIAL_GREY_IN_OUT_BOUND',
                                                            pi_column_name => 'BOUND_NUM',
                                                            pi_pre         => 'WPCK' ||
                                                                              to_char(trunc(SYSDATE),
                                                                                      'YYYYMMDD'),
                                                            pi_serail_num  => 5);
    v_mciob_rec.bound_num := v_bound_num;
  
    v_mciob_rec.ascription          := 0; --����������0����1���
    v_mciob_rec.bound_type          := 4; --������������ͣ�1ɫ�����ϳ���/ 2�̿�����/ 3��ʱ��תɫ����/ 4�������ϳ��� /11Ʒ�Ʊ������/ 12��Ӧ���ֻ����/ 13��ӯ���/ 14��ʱ�������/15 ��Ӧ��ɫ�����       
    v_mciob_rec.mater_supplier_code := p_cpop_rec.mater_supplier_code; --���Ϲ�Ӧ�̱��
    v_mciob_rec.material_spu        := p_material_spu; --����SPU
    --v_mciob_rec.whether_inner_mater := p_cpop_rec.whether_inner_mater; --�Ƿ��ڲ����ϣ�0��1��
    v_mciob_rec.unit       := p_cpop_rec.unit; --��λ
    v_mciob_rec.num        := p_num; --����
    v_mciob_rec.stock_type := p_store_type; --�ֿ����ͣ�1Ʒ�Ʋ֣�2��Ӧ�̲�
  
    v_mciob_rec.relate_num                := p_cpop_rec.product_order_id; --��������
    v_mciob_rec.relate_num_type           := 1; --�����������ͣ�1ɫ��������/ 2�����̵㵥/ 3ɫ�����ϵ�/ 4����������/5���ϲɹ���/6ɫ����ⵥ
    v_mciob_rec.relate_skc                := p_cpop_rec.relate_skc; --����SKC
    v_mciob_rec.company_id                := p_cpop_rec.company_id; --������ҵ�ġ���ҵID��
    v_mciob_rec.create_id                 := p_user_id; --������
    v_mciob_rec.create_time               := SYSDATE; --����ʱ��
    v_mciob_rec.update_id                 := p_user_id; --������
    v_mciob_rec.update_time               := SYSDATE; --����ʱ��
    v_mciob_rec.whether_del               := 0; --�Ƿ�ɾ����0��1��
    v_mciob_rec.relate_purchase_order_num := NULL; --�����ɹ�����
  
    mrp.pkg_material_grey_in_out_bound.p_insert_material_grey_in_out_bound(p_mater_rec => v_mciob_rec);
    po_bound_num := v_bound_num;
  END p_generate_brand_inout_bound_by_mt;

  --��Ʒ�����Ϲ�Ӧ�� Ʒ�Ʋ�-������������ⵥ
  PROCEDURE p_generate_brand_inout_bound(p_cpop_rec     mrp.color_prepare_product_order%ROWTYPE,
                                         p_store_type   INT,
                                         p_material_spu VARCHAR2,
                                         p_num          NUMBER,
                                         p_user_id      VARCHAR2,
                                         po_bound_num   OUT VARCHAR2) IS
    v_bound_num VARCHAR2(32);
  BEGIN
  
    IF p_cpop_rec.prepare_object = 0 THEN
      --��Ʒ��Ӧ�� Ʒ�Ʋ� ���ɹ�Ӧ�̿��-��������ⵥ��
      p_generate_brand_inout_bound_by_pro(p_cpop_rec     => p_cpop_rec,
                                          p_store_type   => p_store_type,
                                          p_material_spu => p_material_spu,
                                          p_num          => p_num,
                                          p_user_id      => p_user_id,
                                          po_bound_num   => v_bound_num);
    ELSIF p_cpop_rec.prepare_object = 1 THEN
      --���Ϲ�Ӧ�� Ʒ�Ʋ� ���ɹ�Ӧ�̿��-��������ⵥ��
      p_generate_brand_inout_bound_by_mt(p_cpop_rec     => p_cpop_rec,
                                         p_store_type   => p_store_type,
                                         p_material_spu => p_material_spu,
                                         p_num          => p_num,
                                         p_user_id      => p_user_id,
                                         po_bound_num   => v_bound_num);
    ELSE
      NULL;
    END IF;
    po_bound_num := v_bound_num;
  END p_generate_brand_inout_bound;

  --��Ʒ��Ӧ�� ��Ӧ�̲�-������������ⵥ
  PROCEDURE p_generate_sup_brand_inout_bound_by_pro(p_cpop_rec     mrp.color_prepare_product_order%ROWTYPE,
                                                    p_store_type   INT,
                                                    p_material_spu VARCHAR2,
                                                    p_sup_num      NUMBER,
                                                    p_user_id      VARCHAR2) IS
    v_bound_num VARCHAR2(32);
    v_sgiob_rec mrp.supplier_grey_in_out_bound%ROWTYPE;
  BEGIN
    --��Ӧ�̲� ���ɹ�Ӧ�̿��-��������ⵥ��
    v_bound_num := mrp.pkg_plat_comm.f_get_docuno(pi_table_name  => 'SUPPLIER_GREY_IN_OUT_BOUND',
                                                  pi_column_name => 'BOUND_NUM',
                                                  pi_pre         => 'CPCK' ||
                                                                    to_char(trunc(SYSDATE),
                                                                            'YYYYMMDD'),
                                                  pi_serail_num  => 5); --��������ⵥ��
  
    --��Ʒ��Ӧ�� ��Ӧ�̲� ���ɹ�Ӧ�̿��-��������ⵥ��
    p_generate_brand_inout_bound_by_pro(p_cpop_rec     => p_cpop_rec,
                                        p_store_type   => p_store_type,
                                        p_material_spu => p_material_spu,
                                        p_num          => p_sup_num,
                                        p_user_id      => p_user_id,
                                        po_bound_num   => v_bound_num);
  
    --�ǣ���������ɵġ���Ӧ�̿��-��������ⵥ����Ϣ�����¡���Ӧ�̿��-�����ֿ����ϸ����Ӧ����
    SELECT gs.*
      INTO v_sgiob_rec
      FROM mrp.supplier_grey_in_out_bound gs
     WHERE gs.bound_num = v_bound_num
       AND gs.whether_del = 0;
  
    --���³�Ʒ��Ӧ�̿��-�����ֿ����ϸ
    p_generate_grey_stock(p_sgiob_rec   => v_sgiob_rec,
                          p_inout_stock => p_sup_num, --�������
                          p_user_id     => p_user_id);
  
  END p_generate_sup_brand_inout_bound_by_pro;

  --���Ϲ�Ӧ�� ��Ӧ�̲�-������������ⵥ
  PROCEDURE p_generate_sup_brand_inout_bound_by_mt(p_cpop_rec     mrp.color_prepare_product_order%ROWTYPE,
                                                   p_store_type   INT,
                                                   p_material_spu VARCHAR2,
                                                   p_sup_num      NUMBER,
                                                   p_user_id      VARCHAR2) IS
    v_bound_num VARCHAR2(32);
    v_mgiob_rec mrp.material_grey_in_out_bound%ROWTYPE;
  BEGIN
    --��Ӧ�̲� ���ɹ�Ӧ�̿��-��������ⵥ��
    p_generate_brand_inout_bound_by_mt(p_cpop_rec     => p_cpop_rec,
                                       p_store_type   => p_store_type,
                                       p_material_spu => p_material_spu,
                                       p_num          => p_sup_num,
                                       p_user_id      => p_user_id,
                                       po_bound_num   => v_bound_num);
    --�ǣ���������Ϲ�Ӧ�� ���ɵġ���Ӧ�̿��-��������ⵥ����Ϣ�����¡���Ӧ�̿��-�����ֿ����ϸ����Ӧ����   
    SELECT gs.*
      INTO v_mgiob_rec
      FROM mrp.material_grey_in_out_bound gs
     WHERE gs.bound_num = v_bound_num
       AND gs.whether_del = 0;
    --���¹�Ӧ�̿��-�����ֿ����ϸ
    p_generate_material_grey_stock(p_mgiob_rec   => v_mgiob_rec,
                                   p_inout_stock => p_sup_num, --�������
                                   p_user_id     => p_user_id);
  
  END p_generate_sup_brand_inout_bound_by_mt;

  --��Ʒ�����Ϲ�Ӧ�� ��Ӧ�̲�-������������ⵥ
  PROCEDURE p_generate_sup_brand_inout_bound(p_cpop_rec      mrp.color_prepare_product_order%ROWTYPE,
                                             p_store_type    INT,
                                             p_material_spu  VARCHAR2,
                                             p_brand_stock   NUMBER,
                                             p_dye_loss_late NUMBER,
                                             p_user_id       VARCHAR2) IS
    v_sup_brand_stock NUMBER(18, 2);
    v_flag            INT;
    v_sup_num         NUMBER; --��Ӧ�̲��� 
  BEGIN
    --��ȡ��Ӧ�ֿ̲����
    v_sup_brand_stock := f_get_brand_stock(p_company_id          => p_cpop_rec.company_id,
                                           p_prepare_object      => p_cpop_rec.prepare_object,
                                           p_pro_supplier_code   => p_cpop_rec.pro_supplier_code,
                                           p_mater_supplier_code => p_cpop_rec.mater_supplier_code,
                                           p_unit                => p_cpop_rec.unit,
                                           p_material_spu        => p_material_spu,
                                           p_store_type          => p_store_type);
    --�жϹ�Ӧ�̲��Ƿ��п�� 
    --�У���ִ��һ���߼�
    --�ޣ���������
    IF v_sup_brand_stock > 0 THEN
      --У�顰��Ӧ�̲�������桱ת��Ϊɫ���Ƿ���
      p_check_color_fabric_is_enough(p_brand_stock      => p_brand_stock,
                                     p_plan_product_num => p_cpop_rec.plan_product_quantity,
                                     p_sup_store_num    => v_sup_brand_stock,
                                     p_dye_loss_late    => p_dye_loss_late,
                                     p_store_type       => p_store_type,
                                     po_is_enough_flag  => v_flag,
                                     po_num             => v_sup_num);
    
      IF p_cpop_rec.prepare_object = 0 THEN
        --��Ʒ��Ӧ�� ��Ӧ�̲� ���ɹ�Ӧ�̿��-��������ⵥ��
        --���¹�Ӧ�̿��-�����ֿ����ϸ 
        p_generate_sup_brand_inout_bound_by_pro(p_cpop_rec     => p_cpop_rec,
                                                p_store_type   => p_store_type,
                                                p_material_spu => p_material_spu,
                                                p_sup_num      => v_sup_num,
                                                p_user_id      => p_user_id);
      
      ELSIF p_cpop_rec.prepare_object = 1 THEN
        --���Ϲ�Ӧ�� ��Ӧ�̲� ���ɹ�Ӧ�̿��-��������ⵥ��
        --���¹�Ӧ�̿��-�����ֿ����ϸ 
        p_generate_sup_brand_inout_bound_by_mt(p_cpop_rec     => p_cpop_rec,
                                               p_store_type   => p_store_type,
                                               p_material_spu => p_material_spu,
                                               p_sup_num      => v_sup_num,
                                               p_user_id      => p_user_id);
      END IF;
    ELSE
      NULL;
    END IF;
  END p_generate_sup_brand_inout_bound;

  --��Ʒ��Ӧ�� ���¡���Ӧ�̿��-�����ֿ����ϸ����Ӧ����
  PROCEDURE p_generate_grey_stock(p_sgiob_rec   mrp.supplier_grey_in_out_bound%ROWTYPE,
                                  p_inout_stock NUMBER,
                                  p_user_id     VARCHAR2) IS
  
  BEGIN
    UPDATE mrp.supplier_grey_stock gs
       SET gs.total_stock = (CASE
                              WHEN p_sgiob_rec.ascription = 1 THEN
                               gs.total_stock + p_inout_stock --���
                              WHEN p_sgiob_rec.ascription = 0 THEN
                               gs.total_stock - p_inout_stock --����
                              ELSE
                               0
                            END),
           gs.brand_stock = (CASE
                            --Ʒ�Ʋ�
                              WHEN p_sgiob_rec.stock_type = 1 THEN
                               (CASE
                                 WHEN p_sgiob_rec.ascription = 1 THEN
                                  gs.brand_stock + p_inout_stock --���
                                 WHEN p_sgiob_rec.ascription = 0 THEN
                                  gs.brand_stock - p_inout_stock --����
                                 ELSE
                                  0
                               END)
                            --��Ӧ�̲�
                              WHEN p_sgiob_rec.stock_type = 2 THEN
                               gs.brand_stock
                              ELSE
                               0
                            END),
           gs.supplier_stock = (CASE
                               --Ʒ�Ʋ�
                                 WHEN p_sgiob_rec.stock_type = 1 THEN
                                  gs.supplier_stock
                               --��Ӧ�̲�
                                 WHEN p_sgiob_rec.stock_type = 2 THEN
                                  (CASE
                                    WHEN p_sgiob_rec.ascription = 1 THEN
                                     gs.supplier_stock + p_inout_stock --���
                                    WHEN p_sgiob_rec.ascription = 0 THEN
                                     gs.supplier_stock - p_inout_stock --����
                                    ELSE
                                     0
                                  END)
                                 ELSE
                                  0
                               END),
           gs.update_id      = p_user_id,
           gs.update_time    = SYSDATE
     WHERE gs.company_id = p_sgiob_rec.company_id
       AND gs.pro_supplier_code = p_sgiob_rec.pro_supplier_code
       AND gs.mater_supplier_code = p_sgiob_rec.mater_supplier_code
       AND gs.material_spu = p_sgiob_rec.material_spu
       AND gs.unit = p_sgiob_rec.unit
       AND gs.whether_del = 0;
  END p_generate_grey_stock;

  --���Ϲ�Ӧ�� ���¡���Ӧ�̿��-�����ֿ����ϸ����Ӧ����
  PROCEDURE p_generate_material_grey_stock(p_mgiob_rec   mrp.material_grey_in_out_bound%ROWTYPE,
                                           p_inout_stock NUMBER,
                                           p_user_id     VARCHAR2) IS
  
  BEGIN
    UPDATE mrp.material_grey_stock gs
       SET gs.total_stock = (CASE
                              WHEN p_mgiob_rec.ascription = 1 THEN
                               gs.total_stock + p_inout_stock --���
                              WHEN p_mgiob_rec.ascription = 0 THEN
                               gs.total_stock - p_inout_stock --����
                              ELSE
                               0
                            END),
           gs.brand_stock = (CASE
                            --Ʒ�Ʋ�
                              WHEN p_mgiob_rec.stock_type = 1 THEN
                               (CASE
                                 WHEN p_mgiob_rec.ascription = 1 THEN
                                  gs.brand_stock + p_inout_stock --���
                                 WHEN p_mgiob_rec.ascription = 0 THEN
                                  gs.brand_stock - p_inout_stock --����
                                 ELSE
                                  0
                               END)
                            --��Ӧ�̲�
                              WHEN p_mgiob_rec.stock_type = 2 THEN
                               gs.brand_stock
                              ELSE
                               0
                            END),
           gs.supplier_stock = (CASE
                               --Ʒ�Ʋ�
                                 WHEN p_mgiob_rec.stock_type = 1 THEN
                                  gs.supplier_stock
                               --��Ӧ�̲�
                                 WHEN p_mgiob_rec.stock_type = 2 THEN
                                  (CASE
                                    WHEN p_mgiob_rec.ascription = 1 THEN
                                     gs.supplier_stock + p_inout_stock --���
                                    WHEN p_mgiob_rec.ascription = 0 THEN
                                     gs.supplier_stock - p_inout_stock --����
                                    ELSE
                                     0
                                  END)
                                 ELSE
                                  0
                               END),
           gs.update_id      = p_user_id,
           gs.update_time    = SYSDATE
     WHERE gs.company_id = p_mgiob_rec.company_id
       AND gs.mater_supplier_code = p_mgiob_rec.mater_supplier_code
       AND gs.material_spu = p_mgiob_rec.material_spu
       AND gs.unit = p_mgiob_rec.unit
       AND gs.whether_del = 0;
  END p_generate_material_grey_stock;

  --ȡ�����ϵ�
  PROCEDURE p_cancle_color_prepare_order(p_prepare_order_id VARCHAR2,
                                         p_cancel_reason    VARCHAR2,
                                         p_user_id          VARCHAR2) IS
  BEGIN
    --����У��
    --����״̬
    mrp.pkg_color_prepare_order.p_check_prepare_status(p_prepare_order_id => p_prepare_order_id,
                                                       p_prepare_status   => 1);
    --ȡ��ԭ��
    mrp.pkg_color_prepare_order.p_check_cancel_reason(p_cancel_reason => p_cancel_reason);
  
    --ȡ�����ϵ�
    mrp.pkg_color_prepare_order.p_update_color_prepare_order_status(p_prepare_order_id => p_prepare_order_id,
                                                                    p_cancel_reason    => p_cancel_reason,
                                                                    p_user_id          => p_user_id);
  
  END p_cancle_color_prepare_order;

  --�޸Ķ�������
  PROCEDURE p_update_order_num(p_prepare_order_id VARCHAR2,
                               p_order_num        VARCHAR2,
                               p_user_id          VARCHAR2) IS
  BEGIN
    --����У��
    --����״̬
    mrp.pkg_color_prepare_order.p_check_prepare_status(p_prepare_order_id => p_prepare_order_id,
                                                       p_prepare_status   => 1);
    --��������
    mrp.pkg_color_prepare_order.p_check_order_num(p_prepare_order_id => p_prepare_order_id,
                                                  p_order_num        => p_order_num);
  
    UPDATE mrp.color_prepare_order t
       SET t.order_num   = to_number(p_order_num),
           t.update_id   = p_user_id,
           t.update_time = SYSDATE
     WHERE t.prepare_order_id = p_prepare_order_id;
  END p_update_order_num;

  --�޸�Ԥ�Ƶ�������
  PROCEDURE p_update_expect_arrival_time(p_prepare_order_id    VARCHAR2,
                                         p_prepare_status      INT,
                                         p_expect_arrival_time DATE,
                                         p_user_id             VARCHAR2) IS
  BEGIN
    --����У��
    --����״̬
    mrp.pkg_color_prepare_order.p_check_prepare_status(p_prepare_order_id => p_prepare_order_id,
                                                       p_prepare_status   => p_prepare_status);
    --Ԥ�Ƶ�������
    mrp.pkg_color_prepare_order.p_check_expect_arrival_time(p_prepare_order_id    => p_prepare_order_id,
                                                            p_expect_arrival_time => to_char(p_expect_arrival_time,
                                                                                             'yyyy-mm-dd'));
  
    UPDATE mrp.color_prepare_order t
       SET t.expect_arrival_time = to_date(to_char(p_expect_arrival_time,
                                                   'yyyy-mm-dd') ||
                                           ' 12:00:00',
                                           'yyyy-mm-dd hh:mi:ss'),
           t.expect_update_num   = t.expect_update_num + 1,
           t.update_id           = p_user_id,
           t.update_time         = SYSDATE
     WHERE t.prepare_order_id = p_prepare_order_id;
  END p_update_expect_arrival_time;

  --�������߼�
  --ȡ������
  PROCEDURE p_cancel_product_order(p_product_order_id VARCHAR2,
                                   p_user_id          VARCHAR2,
                                   p_cancel_reason    VARCHAR2) IS
  BEGIN
    --����У��
    --������״̬
    mrp.pkg_color_prepare_product_order.p_check_product_status(p_product_order_id => p_product_order_id,
                                                               p_product_status   => 1);
    --ȡ��ԭ��
    mrp.pkg_color_prepare_order.p_check_cancel_reason(p_cancel_reason => p_cancel_reason);
  
    --ȡ��������
    UPDATE mrp.color_prepare_product_order t
       SET t.product_status = 3,
           t.cancel_id      = p_user_id,
           t.cancel_time    = SYSDATE,
           t.cancel_reason  = p_cancel_reason
     WHERE t.product_order_id = p_product_order_id;
  
    --ȡ�����ϵ�
    FOR cpo_rec IN (SELECT po.prepare_order_id
                      FROM mrp.color_prepare_order po
                     WHERE po.product_order_id = p_product_order_id) LOOP
      mrp.pkg_color_prepare_order.p_update_color_prepare_order_status(p_prepare_order_id => cpo_rec.prepare_order_id,
                                                                      p_cancel_reason    => p_cancel_reason,
                                                                      p_user_id          => p_user_id);
    END LOOP;
  END p_cancel_product_order;

  --��ɶ���
  PROCEDURE p_finish_product_order(p_product_order_id     VARCHAR2,
                                   p_cur_finished_num     VARCHAR2,
                                   p_is_finished_preorder NUMBER,
                                   p_company_id           VARCHAR2,
                                   p_user_id              VARCHAR2) IS
    v_cppo_rec               mrp.color_prepare_product_order%ROWTYPE;
    v_batch_finish_num       NUMBER; --���������
    v_batch_finish_percent   NUMBER; --������ɰٷֱ�
    v_batch_finish_percent_d NUMBER; --������ɰٷֱ� С��
  BEGIN
    SELECT *
      INTO v_cppo_rec
      FROM mrp.color_prepare_product_order t
     WHERE t.product_order_id = p_product_order_id;
  
    --У��������״̬
    mrp.pkg_color_prepare_product_order.p_check_product_status(p_product_order_id => p_product_order_id,
                                                               p_product_status   => 1);
    --����У��
    mrp.pkg_color_prepare_product_order.p_check_cur_finished_num(p_cur_finished_num => p_cur_finished_num);
    mrp.pkg_color_prepare_product_order.p_check_is_finished_preorder(p_is_finished_preorder => p_is_finished_preorder);
    --���װ��3% У��
    mrp.pkg_color_prepare_product_order.p_check_more_less_clause(p_cur_finished_num     => p_cur_finished_num,
                                                                 p_finished_num         => v_cppo_rec.batch_finish_num,
                                                                 p_order_num            => v_cppo_rec.plan_product_quantity,
                                                                 p_rate                 => 0.03,
                                                                 p_is_finished_preorder => p_is_finished_preorder);
    --У��ͨ�����������±�
    --1.ɫ�����Ϸ�����ɵ���
    DECLARE
      v_cpbfo_rec mrp.color_prepare_batch_finish_order%ROWTYPE;
    BEGIN
      v_cpbfo_rec.prepare_batch_finish_id := mrp.pkg_plat_comm.f_get_docuno(pi_table_name  => 'COLOR_PREPARE_BATCH_FINISH_ORDER',
                                                                            pi_column_name => 'PREPARE_BATCH_FINISH_ID',
                                                                            pi_pre         => p_product_order_id,
                                                                            pi_serail_num  => 2); --ɫ��������ɵ���
      v_cpbfo_rec.product_order_id        := p_product_order_id; --ɫ����������
      v_cpbfo_rec.batch_finish_time       := SYSDATE; --�������ʱ��
      v_cpbfo_rec.unit                    := v_cppo_rec.unit; --��λ
      v_cpbfo_rec.batch_finish_num        := to_number(p_cur_finished_num); --�����������
      v_cpbfo_rec.batch_finish_percent    := round(to_number(p_cur_finished_num) /
                                                   v_cppo_rec.plan_product_quantity,
                                                   4) * 100; --������ɰٷֱ�  ps:��ʱ��plmͳһ�ٷֱȸ�ʽ
      v_cpbfo_rec.batch_finish_id         := p_user_id; --���������
      v_cpbfo_rec.create_id               := p_user_id; --������
      v_cpbfo_rec.create_time             := SYSDATE; --����ʱ��
      v_cpbfo_rec.update_id               := p_user_id; --������
      v_cpbfo_rec.update_time             := SYSDATE; --����ʱ��
      v_cpbfo_rec.whether_del             := 0; --�Ƿ�ɾ����0��1��
    
      mrp.pkg_color_prepare_batch_finish_order.p_insert_color_prepare_batch_finish_order(p_color_rec => v_cpbfo_rec);
    END;
  
    --���������
    v_batch_finish_num := v_cppo_rec.batch_finish_num + p_cur_finished_num;
    --��������ۼưٷֱ�
    v_batch_finish_percent := round((v_batch_finish_num) /
                                    v_cppo_rec.plan_product_quantity,
                                    4) * 100;
  
    v_batch_finish_percent_d := v_batch_finish_percent / 100;
  
    --2.�޸�ɫ���������������������   
    BEGIN
      IF p_is_finished_preorder = 1 THEN
        v_cppo_rec.product_status := 2; --������״̬��1�����У�2����ɣ�3��ȡ��
        v_cppo_rec.finish_id      := p_user_id; --�������
        v_cppo_rec.finish_num     := v_batch_finish_num; --���������
        v_cppo_rec.finish_time    := SYSDATE; --���������
        v_cppo_rec.complete_num   := 0; --���������
      
      ELSE
        v_cppo_rec.complete_num := v_cppo_rec.plan_product_quantity -
                                   v_batch_finish_num; --���������
      END IF;
    
      v_cppo_rec.batch_finish_num     := v_batch_finish_num; --��������ۼ�����   
      v_cppo_rec.batch_finish_percent := v_batch_finish_percent; --��������ۼưٷֱ�
      v_cppo_rec.update_id            := p_user_id; --������
      v_cppo_rec.update_time          := SYSDATE; --����ʱ��
      mrp.pkg_color_prepare_product_order.p_update_color_prepare_product_order(p_color_rec => v_cppo_rec);
    END;
    --3.ɫ�����ϵ���
    --�����Ƿ���ɱ��ϵ���=��ʱ�������
    --���򣬲�������
    BEGIN
      FOR cpo_rec IN (SELECT *
                        FROM mrp.color_prepare_order t
                       WHERE t.product_order_id = p_product_order_id) LOOP
        IF p_is_finished_preorder = 1 THEN
          cpo_rec.prepare_status := 3; --����״̬��0����ˣ�1���ӵ���2�����У�3����ɣ�4��ȡ��
          cpo_rec.finish_id      := p_user_id; --�����
          cpo_rec.finish_num     := v_batch_finish_percent_d *
                                    cpo_rec.order_num; --�������
          cpo_rec.finish_time    := SYSDATE; --�������
        ELSE
          NULL;
        END IF;
        cpo_rec.batch_finish_num     := v_batch_finish_percent_d *
                                        cpo_rec.order_num; --��������ۼ�����
        cpo_rec.batch_finish_percent := v_batch_finish_percent; --��������ۼưٷֱ�
        cpo_rec.complete_num         := cpo_rec.order_num *
                                        (1 - v_batch_finish_percent_d); --���������
      
        cpo_rec.update_id   := p_user_id; --������
        cpo_rec.update_time := SYSDATE; --����ʱ��   
        mrp.pkg_color_prepare_order.p_update_color_prepare_order(p_color_rec => cpo_rec);
      END LOOP;
    END;
    --4.���ݡ����϶���(0��Ʒ��Ӧ�̣�1���Ϲ�Ӧ��)���������ɫ������ⵥ��ɫ���ֿ����ϸ��
    DECLARE
      vo_bound_num VARCHAR2(32);
      v_sciob_rec  mrp.supplier_color_in_out_bound%ROWTYPE;
      v_mciob_rec  mrp.material_color_in_out_bound%ROWTYPE;
    BEGIN
      IF v_cppo_rec.prepare_object = 0 THEN
        --4.1 ɫ�����
        p_color_cloth_storage(p_cppo_rec   => v_cppo_rec,
                              p_company_id => p_company_id,
                              p_user_id    => p_user_id,
                              p_batch_num  => v_batch_finish_num,
                              po_bound_num => vo_bound_num);
        --4.2 ɫ���ֿ����ϸ
        SELECT *
          INTO v_sciob_rec
          FROM mrp.supplier_color_in_out_bound t
         WHERE t.bound_num = vo_bound_num;
      
        p_sync_supplier_color_cloth_stock(p_sciob_rec  => v_sciob_rec,
                                          p_company_id => p_company_id,
                                          p_user_id    => p_user_id);
      ELSIF v_cppo_rec.prepare_object = 1 THEN
        --4.3 ɫ�����
        p_material_color_cloth_storage(p_cppo_rec   => v_cppo_rec,
                                       p_company_id => p_company_id,
                                       p_user_id    => p_user_id,
                                       p_batch_num  => v_batch_finish_num,
                                       po_bound_num => vo_bound_num);
        --4.4 ɫ���ֿ����ϸ
        SELECT *
          INTO v_mciob_rec
          FROM mrp.material_color_in_out_bound t
         WHERE t.bound_num = vo_bound_num;
      
        p_sync_material_color_cloth_stock(p_mciob_rec  => v_mciob_rec,
                                          p_company_id => p_company_id,
                                          p_user_id    => p_user_id);
      ELSE
        NULL;
      END IF;
    END;
  END p_finish_product_order;

  --��Ʒ��Ӧ�� ɫ�����
  PROCEDURE p_color_cloth_storage(p_cppo_rec   mrp.color_prepare_product_order%ROWTYPE,
                                  p_company_id VARCHAR2,
                                  p_user_id    VARCHAR2,
                                  p_batch_num  NUMBER,
                                  po_bound_num OUT VARCHAR2) IS
    v_sciob_rec supplier_color_in_out_bound%ROWTYPE;
    v_bound_num VARCHAR2(32);
  BEGIN
    v_bound_num                     := mrp.pkg_plat_comm.f_get_docuno(pi_table_name  => 'SUPPLIER_COLOR_IN_OUT_BOUND',
                                                                      pi_column_name => 'BOUND_NUM',
                                                                      pi_pre         => 'CKRK' ||
                                                                                        to_char(trunc(SYSDATE),
                                                                                                'YYYYMMDD'),
                                                                      pi_serail_num  => 5);
    v_sciob_rec.bound_num           := v_bound_num; --ɫ������ⵥ��
    v_sciob_rec.ascription          := 1; --����������0����1���
    v_sciob_rec.bound_type          := 10; --��������ͣ�1�������⣬2�̿����⣬3���ϳ��⣬10Ʒ�Ʊ�����⣬11��Ӧ���ֻ���⣬12��ʱ������⣬13��ӯ��⣬14��ʱ��תɫ��� 15 ��Ӧ��ɫ����� 16 ��Ӧ���ֻ�����
    v_sciob_rec.pro_supplier_code   := p_cppo_rec.pro_supplier_code; --��Ʒ��Ӧ�̱��
    v_sciob_rec.mater_supplier_code := p_cppo_rec.mater_supplier_code; --���Ϲ�Ӧ�̱��
    v_sciob_rec.material_sku        := p_cppo_rec.material_sku; --����SKU
    v_sciob_rec.whether_inner_mater := p_cppo_rec.whether_inner_mater; --�Ƿ��ڲ����ϣ�0��1��
    v_sciob_rec.unit                := p_cppo_rec.unit; --��λ
    v_sciob_rec.num                 := p_batch_num; --���� 
    v_sciob_rec.stock_type          := 1; --�ֿ����ͣ�1Ʒ�Ʋ֣�2��Ӧ�̲�
    v_sciob_rec.relate_num          := p_cppo_rec.product_order_id; --��������
    v_sciob_rec.relate_num_type     := 1; --�����������ͣ�1ɫ��������/2ɫ���̵㵥/3ɫ�����ϵ�/4���ϲɹ���/5�������ⵥ
    v_sciob_rec.relate_skc          := p_cppo_rec.relate_skc; --����SKC
    v_sciob_rec.relate_purchase     := NULL; --�����ɹ�����
    v_sciob_rec.company_id          := p_company_id; --��ҵ����
    v_sciob_rec.create_id           := p_user_id; --������
    v_sciob_rec.create_time         := SYSDATE; --����ʱ��
    v_sciob_rec.update_id           := p_user_id; --������
    v_sciob_rec.update_time         := SYSDATE; --����ʱ��
    v_sciob_rec.whether_del         := 0; --�Ƿ�ɾ����0��1��
  
    mrp.pkg_supplier_color_in_out_bound.p_insert_supplier_color_in_out_bound(p_suppl_rec => v_sciob_rec);
  
    po_bound_num := v_bound_num;
  END p_color_cloth_storage;

  --���Ϲ�Ӧ�� ɫ�����
  PROCEDURE p_material_color_cloth_storage(p_cppo_rec   mrp.color_prepare_product_order%ROWTYPE,
                                           p_company_id VARCHAR2,
                                           p_user_id    VARCHAR2,
                                           p_batch_num  NUMBER,
                                           po_bound_num OUT VARCHAR2) IS
    v_mciob_rec material_color_in_out_bound%ROWTYPE;
    v_bound_num VARCHAR2(32);
  BEGIN
    v_bound_num                     := mrp.pkg_plat_comm.f_get_docuno(pi_table_name  => 'MATERIAL_COLOR_IN_OUT_BOUND',
                                                                      pi_column_name => 'BOUND_NUM',
                                                                      pi_pre         => 'WKRK' ||
                                                                                        to_char(trunc(SYSDATE),
                                                                                                'YYYYMMDD'),
                                                                      pi_serail_num  => 5);
    v_mciob_rec.bound_num           := v_bound_num; --ɫ������ⵥ��
    v_mciob_rec.ascription          := 1; --����������0����1���
    v_mciob_rec.bound_type          := 10; --��������ͣ�1�������⣬2�̿����⣬3���ϳ��⣬10Ʒ�Ʊ�����⣬11��Ӧ���ֻ���⣬12��ʱ������⣬13��ӯ��⣬14��ʱ��תɫ��� 15 ��Ӧ��ɫ����� 16 ��Ӧ���ֻ�����
    v_mciob_rec.mater_supplier_code := p_cppo_rec.mater_supplier_code; --���Ϲ�Ӧ�̱��
    v_mciob_rec.material_sku        := p_cppo_rec.material_sku; --����SKU
    v_mciob_rec.unit                := p_cppo_rec.unit; --��λ
    v_mciob_rec.num                 := p_batch_num; --����
    v_mciob_rec.stock_type          := 1; --�ֿ����ͣ�1Ʒ�Ʋ֣�2��Ӧ�̲�
    v_mciob_rec.relate_num          := p_cppo_rec.product_order_id; --��������
    v_mciob_rec.relate_num_type     := 1; --�����������ͣ�1ɫ��������/2ɫ���̵㵥/3ɫ�����ϵ�/4���ϲɹ���/5�������ⵥ
    v_mciob_rec.relate_skc          := p_cppo_rec.relate_skc; --����SKC
    v_mciob_rec.relate_purchase     := NULL; --�����ɹ�����
    v_mciob_rec.company_id          := p_company_id; --��ҵ����
    v_mciob_rec.create_id           := p_user_id; --������
    v_mciob_rec.create_time         := SYSDATE; --����ʱ��
    v_mciob_rec.update_id           := p_user_id; --������
    v_mciob_rec.update_time         := SYSDATE; --����ʱ��
    v_mciob_rec.whether_del         := 0; --�Ƿ�ɾ����0��1��
    v_mciob_rec.whether_inner_mater := p_cppo_rec.whether_inner_mater; --�Ƿ��ڲ����ϣ�0��1��
  
    mrp.pkg_material_color_in_out_bound.p_insert_material_color_in_out_bound(p_mater_rec => v_mciob_rec);
  
    po_bound_num := v_bound_num;
  END p_material_color_cloth_storage;

  --�Ƿ��ҵ�ɫ�����
  --���ֱ��϶��� 
  --p_prepare_object��0 ��Ʒ��Ӧ�� 1 ���Ϲ�Ӧ��
  FUNCTION f_is_find_color_stock(p_pro_supplier_code   VARCHAR2 DEFAULT NULL,
                                 p_mater_supplier_code VARCHAR2,
                                 p_material_sku        VARCHAR2,
                                 p_unit                VARCHAR2,
                                 p_prepare_object      INT) RETURN NUMBER IS
    v_cnt NUMBER := 0;
  BEGIN
    IF p_prepare_object = 0 THEN
      SELECT COUNT(1)
        INTO v_cnt
        FROM mrp.supplier_color_cloth_stock t
       WHERE t.pro_supplier_code = p_pro_supplier_code
         AND t.mater_supplier_code = p_mater_supplier_code
         AND t.material_sku = p_material_sku
         AND t.unit = p_unit;
    ELSIF p_prepare_object = 1 THEN
      SELECT COUNT(1)
        INTO v_cnt
        FROM mrp.material_color_cloth_stock t
       WHERE t.mater_supplier_code = p_mater_supplier_code
         AND t.material_sku = p_material_sku
         AND t.unit = p_unit;
    ELSE
      NULL;
    END IF;
    RETURN v_cnt;
  END f_is_find_color_stock;

  --��Ʒ��Ӧ�� ɫ���ֿ��
  PROCEDURE p_sync_supplier_color_cloth_stock(p_sciob_rec  mrp.supplier_color_in_out_bound%ROWTYPE,
                                              p_company_id VARCHAR2,
                                              p_user_id    VARCHAR2) IS
    v_sccs_rec supplier_color_cloth_stock%ROWTYPE;
    v_flag     INT;
  BEGIN
    --�Ƿ��ҵ�ɫ�����
    v_flag := f_is_find_color_stock(p_pro_supplier_code   => p_sciob_rec.pro_supplier_code,
                                    p_mater_supplier_code => p_sciob_rec.mater_supplier_code,
                                    p_material_sku        => p_sciob_rec.material_sku,
                                    p_unit                => p_sciob_rec.unit,
                                    p_prepare_object      => 0);
    IF v_flag > 0 THEN
      UPDATE mrp.supplier_color_cloth_stock t
         SET t.total_stock = nvl(t.total_stock, 0) + nvl(p_sciob_rec.num, 0),
             t.brand_stock = nvl(t.brand_stock, 0) + nvl(p_sciob_rec.num, 0),
             t.update_id   = p_user_id,
             t.update_time = SYSDATE
       WHERE t.pro_supplier_code = p_sciob_rec.pro_supplier_code
         AND t.mater_supplier_code = p_sciob_rec.mater_supplier_code
         AND t.material_sku = p_sciob_rec.material_sku
         AND t.unit = p_sciob_rec.unit;
    ELSE
      v_sccs_rec.color_cloth_stock_id := mrp.pkg_plat_comm.f_get_uuid(); --��Ӧ��ɫ���������
      v_sccs_rec.pro_supplier_code    := p_sciob_rec.pro_supplier_code; --��Ʒ��Ӧ�̱��
      v_sccs_rec.mater_supplier_code  := p_sciob_rec.mater_supplier_code; --���Ϲ�Ӧ�̱��
      v_sccs_rec.material_sku         := p_sciob_rec.material_sku; --����SKU
      v_sccs_rec.whether_inner_mater  := p_sciob_rec.whether_inner_mater; --�Ƿ��ڲ����ϣ�0��1��
      v_sccs_rec.unit                 := p_sciob_rec.unit; --��λ
      v_sccs_rec.total_stock          := nvl(v_sccs_rec.total_stock, 0) +
                                         nvl(p_sciob_rec.num, 0); --�ܿ����
      v_sccs_rec.brand_stock          := nvl(v_sccs_rec.brand_stock, 0) +
                                         nvl(p_sciob_rec.num, 0); --Ʒ�Ʋֿ����
      v_sccs_rec.supplier_stock       := 0; --��Ӧ�ֿ̲����
      v_sccs_rec.company_id           := p_company_id; --��ҵ����
      v_sccs_rec.create_id            := p_user_id; --������
      v_sccs_rec.create_time          := SYSDATE; --����ʱ��
      v_sccs_rec.update_id            := p_user_id; --������
      v_sccs_rec.update_time          := SYSDATE; --����ʱ��
      v_sccs_rec.whether_del          := 0; --�Ƿ�ɾ����0��1��
    
      mrp.pkg_supplier_color_cloth_stock.p_insert_supplier_color_cloth_stock(p_suppl_rec => v_sccs_rec);
    END IF;
  END p_sync_supplier_color_cloth_stock;

  --���Ϲ�Ӧ�� ɫ���ֿ��
  PROCEDURE p_sync_material_color_cloth_stock(p_mciob_rec  mrp.material_color_in_out_bound%ROWTYPE,
                                              p_company_id VARCHAR2,
                                              p_user_id    VARCHAR2) IS
    v_mccs_rec material_color_cloth_stock%ROWTYPE;
    v_flag     INT;
  BEGIN
    --�Ƿ��ҵ�ɫ�����
    v_flag := f_is_find_color_stock(p_mater_supplier_code => p_mciob_rec.mater_supplier_code,
                                    p_material_sku        => p_mciob_rec.material_sku,
                                    p_unit                => p_mciob_rec.unit,
                                    p_prepare_object      => 1);
    IF v_flag > 0 THEN
      UPDATE mrp.material_color_cloth_stock t
         SET t.total_stock = nvl(t.total_stock, 0) + nvl(p_mciob_rec.num, 0),
             t.brand_stock = nvl(t.brand_stock, 0) + nvl(p_mciob_rec.num, 0),
             t.update_id   = p_user_id,
             t.update_time = SYSDATE
       WHERE t.mater_supplier_code = p_mciob_rec.mater_supplier_code
         AND t.material_sku = p_mciob_rec.material_sku
         AND t.unit = p_mciob_rec.unit;
    ELSE
      v_mccs_rec.color_cloth_stock_id := mrp.pkg_plat_comm.f_get_uuid(); --��Ӧ��ɫ���������
      v_mccs_rec.mater_supplier_code  := p_mciob_rec.mater_supplier_code; --���Ϲ�Ӧ�̱��
      v_mccs_rec.material_sku         := p_mciob_rec.material_sku; --����SKU
      v_mccs_rec.unit                 := p_mciob_rec.unit; --��λ
      v_mccs_rec.total_stock          := nvl(v_mccs_rec.total_stock, 0) +
                                         nvl(p_mciob_rec.num, 0); --�ܿ����
      v_mccs_rec.brand_stock          := nvl(v_mccs_rec.brand_stock, 0) +
                                         nvl(p_mciob_rec.num, 0); --Ʒ�Ʋֿ����
      v_mccs_rec.supplier_stock       := 0; --��Ӧ�ֿ̲����
      v_mccs_rec.company_id           := p_company_id; --��ҵ����
      v_mccs_rec.create_id            := p_user_id; --������
      v_mccs_rec.create_time          := SYSDATE; --����ʱ��
      v_mccs_rec.update_id            := p_user_id; --������
      v_mccs_rec.update_time          := SYSDATE; --����ʱ��
      v_mccs_rec.whether_del          := 0; --�Ƿ�ɾ����0��1��
    
      mrp.pkg_material_color_cloth_stock.p_insert_material_color_cloth_stock(p_mater_rec => v_mccs_rec);
    END IF;
  END p_sync_material_color_cloth_stock;

  --���Ͻ��Ȳ�ѯ  
  FUNCTION f_query_prepare_order_process(p_order_num VARCHAR2) RETURN CLOB IS
    v_pick_sql     CLOB;
    v_purchase_sql CLOB;
    v_sql          CLOB;
  BEGIN
    v_pick_sql     := mrp.pkg_pick_list.f_query_pick_list(p_order_num => p_order_num);
    v_purchase_sql := mrp.pkg_t_fabric_purchase_sheet.f_query_t_fabric_purchase_sheet(p_order_num => p_order_num);
  
    v_sql := v_pick_sql || ' UNION ALL ' || v_purchase_sql;
    RETURN v_sql;
  END f_query_prepare_order_process;

  --����״̬ͬ�����������ȱ�
  PROCEDURE p_sync_prepare_status(p_order_num  VARCHAR2,
                                  p_company_id VARCHAR2) IS
    v_pcnt   INT;
    v_fcnt   INT;
    v_cnt    INT;
    v_status VARCHAR2(32);
  BEGIN
    SELECT COUNT(1)
      INTO v_pcnt
      FROM mrp.pick_list t
     WHERE t.relate_product_order_num = p_order_num;
  
    SELECT COUNT(1)
      INTO v_fcnt
      FROM mrp.t_fabric_purchase_sheet t
     WHERE t.purchase_order_num = p_order_num
       AND t.company_id = p_company_id;
  
    v_cnt := v_pcnt + v_fcnt;
  
    IF v_cnt = 0 THEN
      v_status := '00'; --�ޱ���
    ELSE
      --���ϵ�
      SELECT COUNT(1) cnt
        INTO v_pcnt
        FROM mrp.pick_list t
       WHERE t.relate_product_order_num = p_order_num
         AND t.pick_status = 0;
    
      --���ϲɹ���
      SELECT SUM(va.cnt) cnt
        INTO v_fcnt
        FROM (SELECT COUNT(1) cnt
                FROM mrp.t_fabric_purchase_sheet t
               WHERE t.purchase_order_num = p_order_num
                 AND t.fabric_status IN ('S00', 'S01', 'S02', 'S03')) va;
    
      v_cnt := v_pcnt + v_fcnt;
    
      IF v_cnt > 0 THEN
        v_status := '01'; --δ���
      ELSE
        v_status := '02'; --�����
      END IF;
    END IF;
  
    --������״̬ͬ�����������ȱ�
    UPDATE scmdata.t_production_progress t
       SET t.prepare_status = v_status
     WHERE t.product_gress_code = p_order_num
       AND t.company_id = p_company_id;
  
  END p_sync_prepare_status;
END pkg_color_prepare_order_manager;
/
