SELECT ROWID, t.* FROM nbw.sys_method t WHERE t.method_id IN ('method_hc_dev','method_hc_test','method_hc_pro','method_hc_pro_v1','method_hc_pro_v2'); --method_hc_dev

SELECT ROWID, t.* FROM nbw.sys_port_http t WHERE t.port_name IN ('CACHE_DEV','CACHE_TEST','CACHE_PRO','CACHE_PRO_V1','CACHE_PRO_V2');

SELECT ROWID, t.* FROM nbw.sys_port_method t WHERE t.port_name IN ('CACHE_DEV','CACHE_TEST','CACHE_PRO','CACHE_PRO_V1','CACHE_PRO_V2');

SELECT rowid,t.* from nbw.sys_element t WHERE t.element_id IN ('action_cache_dev','action_cache_test','action_cache_pro_v1','action_cache_pro_v2'); 
SELECT ROWID, t.* FROM nbw.sys_action t WHERE t.element_id IN ('action_cache_dev','action_cache_test','action_cache_pro_v1','action_cache_pro_v2'); 
--https://tscm.sanfu.com/st/scm/api/v1/caffeine/cache/clear
SELECT ROWID, t.*
  FROM nbw.sys_item_element_rela t
 WHERE t.element_id IN ('action_cache_dev','action_cache_test','action_cache_pro_v1','action_cache_pro_v2'); 
 

SELECT rowid,t.* from nbw.sys_item t WHERE t.item_id = 'test_detail'; --http://172.28.40.61:9090/lion/scm  

--https://tscm.sanfu.com/st/scm/api/v1/item/g_520/action/action_cache_pro_v2/call?node_id=node_g_520

--https://scm.sanfu.com/lion/scm/api/v1/caffeine/cache/clear

SELECT rowid,t.* from nbw.sys_cond_list t WHERE t.cond_id = 'cond_action_cache_dev';
SELECT rowid,t.* from nbw.sys_cond_rela t WHERE t.cond_id = 'cond_action_cache_dev';  
