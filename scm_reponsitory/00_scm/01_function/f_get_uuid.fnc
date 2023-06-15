CREATE OR REPLACE FUNCTION SCMDATA.f_get_uuid RETURN VARCHAR IS
  /* createtime: 2020-7-1
     author: HX87
     memo:通过UUID获取主键
  */
  guid VARCHAR(50);
BEGIN
  guid := lower(rawtohex(sys_guid()));
  RETURN guid;
END f_get_uuid;
/

