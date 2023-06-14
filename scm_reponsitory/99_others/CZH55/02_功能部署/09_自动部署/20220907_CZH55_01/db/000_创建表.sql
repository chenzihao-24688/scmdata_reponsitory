ALTER TABLE scmdata.pt_ordered ADD SEASON VARCHAR2(32);
comment on column scmdata.pt_ordered.season
  is '季节';
/
ALTER TABLE scmdata.t_ordered ADD SEASON VARCHAR2(32);
comment on column scmdata.t_ordered.season
  is '季节';
/  
ALTER TABLE scmdata.t_ordered ADD COMPANY_VILL VARCHAR2(128);
comment on column scmdata.t_ordered.COMPANY_VILL
  is '乡镇/街道';
/
