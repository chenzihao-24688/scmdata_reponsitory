begin
insert into bw3.sys_item_rela (ITEM_ID, RELATE_ID, RELATE_TYPE, SEQ_NO, PAUSE)
values ('c_2051', 'c_2412', 'S', 3, 0);
end;
/
begin
update bw3.sys_item_list t set t.select_sql = q'[SELECT dp.data_priv_id,
       decode(dp.pause,1,'∆Ù”√',0,'Õ£”√') pause_desc,
       dp.data_priv_code,
       dp.data_priv_name,
       dp.create_id,
       dp.create_time,
       dp.update_id,
       dp.update_time
  FROM sys_data_privs dp
 ORDER BY dp.level_type ASC, dp.seq_no ASC]' where t.item_id = 'c_2420';
end;
