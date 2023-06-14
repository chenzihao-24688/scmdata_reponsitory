BEGIN
UPDATE scmdata.t_supplier_info t SET t.group_name = NULL,t.update_id = 'ADMIN',t.update_date = SYSDATE WHERE 1 = 1 ;
END;
/
BEGIN
  FOR sup_rec IN (SELECT t.company_province,
                         t.company_city,
                         vc.coop_classification,
                         vc.coop_product_cate,
                         t.supplier_info_id,
                         t.company_id,
                         t.pause
                    FROM scmdata.t_supplier_info t
                   INNER JOIN (SELECT *
                                FROM (SELECT tc.coop_classification,
                                             tc.coop_product_cate,
                                             row_number() over(PARTITION BY tc.supplier_info_id, tc.company_id ORDER BY tc.create_time DESC) rn,
                                             tc.supplier_info_id,
                                             tc.company_id
                                        FROM scmdata.t_coop_scope tc
                                       WHERE tc.company_id = 'b6cc680ad0f599cde0531164a8c0337f')
                               WHERE rn = 1) vc
                      ON vc.supplier_info_id = t.supplier_info_id
                     AND vc.company_id = t.company_id
                   WHERE t.company_id = 'b6cc680ad0f599cde0531164a8c0337f') LOOP
  
    scmdata.pkg_supplier_info.p_update_group_name(p_company_id       => sup_rec.company_id,
                                                  p_supplier_info_id => sup_rec.supplier_info_id,
                                                  p_is_trigger       => 0,
                                                  p_pause            => sup_rec.pause,
                                                  p_is_by_pick       => 1,
                                                  p_is_create_sup    => 1,
                                                  p_province         => sup_rec.company_province,
                                                  p_city             => sup_rec.company_city);
  END LOOP;
END;
/
BEGIN
DELETE from scmdata.t_excel_import WHERE 1 = 1;
insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01644', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01649', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01650', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01651', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01652', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01653', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01654', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01655', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01656', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01657', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01658', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01659', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01660', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01661', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01662', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01663', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01664', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01665', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01666', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01667', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01668', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01669', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01671', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01672', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01673', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01674', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01675', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01676', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01677', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01678', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01679', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01680', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01681', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01682', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01683', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01684', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01685', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01686', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01687', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01688', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01689', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01690', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01691', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01692', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01693', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01694', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01695', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01696', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01697', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01698', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01699', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01700', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01701', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01702', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01703', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01704', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01705', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01706', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01707', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01708', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01709', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01710', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01711', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01712', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01713', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01714', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01715', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01716', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01717', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01718', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01719', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01720', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01721', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01722', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01723', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01724', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01725', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01726', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01727', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01728', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01729', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01730', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01731', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01732', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01733', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01734', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01735', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01736', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01737', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01738', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01739', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01740', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01741', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01742', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01743', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01744', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01745', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01746', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01747', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01748', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01749', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01750', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01751', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01752', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01753', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01754', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01755', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01756', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01757', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01758', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01759', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01760', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01761', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01762', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01763', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01764', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01765', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01766', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01767', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01768', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01769', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01770', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01771', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01772', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01773', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01774', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01775', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01776', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01777', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01778', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01779', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01780', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01781', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01782', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01783', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01784', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01785', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01786', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01787', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01788', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01790', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01791', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01792', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01793', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01794', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01795', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01796', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01797', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01798', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01799', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01800', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01801', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01802', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01803', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01804', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01805', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01806', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01807', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01808', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01809', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01810', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01811', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01812', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01813', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01814', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01815', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01816', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01817', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01818', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01819', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01820', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01821', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01822', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01823', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01824', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01825', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01826', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01827', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01828', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01829', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01830', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01831', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01832', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01833', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01834', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01835', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01836', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01837', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01838', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01839', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01840', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01841', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01842', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01843', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01844', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01845', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01846', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01847', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01848', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01849', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01850', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01851', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01852', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01853', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01854', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01855', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01857', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01858', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01859', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01860', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01861', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01862', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01863', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01864', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01865', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01866', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01868', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01869', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01870', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01871', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01872', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01873', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01874', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01875', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01876', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01877', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01878', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01879', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01880', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01881', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01882', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01883', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01884', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01885', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01886', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01887', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01888', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01889', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01890', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01891', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01892', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01893', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01894', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01895', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01896', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01897', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01898', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01899', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01900', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01901', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01902', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01903', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01904', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01905', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01906', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01907', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01908', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01909', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01910', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01911', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01912', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01913', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01914', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01915', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01916', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01917', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01918', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01919', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01920', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01921', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01922', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01923', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01924', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01925', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01926', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01927', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01928', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01929', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01930', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01931', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01932', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01933', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01934', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01935', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01936', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01937', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01938', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01939', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01940', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01941', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01942', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01943', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01944', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01945', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01946', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01947', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01948', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01949', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01950', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01952', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01953', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01954', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01955', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01956', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01957', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01958', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01959', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01960', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01961', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01962', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01963', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01964', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01965', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01966', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01968', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01969', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01970', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01971', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01972', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01973', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01974', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01975', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01976', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01977', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01978', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01979', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01980', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01981', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01982', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01983', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01984', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01985', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01987', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01988', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01989', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01990', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01991', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01992', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01993', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01994', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01995', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01996', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01997', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01998', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01999', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02000', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02001', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02002', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02003', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02004', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02005', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02006', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02007', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02008', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02009', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02010', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02011', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02012', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02013', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02014', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02015', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02016', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02017', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02018', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02019', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02020', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02021', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02022', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02023', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02024', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02025', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02026', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02027', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02029', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02030', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02031', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02032', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02033', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02034', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02035', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00929', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01008', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01052', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01145', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01149', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01220', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01224', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01227', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01270', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01272', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01291', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01372', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01477', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01551', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01789', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01867', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01967', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01856', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00001', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00002', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00003', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00004', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00005', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00006', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00007', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00008', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00009', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00011', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00012', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00013', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00014', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00015', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00016', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00017', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00018', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00019', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00020', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00021', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00022', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00023', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00024', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00025', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00026', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00027', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00028', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00029', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00030', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00031', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00032', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00033', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00034', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00035', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00036', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00037', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00038', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00039', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00040', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00041', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00042', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00043', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00044', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00045', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00046', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00047', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00048', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00049', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00050', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00051', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00052', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00053', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00054', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00055', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00056', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00057', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00058', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00059', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00060', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00061', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00062', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00063', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00064', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00065', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00066', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00067', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00068', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00069', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00070', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00071', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00072', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00073', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00074', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00075', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00076', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00077', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00078', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00079', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00080', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00081', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00082', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00083', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00084', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00085', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00086', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00087', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00088', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00089', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00090', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00091', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00092', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00093', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00094', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00095', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00096', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00097', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00098', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00099', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00100', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00101', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00102', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00103', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00104', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00105', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00106', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00107', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00108', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00109', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00110', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00111', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00112', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00113', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00114', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00115', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00116', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00117', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00118', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00119', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00120', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00121', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00122', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00123', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00124', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00125', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00126', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00127', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00128', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00129', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00130', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00131', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00132', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00133', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00134', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00135', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00136', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00137', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00138', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00139', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00140', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00141', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00142', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00143', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00144', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00145', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00146', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00147', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00148', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00149', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00150', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00151', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00152', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00153', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00154', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00155', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00156', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00157', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00158', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00159', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00160', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00161', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00162', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00163', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00164', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00165', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00166', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00167', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00168', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00169', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00170', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00171', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00172', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00173', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00174', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00175', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00178', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00179', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00180', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00181', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00182', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00183', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00184', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00185', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00186', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00187', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00188', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00189', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00190', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00191', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00192', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00193', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00194', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00195', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00196', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00197', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00198', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00199', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00200', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00201', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00202', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00203', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00204', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00205', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00206', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00207', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00208', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00209', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00210', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00211', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00212', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00213', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00214', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00215', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00217', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00218', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00219', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00220', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00221', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00222', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00223', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00224', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00225', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00226', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00227', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00228', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00229', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00230', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00234', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00235', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00236', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00240', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00244', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00245', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00246', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00249', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00251', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00252', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00253', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00254', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00255', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00256', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00257', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00258', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00259', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00260', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00261', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00262', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00263', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00264', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00265', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00266', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00267', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00268', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00269', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00270', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00271', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00272', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00273', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00274', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00275', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00276', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00277', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00278', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00279', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00280', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00281', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00282', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00283', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00284', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00285', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00286', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00287', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00288', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00289', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00290', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00291', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('col_1', 'col_2', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00292', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00293', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00294', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00295', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00296', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00297', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00298', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00299', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00300', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00301', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00302', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00303', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00304', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00305', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00306', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00307', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00308', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00309', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00310', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00311', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00312', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00313', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00314', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00315', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00316', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00317', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00318', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00319', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00320', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00322', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00323', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00324', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00325', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00326', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00327', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00328', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00329', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00330', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00331', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00332', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00333', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00334', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00335', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00336', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00337', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00338', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00339', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00340', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00341', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00342', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00343', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00344', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00345', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00346', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00347', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00348', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00349', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00350', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00351', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00352', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00353', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00354', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00355', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00356', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00357', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00358', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00359', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00360', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00361', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00362', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00363', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00364', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00365', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00366', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00367', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00368', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00369', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00370', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00371', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00372', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00373', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00374', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00375', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00376', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00377', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00378', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00379', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00380', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00381', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00382', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00383', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00384', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00385', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00386', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00387', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00388', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00389', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00390', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00391', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00392', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00393', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00394', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00395', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00396', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00397', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00398', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00399', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00400', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00401', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00402', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00403', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00404', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00405', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00406', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00407', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00408', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00409', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00410', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00411', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00412', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00413', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00414', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00415', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00416', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00417', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00418', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00419', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00420', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00421', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00422', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00423', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00424', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00425', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00426', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00427', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00428', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00429', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00430', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00431', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00432', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00433', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00434', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00435', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00436', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00437', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00438', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00439', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00440', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00441', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00442', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00443', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00444', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00445', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00446', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00447', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00448', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00449', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00450', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00451', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00452', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00453', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00454', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00455', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00456', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00457', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00458', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00459', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00460', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00461', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00462', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00463', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00464', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00465', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00466', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00467', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00468', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00469', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00470', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00471', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00472', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00473', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00474', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00475', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00476', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00477', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00478', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00479', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00480', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00481', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00482', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00483', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00484', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00485', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00486', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00487', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00488', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00489', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00490', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00491', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00492', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00493', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00494', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00495', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00496', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00497', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00498', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00499', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00500', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00501', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00502', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00503', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00504', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00505', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00506', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00507', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00508', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00509', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00510', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00511', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00512', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00513', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00514', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00515', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00516', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00517', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00518', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00519', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00520', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00521', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00522', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00523', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00524', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00525', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00526', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00527', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00528', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00529', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00530', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00531', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00532', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00533', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00534', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00535', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00536', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00537', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00538', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00539', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00540', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00541', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00542', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00543', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00544', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00545', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00546', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00547', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00548', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00549', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00550', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00551', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00552', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00553', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00554', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00555', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00556', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00557', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00558', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00559', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00560', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00561', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00562', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00564', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00565', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00566', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00567', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00568', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00569', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00570', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00571', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00572', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00573', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00574', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00575', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00576', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00577', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00578', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00579', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00580', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00581', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00582', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00583', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00584', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00585', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00586', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00587', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00588', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00589', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00590', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00591', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00592', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00593', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00594', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00595', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00596', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00597', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00598', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00599', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00600', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00601', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00602', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00603', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00604', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00605', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00606', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00607', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00608', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00609', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00610', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00611', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00612', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00613', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00614', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00615', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00616', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00617', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00618', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00619', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00620', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00621', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00622', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00623', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00624', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00625', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00626', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00627', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00628', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00629', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00630', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00631', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00632', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00633', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00634', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00635', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00636', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00637', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00638', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00639', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00640', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00641', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00642', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00643', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00644', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00645', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00646', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00647', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00648', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00649', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00650', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00651', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00652', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00653', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00654', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00655', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00656', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00657', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00658', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00659', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00660', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00661', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00662', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00663', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00664', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00665', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00666', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00667', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00668', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00669', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00670', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00672', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00673', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00674', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00675', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00676', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00677', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00678', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00680', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00682', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00684', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00685', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00686', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00687', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00688', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00689', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00691', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00692', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00695', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00698', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00699', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00700', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00701', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00702', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00703', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00704', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00705', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00706', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00707', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00708', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00709', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00710', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00711', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00713', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00714', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00715', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00716', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00717', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00718', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00719', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00721', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00722', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00723', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00724', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00725', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00726', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00727', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00728', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00730', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00731', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00732', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00733', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00734', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00735', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00736', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00737', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00738', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00739', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00741', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00742', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00744', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00745', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00746', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00747', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00749', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00751', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00752', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00754', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00755', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00756', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00757', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00758', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00759', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00760', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00761', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00762', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00763', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00764', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00766', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00767', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00768', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00769', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00770', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00771', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00772', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00773', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00774', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00775', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00776', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00777', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00778', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00779', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00780', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00781', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00782', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00783', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00784', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00785', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00786', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00787', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00788', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00789', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00790', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00791', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00792', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00793', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00794', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00795', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00796', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00797', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00798', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00799', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00800', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00801', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00802', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00803', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00804', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00805', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00806', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00807', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00808', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00809', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00810', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00811', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00812', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00813', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00814', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00815', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00816', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00817', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00818', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00819', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00820', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00821', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00822', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00823', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00824', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00825', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00826', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00827', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00828', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00830', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00831', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00832', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00833', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00834', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00835', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00836', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00837', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00838', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00839', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00840', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00841', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00842', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00843', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00844', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00845', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00846', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00847', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00848', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00849', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00850', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00851', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00852', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00853', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00854', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00855', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00856', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00857', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00858', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00859', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00860', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00861', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00862', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00863', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00864', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00865', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00866', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00867', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00868', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00869', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00870', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00871', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00872', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00873', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00874', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00875', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00876', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00877', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00878', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00879', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00880', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00881', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00882', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00883', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00884', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00885', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00886', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00887', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00888', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00889', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00890', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00891', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00892', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00893', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00894', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00895', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00896', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00897', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00898', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00899', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00900', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00901', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00902', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00903', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00904', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00906', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00907', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00908', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00909', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00910', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00911', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00912', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00913', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00914', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00915', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00916', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00917', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00918', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00919', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00920', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00921', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00922', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00923', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00924', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00925', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00926', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00927', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00928', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00930', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00931', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00932', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00933', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00934', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00935', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00936', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00937', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00938', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00939', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00940', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00941', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00942', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00943', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00944', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00945', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00946', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00947', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00948', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00949', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00950', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00951', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00952', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00953', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00954', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00955', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00956', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00957', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00958', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00959', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00960', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00961', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00962', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00963', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00964', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00965', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00966', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00967', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00968', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00969', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00970', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00971', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00972', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00973', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00974', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00975', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00976', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00977', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00978', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00979', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00980', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00981', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00982', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00983', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00984', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00985', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00986', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00987', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00988', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00989', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00990', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00991', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00992', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00993', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00994', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00995', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00996', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00997', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00998', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00999', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01000', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01001', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01002', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01003', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01004', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01005', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01006', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01007', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01009', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01010', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01011', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01012', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01013', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01014', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01015', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01016', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01017', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01018', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01019', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01020', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01021', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01022', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01023', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01024', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01025', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01026', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01027', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01028', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01029', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01030', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01031', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01032', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01033', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01034', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01035', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01036', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01037', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01038', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01039', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01040', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01041', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01042', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01043', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01044', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01045', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01046', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01047', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01048', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01049', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01050', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01053', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01054', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01055', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01056', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01057', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01058', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01059', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01060', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01061', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01062', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01063', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01064', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01065', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01066', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01067', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01068', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01069', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01070', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01071', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01072', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01073', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01074', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01075', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01076', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01077', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01078', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01079', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01080', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01081', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01082', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01083', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01084', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01085', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01086', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01087', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01088', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01089', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01090', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01091', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01092', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01093', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01094', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01095', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01096', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01097', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01098', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01099', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01100', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01101', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01102', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01103', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01104', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01105', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01106', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01107', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01108', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01109', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01110', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01111', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01112', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01113', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01114', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01115', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01116', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01117', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01118', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01119', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01120', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01121', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01122', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01123', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01124', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01125', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01126', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01127', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01128', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01129', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01130', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01131', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01132', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01133', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01134', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01135', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01136', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01137', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01138', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01139', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01140', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01141', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01142', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01143', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01144', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01146', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01147', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01148', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01150', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01151', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01152', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01153', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01154', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01155', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01156', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01157', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01158', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01159', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01160', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01161', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01162', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01163', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01164', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01165', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01166', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01167', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01168', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01169', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01170', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01171', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01172', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01173', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01174', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01175', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01176', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01177', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01178', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01179', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01180', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01181', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01182', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01183', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01184', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01185', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01186', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01187', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01188', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01189', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01190', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01191', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01192', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01193', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01194', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01195', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01196', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01197', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01198', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01199', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01200', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01201', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01202', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01203', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01204', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01205', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01207', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01209', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01210', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01211', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01212', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01213', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01214', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01215', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01216', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01217', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01218', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01219', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01221', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01222', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01223', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01225', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01226', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01228', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01229', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01230', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01231', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01232', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01233', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01234', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01235', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01236', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01237', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01238', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01239', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01240', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01241', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01242', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01243', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01244', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01245', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01246', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01247', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01248', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01249', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01250', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01251', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01252', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01253', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01254', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01255', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01256', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01257', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01258', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01259', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01260', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01261', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01262', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01263', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01264', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01265', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01266', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01267', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01268', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01269', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01271', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01273', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01274', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01275', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01276', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01277', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01278', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01279', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01280', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01281', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01282', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01283', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01284', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01285', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01286', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01287', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01288', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01289', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01290', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01292', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01293', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01294', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01295', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01296', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01297', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01298', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01299', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01300', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01301', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01302', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01303', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01304', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01305', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01306', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01307', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01308', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01309', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01310', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01311', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01312', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01313', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01314', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01315', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01316', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01317', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01318', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01319', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01320', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01321', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01322', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01323', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01324', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01325', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01326', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01327', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01328', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01329', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01330', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01331', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01332', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01333', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01334', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01335', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01336', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01337', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01338', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01339', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01340', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01341', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01342', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01343', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01344', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01345', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01346', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01347', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01348', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01349', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01350', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01351', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01353', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01354', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01356', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01357', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01358', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01362', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01363', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01364', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01365', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01366', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01367', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01368', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01369', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01370', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01373', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01374', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01375', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01376', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01377', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01378', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01379', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01380', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01381', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01382', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01383', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01385', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01386', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01387', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01388', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01389', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01390', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01391', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01392', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01393', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01394', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01395', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01396', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01397', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01398', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01399', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01400', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01401', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01402', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01403', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01404', '江西/中山', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01405', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01406', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01408', '温州', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01409', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01410', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01411', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01412', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01413', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01414', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01415', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01416', '湖北/狮岭', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01417', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01418', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01419', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01420', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01421', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01422', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01423', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01424', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01425', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01430', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01432', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01434', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01435', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01436', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01438', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01441', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01445', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01447', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01448', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01449', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01454', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01464', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01467', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01485', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01487', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01498', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01501', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01503', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01504', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01514', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01516', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01523', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01528', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01540', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01543', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01555', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01557', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01570', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01571', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01573', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01574', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01575', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01576', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01579', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01580', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01586', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01596', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01605', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01608', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01613', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01619', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01623', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01633', '东莞/义乌', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01642', '广州/汕头', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

END;
/
