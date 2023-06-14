prompt Importing table nbw.sys_field_control...
set feedback off
set define off

insert into nbw.sys_field_control (ELEMENT_ID, FROM_FIELD, CONTROL_EXPRESS, CONTROL_FIELDS, CONTROL_TYPE)
values ('control_a_product_118', 'ANOMALY_CLASS_PR', '''{{ANOMALY_CLASS_PR}}''!=''AC_DATE''', 'CHECK_LINK,CHECK_NUM,CHECKER,CHECKER_DESC,ABNORMAL_ORGIN,ABN_ORGIN_DESC,CHECK_GD_LINK_DESC', 0);

insert into nbw.sys_field_control (ELEMENT_ID, FROM_FIELD, CONTROL_EXPRESS, CONTROL_FIELDS, CONTROL_TYPE)
values ('control_a_product_118_1', 'ABNORMAL_ORGIN', '''{{ORIGIN}}''==''MA''&&''{{ANOMALY_CLASS_PR}}''!=''AC_DATE''&&''{{ABNORMAL_ORGIN}}''==''ed7ff3c7135a236ae0533c281caccd8d''||''{{ABNORMAL_ORGIN}}''==''14''', 'CHECKER,CHECKER_DESC', 0);

insert into nbw.sys_field_control (ELEMENT_ID, FROM_FIELD, CONTROL_EXPRESS, CONTROL_FIELDS, CONTROL_TYPE)
values ('control_a_product_118_2', 'ABNORMAL_ORGIN', '''{{ORIGIN}}''==''MA''&&''{{ANOMALY_CLASS_PR}}''!=''AC_DATE''&&''{{ABNORMAL_ORGIN}}''==''ed7ff3c7135a236ae0533c281caccd8d''||''{{ABNORMAL_ORGIN}}''==''14''||''{{ABNORMAL_ORGIN}}''==''16''', 'CHECK_LINK,CHECK_NUM,CHECK_GD_LINK_DESC', 0);

insert into nbw.sys_field_control (ELEMENT_ID, FROM_FIELD, CONTROL_EXPRESS, CONTROL_FIELDS, CONTROL_TYPE)
values ('control_a_product_120_2', 'ORIGIN', '''{{ORIGIN}}''==''SC''', 'associate_a_product_120_1', 2);

insert into nbw.sys_field_control (ELEMENT_ID, FROM_FIELD, CONTROL_EXPRESS, CONTROL_FIELDS, CONTROL_TYPE)
values ('control_a_product_120_1', 'IS_EDIT_ABN_ORGIN', '''{{ORIGIN}}''==''MA''&&''{{ANOMALY_CLASS_PR}}''!=''AC_DATE''&&''{{IS_EDIT_ABN_ORGIN}}''==''1''', 'ABNORMAL_ORGIN,ABN_ORGIN_DESC', 0);

prompt Done.
