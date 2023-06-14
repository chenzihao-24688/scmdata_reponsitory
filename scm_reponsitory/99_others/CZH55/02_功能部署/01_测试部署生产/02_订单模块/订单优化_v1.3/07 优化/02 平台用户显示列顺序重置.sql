DELETE FROM bw3.sys_item_tool_setting t
 WHERE t.item_id IN ('a_product_110',
                     'a_product_150',
                     'a_product_116',
                     'a_product_210',
                     'a_product_217',
                     'a_product_216',
                     'a_product_120_1',
                     'a_product_120_2',
                     'a_product_118')
   AND t.tool_type = 'columnSetting';



