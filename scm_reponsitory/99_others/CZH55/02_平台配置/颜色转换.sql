--��ɫ�Զ�ת��
--ʮ��������ɫ��ת����RGB��ɫֵ=��תBGR��ɫֵ=>תʮ����
DECLARE
  v_rgb VARCHAR2(6):= 'fff799';
  v_r   VARCHAR2(2);
  v_g   VARCHAR2(2);
  v_b   VARCHAR2(2);
  v_bgr NUMBER;
BEGIN
  v_r   := substr(v_rgb, 1, 2);
  v_g   := substr(v_rgb, 3, 2);
  v_b   := substr(v_rgb, 5, 2);
  v_bgr := to_number(v_b || v_g || v_r, 'xxxxxx');
  dbms_output.put_line(v_bgr);
END;
