CREATE OR REPLACE PACKAGE SCMDATA.pkg_matersup_register  IS
 PROCEDURE P_REGISTER_MATERIALSUP(P_SUPCODE IN VARCHAR2, --物料商编号 MRP.MRP_DETERMINE_SUPPLIER_ARCHIVES.SUPPLIER_CODE
                                  P_COMID   IN VARCHAR2  --企业id，（三福企业id）
                                  ) ;

END pkg_matersup_register;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_matersup_register  IS

 PROCEDURE P_REGISTER_MATERIALSUP(P_SUPCODE IN VARCHAR2,
                                  P_COMID   IN VARCHAR2) IS

   p_user     MRP.MRP_DETERMINE_SUPPLIER_ARCHIVES%rowtype;
   p_u        int;
   p_logo     varchar2(32);
   p_user_id  varchar2(32);
   p_result   varchar2(128);
   p_msg      varchar2(128);
BEGIN

  --获取该供应商等级、简称、全称、联系电话、社信代
    SELECT *
      INTO p_user
      FROM MRP.MRP_DETERMINE_SUPPLIER_ARCHIVES A
   WHERE a.supplier_code=P_SUPCODE
     AND A.COMPANY_ID = P_COMID ;

   IF p_user.cooperation_level = 'A' THEN
    select nvl(max(1), 0)
      into p_u
      from scmdata.sys_user u
     where u.user_account =p_user.CONTACT_PHONE;

    if p_u=0 then
  --用户手机注册
  scmdata.pkg_plat_comm.p_user_register(pi_moblie =>p_user.CONTACT_PHONE, pi_uuid =>NULL, pi_devicesystem =>NULL );
     END IF;

     select max(user_id)
      into p_user_id
      from scmdata.sys_user a
     where a.user_account = p_user.CONTACT_PHONE;
    --修改初始密码
    update scmdata.sys_user a
       set a.password = '496d234c7d6f6f7a422d634747632d4273616173422d6d05'
     where a.user_id = p_user_id;

     --修改用户名称
     update scmdata.sys_user a
       set a.username = ltrim(RTRIM(p_user.SUPPLIER_ABBREVIATION)), a.nick_name = ltrim(RTRIM(p_user.SUPPLIER_ABBREVIATION))
     where a.user_id = p_user_id;

    p_logo := '1';
    --企业注册
   scmdata.pkg_user_my_company.p_register_company(pi_user_id     => p_user_id,
                                                  pi_logo        => p_logo,
                                                  pi_name        => ltrim(RTRIM(p_user.SUPPLIER_ABBREVIATION)),
                                                  pi_logn_name   => ltrim(rtrim(p_user.SUPPLIER_NAME)),
                                                  pi_LICENCE_NUM => ltrim(rtrim(p_user.UNIFIED_SOCIAL_CREDIT_CODE)),
                                                  pi_tips        => ltrim(RTRIM(p_user.SUPPLIER_ABBREVIATION)),
                                                  po_result      => p_result,
                                                  po_msg         => p_msg,pi_company_role => 'mrpp');

   IF scmdata.pkg_user_default_company.f_count_user_company(p_user_id) = 1 THEN
      scmdata.pkg_user_default_company.p_user_company_default_when_user_change(p_user_id,
                                                                               p_result,
                                                                               p_msg);
   END IF;
  ELSE
    NULL;
  END IF;

END P_REGISTER_MATERIALSUP;

END pkg_matersup_register;
/

