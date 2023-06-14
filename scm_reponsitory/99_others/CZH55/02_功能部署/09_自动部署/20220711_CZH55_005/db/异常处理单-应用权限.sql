BEGIN
DELETE FROM bw3.sys_cond_rela a WHERE a.cond_id LIKE '%action_a_product_110_3%';
DELETE FROM bw3.sys_cond_list a WHERE a.cond_id LIKE '%action_a_product_110_3%';

DELETE FROM bw3.sys_cond_rela a WHERE a.cond_id LIKE '%node_a_product_118%';
DELETE FROM bw3.sys_cond_list a WHERE a.cond_id LIKE '%node_a_product_118%';

DELETE FROM bw3.sys_cond_rela a WHERE a.cond_id LIKE '%a_product_118%';
DELETE FROM bw3.sys_cond_list a WHERE a.cond_id LIKE '%a_product_118%';

DELETE FROM bw3.sys_cond_rela a WHERE a.cond_id LIKE '%action_a_product_118_2%';
DELETE FROM bw3.sys_cond_list a WHERE a.cond_id LIKE '%action_a_product_118_2%';

DELETE FROM bw3.sys_cond_rela a WHERE a.cond_id LIKE '%action_a_product_118_3%';
DELETE FROM bw3.sys_cond_list a WHERE a.cond_id LIKE '%action_a_product_118_3%';

DELETE FROM bw3.sys_cond_rela a WHERE a.cond_id LIKE '%action_a_product_118_4%';
DELETE FROM bw3.sys_cond_list a WHERE a.cond_id LIKE '%action_a_product_118_4%';

DELETE FROM bw3.sys_cond_rela a WHERE a.cond_id LIKE '%action_a_product_118_5%';
DELETE FROM bw3.sys_cond_list a WHERE a.cond_id LIKE '%action_a_product_118_5%';

DELETE FROM bw3.sys_cond_rela a WHERE a.cond_id LIKE '%action_a_product_118_1%';
DELETE FROM bw3.sys_cond_list a WHERE a.cond_id LIKE '%action_a_product_118_1%';
END;
/
BEGIN
  DELETE FROM bw3.sys_cond_rela t
   WHERE t.cond_id IN
         (SELECT t.cond_id
            FROM scmdata.sys_app_privilege t
           START WITH t.priv_id IN
                      ('P0090705')
          CONNECT BY PRIOR t.priv_id = t.parent_priv_id);

  DELETE FROM bw3.sys_cond_list t
   WHERE t.cond_id IN
         (SELECT t.cond_id
            FROM scmdata.sys_app_privilege t
           START WITH t.priv_id IN
                      ('P0090705')
          CONNECT BY PRIOR t.priv_id = t.parent_priv_id);

  UPDATE scmdata.sys_app_privilege t
     SET t.cond_id = NULL
   WHERE t.cond_id IN
         (SELECT t.cond_id
            FROM scmdata.sys_app_privilege t
           START WITH t.priv_id IN
                      ('P0090705')
          CONNECT BY PRIOR t.priv_id = t.parent_priv_id);
END;
/
BEGIN
UPDATE scmdata.sys_app_privilege a
   SET a.cond_id = NULL
 WHERE a.cond_id IS NOT NULL
   AND a.cond_id LIKE '%cond_9_auto%';

DELETE FROM bw3.sys_cond_rela a WHERE a.cond_id LIKE '%cond_9_auto%';
DELETE FROM bw3.sys_cond_list a WHERE a.cond_id LIKE '%cond_9_auto%';
END;
/
