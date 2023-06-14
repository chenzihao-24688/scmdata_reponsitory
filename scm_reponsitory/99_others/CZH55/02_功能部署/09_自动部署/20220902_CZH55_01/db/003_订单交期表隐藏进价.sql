BEGIN
UPDATE bw3.sys_item_list t
   SET t.noshow_fields = 'goo_id_pr,company_id,pt_ordered_id,company_id,order_id,first_dept_id,responsible_dept_sec,deal_follower,qc_id,GROUP_NAME,purchase_price'
 WHERE t.item_id = 'a_report_120';
END;
/
