DECLARE
  v_sql CLOB;
BEGIN
  FOR il_rec IN (SELECT t.*
                   FROM nbw.sys_item_list t
                  WHERE t.item_id IN ('a_supp_151',
                                      'a_supp_151_7',
                                      'a_supp_160',
                                      'a_supp_161',
                                      'a_supp_161_1',
                                      'a_supp_171',
                                      'a_supp_120_1')) LOOP
    SELECT COUNT(1)
      INTO v_flag
      FROM nbw.sys_item_list t
     WHERE t.item_id = il_rec.item_id;
    IF v_flag > 0 THEN
      --遇到引号问题 自动替换 replace('',''','''')
     v_sql := q'[UPDATE bw3.sys_item_list t
         SET t.query_type              = ]' || il_rec.query_type || q'[,
             t.query_fields            = ']' ||il_rec.query_fields|| q'[',
             t.query_count             = ]' ||il_rec.query_count|| q'[,
             t.edit_express            = ']' ||il_rec.edit_express|| q'[',
             t.newid_sql               = ]' ||il_rec.newid_sql|| q'[,
             t.select_sql              = ]' ||il_rec.select_sql|| q'[,  
             t.detail_sql              = ]' ||il_rec.detail_sql|| q'[,
             t.subselect_sql           = ]' ||il_rec.subselect_sql|| q'[,
             t.insert_sql              = ]' ||il_rec.insert_sql|| q'[,
             t.update_sql              = ]' ||il_rec.update_sql|| q'[,
             t.delete_sql              = ]' ||il_rec.delete_sql|| q'[,
             t.noshow_fields           = ]' ||il_rec.noshow_fields|| q'[,
             t.noadd_fields            = ]' ||il_rec.noadd_fields|| q'[,
             t.nomodify_fields         = ]' ||il_rec.nomodify_fields|| q'[,
             t.noedit_fields           = ]' ||il_rec.noedit_fields|| q'[,
             t.subnoshow_fields        = ]' ||il_rec.subnoshow_fields|| q'[,
             t.ui_tmpl                 = ]' ||il_rec.ui_tmpl|| q'[,
             t.multi_page_flag         = ]' ||il_rec.multi_page_flag|| q'[,
             t.output_parameter        = ]' ||il_rec.output_parameter|| q'[,
             t.lock_sql                = ]' ||il_rec.lock_sql|| q'[,
             t.monitor_id              = ]' ||il_rec.monitor_id|| q'[,
             t.end_field               = ]' ||il_rec.end_field|| q'[,
             t.execute_time            = ]' ||il_rec.execute_time|| q'[,
             t.scannable_field         = ]' ||il_rec.scannable_field|| q'[,
             t.scannable_type          = ]' ||il_rec.scannable_type|| q'[,
             t.auto_refresh            = ]' ||il_rec.auto_refresh|| q'[,
             t.rfid_flag               = ]' ||il_rec.rfid_flag|| q'[,
             t.scannable_time          = ]' ||il_rec.scannable_time|| q'[,
             t.max_row_count           = ]' ||il_rec.max_row_count|| q'[,
             t.noshow_app_fields       = ]' ||il_rec.noshow_app_fields|| q'[,
             t.scannable_location_line = ]' ||il_rec.scannable_location_line|| q'[,
             t.sub_table_judge_field   = ]' ||il_rec.sub_table_judge_field|| q'[,
             t.back_ground_id          = ]' ||il_rec.back_ground_id|| q'[,
             t.opretion_hint           = ]' ||il_rec.opretion_hint|| q'[,
             t.sub_edit_state          = ]' ||il_rec.sub_edit_state|| q'[,
             t.hint_type               = ]' ||il_rec.hint_type|| q'[,
             t.header                  = ]' ||il_rec.header|| q'[,
             t.footer                  = ]' ||il_rec.footer|| q'[,
             t.jump_field              = ]' ||il_rec.jump_field|| q'[,
             t.jump_express            = ]' ||il_rec.jump_express|| q'[,
             t.open_mode               = ]' ||il_rec.open_mode|| q'[,
             t.operation_type          = ]' ||il_rec.operation_type|| q'[,
             t.operate_type            = ]' ||il_rec.operate_type|| q'[,
             t.page_sizes              = ]' ||il_rec.page_sizes|| q'[
       WHERE t.item_id = ]' || il_rec.item_id || q'[']';
    END IF;
  END LOOP;
END;
