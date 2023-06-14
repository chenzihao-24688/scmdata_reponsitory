select rowid,t.* from bwptest1.sys_item t where t.item_id = 'data-20207221';

--递归树
select rowid,t.*
  from bwptest1.sys_tree_list t
 start with t.item_id = 'data-202072'
connect by prior t.item_id = t.parent_id;--czh2000

select rowid,t.* from bwptest1.sys_item_list t where t.item_id = 'data-20207221';
--czhdata-2000
--菜单配置

select rowid,t.* from bwptest1.sys_item t where t.item_id in('data-20207131','data-202071311','data-2020713111') ;  --data-202071   czh2000  czhdata-2000  czhdata-2000  node-data-20207131  data-202071311
select rowid,t.* from bwptest1.sys_tree_list t where t.item_id in('data-20207131','data-202071311','data-2020713111') ;--data-202071
select rowid,t.* from bwptest1.sys_item_list t where t.item_id in ('data-20207131','data-202071311','data-2020713111'); 
select rowid,t.* from bwptest1.sys_item_custom t ;
select rowid,t.* from bwptest1.sys_item  t where t.base_table like '%PL_DIC_CATEGORYGROUPS%' 
--------------------------------------------------------------------------------------------------

select rowid,t.* from bwptest1.sys_item t where t.item_id in('scm_p_1','scm_p_10','scm_p_20','scm_p_30','scm_p_40') ;  --data-202071   czh2000  czhdata-2000  czhdata-2000  node-data-20207131  data-202071311
select rowid,t.* from bwptest1.sys_tree_list t where t.item_id in('scm_p_1','scm_p_10','scm_p_20','scm_p_30','scm_p_40') ;--data-202071
select rowid,t.* from bwptest1.sys_item_list t where t.item_id in ('scm_p_1','scm_p_10','scm_p_20','scm_p_30','scm_p_40'); 



--页面配置
--1. 页面类型
--标准查询器：sys_item SYS_ITEM_LIST sys_field_list
--快捷查询器：SYS_QUICK_QUERY
select rowid,t.* from bwptest1.SYS_QUICK_QUERY t ; --data-202071212 a.bra_id,a.bra_name

--标准钻取  ???
select rowid,t.* from bwptest1.RESOURCES_DRILL t ;--data-202071221
select rowid,t.* from bwptest1.RESOURCES_DRILL_RESULT t ;
select rowid,t.* from bwptest1.resources_drill_level t ;

--登录相关参数的配置 7.2号继续看
--个人中心配置
select rowid,t.* from bwptest1.sys_item t where t.item_id = 'scm_p_1';
select rowid,t.* from bwptest1.sys_tree_list t where t.node_id = 'node-scm_p_1';
select rowid,t.* from bwptest1.sys_item_list t where t.item_id = 'scm_p_1'; 
select rowid,t.* from bwptest1.SYS_PERSONAL_MENU t ;--node_czh2000  node-data-20207124

--个人信息配置  
select rowid,t.* from bwptest1.sys_config t ; 
select rowid,t.* from bwptest1.sys_sql_config t where t.sql_name in ('user_info','modify_user_info');

--2. 页面模板
--通用功能

select rowid,t.* from bwptest1.sys_item t ;
select rowid,t.* from bwptest1.sys_tree_list t ;
select rowid,t.* from bwptest1.sys_item_list t  ;
select rowid,t.* from bwptest1.sys_element_hint t ;
select rowid,t.* from bwptest1.sys_field_back_color t ;

--增删改操作

--钻取

--超链接（即行下级功能）  需要配置多一个item   data-2020713111   CUSGROUPNO在这一item_list 通过 %ASS_cusgroupno%与上级关联起来  

--注意LINK_FIELD字段

select rowid,t.* from bwptest1.sys_item t where t.item_id in('data-20207131','data-202071311','data-2020713111') ;  --data-202071   czh2000  czhdata-2000  czhdata-2000  node-data-20207131  data-202071311
select rowid,t.* from bwptest1.sys_tree_list t where t.item_id in('data-20207131','data-202071311','data-2020713111') ;--data-202071
select rowid,t.* from bwptest1.sys_item_list t where t.item_id in ('data-20207131','data-202071311','data-2020713111'); 

--actions基于数据按钮  注意SELECT_FIELDS的使用
--表： sys_element  sys_action  sys_item_element_rela   
--data-czh20001
select rowid,t.* from bwptest1.sys_element t  where t.element_id in ('action-test-3','action-20207131','action-202071311'); --action-20001  associate-test-1
select rowid,t.* from bwptest1.sys_action t  where t.element_id in ('action-test-3', 'action-20207131','action-202071311');--action-20001  associate-test-1
select rowid,t.* from bwptest1.sys_item_element_rela t where t.element_id in ('action-test-3','action-20207131','action-202071311'); --node-data-20207131  action-20207131  node-data-20207131


--支持列和按钮关联，点击列数据时，触发对应关联的按钮
select rowid,t.* from bwptest1.sys_item t where t.item_id in('test-4','data-20207131','data-202071311') ; 
select rowid,t.* from bwptest1.sys_item_list t where t.item_id in ('test-4','data-20207131','data-202071311','data-2020713111'); 

select rowid,t.* from bwptest1.sys_element_hint t; 


--页眉页脚

select rowid,t.* from bwptest1.sys_item t where t.item_id in('test-4','data-20207131','data-202071311','data-2020713111') ;  --data-202071   czh2000  czhdata-2000  czhdata-2000  node-data-20207131  data-202071311
select rowid,t.* from bwptest1.sys_tree_list t where t.item_id in('test-4','data-20207131','data-202071311','data-2020713111') ;--data-202071
select rowid,t.* from bwptest1.sys_item_list t where t.item_id in ('test-4','data-20207131','data-202071311','data-2020713111'); 


--界面支持对行进行背景颜色配置（仅表格、列表）

select a.bra_id,
       a.bra_name,
       a.fullname,
       a.jdbra_id,
       a.jdbra_name,
       '查询分部详情' excute,
       case a.bra_name
         when '男装' then
          65280
         when '女装' then
          65535
       end GRIDBACKCOLOR
  from nsfdata.branch a

--界面支持对单个列进行背景颜色配置  data-20207131
select rowid,t.* from bwptest1.sys_field_back_color t ;

--界面支持对单个列进行字体颜色配置（表格、列表）

select a.cusgroupno,
       a.cusgroupname,
       CASE
         WHEN a.cusgroupno = '152' THEN
          255
         ELSE
          NULL
       END GRIDFORECOLOR
  from nsfdata.pl_dic_cusgroups a
 where bra_id = %bra_id%

select a.categorygroupno,
       a.categorygroup,
       CASE
         WHEN a.categorygroupno = '152' THEN
          255
         ELSE
          NULL
       END GRIDFORECOLOR
  from nsfdata.pl_dic_categorygroup a;
  

--表格

select rowid,t.* from bwptest1.sys_item t where t.item_id in('data-2020713','data-20207132','data-202071321','data-202071322') ;  --data-202071   czh2000  czhdata-2000  czhdata-2000  node-data-20207131  data-202071311
select rowid,t.* from bwptest1.sys_tree_list t where t.item_id in('data-2020713','data-20207132','data-202071321','data-202071322') ;--data-202071
select rowid,t.* from bwptest1.sys_item_list t where t.item_id in ('data-2020713','data-20207132','data-202071321','data-202071322'); 

--node-test-7

--交叉制表  data-202071321  p-202071321
select rowid,t.* from bwptest1.sys_item t where t.item_id in ('test-7','data-202071321');

select rowid,t.* from bwptest1.sys_item_list t where t.item_id in ('test-7','data-202071321');

select rowid,t.* from bwptest1.sys_tree_list t where t.item_id in ('test-7','data-202071321');

select rowid,t.* from bwptest1.sys_item_rela t where t.item_id in ('data-202071321','test-7') ;

select rowid,t.* from bwptest1.sys_pivot_list t where t.pivot_id in ('p-test-1','p-202071321'); 


--抽象字段  node-data-202071322
select rowid,t.* from bwptest1.sys_item t  where t.item_id in ('data-202071322');

select rowid,t.* from bwptest1.sys_item_list t where t.item_id in ('data-202071322');

select rowid,t.* from bwptest1.sys_item_rela t where t.item_id in ('data-202071322');

select rowid,t.* from bwptest1.sys_element t; --adt-202071322

select rowid,t.* from bwptest1.sys_adt_field t;

select rowid,t.* from bwptest1.sys_item_element_rela t;


--单页  n2_test_dy-1
select rowid,t.* from bwptest1.sys_item t where t.item_id in('n2_test_dy-1','data-20207132','data-20207133','data-202071331','data-202071332') ;  --data-202071   czh2000  czhdata-2000  czhdata-2000  node-data-20207131  data-202071311
select rowid,t.* from bwptest1.sys_tree_list t where t.item_id in('n2_test_dy-1','data-20207132','data-20207133','data-20207133','data-202071331','data-202071332') ;--data-202071
select rowid,t.* from bwptest1.sys_item_list t where t.item_id in ('n2_test_dy-1','data-20207132','data-20207133','data-20207133','data-202071331','data-202071332'); --node-data-20207133 node-data-202071331 node-data-202071332
select rowid,t.* from bwptest1.sys_detail_group t;  --data-202071332

--列表  data-20207133  scm_1003

select rowid,t.* from bwptest1.sys_item t where t.item_id in('n2_test_dy-1','data-20207132','data-20207133','data-202071331','data-202071332','scm_1003','data-20207134') ;  --data-202071   czh2000  czhdata-2000  czhdata-2000  node-data-20207131  data-202071311
select rowid,t.* from bwptest1.sys_tree_list t where t.item_id in('n2_test_dy-1','data-20207132','data-20207133','data-20207133','data-202071331','data-202071332','scm_1003','data-20207134') ;--data-202071
select rowid,t.* from bwptest1.sys_item_list t where t.item_id in ('n2_test_dy-1','data-20207132','data-20207133','data-20207133','data-202071331','data-202071332','scm_1003','data-20207134');
--select rowid,t.* from bwptest1.sys_tree_list t  where t.node_id = 'node_scm1003';
select rowid,t.* from bwptest1.sys_layout t where t.item_id = 'scm_1003'; --node_scm1003 scm_1003

--标准图  data-20207135
select rowid,t.* from bwptest1.sys_item t where t.item_id in('test-15','data-20207135') ;  --data-202071   czh2000  czhdata-2000  czhdata-2000  node-data-20207131  data-202071311
select rowid,t.* from bwptest1.sys_tree_list t where t.item_id in('test-15','data-20207135') ;--data-202071
select rowid,t.* from bwptest1.sys_item_list t where t.item_id in ('test-15','data-20207135');
--面板表
select rowid,t.* from bwptest1.sys_panel t where t.panel_id in ('p-test-5','p-20207135');
--面板属性表
select rowid,t.* from bwptest1.sys_panel_attribute t where t.panel_id  in ('p-test-5','p-20207135');

--select rowid,t.* from bwptest1.sys_item t where t.panel_id = 'p-test-5'; 
select rowid,t.* from bwptest1.sys_item_list t where t.item_id = 'test-15' ;

--通讯录  n1011_data-1005
select rowid,t.* from bwptest1.sys_item t where t.item_id in('data-1005','data-20207135') ;  --data-202071   czh2000  czhdata-2000  czhdata-2000  node-data-20207131  data-202071311
select rowid,t.* from bwptest1.sys_tree_list t where t.item_id in('data-1005','data-20207135') ;--data-202071
select rowid,t.* from bwptest1.sys_item_list t where t.item_id in ('data-1005','data-20207135','data-20207136');
 
--页面组装  data-2020714

select rowid,t.* from bwptest1.sys_item t where t.item_id in('data-1005','data-2020714','data-20207141','data-20207142','data-202071411','data-202071412') ;  --data-202071   czh2000  czhdata-2000  czhdata-2000  node-data-20207131  data-202071311
select rowid,t.* from bwptest1.sys_tree_list t where t.item_id in('data-1005','data-2020714','data-20207141','data-20207142','data-202071411','data-202071412') ;--data-202071
select rowid,t.* from bwptest1.sys_item_list t where t.item_id in ('data-1005','data-2020714','data-20207141','data-20207142','data-202071411','data-202071412');

--tab页
select rowid,t.* from bwptest1.sys_web_union t; --data-20207141

--主从表  data-20207131
select rowid,t.* from bwptest1.sys_item t where t.item_id in('data-20207131','data-202071311','data-2020713111','data-20207142','data-202071421','data-202071422') ;  --data-202071   czh2000  czhdata-2000  czhdata-2000  node-data-20207131  data-202071311
select rowid,t.* from bwptest1.sys_tree_list t where t.item_id in('data-20207131','data-202071311','data-2020713111','data-20207142','data-202071421','data-202071422') ;--data-202071
select rowid,t.* from bwptest1.sys_item_list t where t.item_id in ('data-20207131','data-202071311','data-2020713111','data-20207142','data-202071421','data-202071422');

select rowid,t.* from bwptest1.sys_item_rela t ; --data-20207142  data-202071421 data-202071422


--功能配置  data-202072

select rowid,t.* from bwptest1.sys_item t where t.item_id in('data-202071321','data-20207131','data-202071','data-2020712','data-20207211','data-20207221') ;  --data-202071   czh2000  czhdata-2000  czhdata-2000  node-data-20207131  data-202071311
select rowid,t.* from bwptest1.sys_tree_list t where t.item_id in('data-202071321','data-20207131','data-202071','data-2020712','data-20207211','data-20207221') ;--data-202071
select rowid,t.* from bwptest1.sys_item_list t where t.item_id in ('data-202071321','data-20207131','data-202071','data-2020712','data-20207211','data-20207221');

--字段配置（加密字段，敏感字段）

select rowid,t.* from bwptest1.sys_field_list t; 

--字段控制  data-20207211  action-20207211  control-20207211-1  2  3 （有问题）？？？？

select rowid,t.* from bwptest1.Sys_element t;

select rowid,t.* from bwptest1.sys_item_element_rela t where t.element_id = 'control-20207211-1';

select rowid,t.* from bwptest1.SYS_FIELD_CONTROL t; 

select a.bra_id,
       a.bra_name,
       a.fullname,
       a.jdbra_id,
       a.jdbra_name,
       '查询分部详情' excute,
       case a.bra_name
         when '男装' then
          65280
         when '女装' then
          65535
       end GRIDBACKCOLOR
  from nsfdata.branch a;--FULLNAME,JDBRA_ID,JDBRA_NAME
  
  
--辅助输入  node-data-202071321  data-20207221

--自动赋值  data-20207211  assign-20207211

select rowid,t.* from bwptest1.sys_element t where t.element_id = 'assign-20207211';
select rowid,t.* from bwptest1.sys_assign t where t.element_id = 'assign-20207211' ;
select rowid,t.* from bwptest1.sys_item_element_rela t  where t.element_id = 'assign-20207211';

--default新增默认值  data-20207211   default-20207211

select rowid,t.* from bwptest1.sys_element t ;

select rowid,t.* from bwptest1.sys_default t ;

select rowid,t.* from bwptest1.sys_item_element_rela t ; 

--lookup下拉选择列表 data-20207211  look-20207211

select rowid,t.* from bwptest1.sys_element t;

select rowid,t.* from bwptest1.sys_look_up t;

select rowid,t.* from bwptest1.sys_item_element_rela t;

--valuelist下拉列表 data-20207211 value-20207211

select rowid,t.* from bwptest1.sys_element t;

select rowid,t.* from bwptest1.sys_value_list t;

select rowid,t.* from bwptest1.sys_item_element_rela t;
 
--picklist弹出列表  data-20207221 pick-20207221-1 2 3 (表格，单层，多层弹出)

select rowid,t.* from bwptest1.sys_element t;

select rowid,t.* from bwptest1.sys_pick_list t;

select rowid,t.* from bwptest1.sys_item_element_rela t;

--qryvaluelist过滤下拉框（查询界面） data-20207221


select rowid,t.* from bwptest1.sys_field_list t where t.field_name like '%FULLNAME%';

select rowid,t.* from bwptest1.sys_field_qryvalue t; --FULLNAME


--树模板   data-20207222




--pick+assign  data-20207223  pickassign-20207223   注意分号：GetUserNames

select rowid,t.* from bwptest1.sys_element t where t;

select rowid,t.* from bwptest1.sys_pick_list t where t.element_id = 'pickassign-20207223';

select rowid,t.* from bwptest1.sys_assign t WHERE t.element_id = 'assign-20207223';

select rowid,t.* from bwptest1.sys_item_element_rela t;



--纵向统计
select rowid,t.* from bwptest1.sys_element t;

select rowid,t.* from bwptest1.sys_field_list t;

select rowid,t.* from bwptest1.sys_aggregate t;

select rowid,t.* from bwptest1.sys_item_element_rela t;
