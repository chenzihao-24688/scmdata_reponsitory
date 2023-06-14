CREATE OR REPLACE FUNCTION SCMDATA.f_get_uuid_pe RETURN VARCHAR PARALLEL_ENABLE IS
  /* createtime: 2022-7-13
     author: ZWH73
     memo:通过UUID获取主键每行并行执行
  */
  guid VARCHAR(50);
BEGIN
  guid := lower(rawtohex(sys_guid()));
  RETURN guid;
END f_get_uuid_pe;
/

