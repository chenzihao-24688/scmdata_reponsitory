﻿CREATE OR REPLACE FORCE VIEW SCMDATA.AQ$DEMO_QUEUE_TABLE_S AS
SELECT queue_name QUEUE, name NAME , address ADDRESS , protocol PROTOCOL, trans_name TRANSFORMATION, decode(bitand(SUBSCRIBER_TYPE, 512), 512, 'TRUE', 'FALSE') QUEUE_TO_QUEUE  FROM "AQ$_DEMO_QUEUE_TABLE_S" s  WHERE (bitand(s.subscriber_type, 1) = 1)  WITH READ ONLY;

