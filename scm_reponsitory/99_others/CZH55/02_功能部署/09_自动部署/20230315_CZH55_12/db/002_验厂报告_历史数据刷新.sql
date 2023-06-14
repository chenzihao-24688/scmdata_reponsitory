---历史数据刷新
begin
  for i in (SELECT fr.factory_report_id,
                   tfa.brand_type, --合作品牌/客户 类型  
                   tfa.cooperation_brand --合作品牌/客户 
              FROM scmdata.t_factory_ask tfa
             INNER JOIN scmdata.t_factory_report fr
                ON tfa.company_id = fr.company_id
               AND tfa.factory_ask_id = fr.factory_ask_id
             where fr.brand_type is null
               and fr.cooperation_brand is null) loop
    update scmdata.t_factory_report tf
       set tf.brand_type        = i.brand_type,
           tf.cooperation_brand = i.cooperation_brand
     where tf.factory_report_id = i.factory_report_id;
  end loop;
end;
/
