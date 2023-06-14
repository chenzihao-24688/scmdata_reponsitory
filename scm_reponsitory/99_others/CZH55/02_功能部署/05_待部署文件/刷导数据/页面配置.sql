--包
--scmdata.pkg_ask_record_mange
--页面配置
--item 主表
SELECT rowid,t.* from nbw.sys_item t WHERE t.item_id = 'a_coop_200';

SELECT PRIOR b.item_id pr_item_id, b.item_id, a.caption_sql
  FROM nbw.sys_tree_list b
  LEFT JOIN nbw.sys_item a
    ON a.item_id = b.item_id
 START WITH b.item_id = 'a_coop_200'
CONNECT BY PRIOR b.item_id = b.parent_id;

--从表
SELECT c.item_id, c.relate_id, d.caption_sql
  FROM nbw.sys_item_rela c
 INNER JOIN nbw.sys_item d
    ON d.item_id = c.relate_id
 WHERE c.item_id IN (SELECT b.item_id
                       FROM nbw.sys_tree_list b
                       LEFT JOIN nbw.sys_item a
                         ON a.item_id = b.item_id
                      START WITH b.item_id = 'a_coop_200'
                     CONNECT BY PRIOR b.item_id = b.parent_id);

--按钮
SELECT bt.*,c.*
  FROM nbw.sys_item_element_rela bt
  inner JOIN nbw.sys_element c ON c.element_id = bt.element_id
 WHERE bt.item_id IN
       (SELECT b.item_id
          FROM nbw.sys_tree_list b
          LEFT JOIN nbw.sys_item a
            ON a.item_id = b.item_id
         START WITH b.item_id = 'a_coop_200'
        CONNECT BY PRIOR b.item_id = b.parent_id);
        
--按钮跳转页
SELECT f.*
  FROM nbw.sys_item_element_rela bt
  inner JOIN nbw.sys_element c ON c.element_id = bt.element_id
  AND c.element_type = 'associate'
  INNER JOIN nbw.sys_associate d ON d.element_id = c.element_id
  INNER JOIN nbw.sys_tree_list e ON e.node_id = d.node_id
  INNER JOIN nbw.sys_item f ON f.item_id = e.item_id
 WHERE bt.item_id IN
       (SELECT b.item_id
          FROM nbw.sys_tree_list b
          LEFT JOIN nbw.sys_item a
            ON a.item_id = b.item_id
         START WITH b.item_id = 'a_coop_200'
        CONNECT BY PRIOR b.item_id = b.parent_id);
