BEGIN
  UPDATE scmdata.t_plat_log t
     SET t.operater           = 'ADMIN',
         t.operate_company_id = 'b6cc680ad0f599cde0531164a8c0337f'
   WHERE t.operater IS NULL
     AND t.operate_company_id IS NULL;
END;

