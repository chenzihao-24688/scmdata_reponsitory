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

--�ݹ���   
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
  --�����ҹ���
  --1.������̨����������  toollist
  --2.����������֤�ڵ���ͬһ�����ϣ�treelist
  --3.���ø��ڵ�
  insert into sfsys.itemlist
    (ITEMID, settingid, caption, iconname, datatype)
  VALUES
    (777777, 777777, '����ͼ���', 'BOOKS', 1);
  --�ӽڵ㣬������parent_id����ڵ����  
  insert into sfsys.itemlist
    (ITEMID, settingid, caption, iconname, datatype)
  VALUES
    (777778, 777778, '�����ҹ���', 'ADDRLIST', 1);
  insert into sfsys.itemlist
    (ITEMID, settingid, caption, iconname, datatype)
  VALUES
    (777779, 777779, '���߹���', 'GROUPS', 1);
  insert into sfsys.itemlist
    (ITEMID, settingid, caption, iconname, datatype)
  VALUES
    (7777710, 7777710, 'ͼ�����', 'BOOKS', 1);

  insert into sfsys.itemlist
    (ITEMID, settingid, caption, iconname, datatype)
  VALUES
    (7777781, 7777781, '������01', 'ADDRLIST', 1);

  insert into sfsys.itemlist
    (ITEMID, settingid, caption, iconname, datatype)
  VALUES
    (7777782, 7777782, '������02', 'ADDRLIST', 1);
  --4.���ڵ����ӹ�ϵ
  select *
    from CZH_READROOM_APPOINTMENT cr
   where cr.roomid = '�����ڵ�����'
     FOR UPDATE;
  --�ӱ�dml
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

  --5.���ֶ�����
  select rowid, f.*
    from sfsys.fieldlist f
   where f.fieldname like 'ROOM_ID';

  --6.lookup
  select rowid, ls.* from sfsys.lookups ls where ls.lookid = 777781;
  select rowid, l.* from sfsys.lookup l WHERE l.itemid = 7777781; --URGEN     select t.urgenid,t.urgentext,t.pause from ITURGENS t; 777781
  
  select rowid, ls.* from sfsys.lookups ls where ls.lookid = 77777102;
  select rowid, ls.* from sfsys.lookups ls where ls.fieldname = upper('classname');
  select rowid, l.* from sfsys.lookup l WHERE l.itemid = 7777710;
  
  
  --���߹��� 

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
  --2.����paramList�������������
  
  select rowid,p.* from sfsys.paramlist p where p.paramname = upper('bookclassid');
 

  --3.����action

  select rowid, a.* from sfsys.action a where a.itemid = 20205285;
  select * from sfsys.actions a where a.actionid = -20205288;
  select rowid, t.* from sfsys.actions t where t.actionid = -20205289;
  
  select rowid, a.* from sfsys.action a where a.itemid = 777779;
  select rowid, a.* from sfsys.actions a where a.actionid = 777779;
  select rowid, t.* from sfsys.actions t where t.actionid = -20205289;
  

     
  --3.����Associate --7777711 ע��Associate����ITEMID����
  select rowid, i.* from sfsys.itemlist i where itemid in (20205291,7777711); 
  select rowid, t.*
  from sfsys.treelist t
 where t.nodeid in (20205291,7777711);
 
  select rowid,a.* from sfsys.Associate a where a.itemid in (20205285,7777710);
 -- select rowid,a.* from sfsys.Associate a where a.itemid = 7777711;
  select rowid,a.* from sfsys.associates a where a.associateid in (-20205292,7777711);
 -- select rowid,a.* from sfsys.associates a where a.associateid = 7777711; 
  
  --4.Assignes�Զ���ֵ
  select rowid,a.* from sfsys.assign a;
  select rowid,a.* from sfsys.assignes a where a.assignid = 7777710;
  
  --5.DataEdit ��������  ������ûЧ��
  select rowid,d.* from sfsys.dataedit d;
  select rowid,d.* from sfsys.dataedits d;
  
  --6.DefaultLists����Ĭ��ֵ
  select rowid,t.* from sfsys.defaultlists t where t.defaultid in (2020641,7777781);  
  select rowid,t.* from sfsys.defaultlists t where t.defaultid =7777781;     777779
  select rowid,t.* from sfsys.defaultlist t where t.itemid =7777781;  
  
  --7.ValueLists�����б�
  --1)FieldList
  select rowid,t.* from sfsys.fieldlist t where t.fieldname = upper('publish');
  --2)ValueLists�����б�
  select rowid,t.* from sfsys.valuelists t where t.valueid = 7777710; 
  select rowid,t.* from sfsys.valuelist t; 
  
  --8.PickLists�����б�
  select rowid,t.* from sfsys.picklists t;--777779
  select rowid,t.* from sfsys.picklist t; --academy 
  
  --9.QryValueList���������򣨲�ѯ���棩?????
  select rowid,t.* from sfsys.qryvaluelist t 
  
  --10.Aggregates����ͳ�� 777779
  select rowid,t.* from sfsys.aggregates t where t.aggreid =  7777791; --7777791
  select rowid,t.* from sfsys.aggregate t; 
  
  --11.Calculates����ͳ��
  select rowid,t.* from sfsys.calculates t;
  select rowid,t.* from sfsys.calculate t; --7777710
  
  --12. LinkItems
  select rowid, i.* from sfsys.itemlist i where itemid = 7777781;
  select rowid,t.* from sfsys.linkitems t where t.fromitemid =777778 ;    --777778  7777710   70001  70020  
   
  --13.33)LinkList    777779
  select rowid, i.* from sfsys.itemlist i where itemid = 777778;
  select rowid,t.* from sfsys.linklist t WHERE t.fromitemid = 7777781;
  
  --14.UnionList  ????ûЧ��
  select rowid,t.* from sfsys.unionlist t where t.mainid = 7777781; --777778
  
  --15.35)URList
  select rowid,t.* from sfsys.urlist t;  --�ٶ�һ��  https://www.baidu.com/
  
  --16. CheckValues������У�� 
  select rowid, i.* from sfsys.itemlist i where itemid = 777779;
  select rowid,t.* from sfsys.checkvalues t where t.checkid =  777779;
  select rowid,t.* from sfsys.checkvalue t ;  --777779  phone
  
  --17.42)CheckParams ����У��
  select rowid,t.* from sfsys.checkparams t; 
  select rowid,t.* from sfsys.checkparam t; 
  
  --18.36)CheckActions ������ݲ����Ŀ��Ʊ�  ע��prompt����
  select rowid, i.* from sfsys.itemlist i where itemid = 7777710;
  select rowid,t.* from sfsys.action t where t.itemid = 7777710;
  select rowid,t.* from sfsys.actions t where t.actionid = 77777102; 
  select rowid,t.* from sfsys.checkactions t where t.checkid = 77777102; --7777710
  select rowid,t.* from sfsys.checkaction t;  
  
 
end;


