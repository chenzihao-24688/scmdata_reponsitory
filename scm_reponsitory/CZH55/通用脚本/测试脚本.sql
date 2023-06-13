--查询班级
SELECT * FROM t_class;
--1.新增班级
DECLARE
  p_cla_info t_class%ROWTYPE;
BEGIN
  --生成数据
  FOR i IN 1 .. 10 LOOP
    p_cla_info.clno   := seq_t_class.nextval;
    p_cla_info.dept   := i || 'dept';
    p_cla_info.grade  := i || 'grade';
    p_cla_info.branch := i || 'branch';
    --调用新增（存储过程）
    pkg_person_info_sys.insert_t_class(p_cla_info => p_cla_info);
  END LOOP;

END;

--修改
DECLARE
  p_cla_info t_class%ROWTYPE;
BEGIN
  --生成数据
  FOR i IN 1 .. 10 LOOP
    p_cla_info.clno   := i; --班级编号
    p_cla_info.dept   := i * 2 || 'dept';
    p_cla_info.grade  := i * 2 || 'grade';
    p_cla_info.branch := i * 2 || 'branch';
    --调用修改（存储过程）
    pkg_person_info_sys.update_t_class(p_cla_info => p_cla_info);
  END LOOP;

END;

--删除
DECLARE
  p_cla_info t_class%ROWTYPE;
  --游标
  CURSOR cla_cur IS
    SELECT t.clno FROM t_class t;
BEGIN
  --删除所有数据
  FOR cla_rec IN cla_cur LOOP
    --调用删除（存储过程）
    pkg_person_info_sys.delete_t_class(p_cla_no => cla_rec.clno);
  END LOOP;
END;

--查询学生
SELECT * FROM t_student;

--2.新增学生

DECLARE
  p_stu_info t_student%ROWTYPE;
BEGIN
  --生成数据
  FOR i IN 1 .. 10 LOOP
    p_stu_info.sno  := seq_t_class.nextval;
    p_stu_info.name := i || 'dept';
    p_stu_info.age  := i;
    p_stu_info.sex  := '0';
    --调用新增（存储过程）
    pkg_person_info_sys.insert_t_student(p_stu_info => p_stu_info);
  END LOOP;

END;

--修改
DECLARE
  p_stu_info t_student%ROWTYPE;
BEGIN
  --生成数据
  FOR i IN 1 .. 10 LOOP
    p_stu_info.sno  := i;
    p_stu_info.name := i * 2 || 'dept';
    p_stu_info.age  := i * 2;
    p_stu_info.sex  := '1';
    --调用修改（存储过程）
    pkg_person_info_sys.update_t_student(p_stu_info => p_stu_info);
  END LOOP;

END;

--删除
DECLARE
  p_stu_info t_student%ROWTYPE;
  --游标
  CURSOR stu_cur IS
    SELECT * FROM t_student t;
BEGIN
  --删除所有数据
  FOR stu_rec IN stu_cur LOOP
    --调用删除（存储过程）
    pkg_person_info_sys.delete_t_student(p_stu_info => stu_rec);
  END LOOP;
END;

--查询课程
SELECT * FROM t_course;

--3.新增课程

DECLARE
  p_cou_info t_course%ROWTYPE;
BEGIN
  --生成数据
  FOR i IN 1 .. 5 LOOP
    p_cou_info.cno   := seq_t_class.nextval;
    p_cou_info.name  := i || 'dept';
    p_cou_info.score := i;
    --调用新增（存储过程）
    pkg_person_info_sys.insert_t_course(p_cou_info => p_cou_info);
  END LOOP;

END;

--修改
DECLARE
  p_cou_info t_course%ROWTYPE;
BEGIN
  --生成数据
  FOR i IN 1 .. 5 LOOP
    p_cou_info.cno   := i;
    p_cou_info.name  := i * 2 || 'name';
    p_cou_info.score := i;
    --调用新增（存储过程）
    pkg_person_info_sys.update_t_course(p_cou_info => p_cou_info);
  END LOOP;

END;

--删除
DECLARE
  p_cou_info t_course%ROWTYPE;
  --游标
  CURSOR cou_cur IS
    SELECT * FROM t_course t;
BEGIN
  --删除所有数据
  FOR cou_rec IN cou_cur LOOP
    --调用删除（存储过程）
    pkg_person_info_sys.delete_t_course(p_cou_info => p_cou_info);
  END LOOP;
END;

--4.新增课程
SELECT * FROM t_teacher;
DECLARE
  p_tea_info t_teacher%ROWTYPE;
  --游标
  CURSOR cou_cur IS
    SELECT * FROM t_course t;
BEGIN
  --生成数据
  FOR i IN 1 .. 3 LOOP
          p_tea_info.tno  := seq_t_class.nextval;
      p_tea_info.name := i || 'dept';
      p_tea_info.age  := 30;
    FOR cou_rec IN cou_cur LOOP
      p_tea_info.cno  := cou_rec.cno ;
    END LOOP;
    --调用新增（存储过程）
    pkg_person_info_sys.insert_t_teacher(p_tea_info => p_tea_info);
  END LOOP;

END;

--修改
DECLARE
  p_tea_info t_teacher%ROWTYPE;
BEGIN
  --生成数据
  FOR i IN 1 .. 2 LOOP
    p_tea_info.tno  := i;
    p_tea_info.name := i || 'name';
    p_tea_info.age  := 40;
    p_tea_info.cno  := i;
    --调用新增（存储过程）
    pkg_person_info_sys.update_t_teacher(p_tea_info => p_tea_info);
  END LOOP;

END;

--删除
DECLARE
  p_tea_info t_teacher%ROWTYPE;
  --游标
  CURSOR tea_cur IS
    SELECT * FROM t_teacher t;
BEGIN
  --删除所有数据
  FOR tea_rec IN tea_cur LOOP
    --调用删除（存储过程）
    pkg_person_info_sys.delete_t_teacher(p_tea_info => tea_rec);
  END LOOP;
END;
