-- Create table
create table SCMDATA.T_EXCEL_IMPORT
(
  col_1  VARCHAR2(256),
  col_2  VARCHAR2(256),
  col_3  VARCHAR2(256),
  col_4  VARCHAR2(256),
  col_5  VARCHAR2(256),
  col_6  VARCHAR2(256),
  col_7  VARCHAR2(256),
  col_8  VARCHAR2(256),
  col_9  VARCHAR2(256),
  col_10 VARCHAR2(256),
  col_11 VARCHAR2(256),
  col_12 VARCHAR2(256),
  col_13 VARCHAR2(256),
  col_14 VARCHAR2(256),
  col_15 VARCHAR2(256),
  col_16 VARCHAR2(256),
  col_17 VARCHAR2(256),
  col_18 VARCHAR2(256),
  col_19 VARCHAR2(256),
  col_20 VARCHAR2(256)
)
tablespace SCMDATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
