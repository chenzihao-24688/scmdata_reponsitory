CREATE OR REPLACE TRIGGER SCMDATA.trg_u_t_orders
  AFTER UPDATE OF delivery_date ON t_orders
  FOR EACH ROW
DECLARE
  po_header_rec scmdata.t_ordered%ROWTYPE;
  po_line_rec   scmdata.t_orders%ROWTYPE;
  p_produ_rec   t_production_progress%ROWTYPE;
BEGIN
  SELECT po.*
    INTO po_header_rec
    FROM scmdata.t_ordered po
   WHERE po.company_id = :old.company_id
     AND po.order_code = :old.order_id;

  SELECT pr.*
    INTO p_produ_rec
    FROM scmdata.t_production_progress pr
   WHERE pr.company_id = :old.company_id
     AND pr.order_id = :old.order_id
     AND pr.goo_id = :old.goo_id;
     
  po_line_rec.company_id    := :old.company_id;
  po_line_rec.order_id      := :old.order_id;
  po_line_rec.goo_id        := :old.goo_id;
  po_line_rec.delivery_date := :new.delivery_date;

  scmdata.pkg_production_progress.sync_orders_update_product(po_header_rec => po_header_rec,
                                                             po_line_rec   => po_line_rec,
                                                             p_produ_rec   => p_produ_rec);
END trg_u_t_orders;
/

