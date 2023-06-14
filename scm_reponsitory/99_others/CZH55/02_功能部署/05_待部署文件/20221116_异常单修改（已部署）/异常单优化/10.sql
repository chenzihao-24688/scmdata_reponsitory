prompt Importing table nbw.sys_associate...
set feedback off
set define off

insert into nbw.sys_associate (NODE_ID, ELEMENT_ID, FIELD_NAME, ASSOCIATE_TYPE, CAPTION, ICON_NAME, DATA_TYPE, DATA_SQL, OPEN_TYPE)
values ('node_a_product_113_1', 'associate_a_product_113', 'QUALITY_CONTROL_LOG_ID', 6, '查看品控详情', null, 2, null, null);

insert into nbw.sys_associate (NODE_ID, ELEMENT_ID, FIELD_NAME, ASSOCIATE_TYPE, CAPTION, ICON_NAME, DATA_TYPE, DATA_SQL, OPEN_TYPE)
values ('node_a_qcqa_152_1', 'associate_a_product_120_1', 'QUALITY_CONTROL_LOG_ID', 6, '查看报告', null, 2, null, null);

insert into nbw.sys_associate (NODE_ID, ELEMENT_ID, FIELD_NAME, ASSOCIATE_TYPE, CAPTION, ICON_NAME, DATA_TYPE, DATA_SQL, OPEN_TYPE)
values ('node_a_qcqa_152_1', 'associate_a_qcqa_152_1', 'QUALITY_CONTROL_LOG_ID', 6, '品控详情', null, 2, null, null);

prompt Done.
