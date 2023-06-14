--±Ì–≈œ¢
--users
select a.memo bg_picture1,
       a.username,
       a.sex,
       a.mobile,
       a.dep_id,
       a.sho_id,
       a.knowledge,
       case
         when a.memo is null then
          '8210c3d0fbe37a11ff16608838d602ed'
         else
          a.memo
       end bg_picture1  
  from users a
 where a.username like '%ª∆œË%';

insert into sys_sql_config
  (APP_ID,
   SQL_NAME,
   DATA_SOURCE,
   SQL_TEXT,
   SQL_TYPE,
   CONFIG_TYPE,
   MEMO,
   PAUSE)
values
  ('app_sanfu_retail',
   'modify_user_info',
   'oracle_nsfdata',
   '  update users  set memo = :bg_picture1, mobile   = :mobile, username =:username, knowledge =:knowledge,  sex      = :sex  where userid = %CURRENTUSERID% ',
   2,
   0,
   null,
   0);

insert into sys_sql_config
  (APP_ID,
   SQL_NAME,
   DATA_SOURCE,
   SQL_TEXT,
   SQL_TYPE,
   CONFIG_TYPE,
   MEMO,
   PAUSE)
values
  ('app_sanfu_retail',
   'user_info',
   'oracle_nsfdata',
   'select a.memo bg_picture1,a.username,a.mobile,a.dep_id,a.sho_id,a.knowledge, case when a.memo is null then ''8210c3d0fbe37a11ff16608838d602ed'' else  a.memo end bg_picture1 from users a where a.userid = :userid  ',
   0,
   0,
   null,
   0);

insert into sys_config (SET_NAME, SET_VALUE, APP_ID) values  ('personal_image', 'BG_PICTURE1', 'app_sanfu_retail');
