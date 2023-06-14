CREATE OR REPLACE TRIGGER trg_bf_pt_orderds_byfileds
  BEFORE INSERT OR UPDATE OF factory_code, sho_id ON pt_ordered
  FOR EACH ROW
DECLARE
  vo_group_name  VARCHAR2(256);
  vo_area_leader VARCHAR2(256);
BEGIN
  scmdata.pkg_db_job.p_get_groupname(p_gp_type      => 'GROUP_AREA',
                                     p_category     => :new.category,
                                     p_product_cate => :new.product_cate,
                                     p_sub_cate     => :new.samll_category,
                                     p_goo_id       => :new.goo_id_pr,
                                     p_order_id     => :new.product_gress_code,
                                     p_company_id   => :new.company_id,
                                     po_group_name  => vo_group_name,
                                     po_area_leader => vo_area_leader);

  :new.group_name     := vo_group_name;
  :new.area_gp_leader := vo_area_leader;
END trg_af_pt_orderds_byfileds;
/
