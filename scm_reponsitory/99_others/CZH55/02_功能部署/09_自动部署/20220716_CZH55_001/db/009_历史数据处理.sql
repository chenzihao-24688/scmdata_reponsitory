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
values ('C01644', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01649', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01650', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01651', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01652', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01653', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01654', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01655', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01656', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01657', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01658', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01659', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01660', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01661', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01662', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01663', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01664', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01665', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01666', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01667', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01668', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01669', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01671', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01672', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01673', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01674', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01675', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01676', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01677', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01678', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01679', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01680', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01681', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01682', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01683', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01684', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01685', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01686', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01687', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01688', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01689', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01690', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01691', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01692', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01693', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01694', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01695', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01696', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01697', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01698', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01699', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01700', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01701', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01702', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01703', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01704', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01705', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01706', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01707', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01708', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01709', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01710', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01711', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01712', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01713', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01714', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01715', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01716', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01717', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01718', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01719', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01720', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01721', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01722', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01723', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01724', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01725', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01726', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01727', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01728', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01729', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01730', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01731', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01732', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01733', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01734', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01735', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01736', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01737', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01738', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01739', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01740', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01741', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01742', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01743', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01744', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01745', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01746', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01747', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01748', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01749', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01750', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01751', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01752', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01753', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01754', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01755', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01756', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01757', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01758', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01759', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01760', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01761', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01762', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01763', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01764', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01765', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01766', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01767', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01768', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01769', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01770', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01771', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01772', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01773', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01774', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01775', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01776', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01777', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01778', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01779', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01780', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01781', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01782', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01783', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01784', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01785', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01786', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01787', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01788', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01790', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01791', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01792', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01793', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01794', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01795', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01796', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01797', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01798', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01799', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01800', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01801', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01802', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01803', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01804', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01805', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01806', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01807', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01808', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01809', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01810', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01811', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01812', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01813', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01814', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01815', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01816', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01817', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01818', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01819', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01820', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01821', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01822', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01823', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01824', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01825', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01826', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01827', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01828', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01829', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01830', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01831', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01832', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01833', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01834', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01835', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01836', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01837', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01838', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01839', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01840', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01841', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01842', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01843', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01844', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01845', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01846', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01847', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01848', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01849', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01850', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01851', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01852', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01853', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01854', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01855', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01857', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01858', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01859', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01860', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01861', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01862', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01863', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01864', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01865', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01866', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01868', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01869', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01870', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01871', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01872', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01873', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01874', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01875', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01876', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01877', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01878', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01879', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01880', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01881', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01882', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01883', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01884', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01885', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01886', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01887', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01888', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01889', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01890', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01891', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01892', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01893', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01894', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01895', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01896', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01897', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01898', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01899', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01900', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01901', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01902', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01903', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01904', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01905', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01906', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01907', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01908', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01909', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01910', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01911', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01912', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01913', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01914', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01915', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01916', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01917', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01918', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01919', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01920', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01921', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01922', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01923', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01924', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01925', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01926', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01927', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01928', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01929', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01930', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01931', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01932', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01933', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01934', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01935', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01936', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01937', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01938', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01939', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01940', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01941', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01942', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01943', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01944', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01945', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01946', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01947', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01948', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01949', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01950', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01952', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01953', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01954', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01955', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01956', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01957', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01958', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01959', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01960', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01961', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

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
values ('C01972', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01973', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01974', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01975', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01976', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01977', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01978', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01979', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01980', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01981', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01982', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01983', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01984', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01985', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01987', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01988', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01989', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01990', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01991', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01992', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01993', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01994', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01995', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01996', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01997', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01998', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01999', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02000', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02001', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02002', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02003', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

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
values ('C02009', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02010', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02011', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02012', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02013', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02014', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02015', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02016', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02017', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02018', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02019', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02020', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02021', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02022', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02023', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02024', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02025', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02026', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02027', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02029', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02030', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02031', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02032', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02033', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02034', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C02035', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00929', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01008', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01052', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01145', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01149', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01220', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01224', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01227', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01270', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01272', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01291', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01372', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01477', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01551', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01789', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01867', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01967', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01856', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00001', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00002', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00003', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00004', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00005', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00006', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00007', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00008', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00009', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00011', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00012', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00013', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00014', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00015', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00016', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00017', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00018', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00019', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00020', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00021', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00022', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00023', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00024', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00025', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00026', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00027', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00028', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00029', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00030', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00031', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00032', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00033', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00034', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00035', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00036', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00037', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00038', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00039', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00040', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00041', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00042', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00043', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00044', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00045', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00046', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00047', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00048', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00049', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00050', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00051', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00052', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00053', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00054', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00055', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00056', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00057', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00058', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00059', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00060', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00061', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00062', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00063', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00064', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00065', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00066', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00067', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00068', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00069', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00070', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00071', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00072', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00073', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00074', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00075', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00076', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00077', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00078', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00079', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00080', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00081', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00082', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00083', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00084', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00085', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00086', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00087', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00088', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00089', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00090', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00091', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00092', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00093', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00094', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00095', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00096', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00097', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00098', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00099', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00100', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00101', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00102', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00103', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00104', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00105', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00106', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00107', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00108', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00109', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00110', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00111', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00112', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00113', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00114', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00115', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00116', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00117', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00118', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00119', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00120', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00121', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00122', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00123', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00124', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00125', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00126', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00127', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00128', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00129', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00130', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00131', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00132', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00133', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00134', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00135', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00136', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00137', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00138', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00139', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00140', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00141', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00142', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00143', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00144', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00145', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00146', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00147', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00148', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00149', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00150', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00151', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00152', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00153', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00154', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00155', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00156', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00157', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00158', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00159', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00160', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00161', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00162', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00163', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00164', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00165', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00166', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00167', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00168', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00169', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00170', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00171', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00172', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00173', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00174', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00175', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00178', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00179', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00180', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00181', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00182', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00183', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00184', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00185', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00186', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00187', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00188', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00189', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00190', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00191', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00192', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00193', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00194', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00195', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00196', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00197', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00198', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00199', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00200', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00201', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00202', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00203', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00204', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00205', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00206', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00207', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00208', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00209', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00210', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00211', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00212', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00213', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00214', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00215', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00217', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00218', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00219', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00220', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00221', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00222', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00223', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00224', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00225', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00226', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00227', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00228', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00229', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00230', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00234', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00235', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00236', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00240', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00244', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00245', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00246', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00249', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00251', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00252', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00253', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00254', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00255', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00256', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00257', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00258', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00259', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00260', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00261', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00262', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00263', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00264', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00265', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00266', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00267', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00268', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00269', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00270', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00271', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00272', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00273', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00274', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00275', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00276', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00277', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00278', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00279', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00280', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00281', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00282', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00283', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00284', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00285', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00286', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00287', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00288', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00289', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00290', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00291', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('col_1', 'col_2', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00292', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00293', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00294', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00295', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00296', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00297', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00298', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00299', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00300', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00301', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00302', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00303', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00304', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00305', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00306', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00307', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00308', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00309', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00310', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00311', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00312', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00313', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00314', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00315', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00316', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00317', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00318', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00319', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00320', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00322', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00323', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00324', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00325', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00326', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00327', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00328', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00329', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00330', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00331', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00332', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00333', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00334', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00335', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00336', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00337', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00338', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00339', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00340', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00341', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00342', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00343', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00344', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00345', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00346', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00347', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00348', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00349', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00350', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00351', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00352', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00353', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00354', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00355', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00356', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00357', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00358', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00359', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00360', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00361', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00362', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00363', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00364', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00365', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00366', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00367', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00368', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00369', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00370', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00371', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00372', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00373', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00374', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00375', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00376', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00377', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00378', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00379', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00380', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00381', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00382', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00383', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00384', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00385', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00386', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00387', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00388', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00389', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00390', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00391', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00392', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00393', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00394', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00395', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00396', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00397', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00398', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00399', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00400', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00401', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00402', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00403', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00404', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00405', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00406', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00407', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00408', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00409', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00410', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00411', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00412', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00413', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00414', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00415', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00416', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00417', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00418', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00419', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00420', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00421', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00422', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00423', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00424', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00425', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00426', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00427', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00428', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00429', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00430', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00431', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00432', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00433', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00434', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00435', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00436', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00437', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00438', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00439', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00440', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00441', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00442', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00443', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00444', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00445', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00446', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00447', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00448', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00449', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00450', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00451', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00452', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00453', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00454', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00455', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00456', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00457', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00458', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00459', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00460', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00461', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00462', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00463', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00464', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00465', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00466', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00467', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00468', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00469', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00470', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00471', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00472', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00473', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00474', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00475', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00476', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00477', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00478', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00479', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00480', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00481', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00482', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00483', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00484', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00485', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00486', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00487', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00488', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00489', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00490', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00491', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00492', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00493', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00494', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00495', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00496', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00497', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00498', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00499', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00500', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00501', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00502', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00503', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00504', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00505', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00506', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00507', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00508', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00509', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00510', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00511', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00512', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00513', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00514', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00515', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00516', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00517', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00518', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00519', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00520', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00521', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00522', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00523', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00524', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00525', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00526', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00527', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00528', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00529', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00530', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00531', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00532', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00533', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00534', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00535', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00536', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00537', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00538', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00539', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00540', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00541', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00542', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00543', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00544', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00545', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00546', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00547', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00548', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00549', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00550', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00551', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00552', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00553', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00554', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00555', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00556', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00557', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00558', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00559', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00560', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00561', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00562', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00564', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00565', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00566', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00567', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00568', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00569', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00570', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00571', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00572', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00573', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00574', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00575', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00576', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00577', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00578', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00579', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00580', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00581', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00582', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00583', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00584', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00585', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00586', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00587', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00588', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00589', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00590', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00591', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00592', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00593', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00594', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00595', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00596', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00597', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00598', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00599', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00600', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00601', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00602', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00603', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00604', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00605', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00606', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00607', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00608', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00609', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00610', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00611', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00612', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00613', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00614', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00615', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00616', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00617', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00618', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00619', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00620', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00621', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00622', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00623', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00624', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00625', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00626', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00627', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00628', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00629', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00630', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00631', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00632', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00633', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00634', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00635', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00636', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00637', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00638', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00639', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00640', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00641', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00642', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00643', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00644', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00645', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00646', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00647', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00648', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00649', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00650', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00651', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00652', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00653', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00654', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00655', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00656', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00657', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00658', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00659', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00660', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00661', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00662', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00663', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00664', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00665', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00666', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00667', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00668', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00669', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00670', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00672', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00673', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00674', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00675', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00676', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00677', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00678', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00680', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00682', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00684', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00685', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00686', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00687', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00688', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00689', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00691', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00692', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00695', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00698', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00699', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00700', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00701', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00702', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00703', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00704', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00705', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00706', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00707', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00708', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00709', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00710', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00711', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00713', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00714', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00715', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00716', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00717', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00718', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00719', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00721', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00722', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00723', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00724', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00725', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00726', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00727', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00728', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00730', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00731', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00732', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00733', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00734', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00735', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00736', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00737', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00738', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00739', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00741', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00742', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00744', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00745', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00746', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00747', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00749', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00751', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00752', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00754', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00755', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00756', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00757', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00758', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00759', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00760', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00761', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00762', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00763', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00764', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00766', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00767', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00768', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00769', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00770', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00771', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00772', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00773', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00774', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00775', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00776', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00777', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00778', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00779', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00780', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00781', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00782', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00783', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00784', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00785', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00786', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00787', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00788', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00789', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00790', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00791', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00792', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00793', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00794', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00795', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00796', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00797', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00798', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00799', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00800', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00801', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00802', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00803', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00804', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00805', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00806', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00807', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00808', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00809', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00810', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00811', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00812', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00813', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00814', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00815', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00816', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00817', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00818', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00819', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00820', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00821', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00822', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00823', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00824', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00825', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00826', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00827', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00828', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00830', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00831', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00832', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00833', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00834', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00835', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00836', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00837', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00838', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00839', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00840', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00841', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00842', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00843', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00844', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00845', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00846', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00847', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00848', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00849', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00850', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00851', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00852', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00853', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00854', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00855', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00856', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00857', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00858', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00859', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00860', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00861', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00862', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00863', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00864', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00865', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00866', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00867', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00868', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00869', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00870', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00871', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00872', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00873', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00874', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00875', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00876', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00877', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00878', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00879', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00880', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00881', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00882', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00883', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00884', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00885', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00886', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00887', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00888', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00889', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00890', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00891', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00892', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00893', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00894', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00895', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00896', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00897', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00898', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00899', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00900', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00901', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00902', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00903', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00904', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00906', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00907', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00908', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00909', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00910', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00911', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00912', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00913', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00914', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00915', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00916', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00917', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00918', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00919', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00920', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00921', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00922', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00923', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00924', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00925', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00926', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00927', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00928', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00930', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00931', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00932', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00933', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00934', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00935', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00936', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00937', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00938', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00939', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00940', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00941', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00942', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00943', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00944', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00945', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00946', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00947', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00948', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00949', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00950', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00951', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00952', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00953', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00954', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00955', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00956', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00957', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00958', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00959', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00960', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00961', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00962', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00963', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00964', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00965', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00966', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00967', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00968', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00969', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00970', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00971', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00972', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00973', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00974', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00975', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00976', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00977', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00978', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00979', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00980', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00981', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00982', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00983', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00984', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00985', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00986', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00987', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00988', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00989', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00990', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00991', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00992', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00993', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00994', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00995', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00996', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00997', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00998', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C00999', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01000', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01001', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01002', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01003', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01004', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01005', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01006', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01007', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01009', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01010', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01011', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01012', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01013', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01014', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01015', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01016', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01017', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01018', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01019', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01020', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01021', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01022', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01023', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01024', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01025', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01026', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01027', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01028', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01029', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01030', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01031', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01032', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01033', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01034', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01035', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01036', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01037', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01038', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01039', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01040', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01041', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01042', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01043', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01044', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01045', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01046', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01047', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01048', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01049', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01050', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01053', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01054', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01055', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01056', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01057', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01058', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01059', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01060', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01061', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01062', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01063', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01064', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01065', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01066', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01067', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01068', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01069', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01070', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01071', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01072', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01073', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01074', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01075', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01076', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01077', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01078', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01079', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01080', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01081', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01082', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01083', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01084', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01085', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01086', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01087', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01088', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01089', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01090', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01091', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01092', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01093', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01094', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01095', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01096', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01097', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01098', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01099', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01100', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01101', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01102', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01103', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01104', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01105', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01106', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01107', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01108', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01109', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01110', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01111', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01112', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01113', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01114', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01115', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01116', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01117', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01118', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01119', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01120', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01121', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01122', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01123', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01124', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01125', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01126', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01127', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01128', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01129', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01130', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01131', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01132', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01133', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01134', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01135', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01136', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01137', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01138', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01139', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01140', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01141', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01142', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01143', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01144', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01146', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01147', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01148', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01150', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01151', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01152', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01153', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01154', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01155', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01156', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01157', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01158', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01159', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01160', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01161', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01162', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01163', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01164', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01165', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01166', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01167', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01168', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01169', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01170', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01171', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01172', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01173', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01174', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01175', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01176', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01177', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01178', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01179', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01180', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01181', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01182', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01183', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01184', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01185', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01186', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01187', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01188', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01189', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01190', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01191', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01192', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01193', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01194', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01195', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01196', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01197', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01198', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01199', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01200', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01201', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01202', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01203', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01204', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01205', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01207', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01209', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01210', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01211', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01212', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01213', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01214', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01215', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01216', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01217', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01218', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01219', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01221', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01222', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01223', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01225', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01226', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01228', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01229', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01230', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01231', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01232', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01233', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01234', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01235', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01236', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01237', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01238', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01239', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01240', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01241', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01242', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01243', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01244', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01245', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01246', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01247', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01248', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01249', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01250', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01251', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01252', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01253', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01254', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01255', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01256', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01257', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01258', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01259', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01260', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01261', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01262', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01263', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01264', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01265', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01266', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01267', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01268', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01269', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01271', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01273', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01274', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01275', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01276', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01277', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01278', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01279', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01280', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01281', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01282', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01283', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01284', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01285', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01286', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01287', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01288', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01289', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01290', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01292', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01293', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01294', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01295', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01296', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01297', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01298', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01299', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01300', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01301', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01302', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01303', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01304', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01305', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01306', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01307', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01308', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01309', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01310', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01311', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01312', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01313', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01314', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01315', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01316', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01317', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01318', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01319', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01320', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01321', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01322', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01323', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01324', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01325', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01326', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01327', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01328', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01329', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01330', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01331', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01332', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01333', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01334', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01335', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01336', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01337', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01338', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01339', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01340', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01341', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01342', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01343', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01344', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01345', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01346', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01347', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01348', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01349', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01350', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01351', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01353', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01354', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01356', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01357', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01358', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01362', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01363', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01364', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01365', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01366', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01367', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01368', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01369', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01370', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01373', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01374', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01375', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01376', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01377', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01378', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01379', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01380', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01381', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01382', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01383', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01385', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01386', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01387', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01388', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01389', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01390', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01391', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01392', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01393', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01394', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01395', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01396', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01397', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01398', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01399', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01400', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01401', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01402', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01403', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01404', '����/��ɽ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01405', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01406', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01408', '����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01409', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01410', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01411', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01412', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01413', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01414', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01415', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01416', '����/ʨ��', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01417', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01418', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01419', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01420', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01421', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01422', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01423', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01424', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01425', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01430', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01432', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01434', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01435', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01436', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01438', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01441', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01445', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01447', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01448', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01449', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01454', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01464', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01467', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01485', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01487', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01498', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01501', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01503', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01504', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01514', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01516', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01523', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01528', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01540', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01543', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01555', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01557', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01570', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01571', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01573', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01574', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01575', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01576', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01579', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01580', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01586', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01596', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01605', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01608', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01613', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01619', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01623', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01633', '��ݸ/����', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into scmdata.t_excel_import (COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7, COL_8, COL_9, COL_10, COL_11, COL_12, COL_13, COL_14, COL_15, COL_16, COL_17, COL_18, COL_19, COL_20)
values ('C01642', '����/��ͷ', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

END;
/
