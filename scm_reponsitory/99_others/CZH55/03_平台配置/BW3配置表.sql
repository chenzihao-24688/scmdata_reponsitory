SELECT owner, table_name NAME, object_type, stale_stats, last_analyzed
  FROM dba_tab_statistics
 WHERE table_name IN ('SYS_ITEM',
                      'SYS_TREE_LIST',
                      'SYS_ITEM_LIST',
                      'SYS_ELEMENT',
                      'SYS_ACTION',
                      'SYS_ASSOCIATE',
                      'SYS_ITEM_ELEMENT_RELA',
                      'SYS_LOOK_UP',
                      'SYS_PICK_LIST',
                      'SYS_ASSIGN',
                      'SYS_COND_LIST',
                      'SYS_COND_RELA')
   AND owner = 'BW3'
   AND (stale_stats = 'YES' OR last_analyzed IS NULL);


BEGIN
  FOR i IN (SELECT owner,
                   table_name,
                   object_type,
                   stale_stats,
                   last_analyzed
              FROM dba_tab_statistics
             WHERE table_name IN ('SYS_ITEM',
                                  'SYS_TREE_LIST',
                                  'SYS_ITEM_LIST',
                                  'SYS_ELEMENT',
                                  'SYS_ACTION',
                                  'SYS_ASSOCIATE',
                                  'SYS_ITEM_ELEMENT_RELA',
                                  'SYS_LOOK_UP',
                                  'SYS_PICK_LIST',
                                  'SYS_ASSIGN',
                                  'SYS_COND_LIST',
                                  'SYS_COND_RELA')
               AND owner = 'BW3'
               AND (stale_stats = 'YES' OR last_analyzed IS NULL)) LOOP
    dbms_stats.gather_table_stats(ownname          => 'BW3',
                                  tabname          => i.table_name,
                                  estimate_percent => 30,
                                  method_opt       => 'for all columns size skewonly',
                                  no_invalidate    => FALSE,
                                  degree           => 8,
                                  cascade          => TRUE);
  END LOOP;
END;
