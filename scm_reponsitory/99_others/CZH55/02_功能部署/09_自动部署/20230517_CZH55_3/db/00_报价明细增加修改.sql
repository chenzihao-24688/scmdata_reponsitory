DECLARE
v_sql CLOB;
BEGIN
v_sql := '{DECLARE
  v_quotation_id                VARCHAR2(32);
  v_rest_method                 VARCHAR2(256);
  v_params                      VARCHAR2(256);
  v_sql                         CLOB;
  v_whether_add_color_quotation VARCHAR2(1);
  v_quotation_classification    VARCHAR2(256);
  v_quotation_status            VARCHAR2(256);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_quotation_id%,
                                             po_pk_id        => v_quotation_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);

  IF instr('';'' || v_rest_method || '';'', '';'' || ''PUT'' || '';'') > 0 THEN

    v_whether_add_color_quotation := plm.pkg_plat_comm.parse_json(p_jsonstr => v_params,p_key   => ''whether_add_color_quotation'');

    v_quotation_status := plm.pkg_plat_comm.parse_json(p_jsonstr => v_params,p_key  => ''quotation_status'');

    v_quotation_classification := plm.pkg_plat_comm.parse_json(p_jsonstr => v_params,p_key  => ''quotation_classification'');

    v_sql := q''[DECLARE
    p_quota_rec plm.quotation%ROWTYPE;
    v_company_id           VARCHAR2(32) := ''b6cc680ad0f599cde0531164a8c0337f'';
  BEGIN
    --未报价
    --主表
    p_quota_rec.quotation_id                := :quotation_id;
    p_quota_rec.quotation_status            := ]'' || v_quotation_status || q''[;
    ]'' || (CASE
               WHEN v_whether_add_color_quotation = ''0'' THEN
                (CASE
                  WHEN v_quotation_status = 4 THEN
                   q''[
    p_quota_rec.color                       := :color_qt;
    p_quota_rec.consumables_quotation_remark := :consumables_quotation_remark;]''
                  ELSE
                   q''[
    p_quota_rec.color                       := :color_qt;
    p_quota_rec.item_no                     := :item_no;
    p_quota_rec.sanfu_article_no            := :sanfu_article_no;
    p_quota_rec.bag_paper_lattice_number    := :bag_paper_lattice_number;
    p_quota_rec.consumables_quotation_remark := :consumables_quotation_remark;
    --0.校验数据
    plm.pkg_quotation.p_check_bag_paper(p_company_id => v_company_id, p_quotation_class => '']'' || v_quotation_classification || q''['', p_bag_paper => :bag_paper_lattice_number);]''
                END)
               ELSE
                q''[ p_quota_rec.color                        := :color_qt;
                    p_quota_rec.consumables_quotation_remark := :consumables_quotation_remark;]''
             END) || q''[
    p_quota_rec.final_quotation             := :final_quotation;         
    p_quota_rec.whether_add_color_quotation := :whether_add_color_quotation;
    p_quota_rec.update_time                 := SYSDATE;
    p_quota_rec.update_id                   := :user_id;
    --1.更新报价单
    plm.pkg_quotation.p_update_quotation(p_quota_rec => p_quota_rec,p_type => 0);
  END;]'';
  ELSE
    v_sql := NULL;
  END IF;
  @strresult := v_sql;
END;}';
UPDATE bw3.sys_item_list t SET t.update_sql = v_sql,t.insert_sql = NULL WHERE t.item_id = 'a_quotation_111';
END;
/
