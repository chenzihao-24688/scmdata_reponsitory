ALTER TABLE scmdata.T_ABNORMAL ADD  orgin_type  VARCHAR2(32);
ALTER TABLE scmdata.T_ABNORMAL ADD   abnormal_orgin       VARCHAR2(32);
ALTER TABLE scmdata.T_ABNORMAL ADD   checker              VARCHAR2(512);
ALTER TABLE scmdata.T_ABNORMAL ADD   check_link           VARCHAR2(32);
ALTER TABLE scmdata.T_ABNORMAL ADD   check_num            NUMBER;
COMMENT on column scmdata.T_ABNORMAL.origin
  is '来源    MA:手动创建  SC:系统创建（扣款单、QC报告、QA报告自动生成相应异常单）';
comment on column scmdata.T_ABNORMAL.origin_id
  is '来源ID,当来源为MA时，存异常单ID;   当来源为SC时，根据来源类型存值（TD:扣款单ID，QC:QC报告ID，QA:QA报告ID）';
comment on column scmdata.T_ABNORMAL.abnormal_range
  is '异常范围（00 全部，01 指定数量，02 订单颜色-根据订单明细动态展示）';
comment on column scmdata.T_ABNORMAL.delivery_amount
  is '已交货数量';
comment on column scmdata.T_ABNORMAL.orgin_type
  is '当来源为MA时，存ABN:异常单;   当来源为SC时，根据类型存值（TD:扣款单，QC:QC报告，QA:QA报告）';
comment on column scmdata.T_ABNORMAL.abnormal_orgin
  is '异常来源，创建人对应的三级部门名称';
comment on column scmdata.T_ABNORMAL.checker
  is '查货人（数据来源=系统创建的，查货人=创建人；数据来源=手动新增的，按规则存值）';
comment on column scmdata.T_ABNORMAL.check_link
  is '查货环节， 数据来源=系统创建的，查货环节取QC验货报告对应字段“查货环节”；数据来源=手动新增的，按规则存值）';
comment on column scmdata.T_ABNORMAL.check_num
  is '根据来源类型记录查货/仓检次数，1.当来源为QC：则记录QC查货次数 2.当来源为QA时，记录QA仓检次数  3.其他则为空';
/
