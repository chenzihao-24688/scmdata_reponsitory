BEGIN
  insert into scmdata.sys_group_dict (GROUP_DICT_ID, PARENT_ID, PARENT_IDS, GROUP_DICT_NAME, GROUP_DICT_VALUE, GROUP_DICT_TYPE, DESCRIPTION, GROUP_DICT_SORT, GROUP_DICT_STATUS, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, PAUSE, IS_COMPANY_DICT_RELA, EXTEND_01, EXTEND_02, EXTEND_03, EXTEND_04)
values ('fb63225206e05cebe0533c281cac4feb', null, null, '备料管理', 'MATERIAL_PREPARATION_DICT', 'MATERIAL_PREPARATION_DICT', '备料管理相关字典配置', 1, '1', 1, 1, 0, 'CZH', to_date('11-05-2023 10:56:24', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('11-05-2023 10:56:49', 'dd-mm-yyyy hh24:mi:ss'), null, 0, 0, '0', null, null, null, null);

insert into scmdata.sys_group_dict (GROUP_DICT_ID, PARENT_ID, PARENT_IDS, GROUP_DICT_NAME, GROUP_DICT_VALUE, GROUP_DICT_TYPE, DESCRIPTION, GROUP_DICT_SORT, GROUP_DICT_STATUS, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, PAUSE, IS_COMPANY_DICT_RELA, EXTEND_01, EXTEND_02, EXTEND_03, EXTEND_04)
values ('fb63225206e15cebe0533c281cac4feb', 'fb63225206e05cebe0533c281cac4feb', 'fb63225206e05cebe0533c281cac4feb', '备料状态', 'PREPARATION_STATUS', 'MATERIAL_PREPARATION_DICT', null, 1, '1', 1, 1, 0, 'CZH', to_date('11-05-2023 10:57:30', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('11-05-2023 10:57:30', 'dd-mm-yyyy hh24:mi:ss'), null, 0, 0, '0', null, null, null, null);

insert into scmdata.sys_group_dict (GROUP_DICT_ID, PARENT_ID, PARENT_IDS, GROUP_DICT_NAME, GROUP_DICT_VALUE, GROUP_DICT_TYPE, DESCRIPTION, GROUP_DICT_SORT, GROUP_DICT_STATUS, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, PAUSE, IS_COMPANY_DICT_RELA, EXTEND_01, EXTEND_02, EXTEND_03, EXTEND_04)
values ('fb63225206e25cebe0533c281cac4feb', 'fb63225206e15cebe0533c281cac4feb', 'fb63225206e15cebe0533c281cac4feb', '待审核', '0', 'PREPARATION_STATUS', null, 1, '1', 1, 1, 0, 'CZH', to_date('11-05-2023 10:59:12', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('11-05-2023 10:59:12', 'dd-mm-yyyy hh24:mi:ss'), null, 0, 0, '0', null, null, null, null);

insert into scmdata.sys_group_dict (GROUP_DICT_ID, PARENT_ID, PARENT_IDS, GROUP_DICT_NAME, GROUP_DICT_VALUE, GROUP_DICT_TYPE, DESCRIPTION, GROUP_DICT_SORT, GROUP_DICT_STATUS, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, PAUSE, IS_COMPANY_DICT_RELA, EXTEND_01, EXTEND_02, EXTEND_03, EXTEND_04)
values ('fb63225206e35cebe0533c281cac4feb', 'fb63225206e15cebe0533c281cac4feb', 'fb63225206e15cebe0533c281cac4feb', '待接单', '1', 'PREPARATION_STATUS', null, 2, '1', 1, 1, 0, 'CZH', to_date('11-05-2023 10:59:12', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('11-05-2023 10:59:12', 'dd-mm-yyyy hh24:mi:ss'), null, 0, 0, '0', null, null, null, null);

insert into scmdata.sys_group_dict (GROUP_DICT_ID, PARENT_ID, PARENT_IDS, GROUP_DICT_NAME, GROUP_DICT_VALUE, GROUP_DICT_TYPE, DESCRIPTION, GROUP_DICT_SORT, GROUP_DICT_STATUS, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, PAUSE, IS_COMPANY_DICT_RELA, EXTEND_01, EXTEND_02, EXTEND_03, EXTEND_04)
values ('fb63225206e45cebe0533c281cac4feb', 'fb63225206e15cebe0533c281cac4feb', 'fb63225206e15cebe0533c281cac4feb', '生产中', '2', 'PREPARATION_STATUS', null, 3, '1', 1, 1, 0, 'CZH', to_date('11-05-2023 10:59:12', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('11-05-2023 10:59:12', 'dd-mm-yyyy hh24:mi:ss'), null, 0, 0, '0', null, null, null, null);

insert into scmdata.sys_group_dict (GROUP_DICT_ID, PARENT_ID, PARENT_IDS, GROUP_DICT_NAME, GROUP_DICT_VALUE, GROUP_DICT_TYPE, DESCRIPTION, GROUP_DICT_SORT, GROUP_DICT_STATUS, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, PAUSE, IS_COMPANY_DICT_RELA, EXTEND_01, EXTEND_02, EXTEND_03, EXTEND_04)
values ('fb63225206e55cebe0533c281cac4feb', 'fb63225206e15cebe0533c281cac4feb', 'fb63225206e15cebe0533c281cac4feb', '已完成', '3', 'PREPARATION_STATUS', null, 4, '1', 1, 1, 0, 'CZH', to_date('11-05-2023 10:59:12', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('11-05-2023 10:59:12', 'dd-mm-yyyy hh24:mi:ss'), null, 0, 0, '0', null, null, null, null);

insert into scmdata.sys_group_dict (GROUP_DICT_ID, PARENT_ID, PARENT_IDS, GROUP_DICT_NAME, GROUP_DICT_VALUE, GROUP_DICT_TYPE, DESCRIPTION, GROUP_DICT_SORT, GROUP_DICT_STATUS, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, PAUSE, IS_COMPANY_DICT_RELA, EXTEND_01, EXTEND_02, EXTEND_03, EXTEND_04)
values ('fb63225206e65cebe0533c281cac4feb', 'fb63225206e15cebe0533c281cac4feb', 'fb63225206e15cebe0533c281cac4feb', '已取消', '4', 'PREPARATION_STATUS', null, 5, '1', 1, 1, 0, 'CZH', to_date('11-05-2023 10:59:12', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('11-05-2023 10:59:12', 'dd-mm-yyyy hh24:mi:ss'), null, 0, 0, '0', null, null, null, null);

insert into scmdata.sys_group_dict (GROUP_DICT_ID, PARENT_ID, PARENT_IDS, GROUP_DICT_NAME, GROUP_DICT_VALUE, GROUP_DICT_TYPE, DESCRIPTION, GROUP_DICT_SORT, GROUP_DICT_STATUS, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, PAUSE, IS_COMPANY_DICT_RELA, EXTEND_01, EXTEND_02, EXTEND_03, EXTEND_04)
values ('fb2da420ee884d8de0533c281cac06f4', 'dfbca61982417efde0533c281cacae88', 'dfbca61982417efde0533c281cacae88', '备料单管理', 'PREMATERIAL_MANA_LOG', 'OPERATE_LOG', null, 1, '1', 1, 1, 0, 'cb82c279e43c368ce0533c281cac20cf', to_date('08-05-2023 19:07:14', 'dd-mm-yyyy hh24:mi:ss'), 'cb82c279e43c368ce0533c281cac20cf', to_date('08-05-2023 19:07:14', 'dd-mm-yyyy hh24:mi:ss'), null, 0, 0, '0', null, null, null, null);

insert into scmdata.sys_group_dict (GROUP_DICT_ID, PARENT_ID, PARENT_IDS, GROUP_DICT_NAME, GROUP_DICT_VALUE, GROUP_DICT_TYPE, DESCRIPTION, GROUP_DICT_SORT, GROUP_DICT_STATUS, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, PAUSE, IS_COMPANY_DICT_RELA, EXTEND_01, EXTEND_02, EXTEND_03, EXTEND_04)
values ('fb2da420ee894d8de0533c281cac06f4', 'fb2da420ee884d8de0533c281cac06f4', 'fb2da420ee884d8de0533c281cac06f4', '接单', '00', 'PREMATERIAL_MANA_LOG', null, 1, '1', 1, 1, 0, 'cb82c279e43c368ce0533c281cac20cf', to_date('08-05-2023 19:08:49', 'dd-mm-yyyy hh24:mi:ss'), 'cb82c279e43c368ce0533c281cac20cf', to_date('08-05-2023 19:08:49', 'dd-mm-yyyy hh24:mi:ss'), null, 0, 0, '0', null, null, null, null);

insert into scmdata.sys_group_dict (GROUP_DICT_ID, PARENT_ID, PARENT_IDS, GROUP_DICT_NAME, GROUP_DICT_VALUE, GROUP_DICT_TYPE, DESCRIPTION, GROUP_DICT_SORT, GROUP_DICT_STATUS, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, PAUSE, IS_COMPANY_DICT_RELA, EXTEND_01, EXTEND_02, EXTEND_03, EXTEND_04)
values ('fb2da420ee8a4d8de0533c281cac06f4', 'fb2da420ee884d8de0533c281cac06f4', 'fb2da420ee884d8de0533c281cac06f4', '取消备料单', '01', 'PREMATERIAL_MANA_LOG', null, 2, '1', 1, 1, 0, 'cb82c279e43c368ce0533c281cac20cf', to_date('08-05-2023 19:09:47', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('09-05-2023 17:33:53', 'dd-mm-yyyy hh24:mi:ss'), null, 0, 0, '0', null, null, null, null);

insert into scmdata.sys_group_dict (GROUP_DICT_ID, PARENT_ID, PARENT_IDS, GROUP_DICT_NAME, GROUP_DICT_VALUE, GROUP_DICT_TYPE, DESCRIPTION, GROUP_DICT_SORT, GROUP_DICT_STATUS, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, PAUSE, IS_COMPANY_DICT_RELA, EXTEND_01, EXTEND_02, EXTEND_03, EXTEND_04)
values ('fb2da420ee8b4d8de0533c281cac06f4', 'fb2da420ee884d8de0533c281cac06f4', 'fb2da420ee884d8de0533c281cac06f4', '修改订单数量', '02', 'PREMATERIAL_MANA_LOG', null, 3, '1', 1, 1, 0, 'cb82c279e43c368ce0533c281cac20cf', to_date('08-05-2023 19:10:00', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('09-05-2023 17:33:53', 'dd-mm-yyyy hh24:mi:ss'), null, 0, 0, '0', null, null, null, null);

insert into scmdata.sys_group_dict (GROUP_DICT_ID, PARENT_ID, PARENT_IDS, GROUP_DICT_NAME, GROUP_DICT_VALUE, GROUP_DICT_TYPE, DESCRIPTION, GROUP_DICT_SORT, GROUP_DICT_STATUS, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, PAUSE, IS_COMPANY_DICT_RELA, EXTEND_01, EXTEND_02, EXTEND_03, EXTEND_04)
values ('fb2da420ee8c4d8de0533c281cac06f4', 'fb2da420ee884d8de0533c281cac06f4', 'fb2da420ee884d8de0533c281cac06f4', '修改预计到仓日期', '04', 'PREMATERIAL_MANA_LOG', null, 4, '1', 1, 1, 0, 'cb82c279e43c368ce0533c281cac20cf', to_date('08-05-2023 19:10:18', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('09-05-2023 17:33:53', 'dd-mm-yyyy hh24:mi:ss'), null, 0, 0, '0', null, null, null, null);

insert into scmdata.sys_group_dict (GROUP_DICT_ID, PARENT_ID, PARENT_IDS, GROUP_DICT_NAME, GROUP_DICT_VALUE, GROUP_DICT_TYPE, DESCRIPTION, GROUP_DICT_SORT, GROUP_DICT_STATUS, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, PAUSE, IS_COMPANY_DICT_RELA, EXTEND_01, EXTEND_02, EXTEND_03, EXTEND_04)
values ('fb2da420ee8d4d8de0533c281cac06f4', 'fb2da420ee884d8de0533c281cac06f4', 'fb2da420ee884d8de0533c281cac06f4', '取消订单', '05', 'PREMATERIAL_MANA_LOG', null, 5, '1', 1, 1, 0, 'cb82c279e43c368ce0533c281cac20cf', to_date('08-05-2023 19:10:29', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('09-05-2023 17:33:53', 'dd-mm-yyyy hh24:mi:ss'), null, 0, 0, '0', null, null, null, null);

insert into scmdata.sys_group_dict (GROUP_DICT_ID, PARENT_ID, PARENT_IDS, GROUP_DICT_NAME, GROUP_DICT_VALUE, GROUP_DICT_TYPE, DESCRIPTION, GROUP_DICT_SORT, GROUP_DICT_STATUS, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, PAUSE, IS_COMPANY_DICT_RELA, EXTEND_01, EXTEND_02, EXTEND_03, EXTEND_04)
values ('fb2da420ee8e4d8de0533c281cac06f4', 'fb2da420ee884d8de0533c281cac06f4', 'fb2da420ee884d8de0533c281cac06f4', '完成订单', '06', 'PREMATERIAL_MANA_LOG', null, 6, '1', 1, 1, 0, 'cb82c279e43c368ce0533c281cac20cf', to_date('08-05-2023 19:10:44', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('09-05-2023 17:33:53', 'dd-mm-yyyy hh24:mi:ss'), null, 0, 0, '0', null, null, null, null);

END;
/
