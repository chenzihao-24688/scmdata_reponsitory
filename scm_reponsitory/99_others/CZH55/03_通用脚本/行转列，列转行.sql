WITH temp AS
 (SELECT '�Ĵ�ʡ' nation, '�ɶ���' city, '��һ' ranking
    FROM dual
  UNION ALL
  SELECT '�Ĵ�ʡ' nation, '������' city, '�ڶ�' ranking
    FROM dual
  UNION ALL
  SELECT '�Ĵ�ʡ' nation, '������' city, '����' ranking
    FROM dual
  UNION ALL
  SELECT '�Ĵ�ʡ' nation, '�˱���' city, '����' ranking
    FROM dual
  UNION ALL
  SELECT '����ʡ' nation, '�人��' city, '��һ' ranking
    FROM dual
  UNION ALL
  SELECT '����ʡ' nation, '�˲���' city, '�ڶ�' ranking
    FROM dual
  UNION ALL
  SELECT '����ʡ' nation, '������' city, '����' ranking
    FROM dual)

--select * from temp;

--˵����pivot���ۺϺ��� for ���� in�����ͣ��������� in(����) �п���ָ��������in�л�����ָ���Ӳ�ѯ������ select distinct ranking from temp ��xml��ʽ���
--1.��ת�� ѡȥranking�ֶ�Ϊ�У��Գ����������city
/*SELECT *
  FROM (SELECT nation, city, ranking FROM temp)
pivot (MAX(city) FOR ranking IN('��һ' AS ��һ,
                           '�ڶ�' AS �ڶ�,
                           '����' AS ����,
                           '����' AS ����));*/
--1.1 xml��ʽ��ת�����                          
/*SELECT *
  FROM (SELECT nation, city, ranking FROM temp)
pivot xml(MAX(city)
   FOR ranking IN (SELECT DISTINCT ranking FROM temp));*/

--2.ʹ�þۺϺ��������decode ��ת��
--˵����decode���÷���decode(����,ֵ1,����ֵ1,ֵ2,����ֵ2,...ֵn,����ֵn,ȱʡֵ)

SELECT t.nation,
       MAX(decode(t.ranking, '��һ', t.city, '')) AS ��һ,
       MAX(decode(t.ranking, '�ڶ�', t.city, '')) AS �ڶ�,
       MAX(decode(t.ranking, '����', t.city, '')) AS ����,
       MAX(decode(t.ranking, '����', t.city, '')) AS ����
  FROM temp t
 GROUP BY t.nation;

--3.ʹ�þۺϺ��������case..when

WITH temp_score AS
 (SELECT '1' grade_id, '����' course, '98' score
    FROM dual
  UNION ALL
  SELECT '1' grade_id, '��ѧ' course, '88' score
    FROM dual
  UNION ALL
  SELECT '1' grade_id, '����' course, '94' score
    FROM dual
  UNION ALL
  SELECT '2' grade_id, '��ѧ' course, '70' score
    FROM dual
  UNION ALL
  SELECT '2' grade_id, '��ѧ' course, '88' score
    FROM dual
  UNION ALL
  SELECT '2' grade_id, 'Ӣ��' course, '94' score
    FROM dual
  UNION ALL
  SELECT '3' grade_id, '����' course, '80' score
    FROM dual
  UNION ALL
  SELECT '4' grade_id, '��ѧ' course, '66' score
    FROM dual
  UNION ALL
  SELECT '4' grade_id, '��ѧ' course, '99' score
    FROM dual
  UNION ALL
  SELECT '5' grade_id, '����' course, '77' score
    FROM dual
  UNION ALL
  SELECT '6' grade_id, '��ѧ' course, '88' score
    FROM dual
  UNION ALL
  SELECT '7' grade_id, 'Ӣ��' course, '94' score
    FROM dual)
SELECT CASE
         WHEN t.grade_id = '1' THEN
          'һ�꼶'
         WHEN t.grade_id = '2' THEN
          '���꼶'
         WHEN t.grade_id = '3' THEN
          '���꼶'
         WHEN t.grade_id = '4' THEN
          '���꼶'
         WHEN t.grade_id = '5' THEN
          '���꼶'
         WHEN t.grade_id = '6' THEN
          '���꼶'
         WHEN t.grade_id = '7' THEN
          '���꼶'
         ELSE
          NULL
       END grade,
       MAX(CASE
             WHEN t.course = '����' THEN
              t.score
           END) ����,
       MAX(CASE
             WHEN t.course = '��ѧ' THEN
              t.score
           END) ��ѧ,
       MAX(CASE
             WHEN t.course = 'Ӣ��' THEN
              t.score
           END) Ӣ��
  FROM temp_score t
 GROUP BY CASE
            WHEN t.grade_id = '1' THEN
             'һ�꼶'
            WHEN t.grade_id = '2' THEN
             '���꼶'
            WHEN t.grade_id = '3' THEN
             '���꼶'
            WHEN t.grade_id = '4' THEN
             '���꼶'
            WHEN t.grade_id = '5' THEN
             '���꼶'
            WHEN t.grade_id = '6' THEN
             '���꼶'
            WHEN t.grade_id = '7' THEN
             '���꼶'
            ELSE
             NULL
          END;

--2.��ת��
--˵����unpivot���Զ�������/*�е�ֵ*/ for �Զ�������/*����*/ in����������
WITH temp AS
 (SELECT '�Ĵ�ʡ' nation,
         '�ɶ���' ��һ,
         '������' �ڶ�,
         '������' ����,
         '�˱���' ����
    FROM dual
  UNION ALL
  SELECT '����ʡ' nation,
         '�人��' ��һ,
         '�˲���' �ڶ�,
         '������' ����,
         '' ����
    FROM dual)
--SELECT * FROM temp WHERE 1 = 2;

SELECT * FROM temp unpivot(city FOR ranking IN(��һ, �ڶ�, ����������));
