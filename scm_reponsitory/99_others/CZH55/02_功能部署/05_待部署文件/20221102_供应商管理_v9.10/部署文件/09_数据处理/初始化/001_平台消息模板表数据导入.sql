insert into scmdata.sys_group_wecom_msg_pattern (SYS_GROUP_WECOM_MSG_PATTERN_ID, SYS_GROUP_WECOM_MSG_PATTERN_CODE, SYS_GROUP_WECOM_MSG_PATTERN_NAME, MSG_PATTERN, DESCRIPTORS, COMPLEX_LIMIT, PAUSE, QUANTIFIER, PARAM_NAME_LIST, HINT_SQL, APPLY_ID)
values ('f230ce12b0473d4fe0533c281cac52a6', 'FR_SUBMIT_00', '验厂报告_提交(鞋类)', 'SCM系统消息：您好！{{SUP_NAME}}报告待审核，请您前往【验厂管理】待审核页面进行处理。', '供应商', null, 0, '家', 'SUP_NAME', null, 'apply_2');

insert into scmdata.sys_group_wecom_msg_pattern (SYS_GROUP_WECOM_MSG_PATTERN_ID, SYS_GROUP_WECOM_MSG_PATTERN_CODE, SYS_GROUP_WECOM_MSG_PATTERN_NAME, MSG_PATTERN, DESCRIPTORS, COMPLEX_LIMIT, PAUSE, QUANTIFIER, PARAM_NAME_LIST, HINT_SQL, APPLY_ID)
values ('f20cc83a28c36013e0533c281cac3f9c', 'FR_REJECT', '待验厂_驳回', 'SCM系统消息：您好！{{SUP_NAME}}验厂被驳回，请您前往【验厂申请】待审核申请页面进行处理。', '供应商', null, 0, '家', 'SUP_NAME', null, 'apply_2');

insert into scmdata.sys_group_wecom_msg_pattern (SYS_GROUP_WECOM_MSG_PATTERN_ID, SYS_GROUP_WECOM_MSG_PATTERN_CODE, SYS_GROUP_WECOM_MSG_PATTERN_NAME, MSG_PATTERN, DESCRIPTORS, COMPLEX_LIMIT, PAUSE, QUANTIFIER, PARAM_NAME_LIST, HINT_SQL, APPLY_ID)
values ('f230ce12b0c43d4fe0533c281cac52a6', 'FR_SUBMIT_01', '验厂报告_提交(非鞋类)', 'SCM系统消息：您好！{{SUP_NAME}}报告待审核，请您前往【验厂管理】待审核页面进行处理。', '供应商', null, 0, '家', 'SUP_NAME', null, 'apply_2');

insert into scmdata.sys_group_wecom_msg_pattern (SYS_GROUP_WECOM_MSG_PATTERN_ID, SYS_GROUP_WECOM_MSG_PATTERN_CODE, SYS_GROUP_WECOM_MSG_PATTERN_NAME, MSG_PATTERN, DESCRIPTORS, COMPLEX_LIMIT, PAUSE, QUANTIFIER, PARAM_NAME_LIST, HINT_SQL, APPLY_ID)
values ('f25f6b76039303c0e0533c281caccf45', 'FA_SPECIAL_00', '验厂申请_特批申请按钮', 'SCM系统消息：您好！{{SUP_NAME}}待特批，请您前往【准入审批】待审批申请页面进行处理。', '供应商', null, 0, '家', 'SUP_NAME', null, 'apply_1');

insert into scmdata.sys_group_wecom_msg_pattern (SYS_GROUP_WECOM_MSG_PATTERN_ID, SYS_GROUP_WECOM_MSG_PATTERN_CODE, SYS_GROUP_WECOM_MSG_PATTERN_NAME, MSG_PATTERN, DESCRIPTORS, COMPLEX_LIMIT, PAUSE, QUANTIFIER, PARAM_NAME_LIST, HINT_SQL, APPLY_ID)
values ('f25f6b76041103c0e0533c281caccf45', 'FA_DISAGREE_01', '特批_不同意准入', 'SCM系统消息：您好！{{SUP_NAME}}特批不通过，请知。', '供应商', null, 0, '家', 'SUP_NAME', null, 'apply_1');

insert into scmdata.sys_group_wecom_msg_pattern (SYS_GROUP_WECOM_MSG_PATTERN_ID, SYS_GROUP_WECOM_MSG_PATTERN_CODE, SYS_GROUP_WECOM_MSG_PATTERN_NAME, MSG_PATTERN, DESCRIPTORS, COMPLEX_LIMIT, PAUSE, QUANTIFIER, PARAM_NAME_LIST, HINT_SQL, APPLY_ID)
values ('f259bb1be0b97789e0533c281cac3825', 'FA_SUBMIT_00', '提交_验厂申请', 'SCM系统消息：您好！{{SUP_NAME}}申请待审核，请您前往【验厂申请】待审核申请页面进行处理。', '供应商', null, 0, '家', 'SUP_NAME', null, 'apply_1');

insert into scmdata.sys_group_wecom_msg_pattern (SYS_GROUP_WECOM_MSG_PATTERN_ID, SYS_GROUP_WECOM_MSG_PATTERN_CODE, SYS_GROUP_WECOM_MSG_PATTERN_NAME, MSG_PATTERN, DESCRIPTORS, COMPLEX_LIMIT, PAUSE, QUANTIFIER, PARAM_NAME_LIST, HINT_SQL, APPLY_ID)
values ('f25d10c920de1705e0533c281cacec2c', 'FA_REJECT_00', '准入审批不验厂_驳回', 'SCM系统消息：您好！{{SUP_NAME}}报告被驳回，请您前往【验厂申请】待审核申请页面进行处理。', '供应商', null, 0, '家', 'SUP_NAME', null, 'apply_1');

insert into scmdata.sys_group_wecom_msg_pattern (SYS_GROUP_WECOM_MSG_PATTERN_ID, SYS_GROUP_WECOM_MSG_PATTERN_CODE, SYS_GROUP_WECOM_MSG_PATTERN_NAME, MSG_PATTERN, DESCRIPTORS, COMPLEX_LIMIT, PAUSE, QUANTIFIER, PARAM_NAME_LIST, HINT_SQL, APPLY_ID)
values ('f25d10c9215b1705e0533c281cacec2c', 'FA_REJECT_01', '准入审批内部验厂_驳回', 'SCM系统消息：您好！{{SUP_NAME}}报告被驳回，请您前往【验厂管理】待验厂页面进行处理。', '供应商', null, 0, '家', 'SUP_NAME', null, 'apply_1');

insert into scmdata.sys_group_wecom_msg_pattern (SYS_GROUP_WECOM_MSG_PATTERN_ID, SYS_GROUP_WECOM_MSG_PATTERN_CODE, SYS_GROUP_WECOM_MSG_PATTERN_NAME, MSG_PATTERN, DESCRIPTORS, COMPLEX_LIMIT, PAUSE, QUANTIFIER, PARAM_NAME_LIST, HINT_SQL, APPLY_ID)
values ('f25e57d6e11608d0e0533c281cac5559', 'FA_DISAGREE_00', '准入审批_不同意准入', 'SCM系统消息：您好！{{SUP_NAME}}准入不通过，若需继续合作，请您前往【验厂申请】供应商资源库页面申请特批。', '供应商', null, 0, '家', 'SUP_NAME', null, 'apply_1');

insert into scmdata.sys_group_wecom_msg_pattern (SYS_GROUP_WECOM_MSG_PATTERN_ID, SYS_GROUP_WECOM_MSG_PATTERN_CODE, SYS_GROUP_WECOM_MSG_PATTERN_NAME, MSG_PATTERN, DESCRIPTORS, COMPLEX_LIMIT, PAUSE, QUANTIFIER, PARAM_NAME_LIST, HINT_SQL, APPLY_ID)
values ('f25e0d63b426374ae0533c281cac6e39', 'FA_AUDIT_00', '验厂申请审核_不验厂', 'SCM系统消息：您好！{{SUP_NAME}}准入待审批，请您前往【准入审批】待审批申请页面进行处理。', '供应商', null, 0, '家', 'SUP_NAME', null, 'apply_1');

insert into scmdata.sys_group_wecom_msg_pattern (SYS_GROUP_WECOM_MSG_PATTERN_ID, SYS_GROUP_WECOM_MSG_PATTERN_CODE, SYS_GROUP_WECOM_MSG_PATTERN_NAME, MSG_PATTERN, DESCRIPTORS, COMPLEX_LIMIT, PAUSE, QUANTIFIER, PARAM_NAME_LIST, HINT_SQL, APPLY_ID)
values ('f25e0d63b4a3374ae0533c281cac6e39', 'FA_AUDIT_01', '验厂申请审核_内部验厂', 'SCM系统消息：您好！{{SUP_NAME}}待验厂，请您通知相关工艺师安排验厂，并前往【验厂管理】待验厂页面进行处理。', '供应商', null, 0, '家', 'SUP_NAME', null, 'apply_1');

insert into scmdata.sys_group_wecom_msg_pattern (SYS_GROUP_WECOM_MSG_PATTERN_ID, SYS_GROUP_WECOM_MSG_PATTERN_CODE, SYS_GROUP_WECOM_MSG_PATTERN_NAME, MSG_PATTERN, DESCRIPTORS, COMPLEX_LIMIT, PAUSE, QUANTIFIER, PARAM_NAME_LIST, HINT_SQL, APPLY_ID)
values ('f25e57d6e09108d0e0533c281cac5559', 'FA_AUDIT_02', '验厂申请审核_不同意', 'SCM系统消息：您好！{{SUP_NAME}}申请审核不通过，请您前往【验厂申请】供应商资源库页面进行处理。', '供应商', null, 0, '家', 'SUP_NAME', null, 'apply_1');

insert into scmdata.sys_group_wecom_msg_pattern (SYS_GROUP_WECOM_MSG_PATTERN_ID, SYS_GROUP_WECOM_MSG_PATTERN_CODE, SYS_GROUP_WECOM_MSG_PATTERN_NAME, MSG_PATTERN, DESCRIPTORS, COMPLEX_LIMIT, PAUSE, QUANTIFIER, PARAM_NAME_LIST, HINT_SQL, APPLY_ID)
values ('f25e57d6e19308d0e0533c281cac5559', 'FA_AGREE_00', '准入审批_同意准入', 'SCM系统消息：您好！{{SUP_NAME}}待建档，请您前往【成品供应商】待建档供应商页面建档。', '供应商', null, 0, '家', 'SUP_NAME', null, 'apply_1');

insert into scmdata.sys_group_wecom_msg_pattern (SYS_GROUP_WECOM_MSG_PATTERN_ID, SYS_GROUP_WECOM_MSG_PATTERN_CODE, SYS_GROUP_WECOM_MSG_PATTERN_NAME, MSG_PATTERN, DESCRIPTORS, COMPLEX_LIMIT, PAUSE, QUANTIFIER, PARAM_NAME_LIST, HINT_SQL, APPLY_ID)
values ('f2355a9808fd5e30e0533c281caccada', 'FR_AUDIT_00', '待审核_通过/不通过按钮', 'SCM系统消息：您好！{{SUP_NAME}}准入待审批，请您前往【准入审批】待审批申请页面进行处理。', '供应商', null, 0, '家', 'SUP_NAME', null, 'apply_2');

insert into scmdata.sys_group_wecom_msg_pattern (SYS_GROUP_WECOM_MSG_PATTERN_ID, SYS_GROUP_WECOM_MSG_PATTERN_CODE, SYS_GROUP_WECOM_MSG_PATTERN_NAME, MSG_PATTERN, DESCRIPTORS, COMPLEX_LIMIT, PAUSE, QUANTIFIER, PARAM_NAME_LIST, HINT_SQL, APPLY_ID)
values ('f2355a98097a5e30e0533c281caccada', 'FR_AUDIT_01', '待审核_驳回', 'SCM系统消息：您好！{{SUP_NAME}}报告被驳回，请您前往【验厂管理】待审核页面进行处理。', '供应商', null, 0, '家', 'SUP_NAME', null, 'apply_2');
