SELECT

 sys_context('USERENV', 'TERMINAL') terminal,
 
 sys_context('USERENV', 'LANGUAGE') LANGUAGE,
 
 sys_context('USERENV', 'SESSIONID') sessionid,
 
 sys_context('USERENV', 'INSTANCE') instance,
 
 sys_context('USERENV', 'ENTRYID') entryid,
 
 sys_context('USERENV', 'ISDBA') isdba,
 
 sys_context('USERENV', 'NLS_TERRITORY') nls_territory,
 
 sys_context('USERENV', 'NLS_CURRENCY') nls_currency,
 
 sys_context('USERENV', 'NLS_CALENDAR') nls_calendar,
 
 sys_context('USERENV', 'NLS_DATE_FORMAT') nls_date_format,
 
 sys_context('USERENV', 'NLS_DATE_LANGUAGE') nls_date_language,
 
 sys_context('USERENV', 'NLS_SORT') nls_sort,
 
 sys_context('USERENV', 'CURRENT_USER') CURRENT_USER,
 
 sys_context('USERENV', 'CURRENT_USERID') current_userid,
 
 sys_context('USERENV', 'SESSION_USER') session_user,
 
 sys_context('USERENV', 'SESSION_USERID') session_userid,
 
 sys_context('USERENV', 'PROXY_USER') proxy_user,
 
 sys_context('USERENV', 'PROXY_USERID') proxy_userid,
 
 sys_context('USERENV', 'DB_DOMAIN') db_domain,
 
 sys_context('USERENV', 'DB_NAME') db_name,
 
 sys_context('USERENV', 'HOST') host,
 
 sys_context('USERENV', 'OS_USER') os_user,
 
 sys_context('USERENV', 'EXTERNAL_NAME') external_name,
 
 sys_context('USERENV', 'IP_ADDRESS') ip_address,
 
 sys_context('USERENV', 'NETWORK_PROTOCOL') network_protocol,
 
 sys_context('USERENV', 'BG_JOB_ID') bg_job_id,
 
 sys_context('USERENV', 'FG_JOB_ID') fg_job_id,
 
 sys_context('USERENV', 'AUTHENTICATION_TYPE') authentication_type,
 
 sys_context('USERENV', 'AUTHENTICATION_DATA') authentication_data

  FROM dual
