--1.action
DECLARE
  v_sql VARCHAR2(4000);
BEGIN
  v_sql := 'select 1 from dual';

  nbw.pkg_plat_config.config_actions(p_item_id       => 'g_540_1', --item_id
                                     p_element_id    => 'action_g_540_1_1', --按钮id
                                     p_element_type  => 'action', --按钮类型
                                     p_data_source   => 'oracle_scmdata', --数据源
                                     p_seq_no        => 1, --序号
                                     p_pause         => 0, --是否禁用
                                     p_is_hide       => 0, --是否隐藏
                                     p_caption       => '打印控制', --按钮名称
                                     p_action_type   => 4, --按钮操作类型
                                     p_action_sql    => v_sql, --按钮sql
                                     p_select_fields => '', --选择字段 按需填
                                     p_refresh_flag  => 1, --刷新标志                                                                         
                                     p_status        => 1);
END;

SELECT ROWID, t.*
  FROM nbw.sys_element t
 WHERE t.element_id = 'action_c_2300_1_1';
SELECT ROWID, t.*
  FROM nbw.sys_action t
 WHERE t.element_id = 'action_c_2300_1_5';
SELECT ROWID, t.*
  FROM nbw.sys_item_element_rela t
 WHERE t.element_id = 'action_c_2300_1_1';

--2. lookup nbw.sys_look_up

DECLARE
  v_look_up_sql VARCHAR2(4000);
BEGIN
  v_look_up_sql := q'[SELECT a.group_dict_value deduction_method_pr,
       a.group_dict_name  deduction_method_desc
  FROM scmdata.sys_group_dict a
 WHERE a.group_dict_type = 'DEDUCTION_METHOD'
   AND a.pause = 0]';

  nbw.pkg_plat_config.config_look_ups(p_item_id          => 'a_product_118', --item_id
                                      p_element_id       => 'look_a_product_118_5', --按钮id
                                      p_element_type     => 'lookup', --按钮类型
                                      p_data_source      => 'oracle_scmdata', --数据源
                                      p_seq_no           => 1, --序号
                                      p_pause            => 0, --是否禁用
                                      p_is_hide          => 0, --是否隐藏
                                      p_field_name       => 'deduction_method_desc', --字段名 desc
                                      p_look_up_sql      => v_look_up_sql, --列表sql 
                                      p_data_type        => '1', --数据类型1:下拉框类型,2.radio单选框,3.checkbox复选框 
                                      p_key_field        => 'deduction_method_pr', --主键字段 pr
                                      p_result_field     => 'deduction_method_desc', --result_field desc
                                      p_before_field     => 'deduction_method_pr', --before_field pr
                                      p_search_flag      => 0, --搜索标志  0：不可搜索  1：可搜索   
                                      p_multi_value_flag => 0, --多选标志  0：单选  1：允许多选 
                                      p_disabled_field   => 0, --禁用字段   该字段获取的结果  0：可选  1：不可选 
                                      p_group_field      => '', --分组字段   只允许配置一个 
                                      p_value_sep        => '', --分隔符   
                                      p_icon             => '', --图片字段列 
                                      p_status           => 1);

END;

SELECT ROWID, t.*
  FROM nbw.sys_element t
 WHERE t.element_id = 'look_a_product_118_5';
SELECT ROWID, t.*
  FROM nbw.sys_look_up t
 WHERE t.element_id = 'look_a_quotation_111_2_2';
SELECT ROWID, t.*
  FROM nbw.sys_item_element_rela t
 WHERE t.element_id = 'look_a_product_118_5';

--3.pick_list
DECLARE
  v_pick_sql CLOB;
BEGIN
  v_pick_sql := q'[SELECT g.apply_id, g.icon, g.apply_name, g.tips
    FROM scmdata.sys_group_apply g
   ORDER BY g.sort ASC
]';

  nbw.pkg_plat_config.config_pick_lists(p_item_id          => 'g_530_2', --item_id
                                        p_element_id       => 'pick_g_530_2_1', --元素id 代码中维护逻辑关系，数据库不建立外键  
                                        p_element_type     => 'pick', --类型
                                        p_data_source      => 'oracle_scmdata', --数据源
                                        p_seq_no           => 1, --序号
                                        p_pause            => 0, --是否禁用
                                        p_is_hide          => 0, --是否隐藏
                                        p_field_name       => 'apply_name', --关联字段名 
                                        p_caption          => '应用名称', --标题 
                                        p_pick_sql         => v_pick_sql, --选择sql 
                                        p_from_field       => 'apply_name', --来源字段 
                                        p_query_fields     => 'apply_name', --查询字段 
                                        p_other_fields     => 'apply_id', --其它字段 
                                        p_tree_fields      => 'apply_name', --树形字段 
                                        p_level_field      => '', --层级字段 
                                        p_image_names      => '', --图标名称 
                                        p_tree_id          => '', --层级树id 
                                        p_seperator        => '', --多值分隔符 
                                        p_multi_value_flag => 0, --多值标志  0:单值     非0：多值 
                                        p_recursion_flag   => 0, --递归树图标志 0 固定层级树，1 动态层级树 
                                        p_custom_query     => 0, --自定义查询器 查询器自动弹出，0不自动弹出，1自动弹出，默认为0 
                                        p_name_list_sql    => '', --名称列表：支持@selection多值传入方式 
                                        p_port_id          => '', --接口id 
                                        p_port_sql         => '', --接口查询sql 
                                        p_status           => 1);

END;

SELECT ROWID, t.*
  FROM nbw.sys_element t
 WHERE t.element_id = 'pick_g_530_2_1';
SELECT ROWID, t.*
  FROM nbw.sys_pick_list t
 WHERE t.element_id = 'pick_g_530_2_1';
SELECT ROWID, t.*
  FROM nbw.sys_item_element_rela t
 WHERE t.element_id = 'pick_g_530_2_1';

--4.配置check_action
DECLARE
  v_cond_sql CLOB;
BEGIN
  v_cond_sql := 'select 0 flag from dual where 1=1'; --operate
  --v_cond_sql := 'select max(1) flag from dual where 1=1';
  nbw.pkg_plat_config.config_check_action( --配置sys_cond_list
                                          p_cond_id         => 'cond_g_540_1_1', --条件id 
                                          p_cond_sql        => v_cond_sql, --条件sql 
                                          p_cond_type       => 1, --1：跳出“确定”、“取消”按钮窗口，根据按钮选择操作，即提示信息，让用户选择0：跳出“确定”按钮窗口，不执行该操作，即输入无效，按提示报错
                                          p_show_text       => '', --一般是直接些提示和报错的内容。如果要通过sql语句返回报错内容，必须用花括号括起来。
                                          p_data_source     => 'oracle_scmdata', --数据源 
                                          p_cond_field_name => '', --条件控制字段 
                                          p_memo            => '',
                                          --配置sys_cond_rela
                                          p_obj_type => 91, --0:  node_id；11: item list新增；12: item list删除 ；13. item list修改；14: item list 查看；15: item  detail 详情sql；16: item checkvalue (新增，修改)；21: label_list 标签打印；41: hint ；50：key step；51: 快捷方式；55: 盘点按钮；91: action；92: handle；93: 盘点较验；95: associate；97：合同模板 
                                          p_ctl_id   => 'action_g_540_1_1', --控制id 
                                          p_ctl_type => 1, --0:  condition  ；1:  前置  ；2:  后置 ；3:  checkvalue；4: item控制下载数据按纽权限；5:item控制下载模板按纽权限；6:item控制上传数据按纽权限 
                                          p_seq_no   => 1, --序号 
                                          p_pause    => 0, --是否禁用 
                                          p_item_id  => '', --存在项目id时，只对这个项目id启作用 
                                          p_operate  => 1, --是否配置配置sys_cond_operate 1 ：配置，0：不配置
                                          --配置sys_cond_operate --可配可不配
                                          p_caption            => '提示', --标题 
                                          p_content            => '是否前往打印控制新增页面？', --内容，支持sql 
                                          p_to_confirm_item_id => 'g_540_11', --跳转确认页面id 
                                          p_to_cancel_item_id  => ''); --跳转取消页面id 

END;

SELECT ROWID, t.*
  FROM nbw.sys_cond_list t
 WHERE t.cond_id = 'cond_g_540_1_1';

SELECT ROWID, t.*
  FROM nbw.sys_cond_rela t
 WHERE t.cond_id = 'cond_g_540_1_1';

SELECT ROWID, t.*
  FROM nbw.sys_cond_operate t
 WHERE t.cond_id = 'cond_g_540_1_1';

--5.配置filedlist
DECLARE
BEGIN
  nbw.pkg_plat_config.config_field_list(p_field_name     => 'wrap_flag   ', --字段名 
                                        p_caption        => '按钮执行SQL ', --标题 
                                        p_requiered_flag => '0', --1：必须有内容 0：可以没有内容 
                                        p_read_only_flag => '0', --是否只读
                                        p_no_edit        => '0', --是否可编辑
                                        p_no_copy        => '0', --是否可复制
                                        p_no_sort        => '0', --是否排序
                                        p_alignment      => '0', --0：左对齐;；1：右对齐;2：居中; 
                                        p_check_express  => '', --校验表达式 
                                        p_display_format => '', --0.00: 小数点四舍五入保留两位，不够位数0补全.小数点后有几个0，展示就要有几个小数；0.##: 小数点四舍五入保留两位。小数点后有几个井号键，表示保留几位小数；###,###: 数字分结号 
                                        p_data_type      => '', --10:数值；11:货币；12:日期；13:时间；14:百分比；15:分数；16:文本；17:布尔型；18:文本框多行；20:blob类型存储图片；26:签名；27:单图；28:多图片；30:超文本格式文件,字段数据库类型为blob；31:文本格式文件,字段数据库类型为blob；32:超链接地址；33:电话号码；34:邮箱地址；35:checkbox类型,前端展示小箱子(值为0：表示 不打勾;1：打勾状态)；36:富文本直接保存html；40:blob类型附件；43:附件名称，但是文件指向同一张表字段,通过sys_blob_list表关联附件；47:单附件；48:多附件 
                                        p_ime_care       => '0',
                                        p_ime_open       => '0',
                                        p_status         => '1');
END;

SELECT ROWID, t.*
  FROM nbw.sys_field_list t
 WHERE t.field_name LIKE upper('wrap_flag');

SELECT ROWID, t.*
  FROM nbw.sys_field_list t
 WHERE t.caption LIKE '%按钮执行%';

--6.配置Tab页
DECLARE
BEGIN
  nbw.pkg_plat_config.config_tab(p_item_id       => 'a_supp_100',
                                 p_union_item_id => 'a_supp_150',
                                 p_seqno         => 1,
                                 p_pause         => 0);
END;

--7.配置主从表
DECLARE
BEGIN
  nbw.pkg_plat_config.config_sys_item_rela(p_item_id     => 'c_2300_1', --项目id 
                                           p_relate_id   => 'c_2300_11', --关联项目id 
                                           p_relate_type => 'S', --s:关联子表；p:交叉表；c:立方体 
                                           p_seq_no      => '1', --序号 
                                           p_pause       => '0'); --0 启用 1 禁用 
END;

--8.列下钻
INSERT INTO nbw.sys_link_list
  (item_id, field_name, to_item_id, null_item_id, pause)
VALUES
  ('g_540_1', 'CAPTION', 'g_540_11', '', 0);
  
select rowid,t.* from nbw.sys_link_list t ;

--9.定时任务

insert into nbw.xxl_job_info (ID, APP_ID, JOB_GROUP, JOB_CRON, JOB_DESC, ADD_TIME, UPDATE_TIME, AUTHOR, ALARM_EMAIL, EXECUTOR_ROUTE_STRATEGY, EXECUTOR_HANDLER, EXECUTOR_PARAM, EXECUTOR_BLOCK_STRATEGY, EXECUTOR_TIMEOUT, EXECUTOR_FAIL_RETRY_COUNT, GLUE_TYPE, GLUE_SOURCE, GLUE_REMARK, GLUE_UPDATETIME, CHILD_JOBID, TRIGGER_STATUS, TRIGGER_LAST_TIME, TRIGGER_NEXT_TIME)
values (3500, 'scm', 202, '0 0 0 */1 * ?', '自动结束订单', to_date('27-07-2021 21:27:46', 'dd-mm-yyyy hh24:mi:ss'), to_date('27-07-2021 21:27:46', 'dd-mm-yyyy hh24:mi:ss'), '18172543571', null, 'ROUND', 'actionJobHandler', 'action_pro_generater', 'SERIAL_EXECUTION', 0, 0, 'BEAN', null, null, to_date('27-07-2021 21:27:46', 'dd-mm-yyyy hh24:mi:ss'), null, 1, 0, 0);


