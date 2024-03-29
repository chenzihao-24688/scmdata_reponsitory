﻿CREATE OR REPLACE FORCE VIEW MRP.V_COLOR_PREPARE_ORDER AS
SELECT "GROUP_KEY",
       "GOODS_SKC",
       "COMPANY_ID",
       "PRO_SUPPLIER_CODE",
       "MATER_SUPPLIER_CODE",
       "MATERIAL_NAME",
       "IS_DELAY",
       "FEATURES",
       "SUPPLIER_COLOR",
       "SUPPLIER_SHADES",
       "UNIT",
       "ORDER_CNT",
       "ORDER_NUM",
       "PRACTICAL_DOOR_WITH",
       "GRAM_WEIGHT",
       "MATERIAL_SPECIFICATIONS",
       "MATERIAL_SKU",
       "ORDER_TIME",
       "PREPARE_STATUS",
       "PREPARE_OBJECT",
       "FINISH_NUM",
       "PRODUCT_ORDER_ID",
       "RN"
  FROM (SELECT po.group_key,
               po.goods_skc,
               po.company_id,
               po.pro_supplier_code,
               po.mater_supplier_code,
               po.material_name,
               decode(sign(to_number((CASE
                                       WHEN po.prepare_status IN (1, 2, 4) THEN
                                        SYSDATE
                                       WHEN po.prepare_status = 3 THEN
                                        po.finish_time
                                       ELSE
                                        NULL
                                     END) - MIN(po.expect_arrival_time)
                                     over(PARTITION BY po.group_key,
                                          po.prepare_object,
                                          po.prepare_status))),
                      1,
                      '是',
                      '否') is_delay,
               po.features,
               po.supplier_color,
               po.supplier_shades,
               po.unit,
               COUNT(po.prepare_order_id) over(PARTITION BY po.group_key, po.prepare_object, po.prepare_status) order_cnt,
               SUM(po.order_num) over(PARTITION BY po.group_key, po.prepare_object, po.prepare_status) order_num,
               po.practical_door_with,
               po.gram_weight,
               po.material_specifications,
               po.material_sku,
               po.order_time,
               po.prepare_status,
               po.prepare_object,
               po.finish_num,
               po.product_order_id,
               row_number() over(PARTITION BY po.group_key, po.prepare_object, po.prepare_status ORDER BY po.order_time DESC) rn
          FROM mrp.color_prepare_order po
         WHERE po.whether_del = 0) va
 WHERE va.rn = 1;

