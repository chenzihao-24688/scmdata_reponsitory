--0624  调入调出，平台管理

--增删改查
--1.查
select cr.room_id, cr.room_location, cr.pause, cr.roomtype
  from czh_readroom_info cr
   for update;
--2.增
insert into czh_readroom_info
  (room_id, room_location, pause, roomtype)
values
  (czh_readroom_info_s.nextval, :room_location, :pause, :roomtype);

insert into czh_readroom_info
  (room_id, room_location, pause, roomtype)
values
  (nsfdata.GetNewKeyID('room_id', 'CZH_READROOM_INFO', 'sfsys'),
   :room_location,
   :pause,
   :roomtype);
--3.改
update czh_readroom_info cr
   set cr.room_id       = :room_id,
       cr.room_location = :room_location,
       cr.pause         = :pause,
       cr.roomtype      = :roomtype
 where cr.room_id = :old_room_id;
--4.删
delete from czh_readroom_info cr where cr.room_id = :old_room_id;

--5.字段对应中文（字段名要大写）
insert into sfsys.fieldlist (fieldname, caption) values ('ROOM_ID','阅览室编号');
insert into sfsys.fieldlist (fieldname, caption) values (UPPER('room_location'),'阅览室名称');--ROOM_LOCATION

select * from sfsys.fieldlist f where f.fieldname = 'ROOM_LOCATION';

--6.下拉选择列表

select * from sfsys.itemlist where itemid = 777778 for update;

select * from sfsys.lookups l /*for update*/ where l.lookid = 2020642  for update;--7777   777778  20205285

select * from sfsys.lookup l where l.itemid = 20205285 for update;

Select FltDesID,FaultDescribe from ROOMTYPE_DESCRIBE  for update;

Select FltDesID,FaultDescribe as ROOM_LOCATION from ROOMTYPE_DESCRIBE;

select *
from nsfdata.fltdesid fltdesid 
order by classid Desc;

--7.查询树

select *
  from sfsys.treelist
 start with itemid = 55501
connect by prior itemid = parentid
   for update;

--配置表
select * FROM sfsys.sqlconfig;--系统基础配置
select * from sfsys.config;--正则表达式
