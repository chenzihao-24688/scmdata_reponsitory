--toollist
select * from sfsys.toollist t for update;

--treelist
select rowid, t.*
  from sfsys.treelist t
 where t.itemid = 7777781 --20205291 --7777711
   for update /* where t.nodeid = 2000;*/ --7777781

select tr.*
  from sfsys.treelist tr, sfsys.treelist tr1
 where tr.nodeid = tr1.parentid(+)
   and tr.parentid = 777778;

--递归树   
select *
  from sfsys.treelist
 start with itemid = 777778
connect by prior itemid = parentid
   for update;

select *
  from sfsys.treelist
 start with itemid = 55501
connect by prior itemid = parentid
   for update;

--itemlist

select rowid, i.* from sfsys.itemlist i where itemid in(20205285,7777710); --777777  2020632 CZH_READROOM_APPOINTMENT  20205282 7777781
select rowid, i.* from sfsys.itemlist i where itemid = 777778; --20205291 7777711


select rowid,ff.* from sfsys.fieldlist ff where ff.fieldname = 'BOOKID';

--
select * from sfsys.actions a where a.actionid = 337;

select a.*
  from sfsys.checkaction c, sfsys.checkactions scc, sfsys.action a
 where c.actionid = a.actionid
   and c.checkid = scc.checkid
   and a.itemid = 7777791;

select * from sfsys.checkactions c where c.checkid in (930, 933);

declare
begin
  --阅览室管理
  --1.创建后台管理主窗体  toollist
  --2.创建树（保证节点在同一颗树上）treelist
  --3.设置根节点
  insert into sfsys.itemlist
    (ITEMID, settingid, caption, iconname, datatype)
  VALUES
    (777777, 777777, '测试图书馆', 'BOOKS', 1);
  --子节点，需设置parent_id与根节点关联  
  insert into sfsys.itemlist
    (ITEMID, settingid, caption, iconname, datatype)
  VALUES
    (777778, 777778, '阅览室管理', 'ADDRLIST', 1);
  insert into sfsys.itemlist
    (ITEMID, settingid, caption, iconname, datatype)
  VALUES
    (777779, 777779, '读者管理', 'GROUPS', 1);
  insert into sfsys.itemlist
    (ITEMID, settingid, caption, iconname, datatype)
  VALUES
    (7777710, 7777710, '图书管理', 'BOOKS', 1);

  insert into sfsys.itemlist
    (ITEMID, settingid, caption, iconname, datatype)
  VALUES
    (7777781, 7777781, '阅览室01', 'ADDRLIST', 1);

  insert into sfsys.itemlist
    (ITEMID, settingid, caption, iconname, datatype)
  VALUES
    (7777782, 7777782, '阅览室02', 'ADDRLIST', 1);
  --4.树节点主从关系
  select *
    from CZH_READROOM_APPOINTMENT cr
   where cr.roomid = '主树节点主键'
     FOR UPDATE;
  --从表dml
  insert into nsfdata.czh_readroom_appointment
    (appointmentid,
     readerid,
     readername,
     date_from,
     date_to,
     urgen,
     roomid)
  values
    (:appointmentid,
     :readerid,
     :readername,
     :date_from,
     :date_to,
     :urgen,
     %room_id%);

  update nsfdata.czh_readroom_appointment
     set appointmentid = :appointmentid,
         readerids     = :readerid,
         readernames   = :readername,
         begintime     = :date_from,
         endtime       = :date_to,
         urgent        = :urgen
   where appointmentid = :old_appointmentid;

  delete from nsfdata.czh_readroom_appointment
   where appointmentid = :old_appointmentid;

  --5.改字段描述
  select rowid, f.*
    from sfsys.fieldlist f
   where f.fieldname like 'ROOM_ID';

  --6.lookup
  select rowid, ls.* from sfsys.lookups ls where ls.lookid = 777781;
  select rowid, l.* from sfsys.lookup l WHERE l.itemid = 7777781; --URGEN     select t.urgenid,t.urgentext,t.pause from ITURGENS t; 777781
  
  select rowid, ls.* from sfsys.lookups ls where ls.lookid = 77777102;
  select rowid, ls.* from sfsys.lookups ls where ls.fieldname = upper('classname');
  select rowid, l.* from sfsys.lookup l WHERE l.itemid = 7777710;
  
  
  --读者管理 

  SELECT rownum AS line_num,
         cr.readerid,
         cr.readername,
         cr.sex,
         cr.phone,
         cr.email,
         cr.profession,
         cr.academy
    FROM CZH_READER_INFO cr;

  INSERT INTO CZH_READER_INFO
    (READERID, READERNAME, SEX, PHONE, EMAIL, PROFESSION, ACADEMY)
  VALUES
    (:READERID, :READERNAME, :SEX, :PHONE, :EMAIL, :PROFESSION, :ACADEMY);

  UPDATE CZH_READER_INFO CR
     SET CR.READERNAME = :READERNAME,
         CR.SEX        = :SEX,
         CR.PHONE      = :PHONE,
         CR.EMAIL      = :EMAIL,
         CR.PROFESSION = :PROFESSION,
         CR.ACADEMY    = :ACADEMY
   WHERE CR.READERID = :OLD_READERID;

  DELETE FROM CZH_READER_INFO CR WHERE CR.READERID = :OLD_READERID;
  --2.设置paramList（弹出框参数）
  
  select rowid,p.* from sfsys.paramlist p where p.paramname = upper('bookclassid');
 

  --3.设置action

  select rowid, a.* from sfsys.action a where a.itemid = 20205285;
  select * from sfsys.actions a where a.actionid = -20205288;
  select rowid, t.* from sfsys.actions t where t.actionid = -20205289;
  
  select rowid, a.* from sfsys.action a where a.itemid = 777779;
  select rowid, a.* from sfsys.actions a where a.actionid = 777779;
  select rowid, t.* from sfsys.actions t where t.actionid = -20205289;
  

     
  --3.设置Associate --7777711 注意Associate表中ITEMID问题
  select rowid, i.* from sfsys.itemlist i where itemid in (20205291,7777711); 
  select rowid, t.*
  from sfsys.treelist t
 where t.nodeid in (20205291,7777711);
 
  select rowid,a.* from sfsys.Associate a where a.itemid in (20205285,7777710);
 -- select rowid,a.* from sfsys.Associate a where a.itemid = 7777711;
  select rowid,a.* from sfsys.associates a where a.associateid in (-20205292,7777711);
 -- select rowid,a.* from sfsys.associates a where a.associateid = 7777711; 
  
  --4.Assignes自动赋值
  select rowid,a.* from sfsys.assign a;
  select rowid,a.* from sfsys.assignes a where a.assignid = 7777710;
  
  --5.DataEdit 批量更改  ？？？没效果
  select rowid,d.* from sfsys.dataedit d;
  select rowid,d.* from sfsys.dataedits d;
  
  --6.DefaultLists新增默认值
  select rowid,t.* from sfsys.defaultlists t where t.defaultid in (2020641,7777781);  
  select rowid,t.* from sfsys.defaultlists t where t.defaultid =7777781;     777779
  select rowid,t.* from sfsys.defaultlist t where t.itemid =7777781;  
  
  --7.ValueLists下拉列表
  --1)FieldList
  select rowid,t.* from sfsys.fieldlist t where t.fieldname = upper('publish');
  --2)ValueLists下拉列表
  select rowid,t.* from sfsys.valuelists t where t.valueid = 7777710; 
  select rowid,t.* from sfsys.valuelist t; 
  
  --8.PickLists弹出列表
  select rowid,t.* from sfsys.picklists t;--777779
  select rowid,t.* from sfsys.picklist t; --academy 
  
  --9.QryValueList过滤下拉框（查询界面）?????
  select rowid,t.* from sfsys.qryvaluelist t 
  
  --10.Aggregates纵向统计 777779
  select rowid,t.* from sfsys.aggregates t where t.aggreid =  7777791; --7777791
  select rowid,t.* from sfsys.aggregate t; 
  
  --11.Calculates横向统计
  select rowid,t.* from sfsys.calculates t;
  select rowid,t.* from sfsys.calculate t; --7777710
  
  --12. LinkItems
  select rowid, i.* from sfsys.itemlist i where itemid = 7777781;
  select rowid,t.* from sfsys.linkitems t where t.fromitemid =777778 ;    --777778  7777710   70001  70020  
   
  --13.33)LinkList    777779
  select rowid, i.* from sfsys.itemlist i where itemid = 777778;
  select rowid,t.* from sfsys.linklist t WHERE t.fromitemid = 7777781;
  
  --14.UnionList  ????没效果
  select rowid,t.* from sfsys.unionlist t where t.mainid = 7777781; --777778
  
  --15.35)URList
  select rowid,t.* from sfsys.urlist t;  --百度一下  https://www.baidu.com/
  
  --16. CheckValues输入项校验 
  select rowid, i.* from sfsys.itemlist i where itemid = 777779;
  select rowid,t.* from sfsys.checkvalues t where t.checkid =  777779;
  select rowid,t.* from sfsys.checkvalue t ;  --777779  phone
  
  --17.42)CheckParams 变量校验
  select rowid,t.* from sfsys.checkparams t; 
  select rowid,t.* from sfsys.checkparam t; 
  
  --18.36)CheckActions 检测数据操作的控制表  注意prompt问题
  select rowid, i.* from sfsys.itemlist i where itemid = 7777710;
  select rowid,t.* from sfsys.action t where t.itemid = 7777710;
  select rowid,t.* from sfsys.actions t where t.actionid = 77777102; 
  select rowid,t.* from sfsys.checkactions t where t.checkid = 77777102; --7777710
  select rowid,t.* from sfsys.checkaction t;  
  
 
end;


