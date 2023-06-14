--应用关系启停，上下架
--上下游个应用，应用关系之前的状态变化
with b as
 (select a.rela_apply_id,
         a.force_bind,
         a.apply_rela_id,
         g.pause pause_desc,
         g.apply_status,
         a.pause --,g.pause   
    from scmdata.sys_group_apply g, scmdata.sys_group_apply_rela a
   where g.apply_id = a.apply_id
     and g.apply_id = 'apply_1')
select ga.apply_id RELA_APPLY_ID,
       --:apply_id apply_id,
       ga.pause        gpause,
       ga.apply_status gapply_status,
       b.pause_desc    bpause,
       b.apply_status  bapply_status,
       --decode(ga.pause, 0, b.pause, ga.pause) pause,
       /*       case
         when (ga.pause = 0 and ga.apply_status = 0 and b.pause_desc = 0 and
              b.apply_status = 0) then
          0
         else
          1
       end pause,*/
       b.pause,
       b.force_bind,
       --ga.pause,
       --ga.apply_status,
       ga.icon         APPLY_ICON,
       ga.apply_name,
       ga.tips,
       ga.apply_type,
       ga.create_time,
       b.apply_rela_id
  from scmdata.sys_group_apply ga, b
 where ga.apply_id = b.rela_apply_id;


     
select   a.* 
    from scmdata.sys_group_apply g, scmdata.sys_group_apply_rela a
   where g.apply_id = a.apply_id
     and a.rela_apply_id = 'apply_2';
