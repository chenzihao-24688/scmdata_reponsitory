select rowid,t.* from  nbw.sys_label_list  t where t.label_id = 'lb_a_approve_112_1';

select rowid,t.* from  nbw.sys_label_lists  t where t.label_id = 'lb_a_approve_112_1';

select rowid,t.* from  nbw.sys_label_code  t WHERE t.code_id LIKE '%999%';

select rowid,t.* from  nbw.sys_label_data  t WHERE t.data_id LIKE '%999%';

select rowid,t.* from  nbw.sys_label_graph  t;

select rowid,t.* from  nbw.sys_label_shape  t WHERE t.shape_id LIKE '%999%';

SELECT ROWID, t.* FROM nbw.sys_font_list t;

update nbw.sys_label_lists t set t.pause = 1  WHERE t.label_id = 'lb_a_approve_112_1';

update nbw.sys_label_shape t set t.width = t.width / 3.8 , t.height = t.height / 3.8 WHERE t.shape_id LIKE '%999%';  
update nbw.sys_label_lists t set t.left_pos = t.left_pos / 3.8 , t.top_pos = t.top_pos / 3.8 WHERE t.object_id LIKE '%999%';  

update nbw.sys_label_code t set t.width = t.width / 3.8 , t.height = t.height / 3.8 WHERE t.code_id LIKE '%999%';  

--181
SELECT ROWID, t.* FROM sfsys.labellist t WHERE t.labelid = '9999';

SELECT ROWID, t.* FROM sfsys.labellists t WHERE t.labelid = '9999';

SELECT ROWID, t.* FROM sfsys.labelcode t;

SELECT ROWID, t.* FROM sfsys.labeldata t WHERE t.dataid LIKE '%9999%';

SELECT ROWID, t.* FROM sfsys.labelgraph t;

SELECT ROWID, t.* FROM sfsys.labelshape t WHERE t.shapeid LIKE '%9999%';

SELECT ROWID, t.* FROM sfsys.fontlist t;

select rowid,t.* from  nbw.sys_font_list  t;

select rowid,t.* from  nbw.sys_exclude_global  t;



SELECT *
  FROM nbw.sys_label_list t
 INNER JOIN nbw.sys_label_lists a
    ON t.label_id = a.label_id
  LEFT JOIN nbw.sys_label_code b
    ON a.object_id = b.code_id
   AND a.type = 'C'
  LEFT JOIN nbw.sys_label_data c
    ON a.object_id = c.data_id
   AND a.type = 'D'
  LEFT JOIN nbw.sys_font_list e
    ON t.font_id = e.font_id
 WHERE t.caption = '批办卡';


--80环境
SELECT *
  FROM bwpplus.sys_label_list t
 INNER JOIN bwpplus.sys_label_lists a
    ON t.label_id = a.label_id
  LEFT JOIN bwpplus.sys_label_code b
    ON a.object_id = b.code_id
   AND a.type = 'C'
  LEFT JOIN bwpplus.sys_label_data c
    ON a.object_id = c.data_id
   AND a.type = 'D'
  LEFT JOIN bwpplus.sys_font_list e
    ON t.font_id = e.font_id
 WHERE t.caption = '新标签-男女装(4X6.5)';
