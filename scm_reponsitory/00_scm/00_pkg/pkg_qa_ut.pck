CREATE OR REPLACE PACKAGE SCMDATA.pkg_qa_ut IS

  /*=============================================================================

     包：
       pkg_qa_ut(qa单元测试包)

     过程名:
       单元测试--asn免检参数校验

     入参:
       v_inp_compname         :  企业名称
       v_inp_aereasondicname  :  免检字典名称

     打印信息:
       asn免检参数校验函数调用返回结果

     版本:
       2022-10-24_zc314 : 逻辑细节包--asn免检参数校验单元测试

  ==============================================================================*/
  PROCEDURE p_ut_pkgqald_fcheckasnexemptionparam(v_inp_compname        IN VARCHAR2,
                                                 v_inp_aereasondicname IN VARCHAR2);

END pkg_qa_ut;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_qa_ut IS

  /*=============================================================================

     包：
       pkg_qa_ut(qa单元测试包)

     过程名:
       单元测试--打印输入信息

     入参:
       v_inp_infoname   :  输入信息名称
       v_inp_infovalue  :  输入信息值

     版本:
       2022-10-24_zc314 : 逻辑细节包--asn免检参数校验单元测试

  ==============================================================================*/
  PROCEDURE p_print_inputinfo(v_inp_infoname  IN VARCHAR2,
                              v_inp_infovalue IN VARCHAR2) IS

  BEGIN
    dbms_output.put_line('Info_Name: ' || v_inp_infoname);
    dbms_output.put_line('Info_Value: ' || v_inp_infovalue);
  END p_print_inputinfo;

  /*=============================================================================

     包：
       pkg_qa_ut(qa单元测试包)

     过程名:
       单元测试--asn免检参数校验

     入参:
       v_inp_compname         :  企业名称
       v_inp_aereasondicname  :  免检字典名称

     打印信息:
       asn免检参数校验函数调用返回结果

     版本:
       2022-10-24_zc314 : 逻辑细节包--asn免检参数校验单元测试

  ==============================================================================*/
  PROCEDURE p_ut_pkgqald_fcheckasnexemptionparam(v_inp_compname        IN VARCHAR2,
                                                 v_inp_aereasondicname IN VARCHAR2) IS
    v_funcreturn    CLOB;
    v_asnid         VARCHAR2(32);
    v_asnstatus     VARCHAR2(8);
    v_compid        VARCHAR2(32);
    v_aereasoncode  VARCHAR2(32);
    v_fakeinvokeobj VARCHAR2(1024) := 'scmdata.pkg_qa_lc.p_asnexemption';
  BEGIN
    --模拟参数值
    v_compid := scmdata.pkg_mock.f_get_companyid(v_inp_compname => v_inp_compname);

    v_asnstatus := scmdata.pkg_mock.f_get_mockrandomvalinfields(v_inp_fields    => ',IN,PC,PE,PA,FA,AE,',
                                                                v_inp_seperator => ',');

    v_asnid := scmdata.pkg_mock.f_get_asnidsbystatus(v_inp_asnstatus => v_asnstatus,
                                                     v_inp_asnnumber => 1,
                                                     v_inp_compid    => v_compid);

    v_aereasoncode := scmdata.pkg_mock.f_get_mockgroupdicval(v_inp_groupdictname => v_inp_aereasondicname);

    --测试时间与参数信息输出
    p_print_inputinfo(v_inp_infoname  => '测试时间',
                      v_inp_infovalue => to_char(SYSDATE,
                                                 'yyyy-mm-dd hh24:mi:ss'));
    p_print_inputinfo(v_inp_infoname  => 'v_asnid',
                      v_inp_infovalue => v_asnid);
    p_print_inputinfo(v_inp_infoname  => 'v_asnstatus',
                      v_inp_infovalue => v_asnstatus);
    p_print_inputinfo(v_inp_infoname  => 'v_compid',
                      v_inp_infovalue => v_compid);
    p_print_inputinfo(v_inp_infoname  => 'v_aereasoncode',
                      v_inp_infovalue => v_aereasoncode);

    --模拟调用
    v_funcreturn := scmdata.pkg_qa_ld.f_check_asnexemptionparam(v_inp_asnid       => v_asnid,
                                                                v_inp_compid      => v_compid,
                                                                v_inp_aeresoncode => v_aereasoncode,
                                                                v_inp_invokeobj   => v_fakeinvokeobj);

    --模拟调用结果输出
    p_print_inputinfo(v_inp_infoname  => 'v_funcreturn',
                      v_inp_infovalue => v_funcreturn);
  EXCEPTION
    WHEN OTHERS THEN
      --报错输出
      p_print_inputinfo(v_inp_infoname  => 'format_error_backtrace',
                        v_inp_infovalue => dbms_utility.format_error_backtrace);
  END p_ut_pkgqald_fcheckasnexemptionparam;

END pkg_qa_ut;
/

