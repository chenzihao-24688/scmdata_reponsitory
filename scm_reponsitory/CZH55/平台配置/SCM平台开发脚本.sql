--查看数据源
select a.*,a.rowid from nbw.sys_data_source a;
--主键生成
select  f_get_uuid() from dual;
--用户登录
SELECT rowid,a.* FROM SYS_USER_LOGIN a;
--抛异常，弹提示框
raise_application_error(-20002,'昵称长于7个字符或含有特殊字符');

--执行计划  explain plan for  F5
select * from plan_table;
select * from table(dbms_xplan.display);

--正则表达式
select *
   from scmdata.sys_group_dict t
  where regexp_like(t.group_dict_value, '.([a-z]+|[A-Z])');

--递归树
select rowid,t.*
  from nbw.sys_tree_list t
 start with t.item_id = 'g_500'
connect by prior t.item_id = t.parent_id;--node_g_500

select rowid, t.* from nbw.sys_item t;
select rowid, t.* from nbw.sys_tree_list t;
select rowid, t.* from nbw.sys_item_list t;

--nbw 放配置  scmdata放业务
--平台后台 node_g_500
--1.用户管理

select * from scmdata.sys_user;
select decode(u.pause, 0, '正常', 1, '停用') pause,
       u.avatar,
       u.nick_name,
       u.user_account,
       u.city,
       u.sex,
       u.birthday
 from scmdata.sys_user u;
 

 
select * from nbw.sys_tree_list t where t.node_id = 'node_g_500' ; --g_500

select rowid,t.* from nbw.sys_item t where t.item_id in('g_500','g_501','g_502','g_503') ;
select rowid,t.* from nbw.sys_tree_list t where t.item_id in('g_500','g_501','g_502','g_503') ;
select rowid,t.* from nbw.sys_item_list t where t.item_id in('g_500','g_501','g_502','g_503') ;

--字段配置
select rowid,t.* from nbw.sys_field_list t; 
select rowid,t.* from nbw.sys_param_list t;


--按钮配置
--action
select rowid,t.* from nbw.sys_element t  where t.element_id in ('action_g_501_1','action_g_501_2','action_g_501_3','action_g_501_4','action_g_501_5'); 
select rowid,t.* from nbw.sys_action t  where t.element_id in ('action_g_501_1','action_g_501_2','action_g_501_3','action_g_501_4','action_g_501_5');
select rowid,t.* from nbw.sys_item_element_rela t where t.element_id in ('action_g_501_1','action_g_501_2','action_g_501_3','action_g_501_4','action_g_501_5');

select rowid,t.* from nbw.sys_element_hint t  ;

--弹出详情页面  associate-501-6
--associate 配置  未配置完
select rowid,t.* from nbw.sys_element t  where t.element_id in ('associate-501-6','associate-503-9'); 
select rowid,t.* from nbw.sys_associate t  where t.element_id in ('associate-501-6','associate-503-9');
select rowid,t.* from nbw.sys_item_element_rela t where t.element_id in ('associate-501-6','associate-503-9');
select rowid,t.* from nbw.sys_element_hint t ;

--TAB页  --g_502   node_g_502  g_502_1 ~6
select rowid,t.* from nbw.sys_item t;
select rowid,t.* from nbw.sys_tree_list t;--未配置
select rowid,t.* from nbw.sys_item_list t ;--未配置
select rowid,t.* from nbw.sys_web_union t;
select rowid,t.* from nbw.sys_item_rela t;--主从表
select rowid,t.* from nbw.sys_field_list t; 
select rowid,t.* from nbw.sys_param_list t;

--sys_value_list  平台角色下拉


--下拉框
select rowid,t.* from nbw.sys_element t ;

select rowid,t.* from nbw.sys_look_up t ;

select rowid,t.* from nbw.sys_value_list t;

select rowid,t.* from nbw.sys_item_element_rela t ;

--按钮触发 paramList
select rowid,t.* from nbw.sys_field_list t ; 
select rowid,t.* from nbw.sys_param_list t;

--sys_field_qryvalue 过滤下拉框（还有些问题，需要改）

select rowid,t.* from nbw.sys_field_qryvalue t ;-- PAUSE  USER_TYPE

select rowid, t.* from scmdata.SYS_QRYVALUE_LIST t;

--非结构化condition 平台管理员可见  控制item

select rowid,t.* from nbw.sys_cond_list t;  --g_505_1  node_g_505_1

select rowid,t.* from nbw.sys_cond_rela t; --node_g_501

--控制action   cond_czh_505_3_5
select rowid,t.* from nbw.sys_cond_list t;

select rowid,t.* from nbw.sys_cond_rela t;


--支持列和按钮关联，点击列数据时，触发对应关联的按钮
select rowid,t.* from nbw.sys_element_hint t  ;

--主从表
select rowid,t.* from nbw.sys_item_rela t;

select rowid,t.* from nbw.sys_item t;
select rowid,t.* from nbw.sys_tree_list t;--未配置
select rowid,t.* from nbw.sys_item_list t;--未配置
select rowid,t.* from nbw.sys_item_rela t;

select rowid,t.* from nbw.sys_element t  where t.element_id in ('associate-501-6','associate-503-9'); 
select rowid,t.* from nbw.sys_associate t  where t.element_id in ('associate-501-6','associate-503-9');
select rowid,t.* from nbw.sys_item_element_rela t where t.element_id in ('associate-501-6','associate-503-9');
select rowid,t.* from nbw.sys_element_hint t ;

--2.企业管理
select rowid,t.* from nbw.sys_item t where t.item_id in('g_500','g_501','g_502','g_503') ;
select rowid,t.* from nbw.sys_tree_list t where t.item_id in('g_500','g_501','g_502','g_503') ;
select rowid,t.* from nbw.sys_item_list t where t.item_id in('g_500','g_501','g_502','g_503') ;

--字段配置
select rowid,t.* from nbw.sys_field_list t; 

--按钮配置
select rowid,t.* from nbw.sys_element t  where t.element_id in ('action_g_503_1','action_g_503_2'); 
select rowid,t.* from nbw.sys_action t  where t.element_id in ('action_g_503_1','action_g_503_2');
select rowid,t.* from nbw.sys_item_element_rela t where t.element_id in ('action_g_503_1','action_g_503_2');



--快捷键配置
select rowid,t.* from nbw.sys_item t;

select rowid,t.* from nbw.sys_shortcut t;

select rowid,t.* from nbw.sys_shortcut_node_rela t;

select rowid,t.* from nbw.sys_item_custom t;

--3.应用管理  g_504

select rowid,t.* from nbw.sys_item t  ;
select rowid,t.* from nbw.sys_tree_list t  ;
select rowid,t.* from nbw.sys_item_list t ;

--字段配置
select rowid,t.* from nbw.sys_field_list t; 

--按钮配置
select rowid,t.* from nbw.sys_element t  where t.element_id in ('action_g_504_1','action_g_504_2','action_g_504_3','action_g_504_4'); 
select rowid,t.* from nbw.sys_action t  where t.element_id in ('action_g_504_1','action_g_504_2','action_g_504_3','action_g_504_4');
select rowid,t.* from nbw.sys_item_element_rela t where t.element_id in ('action_g_504_1','action_g_504_2','action_g_504_3','action_g_504_4');

--3.1 价格配置
--g_504_1 --associate_g_504_3
select rowid, t.* from nbw.sys_item t where t.item_id LIKE '%g_504%';
select rowid, t.* from nbw.sys_tree_list t where t.item_id LIKE '%g_504%';
select rowid, t.* from nbw.sys_item_list t where t.item_id LIKE '%g_504%';

select rowid,t.* from nbw.sys_element t ;

select rowid,t.* from nbw.sys_look_up t where t.element_id like '%lookup_g_504_4%' ;

select rowid,t.* from nbw.sys_item_element_rela t ;

select rowid,t.* from nbw.sys_field_list t ; 

--3.2绑定应用


--4.角色权限管理 g_505
select rowid,t.* from nbw.sys_item t  ;
select rowid,t.* from nbw.sys_tree_list t  ;
select rowid,t.* from nbw.sys_item_list t  ;
select rowid,t.* from nbw.sys_web_union t;--分页
select rowid,t.* from nbw.sys_item_rela t;--主从表

select rowid,t.* from nbw.sys_link_list t;--group_role_name

select rowid,t.* from nbw.sys_element t  where t.element_id in ('action_g_505_3_1','action_g_505_3_5'); --action_g_505_3_5
select rowid,t.* from nbw.sys_action t  where t.element_id in ('action_g_505_3_1','action_g_505_3_5');
select rowid,t.* from nbw.sys_item_element_rela t where t.element_id in ('action_g_505_3_1','action_g_505_3_5');


--控制action   cond_czh_505_3_5
select rowid,t.* from nbw.sys_cond_list t;

select rowid,t.* from nbw.sys_cond_rela t;

select rowid,t.* from scmdata.SYS_GROUP_ROLE t ;
select rowid,t.* from scmdata.SYS_GROUP_ROLE_SECURITY t ;
select rowid,t.* from scmdata.SYS_GROUP_SECURITY t ;
select rowid,t.* from scmdata.SYS_GROUP_USER_ROLE t;

--字段配置
select rowid,t.* from nbw.sys_field_list t; 

--按钮配置  g_505_3   action_g_505_3_5
select rowid,t.* from nbw.sys_element t  where t.element_id in ('action_g_505_3_1','action_g_505_3_5'); --action_g_505_3_5
select rowid,t.* from nbw.sys_action t  where t.element_id in ('action_g_505_3_1','action_g_505_3_5');
select rowid,t.* from nbw.sys_item_element_rela t where t.element_id in ('action_g_505_3_1','action_g_505_3_5');

--按钮触发 paramList
select rowid,t.* from nbw.sys_field_list t; 
select rowid,t.* from nbw.sys_param_list t;

--用户弹出框选择 picklist  g_505_7   pick_g_505_7

select rowid,t.* from nbw.sys_element t;

select rowid,t.* from nbw.sys_pick_list t;

select rowid,t.* from nbw.sys_item_element_rela t;

--5.数据字典
select rowid,t.* from nbw.sys_item t where t.item_id like '%g_%' ;
select rowid,t.* from nbw.sys_tree_list t where t.item_id like '%g_%' ;
select rowid,t.* from nbw.sys_item_list t where t.item_id like '%g_%'  ;
select rowid,t.* from nbw.sys_web_union t;--分页
select rowid,t.* from nbw.sys_item_rela t;--主从表

--字段配置
select rowid,t.* from nbw.sys_field_list t; 


--按钮配置  action_g_506
select rowid,t.* from nbw.sys_element t  where t.element_id in ('action_g_504_1','action_g_504_2','action_g_504_3','action_g_504_4','action_g_506_1','action_g_506_2'); 
select rowid,t.* from nbw.sys_action t  where t.element_id in ('action_g_504_1','action_g_504_2','action_g_504_3','action_g_504_4','action_g_506_1','action_g_506_2');
select rowid,t.* from nbw.sys_item_element_rela t where t.element_id in ('action_g_504_1','action_g_504_2','action_g_504_3','action_g_504_4','action_g_506_1','action_g_506_2');

--checkaction
select rowid,t.* from nbw.sys_action t;

select rowid,t.* from nbw.sys_cond_rela t;

select rowid,t.* from nbw.sys_cond_list t;

select rowid,t.* from nbw.sys_cond_operate t;
