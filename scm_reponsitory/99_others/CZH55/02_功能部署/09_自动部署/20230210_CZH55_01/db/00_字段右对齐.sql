BEGIN
UPDATE bw3.sys_field_list t
   SET t.alignment = 2
 WHERE t.field_name IN ('PROCESSING_PROFIT',
                        'MANAGEMENT_EXPENSE',
                        'DEVELOPMENT_FEE',
                        'EUIPMENT_DEPRECIATION',
                        'RENT_AND_UTILITIES','FREIGHT_OT','DESIGN_FEE');
END;
/
