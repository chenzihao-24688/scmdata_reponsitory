CREATE OR REPLACE TRIGGER SCMDATA.trg_abnormaldtlconfig_bf_del
  BEFORE DELETE ON scmdata.t_abnormal_dtl_config
  FOR EACH ROW
BEGIN
  scmdata.pkg_qa_ld.p_upd_qarepprobclassbfabdtlcfgdel(v_inp_abnormaldtlcfgid => :OLD.ABNORMAL_DTL_CONFIG_ID,
                                                      v_inp_compid           => :OLD.COMPANY_ID);
END;
/

