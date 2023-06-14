select rowid, t.*
  from nbw.sys_item t
 where t.item_id in
       ('data-20207137', 'data-20207138', 'data-20207139', 'data-202071411');

select rowid, t.*
  from nbw.sys_tree_list t
 where t.node_id in ('node-data-2020713',
                     'node-data-20207137',
                     'node-data-20207138',
                     'node-data-20207139');
--µ¼º½À¸                    
select rowid, t.*
  from nbw.sys_item_list t
 where t.item_id in ('data-2020713', 'data-20207137');

select rowid, t.*
  from nbw.sys_layout t
 where t.item_id = 'data-20207137';

select rowid, t.*
  from nbw.sys_item_element_rela t
 where t.item_id = 'data-20207137';

select rowid, t.*
  from nbw.sys_item_rela t
 where t.item_id = 'data-20207137';

select rowid, t.*
  from nbw.sys_item t
 where t.item_id in ('data-20207142', 'data-202071421');

select rowid, t.*
  from nbw.sys_item_list t
 where t.item_id in ('data-20207142', 'data-202071421');

select rowid, t.*
  from nbw.sys_item_rela t
 where t.item_id = 'data-20207142';
