--20230220 ÐÞ¸Ä
SELECT ROWID, t.*
  FROM bw3.sys_look_up t
 WHERE t.element_id = 'look_a_supp_160_1';

SELECT ROWID, t.*
  FROM bw3.sys_item_element_rela t
 WHERE t.element_id = 'look_a_supp_160_1';
UPDATE bw3.sys_item_element_rela t SET t.pause = 1 WHERE t.element_id = 'look_a_supp_160_1';

SELECT rowid,t.* from bw3.sys_cond_operate t WHERE t.cond_id = 'cond_a_coop_150'; 
SELECT rowid,t.* from bw3.sys_element t WHERE t.element_id = 'pick_a_supp_160_1';

SELECT ROWID, t.*
  FROM bw3.sys_pick_list t
 WHERE t.element_id IN ('pick_a_coop_151_4');
 
SELECT ROWID, t.*
  FROM bw3.sys_item_element_rela t
 WHERE t.element_id = 'pick_a_supp_160_1';

SELECT ROWID, t.*
  FROM bw3.sys_pick_list t
 WHERE t.element_id = 'picklist_address';
 
 
SELECT rowid,t.* from bw3.sys_element t WHERE t.element_id IN ('pick_a_coop_151_10','pick_a_coop_151_11');

SELECT ROWID, t.*
  FROM bw3.sys_pick_list t
 WHERE t.element_id IN ('pick_a_coop_151_3','pick_a_coop_151_4','pick_a_coop_151_10','pick_a_coop_151_11');

SELECT ROWID, t.*
  FROM bw3.sys_item_element_rela t
 WHERE t.element_id IN ('pick_a_coop_151_10','pick_a_coop_151_11');

SELECT rowid,t.* from bw3.sys_look_up t WHERE t.element_id IN ('look_a_coop_151_2','look_a_coop_151_3'); 


UPDATE bw3.sys_item_element_rela t SET t.pause = 0
 WHERE t.element_id IN ('look_a_coop_151_2');


