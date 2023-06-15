CREATE OR REPLACE TRIGGER SCMDATA.trg_bf_update_t_ask_scope
  before update on t_ask_scope
  for each row
declare
  PRAGMA AUTONOMOUS_TRANSACTION;
  p_i           int;
  p_coo_Clasi   varchar2(48);
  p_coo_product varchar2(48);
begin
  select nvl(max(1), 0)
    into p_i
    from t_ask_scope a
   where a.ask_scope_id <> :NEW.Ask_Scope_Id
     and a.object_id = :NEW.Object_Id
     and a.object_type = :NEW.OBJECT_TYPE
     and a.cooperation_classification = :NEW.Cooperation_Classification
     and a.cooperation_product_cate = :NEW.Cooperation_Product_Cate;
  select max(group_dict_name)
    into p_coo_Clasi
    from sys_group_dict
   where group_dict_value = :NEW.Cooperation_Classification
     and group_dict_type = :NEW.COOPERATION_TYPE;
  select max(group_dict_name)
    into p_coo_product
    from sys_group_dict
   where group_dict_value = :NEW.Cooperation_Product_Cate
     and group_dict_type = :NEW.Cooperation_Classification;

  if p_i = 1 then
    raise_application_error(-20002,
                            '存在重复的' || p_coo_Clasi || p_coo_product ||
                            '范围，请检查！（如果您是第二次看到本提示，请先取消编辑，然后刷新页面）');
  end if;
end trg_bf_update_t_ask_scope;
/

