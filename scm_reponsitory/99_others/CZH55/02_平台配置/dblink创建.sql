CREATE PUBLIC DATABASE LINK db_link_scmdata_nbw CONNECT TO nbw IDENTIFIED BY Sf123321 USING '(DESCRIPTION =
    (ADDRESS_LIST =
      (ADDRESS = (PROTOCOL = TCP)(HOST = 172.28.40.60)(PORT = 1521 ))
    )
    (CONNECT_DATA =
      (SERVICE_NAME = devscm)
    )
  )';
  --参数说明
  --username 需要访问数据用户名， password  密码， visit_ip  需要访问数据库的ip，visit_port 窗口， db_name数据库名称
  
  
SELECT * FROM nbw.sys_field_list fd;
--同步field_list
DECLARE
BEGIN
  INSERT INTO bw3.sys_field_list
    SELECT *
      FROM nbw.sys_field_list@db_link_scmdata_nbw fd
     WHERE NOT EXISTS (SELECT 1
              FROM bw3.sys_field_list t
             WHERE t.field_name = fd.field_name);
END;

--同步sys_group_dict 平台字典
SELECT * FROM scmdata.sys_group_dict;
SELECT * FROM scmdata.sys_group_dict@db_link_scmdata;

SELECT *
  FROM scmdata.sys_group_dict@db_link_scmdata fd
 WHERE NOT EXISTS (SELECT 1
          FROM scmdata.sys_group_dict t
         WHERE t.group_dict_id = fd.group_dict_id);

DECLARE
BEGIN
  INSERT INTO scmdata.sys_group_dict
    SELECT *
      FROM scmdata.sys_group_dict@db_link_scmdata fd
     WHERE NOT EXISTS
     (SELECT 1
              FROM scmdata.sys_group_dict t
             WHERE t.group_dict_type = fd.group_dict_type
               AND t.group_dict_value = fd.group_dict_value);
END;

--同步sys_group_dict 企业字典
SELECT * FROM scmdata.sys_company_dict;
SELECT *
  FROM scmdata.sys_company_dict@db_link_scmdata
 WHERE company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7';

SELECT *
  FROM scmdata.sys_company_dict@db_link_scmdata fd
 WHERE company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7'
   AND NOT EXISTS
 (SELECT 1
          FROM scmdata.sys_company_dict t
         WHERE t.company_dict_type = fd.company_dict_type
           AND t.company_dict_value = fd.company_dict_value);
                    

DECLARE
BEGIN
  INSERT INTO scmdata.sys_company_dict
    SELECT *
      FROM scmdata.sys_company_dict@db_link_scmdata fd
     WHERE NOT EXISTS
     (SELECT 1
              FROM scmdata.sys_company_dict t
             WHERE t.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7'
               AND t.company_dict_type = fd.company_dict_type
               AND t.company_dict_value = fd.company_dict_value);
END;
