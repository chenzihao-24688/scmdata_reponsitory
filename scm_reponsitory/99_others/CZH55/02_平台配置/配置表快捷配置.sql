--�����ֶ�
SELECT ROWID, t.* FROM nbw.sys_field_list t where t.caption like '%�������%';

INSERT INTO nbw.sys_field_list (field_name,caption,requiered_flag,read_only_flag,no_edit,no_copy,no_sort,alignment,ime_care,ime_open)
VALUES('COMPANY_PROVINCE_DESC', 'ʡ', 0, 0, 0, 0, 0, 0, 0, 0);

INSERT INTO nbw.sys_field_list (field_name,caption,requiered_flag,read_only_flag,no_edit,no_copy,no_sort,alignment,ime_care,ime_open)
VALUES('COMPANY_CITY_DESC', '��', 0, 0, 0, 0, 0, 0, 0, 0);

INSERT INTO nbw.sys_field_list (field_name,caption,requiered_flag,read_only_flag,no_edit,no_copy,no_sort,alignment,ime_care,ime_open)
VALUES('SUPP_CODE_GD', '��Ӧ�̵������', 1, 1, 0, 0, 0, 0, 0, 0);



--��ʾ
insert into sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE)
values ('span_1', 'span', 'oracle_nsfdata', 0, null, null);

insert into sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE)
values ('span_2', 'span', 'oracle_nsfdata', 0, null, null);
