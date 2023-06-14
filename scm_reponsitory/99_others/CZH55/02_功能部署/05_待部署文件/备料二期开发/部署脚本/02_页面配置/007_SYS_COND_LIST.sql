begin
insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_action_a_prematerial_211_1_1', 'select max(1) from dual', 1, '{
DECLARE
  V_STR CLOB;
BEGIN
  FOR CPO_REC IN (SELECT PO.MATERIAL_NAME, SUM(PO.ORDER_NUM) ORDER_NUM
                    FROM MRP.GREY_PREPARE_ORDER PO
                   WHERE PO.PREPARE_ORDER_ID IN (%SELECTION%)
                     AND PO.PREPARE_STATUS = 1
                   GROUP BY PO.GROUP_KEY, PO.MATERIAL_NAME) LOOP
    V_STR := V_STR || ''�������ơ�'' || CPO_REC.MATERIAL_NAME || ''�������νӵ���������'' ||
             CPO_REC.ORDER_NUM || ''����'' || CHR(10);
  END LOOP;
  IF V_STR IS NULL THEN
    RAISE_APPLICATION_ERROR(-20002,
                            ''ֻ�ɶԡ����ӵ���״̬�ı��ϵ����в�������ˢ��ҳ�����ԣ�'');
  ELSE
    V_STR := ''��ȷ�ϣ�'' || V_STR;
  END IF;
  @STRRESULT := V_STR;
END;
}', 'oracle_plm', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_action_a_prematerial_241_1', 'select max(1) from dual', 1, '{
DECLARE
  v_str CLOB;
BEGIN
  FOR cpo_rec IN (SELECT po.material_name, SUM(po.order_num) order_num
                    FROM mrp.color_prepare_order po
                   WHERE po.group_key IN (%selection%)
                   AND po.prepare_status = 1
                   GROUP BY po.group_key, po.material_name) LOOP
    v_str := v_str || ''�������ơ�'' || cpo_rec.material_name || ''�������νӵ���������'' || cpo_rec.order_num || ''����'' || chr(10);
  END LOOP;
  IF v_str IS NULL THEN
    raise_application_error(-20002,''ֻ�ɶԡ����ӵ���״̬�ı��ϵ����в�������ˢ��ҳ�����ԣ�'');
  ELSE
    v_str := ''��ȷ�ϣ�'' || v_str;
  END IF;
  @strresult := v_str;
END;
}', 'oracle_plm', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_action_a_prematerial_211_1', 'select max(1) from dual', 1, '{
DECLARE
  V_STR CLOB;
BEGIN
  FOR CPO_REC IN (SELECT PO.MATERIAL_NAME, SUM(PO.ORDER_NUM) ORDER_NUM
                    FROM MRP.GREY_PREPARE_ORDER PO
                   WHERE PO.GROUP_KEY IN (%SELECTION%)
                     AND PO.PREPARE_STATUS = 1
                   GROUP BY PO.GROUP_KEY, PO.MATERIAL_NAME) LOOP
    V_STR := V_STR || ''�������ơ�'' || CPO_REC.MATERIAL_NAME || ''�������νӵ���������'' ||
             CPO_REC.ORDER_NUM || ''����'' || CHR(10);
  END LOOP;
  IF V_STR IS NULL THEN
    RAISE_APPLICATION_ERROR(-20002,
                            ''ֻ�ɶԡ����ӵ���״̬�ı��ϵ����в�������ˢ��ҳ�����ԣ�'');
  ELSE
    V_STR := ''��ȷ�ϣ�'' || V_STR;
  END IF;
  @STRRESULT := V_STR;
END;
}', 'oracle_plm', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_action_a_prematerial_221_1', 'select max(1) from dual', 1, '{
DECLARE
  v_str CLOB;
BEGIN
  FOR cpo_rec IN (SELECT po.material_name, SUM(po.order_num) order_num
                    FROM mrp.color_prepare_order po
                   WHERE po.group_key IN (%selection%)
                   AND po.prepare_status = 1
                   GROUP BY po.group_key, po.material_name) LOOP
    v_str := v_str || ''�������ơ�'' || cpo_rec.material_name || ''�������νӵ���������'' || cpo_rec.order_num || ''����'' || chr(10);
  END LOOP;
  IF v_str IS NULL THEN
    raise_application_error(-20002,''ֻ�ɶԡ����ӵ���״̬�ı��ϵ����в�������ˢ��ҳ�����ԣ�'');
  ELSE
    v_str := ''��ȷ�ϣ�'' || v_str;
  END IF;
  @strresult := v_str;
END;
}', 'oracle_plm', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_action_a_prematerial_221_1_1', 'select max(1) from dual', 1, '{
DECLARE
  v_str CLOB;
BEGIN
  FOR cpo_rec IN (SELECT po.material_name, SUM(po.order_num) order_num
                    FROM mrp.color_prepare_order po
                   WHERE po.prepare_order_id IN (%selection%)
                     AND po.prepare_status = 1
                   GROUP BY po.group_key, po.material_name) LOOP
    v_str := v_str || ''�������ơ�'' || cpo_rec.material_name || ''�������νӵ���������'' ||
             cpo_rec.order_num || ''����'' || chr(10);
  END LOOP;
  IF v_str IS NULL THEN
    raise_application_error(-20002,
                            ''ֻ�ɶԡ����ӵ���״̬�ı��ϵ����в�������ˢ��ҳ�����ԣ�'');
  ELSE
    v_str := ''��ȷ�ϣ�'' || v_str;
  END IF;
  @strresult := v_str;
END;
}', 'oracle_plm', null, null);
end;
/
