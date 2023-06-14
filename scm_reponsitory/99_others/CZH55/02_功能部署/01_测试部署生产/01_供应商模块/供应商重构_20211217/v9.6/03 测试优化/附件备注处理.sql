alter table scmdata.t_supplier_info modify file_remark varchar2(4000);
/
update scmdata.t_supplier_info t set t.file_remark = t.remarks where 1 = 1;
