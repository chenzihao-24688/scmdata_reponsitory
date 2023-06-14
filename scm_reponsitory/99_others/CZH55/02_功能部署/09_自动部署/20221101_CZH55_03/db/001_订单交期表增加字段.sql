ALTER TABLE scmdata.PT_ORDERED ADD updated_flw NUMBER(1);
/
comment on column scmdata.PT_ORDERED.updated
  is '延期原因是否在交期表中更改';
/
comment on column scmdata.PT_ORDERED.updated_flw
  is '跟单是否在交期表中更改';
/
