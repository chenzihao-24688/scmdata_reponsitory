BEGIN
UPDATE scmdata.t_production_progress t
   SET t.progress_status = '01'
 WHERE t.product_gress_code = 'GZZXS2302150031'
   AND t.company_id = 'b6cc680ad0f599cde0531164a8c0337f';
END;
/
