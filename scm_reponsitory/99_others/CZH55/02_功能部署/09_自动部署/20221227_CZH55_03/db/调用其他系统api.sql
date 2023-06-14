SELECT ROWID, t.* FROM nbw.sys_method t WHERE t.method_id = 'method_hc_dev';

SELECT ROWID, t.* FROM nbw.sys_port_http t WHERE t.port_name = 'CACHE_DEV';

SELECT ROWID, t.* FROM nbw.sys_port_method t WHERE t.method_id = 'method_hc_dev';


--SELECT ROWID, t.* FROM nbw.sys_port_map t WHERE t.port_name = 'CACHE_DEV';
SELECT ROWID, t.* FROM nbw.sys_element t WHERE t.element_id = 'action_cache_dev';
SELECT ROWID, t.* FROM nbw.sys_action t WHERE t.element_id = 'action_cache_dev';
SELECT ROWID, t.* FROM nbw.sys_item_element_rela t WHERE t.element_id = 'action_cache_dev';
