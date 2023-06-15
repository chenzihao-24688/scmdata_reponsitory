CREATE OR REPLACE PACKAGE SCMDATA.pkg_commodity_info IS

  -- Author  : SANFU
  -- Created : 2020/10/13 9:30:27
  -- Purpose : 商品档案业务逻辑

  -- 新增-商品档案
  PROCEDURE insert_commodity_info(p_cinfo_rec scmdata.t_commodity_info%ROWTYPE);

  --更新-商品档案
  PROCEDURE update_commodity_info(p_cinfo_rec scmdata.t_commodity_info%ROWTYPE);
  --校验-商品档案
  PROCEDURE check_commodity_info(p_cinfo_rec scmdata.t_commodity_info%ROWTYPE);
  --生成色码
  PROCEDURE create_comm_color_size(p_commodity_info_id VARCHAR2,
                                   p_company_id        VARCHAR2);
  --删除色码
  PROCEDURE delete_comm_color_size(p_comm_color_size_id VARCHAR2);
  --EXCEL导入 新增工艺单临时数据
  PROCEDURE insert_comm_craft_temp(p_craft_rec scmdata.t_commodity_craft_temp%ROWTYPE);
  --EXCEL导入 修改工艺单临时数据
  PROCEDURE update_comm_craft_temp(p_craft_rec scmdata.t_commodity_craft_temp%ROWTYPE);
  --校验导入数据
  PROCEDURE check_importdatas(p_company_id IN VARCHAR2,
                              p_user_id    IN VARCHAR2);
  --清空导入数据
  PROCEDURE delete_sys_company_user_temp(p_company_id IN VARCHAR2,
                                         p_user_id    IN VARCHAR2);
  --提交导入数据
  PROCEDURE submit_comm_craft_temp(p_company_id IN VARCHAR2,
                                   p_user_id    IN VARCHAR2);
  --新增工艺单
  PROCEDURE insert_comm_craft(p_craft_rec scmdata.t_commodity_craft%ROWTYPE);
  --修改工艺单
  PROCEDURE update_comm_craft(p_craft_rec scmdata.t_commodity_craft%ROWTYPE);
  --删除工艺单
  PROCEDURE delete_comm_craft(p_commodity_craft_id VARCHAR2);

  -- 新增附件
  PROCEDURE insert_commodity_file(p_file_rec scmdata.t_commodity_file%ROWTYPE);

  --修改附件
  PROCEDURE update_commodity_file(p_file_rec scmdata.t_commodity_file%ROWTYPE);

  -- 删除附件
  PROCEDURE delete_commodity_file(p_commodity_file_id VARCHAR2);

  -- 动态同步尺寸中间表t_commodity_size_middle 列值，如：S,M,L
  PROCEDURE sync_commodity_size_middle(p_cinfo_rec scmdata.t_commodity_info%ROWTYPE);
  --新增尺寸表
  PROCEDURE insert_commodity_size(p_csize_rec scmdata.t_commodity_size%ROWTYPE);
  --修改尺寸表
  PROCEDURE update_commodity_size(p_csize_rec  scmdata.t_commodity_size%ROWTYPE,
                                  p_size_name  VARCHAR2,
                                  p_size_value VARCHAR2);
  --同步删除色码
  PROCEDURE sync_delete_comm_color_size(p_commodity_info_id VARCHAR2,
                                        p_company_id        VARCHAR2);

  --同步新增色码
  PROCEDURE sync_insert_comm_color_size(p_commodity_info_id VARCHAR2,
                                        p_company_id        VARCHAR2);
  --删除尺寸表
  PROCEDURE delete_commodity_size(p_csize_rec scmdata.t_commodity_size%ROWTYPE);
  --校验商品档案尺寸表不可修改情况
  FUNCTION check_comm_size(p_company_id VARCHAR2, p_goo_id VARCHAR2)
    RETURN NUMBER;

  --导入
  PROCEDURE check_importdatas_good(p_commodity_info_import_temp_id IN VARCHAR2);
  --导入
  PROCEDURE submit_t_goo_temp(p_company_id IN VARCHAR2,
                              p_user_id    IN VARCHAR2);

  --导入
  PROCEDURE check_importdatas_article(p_commodity_color_size_import_temp_id IN VARCHAR2);

  PROCEDURE submit_t_article_temp(p_company_id IN VARCHAR2,
                                  p_user_id    IN VARCHAR2);

  PROCEDURE check_importdatas_compostion(p_import_temp_id IN VARCHAR2);

  PROCEDURE submit_t_compostion_temp(p_company_id IN VARCHAR2,
                                     p_user_id    IN VARCHAR2);
END pkg_commodity_info;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_commodity_info IS

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:30:08
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  新增-商品档案
  * Obj_Name    : UPDATE_COMMODITY_INFO
  * Arg_Number  : 1
  * P_CINFO_REC :商品档案记录
  *============================================*/

  PROCEDURE insert_commodity_info(p_cinfo_rec scmdata.t_commodity_info%ROWTYPE) IS
  
  BEGIN
    --1）校验数据
    check_commodity_info(p_cinfo_rec);
  
    --2）新增数据
    INSERT INTO t_commodity_info
      (commodity_info_id,
       company_id,
       origin,
       style_pic,
       supplier_code,
       goo_id,
       rela_goo_id,
       style_name,
       style_number,
       category,
       samll_category,
       YEAR,
       season,
       base_size,
       inprice,
       price,
       color_list,
       size_list,
       create_id,
       create_time,
       update_id,
       update_time,
       remarks,
       sup_style_number,
       product_cate,
       goo_name,
       EXECUTIVE_STD)
    VALUES
      (p_cinfo_rec.commodity_info_id,
       p_cinfo_rec.company_id,
       p_cinfo_rec.origin,
       p_cinfo_rec.style_pic,
       p_cinfo_rec.supplier_code,
       p_cinfo_rec.goo_id,
       p_cinfo_rec.rela_goo_id,
       p_cinfo_rec.style_name,
       p_cinfo_rec.style_number,
       p_cinfo_rec.category,
       p_cinfo_rec.samll_category,
       p_cinfo_rec.year,
       p_cinfo_rec.season,
       p_cinfo_rec.base_size,
       p_cinfo_rec.inprice,
       p_cinfo_rec.price,
       p_cinfo_rec.color_list,
       p_cinfo_rec.size_list,
       p_cinfo_rec.create_id,
       p_cinfo_rec.create_time,
       p_cinfo_rec.update_id,
       p_cinfo_rec.update_time,
       p_cinfo_rec.remarks,
       p_cinfo_rec.sup_style_number,
       p_cinfo_rec.product_cate,
       p_cinfo_rec.goo_name,
       p_cinfo_rec.executive_std);
    COMMIT;
  
    --3)动态同步色码表
    create_comm_color_size(p_commodity_info_id => p_cinfo_rec.commodity_info_id,
                           p_company_id        => p_cinfo_rec.company_id);
  
    --4）动态同步尺寸中间表t_commodity_size_middle 列值，如：S,M,L
    sync_commodity_size_middle(p_cinfo_rec => p_cinfo_rec);
  
  END insert_commodity_info;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:30:08
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  更新-商品档案
  * Obj_Name    : UPDATE_COMMODITY_INFO
  * Arg_Number  : 1
  * P_CINFO_REC :商品档案记录
  *============================================*/

  PROCEDURE update_commodity_info(p_cinfo_rec scmdata.t_commodity_info%ROWTYPE) IS
  
  BEGIN
    --1）校验数据
    check_commodity_info(p_cinfo_rec);
  
    --2）更新数据
    UPDATE scmdata.t_commodity_info
       SET style_pic      = p_cinfo_rec.style_pic,
           supplier_code  = p_cinfo_rec.supplier_code,
           style_number   = p_cinfo_rec.style_number,
           category       = p_cinfo_rec.category,
           samll_category = p_cinfo_rec.samll_category,
           style_name     = p_cinfo_rec.style_name,
           YEAR           = p_cinfo_rec.year,
           season         = p_cinfo_rec.season,
           color_list     = p_cinfo_rec.color_list,
           size_list      = p_cinfo_rec.size_list,
           base_size      = p_cinfo_rec.base_size,
           inprice        = p_cinfo_rec.inprice,
           price          = p_cinfo_rec.price,
           update_time    = p_cinfo_rec.update_time,
           update_id      = p_cinfo_rec.update_id,
           goo_name       = p_cinfo_rec.goo_name,
           EXECUTIVE_STD  = p_cinfo_rec.executive_std
     WHERE commodity_info_id = p_cinfo_rec.commodity_info_id
       AND company_id = p_cinfo_rec.company_id;
  
    --3)动态同步色码表
    create_comm_color_size(p_commodity_info_id => p_cinfo_rec.commodity_info_id,
                           p_company_id        => p_cinfo_rec.company_id);
  
    --4）动态同步尺寸中间表t_commodity_size_middle 列值，如：S,M,L
    sync_commodity_size_middle(p_cinfo_rec => p_cinfo_rec);
  
  END update_commodity_info;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:31:55
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  校验-商品档案
  * Obj_Name    : CHECK_COMMODITY_INFO
  * Arg_Number  : 1
  * P_CINFO_REC :商品档案记录
  *============================================*/

  PROCEDURE check_commodity_info(p_cinfo_rec scmdata.t_commodity_info%ROWTYPE) IS
    v_snum_flag    NUMBER;
    v_ssnum_flag   NUMBER;
    v_color_list   VARCHAR2(1000);
    v_size_list    VARCHAR2(1000);
    v_company_name VARCHAR2(100);
  BEGIN
  
    SELECT fc.logn_name
      INTO v_company_name
      FROM scmdata.sys_company fc
     WHERE fc.company_id = p_cinfo_rec.company_id;
  
    --校验款号 唯一性
    SELECT COUNT(1)
      INTO v_snum_flag
      FROM scmdata.t_commodity_info t
     WHERE t.company_id = p_cinfo_rec.company_id
       AND t.commodity_info_id <> p_cinfo_rec.commodity_info_id
       AND t.style_number = p_cinfo_rec.style_number;
  
    IF v_snum_flag > 0 THEN
      raise_application_error(-20002,
                              v_company_name || ',该企业款号不唯一，请重新确认！');
    END IF;
    --校验供应商款号唯一性
    SELECT COUNT(1)
      INTO v_ssnum_flag
      FROM scmdata.t_commodity_info t
     WHERE t.company_id = p_cinfo_rec.company_id
       AND t.commodity_info_id <> p_cinfo_rec.commodity_info_id
       AND t.sup_style_number = p_cinfo_rec.sup_style_number;
  
    IF v_ssnum_flag > 0 THEN
      raise_application_error(-20002,
                              v_company_name || ',该企业供应商款号不唯一，请重新确认！');
    END IF;
    IF p_cinfo_rec.origin <> 'MA' THEN
      --校验色码组是否为空
      SELECT t.color_list, t.size_list
        INTO v_color_list, v_size_list
        FROM scmdata.t_commodity_info t
       WHERE t.company_id = p_cinfo_rec.company_id
         AND t.commodity_info_id = p_cinfo_rec.commodity_info_id;
    
      IF v_color_list IS NULL OR v_size_list IS NULL THEN
        raise_application_error(-20002,
                                '颜色或者尺码不能为空，请重新确认并填写！');
      END IF;
    END IF;
  END check_commodity_info;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:34:09
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 生成色码
  * Obj_Name    : CREATE_COMM_COLOR_SIZE
  * Arg_Number  : 2
  * P_COMMODITY_INFO_ID : 商品档案ID
  * P_COMPANY_ID : 企业ID
  *============================================*/

  PROCEDURE create_comm_color_size(p_commodity_info_id VARCHAR2,
                                   p_company_id        VARCHAR2) IS
  
  BEGIN
  
    --1)同步删除色码
    sync_delete_comm_color_size(p_commodity_info_id => p_commodity_info_id,
                                p_company_id        => p_company_id);
  
    --2)同步新增色码
    sync_insert_comm_color_size(p_commodity_info_id => p_commodity_info_id,
                                p_company_id        => p_company_id);
  END create_comm_color_size;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:34:53
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  删除色码
  * Obj_Name    : DELETE_COMM_COLOR_SIZE
  * Arg_Number  : 1
  * P_COMM_COLOR_SIZE_ID : 色码表ID
  *============================================*/

  PROCEDURE delete_comm_color_size(p_comm_color_size_id VARCHAR2) IS
  BEGIN
    DELETE FROM scmdata.t_commodity_color_size t
     WHERE t.commodity_color_size_id = p_comm_color_size_id;
  EXCEPTION
    WHEN OTHERS THEN
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => '删除色码出错，请联系管理员！',
                                               p_is_running_error => 'T');
  END;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:35:35
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 同步删除色码
  * Obj_Name    : SYNC_DELETE_COMM_COLOR_SIZE
  * Arg_Number  : 2
  * P_COMMODITY_INFO_ID :
  * P_COMPANY_ID :
  *============================================*/

  PROCEDURE sync_delete_comm_color_size(p_commodity_info_id VARCHAR2,
                                        p_company_id        VARCHAR2) IS
  BEGIN
  
    --生成色码表之前,删除商品档案色码操作
    --如果商品档案删除某一颜色时，在色码表须同步删除该颜色。   待封装成过程
    DELETE FROM scmdata.t_commodity_color_size t
     WHERE t.commodity_info_id = p_commodity_info_id
       AND t.company_id = p_company_id
       AND t.color_code NOT IN
           (SELECT regexp_substr(v.color_list, '[^;]+', 1, LEVEL) color
              FROM (SELECT tc.color_list
                      FROM scmdata.t_commodity_info tc
                     WHERE tc.commodity_info_id = p_commodity_info_id
                       AND tc.company_id = p_company_id) v
            CONNECT BY LEVEL <= regexp_count(v.color_list, '[^;]+'));
  
    --如果商品档案删除某一尺码时，在色码表须同步删除各颜色下的尺码。
    DELETE FROM scmdata.t_commodity_color_size t
     WHERE t.commodity_info_id = p_commodity_info_id
       AND t.company_id = p_company_id
       AND t.sizecode NOT IN
           (SELECT regexp_substr(v.size_list, '[^;]+', 1, LEVEL) size_gd
              FROM (SELECT tc.size_list
                      FROM scmdata.t_commodity_info tc
                     WHERE tc.commodity_info_id = p_commodity_info_id
                       AND tc.company_id = p_company_id) v
            CONNECT BY LEVEL <= regexp_count(v.size_list, '[^;]+'));
  
  END sync_delete_comm_color_size;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:36:50
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 同步新增色码
  * Obj_Name    : SYNC_INSERT_COMM_COLOR_SIZE
  * Arg_Number  : 2
  * P_COMMODITY_INFO_ID :商品档案ID
  * P_COMPANY_ID : 企业ID
  *============================================*/

  PROCEDURE sync_insert_comm_color_size(p_commodity_info_id VARCHAR2,
                                        p_company_id        VARCHAR2) IS
    v_color_flag NUMBER;
    v_size_flag  NUMBER;
    v_goo_id     VARCHAR2(100); --货号
    v_bar_code   VARCHAR2(100); --条码
    v_colorname  VARCHAR2(100);
    v_sizename   VARCHAR2(100);
    --1）来源：商品档案基本信息 颜色组                              
    CURSOR color_data IS
      SELECT regexp_substr(v.color_list, '[^;]+', 1, LEVEL) color
        FROM (SELECT tc.color_list
                FROM scmdata.t_commodity_info tc
               WHERE tc.commodity_info_id = p_commodity_info_id
                 AND tc.company_id = p_company_id) v
      CONNECT BY LEVEL <= regexp_count(v.color_list, '[^;]+');
    --2）来源：商品档案基本信息 尺码组 
    CURSOR size_data IS
      SELECT regexp_substr(v.size_list, '[^;]+', 1, LEVEL) size_gd
        FROM (SELECT tc.size_list
                FROM scmdata.t_commodity_info tc
               WHERE tc.commodity_info_id = p_commodity_info_id
                 AND tc.company_id = p_company_id) v
      CONNECT BY LEVEL <= regexp_count(v.size_list, '[^;]+');
  BEGIN
  
    --获取货号
    SELECT tc.goo_id
      INTO v_goo_id
      FROM scmdata.t_commodity_info tc
     WHERE tc.commodity_info_id = p_commodity_info_id
       AND tc.company_id = p_company_id;
  
    --3）生成色码表之前,新增商品档案色码操作
    --如果商品档案新增某一颜色时，在色码表须同步新增该颜色。
    FOR color_rec IN color_data LOOP
    
      SELECT COUNT(1)
        INTO v_color_flag
        FROM scmdata.t_commodity_color_size t
       WHERE t.commodity_info_id = p_commodity_info_id
         AND t.company_id = p_company_id
         AND t.color_code = color_rec.color;
    
      IF v_color_flag = 0 THEN
        --获取颜色名称    
        SELECT t1.company_dict_name
          INTO v_colorname
          FROM scmdata.sys_company_dict t, scmdata.sys_company_dict t1
         WHERE t.company_id = p_company_id
           AND t.company_id = t1.company_id
           AND t.company_dict_type = 'GD_COLOR_LIST'
           AND t.company_dict_value = t1.company_dict_type
           AND t1.company_dict_value = color_rec.color
           AND t.pause = 0
           AND t1.pause = 0;
      
        FOR size_rec IN size_data LOOP
          --条码  原规则：货号+颜色编号+尺码编号   现规则：货号+企业级唯一6位（需修改）
          v_bar_code := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => 't_commodity_color_size',
                                                           pi_column_name => 'barcode',
                                                           pi_company_id  => p_company_id,
                                                           pi_pre         => v_goo_id,
                                                           pi_serail_num  => 6);
          --获取尺码名称       
          SELECT max(t1.company_dict_name)
            INTO v_sizename
            FROM scmdata.sys_company_dict t, scmdata.sys_company_dict t1
           WHERE t.company_id = p_company_id
             AND t.company_id = t1.company_id
             AND t.company_dict_type = 'GD_SIZE_LIST'
             AND t.company_dict_value = t1.company_dict_type
             AND t1.company_dict_value = size_rec.size_gd
             AND t.pause = 0
             AND t1.pause = 0;
        
          --按颜色组，色码组插入到色码表
          INSERT INTO scmdata.t_commodity_color_size
            (commodity_color_size_id,
             commodity_info_id,
             company_id,
             goo_id,
             barcode,
             color_code,
             colorname,
             sizecode,
             sizename)
          VALUES
            (scmdata.f_get_uuid(),
             p_commodity_info_id,
             p_company_id,
             v_goo_id,
             v_bar_code,
             color_rec.color,
             v_colorname,
             size_rec.size_gd,
             v_sizename);
        
        END LOOP;
      ELSE
        NULL;
      END IF;
    
    END LOOP;
  
    --4)如果商品档案新增某一尺码时，在色码表须同步新增各颜色下的尺码。
  
    FOR size_rec IN size_data LOOP
    
      SELECT COUNT(1)
        INTO v_size_flag
        FROM scmdata.t_commodity_color_size t
       WHERE t.commodity_info_id = p_commodity_info_id
         AND t.company_id = p_company_id
         AND t.sizecode = size_rec.size_gd;
    
      IF v_size_flag = 0 THEN
        --获取尺码名称
        SELECT max(gd.company_dict_name)
          INTO v_sizename
          FROM scmdata.sys_company_dict gd
         WHERE gd.company_dict_value = size_rec.size_gd
           and gd.company_id = p_company_id;
        FOR color_rec IN color_data LOOP
          --获取颜色名称
          SELECT gd.company_dict_name
            INTO v_colorname
            FROM scmdata.sys_company_dict gd
           WHERE gd.company_dict_value = color_rec.color
             and gd.company_id = p_company_id;
          --条码  原规则：货号+颜色编号+尺码编号   现规则：货号+企业级唯一6位（需修改）
          v_bar_code := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => 't_commodity_color_size',
                                                           pi_column_name => 'barcode',
                                                           pi_company_id  => p_company_id,
                                                           pi_pre         => v_goo_id,
                                                           pi_serail_num  => 6);
          --按颜色组，色码组插入到色码表
          INSERT INTO scmdata.t_commodity_color_size
            (commodity_color_size_id,
             commodity_info_id,
             company_id,
             goo_id,
             barcode,
             color_code,
             colorname,
             sizecode,
             sizename)
          VALUES
            (scmdata.f_get_uuid(),
             p_commodity_info_id,
             p_company_id,
             v_goo_id,
             v_bar_code,
             color_rec.color,
             v_colorname,
             size_rec.size_gd,
             v_sizename);
        
        END LOOP;
      ELSE
        NULL;
      END IF;
    
    END LOOP;
  END sync_insert_comm_color_size;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:38:28
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  EXCEL导入 新增工艺单临时数据
  * Obj_Name    : INSERT_COMM_CRAFT_TEMP
  * Arg_Number  : 1
  * P_CRAFT_REC :临时数据
  *============================================*/

  PROCEDURE insert_comm_craft_temp(p_craft_rec scmdata.t_commodity_craft_temp%ROWTYPE) IS
  BEGIN
  
    INSERT INTO scmdata.t_commodity_craft_temp
      (commodity_craft_id,
       company_id,
       user_id,
       commodity_info_id,
       craft_type,
       part,
       process_description,
       remarks,
       goo_id)
    VALUES
      (p_craft_rec.commodity_craft_id,
       p_craft_rec.company_id,
       p_craft_rec.user_id,
       p_craft_rec.commodity_info_id,
       p_craft_rec.craft_type,
       p_craft_rec.part,
       p_craft_rec.process_description,
       p_craft_rec.remarks,
       p_craft_rec.goo_id);
  
    --导入后校验数据
    check_importdatas(p_company_id => p_craft_rec.company_id,
                      p_user_id    => p_craft_rec.user_id);
  EXCEPTION
    WHEN OTHERS THEN
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => 'EXCEL导入工艺单出错，请联系管理员！',
                                               p_is_running_error => 'T');
  END insert_comm_craft_temp;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:38:28
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  EXCEL导入 修改工艺单临时数据
  * Obj_Name    : update_comm_craft_temp
  * Arg_Number  : 1
  * P_CRAFT_REC :临时数据
  *============================================*/
  PROCEDURE update_comm_craft_temp(p_craft_rec scmdata.t_commodity_craft_temp%ROWTYPE) IS
  BEGIN
  
    UPDATE scmdata.t_commodity_craft_temp t
       SET t.craft_type          = p_craft_rec.craft_type,
           t.part                = p_craft_rec.part,
           t.process_description = p_craft_rec.process_description
     WHERE t.commodity_craft_id = p_craft_rec.commodity_craft_id;
  
    --导入后校验数据
    check_importdatas(p_company_id => p_craft_rec.company_id,
                      p_user_id    => p_craft_rec.user_id);
  EXCEPTION
    WHEN OTHERS THEN
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => 'EXCEL导入数据，修改工艺单出错，请联系管理员！',
                                               p_is_running_error => 'T');
  END update_comm_craft_temp;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:38:28
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  EXCEL导入 提交工艺单 将临时数据提交到业务表中
  * Obj_Name    : submit_comm_craft_temp
  * Arg_Number  : 2
  * p_company_id :企业ID
  * p_user_id ：用户ID
  *============================================*/
  PROCEDURE submit_comm_craft_temp(p_company_id IN VARCHAR2,
                                   p_user_id    IN VARCHAR2) IS
    --校验信息                               
    CURSOR msg_cur IS
      SELECT t.commodity_craft_id, t.err_msg_id, m.msg_type
        FROM scmdata.t_commodity_craft_temp t
        LEFT JOIN scmdata.t_commodity_craft_import_msg m
          ON t.err_msg_id = m.msg_id
       WHERE t.company_id = p_company_id
         AND t.user_id = p_user_id;
    --临时数据
    CURSOR import_data_cur IS
      SELECT scmdata.f_get_uuid() commodity_craft_id,
             t.company_id,
             t.commodity_info_id,
             p.group_dict_value craft_type,
             t.part,
             t.process_description,
             t.remarks,
             t.goo_id,
             t.user_id create_id,
             SYSDATE create_time,
             t.user_id update_id,
             SYSDATE update_time
        FROM scmdata.t_commodity_craft_temp t, scmdata.sys_group_dict p
       WHERE t.company_id = p_company_id
         AND t.user_id = p_user_id
         AND p.group_dict_type = 'GD_CRAFT_TYPE'
         AND p.group_dict_name = t.craft_type;
  
  BEGIN
    --判断数据是否都校验成功，只有都校验成功了，才能进行提交
    FOR data_rec IN msg_cur LOOP
      IF data_rec.msg_type = 'E' OR data_rec.msg_type IS NULL THEN
        raise_application_error(-20002,
                                '请检查数据是否都已检验成功，修改正确后再提交!');
      END IF;
    END LOOP;
    FOR p_craft_rec IN import_data_cur LOOP
      --将临时表数据正式导入到业务表中
      scmdata.pkg_commodity_info.insert_comm_craft(p_craft_rec => p_craft_rec);
    
    END LOOP;
  
    --最后清空临时表数据以及导入信息表的数据
    delete_sys_company_user_temp(p_company_id => p_company_id,
                                 p_user_id    => p_user_id);
  END submit_comm_craft_temp;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:42:18
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 校验导入数据
  * Obj_Name    : CHECK_IMPORTDATAS
  * Arg_Number  : 2
  * P_COMPANY_ID :企业ID
  * P_USER_ID :用户ID
  *============================================*/

  PROCEDURE check_importdatas(p_company_id IN VARCHAR2,
                              p_user_id    IN VARCHAR2) IS
  
    v_num         NUMBER := 0;
    v_err_num     NUMBER := 0;
    v_msg_id      NUMBER;
    v_msg         VARCHAR2(2000);
    v_import_flag VARCHAR2(100);
    --导入的临时数据
    CURSOR importdatas IS
      SELECT t.commodity_craft_id,
             t.company_id,
             t.commodity_info_id,
             t.craft_type,
             t.part,
             t.process_description,
             t.remarks,
             t.goo_id,
             t.user_id
        FROM scmdata.t_commodity_craft_temp t
       WHERE t.company_id = p_company_id
         AND t.user_id = p_user_id;
  BEGIN
    FOR data_rec IN importdatas LOOP
      IF data_rec.craft_type IS NULL THEN
        v_err_num := v_err_num + 1;
        v_msg     := v_err_num || '.工艺单类型不能为空！';
      END IF;
    
      IF data_rec.part IS NULL THEN
        v_err_num := v_err_num + 1;
        v_msg     := v_msg || v_err_num || '.部位不能为空！';
      
      END IF;
    
      IF data_rec.process_description IS NULL THEN
        v_err_num := v_err_num + 1;
        v_msg     := v_msg || v_err_num || '.工艺描述不能为空！';
      END IF;
    
      --工艺单类型
      SELECT COUNT(1)
        INTO v_num
        FROM scmdata.sys_group_dict p
       WHERE p.group_dict_type = 'GD_CRAFT_TYPE'
         AND p.group_dict_name = data_rec.craft_type;
    
      IF v_num = 0 THEN
        v_err_num := v_err_num + 1;
        v_msg     := v_msg || v_err_num || '.工艺单类型:[' ||
                     data_rec.craft_type || ']在数据字典中不存在，请填写正确的工艺单类型！';
      
      END IF;
    
      --将校验信息插入到导入信息表
      v_msg_id := scmdata.t_commodity_craft_import_msg_s.nextval;
    
      UPDATE scmdata.t_commodity_craft_temp t
         SET t.err_msg_id = v_msg_id
       WHERE t.company_id = data_rec.company_id
         AND t.user_id = data_rec.user_id
         AND t.commodity_craft_id = data_rec.commodity_craft_id;
    
      IF v_err_num > 0 THEN
        v_import_flag := '校验错误：共' || v_err_num || '处错误。';
        INSERT INTO scmdata.t_commodity_craft_import_msg
        VALUES
          (v_msg_id,
           'E',
           v_import_flag || v_msg,
           SYSDATE,
           data_rec.company_id,
           data_rec.user_id);
        --清空错误记录
        v_num     := 0;
        v_err_num := 0;
        v_msg     := NULL;
      ELSE
        v_import_flag := '校验成功';
        INSERT INTO scmdata.t_commodity_craft_import_msg
        VALUES
          (v_msg_id,
           'Y',
           v_import_flag,
           SYSDATE,
           data_rec.company_id,
           data_rec.user_id);
      END IF;
    
    END LOOP;
  
  END check_importdatas;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:43:35
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 清空导入数据
  * Obj_Name    : DELETE_SYS_COMPANY_USER_TEMP
  * Arg_Number  : 2
  * P_COMPANY_ID :企业ID
  * P_USER_ID : 用户ID
  *============================================*/
  PROCEDURE delete_sys_company_user_temp(p_company_id IN VARCHAR2,
                                         p_user_id    IN VARCHAR2) IS
  
  BEGIN
    --清空临时表，导入信息表的数据
    DELETE FROM scmdata.t_commodity_craft_import_msg m
     WHERE m.company_id = p_company_id
       AND m.user_id = p_user_id;
  
    DELETE FROM scmdata.t_commodity_craft_temp t
     WHERE t.company_id = p_company_id
       AND t.user_id = p_user_id;
  
  END delete_sys_company_user_temp;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:44:10
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 新增工艺单
  * Obj_Name    : INSERT_COMM_CRAFT
  * Arg_Number  : 1
  * P_CRAFT_REC :工艺单
  *============================================*/

  PROCEDURE insert_comm_craft(p_craft_rec scmdata.t_commodity_craft%ROWTYPE) IS
  BEGIN
    INSERT INTO scmdata.t_commodity_craft
      (commodity_craft_id,
       company_id,
       commodity_info_id,
       craft_type,
       part,
       process_description,
       remarks,
       goo_id,
       create_id,
       create_time,
       update_id,
       update_time)
    VALUES
      (p_craft_rec.commodity_craft_id,
       p_craft_rec.company_id,
       p_craft_rec.commodity_info_id,
       p_craft_rec.craft_type,
       p_craft_rec.part,
       p_craft_rec.process_description,
       p_craft_rec.remarks,
       p_craft_rec.goo_id,
       p_craft_rec.create_id,
       p_craft_rec.create_time,
       p_craft_rec.update_id,
       p_craft_rec.update_time);
  EXCEPTION
    WHEN OTHERS THEN
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => '新增工艺单出错，请联系管理员！',
                                               p_is_running_error => 'T');
  END;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:44:10
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 修改工艺单
  * Obj_Name    : update_comm_craft
  * Arg_Number  : 1
  * P_CRAFT_REC :工艺单
  *============================================*/
  PROCEDURE update_comm_craft(p_craft_rec scmdata.t_commodity_craft%ROWTYPE) IS
  BEGIN
    UPDATE scmdata.t_commodity_craft t
       SET t.craft_type          = p_craft_rec.craft_type,
           t.part                = p_craft_rec.part,
           t.update_id           = p_craft_rec.update_id,
           t.update_time         = p_craft_rec.update_time,
           t.process_description = p_craft_rec.process_description
     WHERE t.commodity_craft_id = p_craft_rec.commodity_craft_id;
  EXCEPTION
    WHEN OTHERS THEN
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => '修改工艺单出错，请联系管理员！',
                                               p_is_running_error => 'T');
  END update_comm_craft;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:44:10
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 删除工艺单
  * Obj_Name    : update_comm_craft
  * Arg_Number  : 1
  * p_commodity_craft_id :工艺单ID
  *============================================*/
  PROCEDURE delete_comm_craft(p_commodity_craft_id VARCHAR2) IS
  BEGIN
    DELETE FROM scmdata.t_commodity_craft t
     WHERE t.commodity_craft_id = p_commodity_craft_id;
  EXCEPTION
    WHEN OTHERS THEN
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => '删除工艺单出错，请联系管理员！',
                                               p_is_running_error => 'T');
  END delete_comm_craft;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:45:23
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 新增附件
  * Obj_Name    : INSERT_COMMODITY_FILE
  * Arg_Number  : 1
  * P_FILE_REC : 附件
  *============================================*/

  PROCEDURE insert_commodity_file(p_file_rec scmdata.t_commodity_file%ROWTYPE) IS
    p_i int;
  BEGIN
    if p_file_rec.file_type = '01' and p_file_rec.picture_id is null then
      -- raise need_picture;
      raise_application_error(-20002, '尺寸表需要上传图片');
    end if;
    if p_file_rec.file_type <> '01' and p_file_rec.picture_id is null and
       p_file_rec.file_id is null then
      -- raise need_file;
      raise_application_error(-20002, '请上传一个附件或图片');
    end if;
    if p_file_rec.file_type in ('01', '02') then
      select nvl(max(1), 0)
        into p_i
        from scmdata.t_commodity_file a
       where a.file_type = p_file_rec.file_type
         and a.commodity_info_id = p_file_rec.commodity_info_id;
      if p_i = 1 and p_file_rec.file_type = '01' then
        raise_application_error(-20002,
                                '已存在尺寸表类型，如有更新请点击编辑进行修改');
      end if;
      if p_i = 1 and p_file_rec.file_type = '02' then
        raise_application_error(-20002,
                                '已存在工艺单类型，如有更新请点击编辑进行修改');
      end if;
    end if;
  
    INSERT INTO scmdata.t_commodity_file
      (commodity_file_id,
       commodity_info_id,
       company_id,
       file_type,
       file_id,
       picture_id,
       create_id,
       create_time,
       goo_id,
       update_id,
       update_time)
    VALUES
      (scmdata.f_get_uuid(),
       p_file_rec.commodity_info_id,
       p_file_rec.company_id,
       p_file_rec.file_type,
       p_file_rec.file_id,
       p_file_rec.picture_id,
       p_file_rec.create_id,
       p_file_rec.create_time,
       p_file_rec.goo_id,
       p_file_rec.update_id,
       p_file_rec.update_time);
    /*  EXCEPTION
    when need_picture then
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => '尺寸表需要上传图片',
                                               p_is_running_error => 'P');
    when need_file then
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => '请上传一个附件或图片',
                                               p_is_running_error => 'P');
    WHEN OTHERS THEN
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => '新增附件出错，请联系管理员！',
                                               p_is_running_error => 'T');*/
  END insert_commodity_file;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:45:23
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 修改附件
  * Obj_Name    : INSERT_COMMODITY_FILE
  * Arg_Number  : 1
  * P_FILE_REC : 附件
  *============================================*/
  PROCEDURE update_commodity_file(p_file_rec scmdata.t_commodity_file%ROWTYPE) IS
    -- need_picture exception;
    -- need_file    exception;
    p_i int;
  BEGIN
  
    if p_file_rec.file_type = '01' and p_file_rec.picture_id is null then
      -- raise need_picture;
      raise_application_error(-20002, '尺寸表需要上传图片');
    end if;
    if p_file_rec.file_type <> '01' and p_file_rec.picture_id is null and
       p_file_rec.file_id is null then
      -- raise need_file;
      raise_application_error(-20002, '请上传一个附件或图片');
    end if;
    if p_file_rec.file_type in ('01', '02') then
      select nvl(max(1), 0)
        into p_i
        from scmdata.t_commodity_file a
       where a.file_type = p_file_rec.file_type
         and a.commodity_info_id =
             (select commodity_info_id
                from scmdata.t_commodity_file
               where commodity_file_id = p_file_rec.commodity_file_id)
         and a.commodity_file_id <> p_file_rec.commodity_file_id;
      if p_i = 1 and p_file_rec.file_type = '01' then
        raise_application_error(-20002,
                                '已存在尺寸表类型，如有更新请对已有的尺寸表进行编辑');
      end if;
      if p_i = 1 and p_file_rec.file_type = '02' then
        raise_application_error(-20002,
                                '已存在工艺单类型，如有更新请对已有的工艺单进行编辑');
      end if;
    end if;
    UPDATE scmdata.t_commodity_file t
       SET t.file_type   = p_file_rec.file_type,
           t.file_id     = p_file_rec.file_id,
           t.picture_id  = p_file_rec.picture_id,
           t.update_id   = p_file_rec.update_id,
           t.update_time = p_file_rec.update_time
     WHERE t.commodity_file_id = p_file_rec.commodity_file_id;
    /* EXCEPTION
    when need_picture then
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => '尺寸表需要上传图片',
                                               p_is_running_error => 'P');
    when need_file then
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => '请上传一个附件或图片',
                                               p_is_running_error => 'P');
    WHEN OTHERS THEN
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => '修改附件出错，请联系管理员！',
                                               p_is_running_error => 'T');*/
  END update_commodity_file;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:45:23
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 删除附件
  * Obj_Name    : INSERT_COMMODITY_FILE
  * Arg_Number  : 1
  * p_commodity_file_id : 附件ID
  *============================================*/
  PROCEDURE delete_commodity_file(p_commodity_file_id VARCHAR2) IS
  BEGIN
    DELETE FROM scmdata.t_commodity_file t
     WHERE t.commodity_file_id = p_commodity_file_id;
  EXCEPTION
    WHEN OTHERS THEN
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => '删除附件出错，请联系管理员！',
                                               p_is_running_error => 'T');
  END delete_commodity_file;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:46:28
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 动态同步尺寸中间表t_commodity_size_middle 列值，如：S,M,L
  * Obj_Name    : SYNC_COMMODITY_SIZE_MIDDLE
  * Arg_Number  : 1
  * P_CINFO_REC :商品档案
  *============================================*/

  PROCEDURE sync_commodity_size_middle(p_cinfo_rec scmdata.t_commodity_info%ROWTYPE) IS
  
    v_flag NUMBER; --判断部位表是否有数据
    --获取部位表
    CURSOR comm_size_data IS
      SELECT *
        FROM scmdata.t_commodity_size tc
       WHERE tc.commodity_info_id = p_cinfo_rec.commodity_info_id
         AND tc.company_id = p_cinfo_rec.company_id;
  
    --拆分尺码组
    CURSOR size_data IS
      SELECT regexp_substr(v.size_list, '[^;]+', 1, LEVEL) size_gd
        FROM (SELECT tc.size_list
                FROM scmdata.t_commodity_info tc
               WHERE tc.commodity_info_id = p_cinfo_rec.commodity_info_id
                 AND tc.company_id = p_cinfo_rec.company_id) v
      CONNECT BY LEVEL <= regexp_count(v.size_list, '[^;]+');
  
    v_csize_rec scmdata.t_commodity_size%ROWTYPE;
    v_goo_id    VARCHAR2(100);
    v_size_flag NUMBER;
  BEGIN
  
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_commodity_size tc
     WHERE tc.commodity_info_id = p_cinfo_rec.commodity_info_id
       AND tc.company_id = p_cinfo_rec.company_id;
    --1）如果部位表不存在，则新增默认数据
    IF v_flag = 0 THEN
      SELECT t.goo_id
        INTO v_goo_id
        FROM scmdata.t_commodity_info t
       WHERE t.company_id = p_cinfo_rec.company_id
         AND t.commodity_info_id = p_cinfo_rec.commodity_info_id;
    
      v_csize_rec.commodity_info_id   := p_cinfo_rec.commodity_info_id;
      v_csize_rec.company_id          := p_cinfo_rec.company_id;
      v_csize_rec.position            := '请修改';
      v_csize_rec.measurement_methods := '请修改';
      v_csize_rec.std_size            := '0';
      v_csize_rec.tolerance_upper     := '0';
      v_csize_rec.tolerance_lower     := '0';
      v_csize_rec.goo_id              := v_goo_id;
    
      scmdata.pkg_commodity_info.insert_commodity_size(p_csize_rec => v_csize_rec);
    END IF;
  
    --2）如果部位表存在，则同步尺寸中间表，删除(S,M,L => S,M)，新增(S,M => S,M,L)
    --2.1）删除尺码
    DELETE FROM scmdata.t_commodity_size_middle t
     WHERE t.company_id = p_cinfo_rec.company_id
       AND t.commodity_info_id = p_cinfo_rec.commodity_info_id
       AND t.size_code NOT IN
           (SELECT regexp_substr(v.size_list, '[^;]+', 1, LEVEL) size_gd
              FROM (SELECT tc.size_list
                      FROM scmdata.t_commodity_info tc
                     WHERE tc.commodity_info_id =
                           p_cinfo_rec.commodity_info_id
                       AND tc.company_id = p_cinfo_rec.company_id) v
            CONNECT BY LEVEL <= regexp_count(v.size_list, '[^;]+'));
  
    --2.2）新增尺码
  
    FOR comm_size_rec IN comm_size_data LOOP
      FOR size_rec IN size_data LOOP
        SELECT COUNT(1)
          INTO v_size_flag
          FROM scmdata.t_commodity_size_middle tc
         WHERE tc.company_id = comm_size_rec.company_id
           AND tc.commodity_info_id = comm_size_rec.commodity_info_id
           AND tc.commodity_size_id = comm_size_rec.commodity_size_id
           AND tc.size_code = size_rec.size_gd;
      
        IF v_size_flag = 0 THEN
          INSERT INTO scmdata.t_commodity_size_middle
            (commodity_size_middle_id,
             commodity_info_id,
             company_id,
             commodity_size_id,
             size_code,
             size_name,
             size_value)
          VALUES
            (scmdata.f_get_uuid(),
             comm_size_rec.commodity_info_id,
             comm_size_rec.company_id,
             comm_size_rec.commodity_size_id,
             size_rec.size_gd,
             (SELECT gd.group_dict_name
                FROM scmdata.sys_group_dict gd
               WHERE gd.group_dict_value = size_rec.size_gd),
             0);
        END IF;
      
      END LOOP;
    
    END LOOP;
  
  END sync_commodity_size_middle;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:47:49
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 新增尺码表
  * Obj_Name    : INSERT_COMMODITY_SIZE
  * Arg_Number  : 1
  * P_CSIZE_REC :尺码表
  *============================================*/

  PROCEDURE insert_commodity_size(p_csize_rec scmdata.t_commodity_size%ROWTYPE) IS
    --拆分尺码组
    CURSOR size_data IS
      SELECT regexp_substr(v.size_list, '[^;]+', 1, LEVEL) size_gd
        FROM (SELECT tc.size_list
                FROM scmdata.t_commodity_info tc
               WHERE tc.commodity_info_id = p_csize_rec.commodity_info_id
                 AND tc.company_id = p_csize_rec.company_id) v
      CONNECT BY LEVEL <= regexp_count(v.size_list, '[^;]+');
    v_size_id VARCHAR2(100);
  BEGIN
    --1.新增尺寸表
    v_size_id := scmdata.f_get_uuid();
    INSERT INTO scmdata.t_commodity_size
      (commodity_size_id,
       commodity_info_id,
       company_id,
       position,
       std_size,
       measurement_methods,
       tolerance_upper,
       tolerance_lower,
       remarks,
       goo_id)
    VALUES
      (v_size_id,
       p_csize_rec.commodity_info_id,
       p_csize_rec.company_id,
       p_csize_rec.position,
       p_csize_rec.std_size,
       p_csize_rec.measurement_methods,
       p_csize_rec.tolerance_upper,
       p_csize_rec.tolerance_lower,
       p_csize_rec.remarks,
       p_csize_rec.goo_id);
  
    --2.动态同步尺寸中间表t_commodity_size_middle 列值，如：S,M,L
    FOR size_rec IN size_data LOOP
      INSERT INTO scmdata.t_commodity_size_middle
        (commodity_size_middle_id,
         commodity_info_id,
         company_id,
         commodity_size_id,
         size_code,
         size_name,
         size_value)
      VALUES
        (scmdata.f_get_uuid(),
         p_csize_rec.commodity_info_id,
         p_csize_rec.company_id,
         v_size_id,
         size_rec.size_gd,
         (SELECT gd.group_dict_name
            FROM scmdata.sys_group_dict gd
           WHERE gd.group_dict_value = size_rec.size_gd),
         0);
    END LOOP;
  
  END insert_commodity_size;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:47:49
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 修改尺码表
  * Obj_Name    : INSERT_COMMODITY_SIZE
  * Arg_Number  : 1
  * P_CSIZE_REC :尺码表
  *============================================*/
  PROCEDURE update_commodity_size(p_csize_rec  scmdata.t_commodity_size%ROWTYPE,
                                  p_size_name  VARCHAR2,
                                  p_size_value VARCHAR2) IS
  BEGIN
    UPDATE scmdata.t_commodity_size t
       SET t.position            = p_csize_rec.position,
           t.measurement_methods = p_csize_rec.measurement_methods,
           t.std_size            = p_csize_rec.std_size,
           t.tolerance_upper     = p_csize_rec.tolerance_upper,
           t.tolerance_lower     = p_csize_rec.tolerance_lower
     WHERE t.commodity_size_id = p_csize_rec.commodity_size_id;
  
    UPDATE scmdata.t_commodity_size_middle t
       SET t.size_value = p_size_value
     WHERE t.commodity_size_id = p_csize_rec.commodity_size_id
       AND t.size_name = p_size_name;
  
  END update_commodity_size;
  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:47:49
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 删除尺寸表
  * Obj_Name    : INSERT_COMMODITY_SIZE
  * Arg_Number  : 1
  * P_CSIZE_REC :尺码表
  *============================================*/
  PROCEDURE delete_commodity_size(p_csize_rec scmdata.t_commodity_size%ROWTYPE) IS
    v_approve_version_id VARCHAR2(100); --批版编号
    v_approve_status     NUMBER;
  BEGIN
    v_approve_status := check_comm_size(p_company_id => p_csize_rec.company_id,
                                        p_goo_id     => p_csize_rec.goo_id);
    --删除尺寸表，需判断批版状态，只有待批版的才可删除。
  
    IF v_approve_status = 0 THEN
      raise_application_error(-20002,
                              '存在待批版数据，商品档案尺寸表不可操作！');
    ELSIF v_approve_status = 1 THEN
      raise_application_error(-20002,
                              '存在批版通过数据，商品档案尺寸表不可删除数据！');
    ELSE
      SELECT v.approve_version_id
        INTO v_approve_version_id
        FROM scmdata.t_approve_version v
       WHERE v.approve_number =
             (SELECT MAX(t.approve_number)
                FROM scmdata.t_approve_version t
               WHERE t.company_id = v.company_id
                 AND t.goo_id = v.goo_id)
         AND v.company_id = p_csize_rec.company_id
         AND v.goo_id = p_csize_rec.goo_id;
    
      --删除批版 尺寸表数据 根据部位（唯一）删除
      DELETE FROM scmdata.t_approve_size t
       WHERE t.company_id = p_csize_rec.company_id
         AND t.approve_version_id = v_approve_version_id
         AND t.position = p_csize_rec.position;
    
      --删除商品档案尺寸表数据
      DELETE FROM scmdata.t_commodity_size_middle t
       WHERE t.company_id = p_csize_rec.company_id
         AND t.commodity_info_id = p_csize_rec.commodity_info_id
         AND t.commodity_size_id = p_csize_rec.commodity_size_id;
    
      DELETE FROM scmdata.t_commodity_size t
       WHERE t.company_id = p_csize_rec.company_id
         AND t.commodity_info_id = p_csize_rec.commodity_info_id
         AND t.commodity_size_id = p_csize_rec.commodity_size_id;
    END IF;
  END delete_commodity_size;

  --校验商品档案尺寸表不可修改情况

  FUNCTION check_comm_size(p_company_id VARCHAR2, p_goo_id VARCHAR2)
    RETURN NUMBER IS
    v_approve_status     VARCHAR2(100);
    v_approve_result     VARCHAR2(100);
    v_approve_version_id VARCHAR2(100);
  BEGIN
    /*
    1.商品档案尺寸表不可修改情况：
    （1）存在待批版数据时，商品档案尺寸表不可操作
    （2）存在批版通过数据时，商品档案尺寸表：部位、量法、标准尺寸及基码不可修改，且不可删除、新增数据；
    （3）当商品即存在待批版数据，又存在批版通过数据时，条件（1）> 条件（2）
    2. 商品档案可随意新增、修改、删除情况：
    （1）当商品档案不存在批版数据
    （2）只有不批版数据
    （3）只有批版不通过数据时
      */
    SELECT v.approve_status, v.approve_result, v.approve_version_id
      INTO v_approve_status, v_approve_result, v_approve_version_id
      FROM scmdata.t_approve_version v
     WHERE v.approve_number =
           (SELECT MAX(t.approve_number)
              FROM scmdata.t_approve_version t
             WHERE t.company_id = v.company_id
               AND t.goo_id = v.goo_id)
       AND v.company_id = p_company_id
       AND v.goo_id = p_goo_id;
    --（1）存在待批版数据时，商品档案尺寸表不可操作
    IF v_approve_status = 'AS00' THEN
      RETURN 0;
      --2）存在批版通过数据时，商品档案尺寸表：部位、量法、标准尺寸及基码不可修改，且不可删除、新增数据；
    ELSIF v_approve_status = 'AS01' AND v_approve_result = 'AS03' THEN
      RETURN 1;
    ELSE
      RETURN - 1;
    END IF;
  
  END check_comm_size;

  /*============================================*
  * Author   : zwh73
  * Created  : 2020-10-23 17:42:18
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 校验导入数据
  * Obj_Name    : check_importdatas_good
  * Arg_Number  : 1
  * p_commodity_info_import_temp_id :临时表ID
  *============================================*/

  PROCEDURE check_importdatas_good(p_commodity_info_import_temp_id IN VARCHAR2) IS
    p_commodity_info_import_temp scmdata.t_commodity_info_import_temp%ROWTYPE;
    p_flag                       INT;
    p_i                          INT;
    p_msg                        VARCHAR2(3000);
    p_desc                       VARCHAR2(1000);
    p_supplier_id                VARCHAR2(32);
    p_temp_id                    VARCHAR2(32);
  BEGIN
    p_i := 0;
    SELECT t.*
      INTO p_commodity_info_import_temp
      FROM scmdata.t_commodity_info_import_temp t
     WHERE commodity_info_import_temp_id = p_commodity_info_import_temp_id;
    --校验供应商号码
    SELECT MAX(t.status),
           MAX(supplier_company_name),
           MAX(t.supplier_info_id)
      INTO p_flag, p_desc, p_supplier_id
      FROM scmdata.t_supplier_info t
     WHERE t.inside_supplier_code =
           p_commodity_info_import_temp.supplier_code
       AND t.company_id = p_commodity_info_import_temp.company_id;
    IF p_flag IS NULL THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')不存在的供应商编号,';
    ELSIF p_flag = 0 THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')供应商未建档,';
    
    ELSIF p_desc <> p_commodity_info_import_temp.supplier_code_desc THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')供应商编号和供应商名称不对应,当前对应为:' || p_desc || ' ,';
    END IF;
    /* --检测货号
      SELECT MAX(t.commodity_info_id)
        INTO p_temp_id
        FROM scmdata.t_commodity_info t
       WHERE t.rela_goo_id = p_commodity_info_import_temp.goo_id
         AND t.company_id = p_commodity_info_import_temp.company_id;
      IF p_temp_id IS NOT NULL THEN
        p_i   := p_i + 1;
        p_msg := p_msg || p_i || ')商品档案中已存在相同货号';
      END IF;
      SELECT COUNT(*)
        INTO p_flag
        FROM t_commodity_info_import_temp t
       WHERE t.goo_id = p_commodity_info_import_temp.goo_id
         AND t.create_id = p_commodity_info_import_temp.create_id
         AND t.company_id = p_commodity_info_import_temp.company_id;
      IF p_flag > 1 THEN
        p_i   := p_i + 1;
        p_msg := p_msg || p_i || ')本次导入的商品档案存在重复的货号，请检查';
      END IF;
    */
    SELECT MAX(a.group_dict_value)
      INTO p_commodity_info_import_temp.category
      FROM sys_group_dict a
     WHERE a.group_dict_value = p_commodity_info_import_temp.category_desc
       AND a.group_dict_type = 'PRODUCT_TYPE'
       AND pause = 0;
    if p_commodity_info_import_temp.category is null then
      --检验大类
      SELECT MAX(a.group_dict_value)
        INTO p_commodity_info_import_temp.category
        FROM sys_group_dict a
       WHERE a.group_dict_name = p_commodity_info_import_temp.category_desc
         AND a.group_dict_type = 'PRODUCT_TYPE'
         AND pause = 0;
      IF p_commodity_info_import_temp.category IS NULL THEN
        p_i   := p_i + 1;
        p_msg := p_msg || p_i || ')不存在的分类,';
      
      END IF;
    end if;
    --检测生产类别
    SELECT MAX(a.group_dict_value)
      INTO p_commodity_info_import_temp.product_cate
      FROM sys_group_dict a
     WHERE a.group_dict_value =
           p_commodity_info_import_temp.product_cate_desc
       AND a.group_dict_type = p_commodity_info_import_temp.category
       AND pause = 0;
  
    IF p_commodity_info_import_temp.product_cate IS NULL THEN
      SELECT MAX(a.group_dict_value)
        INTO p_commodity_info_import_temp.product_cate
        FROM sys_group_dict a
       WHERE a.group_dict_name =
             p_commodity_info_import_temp.product_cate_desc
         AND a.group_dict_type = p_commodity_info_import_temp.category
         AND pause = 0;
      IF p_commodity_info_import_temp.product_cate IS NULL THEN
        p_i   := p_i + 1;
        p_msg := p_msg || p_i || ')不存在的生产类别,';
      
      END IF;
    end if;
    --检验子类
    SELECT MAX(a.company_dict_value)
      INTO p_commodity_info_import_temp.samll_category
      FROM sys_company_dict a
     WHERE a.company_dict_value =
           p_commodity_info_import_temp.samll_category_desc
       AND a.company_dict_type = p_commodity_info_import_temp.product_cate
       AND a.company_id = p_commodity_info_import_temp.company_id
       AND pause = 0;
    IF p_commodity_info_import_temp.samll_category IS NULL THEN
      SELECT MAX(a.company_dict_value)
        INTO p_commodity_info_import_temp.samll_category
        FROM sys_company_dict a
       WHERE a.company_dict_name =
             p_commodity_info_import_temp.samll_category_desc
         AND a.company_dict_type =
             p_commodity_info_import_temp.product_cate
         AND a.company_id = p_commodity_info_import_temp.company_id
         AND pause = 0;
      IF p_commodity_info_import_temp.samll_category IS NULL THEN
        p_i   := p_i + 1;
        p_msg := p_msg || p_i || ')不存在的子类,';
      
      END IF;
    end if;
    --更新类别编号
  
    update t_commodity_info_import_temp a
       set a.category       = p_commodity_info_import_temp.category,
           a.product_cate   = p_commodity_info_import_temp.product_cate,
           a.samll_category = p_commodity_info_import_temp.samll_category
     where a.commodity_info_import_temp_id =
           p_commodity_info_import_temp_id;
    --季度
    SELECT MAX(a.group_dict_value)
      INTO p_desc
      FROM sys_group_dict a
     WHERE a.group_dict_name = p_commodity_info_import_temp.season
       AND a.group_dict_type = 'GD_SESON'
       AND pause = 0;
    IF p_desc IS NULL THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')请输入正确的季度';
    
    END IF;
    if p_commodity_info_import_temp.color_list <> '无' then
      --color_list
      SELECT listagg(c.color_desc, ';') within GROUP(ORDER BY c.seq_no)
        INTO p_desc
        FROM (SELECT a.col, b.color_desc, a.seq_no
                FROM (SELECT regexp_substr(p_commodity_info_import_temp.color_list,
                                           '[^;]+',
                                           1,
                                           LEVEL,
                                           'i') col,
                             LEVEL seq_no
                        FROM dual
                      CONNECT BY LEVEL <=
                                 length(p_commodity_info_import_temp.color_list) -
                                 length(regexp_replace(p_commodity_info_import_temp.color_list,
                                                       ';',
                                                       '')) + 1) a
                LEFT JOIN (SELECT ca.company_dict_name  color_desc,
                                 ca.company_dict_value color
                            FROM sys_company_dict ca
                            LEFT JOIN sys_company_dict cb
                              ON ca.company_dict_type =
                                 cb.company_dict_value
                             AND cb.company_id =
                                 p_commodity_info_import_temp.company_id
                           WHERE cb.company_dict_type = 'GD_COLOR_LIST'
                             AND ca.company_id =
                                 p_commodity_info_import_temp.company_id) b
                  ON a.col = b.color
               ORDER BY a.seq_no) c;
    
      IF p_desc IS NULL THEN
        p_i   := p_i + 1;
        p_msg := p_msg || p_i || ')不存在的颜色编号';
        /*  ELSIF p_desc <> p_commodity_info_import_temp.color_list_desc THEN
        p_i   := p_i + 1;
        p_msg := p_msg || p_i || ')颜色编号和颜色不对应,当前对应为:' || p_desc || ',';*/
      END IF;
    end if;
    --size_list
  
    IF p_commodity_info_import_temp.size_list IS NOT NULL THEN
      SELECT listagg(a.k_desc, ';') within GROUP(ORDER BY 1)
        INTO p_desc
        FROM (SELECT regexp_substr(p_commodity_info_import_temp.size_list,
                                   '[^;]+',
                                   1,
                                   LEVEL,
                                   'i') k_desc
                FROM dual
              CONNECT BY LEVEL <= length(p_commodity_info_import_temp.size_list) -
                         length(regexp_replace(p_commodity_info_import_temp.size_list,
                                                        ';',
                                                        '')) + 1) a
       WHERE a.k_desc NOT IN
             (SELECT ca.company_dict_name size_desc
                FROM sys_company_dict ca
                LEFT JOIN sys_company_dict cb
                  ON ca.company_dict_type = cb.company_dict_value
                 AND cb.company_id = p_commodity_info_import_temp.company_id
               WHERE cb.company_dict_type = 'GD_SIZE_LIST'
                 AND ca.company_id = p_commodity_info_import_temp.company_id);
      IF p_desc IS NOT NULL THEN
        p_i   := p_i + 1;
        p_msg := p_msg || p_i || ')以下尺码输入不正确:' || p_desc || ',请确认';
      
      END IF;
    END IF;
    IF p_msg IS NOT NULL THEN
      UPDATE scmdata.t_commodity_info_import_temp t
         SET t.msg_type = 'E', t.error_msg = p_msg
       WHERE t.commodity_info_import_temp_id =
             p_commodity_info_import_temp_id;
    ELSE
      UPDATE scmdata.t_commodity_info_import_temp t
         SET t.msg_type = 'N', t.error_msg = NULL
       WHERE t.commodity_info_import_temp_id =
             p_commodity_info_import_temp_id;
    END IF;
  END check_importdatas_good;

  /*============================================*
  * Author   : zwh73
  * Created  : 2020-10-23 17:38:28
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  EXCEL导入 提交档案数据
  * Obj_Name    : submit_t_coop_scope_temp
  * Arg_Number  : 2
  * p_company_id :企业ID
  * p_user_id ：用户ID
  *============================================*/
  PROCEDURE submit_t_goo_temp(p_company_id IN VARCHAR2,
                              p_user_id    IN VARCHAR2) IS
    p_code   VARCHAR2(32);
    p_id     VARCHAR2(32);
    p_goo_id VARCHAR2(32);
  BEGIN
    FOR data_rec IN (SELECT *
                       FROM scmdata.t_commodity_info_import_temp t
                      WHERE t.company_id = p_company_id
                        AND t.create_id = p_user_id) LOOP
      IF data_rec.msg_type = 'E' OR data_rec.msg_type IS NULL THEN
        raise_application_error(-20002,
                                '请检查数据是否都已检验成功，修改正确后再提交!');
      ELSE
        p_code := data_rec.supplier_code;
      
        SELECT MAX(t.commodity_info_id)
          INTO p_id
          FROM scmdata.t_commodity_info t
         WHERE t.rela_goo_id = data_rec.goo_id
           AND t.company_id = data_rec.company_id;
      
        if p_id is null then
          p_id     := f_get_uuid();
          p_goo_id := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => 't_commodity_info',
                                                         pi_column_name => 'goo_id',
                                                         pi_company_id  => p_company_id,
                                                         pi_pre         => substr(data_rec.year,
                                                                                  3,
                                                                                  2),
                                                         pi_serail_num  => 6);
        
          INSERT INTO scmdata.t_commodity_info
            (commodity_info_id,
             company_id,
             origin,
             style_pic,
             supplier_code,
             goo_id,
             rela_goo_id,
             style_name,
             style_number,
             category,
             samll_category,
             YEAR,
             season,
             base_size,
             inprice,
             price,
             color_list,
             size_list,
             create_id,
             create_time,
             update_id,
             update_time,
             remarks,
             sup_style_number,
             product_cate,
             goo_name,
             EXECUTIVE_STD)
          VALUES
            (p_id,
             data_rec.company_id,
             'QC',
             data_rec.style_pic,
             (SELECT supplier_code
                FROM scmdata.t_supplier_info
               WHERE inside_supplier_code = data_rec.supplier_code
                 AND company_id = data_rec.company_id),
             p_goo_id,
             data_rec.goo_id,
             data_rec.style_name,
             data_rec.style_number,
             data_rec.category,
             data_rec.samll_category,
             data_rec.year,
             (SELECT group_dict_value
                FROM sys_group_dict
               WHERE group_dict_type = 'GD_SESON'
                 AND group_dict_name = data_rec.season),
             data_rec.base_size,
             data_rec.inprice,
             data_rec.price,
             data_rec.color_list,
             (SELECT listagg(k.sizecode, ';') within GROUP(ORDER BY 1)
                FROM (SELECT b.company_dict_value sizecode,
                             b.company_dict_name  sizedesc
                        FROM sys_company_dict a
                       INNER JOIN sys_company_dict b
                          ON a.company_dict_value = b.company_dict_type
                         AND b.company_id = data_rec.company_id
                       WHERE a.company_dict_type = 'GD_SIZE_LIST'
                         AND a.company_id = data_rec.company_id) k
               WHERE instr(';' || data_rec.size_list || ';',
                           ';' || k.sizedesc || ';') > 0),
             scmdata.pkg_personal.f_show_username_by_company(pi_user_id    => p_user_id,
                                                             pi_company_id => data_rec.company_id),
             SYSDATE,
             scmdata.pkg_personal.f_show_username_by_company(pi_user_id    => p_user_id,
                                                             pi_company_id => data_rec.company_id),
             SYSDATE,
             NULL,
             NULL,
             data_rec.product_cate,
             data_rec.goo_name,
             data_rec.EXECUTIVE_STD);
          --    scmdata.pkg_approve_insert.P_GENERATE_NES_APPROVE_INFO(comp_id => p_company_id,
          --                                                         goo_id  => p_goo_id);
        else
          update t_commodity_info a
             set style_name     = data_rec.style_name,
                 style_number   = data_rec.style_number,
                 category       = data_rec.category,
                 samll_category = data_rec.samll_category,
                 base_size      = data_rec.base_size,
                 inprice        = data_rec.inprice,
                 price          = data_rec.price,
                 color_list     = data_rec.color_list,
                 size_list     =
                 (SELECT listagg(k.sizecode, ';') within GROUP(ORDER BY 1)
                    FROM (SELECT b.company_dict_value sizecode,
                                 b.company_dict_name  sizedesc
                            FROM sys_company_dict a
                           INNER JOIN sys_company_dict b
                              ON a.company_dict_value = b.company_dict_type
                             AND b.company_id = data_rec.company_id
                           WHERE a.company_dict_type = 'GD_SIZE_LIST'
                             AND a.company_id = data_rec.company_id) k
                   WHERE instr(';' || data_rec.size_list || ';',
                               ';' || k.sizedesc || ';') > 0),
                 update_id      = scmdata.pkg_personal.f_show_username_by_company(pi_user_id    => p_user_id,
                                                                                  pi_company_id => data_rec.company_id),
                 update_time    = sysdate,
                 product_cate   = data_rec.product_cate,
                 goo_name       = data_rec.goo_name,
                 EXECUTIVE_STD  = data_rec.EXECUTIVE_STD
           where a.commodity_info_id = p_id;
        end if;
      END IF;
    END LOOP;
  
    --清空
    DELETE FROM scmdata.t_commodity_info_import_temp
     WHERE company_id = p_company_id
       AND create_id = p_user_id;
  END submit_t_goo_temp;

  /*============================================*
  * Author   : zwh73
  * Created  : 2020-10-23 17:42:18
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 校验导入数据
  * Obj_Name    : check_importdatas_article
  * Arg_Number  : 1
  * p_supplier_temp_id :临时表ID
  *============================================*/

  PROCEDURE check_importdatas_article(p_commodity_color_size_import_temp_id IN VARCHAR2) IS
    p_commodity_color_size_import_temp scmdata.t_commodity_color_size_import_temp%ROWTYPE;
    p_flag                             INT;
    p_i                                INT;
    p_msg                              VARCHAR2(3000);
    p_desc                             VARCHAR2(256);
    p_temp_id                          VARCHAR2(32);
  BEGIN
    p_i := 0;
  
    SELECT *
      INTO p_commodity_color_size_import_temp
      FROM scmdata.t_commodity_color_size_import_temp a
     WHERE a.t_commodity_color_size_import_temp_id =
           p_commodity_color_size_import_temp_id;
    --检测货号
    SELECT MAX(t.commodity_info_id)
      INTO p_temp_id
      FROM scmdata.t_commodity_info t
     WHERE t.rela_goo_id = p_commodity_color_size_import_temp.goo_id
       AND t.company_id = p_commodity_color_size_import_temp.company_id;
    IF p_temp_id IS NULL THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')商品档案未导入';
    END IF;
    /* --检验重复barcode
    SELECT COUNT(*)
      INTO p_flag
      FROM t_commodity_color_size_import_temp t
     WHERE t.barcode = p_commodity_color_size_import_temp.barcode
       AND t.create_id = p_commodity_color_size_import_temp.create_id
       AND t.company_id = p_commodity_color_size_import_temp.company_id;
    IF p_flag > 1 THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')本次导入的商品档案存在重复的条码编号，请检查';
    END IF;
    
    SELECT COUNT(*)
      INTO p_flag
      FROM t_commodity_color_size t
     WHERE t.barcode = p_commodity_color_size_import_temp.barcode
       AND t.company_id = p_commodity_color_size_import_temp.company_id;
    IF p_flag >= 1 THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')与已有的条码编号重复，请检查';
    END IF;*/
  
    /*--检验colorname
    SELECT MAX(a.color_desc)
      INTO p_desc
      FROM (SELECT ca.company_dict_name  color_desc,
                   ca.company_dict_value color
              FROM sys_company_dict ca
              LEFT JOIN sys_company_dict cb
                ON ca.company_dict_type = cb.company_dict_value
               AND cb.company_id =
                   p_commodity_color_size_import_temp.company_id
             WHERE cb.company_dict_type = 'GD_COLOR_LIST'
               AND ca.company_id =
                   p_commodity_color_size_import_temp.company_id) a
     WHERE a.color = p_commodity_color_size_import_temp.color_code;
    IF p_desc IS NULL THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')请输入正确的标准颜色编码';
    END IF;
    
    IF p_commodity_color_size_import_temp.sizename IS NOT NULL THEN
      --检测sizename
      SELECT MAX(k.size_code)
        INTO p_desc
        FROM (SELECT ca.company_dict_name  size_desc,
                     ca.company_dict_value size_code
                FROM sys_company_dict ca
                LEFT JOIN sys_company_dict cb
                  ON ca.company_dict_type = cb.company_dict_value
                 AND cb.company_id =
                     p_commodity_color_size_import_temp.company_id
               WHERE cb.company_dict_type = 'GD_SIZE_LIST'
                 AND ca.company_id =
                     p_commodity_color_size_import_temp.company_id) k
       WHERE k.size_desc = p_commodity_color_size_import_temp.sizename;
      IF p_desc IS NULL THEN
        p_i   := p_i + 1;
        p_msg := p_msg || p_i || ')请输入正确的标准尺码值,';
      END IF;
    END IF;
      */
    IF p_msg IS NOT NULL THEN
      UPDATE scmdata.t_commodity_color_size_import_temp t
         SET t.msg_type = 'E', t.error_msg = p_msg
       WHERE t.t_commodity_color_size_import_temp_id =
             p_commodity_color_size_import_temp_id;
    ELSE
      UPDATE scmdata.t_commodity_color_size_import_temp t
         SET t.msg_type = 'N', t.error_msg = NULL
       WHERE t.t_commodity_color_size_import_temp_id =
             p_commodity_color_size_import_temp_id;
    END IF;
  END check_importdatas_article;

  /*============================================*
  * Author   : zwh73
  * Created  : 2020-10-23 17:38:28
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  EXCEL导入 提交档案数据
  * Obj_Name    : submit_t_coop_scope_temp
  * Arg_Number  : 2
  * p_company_id :企业ID
  * p_user_id ：用户ID
  *============================================*/
  PROCEDURE submit_t_article_temp(p_company_id IN VARCHAR2,
                                  p_user_id    IN VARCHAR2) IS
    p_id VARCHAR2(32);
  BEGIN
    FOR data_rec IN (SELECT *
                       FROM scmdata.t_commodity_color_size_import_temp t
                      WHERE t.company_id = p_company_id
                        AND t.create_id = p_user_id) LOOP
      IF data_rec.msg_type = 'E' OR data_rec.msg_type IS NULL THEN
        raise_application_error(-20002,
                                '请检查数据是否都已检验成功，修改正确后再提交!');
      ELSE
      
        SELECT max(t.commodity_color_size_id)
          INTO p_id
          FROM t_commodity_color_size t
         WHERE t.barcode = data_rec.barcode
           AND t.company_id = data_rec.company_id;
      
        if p_id is null then
          p_id := f_get_uuid();
        
          INSERT INTO scmdata.t_commodity_color_size
            (commodity_color_size_id,
             commodity_info_id,
             company_id,
             barcode,
             colorname,
             color_code,
             sizename,
             remarks,
             goo_id,
             sizecode)
          VALUES
            (p_id,
             (SELECT commodity_info_id
                FROM scmdata.t_commodity_info
               WHERE rela_goo_id = data_rec.goo_id
                 AND company_id = data_rec.company_id),
             data_rec.company_id,
             data_rec.barcode,
             data_rec.colorname,
             data_rec.color_code,
             data_rec.size_text,
             NULL,
             (SELECT goo_id
                FROM scmdata.t_commodity_info
               WHERE rela_goo_id = data_rec.goo_id
                 AND company_id = data_rec.company_id),
             (SELECT size_code
                FROM (SELECT ca.company_dict_name  size_desc,
                             ca.company_dict_value size_code
                        FROM sys_company_dict ca
                        LEFT JOIN sys_company_dict cb
                          ON ca.company_dict_type = cb.company_dict_value
                         AND cb.company_id = data_rec.company_id
                       WHERE cb.company_dict_type = 'GD_SIZE_LIST'
                         AND ca.company_id = data_rec.company_id)
               WHERE size_desc = data_rec.company_id));
        else
          update scmdata.t_commodity_color_size a
             set colorname  = data_rec.colorname,
                 color_code = data_rec.color_code,
                 sizename   = data_rec.size_text,
                 sizecode  =
                 (SELECT size_code
                    FROM (SELECT ca.company_dict_name  size_desc,
                                 ca.company_dict_value size_code
                            FROM sys_company_dict ca
                            LEFT JOIN sys_company_dict cb
                              ON ca.company_dict_type = cb.company_dict_value
                             AND cb.company_id = data_rec.company_id
                           WHERE cb.company_dict_type = 'GD_SIZE_LIST'
                             AND ca.company_id = data_rec.company_id)
                   WHERE size_desc = data_rec.company_id)
           where commodity_color_size_id = p_id;
        end if;
      END IF;
    END LOOP;
  
    --清空
    DELETE FROM scmdata.t_commodity_color_size_import_temp
     WHERE company_id = p_company_id
       AND create_id = p_user_id;
  END submit_t_article_temp;

  /*============================================*
  * Author   : zwh73
  * Created  : 2020-10-23 17:42:18
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 校验导入数据
  * Obj_Name    : check_importdatas_article
  * Arg_Number  : 1
  * p_supplier_temp_id :临时表ID
  *============================================*/

  PROCEDURE check_importdatas_compostion(p_import_temp_id IN VARCHAR2) IS
    p_commodity_composition_import_temp scmdata.t_commodity_composition_import_temp%ROWTYPE;
    --p_flag                              INT;
    p_i   INT;
    p_msg VARCHAR2(3000);
    -- p_desc                              VARCHAR2(100);
    p_temp_id VARCHAR2(32);
  BEGIN
    p_i := 0;
  
    SELECT *
      INTO p_commodity_composition_import_temp
      FROM scmdata.t_commodity_composition_import_temp a
     WHERE a.import_temp_id = p_import_temp_id;
    --检测货号
    SELECT MAX(t.commodity_info_id)
      INTO p_temp_id
      FROM scmdata.t_commodity_info t
     WHERE t.rela_goo_id = p_commodity_composition_import_temp.goo_id
       AND t.company_id = p_commodity_composition_import_temp.company_id;
    IF p_temp_id IS NULL THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')商品档案未导入';
    END IF;
  
    IF p_msg IS NOT NULL THEN
      UPDATE scmdata.t_commodity_composition_import_temp t
         SET t.msg_type = 'E', t.error_msg = p_msg
       WHERE t.import_temp_id = p_import_temp_id;
    ELSE
      UPDATE scmdata.t_commodity_composition_import_temp t
         SET t.msg_type = 'N', t.error_msg = NULL
       WHERE t.import_temp_id = p_import_temp_id;
    END IF;
  END check_importdatas_compostion;

  PROCEDURE submit_t_compostion_temp(p_company_id IN VARCHAR2,
                                     p_user_id    IN VARCHAR2) IS
    p_id                VARCHAR2(32);
    p_commodity_info_id varchar2(32);
  BEGIN
    FOR data_rec IN (SELECT *
                       FROM scmdata.t_commodity_composition_import_temp t
                      WHERE t.company_id = p_company_id
                        AND t.create_id = p_user_id) LOOP
      IF data_rec.msg_type = 'E' OR data_rec.msg_type IS NULL THEN
        raise_application_error(-20002,
                                '请检查数据是否都已检验成功，修改正确后再提交!');
      ELSE
      
        SELECT max(commodity_info_id)
          into p_commodity_info_id
          FROM scmdata.t_commodity_info
         WHERE rela_goo_id = data_rec.goo_id
           AND company_id = data_rec.company_id;
      
        SELECT max(t.commodity_composition_id)
          INTO p_id
          FROM t_commodity_composition t
         WHERE t.commodity_info_id = p_commodity_info_id
           AND t.sort = data_rec.seq_no
           AND t.company_id = data_rec.company_id;
        if p_id is null then
          p_id := f_get_uuid();
          insert into scmdata.t_commodity_composition
            (commodity_composition_id,
             commodity_info_id,
             company_id,
             composname,
             loadrate,
             goo_raw,
             memo,
             sort,
             create_time,
             create_id,
             update_time,
             update_id,
             pause)
          values
            (p_id,
             p_commodity_info_id,
             p_company_id,
             data_rec.composname,
             data_rec.loadrate,
             data_rec.goo_raw,
             data_rec.memo,
             nvl(data_rec.seq_no,
                 (select nvl(max(sort), 0) + 1
                    from t_commodity_composition
                   where commodity_info_id = p_commodity_info_id)),
             sysdate,
             p_user_id,
             sysdate,
             p_user_id,
             0);
        else
          update scmdata.t_commodity_composition a
             set composname = data_rec.composname,
                 loadrate   = data_rec.loadrate,
                 goo_raw    = data_rec.goo_raw,
                 memo       = data_rec.memo
           where commodity_composition_id = p_id;
        end if;
      END IF;
    END LOOP;
  
    --清空
    DELETE FROM scmdata.t_commodity_composition_import_temp
     WHERE company_id = p_company_id
       AND create_id = p_user_id;
  END submit_t_compostion_temp;
END pkg_commodity_info;
/

