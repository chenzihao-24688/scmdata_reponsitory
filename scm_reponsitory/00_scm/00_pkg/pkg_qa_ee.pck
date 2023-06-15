CREATE OR REPLACE PACKAGE SCMDATA.pkg_qa_ee IS

  /*=============================================================================

     包：
       pkg_qa_ee(qa错误处理包)

     函数名:
       校验模块名是否超出最大长度限制

     入参:
       v_inp_modulename  :  模块名
       v_inp_invokeobj   :  调用对象

     返回值:
       Number 类型，0-没超出最大长度限制
                    1-超出最大长度限制

     版本:
       2022-10-13_zc314 : 校验模块名是否超出最大长度限制

  ==============================================================================*/
  FUNCTION f_is_modulenameoverlimitlength(v_inp_modulename IN VARCHAR2,
                                          v_inp_invokeobj  IN VARCHAR2)
    RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_ee(qa错误处理包)

     过程名:
       新增错误记录表数据(自治事务)

     入参:
       v_inp_errprogram      :  错误模块名
       v_inp_causeerruserid  :  造成错误人员Id
       v_inp_erroccurtime    :  错误发生时间
       v_inp_errinfo         :  错误信息
       v_inp_compid          :  企业Id

     版本:
       2022-10-17_zc314 : 新增错误记录表数据(自治事务)

  ==============================================================================*/
  PROCEDURE p_ins_errrecord_at(v_inp_errprogram     IN VARCHAR2,
                               v_inp_causeerruserid IN VARCHAR2,
                               v_inp_erroccurtime   IN DATE,
                               v_inp_errinfo        IN CLOB,
                               v_inp_compid         IN VARCHAR2);
END pkg_qa_ee;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_qa_ee IS

  /*=============================================================================

     包：
       pkg_qa_ee(qa错误处理包)

     函数名:
       校验模块名是否超出最大长度限制

     入参:
       v_inp_modulename  :  模块名
       v_inp_invokeobj   :  调用对象

     返回值:
       Number 类型，0-没超出最大长度限制
                    1-超出最大长度限制

     版本:
       2022-10-13_zc314 : 校验模块名是否超出最大长度限制

  ==============================================================================*/
  FUNCTION f_is_modulenameoverlimitlength(v_inp_modulename IN VARCHAR2,
                                          v_inp_invokeobj  IN VARCHAR2)
    RETURN NUMBER IS
    v_length          NUMBER(16);
    v_retnum          NUMBER(1);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_ee.p_ins_errrecord';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ee.f_is_modulenameoverlimitlength';
  BEGIN
    --Done: 访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;

    v_length := LENGTH(v_inp_modulename);

    IF v_length > 4 THEN
      v_retnum := 1;
    ELSE
      v_retnum := 0;
    END IF;

    RETURN v_retnum;
  END f_is_modulenameoverlimitlength;

  /*=============================================================================

     包：
       pkg_qa_ee(qa错误处理包)

     过程名:
       新增错误记录表数据(自治事务)

     入参:
       v_inp_errprogram      :  错误模块名
       v_inp_causeerruserid  :  造成错误人员Id
       v_inp_erroccurtime    :  错误发生时间
       v_inp_errinfo         :  错误信息
       v_inp_compid          :  企业Id

     版本:
       2023-01-30_zc314 : 新增错误记录表数据(自治事务)

  ==============================================================================*/
  PROCEDURE p_ins_errrecord_at(v_inp_errprogram     IN VARCHAR2,
                               v_inp_causeerruserid IN VARCHAR2,
                               v_inp_erroccurtime   IN DATE,
                               v_inp_errinfo        IN CLOB,
                               v_inp_compid         IN VARCHAR2) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    v_sql             CLOB;
    v_errid           VARCHAR2(32);
    v_errinfo         CLOB;
    v_errstack        VARCHAR2(512);
    v_errmodule       VARCHAR2(32) := 'QA';
  BEGIN
    v_errid := scmdata.f_get_uuid();

    v_sql := 'INSERT INTO scmdata.t_errrecord
  (err_id,
   company_id,
   err_module,
   err_program,
   errcause_userid,
   erroccur_time,
   err_info)
VALUES
  (:v_errid,
   :v_inp_compid,
   :v_errmodule,
   :v_inp_errprogram,
   :v_inp_causeerruserid,
   :v_inp_erroccurtime,
   :v_inp_errinfo)';

    EXECUTE IMMEDIATE v_sql
      USING v_errid, v_inp_compid, v_errmodule, v_inp_errprogram, v_inp_causeerruserid, v_inp_erroccurtime, v_inp_errinfo;

    COMMIT;
  EXCEPTION 
    WHEN OTHERS THEN 
      v_errstack := SUBSTR(dbms_utility.format_error_stack(), 1, 512);
      v_errinfo := 'Error Object: scmdata.pkg_qa_ee.p_ins_errrecord_at' ||
                   chr(10) || 'Error Info: ' || v_errstack || chr(10) ||
                   'Execute_sql:' || v_sql || chr(10) || 'Params: ' ||
                   chr(10) || 'v_errid: ' || v_errid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid || chr(10) ||
                   'v_errmodule: ' || v_errmodule || chr(10) ||
                   'v_inp_errprogram: ' || v_inp_errprogram || chr(10) ||
                   'v_inp_causeerruserid: ' || v_inp_causeerruserid || chr(10) ||
                   'v_inp_erroccurtime: ' || to_char(v_inp_erroccurtime,'yyyy-mm-dd hh24-mi-ss') || chr(10) ||
                   'v_inp_errinfo: ' || v_inp_errinfo;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => 'scmdata.pkg_qa_ee.p_ins_errrecord_at',
                                           v_inp_causeerruserid => 'self',
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => 'self_company');
  END p_ins_errrecord_at;

END pkg_qa_ee;
/

