SELECT t.rowid,
       (SELECT fd.file_name
          FROM dba_data_files fd
         WHERE fd.file_id =
               dbms_rowid.rowid_to_absolute_fno(t.rowid, USER, 'SYS_USER')) filen, --�����ļ�λ��
       dbms_rowid.rowid_block_number(t.rowid) block_no,--��
       dbms_rowid.rowid_row_number(t.rowid) row_no--��
  FROM scmdata.sys_user t
 WHERE t.user_account = '18172543571';
