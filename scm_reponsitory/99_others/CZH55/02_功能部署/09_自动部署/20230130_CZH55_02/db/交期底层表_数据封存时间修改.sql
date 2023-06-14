BEGIN
UPDATE scmdata.t_order_seal_time t SET t.seal_days = 5 WHERE t.id IN (1,5);
UPDATE scmdata.t_order_seal_time t SET t.seal_days = 8 WHERE t.id = 10;
END;
/
