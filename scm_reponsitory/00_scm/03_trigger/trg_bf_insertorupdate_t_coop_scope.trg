CREATE OR REPLACE TRIGGER SCMDATA.trg_bf_insertorupdate_t_coop_scope
  BEFORE INSERT OR UPDATE OR DELETE ON t_coop_scope
  FOR EACH ROW
DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION;
  v_flag NUMBER := 0; --校验重复
  v_num  NUMBER := 0; --校验是否只剩最后一条
BEGIN
  --1) 新增/更新 校验合作分类，可生产类别，可合作产品子类不可重复
  IF inserting THEN
    SELECT COUNT(1)
      INTO v_flag
      FROM t_coop_scope t
     WHERE t.company_id = :new.company_id
       AND t.supplier_info_id = :new.supplier_info_id
       AND t.coop_classification = :new.coop_classification
       AND t.coop_product_cate = :new.coop_product_cate
       AND t.coop_scope_id <> :new.coop_scope_id;

  ELSIF updating THEN
    SELECT COUNT(1)
      INTO v_flag
      FROM t_coop_scope t
     WHERE t.coop_classification = :new.coop_classification
       AND t.coop_product_cate = :new.coop_product_cate
       AND t.company_id = :old.company_id
       AND t.supplier_info_id = :old.supplier_info_id
       AND t.coop_scope_id <> :old.coop_scope_id;
  ELSIF deleting THEN
    --2) 删除 当合作范围只有1条数据时，不可删除
    SELECT COUNT(1)
      INTO v_num
      FROM t_coop_scope t
     WHERE t.company_id = :old.company_id
       AND t.supplier_info_id = :old.supplier_info_id
       AND t.coop_scope_id = :old.coop_scope_id;
    IF v_num = 1 THEN
      raise_application_error(-20002,
                              '删除失败！合作范围需至少保留1条数据！');
    END IF;
  END IF;
  IF v_flag > 0 THEN
    raise_application_error(-20002,
                            '合作分类、可生产类别，已经存在，请重新填写！');
  END IF;

END trg_af_update_commodity_info;
/

