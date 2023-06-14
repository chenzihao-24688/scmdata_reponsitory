CREATE OR REPLACE TRIGGER SCMDATA.trg_u_t_ordered
  AFTER UPDATE OF supplier_code ON t_ordered
  FOR EACH ROW
DECLARE
  po_header_rec scmdata.t_ordered%ROWTYPE;
BEGIN

  po_header_rec.company_id    := :old.company_id;
  po_header_rec.order_code    := :old.order_code;
  po_header_rec.supplier_code := :new.supplier_code;

  scmdata.pkg_production_progress.sync_ordered_update_product(po_header_rec => po_header_rec);

END trg_u_t_ordered;
/

