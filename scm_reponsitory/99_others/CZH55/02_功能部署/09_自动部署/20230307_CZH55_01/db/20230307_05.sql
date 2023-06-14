DECLARE
  p_i               INT;
  v_tips            VARCHAR2(200);
  v_company_role_id VARCHAR2(32);
  v_company_id      VARCHAR2(32);
  v_user_id         VARCHAR2(32);
  v_role_id         VARCHAR2(32);
BEGIN
  SELECT MAX(1)
    INTO p_i
    FROM dual
   WHERE NOT EXISTS
   (SELECT 1
            FROM scmdata.sys_company_role a
           WHERE a.company_role_name IN ('��������Ա', '����Ա', '��ͨ�û�')
             AND a.company_id = v_company_id);
  IF p_i = 1 THEN
  
    SELECT MAX(t.company_id), MAX(t.attributor_id)
      INTO v_company_id, v_user_id
      FROM scmdata.sys_company t
     WHERE t.licence_num = '91440106MAC14MY400';
  
    --1.������ҵ��ɫ��������
    v_tips            := '��ҵ�Ĵ�����(ϵͳ�Դ�)';
    v_company_role_id := scmdata.f_get_uuid();
    INSERT INTO scmdata.sys_company_role
      (company_role_id, company_id, company_role_name, tips, sort,
       create_id, create_time, update_id, update_time)
    VALUES
      (v_company_role_id, v_company_id, '��������Ա', v_tips, 1, 'ADMIN',
       SYSDATE, 'ADMIN', SYSDATE);
  
    INSERT INTO scmdata.sys_company_role_security
      (role_security_id, company_id, company_role_id, company_security_id)
    VALUES
      (scmdata.f_get_uuid(), v_company_id, v_company_role_id, '0');
  
    --2.������ҵ��ɫ������Ա
    v_tips            := '��ҵ�Ĺ���Ա��������ҵӦ�á����á���֯����Ա�ȹ���(ϵͳ�Դ�)';
    v_company_role_id := scmdata.f_get_uuid();
    INSERT INTO scmdata.sys_company_role
      (company_role_id, company_id, company_role_name, tips, sort,
       create_id, create_time, update_id, update_time)
    VALUES
      (v_company_role_id, v_company_id, '����Ա', v_tips, 2, 'ADMIN', SYSDATE,
       'ADMIN', SYSDATE);
  
    INSERT INTO scmdata.sys_company_role_security
      (role_security_id, company_id, company_role_id, company_security_id)
      SELECT scmdata.f_get_uuid(),
             v_company_id,
             v_company_role_id,
             a.company_security_id
        FROM scmdata.sys_company_security a
       WHERE a.company_security_id <> '0';
  
    --3.������ҵ��ɫ:��ͨ�û�
    v_tips            := '��ҵ����ͨ�û�(ϵͳ�Դ�)';
    v_company_role_id := scmdata.f_get_uuid();
    INSERT INTO scmdata.sys_company_role
      (company_role_id, company_id, company_role_name, tips, sort,
       create_id, create_time, update_id, update_time, is_default)
    VALUES
      (v_company_role_id, v_company_id, '��ͨ�û�', v_tips, 3, 'ADMIN', SYSDATE,
       'ADMIN', SYSDATE, 1);
  
    --��ȡ���������ɵ���ҵӵ����id
    SELECT MAX(company_role_id)
      INTO v_role_id
      FROM scmdata.sys_company_role
     WHERE company_id = v_company_id
       AND company_role_name = '��������Ա';
    --����ҵӵ����Ȩ�����Ӹ����û�
    INSERT INTO scmdata.sys_company_user_role
      (company_user_role_id, company_id, user_id, company_role_id)
    VALUES
      (scmdata.f_get_uuid(), v_company_id, v_user_id, v_role_id);
  END IF;
END;
/
