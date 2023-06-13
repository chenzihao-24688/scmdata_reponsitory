--递归查询（树结构）
select prior t.item_id,
       prior t.caption_explain,
       t.item_id,
       t.caption_explain
  from bwptest1.sys_tree_list t
 start with t.item_id = 'flow_menu'
connect by prior t.item_id = t.parent_id;

--1.主键ID,parent_id
--2.prior 的位置
          --connect by prior 主键ID 从上往下
          --connect by prior parent_id 从下往上
          
--从上往下遍历
select prior t.item_id,
       prior t.caption_explain,
       t.item_id,
       t.caption_explain
  from bwptest1.sys_tree_list t
 start with t.item_id = 'flow_menu'
connect by prior t.item_id = t.parent_id;

--从下往上遍历

select prior t.item_id,
       prior t.caption_explain,
       t.item_id,
       t.caption_explain
  from bwptest1.sys_tree_list t
 start with t.item_id = 'flow_process_manage'
connect by prior t.parent_id = t.item_id;

select prior t.item_id,
       prior t.caption_explain,
       t.item_id,
       t.caption_explain
  from bwptest1.sys_tree_list t
 start with t.item_id = 'flow_process_manage'
connect by t.item_id = prior t.parent_id;

--使用level 和 lpad函数，在output中显示树形层次(注意中文字符 lengthb，英文字符 length)
--1.
SELECT t.item_id,
       t.caption_explain,
       level,
       lpad(t.caption_explain,
            lengthb(t.caption_explain) + (level * 2) - 2,
            '_') chart
  FROM bwptest1.sys_tree_list t
 start with t.item_id = 'czh2000'
connect by prior t.item_id = t.parent_id;

--2.
SELECT t.item_id,
       t.caption_explain,
       level,
       lpad(t.caption_explain,
            lengthb(t.caption_explain) + (level * 2) - 2,
            '_') chart
  FROM bwptest1.sys_tree_list t
 where t.caption_explain is not null
 start with t.item_id = 'czh2000'
connect by prior t.item_id = t.parent_id
 order by level;

--3.
SELECT prior t.item_id,
       prior t.caption_explain,
       t.item_id,
       t.caption_explain,
       level,
       lengthb(prior t.caption_explain),
       lengthb(prior t.caption_explain) + (level * 2)-2,
       lpad(t.caption_explain,
            lengthb(t.caption_explain) + (level * 2)-2,
            '_') chart
  FROM bwptest1.sys_tree_list t
 start with t.item_id = 'flow_menu'
connect by prior t.item_id = t.parent_id;

--语法
1 select … from tablename
2 start with 条件1
3 connect by 条件2
4 where 条件3;

     简单说来是将一个树状结构存储在一张表里，比如一个表中存在两个字段:org_id，parent_id，那么通过表示每一条记录的parent是谁，就可以形成一个树状结构，用上述语法的查询可以取得这棵树的所有记录，其中：  
        条件1 是根结点的限定语句，当然可以放宽限定条件，以取得多个根结点，实际就是多棵树。
        条件2 是连接条件，其中用PRIOR表示上一条记录，比如 CONNECT BY PRIOR org_id = parent_id；就是说上一条记录的org_id 是本条记录的parent_id，即本记录的父亲是上一条记录。
         条件3 是过滤条件，用于对返回的所有记录进行过滤。
    简单介绍如下：
        在扫描树结构表时，需要依此访问树结构的每个节点，一个节点只能访问一次，其访问的步骤如下：
        第一步：从根节点开始；
        第二步：访问该节点；
        第三步：判断该节点有无未被访问的子节点，若有，则转向它最左侧的未被访问的子节，并执行第二步，否则执行第四步；
        第四步：若该节点为根节点，则访问完毕，否则执行第五步；
        第五步：返回到该节点的父节点，并执行第三步骤。
        总之：扫描整个树结构的过程也即是中序遍历树的过程。
--例子 有向图
select t.*,
       level,
       lpad(t.rela_apply_id,
            lengthb(t.rela_apply_id) + (level * 2) - 2,
            '_') chart
  from scmdata.sys_group_apply_rela t
 --where apply_id = 'apply_2'
 start with t.apply_id = 'apply_1'
        and t.force_bind = 1
connect by t.apply_id = prior t.rela_apply_id
       and t.force_bind = 1;
       
       
--绑定应用，强绑定，弱绑定关系
with a as
 (select distinct t.rela_apply_id
    from scmdata.sys_group_apply_rela t
   start with t.apply_id = 'apply_1'
          and t.force_bind = 1
  connect by t.apply_id = prior t.rela_apply_id
         and t.force_bind = 1)
select g.apply_id,
       g.pause,
       g.apply_status,
       g.icon,
       g.apply_name,
       g.tips,
       g.apply_type,
       g.create_time
  from scmdata.sys_group_apply g, a
 where g.apply_id = a.rela_apply_id
