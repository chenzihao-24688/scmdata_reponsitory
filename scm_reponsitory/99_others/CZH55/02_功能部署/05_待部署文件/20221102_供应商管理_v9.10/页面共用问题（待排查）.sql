SELECT rowid,t.* from bw3.sys_item_list t WHERE t.item_id  IN ('a_coop_150_3');--update sql

SELECT rowid,t.* from bw3.sys_element t WHERE t.element_id IN ('action_a_coop_220_21','action_a_coop_220_22');
SELECT rowid,t.*  from bw3.sys_action t WHERE t.element_id IN ('action_a_coop_220_21','action_a_coop_220_22');
SELECT rowid,t.* from bw3.sys_item_element_rela t WHERE t.element_id IN ('action_a_coop_220_21','action_a_coop_220_22');

SELECT rowid,t.* from bw3.sys_cond_list t WHERE t.cond_id IN ('cond_a_coop_220');
SELECT rowid,t.* from bw3.sys_cond_rela t WHERE t.cond_id IN ('cond_a_coop_220'); 


SELECT rowid,t.* from bw3.sys_element t WHERE t.element_id IN ('associate_a_coop_221','associate_a_coop_201','asso_a_coop_150_3'); 
SELECT rowid,t.* from bw3.sys_associate t WHERE t.element_id IN ('associate_a_coop_221','associate_a_coop_201','asso_a_coop_150_3'); 
SELECT rowid,t.* from bw3.sys_item_element_rela t WHERE t.element_id IN ('associate_a_coop_221','associate_a_coop_201','asso_a_coop_150_3'); 

SELECT rowid,t.* from bw3.sys_element t WHERE t.element_id IN ('action_a_coop_311','action_a_coop_312','action_a_coop_313');
SELECT rowid,t.*  from bw3.sys_action t WHERE t.element_id IN ('action_a_coop_311','action_a_coop_312','action_a_coop_313');
SELECT rowid,t.* from bw3.sys_item_element_rela t WHERE t.element_id IN ('action_a_coop_311','action_a_coop_312','action_a_coop_313');


SELECT rowid,t.* from bw3.sys_element t WHERE t.element_id IN ('action_a_coop_220_1','action_a_coop_220_2');
SELECT rowid,t.*  from bw3.sys_action t WHERE t.element_id IN ('action_a_coop_220_1','action_a_coop_220_2');
SELECT rowid,t.* from bw3.sys_item_element_rela t WHERE t.element_id IN ('action_a_coop_220_1','action_a_coop_220_2');


SELECT rowid,t.* from bw3.sys_item_list t WHERE t.item_id IN ('a_coop_151_2','a_supp_151_10'); 


SELECT rowid,t.* from bw3.sys_item_list t WHERE t.item_id = 'a_supp_151';
SELECT rowid,t.*  from bw3.sys_action t WHERE t.element_id = 'action_a_supp_151_1';

SELECT rowid,t.*  from bw3.sys_action t WHERE t.element_id IN ('action_a_supp_161_1_1','action_a_supp_161_1_2'); 

SELECT rowid,t.*  from bw3.sys_item_element_rela t WHERE t.item_id = 'a_supp_161_1';

--ÐÞ¸Ä
SELECT rowid,t.* from bw3.sys_item t WHERE t.item_id = 'a_supp_151_7'; 
SELECT rowid,t.*  from bw3.sys_action t WHERE t.element_id IN ('action_a_supp_151_7_1','action_a_supp_151_7_2'); 
SELECT rowid,t.*  from bw3.sys_action t WHERE t.element_id IN ('action_a_supp_151_7_1','action_a_supp_151_7_2'); 


--´ýÅÅ²é
SELECT rowid,t.* from bw3.sys_associate t WHERE t.element_id = 'associate_a_supp_160_1'; 
