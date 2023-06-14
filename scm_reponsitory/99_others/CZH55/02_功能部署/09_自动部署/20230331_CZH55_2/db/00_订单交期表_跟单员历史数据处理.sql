BEGIN
UPDATE scmdata.pt_ordered t
   SET t.flw_order = REPLACE(t.flw_order, ';', ',')
 WHERE instr(t.flw_order, ';') > 0;
END;
/
