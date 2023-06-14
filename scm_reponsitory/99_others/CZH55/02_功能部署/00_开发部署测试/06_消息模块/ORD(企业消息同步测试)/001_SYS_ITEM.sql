﻿BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM WHERE ITEM_ID = ''c_2300''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM SET (BADGE_FLAG,BASE_TABLE,CAPTION_SQL,CONFIG_PARAMS,DATA_SOURCE,HELP_ID,INIT_SHOW,ITEM_TYPE,KEY_FIELD,LINK_FIELD,MEMO,NAME_FIELD,OFFLINE_FLAG,PANEL_ID,PAUSE,REPORT_TITLE,SETTING_ID,SHOW_ROWID,SUB_SCRIPTS,TAG_ID,TIME_OUT,BADGE_SQL) = (SELECT ,q''[]'',q''[消息管理]'',q''[]'',q''[oracle_scmdata]'',q''[]'',,q''[menu]'',q''[]'',q''[]'',q''[]'',q''[]'',,q''[]'',0,q''[]'',q''[]'',,q''[]'',q''[]'',,:CV1 FROM DUAL) WHERE ITEM_ID = ''c_2300''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM (BADGE_FLAG,BASE_TABLE,CAPTION_SQL,CONFIG_PARAMS,DATA_SOURCE,HELP_ID,INIT_SHOW,ITEM_ID,ITEM_TYPE,KEY_FIELD,LINK_FIELD,MEMO,NAME_FIELD,OFFLINE_FLAG,PANEL_ID,PAUSE,REPORT_TITLE,SETTING_ID,SHOW_ROWID,SUB_SCRIPTS,TAG_ID,TIME_OUT,BADGE_SQL) SELECT ,q''[]'',q''[消息管理]'',q''[]'',q''[oracle_scmdata]'',q''[]'',,''c_2300'',q''[menu]'',q''[]'',q''[]'',q''[]'',q''[]'',,q''[]'',0,q''[]'',q''[]'',,q''[]'',q''[]'',,:CV1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM WHERE ITEM_ID = ''c_2300_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM SET (BADGE_FLAG,BASE_TABLE,CAPTION_SQL,CONFIG_PARAMS,DATA_SOURCE,HELP_ID,INIT_SHOW,ITEM_TYPE,KEY_FIELD,LINK_FIELD,MEMO,NAME_FIELD,OFFLINE_FLAG,PANEL_ID,PAUSE,REPORT_TITLE,SETTING_ID,SHOW_ROWID,SUB_SCRIPTS,TAG_ID,TIME_OUT,BADGE_SQL) = (SELECT ,q''[SYS_GROUP_MSG_CONFIG]'',q''[应用消息配置]'',q''[]'',q''[oracle_scmdata]'',q''[]'',,q''[list]'',q''[GROUP_MSG_ID]'',q''[]'',q''[]'',q''[]'',,q''[]'',0,q''[]'',q''[]'',,q''[]'',q''[]'',,:CV1 FROM DUAL) WHERE ITEM_ID = ''c_2300_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM (BADGE_FLAG,BASE_TABLE,CAPTION_SQL,CONFIG_PARAMS,DATA_SOURCE,HELP_ID,INIT_SHOW,ITEM_ID,ITEM_TYPE,KEY_FIELD,LINK_FIELD,MEMO,NAME_FIELD,OFFLINE_FLAG,PANEL_ID,PAUSE,REPORT_TITLE,SETTING_ID,SHOW_ROWID,SUB_SCRIPTS,TAG_ID,TIME_OUT,BADGE_SQL) SELECT ,q''[SYS_GROUP_MSG_CONFIG]'',q''[应用消息配置]'',q''[]'',q''[oracle_scmdata]'',q''[]'',,''c_2300_1'',q''[list]'',q''[GROUP_MSG_ID]'',q''[]'',q''[]'',q''[]'',,q''[]'',0,q''[]'',q''[]'',,q''[]'',q''[]'',,:CV1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM WHERE ITEM_ID = ''c_2300_11''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM SET (BADGE_FLAG,BASE_TABLE,CAPTION_SQL,CONFIG_PARAMS,DATA_SOURCE,HELP_ID,INIT_SHOW,ITEM_TYPE,KEY_FIELD,LINK_FIELD,MEMO,NAME_FIELD,OFFLINE_FLAG,PANEL_ID,PAUSE,REPORT_TITLE,SETTING_ID,SHOW_ROWID,SUB_SCRIPTS,TAG_ID,TIME_OUT,BADGE_SQL) = (SELECT ,q''[SYS_COMPANY_MSG_CONFIG]'',q''[接收人配置]'',q''[]'',q''[oracle_scmdata]'',q''[]'',,q''[list]'',q''[COMPANY_MSG_ID]'',q''[]'',q''[]'',q''[]'',,q''[]'',0,q''[]'',q''[]'',,q''[]'',q''[]'',,:CV1 FROM DUAL) WHERE ITEM_ID = ''c_2300_11''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM (BADGE_FLAG,BASE_TABLE,CAPTION_SQL,CONFIG_PARAMS,DATA_SOURCE,HELP_ID,INIT_SHOW,ITEM_ID,ITEM_TYPE,KEY_FIELD,LINK_FIELD,MEMO,NAME_FIELD,OFFLINE_FLAG,PANEL_ID,PAUSE,REPORT_TITLE,SETTING_ID,SHOW_ROWID,SUB_SCRIPTS,TAG_ID,TIME_OUT,BADGE_SQL) SELECT ,q''[SYS_COMPANY_MSG_CONFIG]'',q''[接收人配置]'',q''[]'',q''[oracle_scmdata]'',q''[]'',,''c_2300_11'',q''[list]'',q''[COMPANY_MSG_ID]'',q''[]'',q''[]'',q''[]'',,q''[]'',0,q''[]'',q''[]'',,q''[]'',q''[]'',,:CV1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     END IF;
  END;
END;
/

