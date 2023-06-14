CREATE TABLE SCMDATA.T_COOP_FACTORY_BAK AS SELECT * FROM SCMDATA.T_COOP_FACTORY WHERE 1 = 1;
/
BEGIN
  FOR rec IN (SELECT v.*, sp.supplier_company_name
                FROM (SELECT t.company_id,
                             t.supplier_info_id,
                             t.coop_factory_id,
                             t.factory_code,
                             t.pause,
                             COUNT(t.factory_code) over(PARTITION BY t.factory_code, t.supplier_info_id, t.company_id) rn
                        FROM scmdata.t_coop_factory t
                       ORDER BY t.supplier_info_id ASC) v
               INNER JOIN scmdata.t_supplier_info sp
                  ON sp.supplier_info_id = v.supplier_info_id
                 AND sp.company_id = v.company_id
               WHERE v.rn >= 2
                 AND v.pause = 1
                 AND v.coop_factory_id NOT IN
                     ('da2509cba67c1e88e0531164a8c0d83c',
                      'da64e15f4cbad554e0531164a8c0b2a4')) LOOP
  
    DELETE FROM scmdata.t_coop_factory t
     WHERE t.coop_factory_id = rec.coop_factory_id
       AND t.company_id = rec.company_id;
  END LOOP;

  DELETE FROM scmdata.t_coop_factory t
   WHERE t.coop_factory_id = 'da2509cba67c1e88e0531164a8c0d83c'
     AND t.company_id = 'b6cc680ad0f599cde0531164a8c0337f';

END;
/
