--同步生产进度数据
--清空单据
delete from scmdata.t_production_progress;
delete from scmdata.t_production_node;
delete from scmdata.t_abnormal;
delete from  scmdata.t_deduction;

update scmdata.t_ordered po set po.approve_status = null ;

update scmdata.t_production_progress t set t.progress_status = '00';

DECLARE
  po_header_rec scmdata.t_ordered%ROWTYPE;
BEGIN
  FOR i IN (SELECT * FROM scmdata.t_ordered) LOOP
    SELECT *
      INTO po_header_rec
      FROM scmdata.t_ordered t
     WHERE t.company_id = i.company_id
       AND t.order_id = i.order_id;
  
    scmdata.pkg_production_progress.sync_production_progress(po_header_rec => po_header_rec);
  END LOOP;
END;
