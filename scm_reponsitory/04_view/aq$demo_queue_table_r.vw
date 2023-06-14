﻿CREATE OR REPLACE FORCE VIEW SCMDATA.AQ$DEMO_QUEUE_TABLE_R AS
SELECT queue_name QUEUE, s.name NAME , address ADDRESS , protocol PROTOCOL, rule_condition RULE, ruleset_name RULE_SET, trans_name TRANSFORMATION  FROM "AQ$_DEMO_QUEUE_TABLE_S" s , sys.all_rules r WHERE (bitand(s.subscriber_type, 1) = 1) AND s.rule_name = r.rule_name and r.rule_owner = 'SCMDATA'  WITH READ ONLY;

