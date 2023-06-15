CREATE OR REPLACE TRIGGER SCMDATA.trg_af_update_commodity_info
  AFTER UPDATE ON t_commodity_info
  FOR EACH ROW
DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION;
  v_base_size_flag NUMBER;

BEGIN
  --校验基码是否在尺码中存在
  if :new.base_size is not null then
    SELECT instr(';' || :new.size_list || ';', ';' || :new.base_size || ';')
      INTO v_base_size_flag
      FROM scmdata.t_commodity_info tc
     WHERE tc.company_id = :old.company_id
       AND tc.commodity_info_id = :old.commodity_info_id;
  
    IF v_base_size_flag = 0 THEN
      raise_application_error(-20002,
                              '基码在尺码中不存在,请先修正基码再做尺码修改！');
    END IF;
  end if;
END trg_af_update_commodity_info;
/

