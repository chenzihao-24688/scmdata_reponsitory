BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[style_pic,SUPPLIER_CODE_GD,style_name,SUP_NAME_GD,style_number,sup_style_number,goo_id,rela_goo_id,goo_name,category_gd,product_cate_gd,small_category_gd,year,SEASON_GD,inprice,PRICE_GD,color_list_gd,size_list_gd,base_size,base_size_desc,EXECUTIVE_STD,COMPOSNAME_LONG,create_id,create_time,update_id,update_time]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_DETAIL_GROUP WHERE  GROUP_NAME = ''基本信息'' AND ITEM_ID = ''a_good_130''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_DETAIL_GROUP SET (COLUMN_NUMBER,PAUSE,SEQ_NO,CLO_NAMES) = (SELECT 2,0,1,:CV1 FROM DUAL) WHERE  GROUP_NAME = ''基本信息'' AND ITEM_ID = ''a_good_130''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_DETAIL_GROUP (COLUMN_NUMBER,GROUP_NAME,ITEM_ID,PAUSE,SEQ_NO,CLO_NAMES) SELECT 2,''基本信息'',''a_good_130'',0,1,:CV1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     END IF;
  END;
END;
/

