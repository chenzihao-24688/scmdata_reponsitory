create or replace package scmdata.PKG_IF_COMM is

  -- Author  : 黄翔
  -- Created : 2023/5/22 13:46:51
  -- Purpose : 公用包

--返回接口最近一次调度时间
Function Get_IF_LastProcessTime(PI_IF_ID IN VARCHAR2) Return Date;
end;
/

create or replace package body scmdata.PKG_IF_COMM is

  -- Author  : 黄翔
  -- Created : 2023/5/22 13:46:51
  -- Purpose : 公用包

--返回接口最近一次调度时间
Function Get_IF_LastProcessTime(PI_IF_ID IN VARCHAR2) Return Date
is
   P_Result Date;
Begin
  Select max(Process_DateTime)
    into P_Result
    From CMX_IF_LOC_MANAGERMENT
   Where IF_ID = PI_IF_ID;
  if P_Result is null then
    P_Result := date'1900-01-01';
  end if;
  RETURN P_Result;
end;

end;
/

