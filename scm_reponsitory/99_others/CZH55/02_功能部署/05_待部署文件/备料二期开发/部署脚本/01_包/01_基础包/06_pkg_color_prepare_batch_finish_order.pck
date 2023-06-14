CREATE OR REPLACE PACKAGE mrp.pkg_color_prepare_batch_finish_order IS
  --查询 COLOR_PREPARE_BATCH_FINISH_ORDER
  FUNCTION f_query_color_prepare_batch_finish_order RETURN CLOB;

  --新增 COLOR_PREPARE_BATCH_FINISH_ORDER
  PROCEDURE p_insert_color_prepare_batch_finish_order(p_color_rec color_prepare_batch_finish_order%ROWTYPE);

  --修改 COLOR_PREPARE_BATCH_FINISH_ORDER
  PROCEDURE p_update_color_prepare_batch_finish_order(p_color_rec color_prepare_batch_finish_order%ROWTYPE);

  --删除 COLOR_PREPARE_BATCH_FINISH_ORDER
  PROCEDURE p_delete_color_prepare_batch_finish_order(p_color_rec color_prepare_batch_finish_order%ROWTYPE);

END pkg_color_prepare_batch_finish_order;
/
CREATE OR REPLACE PACKAGE BODY mrp.pkg_color_prepare_batch_finish_order IS
  --查询 COLOR_PREPARE_BATCH_FINISH_ORDER
  FUNCTION f_query_color_prepare_batch_finish_order RETURN CLOB IS
    v_sql CLOB;
  
  BEGIN
    v_sql := '
SELECT t.prepare_batch_finish_id, --色布分批完成单号
       t.product_order_id, --色布生产单号
       t.batch_finish_time, --分批完成时间
       t.unit, --单位
       t.batch_finish_num, --分批完成数量
       t.batch_finish_percent, --分批完成百分比
       t.batch_finish_id, --分批完成人
       t.create_id, --创建者
       t.create_time, --创建时间
       t.update_id, --更新者
       t.update_time, --更新时间
       t.whether_del --是否删除，0否1是
  FROM color_prepare_batch_finish_order t
 WHERE 1 = 1
';
    RETURN v_sql;
  END f_query_color_prepare_batch_finish_order;

  --新增 COLOR_PREPARE_BATCH_FINISH_ORDER
  PROCEDURE p_insert_color_prepare_batch_finish_order(p_color_rec color_prepare_batch_finish_order%ROWTYPE) IS
  BEGIN
  
    INSERT INTO color_prepare_batch_finish_order
      (prepare_batch_finish_id, product_order_id, batch_finish_time, unit,
       batch_finish_num, batch_finish_percent, batch_finish_id, create_id,
       create_time, update_id, update_time, whether_del)
    VALUES
      (p_color_rec.prepare_batch_finish_id, p_color_rec.product_order_id,
       p_color_rec.batch_finish_time, p_color_rec.unit,
       p_color_rec.batch_finish_num, p_color_rec.batch_finish_percent,
       p_color_rec.batch_finish_id, p_color_rec.create_id,
       p_color_rec.create_time, p_color_rec.update_id,
       p_color_rec.update_time, p_color_rec.whether_del);
  END p_insert_color_prepare_batch_finish_order;

  --修改 COLOR_PREPARE_BATCH_FINISH_ORDER
  PROCEDURE p_update_color_prepare_batch_finish_order(p_color_rec color_prepare_batch_finish_order%ROWTYPE) IS
  BEGIN
  
    UPDATE color_prepare_batch_finish_order t
       SET t.product_order_id     = p_color_rec.product_order_id, --色布生产单号
           t.batch_finish_time    = p_color_rec.batch_finish_time, --分批完成时间
           t.unit                 = p_color_rec.unit, --单位
           t.batch_finish_num     = p_color_rec.batch_finish_num, --分批完成数量
           t.batch_finish_percent = p_color_rec.batch_finish_percent, --分批完成百分比
           t.batch_finish_id      = p_color_rec.batch_finish_id, --分批完成人
           t.create_id            = p_color_rec.create_id, --创建者
           t.create_time          = p_color_rec.create_time, --创建时间
           t.update_id            = p_color_rec.update_id, --更新者
           t.update_time          = p_color_rec.update_time, --更新时间
           t.whether_del          = p_color_rec.whether_del --是否删除，0否1是
     WHERE t.prepare_batch_finish_id = p_color_rec.prepare_batch_finish_id;
  END p_update_color_prepare_batch_finish_order;

  --删除 COLOR_PREPARE_BATCH_FINISH_ORDER
  PROCEDURE p_delete_color_prepare_batch_finish_order(p_color_rec color_prepare_batch_finish_order%ROWTYPE) IS
  BEGIN 
    DELETE FROM color_prepare_batch_finish_order t WHERE 1 = 0;
  END p_delete_color_prepare_batch_finish_order;

END pkg_color_prepare_batch_finish_order;
/
