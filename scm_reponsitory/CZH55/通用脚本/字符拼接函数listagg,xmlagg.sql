
--1.wm_concat �������� string
-- �˺������ã���Oracle12G�в�֧�ִ˺��������������Ŀ�����ݿ�汾�������ᱨ����ʶ����Ч�Ĵ�
/*  SELECT wm_concat(t.name)
  INTO v_wm_concat_str
  FROM nbw.czh_test t
 GROUP BY t.id1
HAVING t.id1 < 3;
dbms_output.put_line(v_wm_concat_str);*/

--2.listagg �������� string
--�г������ƣ�ƴ�ӵ��ַ�������4000ʱ�ᱨ��
SELECT listagg(t.name, ',') within GROUP(ORDER BY 1)
  FROM nbw.czh_test t
 WHERE t.id1 < 3
--GROUP BY t.id1; ����ƴ��

--3.xmlagg  ��������clob
--3.1 �������� ��β��������
  SELECT xmlagg(xmlparse(content t.name || ',' wellformed) ORDER BY 1).getclobval() t_name
          FROM nbw.czh_test t
         WHERE t.id1 < 3
        --group by t.id1;--����ƴ��
        
--3.2 ���rtrim����һ��ʹ�ã�ȥ��ĩβ����ġ�����

  SELECT rtrim(xmlagg(xmlparse(content t.name || ',' wellformed) ORDER BY 1).getclobval(),',') t_name
          FROM nbw.czh_test t
         WHERE t.id1 < 3
        --group by t.id1;--����ƴ��
