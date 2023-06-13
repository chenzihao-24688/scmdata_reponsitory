--��Ϣ����  0412 15.43



--��������

SELECT '����' || COUNT(*) || '�ҹ�Ӧ��׼��ɹ�,��ǰ��[��Ӧ�̹���]=>[��������Ӧ��]ҳ����д���'
  FROM scmdata.t_supplier_info sp
 WHERE sp.company_id = %default_company_id%
   AND sp.status = 0;

--��Ӧ�̹���  ��������Ӧ��

SELECT company_name_list || '����ҵ��ͨ��׼����ˣ��ȴ���Ӧ�̽�����'
  FROM (SELECT listagg(a.supplier_company_name, ';') within GROUP(ORDER BY 1) company_name_list
          FROM scmdata.t_supplier_info a
         WHERE a.create_date > SYSDATE - 5 / 60 / 24
           AND a.company_id = %default_company_id%
           AND a.status = 0)
 WHERE company_name_list IS NOT NULL;

--�������� ׼�������

SELECT '����' || company_name_list || '����ҵ���鳧���뵥���ڵȴ�׼�������'
  FROM (SELECT listagg(b.company_name, ';') within GROUP(ORDER BY 1) company_name_list
          FROM scmdata.t_factory_ask_oper_log a
         INNER JOIN scmdata.t_factory_ask b
            ON a.factory_ask_id = b.factory_ask_id
         WHERE a.status_af_oper = 'FA12'
           AND a.oper_time > SYSDATE - 5 / 60 / 24
           AND b.company_id = %default_company_id%)
 WHERE company_name_list IS NOT NULL;
 
 SELECT '����' || COUNT(1) || '����׼�������账��,�뼰ʱǰ��[׼������]=>[����������]ҳ����д���лл��'
   FROM scmdata.t_factory_ask fa
  WHERE fa.company_id = %default_company_id%
    AND fa.factrory_ask_flow_status = 'FA12';
 

--�鳧���� ���鳧�鳧��������

SELECT '����' || company_name_list || '����ҵ���鳧���뵥���ڵȴ��ύ�鳧������'
  FROM (SELECT listagg(b.company_name, ';') within GROUP(ORDER BY 1) company_name_list
          FROM scmdata.t_factory_ask_oper_log a
         INNER JOIN scmdata.t_factory_ask b
            ON a.factory_ask_id = b.factory_ask_id
         WHERE a.status_af_oper = 'FA11'
           AND a.oper_time > SYSDATE - 5 / 60 / 24
           AND b.company_id = %default_company_id%)
 WHERE company_name_list IS NOT NULL;
 
 SELECT '����' || COUNT(1) '��[���鳧]�鳧���뵥�账���뼰ʱǰ��[�鳧����]=>[���鳧]ҳ����д���лл��'
   FROM scmdata.t_factory_ask fa
  WHERE fa.company_id = %default_company_id%
    AND fa.factrory_ask_flow_status = 'FA11';
 

--�������� ������ĺ�������
SELECT '����' || company_name_list || '����ҵ�ĺ������뵥���ڵȴ������鳧��'
  FROM (SELECT listagg(a.company_name, ';') within GROUP(ORDER BY 1) company_name_list
          FROM scmdata.t_ask_record a
         WHERE a.ask_date > SYSDATE - 5 / 60 / 24
           AND a.company_id = %default_company_id%
           AND a.coor_ask_flow_status = 'CA01')
 WHERE company_name_list IS NOT NULL;
 
--�������� ������鳧��������
SELECT '����' || company_name_list || '����ҵ���鳧���뵥���ڵȴ������'
  FROM (SELECT listagg(b.company_name, ';') within GROUP(ORDER BY 1) company_name_list
          FROM scmdata.t_factory_ask_oper_log a
         INNER JOIN scmdata.t_factory_ask b
            ON a.factory_ask_id = b.factory_ask_id
         WHERE a.status_af_oper = 'FA02'
           AND a.oper_time > SYSDATE - 5 / 60 / 24
           AND b.company_id = %default_company_id%)
 WHERE company_name_list IS NOT NULL;
 
SELECT '����' || COUNT(1) '���鳧�����账���뼰ʱǰ��[�鳧����]=>[���������]ҳ����д���лл��'
  FROM scmdata.t_factory_ask fa
 WHERE fa.company_id = %default_company_id%
   AND fa.factrory_ask_flow_status = 'FA02';
