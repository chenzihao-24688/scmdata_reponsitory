--准入流程 流程操作按钮
SELECT ROWID, t.*
  FROM nbw.sys_action t
 WHERE t.element_id IN ('action_a_coop_121',
                        'action_a_coop_121_1',
                        'action_a_coop_130',
                        'action_a_coop_151',
                        'ac_a_coop_150_4',
                        'ac_a_coop_150_2',
                        'action_specialapply',
                        'action_a_coop_220_1',
                        'action_a_coop_220_2',
                        'action_a_coop_220_3',
                        'ac_a_check_101_3',
                        'action_a_check_101_1_0',
                        'action_a_check_102_1',
                        'action_a_check_102_2',
                        'action_a_check_102_3',
                        'action_a_coop_311',
                        'action_a_coop_312',
                        'action_a_coop_313',
                        'action_a_supp_151_1',
                        'action_a_check_farevoke');
