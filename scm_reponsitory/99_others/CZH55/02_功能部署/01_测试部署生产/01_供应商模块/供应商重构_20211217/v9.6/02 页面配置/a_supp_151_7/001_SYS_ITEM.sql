﻿BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM WHERE ITEM_ID = ''a_supp_151_7''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM SET (BADGE_FLAG,BASE_TABLE,CAPTION_SQL,CONFIG_PARAMS,DATA_SOURCE,ENABLE_STAND_PERMISSION,FIX_CAPTION,HELP_ID,INIT_SHOW,ITEM_TYPE,KEY_FIELD,LINK_FIELD,MEMO,NAME_FIELD,OFFLINE_FLAG,PANEL_ID,PAUSE,REPORT_TITLE,SETTING_ID,SHOW_ROWID,SUB_SCRIPTS,TAG_ID,TIME_OUT,BADGE_SQL) = (SELECT ,q''[T_COOP_FACTORY]'',q''[合作工厂]'',q''[]'',q''[oracle_scmdata]'',1,q''[]'',q''[]'',,q''[list]'',q''[COOP_FACTORY_ID]'',q''[]'',q''[]'',q''[]'',,q''[]'',0,q''[]'',q''[a_supp_151_7]'',,q''[]'',q''[]'',,:CV1 FROM DUAL) WHERE ITEM_ID = ''a_supp_151_7''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM (BADGE_FLAG,BASE_TABLE,CAPTION_SQL,CONFIG_PARAMS,DATA_SOURCE,ENABLE_STAND_PERMISSION,FIX_CAPTION,HELP_ID,INIT_SHOW,ITEM_ID,ITEM_TYPE,KEY_FIELD,LINK_FIELD,MEMO,NAME_FIELD,OFFLINE_FLAG,PANEL_ID,PAUSE,REPORT_TITLE,SETTING_ID,SHOW_ROWID,SUB_SCRIPTS,TAG_ID,TIME_OUT,BADGE_SQL) SELECT ,q''[T_COOP_FACTORY]'',q''[合作工厂]'',q''[]'',q''[oracle_scmdata]'',1,q''[]'',q''[]'',,''a_supp_151_7'',q''[list]'',q''[COOP_FACTORY_ID]'',q''[]'',q''[]'',q''[]'',,q''[]'',0,q''[]'',q''[a_supp_151_7]'',,q''[]'',q''[]'',,:CV1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     END IF;
  END;
END;
/

