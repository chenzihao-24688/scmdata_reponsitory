--��ѯ�༶
SELECT * FROM t_class;
--1.�����༶
DECLARE
  p_cla_info t_class%ROWTYPE;
BEGIN
  --��������
  FOR i IN 1 .. 10 LOOP
    p_cla_info.clno   := seq_t_class.nextval;
    p_cla_info.dept   := i || 'dept';
    p_cla_info.grade  := i || 'grade';
    p_cla_info.branch := i || 'branch';
    --�����������洢���̣�
    pkg_person_info_sys.insert_t_class(p_cla_info => p_cla_info);
  END LOOP;

END;

--�޸�
DECLARE
  p_cla_info t_class%ROWTYPE;
BEGIN
  --��������
  FOR i IN 1 .. 10 LOOP
    p_cla_info.clno   := i; --�༶���
    p_cla_info.dept   := i * 2 || 'dept';
    p_cla_info.grade  := i * 2 || 'grade';
    p_cla_info.branch := i * 2 || 'branch';
    --�����޸ģ��洢���̣�
    pkg_person_info_sys.update_t_class(p_cla_info => p_cla_info);
  END LOOP;

END;

--ɾ��
DECLARE
  p_cla_info t_class%ROWTYPE;
  --�α�
  CURSOR cla_cur IS
    SELECT t.clno FROM t_class t;
BEGIN
  --ɾ����������
  FOR cla_rec IN cla_cur LOOP
    --����ɾ�����洢���̣�
    pkg_person_info_sys.delete_t_class(p_cla_no => cla_rec.clno);
  END LOOP;
END;

--��ѯѧ��
SELECT * FROM t_student;

--2.����ѧ��

DECLARE
  p_stu_info t_student%ROWTYPE;
BEGIN
  --��������
  FOR i IN 1 .. 10 LOOP
    p_stu_info.sno  := seq_t_class.nextval;
    p_stu_info.name := i || 'dept';
    p_stu_info.age  := i;
    p_stu_info.sex  := '0';
    --�����������洢���̣�
    pkg_person_info_sys.insert_t_student(p_stu_info => p_stu_info);
  END LOOP;

END;

--�޸�
DECLARE
  p_stu_info t_student%ROWTYPE;
BEGIN
  --��������
  FOR i IN 1 .. 10 LOOP
    p_stu_info.sno  := i;
    p_stu_info.name := i * 2 || 'dept';
    p_stu_info.age  := i * 2;
    p_stu_info.sex  := '1';
    --�����޸ģ��洢���̣�
    pkg_person_info_sys.update_t_student(p_stu_info => p_stu_info);
  END LOOP;

END;

--ɾ��
DECLARE
  p_stu_info t_student%ROWTYPE;
  --�α�
  CURSOR stu_cur IS
    SELECT * FROM t_student t;
BEGIN
  --ɾ����������
  FOR stu_rec IN stu_cur LOOP
    --����ɾ�����洢���̣�
    pkg_person_info_sys.delete_t_student(p_stu_info => stu_rec);
  END LOOP;
END;

--��ѯ�γ�
SELECT * FROM t_course;

--3.�����γ�

DECLARE
  p_cou_info t_course%ROWTYPE;
BEGIN
  --��������
  FOR i IN 1 .. 5 LOOP
    p_cou_info.cno   := seq_t_class.nextval;
    p_cou_info.name  := i || 'dept';
    p_cou_info.score := i;
    --�����������洢���̣�
    pkg_person_info_sys.insert_t_course(p_cou_info => p_cou_info);
  END LOOP;

END;

--�޸�
DECLARE
  p_cou_info t_course%ROWTYPE;
BEGIN
  --��������
  FOR i IN 1 .. 5 LOOP
    p_cou_info.cno   := i;
    p_cou_info.name  := i * 2 || 'name';
    p_cou_info.score := i;
    --�����������洢���̣�
    pkg_person_info_sys.update_t_course(p_cou_info => p_cou_info);
  END LOOP;

END;

--ɾ��
DECLARE
  p_cou_info t_course%ROWTYPE;
  --�α�
  CURSOR cou_cur IS
    SELECT * FROM t_course t;
BEGIN
  --ɾ����������
  FOR cou_rec IN cou_cur LOOP
    --����ɾ�����洢���̣�
    pkg_person_info_sys.delete_t_course(p_cou_info => p_cou_info);
  END LOOP;
END;

--4.�����γ�
SELECT * FROM t_teacher;
DECLARE
  p_tea_info t_teacher%ROWTYPE;
  --�α�
  CURSOR cou_cur IS
    SELECT * FROM t_course t;
BEGIN
  --��������
  FOR i IN 1 .. 3 LOOP
          p_tea_info.tno  := seq_t_class.nextval;
      p_tea_info.name := i || 'dept';
      p_tea_info.age  := 30;
    FOR cou_rec IN cou_cur LOOP
      p_tea_info.cno  := cou_rec.cno ;
    END LOOP;
    --�����������洢���̣�
    pkg_person_info_sys.insert_t_teacher(p_tea_info => p_tea_info);
  END LOOP;

END;

--�޸�
DECLARE
  p_tea_info t_teacher%ROWTYPE;
BEGIN
  --��������
  FOR i IN 1 .. 2 LOOP
    p_tea_info.tno  := i;
    p_tea_info.name := i || 'name';
    p_tea_info.age  := 40;
    p_tea_info.cno  := i;
    --�����������洢���̣�
    pkg_person_info_sys.update_t_teacher(p_tea_info => p_tea_info);
  END LOOP;

END;

--ɾ��
DECLARE
  p_tea_info t_teacher%ROWTYPE;
  --�α�
  CURSOR tea_cur IS
    SELECT * FROM t_teacher t;
BEGIN
  --ɾ����������
  FOR tea_rec IN tea_cur LOOP
    --����ɾ�����洢���̣�
    pkg_person_info_sys.delete_t_teacher(p_tea_info => tea_rec);
  END LOOP;
END;
