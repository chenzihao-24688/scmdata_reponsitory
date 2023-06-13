create table CZH_READROOM_INFO(
room_id number not null,
room_location varchar2(100),
pause number default 0,
roomtype varchar2(1)
)tablespace NSFDATA
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
--create primary key
alter table CZH_READROOM_INFO 
      add constraint PK_CZH_READROOM_INFO primary key (room_id)   using index 
      tablespace NSFDATA
      pctfree 10
      initrans 2
      maxtrans 255
      storage
      (
        initial 64K
        next 1M
        minextents 1
        maxextents unlimited
      );
      
-- Create sequence 
create sequence CZH_READROOM_INFO_S
minvalue 1
maxvalue 9999999999999999999999
start with 1
increment by 1
cache 2;

