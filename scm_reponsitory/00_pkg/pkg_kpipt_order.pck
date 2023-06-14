CREATE OR REPLACE PACKAGE SCMDATA.PKG_KPIPT_ORDER IS
  /*   t_type参数解析
  t_type = 0 更新全部指标
  t_type = 1 只更新到仓满足率指标  当指标只做更新不做插入
  t_type = 2 只更新到前20%仓满足率指标  当指标只做更新不做插入
  t_type = 3 只更新到仓补货平均交期指标  当指标只做更新不做插入
  t_type = 4 只更新前20%到仓补货平均交期指标  当指标只做更新不做插入
  t_type = 5 只更新前20%到仓补货平均交期指标  当指标只做更新不做插入
  t_type = 6 只更新到仓满足率(原值)指标  当指标只做更新不做插入
        p_type参数解析
  p_type = 0 更新全部历史数据
  p_type = 1 只更新上一个维度（月份、季度、半年度、年度）的数据 */
  /*时间维度：月度*/
  PROCEDURE P_T_KPIORDER_MONTH(t_type number, p_type number);
  /*时间维度：季度 */
  PROCEDURE P_T_KPIORDER_QUARTER(t_type number, p_type number);
  /*时间维度：半年度 */
  PROCEDURE P_T_KPIORDER_HALFYEAR(t_type number, p_type number);
  /*时间维度：年度 */
  PROCEDURE P_T_KPIORDER_YEAR(t_type number, p_type number);
  /*传入生产工厂或者供应商的省、市、分类、产品类别
  返回所在区域分组*/
  FUNCTION f_get_groupname(f_company_province in varchar2,
                           f_company_city     in varchar2,
                           f_category         in varchar2,
                           f_product_cate     in varchar2,
                           f_compid           in varchar2) return varchar2;
  /*返回半年度 */
  function f_yearmonth return number;

  /* 区域组*/
  /*时间维度：月度*/
  PROCEDURE P_T_KPIORDER_QU_MONTH(t_type number, p_type number);
  /*时间维度：季度 */
  PROCEDURE P_T_KPIORDER_QU_QUARTER(t_type number, p_type number);
  /*时间维度：半年度 */
  PROCEDURE P_T_KPIORDER_QU_HALFYEAR(t_type number, p_type number);
  /*时间维度：年度 */
  PROCEDURE P_T_KPIORDER_QU_YEAR(t_type number, p_type number);
  /*---------------------------------------------------------
   对象：
        P_T_KPI_THISMONTH
   时间维度：
       本月
   t_type参数解析
        t_type = 0 更新全部指标
        t_type = 1 更新订单满足率（原值、绩效值）指标
        t_type = 2 更新补货平均交期指标
   p_type参数解析
        p_type = 0 更新全部历史数据
        p_type = 1 只更新上一个维度（月份）的数据
   ---------------------------------------------------------*/
  PROCEDURE P_T_KPI_THISMONTH(t_type number, p_type number);
  /*---------------------------------------------------------
   对象：
        P_T_KPI_MONTH
   时间维度：
       月份
   t_type参数解析
        t_type = 0 更新全部指标
        t_type = 1 更新订单满足率（原值、绩效值）指标
        t_type = 2 更新补货平均交期指标
   p_type参数解析
        p_type = 0 更新全部历史数据
        p_type = 1 只更新上一个维度（月份）的数据
   ----------------------------------------------  ----------*/
  PROCEDURE P_T_KPI_MONTH(t_type number, p_type number);
  /*----------------------------------------------------------
   对象：
        P_T_KPI_QUARTER
   时间维度：
       季度
   t_type参数解析
        t_type = 0 更新全部指标
        t_type = 1 更新订单满足率（原值、绩效值）指标
        t_type = 2 更新补货平均交期指标
   p_type参数解析
        p_type = 0 更新全部历史数据
        p_type = 1 只更新上一个维度（季度）的数据
   ---------------------------------------------------------*/
  PROCEDURE P_T_KPI_QUARTER(t_type number, p_type number);
  /*----------------------------------------------------------
   对象：
        P_T_KPI_HALFYEAR
   时间维度：
       半年度
   t_type参数解析
        t_type = 0 更新全部指标
        t_type = 1 更新订单满足率（原值、绩效值）指标
        t_type = 2 更新补货平均交期指标
   p_type参数解析
        p_type = 0 更新全部历史数据
        p_type = 1 只更新上一个维度（半年）的数据
   -----------------------------------------------------------*/
  PROCEDURE P_T_KPI_HALFYEAR(t_type number, p_type number);
  /*-----------------------------------------------------------
   对象：
        P_T_KPI_YEAR
   时间维度：
       年度
   t_type参数解析
        t_type = 0 更新全部指标
        t_type = 1 更新订单满足率（原值、绩效值）指标
        t_type = 2 更新补货平均交期指标
   p_type参数解析
        p_type = 0 更新全部历史数据
        p_type = 1 只更新上一个维度（年）的数据
   -------------------------------------------------------------*/
  PROCEDURE P_T_KPI_YEAR(t_type number, p_type number);

  --获取数据权限sql
  FUNCTION F_GET_DATAPRIVS_SQL(p_class_data_privs VARCHAR2,
                               p_pre              VARCHAR2 DEFAULT 't')
    RETURN CLOB;

  /*---------------------------------------------------------
   对象: F_KPI_160_SELECTSQL
   用途: 报表中心==>交期==>指标查询==>订单满足率页面select_sql
   参数解析
        KPI_TIMETYPE        查询时间类型
        KPI_TIME            查询统计时间
        KPI_DIMENSION       统计维度
        KPI_GROUP           区域组
        KPI_CATEGORY        分类
        P_CLASS_DATA_PRIVS  数据权限
        COMPANY_ID          公司id
   -----------------------------------------------------------*/
  FUNCTION F_KPI_160_SELECTSQL(KPI_TIMETYPE       VARCHAR2,
                               KPI_TIME           VARCHAR2,
                               KPI_DIMENSION      VARCHAR2,
                               KPI_GROUP          VARCHAR2,
                               KPI_CATEGORY       VARCHAR2,
                               P_CLASS_DATA_PRIVS CLOB,
                               COMPANY_ID         VARCHAR2) RETURN CLOB;
  /*---------------------------------------------------------
   对象: f_kpi_161_captionsql
   用途: 报表中心==>交期==>指标查询==>订单满足率页面==>查看差异值按钮跳转==>订单满足率责任部门差异分布动态表头
   参数解析
        v_string       订单满足率页面拼接主键
        v_id          公司id
   -----------------------------------------------------------*/
  function f_kpi_161_captionsql(v_string varchar2,v_id varchar2) return clob;

  /*---------------------------------------------------------
   对象: F_KPI_161_SELECTSQL
   用途: 报表中心==>交期==>指标查询==>订单满足率页面==>查看差异值按钮跳转==>订单满足率责任部门差异分布图表
   参数解析
        KPI_TIMETYPE        查询时间类型
        KPI_TIME            查询统计时间
        KPI_DIMENSION       统计维度
        KPI_GROUP           区域组
        KPI_CATEGORY        分类
        P_CLASS_DATA_PRIVS  数据权限
        COMPANY_ID          公司id
   -----------------------------------------------------------*/
  FUNCTION F_KPI_161_SELECTSQL(P_TIME       VARCHAR2,
                               P_DIMENSION  VARCHAR2,
                               P_SORT       VARCHAR2,
                               P_GROUP      VARCHAR2,
                               P_CATEGORY   VARCHAR2,
                               P_COMPANY_ID VARCHAR2) RETURN CLOB;

  /*---------------------------------------------------------
   对象: f_kpi_162_captionsql
   用途: 报表中心==>交期==>指标查询==>订单满足率页面==>查看趋势按钮跳转==>订单满足率趋势图动态表头
   参数解析
        v_string       订单满足率页面拼接主键
        v_id          公司id
   -----------------------------------------------------------*/
  function f_kpi_162_captionsql(v_string varchar2,v_id varchar2) return clob;

  /*---------------------------------------------------------
   对象: F_KPI_162_SELECTSQL
   用途: 报表中心==>交期==>指标查询==>订单满足率页面==>查看趋势按钮跳转==>订单满足率趋势图
   参数解析
        V_TIME           查询时间
        V_DIMENSION      统计维度
        V_SORT           维度分类
        V_GROUP          区域组
        V_CATEGORY       分类
        V_COMPANY_ID     公司id
   -----------------------------------------------------------*/
  FUNCTION F_KPI_162_SELECTSQL(V_TIME       VARCHAR2,
                               V_DIMENSION  VARCHAR2,
                               V_SORT       VARCHAR2,
                               V_GROUP      VARCHAR2,
                               V_CATEGORY   VARCHAR2,
                               V_COMPANY_ID VARCHAR2) RETURN CLOB;

/*   动态返回月份范围12个月 函数*/
  function f_kpi_month(total_time varchar2) return clob;
/*   动态返回季度范围8个季度 函数*/
  function f_kpi_quarter(total_time varchar2) return clob;
/*   动态返回半年度范围6个半年度 函数*/
  function f_kpi_halfyear(total_time varchar2) return clob;
/*   动态返回年度范围3年 函数*/
  function f_kpi_year(total_time varchar2) return clob;

  /*---------------------------------------------------------
   对象: F_KPI_170_SELECTSQL
   用途: 报表中心==>交期==>指标查询==>补货平均交期页面select_sql
   参数解析
        KPI_TIMETYPE        查询时间类型
        KPI_TIME            查询统计时间
        KPI_DIMENSION       统计维度
        KPI_GROUP           区域组
        KPI_CATEGORY        分类
        P_CLASS_DATA_PRIVS  数据权限
        COMPANY_ID          公司id
   -----------------------------------------------------------*/
  FUNCTION F_KPI_170_SELECTSQL(KPI_TIMETYPE       VARCHAR2,
                               KPI_TIME           VARCHAR2,
                               KPI_DIMENSION      VARCHAR2,
                               KPI_GROUP          VARCHAR2,
                               KPI_CATEGORY       VARCHAR2,
                               P_CLASS_DATA_PRIVS CLOB,
                               COMPANY_ID         VARCHAR2) RETURN CLOB;

  /*---------------------------------------------------------
   对象: f_kpi_171_captionsql
   用途: 报表中心==>交期==>指标查询==>补货平均交期==>查看趋势按钮跳转==>补货平均交期趋势图动态表头
   参数解析
        v_string       补货平均交期页面拼接主键
        v_id          公司id
   -----------------------------------------------------------*/
  function f_kpi_171_captionsql(v_string varchar2,v_id varchar2) return clob;

  /*---------------------------------------------------------
   对象: F_KPI_171_SELECTSQL
   用途: 报表中心==>交期==>指标查询==>补货平均交期页面==>查看趋势按钮跳转==>补货平均交期趋势图
   参数解析
        V_TIME           查询时间
        V_DIMENSION      统计维度
        V_SORT           维度分类
        V_GROUP          区域组
        V_CATEGORY       分类
        V_COMPANY_ID     公司id
   -----------------------------------------------------------*/
  FUNCTION F_KPI_171_SELECTSQL(V_TIME       VARCHAR2,
                               V_DIMENSION  VARCHAR2,
                               V_SORT       VARCHAR2,
                               V_GROUP      VARCHAR2,
                               V_CATEGORY   VARCHAR2,
                               V_COMPANY_ID VARCHAR2) RETURN CLOB;

END PKG_KPIPT_ORDER;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.PKG_KPIPT_ORDER IS
  /*   t_type参数解析
  t_type = 0 更新全部指标
  t_type = 1 只更新到仓满足率指标  当指标只做更新不做插入
  t_type = 2 只更新到前20%仓满足率指标  当指标只做更新不做插入
  t_type = 3 只更新补货平均交期指标  当指标只做更新不做插入
  t_type = 4 只更新前20%补货平均交期指标  当指标只做更新不做插入
  t_type = 5 只更新质量问题订单不满足指标  当指标只做更新不做插入
  t_type = 6 只更新到仓满足率(原值)指标  当指标只做更新不做插入
        p_type参数解析
  p_type = 0 更新全部历史数据
  p_type = 1 只更新上一个维度（月份）的数据 */

  /*kpi指标订单满足率、前20%订单满足率、补货平均交期、前20%补货平均交期指标、质量问题订单不满足指标 更新表月份维度数据表

     修改次数
     2021-12-22上线分部
     2022-02-28 因需求变更，更新补货平均交期、前20%补货平均交期分母的取数逻辑
     2022-03-23 因需求变更，更新订单满足率、前20%订单满足率分子的取数逻辑
     2022-04-06 因需求变更，更新订单满足率、前20%订单满足率分子的取数逻辑
     2022-04-08 因数据有问题，修改订单满足率、前20%订单满足率分子的取数全部来源于底层订单交期表
     2022-04-11 因底层订单交期表更改了责任部门，质量问题订单不满足、订单满足率、前20%订单满足率分子的责任部门全部修改
     2022-05-05 需求变更，修改订单满足率、前20%订单满足率、补货平均交期、前20%补货平均交期的取数逻辑分子分母都发生了改变
                订单满足率修改过滤条件、新增'无'也需要统计
                补货平均交期修改到仓时间为到仓确认时间、增加是生产订单过滤统计
                只更新2022往后的数据
     2022-05-07 修改到货金额的取值范围
     2022-05-11 新增到仓满足率(原值)指标、刷全部数据，包括2021年
     2022-06-06 只刷新2022年数据
  统计维度：分类
  时间维度：月度*/
  PROCEDURE P_T_KPIORDER_MONTH(t_type number, p_type number) IS
    V_Q_SQL  clob;
    V_U_SQL  clob;
    V_W_SQL  clob;
    V_W1_SQL clob;
    V_U1_SQL clob;
    V_U2_SQL clob;
    V_U3_SQL clob;
    V_U4_SQL clob;
    V_U5_SQL clob;
    V_U6_SQL clob;
    V_IN_SQL clob;
    V_SQL    clob;
  BEGIN
    V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpiorder_month tka
  USING (
      with kpi_order as
     (select t.company_id,t.year,t.month, t.category_name,t.category,sum(t.order_money) order_money
        from scmdata.pt_ordered t
       group by t.company_id, t.year, t.month, t.category_name,t.category)
    select k.company_id, k.year, k.month, k.category_name,k.category, k.order_money,z.sho_order_money,d.sho_order_money_desc,
           y.delivery_money,qa.delivery_order_money,qw.delivery_order_money_desc,x.qua_order_money,qx.order_20_money,qy.delivery_20_money,z1.sho_order_original_money
      from kpi_order k
      left join (select t1.company_id, t1.year, t1.month,t1.category ,t1.category_name, sum(t1.order_money) qua_order_money
                   from scmdata.pt_ordered t1
                  inner join scmdata.sys_company_dept a
                     on a.company_id = t1.company_id
                    and a.company_dept_id = t1.responsible_dept
                    and a.pause = 0
                  where a.dept_name = '供应链管理部'
                    and t1.is_quality = 1
                  group by t1.company_id, t1.year, t1.month,t1.category, t1.category_name) x
        on k.company_id = x.company_id
       and k.year = x.year
       and k.month = x.month
       and k.category = x.category
       and k.category_name = x.category_name
      left join (select t2.company_id, to_char(td.delivery_origin_time,'yyyy')year, to_char(td.delivery_origin_time,'mm')month,
                        t2.category_name,t2.category ,sum(t2.fixed_price* td.delivery_amount) delivery_money
                   from scmdata.pt_ordered t2
                  inner join scmdata.t_ordered tor
                     on tor.order_code = t2.product_gress_code
                    and tor.company_id = t2.company_id
                  inner join scmdata.t_delivery_record td
                     on td.order_code = t2.product_gress_code
                    and td.company_id = t2.company_id
                  where t2.is_first_order = '0'
                    and tor.is_product_order = 1
                  group by t2.company_id, to_char(td.delivery_origin_time,'yyyy'),
                           to_char(td.delivery_origin_time,'mm'), t2.category_name,t2.category) y
        on k.company_id = y.company_id
       and k.year = y.year
       and k.month = y.month
       and k.category = y.category
       and k.category_name = y.category_name
      left join (select tp.company_id, tp.year,tp.month, tp.category,tp.category_name,sum(tp.sum_money) sho_order_money
                  from (select t3.company_id, t3.year,t3.month,t3.category, t3.category_name,t3.satisfy_money  sum_money
                          from scmdata.pt_ordered t3
                        union all
                        select t3a.company_id,t3a.year,t3a.month,t3a.category, t3a.category_name,
                               (t3a.order_money - t3a.satisfy_money ) sum_money
                          from scmdata.pt_ordered t3a
                         inner join scmdata.sys_company_dept a
                            on a.company_id = t3a.company_id
                           and a.company_dept_id = t3a.responsible_dept
                           and a.pause = 0
                         where (a.dept_name like '%物流部%'or a.dept_name like '%品类部%'
                             or a.dept_name like '%事业部%' or a.dept_name = '无') ) tp
                          group by tp.company_id, tp.year,tp.month,tp.category, tp.category_name)z
        on k.company_id = z.company_id
       and k.year = z.year
       and k.month = z.month
       and k.category = z.category
       and k.category_name = z.category_name
      left join (select tp.company_id, tp.year,tp.month, tp.category,tp.category_name,sum(tp.sum_money) sho_order_money_desc
                  from (select t3b.company_id, t3b.year,t3b.month,t3b.category, t3b.category_name,t3b.satisfy_money  sum_money
                          from scmdata.pt_ordered t3b
                         where t3b.is_twenty = 1
                         union all
                        select t3a.company_id, t3a.year, t3a.month, t3a.category, t3a.category_name,
                               (t3a.order_money - t3a.satisfy_money) sum_money
                          from scmdata.pt_ordered t3a
                         inner join scmdata.sys_company_dept a
                            on a.company_id = t3a.company_id
                           and a.company_dept_id = t3a.responsible_dept
                           and a.pause = 0
                         where (a.dept_name like '%物流部%'or a.dept_name like '%品类部%'
                             or a.dept_name like '%事业部%' or a.dept_name = '无')
                           and t3a.is_twenty = 1 ) tp
                          group by tp.company_id, tp.year,tp.month,tp.category, tp.category_name)d
        on k.company_id = d.company_id
       and k.year = d.year
       and k.month = d.month
       and k.category = d.category
       and k.category_name = d.category_name
    left join (select ta0.company_id, ta0.year, ta0.month,ta0.category, ta0.category_name,sum(ta0.sum1_date*ta0.sum1_money) delivery_order_money
              from (select t5.company_id, to_char(tba.delivery_origin_time,'yyyy')year, to_char(tba.delivery_origin_time,'mm')month,t5.category, t5.category_name,
                     (to_date(to_char(tba.delivery_origin_time , 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                     to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                     (t5.fixed_price * tba.delivery_amount) sum1_money
                from scmdata.pt_ordered t5
                inner join scmdata.t_delivery_record tba
                  on t5.product_gress_code = tba.order_code
                 and t5.company_id = tba.company_id
                inner join scmdata.t_ordered tor
                   on tor.company_id = tba.company_id
                  and tor.order_code = tba.order_code
                inner join scmdata.t_commodity_info tb
                  on t5.goo_id = tb.rela_goo_id
                 and tb.goo_id = tba.goo_id
                 and t5.company_id = tb.company_id
               where t5.is_first_order = 0
                 and tor.is_product_order = 1)ta0
              group by ta0.company_id, ta0.year, ta0.month,ta0.category, ta0.category_name) qa
      on k.company_id = qa.company_id
     and k.year = qa.year
     and k.month = qa.month
     and k.category = qa.category
     and k.category_name = qa.category_name
    left join (select t6.company_id, t6.year, t6.month,t6.category, t6.category_name,sum(t6.sum1_date*t6.sum1_money) delivery_order_money_desc
              from (select t5.company_id, to_char(tba.delivery_origin_time,'yyyy')year, to_char(tba.delivery_origin_time,'mm')month,t5.category, t5.category_name,
                     (to_date(to_char(tba.delivery_origin_time , 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                     to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                     (t5.fixed_price * tba.delivery_amount) sum1_money
                from scmdata.pt_ordered t5
                inner join scmdata.t_delivery_record tba
                  on t5.product_gress_code = tba.order_code
                 and t5.company_id = tba.company_id
                inner join scmdata.t_ordered tor
                   on tor.company_id = tba.company_id
                  and tor.order_code = tba.order_code
                inner join scmdata.t_commodity_info tb
                  on t5.goo_id = tb.rela_goo_id
                 and tb.goo_id = tba.goo_id
                 and t5.company_id = tb.company_id
               where t5.is_first_order = 0
                 and t5.is_twenty = 1
                 and tor.is_product_order = 1)t6
                group by t6.company_id, t6.year, t6.month, t6.category, t6.category_name) qw
      on k.company_id = qw.company_id
     and k.year = qw.year
     and k.month = qw.month
     and k.category = qw.category
     and k.category_name = qw.category_name
    left join (select t.company_id,t.year,t.month,t.category, t.category_name,sum(t.order_money) order_20_money
                 from scmdata.pt_ordered t
                where t.is_twenty =1
                group by t.company_id, t.year, t.month, t.category,t.category_name)qx
      on k.company_id = qx.company_id
     and k.year = qx.year
     and k.month = qx.month
     and k.category = qx.category
     and k.category_name = qx.category_name
    left join (select t2.company_id, to_char(td.delivery_origin_time,'yyyy')year, to_char(td.delivery_origin_time,'mm')month,
                      t2.category,t2.category_name, sum(t2.fixed_price* td.delivery_amount) delivery_20_money
                   from scmdata.pt_ordered t2
                  inner join scmdata.t_delivery_record td
                     on td.order_code = t2.product_gress_code
                    and td.company_id = t2.company_id
                  inner join scmdata.t_ordered tor
                     on tor.order_code = t2.product_gress_code
                    and tor.company_id = t2.company_id
                  where t2.is_first_order = '0' and t2.is_twenty = 1  and tor.is_product_order = 1
                  group by t2.company_id,to_char(td.delivery_origin_time,'yyyy'), to_char(td.delivery_origin_time,'mm'),t2.category, t2.category_name) qy
        on k.company_id = qy.company_id
       and k.year = qy.year
       and k.month = qy.month
       and k.category = qy.category
       and k.category_name = qy.category_name
      left join (select tp.company_id, tp.year,tp.month, tp.category,tp.category_name,sum(tp.sum_money) sho_order_original_money
                  from (select t3.company_id, t3.year,t3.month,t3.category, t3.category_name,t3.satisfy_money  sum_money
                          from scmdata.pt_ordered t3) tp
                          group by tp.company_id, tp.year,tp.month,tp.category, tp.category_name)z1
        on k.company_id = z1.company_id
       and k.year = z1.year
       and k.month = z1.month
       and k.category = z1.category
       and k.category_name = z1.category_name ]';
    /*条件1——更新全部历史数据*/
    V_W_SQL := q'[
    where (k.year || lpad(k.month,2,0)) < to_char(sysdate,'yyyymm')
      and k.year >=2022 ) tkb
      ON (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.month = tkb.month and tka.category = tkb.category and tka.category_name = tkb.category_name)
     WHEN MATCHED THEN]';
    /*条件2——只更新上一个月的数据*/
    V_W1_SQL := q'[
     where (k.year || lpad(k.month,2,0)) = to_char(add_months(sysdate,-1),'yyyymm')) tkb
      ON (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.month = tkb.month and tka.category = tkb.category and tka.category_name = tkb.category_name)
     WHEN MATCHED THEN]';
    /*更新全部指标*/
    V_U_SQL := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.sho_order_money           = tkb.sho_order_money,
             tka.sho_order_20_money        = tkb.sho_order_money_desc,
             tka.delivery_money            = tkb.delivery_money,
             tka.delivery_order_money      = tkb.delivery_order_money,
             tka.delivery_order_20_money   = tkb.delivery_order_money_desc,
             tka.qua_order_money           = tkb.qua_order_money,
             tka.delivery_20_money         = tkb.delivery_20_money,
             tka.order_20_money            = tkb.order_20_money,
             tka.sho_order_original_money  = tkb.sho_order_original_money,
             tka.memo                      = '',
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    /*只更新订单满足率指标*/
    V_U1_SQL := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.sho_order_money           = tkb.sho_order_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    /*只更新前20%订单满足率指标*/
    V_U2_SQL := q'[  UPDATE
         SET tka.order_20_money            = tkb.order_20_money,
             tka.sho_order_20_money        = tkb.sho_order_money_desc,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    /*只更新补货平均交期指标*/
    V_U3_SQL := q'[  UPDATE
         SET tka.delivery_money            = tkb.delivery_money,
             tka.delivery_order_money      = tkb.delivery_order_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    /*只更新前20%补货平均交期指标*/
    V_U4_SQL := q'[  UPDATE
         SET tka.delivery_20_money         = tkb.delivery_20_money,
             tka.delivery_order_20_money   = tkb.delivery_order_money_desc,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    /*只更新质量问题订单不满足率指标*/
    V_U5_SQL := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.qua_order_money           = tkb.qua_order_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    /*只更新订单满足率(原值)指标*/
    V_U6_SQL := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.sho_order_original_money  = tkb.sho_order_original_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    /* 插入新数据   */
    V_IN_SQL := q'[
    WHEN NOT MATCHED THEN
      INSERT
        (tka.company_id,
         tka.year,
         tka.month,
         tka.category_name,
         tka.category,
         tka.order_money,
         tka.sho_order_money,
         tka.sho_order_20_money,
         tka.delivery_money,
         tka.delivery_order_money,
         tka.delivery_order_20_money,
         tka.qua_order_money,
         tka.delivery_20_money,
         tka.order_20_money,
         tka.sho_order_original_money,
         tka.memo,
         tka.create_id,
         tka.create_time,
         tka.update_id,
         tka.update_time)
      VALUES
        (tkb.company_id,
         tkb.year,
         tkb.month,
         tkb.category_name,
         tkb.category,
         tkb.order_money,
         tkb.sho_order_money,
         tkb.sho_order_money_desc,
         tkb.delivery_money,
         tkb.delivery_order_money,
         tkb.delivery_order_money_desc,
         tkb.qua_order_money,
         tkb.delivery_20_money,
         tkb.order_20_money,
         tkb.sho_order_original_money,
         ' ',
         'ADMIN',
         sysdate,
         'ADMIN',
         sysdate)]';
    /*   t_type = 0 更新全部指标
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
    end if;
    /*   t_type = 1 只更新到仓满足率指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U1_SQL;
      end if;
    end if;
    /*   t_type = 2 只更新到前20%仓满足率指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 2 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U2_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U2_SQL;
      end if;
    end if;
    /*   t_type = 3 只更新到仓补货平均交期指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 3 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U3_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U3_SQL;
      end if;
    end if;
    /*   t_type = 4 只更新前20%到仓补货平均交期指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 4 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U4_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U4_SQL;
      end if;
    end if;
    /*   t_type = 5 只更新质量问题订单不满足率指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 5 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U5_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U5_SQL;
      end if;
    end if;
    /*   t_type = 6 只更新订单满足率(原值)指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 6 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U6_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U6_SQL;
      end if;
    end if;
    execute immediate V_SQL;
  END P_T_KPIORDER_MONTH;

  /*   t_type参数解析
  t_type = 0 更新全部指标
  t_type = 1 只更新到仓满足率指标  当指标只做更新不做插入
  t_type = 2 只更新到前20%仓满足率指标  当指标只做更新不做插入
  t_type = 3 只更新补货平均交期指标  当指标只做更新不做插入
  t_type = 4 只更新前20%补货平均交期指标  当指标只做更新不做插入
  t_type = 5 只更新质量问题订单不满足指标  当指标只做更新不做插入
        p_type参数解析
  p_type = 0 更新全部历史数据
  p_type = 1 只更新上一个维度（季度）的数据 */

  /*kpi指标订单满足率、前20%订单满足率、补货平均交期、前20%补货平均交期指标、质量问题订单不满足指标 更新表季度维度数据表

  修改次数
   2021-12-22上线分部
   2022-02-28 因需求变更，更新补货平均交期、前20%补货平均交期分母的取数逻辑
   2022-03-23 因需求变更，更新订单满足率、前20%订单满足率分子的取数逻辑
   2022-04-06 因需求变更，更新订单满足率、前20%订单满足率分子的取数逻辑
   2022-04-08 因数据有问题，修改订单满足率、前20%订单满足率分子的取数全部来源于底层订单交期表
   2022-04-11 因底层订单交期表更改了责任部门，质量问题订单不满足、订单满足率、前20%订单满足率分子的责任部门全部修改
   2022-05-05 需求变更，修改订单满足率、前20%订单满足率、补货平均交期、前20%补货平均交期的取数逻辑分子分母都发生了改变
              订单满足率修改过滤条件、新增'无'也需要统计
              补货平均交期修改到仓时间为到仓确认时间、增加是生产订单过滤统计
              只更新2022往后的数据
     2022-05-07 修改到货金额的取值范围
     2022-05-11 新增到仓满足率(原值)指标、刷全部的历史数据，包括2021年
     2022-06-06 只刷新2022年数据
  统计维度：分类
  时间维度：季度 */
  PROCEDURE P_T_KPIORDER_QUARTER(t_type number, p_type number) IS
    V_Q_SQL  clob;
    V_U_SQL  clob;
    V_W_SQL  clob;
    V_W1_SQL clob;
    V_U1_SQL clob;
    V_U2_SQL clob;
    V_U3_SQL clob;
    V_U4_SQL clob;
    V_U5_SQL clob;
    V_U6_SQL clob;
    V_IN_SQL clob;
    V_SQL    clob;
  BEGIN
    V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpiorder_quarter tka
  USING (
     with kpi_order as
     (select t.company_id,t.year,t.quarter, t.category_name,t.category,sum(t.order_money) order_money
        from scmdata.pt_ordered t
       group by t.company_id, t.year, t.quarter, t.category_name,t.category)
    select k.company_id, k.year, k.quarter, k.category_name,k.category, k.order_money,z.sho_order_money,d.sho_order_money_desc, y.delivery_money,
           qa.delivery_order_money, qw.delivery_order_money_desc, x.qua_order_money, qx.order_20_money, qy.delivery_20_money,z1.sho_order_original_money
      from kpi_order k
      left join (select t1.company_id, t1.year, t1.quarter,t1.category, t1.category_name, sum(t1.order_money) qua_order_money
                   from scmdata.pt_ordered t1
                  inner join scmdata.sys_company_dept a
                     on a.company_id = t1.company_id
                    and a.company_dept_id = t1.responsible_dept
                    and a.pause = 0
                  where a.dept_name = '供应链管理部'
                    and t1.is_quality = 1
                  group by t1.company_id, t1.year,  t1.quarter, t1.category,t1.category_name) x
        on k.company_id = x.company_id
       and k.year = x.year
       and k.quarter = x.quarter
       and k.category = x.category
       and k.category_name = x.category_name
      left join (select t2.company_id, to_char(td.delivery_origin_time,'yyyy')year,
                 to_char(td.delivery_origin_time,'Q')quarter, t2.category,t2.category_name, sum(t2.fixed_price* td.delivery_amount) delivery_money
                   from scmdata.pt_ordered t2
                  inner join scmdata.t_delivery_record td
                     on td.order_code = t2.product_gress_code
                    and td.company_id = t2.company_id
                   inner join scmdata.t_ordered tor
                     on tor.order_code = t2.product_gress_code
                    and tor.company_id = t2.company_id
                  where t2.is_first_order = '0'
                    and tor.is_product_order = 1
                  group by t2.company_id,to_char(td.delivery_origin_time,'yyyy'), to_char(td.delivery_origin_time,'Q'), t2.category,t2.category_name) y
        on k.company_id = y.company_id
       and k.year = y.year
       and k.quarter = y.quarter
       and k.category = y.category
       and k.category_name = y.category_name
      left join (select tp.company_id, tp.year,tp.quarter,tp.category, tp.category_name,sum(tp.sum_money) sho_order_money
                  from (select t3.company_id, t3.year,t3.quarter, t3.category,t3.category_name,t3.satisfy_money sum_money
                          from scmdata.pt_ordered t3
                         union all
                        select t3a.company_id,t3a.year,t3a.quarter,t3a.category, t3a.category_name, (t3a.order_money  - t3a.satisfy_money) sum_money
                          from scmdata.pt_ordered t3a
                         inner join scmdata.sys_company_dept a
                            on a.company_id = t3a.company_id
                           and a.company_dept_id = t3a.responsible_dept
                           and a.pause = 0
                         where (a.dept_name like '%物流部%'or a.dept_name like '%品类部%'
                             or a.dept_name like '%事业部%' or a.dept_name = '无')  ) tp
                          group by tp.company_id, tp.year,tp.quarter,tp.category, tp.category_name)z
        on k.company_id = z.company_id
       and k.year = z.year
       and k.quarter = z.quarter
       and k.category = z.category
       and k.category_name = z.category_name
      left join (select tp.company_id, tp.year,tp.quarter, tp.category,tp.category_name,sum(tp.sum_money) sho_order_money_desc
                  from (select t3b.company_id, t3b.year,t3b.quarter,t3b.category, t3b.category_name,t3b.satisfy_money sum_money
                          from scmdata.pt_ordered t3b
                         where t3b.is_twenty = 1
                        union all
                        select t3c.company_id,t3c.year,t3c.quarter,t3c.category, t3c.category_name, (t3c.order_money  - t3c.satisfy_money ) sum_money
                          from scmdata.pt_ordered t3c
                         inner join scmdata.sys_company_dept a
                            on a.company_id = t3c.company_id
                           and a.company_dept_id = t3c.responsible_dept
                           and a.pause = 0
                         where t3c.is_twenty = 1
                           and (a.dept_name like '%物流部%'or a.dept_name like '%品类部%'
                             or a.dept_name like '%事业部%' or a.dept_name = '无') ) tp
                          group by tp.company_id, tp.year,tp.quarter,tp.category, tp.category_name)d
        on k.company_id = d.company_id
       and k.year = d.year
       and k.quarter = d.quarter
       and k.category = d.category
       and k.category_name = d.category_name
    left join (select ta0.company_id, ta0.year, ta0.quarter,ta0.category, ta0.category_name,sum(ta0.sum1_date*ta0.sum1_money) delivery_order_money
              from (select t5.company_id, to_char(tba.delivery_origin_time,'yyyy')year, to_char(tba.delivery_origin_time,'Q')quarter,t5.category, t5.category_name,
                     (to_date(to_char(tba.delivery_origin_time, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                     to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                     (t5.fixed_price * tba.delivery_amount) sum1_money
                from scmdata.pt_ordered t5
                inner join scmdata.t_delivery_record tba
                  on t5.product_gress_code = tba.order_code
                 and t5.company_id = tba.company_id
                inner join scmdata.t_ordered tor
                   on tor.company_id = tba.company_id
                  and tor.order_code = tba.order_code
                inner join scmdata.t_commodity_info tb
                  on t5.goo_id = tb.rela_goo_id
                 and tb.goo_id = tba.goo_id
                 and t5.company_id = tb.company_id
               where t5.is_first_order = 0
                 and tor.is_product_order = 1)ta0
              group by ta0.company_id, ta0.year, ta0.quarter,ta0.category, ta0.category_name) qa
        on k.company_id = qa.company_id
       and k.year = qa.year
       and k.quarter = qa.quarter
       and k.category = qa.category
       and k.category_name = qa.category_name
    left join (select t6.company_id, t6.year, t6.quarter,t6.category, t6.category_name,sum(t6.sum1_date*t6.sum1_money) delivery_order_money_desc
              from (select t5.company_id, to_char(tba.delivery_origin_time,'yyyy')year, to_char(tba.delivery_origin_time,'Q')quarter,t5.category, t5.category_name,
                     (to_date(to_char(tba.delivery_origin_time, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                     to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                     (t5.fixed_price * tba.delivery_amount) sum1_money
                from scmdata.pt_ordered t5
                inner join scmdata.t_delivery_record tba
                   on t5.product_gress_code = tba.order_code
                  and t5.company_id = tba.company_id
                inner join scmdata.t_ordered tor
                   on tor.company_id = tba.company_id
                  and tor.order_code = tba.order_code
                inner join scmdata.t_commodity_info tb
                   on t5.goo_id = tb.rela_goo_id
                  and tb.goo_id = tba.goo_id
                  and t5.company_id = tb.company_id
                where t5.is_first_order = 0
                  and t5.is_twenty = 1
                  and tor.is_product_order = 1)t6
                group by t6.company_id, t6.year, t6.quarter,t6.category, t6.category_name) qw
        on k.company_id = qw.company_id
       and k.year = qw.year
       and k.quarter = qw.quarter
       and k.category = qw.category
       and k.category_name = qw.category_name
      left join (select t.company_id,t.year,t.quarter,t.category, t.category_name,sum(t.order_money) order_20_money
                   from scmdata.pt_ordered t
                  where t.is_twenty =1
                  group by t.company_id, t.year, t.quarter,t.category, t.category_name)qx
        on k.company_id = qx.company_id
       and k.year = qx.year
       and k.quarter = qx.quarter
       and k.category = qx.category
       and k.category_name = qx.category_name
      left join (select t2.company_id, to_char(td.delivery_origin_time,'yyyy')year, to_char(td.delivery_origin_time,'Q')quarter,
                        t2.category, t2.category_name, sum(t2.fixed_price* td.delivery_amount) delivery_20_money
                     from scmdata.pt_ordered t2
                  inner join scmdata.t_delivery_record td
                     on td.order_code = t2.product_gress_code
                    and td.company_id = t2.company_id
                   inner join scmdata.t_ordered tor
                     on tor.order_code = t2.product_gress_code
                    and tor.company_id = t2.company_id
                    where t2.is_first_order = '0' and t2.is_twenty = 1 and tor.is_product_order = 1
                    group by t2.company_id, to_char(td.delivery_origin_time,'yyyy'), to_char(td.delivery_origin_time,'Q'),t2.category, t2.category_name) qy
        on k.company_id = qy.company_id
       and k.year = qy.year
       and k.quarter = qy.quarter
       and k.category = qy.category
       and k.category_name = qy.category_name
      left join (select tp.company_id, tp.year,tp.quarter,tp.category, tp.category_name,sum(tp.sum_money) sho_order_original_money
                  from (select t3.company_id, t3.year,t3.quarter, t3.category,t3.category_name,t3.satisfy_money sum_money
                          from scmdata.pt_ordered t3 ) tp
                          group by tp.company_id, tp.year,tp.quarter,tp.category, tp.category_name)z1
        on k.company_id = z1.company_id
       and k.year = z1.year
       and k.quarter = z1.quarter
       and k.category = z1.category
       and k.category_name = z1.category_name ]';

    V_W_SQL := q'[
     where (k.year || k.quarter) <= (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q'))
      and k.year >=2022) tkb
      ON (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.quarter = tkb.quarter and tka.category = tkb.category and tka.category_name = tkb.category_name)
     WHEN MATCHED THEN]';

    V_W1_SQL := q'[
      where (k.year || k.quarter) = (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q')) ) tkb
      ON (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.quarter = tkb.quarter and tka.category = tkb.category and tka.category_name = tkb.category_name)
     WHEN MATCHED THEN]';

    V_U_SQL  := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.sho_order_money           = tkb.sho_order_money,
             tka.sho_order_20_money        = tkb.sho_order_money_desc,
             tka.delivery_money            = tkb.delivery_money,
             tka.delivery_order_money      = tkb.delivery_order_money,
             tka.delivery_order_20_money   = tkb.delivery_order_money_desc,
             tka.qua_order_money           = tkb.qua_order_money,
             tka.delivery_20_money         = tkb.delivery_20_money,
             tka.order_20_money            = tkb.order_20_money,
             tka.sho_order_original_money  = tkb.sho_order_original_money,
             tka.memo                      = '',
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U1_SQL := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.sho_order_money           = tkb.sho_order_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U2_SQL := q'[  UPDATE
         SET tka.order_20_money            = tkb.order_20_money,
             tka.sho_order_20_money        = tkb.sho_order_money_desc,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U3_SQL := q'[  UPDATE
         SET tka.delivery_money            = tkb.delivery_money,
             tka.delivery_order_money      = tkb.delivery_order_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U4_SQL := q'[  UPDATE
         SET tka.delivery_20_money         = tkb.delivery_20_money,
             tka.delivery_order_20_money   = tkb.delivery_order_money_desc,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U5_SQL := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.qua_order_money           = tkb.qua_order_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    /*只更新订单满足率(原值)指标*/
    V_U6_SQL := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.sho_order_original_money  = tkb.sho_order_original_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';

    V_IN_SQL := q'[
   WHEN NOT MATCHED THEN
      INSERT
        (tka.company_id,
         tka.year,
         tka.quarter,
         tka.category_name,
         tka.category,
         tka.order_money,
         tka.sho_order_money,
         tka.sho_order_20_money,
         tka.delivery_money,
         tka.delivery_order_money,
         tka.delivery_order_20_money,
         tka.qua_order_money,
         tka.delivery_20_money,
         tka.order_20_money,
         tka.sho_order_original_money,
         tka.memo,
         tka.create_id,
         tka.create_time,
         tka.update_id,
         tka.update_time)
      VALUES
        (tkb.company_id,
         tkb.year,
         tkb.quarter,
         tkb.category_name,
         tkb.category,
         tkb.order_money,
         tkb.sho_order_money,
         tkb.sho_order_money_desc,
         tkb.delivery_money,
         tkb.delivery_order_money,
         tkb.delivery_order_money_desc,
         tkb.qua_order_money,
         tkb.delivery_20_money,
         tkb.order_20_money,
         tkb.sho_order_original_money,
         '',
         'ADMIN',
         sysdate,
         'ADMIN',
         sysdate)]';

    /*   t_type = 0 更新全部指标
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个季度的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
    end if;
    /*   t_type = 1 只更新到仓满足率指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个季度的数据 */
    if t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U1_SQL;
      end if;
    end if;
    /*   t_type = 2 只更新到前20%仓满足率指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个季度的数据 */
    if t_type = 2 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U2_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U2_SQL;
      end if;
    end if;
    /*   t_type = 3 只更新到仓补货平均交期指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个季度的数据 */
    if t_type = 3 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U3_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U3_SQL;
      end if;
    end if;
    /*   t_type = 4 只更新前20%到仓补货平均交期指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个季度的数据 */
    if t_type = 4 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U4_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U4_SQL;
      end if;
    end if;
    /*   t_type = 5 只更新质量问题订单不满足率指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个季度的数据 */
    if t_type = 5 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U5_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U5_SQL;
      end if;
    end if;

    /*   t_type = 6 只更新订单满足率(原值)指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 6 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U6_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U6_SQL;
      end if;
    end if;
    execute immediate V_SQL;
  END P_T_KPIORDER_QUARTER;

  /*   t_type参数解析
  t_type = 0 更新全部指标
  t_type = 1 只更新到仓满足率指标  当指标只做更新不做插入
  t_type = 2 只更新到前20%仓满足率指标  当指标只做更新不做插入
  t_type = 3 只更新补货平均交期指标  当指标只做更新不做插入
  t_type = 4 只更新前20%补货平均交期指标  当指标只做更新不做插入
  t_type = 5 只更新质量问题订单不满足指标  当指标只做更新不做插入
        p_type参数解析
  p_type = 0 更新全部历史数据
  p_type = 1 只更新上一个维度（半年度）的数据 */

  /*kpi指标订单满足率、前20%订单满足率、补货平均交期、前20%补货平均交期指标、质量问题订单不满足指标 更新表半年度维度数据表

     修改次数
     2021-12-22上线分部
     2022-02-28 因需求变更，更新补货平均交期、前20%补货平均交期分母的取数逻辑
     2022-03-23 因需求变更，更新订单满足率、前20%订单满足率分子的取数逻辑
     2022-04-06 因需求变更，更新订单满足率、前20%订单满足率分子的取数逻辑
     2022-04-08 因数据有问题，修改订单满足率、前20%订单满足率分子的取数全部来源于底层订单交期表
     2022-04-11 因底层订单交期表更改了责任部门，质量问题订单不满足、订单满足率、前20%订单满足率分子的责任部门全部修改
     2022-05-05 需求变更，修改订单满足率、前20%订单满足率、补货平均交期、前20%补货平均交期的取数逻辑分子分母都发生了改变
                订单满足率修改过滤条件、新增'无'也需要统计
                补货平均交期修改到仓时间为到仓确认时间、增加是生产订单过滤统计
                只更新2022往后的数据
     2022-05-07 修改到货金额的取值范围
     2022-05-11 新增到仓满足率(原值)指标、刷全部的历史数据，包括2021年
     2022-06-06 只刷新2022年数据
   统计维度：分类
  时间维度：半年度 */
  PROCEDURE P_T_KPIORDER_HALFYEAR(t_type number, p_type number) IS
    V_Q_SQL  clob;
    V_W_SQL  clob;
    V_W1_SQL clob;
    V_U_SQL  clob;
    V_U1_SQL clob;
    V_U2_SQL clob;
    V_U3_SQL clob;
    V_U4_SQL clob;
    V_U5_SQL clob;
    V_U6_SQL clob;
    V_IN_SQL clob;
    V_SQL    clob;
  BEGIN
    V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpiorder_halfyear tka
  USING (
    with kpi_order as
     (select t.company_id,t.year,decode(t.quarter,1,1,2,1,3,2,4,2) halfyear, t.category_name,t.category,sum(t.order_money) order_money
        from scmdata.pt_ordered t
       group by t.company_id, t.year, decode(t.quarter,1,1,2,1,3,2,4,2), t.category_name,t.category)
    select k.company_id, k.year, k.halfyear, k.category_name,k.category, k.order_money,z.sho_order_money,d.sho_order_money_desc, y.delivery_money,
          qa.delivery_order_money,qw.delivery_order_money_desc,x.qua_order_money, qx.order_20_money, qy.delivery_20_money,z1.sho_order_original_money
      from kpi_order k
      left join (select t1.company_id, t1.year, decode(t1.quarter,1,1,2,1,3,2,4,2) halfyear,t1.category, t1.category_name, sum(t1.order_money) qua_order_money
                   from scmdata.pt_ordered t1
                  inner join scmdata.sys_company_dept a
                     on a.company_id = t1.company_id
                    and a.company_dept_id = t1.responsible_dept
                    and a.pause = 0
                  where a.dept_name = '供应链管理部'
                    and t1.is_quality = 1
                  group by t1.company_id, t1.year, decode(t1.quarter,1,1,2,1,3,2,4,2),t1.category, t1.category_name) x
        on k.company_id = x.company_id
       and k.year = x.year
       and k.halfyear = x.halfyear
       and k.category = x.category
       and k.category_name = x.category_name
      left join (select t2.company_id, to_char(td.delivery_origin_time,'yyyy')year, decode(to_char(td.delivery_origin_time,'Q'),1,1,2,1,3,2,4,2) halfyear,
                        t2.category, t2.category_name, sum(t2.fixed_price* td.delivery_amount) delivery_money
                   from scmdata.pt_ordered t2
                  inner join scmdata.t_delivery_record td
                     on td.order_code = t2.product_gress_code
                    and td.company_id = t2.company_id
                   inner join scmdata.t_ordered tor
                     on tor.order_code = t2.product_gress_code
                    and tor.company_id = t2.company_id
                  where t2.is_first_order = '0'
                    and tor.is_product_order = 1
                  group by t2.company_id, to_char(td.delivery_origin_time,'yyyy'),
                          decode(to_char(td.delivery_origin_time,'Q'),1,1,2,1,3,2,4,2),t2.category, t2.category_name) y
        on k.company_id = y.company_id
       and k.year = y.year
       and k.halfyear = y.halfyear
       and k.category = y.category
       and k.category_name = y.category_name
      left join (select tp.company_id, tp.year, halfyear,tp.category, tp.category_name,sum(tp.sum_money) sho_order_money
                  from (select t3.company_id, t3.year,decode(t3.quarter,1,1,2,1,3,2,4,2) halfyear,t3.category, t3.category_name,t3.satisfy_money sum_money
                          from scmdata.pt_ordered t3
                         union all
                        select t3a.company_id,t3a.year,decode(t3a.quarter,1,1,2,1,3,2,4,2) halfyear,t3a.category, t3a.category_name, (t3a.order_money  - t3a.satisfy_money ) sum_money
                          from scmdata.pt_ordered t3a
                         inner join scmdata.sys_company_dept a
                            on a.company_id = t3a.company_id
                           and a.company_dept_id = t3a.responsible_dept
                           and a.pause = 0
                         where (a.dept_name like '%物流部%'or a.dept_name like '%品类部%'
                             or a.dept_name like '%事业部%' or a.dept_name = '无')  ) tp
                          group by tp.company_id, tp.year,tp.halfyear,tp.category, tp.category_name)z
        on k.company_id = z.company_id
       and k.year = z.year
       and k.halfyear = z.halfyear
       and k.category = z.category
       and k.category_name = z.category_name
      left join (select tp.company_id, tp.year,tp.halfyear, tp.category,tp.category_name,sum(tp.sum_money) sho_order_money_desc
                  from (select t3b.company_id, t3b.year,decode(t3b.quarter,1,1,2,1,3,2,4,2) halfyear,t3b.category, t3b.category_name,t3b.satisfy_money sum_money
                          from scmdata.pt_ordered t3b
                         where t3b.is_twenty = 1
                        union all
                        select t3c.company_id,t3c.year,decode(t3c.quarter,1,1,2,1,3,2,4,2) halfyear,t3c.category, t3c.category_name, (t3c.order_money  - t3c.satisfy_money ) sum_money
                          from scmdata.pt_ordered t3c
                         inner join scmdata.sys_company_dept a
                            on a.company_id = t3c.company_id
                           and a.company_dept_id = t3c.responsible_dept
                           and a.pause = 0
                         where t3c.is_twenty = 1
                           and (a.dept_name like '%物流部%'or a.dept_name like '%品类部%'
                             or a.dept_name like '%事业部%' or a.dept_name = '无') ) tp
                          group by tp.company_id, tp.year,tp.halfyear,tp.category, tp.category_name)d
        on k.company_id = d.company_id
       and k.year = d.year
       and k.halfyear = d.halfyear
       and k.category = d.category
       and k.category_name = d.category_name
    left join (select ta0.company_id, ta0.year, ta0.halfyear,ta0.category, ta0.category_name,sum(ta0.sum1_date*ta0.sum1_money) delivery_order_money
              from (select t5.company_id, to_char(tba.delivery_origin_time,'yyyy')year, decode(to_char(tba.delivery_origin_time,'Q'),1,1,2,1,3,2,4,2) halfyear,t5.category, t5.category_name,
                     (to_date(to_char(tba.delivery_origin_time, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                     to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                     (t5.fixed_price * tba.delivery_amount) sum1_money
                from scmdata.pt_ordered t5
                inner join scmdata.t_delivery_record tba
                  on t5.product_gress_code = tba.order_code
                 and t5.company_id = tba.company_id
                inner join scmdata.t_ordered tor
                   on tor.company_id = tba.company_id
                  and tor.order_code = tba.order_code
                inner join scmdata.t_commodity_info tb
                  on t5.goo_id = tb.rela_goo_id
                 and tb.goo_id = tba.goo_id
                 and t5.company_id = tb.company_id
               where t5.is_first_order = 0
                 and tor.is_product_order = 1 )ta0
              group by ta0.company_id, ta0.year, ta0.halfyear,ta0.category, ta0.category_name) qa
        on k.company_id = qa.company_id
       and k.year = qa.year
       and k.halfyear = qa.halfyear
       and k.category = qa.category
       and k.category_name = qa.category_name
    left join (select t6.company_id, t6.year, t6.halfyear,t6.category, t6.category_name,sum(t6.sum1_date*t6.sum1_money) delivery_order_money_desc
                from (select t5.company_id, to_char(tba.delivery_origin_time,'yyyy')year, decode(to_char(tba.delivery_origin_time,'Q'),1,1,2,1,3,2,4,2) halfyear,t5.category, t5.category_name,
                     (to_date(to_char(tba.delivery_origin_time, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                     to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                     (t5.fixed_price * tba.delivery_amount) sum1_money
                from scmdata.pt_ordered t5
                inner join scmdata.t_delivery_record tba
                  on t5.product_gress_code = tba.order_code
                 and t5.company_id = tba.company_id
                inner join scmdata.t_ordered tor
                   on tor.company_id = tba.company_id
                  and tor.order_code = tba.order_code
                inner join scmdata.t_commodity_info tb
                  on t5.goo_id = tb.rela_goo_id
                 and tb.goo_id = tba.goo_id
                 and t5.company_id = tb.company_id
               where t5.is_first_order = 0
                 and t5.is_twenty = 1
                 and tor.is_product_order = 1 )t6
                group by t6.company_id, t6.year, t6.halfyear,t6.category, t6.category_name) qw
        on k.company_id = qw.company_id
       and k.year = qw.year
       and k.halfyear = qw.halfyear
       and k.category = qw.category
       and k.category_name = qw.category_name
      left join (select t.company_id,t.year,decode(t.quarter,1,1,2,1,3,2,4,2) halfyear,t.category, t.category_name,sum(t.order_money) order_20_money
                   from scmdata.pt_ordered t
                  where t.is_twenty =1
                  group by t.company_id, t.year, decode(t.quarter,1,1,2,1,3,2,4,2),t.category, t.category_name)qx
        on k.company_id = qx.company_id
       and k.year = qx.year
       and k.halfyear = qx.halfyear
       and k.category = qx.category
       and k.category_name = qx.category_name
      left join (select t2.company_id, to_char(td.delivery_origin_time,'yyyy')year, decode(to_char(td.delivery_origin_time,'Q'),1,1,2,1,3,2,4,2) halfyear,
                        t2.category, t2.category_name, sum(t2.fixed_price* td.delivery_amount) delivery_20_money
                     from scmdata.pt_ordered t2
                  inner join scmdata.t_delivery_record td
                     on td.order_code = t2.product_gress_code
                    and td.company_id = t2.company_id
                     inner join scmdata.t_ordered tor
                       on tor.order_code = t2.product_gress_code
                      and tor.company_id = t2.company_id
                    where t2.is_first_order = '0' and t2.is_twenty = 1  and tor.is_product_order = 1
                    group by t2.company_id,to_char(td.delivery_origin_time,'yyyy'), decode(to_char(td.delivery_origin_time,'Q'),1,1,2,1,3,2,4,2),t2.category, t2.category_name) qy
        on k.company_id = qy.company_id
       and k.year = qy.year
       and k.halfyear = qy.halfyear
       and k.category = qy.category
       and k.category_name = qy.category_name
      left join (select tp.company_id, tp.year, halfyear,tp.category, tp.category_name,sum(tp.sum_money) sho_order_original_money
                  from (select t3.company_id, t3.year,decode(t3.quarter,1,1,2,1,3,2,4,2) halfyear,t3.category, t3.category_name,t3.satisfy_money sum_money
                          from scmdata.pt_ordered t3 ) tp
                          group by tp.company_id, tp.year,tp.halfyear,tp.category, tp.category_name)z1
        on k.company_id = z1.company_id
       and k.year = z1.year
       and k.halfyear = z1.halfyear
       and k.category = z1.category
       and k.category_name = z1.category_name ]';

    V_W_SQL  := q'[
     where (k.year || k.halfyear) <= pkg_kpipt_order.f_yearmonth
      and k.year >=2022 ) tkb
      ON (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.is_halfyear = tkb.halfyear and tka.category = tkb.category and tka.category_name = tkb.category_name)
     WHEN MATCHED THEN]';
    V_W1_SQL := q'[
      where (k.year || k.halfyear) = pkg_kpipt_order.f_yearmonth ) tkb
      ON (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.is_halfyear = tkb.halfyear and tka.category = tkb.category and tka.category_name = tkb.category_name)
     WHEN MATCHED THEN]';
    V_U_SQL  := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.sho_order_money           = tkb.sho_order_money,
             tka.sho_order_20_money        = tkb.sho_order_money_desc,
             tka.delivery_money            = tkb.delivery_money,
             tka.delivery_order_money      = tkb.delivery_order_money,
             tka.delivery_order_20_money   = tkb.delivery_order_money_desc,
             tka.qua_order_money           = tkb.qua_order_money,
             tka.delivery_20_money         = tkb.delivery_20_money,
             tka.order_20_money            = tkb.order_20_money,
             tka.sho_order_original_money  = tkb.sho_order_original_money,
             tka.memo                      = '',
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U1_SQL := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.sho_order_money           = tkb.sho_order_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U2_SQL := q'[  UPDATE
         SET tka.order_20_money            = tkb.order_20_money,
             tka.sho_order_20_money        = tkb.sho_order_money_desc,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U3_SQL := q'[  UPDATE
         SET tka.delivery_money            = tkb.delivery_money,
             tka.delivery_order_money      = tkb.delivery_order_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U4_SQL := q'[  UPDATE
         SET tka.delivery_20_money         = tkb.delivery_20_money,
             tka.delivery_order_20_money   = tkb.delivery_order_money_desc,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U5_SQL := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.qua_order_money           = tkb.qua_order_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    /*只更新订单满足率(原值)指标*/
    V_U6_SQL := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.sho_order_original_money  = tkb.sho_order_original_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';

    V_IN_SQL := q'[
   WHEN NOT MATCHED THEN
      INSERT
        (tka.company_id,
         tka.year,
         tka.is_halfyear,
         tka.category_name,
         tka.category,
         tka.order_money,
         tka.sho_order_money,
         tka.sho_order_20_money,
         tka.delivery_money,
         tka.delivery_order_money,
         tka.delivery_order_20_money,
         tka.qua_order_money,
         tka.delivery_20_money,
         tka.order_20_money,
         tka.sho_order_original_money,
         tka.memo,
         tka.create_id,
         tka.create_time,
         tka.update_id,
         tka.update_time)
      VALUES
        (tkb.company_id,
         tkb.year,
         tkb.halfyear,
         tkb.category_name,
         tkb.category,
         tkb.order_money,
         tkb.sho_order_money,
         tkb.sho_order_money_desc,
         tkb.delivery_money,
         tkb.delivery_order_money,
         tkb.delivery_order_money_desc,
         tkb.qua_order_money,
         tkb.delivery_20_money,
         tkb.order_20_money,
         tkb.sho_order_original_money,
         '',
         'ADMIN',
         sysdate,
         'ADMIN',
         sysdate)]';

    /*   t_type = 0 更新全部指标
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个半年度的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
    end if;
    /*   t_type = 1 只更新到仓满足率指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个半年度的数据 */
    if t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U1_SQL;
      end if;
    end if;
    /*   t_type = 2 只更新到前20%仓满足率指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个半年度的数据 */
    if t_type = 2 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U2_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U2_SQL;
      end if;
    end if;
    /*   t_type = 3 只更新到仓补货平均交期指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个半年度的数据 */
    if t_type = 3 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U3_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U3_SQL;
      end if;
    end if;
    /*   t_type = 4 只更新前20%到仓补货平均交期指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个半年度的数据 */
    if t_type = 4 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U4_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U4_SQL;
      end if;
    end if;
    /*   t_type = 5 只更新质量问题订单不满足率指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个半年度的数据 */
    if t_type = 5 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U5_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U5_SQL;
      end if;
    end if;

    /*   t_type = 6 只更新订单满足率(原值)指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 6 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U6_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U6_SQL;
      end if;
    end if;
    execute immediate V_SQL;
  END P_T_KPIORDER_HALFYEAR;

  /*   t_type参数解析
  t_type = 0 更新全部指标
  t_type = 1 只更新到仓满足率指标  当指标只做更新不做插入
  t_type = 2 只更新到前20%仓满足率指标  当指标只做更新不做插入
  t_type = 3 只更新补货平均交期指标  当指标只做更新不做插入
  t_type = 4 只更新前20%补货平均交期指标  当指标只做更新不做插入
  t_type = 5 只更新质量问题订单不满足指标  当指标只做更新不做插入
        p_type参数解析
  p_type = 0 更新全部历史数据
  p_type = 1 只更新上一个维度（年度）的数据 */

  /*kpi指标订单满足率、前20%订单满足率、补货平均交期、前20%补货平均交期指标、质量问题订单不满足指标 更新表年度维度数据表

   修改次数
    2021-12-22上线分部
    2022-02-28 因需求变更，更新补货平均交期、前20%补货平均交期分母的取数逻辑
    2022-03-23 因需求变更，更新订单满足率、前20%订单满足率分子的取数逻辑
    2022-04-06 因需求变更，更新订单满足率、前20%订单满足率分子的取数逻辑
    2022-04-08 因数据有问题，修改订单满足率、前20%订单满足率分子的取数全部来源于底层订单交期表
    2022-04-11 因底层订单交期表更改了责任部门，质量问题订单不满足、订单满足率、前20%订单满足率分子的责任部门全部修改
    2022-05-05 需求变更，修改订单满足率、前20%订单满足率、补货平均交期、前20%补货平均交期的取数逻辑分子分母都发生了改变
               订单满足率修改过滤条件、新增'无'也需要统计
               补货平均交期修改到仓时间为到仓确认时间、增加是生产订单过滤统计
               只更新2022往后的数据
     2022-05-07 修改到货金额的取值范围
     2022-05-11 新增到仓满足率(原值)指标、刷全部的历史数据，包括2021年
     2022-06-06 只刷新2022年数据
   统计维度：分类
  时间维度：年度 */
  PROCEDURE P_T_KPIORDER_YEAR(t_type number, p_type number) IS
    V_Q_SQL  clob;
    V_W_SQL  clob;
    V_W1_SQL clob;
    V_U_SQL  clob;
    V_U1_SQL clob;
    V_U2_SQL clob;
    V_U3_SQL clob;
    V_U4_SQL clob;
    V_U5_SQL clob;
    V_U6_SQL clob;
    V_IN_SQL clob;
    V_SQL    clob;
  BEGIN
    V_Q_SQL  := q'[
  MERGE INTO scmdata.t_kpiorder_year tka
  USING (
     with kpi_order as
     (select t.company_id,t.year, t.category_name,t.category,sum(t.order_money) order_money
        from scmdata.pt_ordered t
       group by t.company_id, t.year, t.category_name,t.category)
    select k.company_id, k.year, k.category_name,k.category,k.order_money,z.sho_order_money,d.sho_order_money_desc, y.delivery_money,
          qa.delivery_order_money,qw.delivery_order_money_desc,x.qua_order_money, qx.order_20_money, qy.delivery_20_money,z1.sho_order_original_money
      from kpi_order k
      left join (select t1.company_id, t1.year,t1.category,t1.category_name, sum(t1.order_money) qua_order_money
                   from scmdata.pt_ordered t1
                  inner join scmdata.sys_company_dept a
                     on a.company_id = t1.company_id
                    and a.company_dept_id = t1.responsible_dept
                    and a.pause = 0
                  where a.dept_name = '供应链管理部'
                    and t1.is_quality = 1
                  group by t1.company_id, t1.year,t1.category, t1.category_name) x
        on k.company_id = x.company_id
       and k.year = x.year
       and k.category = x.category
       and k.category_name = x.category_name
      left join (select t2.company_id, to_char(td.delivery_origin_time,'yyyy')year,t2.category,t2.category_name, sum(t2.fixed_price* td.delivery_amount) delivery_money
                   from scmdata.pt_ordered t2
                   inner join scmdata.t_ordered tor
                     on tor.order_code = t2.product_gress_code
                    and tor.company_id = t2.company_id
                  inner join scmdata.t_delivery_record td
                     on td.order_code = t2.product_gress_code
                    and td.company_id = t2.company_id
                  where t2.is_first_order = '0'   and tor.is_product_order = 1
                  group by t2.company_id, to_char(td.delivery_origin_time,'yyyy'),t2.category,t2.category_name) y
        on k.company_id = y.company_id
       and k.year = y.year
       and k.category = y.category
       and k.category_name = y.category_name
      left join (select tp.company_id, tp.year,tp.category, tp.category_name,sum(tp.sum_money) sho_order_money
                  from (select t3.company_id, t3.year,t3.category,t3.category_name,t3.satisfy_money sum_money
                          from scmdata.pt_ordered t3
                         union all
                        select t3a.company_id,t3a.year,t3a.category, t3a.category_name, (t3a.order_money  - t3a.satisfy_money ) sum_money
                          from scmdata.pt_ordered t3a
                         inner join scmdata.sys_company_dept a
                            on a.company_id = t3a.company_id
                           and a.company_dept_id = t3a.responsible_dept
                           and a.pause = 0
                         where (a.dept_name like '%物流部%'or a.dept_name like '%品类部%'
                             or a.dept_name like '%事业部%' or a.dept_name = '无')  ) tp
                          group by tp.company_id, tp.year, tp.category,tp.category_name)z
        on k.company_id = z.company_id
       and k.year = z.year
       and k.category = z.category
       and k.category_name = z.category_name
      left join (select tp.company_id, tp.year,tp.category, tp.category_name,sum(tp.sum_money) sho_order_money_desc
                  from (select t3b.company_id, t3b.year,t3b.category, t3b.category_name,t3b.satisfy_money sum_money
                          from scmdata.pt_ordered t3b
                         where t3b.is_twenty = 1
                        union all
                        select t3c.company_id,t3c.year,t3c.category, t3c.category_name, (t3c.order_money  - t3c.satisfy_money ) sum_money
                          from scmdata.pt_ordered t3c
                         inner join scmdata.sys_company_dept a
                            on a.company_id = t3c.company_id
                           and a.company_dept_id = t3c.responsible_dept
                           and a.pause = 0
                         where t3c.is_twenty = 1
                           and (a.dept_name like '%物流部%'or a.dept_name like '%品类部%'
                             or a.dept_name like '%事业部%' or a.dept_name = '无') ) tp
                          group by tp.company_id, tp.year,tp.category, tp.category_name)d
        on k.company_id = d.company_id
       and k.year = d.year
       and k.category = d.category
       and k.category_name = d.category_name
    left join (select ta0.company_id, ta0.year,ta0.category,ta0.category_name,sum(ta0.sum1_date*ta0.sum1_money) delivery_order_money
              from (select t5.company_id, to_char(tba.delivery_origin_time,'yyyy')year, t5.category, t5.category_name,
                     (to_date(to_char(tba.delivery_origin_time, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                     to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                     (t5.fixed_price * tba.delivery_amount) sum1_money
                from scmdata.pt_ordered t5
                inner join scmdata.t_delivery_record tba
                  on t5.product_gress_code = tba.order_code
                 and t5.company_id = tba.company_id
                inner join scmdata.t_ordered tor
                   on tor.company_id = tba.company_id
                  and tor.order_code = tba.order_code
                inner join scmdata.t_commodity_info tb
                  on t5.goo_id = tb.rela_goo_id
                 and tb.goo_id = tba.goo_id
                 and t5.company_id = tb.company_id
               where t5.is_first_order = 0
                 and tor.is_product_order = 1  )ta0
              group by ta0.company_id, ta0.year,ta0.category, ta0.category_name) qa
        on k.company_id = qa.company_id
       and k.year = qa.year
       and k.category = qa.category
       and k.category_name = qa.category_name
    left join (select t6.company_id, t6.year,t6.category, t6.category_name,sum(t6.sum2_date*t6.sum2_money) delivery_order_money_desc
                from (select t5a.company_id,to_char(tab.delivery_origin_time,'yyyy')year,t5a.category, t5a.category_name,
                       (to_date(to_char(tab.delivery_origin_time, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                       to_date(to_char(t5a.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum2_date,
                       (t5a.fixed_price * tab.delivery_amount) sum2_money
                  from scmdata.pt_ordered t5a
                 inner join scmdata.t_delivery_record tab
                    on t5a.product_gress_code = tab.order_code
                   and t5a.company_id = tab.company_id
                inner join scmdata.t_ordered tor
                   on tor.company_id = tab.company_id
                  and tor.order_code = tab.order_code
                 inner join scmdata.t_commodity_info tb
                    on t5a.goo_id = tb.rela_goo_id
                   and tb.goo_id = tab.goo_id
                   and t5a.company_id = tb.company_id
                 where t5a.is_first_order = 0
                   and t5a.is_twenty = 1
                   and tor.is_product_order = 1   )t6
                group by t6.company_id, t6.year,t6.category, t6.category_name) qw
        on k.company_id = qw.company_id
       and k.year = qw.year
       and k.category = qw.category
       and k.category_name = qw.category_name
      left join (select t.company_id,t.year,t.category,t.category_name,sum(t.order_money) order_20_money
                   from scmdata.pt_ordered t
                  where t.is_twenty =1
                  group by t.company_id, t.year, t.category,t.category_name)qx
        on k.company_id = qx.company_id
       and k.year = qx.year
       and k.category = qx.category
       and k.category_name = qx.category_name
      left join (select t2.company_id, to_char(td.delivery_origin_time,'yyyy')year, t2.category,t2.category_name, sum(t2.fixed_price* td.delivery_amount) delivery_20_money
                     from scmdata.pt_ordered t2
                  inner join scmdata.t_delivery_record td
                     on td.order_code = t2.product_gress_code
                    and td.company_id = t2.company_id
                     inner join scmdata.t_ordered tor
                       on tor.order_code = t2.product_gress_code
                      and tor.company_id = t2.company_id
                    where t2.is_first_order = '0' and t2.is_twenty = 1    and tor.is_product_order = 1
                    group by t2.company_id, to_char(td.delivery_origin_time,'yyyy'), t2.category,t2.category_name) qy
        on k.company_id = qy.company_id
       and k.year = qy.year
       and k.category = qy.category
       and k.category_name = qy.category_name
      left join (select tp.company_id, tp.year,tp.category, tp.category_name,sum(tp.sum_money) sho_order_original_money
                  from (select t3.company_id, t3.year,t3.category,t3.category_name,t3.satisfy_money sum_money
                          from scmdata.pt_ordered t3 ) tp
                          group by tp.company_id, tp.year, tp.category,tp.category_name )z1
        on k.company_id = z1.company_id
       and k.year = z1.year
       and k.category = z1.category
       and k.category_name = z1.category_name ]';
    V_W_SQL  := q'[
     where k.year  < to_char(sysdate,'yyyy')
      and k.year >=2022) tkb
      ON (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.category = tkb.category and tka.category_name = tkb.category_name)
     WHEN MATCHED THEN ]';
    V_W1_SQL := q'[
      where k.year  = to_char(sysdate,'yyyy')-1  ) tkb
      ON (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.category = tkb.category and tka.category_name = tkb.category_name)
     WHEN MATCHED THEN ]';

    V_U_SQL  := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.sho_order_money           = tkb.sho_order_money,
             tka.sho_order_20_money        = tkb.sho_order_money_desc,
             tka.delivery_money            = tkb.delivery_money,
             tka.delivery_order_money      = tkb.delivery_order_money,
             tka.delivery_order_20_money   = tkb.delivery_order_money_desc,
             tka.qua_order_money           = tkb.qua_order_money,
             tka.delivery_20_money         = tkb.delivery_20_money,
             tka.order_20_money            = tkb.order_20_money,
             tka.sho_order_original_money  = tkb.sho_order_original_money,
             tka.memo                      = '',
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U1_SQL := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.sho_order_money           = tkb.sho_order_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U2_SQL := q'[  UPDATE
         SET tka.order_20_money            = tkb.order_20_money,
             tka.sho_order_20_money        = tkb.sho_order_money_desc,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U3_SQL := q'[  UPDATE
         SET tka.delivery_money            = tkb.delivery_money,
             tka.delivery_order_money      = tkb.delivery_order_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U4_SQL := q'[  UPDATE
         SET tka.delivery_20_money         = tkb.delivery_20_money,
             tka.delivery_order_20_money   = tkb.delivery_order_money_desc,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U5_SQL := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.qua_order_money           = tkb.qua_order_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';

    /*只更新订单满足率(原值)指标*/
    V_U6_SQL := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.sho_order_original_money  = tkb.sho_order_original_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';

    V_IN_SQL := q'[
    WHEN NOT MATCHED THEN
      INSERT
        (tka.company_id,
         tka.year,
         tka.category_name,
         tka.category,
         tka.order_money,
         tka.sho_order_money,
         tka.sho_order_20_money,
         tka.delivery_money,
         tka.delivery_order_money,
         tka.delivery_order_20_money,
         tka.qua_order_money,
         tka.delivery_20_money,
         tka.order_20_money,
         tka.sho_order_original_money,
         tka.memo,
         tka.create_id,
         tka.create_time,
         tka.update_id,
         tka.update_time)
      VALUES
        (tkb.company_id,
         tkb.year,
         tkb.category_name,
         tkb.category,
         tkb.order_money,
         tkb.sho_order_money,
         tkb.sho_order_money_desc,
         tkb.delivery_money,
         tkb.delivery_order_money,
         tkb.delivery_order_money_desc,
         tkb.qua_order_money,
         tkb.delivery_20_money,
         tkb.order_20_money,
         tkb.sho_order_original_money,
         '',
         'ADMIN',
         sysdate,
         'ADMIN',
         sysdate)]';

    /*   t_type = 0 更新全部指标
    p_type = 0 更新全部历史数据   p_type = 1  只更新上年度的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
    end if;
    /*   t_type = 1 只更新到仓满足率指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上年度的数据 */
    if t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U1_SQL;
      end if;
    end if;
    /*   t_type = 2 只更新到前20%仓满足率指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上年度的数据 */
    if t_type = 2 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U2_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U2_SQL;
      end if;
    end if;
    /*   t_type = 3 只更新到仓补货平均交期指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上年度的数据 */
    if t_type = 3 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U3_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U3_SQL;
      end if;
    end if;
    /*   t_type = 4 只更新前20%到仓补货平均交期指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上年度的数据 */
    if t_type = 4 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U4_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U4_SQL;
      end if;
    end if;
    /*   t_type = 5 只更新质量问题订单不满足率指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上年度的数据 */
    if t_type = 5 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U5_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U5_SQL;
      end if;
    end if;
    /*   t_type = 6 只更新订单满足率(原值)指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 6 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U6_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U6_SQL;
      end if;
    end if;
    execute immediate V_SQL;
  END P_T_KPIORDER_YEAR;

  /*传入省、市、分类、产品、类别
  返回所在区域分组*/
  function f_get_groupname(f_company_province in varchar2,
                           f_company_city     in varchar2,
                           f_category         in varchar2,
                           f_product_cate     in varchar2,
                           f_compid           in varchar2) return varchar2 is
    t_p      clob;
    t_name   varchar2(2000);
    group_id varchar2(2000);
    V_C      varchar2(18) := null;
  begin
    if f_company_province is not null or f_company_city is not null then
      select listagg(t.group_area_config_id, ';') within group(order by t.pause)
        into t_p
        from scmdata.t_supplier_group_area_config t
       where t.pause = 1
         and scmdata.instr_priv(t.province_id, f_company_province) > 0
         and scmdata.instr_priv(t.city_id, f_company_city) > 0
         and t.company_id = f_compid;
      select t.group_config_id
        into group_id
        from scmdata.t_supplier_group_category_config t
       where t.pause = 1
         and scmdata.instr_priv(t.area_config_id, t_p) > 0
         and t.cooperation_classification = f_category
         and scmdata.instr_priv(t.cooperation_product_cate, f_product_cate) > 0
         and t.company_id = f_compid;
      select t.group_name
        into t_name
        from scmdata.t_supplier_group_config t
       where t.pause = 1
         and t.group_config_id = group_id
         and trunc(sysdate) between trunc(t.effective_time) and
             trunc(t.end_time)
         and t.company_id = f_compid;
      return t_name;
    else
      return null;
    end if;
  exception
    when no_data_found then
      return V_C;
  end f_get_groupname;

  /*获取当前的年、月 返回上下半年
    适合用于时间维度是半年度，每半年度更新一次数据
  返回半年度 */
  function f_yearmonth return number is
    p_year      number(4) := to_char(sysdate, 'yyyy');
    p_month     number(2) := to_char(sysdate, 'mm');
    p_halfyear  number(1);
    p_yearmonth number(5);
    v_year      number(4);
  begin
    if p_month in (01, 02, 03, 04, 05, 06) then
      p_halfyear := 2;
      v_year     := p_year - 1;
    else
      p_halfyear := 1;
      v_year     := p_year;
    end if;
    p_yearmonth := v_year || p_halfyear;
    return p_yearmonth;
  end;

  /*   t_type参数解析
  t_type = 0 更新全部指标
  t_type = 1 只更新到仓满足率指标  当指标只做更新不做插入
  t_type = 2 只更新到前20%仓满足率指标  当指标只做更新不做插入
  t_type = 3 只更新补货平均交期指标  当指标只做更新不做插入
  t_type = 4 只更新前20%补货平均交期指标  当指标只做更新不做插入
  t_type = 5 只更新质量问题订单不满足指标  当指标只做更新不做插入
        p_type参数解析
  p_type = 0 更新全部历史数据
  p_type = 1 只更新上一个维度（月份）的数据 */

  /*kpi指标订单满足率、前20%订单满足率、补货平均交期、前20%补货平均交期指标、质量问题订单不满足指标 更新表月份维度数据表

     修改次数
     2021-12-22上线区域组
     2022-02-28 因需求变更，更新补货平均交期、前20%补货平均交期分母的取数逻辑
     2022-03-23 因需求变更，更新订单满足率、前20%订单满足率分子的取数逻辑
     2022-04-06 因需求变更，更新订单满足率、前20%订单满足率分子的取数逻辑
     2022-04-08 因数据有问题，修改订单满足率、前20%订单满足率分子的取数全部来源于底层订单交期表
     2022-04-11 因底层订单交期表更改了责任部门，质量问题订单不满足、订单满足率、前20%订单满足率分子的责任部门全部修改
     2022-05-05 需求变更，修改订单满足率、前20%订单满足率、补货平均交期、前20%补货平均交期的取数逻辑分子分母都发生了改变
                剔除现货供应商、义乌供应商的数据
                订单满足率修改过滤条件、新增'无'也需要统计
                补货平均交期修改到仓时间为到仓确认时间、增加是生产订单过滤统计
                只更新2022往后的数据
     2022-05-07 修改到货金额的取值范围
     2022-05-11 新增到仓满足率(原值)指标、刷全部的历史数据，包括2021年
     2022-06-06 只刷新2022年数据
  统计维度：区域组
   时间维度：月度*/
  procedure P_T_KPIORDER_QU_MONTH(t_type number, p_type number) IS
    V_Q_SQL  clob;
    V_U_SQL  clob;
    V_W_SQL  clob;
    V_W1_SQL clob;
    V_U1_SQL clob;
    V_U2_SQL clob;
    V_U3_SQL clob;
    V_U4_SQL clob;
    V_U5_SQL clob;
    V_U6_SQL clob;
    V_IN_SQL clob;
    V_SQL    clob;
  BEGIN
    V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpiorder_qu_month tka
  USING (
      with kpi_order as
     (select t.company_id,t.year,t.month,t.group_name,sum(t.order_money) order_money
        from scmdata.pt_ordered t
       where t.factory_code not in ('C00563','C00216')
       group by t.company_id, t.year,t.month, t.group_name)
    select k.company_id, k.year, k.month, k.group_name, k.order_money,z.sho_order_money,d.sho_order_money_desc, y.delivery_money,
          qa.delivery_order_money,qw.delivery_order_money_desc,x.qua_order_money,qx.order_20_money,qy.delivery_20_money,z1.sho_order_original_money
      from kpi_order k
      left join (select t1.company_id, t1.year, t1.month, t1.group_name, sum(t1.order_money) qua_order_money
                   from scmdata.pt_ordered t1
                  inner join scmdata.sys_company_dept a
                     on a.company_id = t1.company_id
                    and a.company_dept_id = t1.responsible_dept
                    and a.pause = 0
                  where a.dept_name = '供应链管理部'
                    and t1.is_quality = 1
                  group by t1.company_id, t1.year, t1.month, t1.group_name) x
        on k.company_id = x.company_id
       and k.year = x.year
       and k.month = x.month
       and k.group_name = x.group_name
      left join (select t2.company_id, to_char(td.delivery_origin_time,'yyyy')year, to_char(td.delivery_origin_time,'mm')month, t2.group_name, sum(t2.fixed_price* td.delivery_amount) delivery_money
                   from scmdata.pt_ordered t2
                  inner join scmdata.t_delivery_record td
                     on td.order_code = t2.product_gress_code
                    and td.company_id = t2.company_id
                 inner join scmdata.t_ordered tor
                   on tor.order_code = t2.product_gress_code
                  and tor.company_id = t2.company_id
                  where t2.is_first_order = '0'   and tor.is_product_order = 1
                    and t2.factory_code not in ('C00563','C00216')
                  group by t2.company_id, to_char(td.delivery_origin_time,'yyyy'), to_char(td.delivery_origin_time,'mm'), t2.group_name) y
        on k.company_id = y.company_id
       and k.year = y.year
       and k.month = y.month
       and k.group_name = y.group_name
      left join (select tp.company_id, tp.year,tp.month, tp.group_name,sum(tp.sum_money) sho_order_money
                  from (select t3.company_id, t3.year,t3.month, t3.group_name,t3.satisfy_money sum_money
                          from scmdata.pt_ordered t3
                         where t3.factory_code not in ('C00563','C00216')
                         union all
                        select t3a.company_id,t3a.year,t3a.month, t3a.group_name, (t3a.order_money  - t3a.satisfy_money ) sum_money
                          from scmdata.pt_ordered t3a
                         inner join scmdata.sys_company_dept a
                            on a.company_id = t3a.company_id
                           and a.company_dept_id = t3a.responsible_dept
                           and a.pause = 0
                         where (a.dept_name like '%物流部%'or a.dept_name like '%品类部%'
                             or a.dept_name like '%事业部%' or a.dept_name = '无')
                           and t3a.factory_code not in ('C00563','C00216')) tp
                          group by tp.company_id, tp.year,tp.month, tp.group_name)z
        on k.company_id = z.company_id
       and k.year = z.year
       and k.month = z.month
       and k.group_name = z.group_name
      left join (select tp.company_id, tp.year,tp.month, tp.group_name,sum(tp.sum_money) sho_order_money_desc
                  from (select t3b.company_id, t3b.year,t3b.month, t3b.group_name,t3b.satisfy_money sum_money
                          from scmdata.pt_ordered t3b
                         where t3b.is_twenty = 1
                           and t3b.factory_code not in ('C00563','C00216')
                         union all
                        select t3c.company_id,t3c.year,t3c.month, t3c.group_name, (t3c.order_money  - t3c.satisfy_money ) sum_money
                          from scmdata.pt_ordered t3c
                         inner join scmdata.sys_company_dept a
                            on a.company_id = t3c.company_id
                           and a.company_dept_id = t3c.responsible_dept
                           and a.pause = 0
                         where t3c.is_twenty = 1
                           and (a.dept_name like '%物流部%'or a.dept_name like '%品类部%'
                             or a.dept_name like '%事业部%' or a.dept_name = '无')
                           and t3c.factory_code not in ('C00563','C00216')) tp
                         group by tp.company_id, tp.year,tp.month, tp.group_name)d
        on k.company_id = d.company_id
       and k.year = d.year
       and k.month = d.month
       and k.group_name = d.group_name
    left join (select ta0.company_id, ta0.year,ta0.month, ta0.group_name,sum(ta0.sum1_date*ta0.sum1_money) delivery_order_money
              from (select t5.company_id, to_char(tba.delivery_origin_time,'yyyy')year, to_char(tba.delivery_origin_time,'mm')month, t5.group_name,
                     (to_date(to_char(tba.delivery_origin_time, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                     to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                     (t5.fixed_price * tba.delivery_amount) sum1_money
                from scmdata.pt_ordered t5
                inner join scmdata.t_delivery_record tba
                  on t5.product_gress_code = tba.order_code
                 and t5.company_id = tba.company_id
                inner join scmdata.t_ordered tor
                   on tor.company_id = tba.company_id
                  and tor.order_code = tba.order_code
                inner join scmdata.t_commodity_info tb
                  on t5.goo_id = tb.rela_goo_id
                 and tb.goo_id = tba.goo_id
                 and t5.company_id = tb.company_id
               where t5.is_first_order = 0
                 and t5.factory_code not in ('C00563','C00216')
                 and tor.is_product_order = 1  )ta0
              group by ta0.company_id, ta0.year, ta0.month, ta0.group_name) qa
        on k.company_id = qa.company_id
       and k.year = qa.year
       and k.month = qa.month
       and k.group_name = qa.group_name
    left join (select t6.company_id, t6.year,t6.month, t6.group_name,sum(t6.sum2_date*t6.sum2_money) delivery_order_money_desc
                from (select t5a.company_id, to_char(tab.delivery_origin_time,'yyyy')year, to_char(tab.delivery_origin_time,'mm')month, t5a.group_name,
                       (to_date(to_char(tab.delivery_origin_time, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                       to_date(to_char(t5a.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum2_date,
                       (t5a.fixed_price * tab.delivery_amount) sum2_money
                  from scmdata.pt_ordered t5a
                  inner join scmdata.t_delivery_record tab
                    on t5a.product_gress_code = tab.order_code
                   and t5a.company_id = tab.company_id
                inner join scmdata.t_ordered tor
                   on tor.company_id = tab.company_id
                  and tor.order_code = tab.order_code
                  inner join scmdata.t_commodity_info tb
                    on t5a.goo_id = tb.rela_goo_id
                   and tb.goo_id = tab.goo_id
                   and t5a.company_id = tb.company_id
                 where t5a.is_first_order = 0
                   and t5a.is_twenty = 1
                   and tor.is_product_order = 1
                   and t5a.factory_code not in ('C00563','C00216'))t6
                group by t6.company_id, t6.year, t6.month, t6.group_name) qw
        on k.company_id = qw.company_id
       and k.year = qw.year
       and k.month = qw.month
       and k.group_name = qw.group_name
    left join (select t.company_id,t.year,t.month, t.group_name,sum(t.order_money) order_20_money
                 from scmdata.pt_ordered t
                where t.is_twenty =1
                  and t.factory_code not in ('C00563','C00216')
                group by t.company_id, t.year, t.month, t.group_name)qx
      on k.company_id = qx.company_id
     and k.year = qx.year
     and k.month = qx.month
     and k.group_name = qx.group_name
    left join (select t2.company_id, to_char(td.delivery_origin_time,'yyyy')year, to_char(td.delivery_origin_time,'mm')month, t2.group_name, sum(t2.fixed_price* td.delivery_amount) delivery_20_money
                 from scmdata.pt_ordered t2
                  inner join scmdata.t_delivery_record td
                     on td.order_code = t2.product_gress_code
                    and td.company_id = t2.company_id
                 inner join scmdata.t_ordered tor
                   on tor.order_code = t2.product_gress_code
                  and tor.company_id = t2.company_id
                where t2.is_first_order = '0' and t2.is_twenty = 1   and tor.is_product_order = 1
                  and t2.factory_code not in ('C00563','C00216')
                group by t2.company_id, to_char(td.delivery_origin_time,'yyyy'), to_char(td.delivery_origin_time,'mm'), t2.group_name) qy
      on k.company_id = qy.company_id
     and k.year = qy.year
     and k.month = qy.month
     and k.group_name = qy.group_name
      left join (select tp.company_id, tp.year,tp.month, tp.group_name,sum(tp.sum_money) sho_order_original_money
                  from (select t3.company_id, t3.year,t3.month, t3.group_name,t3.satisfy_money sum_money
                          from scmdata.pt_ordered t3
                         where t3.factory_code not in ('C00563','C00216')) tp
                          group by tp.company_id, tp.year,tp.month, tp.group_name)z1
        on k.company_id = z1.company_id
       and k.year = z1.year
       and k.month = z1.month
       and k.group_name = z1.group_name]';

    V_W_SQL := q'[
    where (k.year || lpad(k.month,2,0)) < to_char(sysdate,'yyyymm')
      and k.year >=2022 ) tkb
      ON (tka.company_id = tkb.company_id and tka.year = tkb.year  and tka.month = tkb.month and tka.groupname = tkb.group_name)
     WHEN MATCHED THEN]';

    V_W1_SQL := q'[
     where (k.year || lpad(k.month,2,0)) = to_char(add_months(sysdate,-1),'yyyymm')) tkb
      ON (tka.company_id = tkb.company_id and tka.year = tkb.year  and tka.month = tkb.month and tka.groupname = tkb.group_name)
     WHEN MATCHED THEN]';

    V_U_SQL  := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.sho_order_money           = tkb.sho_order_money,
             tka.sho_order_20_money        = tkb.sho_order_money_desc,
             tka.delivery_money            = tkb.delivery_money,
             tka.delivery_order_money      = tkb.delivery_order_money,
             tka.delivery_order_20_money   = tkb.delivery_order_money_desc,
             tka.qua_order_money           = tkb.qua_order_money,
             tka.delivery_20_money         = tkb.delivery_20_money,
             tka.order_20_money            = tkb.order_20_money,
             tka.sho_order_original_money  = tkb.sho_order_original_money,
             tka.memo                      = '',
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U1_SQL := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.sho_order_money           = tkb.sho_order_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U2_SQL := q'[  UPDATE
         SET tka.order_20_money            = tkb.order_20_money,
             tka.sho_order_20_money        = tkb.sho_order_money_desc,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U3_SQL := q'[  UPDATE
         SET tka.delivery_money            = tkb.delivery_money,
             tka.delivery_order_money      = tkb.delivery_order_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U4_SQL := q'[  UPDATE
         SET tka.delivery_20_money         = tkb.delivery_20_money,
             tka.delivery_order_20_money   = tkb.delivery_order_money_desc,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U5_SQL := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.qua_order_money           = tkb.qua_order_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    /*只更新订单满足率(原值)指标*/
    V_U6_SQL := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.sho_order_original_money  = tkb.sho_order_original_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';

    V_IN_SQL := q'[
    WHEN NOT MATCHED THEN
      INSERT
        (tka.t_kpiorder_qu_month_id,
         tka.company_id,
         tka.year,
         tka.month,
         tka.groupname,
         tka.order_money,
         tka.sho_order_money,
         tka.sho_order_20_money,
         tka.delivery_money,
         tka.delivery_order_money,
         tka.delivery_order_20_money,
         tka.qua_order_money,
         tka.delivery_20_money,
         tka.order_20_money,
         tka.sho_order_original_money,
         tka.memo,
         tka.create_id,
         tka.create_time,
         tka.update_id,
         tka.update_time)
      VALUES
        (scmdata.f_get_uuid(),
         tkb.company_id,
         tkb.year,
         tkb.month,
         tkb.group_name,
         tkb.order_money,
         tkb.sho_order_money,
         tkb.sho_order_money_desc,
         tkb.delivery_money,
         tkb.delivery_order_money,
         tkb.delivery_order_money_desc,
         tkb.qua_order_money,
         tkb.delivery_20_money,
         tkb.order_20_money,
         tkb.sho_order_original_money,
         '',
         'ADMIN',
         sysdate,
         'ADMIN',
         sysdate)]';
    /*   t_type = 0 更新全部指标
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
    end if;
    /*   t_type = 1 只更新到仓满足率指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U1_SQL;
      end if;
    end if;
    /*   t_type = 2 只更新到前20%仓满足率指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 2 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U2_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U2_SQL;
      end if;
    end if;
    /*   t_type = 3 只更新到仓补货平均交期指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 3 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U3_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U3_SQL;
      end if;
    end if;
    /*   t_type = 4 只更新前20%到仓补货平均交期指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 4 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U4_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U4_SQL;
      end if;
    end if;
    /*   t_type = 5 只更新质量问题订单不满足率指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 5 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U5_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U5_SQL;
      end if;
    end if;

    /*   t_type = 6 只更新订单满足率(原值)指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 6 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U6_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U6_SQL;
      end if;
    end if;
    execute immediate V_SQL;
  END P_T_KPIORDER_QU_MONTH;

  /*   t_type参数解析
  t_type = 0 更新全部指标
  t_type = 1 只更新到仓满足率指标  当指标只做更新不做插入
  t_type = 2 只更新到前20%仓满足率指标  当指标只做更新不做插入
  t_type = 3 只更新补货平均交期指标  当指标只做更新不做插入
  t_type = 4 只更新前20%补货平均交期指标  当指标只做更新不做插入
  t_type = 5 只更新质量问题订单不满足指标  当指标只做更新不做插入
        p_type参数解析
  p_type = 0 更新全部历史数据
  p_type = 1 只更新上一个维度（季度）的数据 */

  /*kpi指标订单满足率、前20%订单满足率、补货平均交期、前20%补货平均交期指标、质量问题订单不满足指标 更新表季度维度数据表

   修改次数
    2021-12-22上线区域组
    2022-02-28 因需求变更，更新补货平均交期、前20%补货平均交期分母的取数逻辑
    2022-03-23 因需求变更，更新订单满足率、前20%订单满足率分子的取数逻辑
    2022-04-06 因需求变更，更新订单满足率、前20%订单满足率分子的取数逻辑
    2022-04-08 因数据有问题，修改订单满足率、前20%订单满足率分子的取数全部来源于底层订单交期表
    2022-04-11 因底层订单交期表更改了责任部门，质量问题订单不满足、订单满足率、前20%订单满足率分子的责任部门全部修改
    2022-05-05 需求变更，修改订单满足率、前20%订单满足率、补货平均交期、前20%补货平均交期的取数逻辑分子分母都发生了改变
               剔除现货供应商、义乌供应商的数据
               订单满足率修改过滤条件、新增'无'也需要统计
               补货平均交期修改到仓时间为到仓确认时间、增加是生产订单过滤统计
               只更新2022往后的数据
     2022-05-07 修改到货金额的取值范围
     2022-05-11 新增到仓满足率(原值)指标、刷全部的历史数据，包括2021年
     2022-06-06 只刷新2022年数据
  统计维度：区域组
   时间维度：季度 */
  procedure P_T_KPIORDER_QU_QUARTER(t_type number, p_type number) IS
    V_Q_SQL  clob;
    V_U_SQL  clob;
    V_W_SQL  clob;
    V_W1_SQL clob;
    V_U1_SQL clob;
    V_U2_SQL clob;
    V_U3_SQL clob;
    V_U4_SQL clob;
    V_U5_SQL clob;
    V_U6_SQL clob;
    V_IN_SQL clob;
    V_SQL    clob;
  BEGIN
    V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpiorder_qu_quarter tka
  USING (
      with kpi_order as
     (select t.company_id,t.year,t.quarter,t.group_name,sum(t.order_money) order_money
        from scmdata.pt_ordered t
       where t.factory_code not in ('C00563','C00216')
       group by t.company_id, t.year,t.quarter, t.group_name)
    select k.company_id, k.year,k.quarter,k.group_name, k.order_money,z.sho_order_money,d.sho_order_money_desc, y.delivery_money,
          qa.delivery_order_money,qw.delivery_order_money_desc,x.qua_order_money, qx.order_20_money, qy.delivery_20_money,z1.sho_order_original_money
      from kpi_order k
      left join (select t1.company_id, t1.year,t1.quarter, t1.group_name, sum(t1.order_money) qua_order_money
                   from scmdata.pt_ordered t1
                  inner join scmdata.sys_company_dept a
                     on a.company_id = t1.company_id
                    and a.company_dept_id = t1.responsible_dept
                    and a.pause = 0
                  where a.dept_name = '供应链管理部'
                    and t1.is_quality = 1
                  group by t1.company_id, t1.year,t1.quarter,t1.group_name) x
        on k.company_id = x.company_id
       and k.year = x.year
       and k.quarter = x.quarter
       and k.group_name = x.group_name
      left join (select t2.company_id, to_char(td.delivery_origin_time,'yyyy')year, to_char(td.delivery_origin_time,'Q')quarter,t2.group_name, sum(t2.fixed_price* td.delivery_amount) delivery_money
                   from scmdata.pt_ordered t2
                  inner join scmdata.t_delivery_record td
                     on td.order_code = t2.product_gress_code
                    and td.company_id = t2.company_id
                  inner join scmdata.t_ordered tor
                     on tor.order_code = t2.product_gress_code
                    and tor.company_id = t2.company_id
                  where t2.is_first_order = '0' and tor.is_product_order = 1
                    and t2.factory_code not in ('C00563','C00216')
                  group by t2.company_id, to_char(td.delivery_origin_time,'yyyy'), to_char(td.delivery_origin_time,'Q'), t2.group_name) y
        on k.company_id = y.company_id
       and k.year = y.year
       and k.quarter = y.quarter
       and k.group_name = y.group_name
      left join (select tp.company_id, tp.year,tp.quarter, tp.group_name,sum(tp.sum_money) sho_order_money
                  from (select t3.company_id, t3.year,t3.quarter,t3.group_name,t3.satisfy_money sum_money
                          from scmdata.pt_ordered t3
                         where t3.factory_code not in ('C00563','C00216')
                          union all
                        select t3a.company_id,t3a.year,t3a.quarter, t3a.group_name, (t3a.order_money  - t3a.satisfy_money ) sum_money
                          from scmdata.pt_ordered t3a
                         inner join scmdata.sys_company_dept a
                            on a.company_id = t3a.company_id
                           and a.company_dept_id = t3a.responsible_dept
                           and a.pause = 0
                         where (a.dept_name like '%物流部%'or a.dept_name like '%品类部%'
                            or a.dept_name like '%事业部%' or a.dept_name = '无')
                           and t3a.factory_code not in ('C00563','C00216') ) tp
                          group by tp.company_id, tp.year,tp.quarter,tp.group_name)z
        on k.company_id = z.company_id
       and k.year = z.year
       and k.quarter = z.quarter
       and k.group_name = z.group_name
      left join (select tp.company_id, tp.year,tp.quarter,tp.group_name,sum(tp.sum_money) sho_order_money_desc
                  from (select t3b.company_id, t3b.year,t3b.quarter,t3b.group_name,t3b.satisfy_money sum_money
                          from scmdata.pt_ordered t3b
                         where t3b.is_twenty = 1
                           and t3b.factory_code not in ('C00563','C00216')
                        union all
                        select t3c.company_id,t3c.year,t3c.quarter,t3c.group_name, (t3c.order_money  - t3c.satisfy_money ) sum_money
                          from scmdata.pt_ordered t3c
                         inner join scmdata.sys_company_dept a
                            on a.company_id = t3c.company_id
                           and a.company_dept_id = t3c.responsible_dept
                           and a.pause = 0
                         where t3c.is_twenty = 1
                           and t3c.factory_code not in ('C00563','C00216')
                           and (a.dept_name like '%物流部%'or a.dept_name like '%品类部%'
                             or a.dept_name like '%事业部%' or a.dept_name = '无') ) tp
                          group by tp.company_id, tp.year,tp.quarter,tp.group_name)d
        on k.company_id = d.company_id
       and k.year = d.year
       and k.quarter = d.quarter
       and k.group_name = d.group_name
    left join (select ta0.company_id, ta0.year,ta0.quarter,ta0.group_name,sum(ta0.sum1_date*ta0.sum1_money) delivery_order_money
              from (select t5.company_id, to_char(tba.delivery_origin_time,'yyyy')year, to_char(tba.delivery_origin_time,'Q')quarter, t5.group_name,
                     (to_date(to_char(tba.delivery_origin_time, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                     to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                     (t5.fixed_price * tba.delivery_amount) sum1_money
                from scmdata.pt_ordered t5
                inner join scmdata.t_delivery_record tba
                  on t5.product_gress_code = tba.order_code
                 and t5.company_id = tba.company_id
                inner join scmdata.t_ordered tor
                   on tor.company_id = tba.company_id
                  and tor.order_code = tba.order_code
                inner join scmdata.t_commodity_info tb
                  on t5.goo_id = tb.rela_goo_id
                 and tb.goo_id = tba.goo_id
                 and t5.company_id = tb.company_id
               where t5.is_first_order = 0
                 and tor.is_product_order = 1
                 and t5.factory_code not in ('C00563','C00216'))ta0
              group by ta0.company_id, ta0.year,ta0.quarter,ta0.group_name) qa
        on k.company_id = qa.company_id
       and k.year = qa.year
       and k.quarter = qa.quarter
       and k.group_name = qa.group_name
    left join (select t6.company_id, t6.year,t6.quarter,t6.group_name,sum(t6.sum2_date*t6.sum2_money) delivery_order_money_desc
                from (select t5a.company_id, to_char(tab.delivery_origin_time,'yyyy')year, to_char(tab.delivery_origin_time,'Q')quarter,t5a.group_name,
                       (to_date(to_char(tab.delivery_origin_time, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                       to_date(to_char(t5a.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum2_date,
                       (t5a.fixed_price * tab.delivery_amount) sum2_money
                  from scmdata.pt_ordered t5a
                 inner join scmdata.t_delivery_record tab
                    on t5a.product_gress_code = tab.order_code
                   and t5a.company_id = tab.company_id
                inner join scmdata.t_ordered tor
                   on tor.company_id = tab.company_id
                  and tor.order_code = tab.order_code
                 inner join scmdata.t_commodity_info tb
                    on t5a.goo_id = tb.rela_goo_id
                   and tb.goo_id = tab.goo_id
                   and t5a.company_id = tb.company_id
                 where t5a.is_first_order = 0
                   and t5a.is_twenty = 1
                 and tor.is_product_order = 1
                   and t5a.factory_code not in ('C00563','C00216'))t6
                group by t6.company_id, t6.year,t6.quarter,t6.group_name) qw
        on k.company_id = qw.company_id
       and k.year = qw.year
       and k.quarter = qw.quarter
       and k.group_name = qw.group_name
      left join (select t.company_id,t.year,t.quarter, t.group_name,sum(t.order_money) order_20_money
                   from scmdata.pt_ordered t
                  where t.is_twenty =1
                    and t.factory_code not in ('C00563','C00216')
                  group by t.company_id, t.year, t.quarter, t.group_name)qx
        on k.company_id = qx.company_id
       and k.year = qx.year
       and k.quarter = qx.quarter
       and k.group_name = qx.group_name
      left join (select t2.company_id, to_char(td.delivery_origin_time,'yyyy')year, to_char(td.delivery_origin_time,'Q')quarter, t2.group_name, sum(t2.fixed_price* td.delivery_amount) delivery_20_money
                     from scmdata.pt_ordered t2
                     inner join scmdata.t_ordered tor
                       on tor.order_code = t2.product_gress_code
                      and tor.company_id = t2.company_id
                  inner join scmdata.t_delivery_record td
                     on td.order_code = t2.product_gress_code
                    and td.company_id = t2.company_id
                    where t2.is_first_order = '0' and t2.is_twenty = 1   and tor.is_product_order = 1
                      and t2.factory_code not in ('C00563','C00216')
                    group by t2.company_id, to_char(td.delivery_origin_time,'yyyy'), to_char(td.delivery_origin_time,'Q'), t2.group_name) qy
        on k.company_id = qy.company_id
       and k.year = qy.year
       and k.quarter = qy.quarter
       and k.group_name = qy.group_name
      left join (select tp.company_id, tp.year,tp.quarter, tp.group_name,sum(tp.sum_money) sho_order_original_money
                  from (select t3.company_id, t3.year,t3.quarter,t3.group_name,t3.satisfy_money sum_money
                          from scmdata.pt_ordered t3
                         where t3.factory_code not in ('C00563','C00216')) tp
                          group by tp.company_id, tp.year,tp.quarter, tp.group_name)z1
        on k.company_id = z1.company_id
       and k.year = z1.year
       and k.quarter = z1.quarter
       and k.group_name = z1.group_name]';

    V_W_SQL := q'[
     where (k.year || k.quarter) <= (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q'))
      and k.year >=2022 ) tkb
      ON (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.quarter = tkb.quarter and tka.groupname = tkb.group_name)
     WHEN MATCHED THEN]';

    V_W1_SQL := q'[
     where (k.year || k.quarter) = (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q')) ) tkb
      ON (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.quarter = tkb.quarter and tka.groupname = tkb.group_name)
     WHEN MATCHED THEN]';

    V_U_SQL  := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.sho_order_money           = tkb.sho_order_money,
             tka.sho_order_20_money        = tkb.sho_order_money_desc,
             tka.delivery_money            = tkb.delivery_money,
             tka.delivery_order_money      = tkb.delivery_order_money,
             tka.delivery_order_20_money   = tkb.delivery_order_money_desc,
             tka.qua_order_money           = tkb.qua_order_money,
             tka.delivery_20_money         = tkb.delivery_20_money,
             tka.order_20_money            = tkb.order_20_money,
             tka.sho_order_original_money  = tkb.sho_order_original_money,
             tka.memo                      = '',
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U1_SQL := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.sho_order_money           = tkb.sho_order_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U2_SQL := q'[  UPDATE
         SET tka.order_20_money            = tkb.order_20_money,
             tka.sho_order_20_money        = tkb.sho_order_money_desc,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U3_SQL := q'[  UPDATE
         SET tka.delivery_money            = tkb.delivery_money,
             tka.delivery_order_money      = tkb.delivery_order_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U4_SQL := q'[  UPDATE
         SET tka.delivery_20_money         = tkb.delivery_20_money,
             tka.delivery_order_20_money   = tkb.delivery_order_money_desc,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U5_SQL := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.qua_order_money           = tkb.qua_order_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    /*只更新订单满足率(原值)指标*/
    V_U6_SQL := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.sho_order_original_money  = tkb.sho_order_original_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_IN_SQL := q'[
    WHEN NOT MATCHED THEN
      INSERT
        (t_kpiorder_qu_quarter_id,
         tka.company_id,
         tka.year,
         tka.quarter,
         tka.groupname,
         tka.order_money,
         tka.sho_order_money,
         tka.sho_order_20_money,
         tka.delivery_money,
         tka.delivery_order_money,
         tka.delivery_order_20_money,
         tka.qua_order_money,
         tka.delivery_20_money,
         tka.order_20_money,
         tka.sho_order_original_money,
         tka.memo,
         tka.create_id,
         tka.create_time,
         tka.update_id,
         tka.update_time)
      VALUES
        (scmdata.f_get_uuid(),
         tkb.company_id,
         tkb.year,
         tkb.quarter,
         tkb.group_name,
         tkb.order_money,
         tkb.sho_order_money,
         tkb.sho_order_money_desc,
         tkb.delivery_money,
         tkb.delivery_order_money,
         tkb.delivery_order_money_desc,
         tkb.qua_order_money,
         tkb.delivery_20_money,
         tkb.order_20_money,
         tkb.sho_order_original_money,
         '',
         'ADMIN',
         sysdate,
         'ADMIN',
         sysdate)]';
    /*   t_type = 0 更新全部指标
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
    end if;
    /*   t_type = 1 只更新到仓满足率指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U1_SQL;
      end if;
    end if;
    /*   t_type = 2 只更新到前20%仓满足率指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 2 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U2_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U2_SQL;
      end if;
    end if;
    /*   t_type = 3 只更新到仓补货平均交期指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 3 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U3_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U3_SQL;
      end if;
    end if;
    /*   t_type = 4 只更新前20%到仓补货平均交期指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 4 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U4_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U4_SQL;
      end if;
    end if;
    /*   t_type = 5 只更新质量问题订单不满足率指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 5 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U5_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U5_SQL;
      end if;
    end if;

    /*   t_type = 6 只更新订单满足率(原值)指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 6 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U6_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U6_SQL;
      end if;
    end if;
    execute immediate V_SQL;
  END P_T_KPIORDER_QU_QUARTER;

  /*   t_type参数解析
  t_type = 0 更新全部指标
  t_type = 1 只更新到仓满足率指标  当指标只做更新不做插入
  t_type = 2 只更新到前20%仓满足率指标  当指标只做更新不做插入
  t_type = 3 只更新补货平均交期指标  当指标只做更新不做插入
  t_type = 4 只更新前20%补货平均交期指标  当指标只做更新不做插入
  t_type = 5 只更新质量问题订单不满足指标  当指标只做更新不做插入
        p_type参数解析
  p_type = 0 更新全部历史数据
  p_type = 1 只更新上一个维度（半年度）的数据 */

  /*kpi指标订单满足率、前20%订单满足率、补货平均交期、前20%补货平均交期指标、质量问题订单不满足指标 更新表半年度维度数据表

    修改次数
     2021-12-22上线区域组
     2022-02-28 因需求变更，更新补货平均交期、前20%补货平均交期分母的取数逻辑
     2022-03-23 因需求变更，更新订单满足率、前20%订单满足率分子的取数逻辑
     2022-04-06 因需求变更，更新订单满足率、前20%订单满足率分子的取数逻辑
     2022-04-08 因数据有问题，修改订单满足率、前20%订单满足率分子的取数全部来源于底层订单交期表
     2022-04-11 因底层订单交期表更改了责任部门，质量问题订单不满足、订单满足率、前20%订单满足率分子的责任部门全部修改
     2022-05-05 需求变更，修改订单满足率、前20%订单满足率、补货平均交期、前20%补货平均交期的取数逻辑分子分母都发生了改变
                剔除现货供应商、义乌供应商的数据
                订单满足率修改过滤条件、新增'无'也需要统计
                补货平均交期修改到仓时间为到仓确认时间、增加是生产订单过滤统计
                只更新2022往后的数据
     2022-05-07 修改到货金额的取值范围
     2022-05-11 新增到仓满足率(原值)指标、刷全部的历史数据，包括2021年
     2022-06-06 只刷新2022年数据
   统计维度：区域组
  时间维度：半年度 */
  procedure P_T_KPIORDER_QU_HALFYEAR(t_type number, p_type number) IS
    V_Q_SQL  clob;
    V_U_SQL  clob;
    V_W_SQL  clob;
    V_W1_SQL clob;
    V_U1_SQL clob;
    V_U2_SQL clob;
    V_U3_SQL clob;
    V_U4_SQL clob;
    V_U5_SQL clob;
    V_U6_SQL clob;
    V_IN_SQL clob;
    V_SQL    clob;
  BEGIN
    V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpiorder_qu_halfyear tka
  USING (
      with kpi_order as
     (select t.company_id,t.year,decode(t.quarter,1,1,2,1,3,2,4,2)halfyear,t.group_name,sum(t.order_money) order_money
        from scmdata.pt_ordered t
       where t.factory_code not in ('C00563','C00216')
       group by t.company_id, t.year,decode(t.quarter,1,1,2,1,3,2,4,2),t.group_name)
    select k.company_id, k.year,k.halfyear,k.group_name, k.order_money,z.sho_order_money,d.sho_order_money_desc, y.delivery_money,
           qa.delivery_order_money,qw.delivery_order_money_desc,x.qua_order_money, qx.order_20_money, qy.delivery_20_money,z1.sho_order_original_money
      from kpi_order k
      left join (select t1.company_id, t1.year,decode(t1.quarter,1,1,2,1,3,2,4,2)halfyear,t1.group_name, sum(t1.order_money) qua_order_money
                   from scmdata.pt_ordered t1
                  inner join scmdata.sys_company_dept a
                     on a.company_id = t1.company_id
                    and a.company_dept_id = t1.responsible_dept
                    and a.pause = 0
                  where a.dept_name = '供应链管理部'
                    and t1.is_quality = 1
                  group by t1.company_id, t1.year, decode(t1.quarter,1,1,2,1,3,2,4,2),t1.group_name) x
        on k.company_id = x.company_id
       and k.year = x.year
       and k.halfyear = x.halfyear
       and k.group_name = x.group_name
      left join (select t2.company_id, to_char(td.delivery_origin_time,'yyyy')year, decode(to_char(td.delivery_origin_time,'Q'),1,1,2,1,3,2,4,2) halfyear,
                         t2.group_name, sum(t2.fixed_price* td.delivery_amount) delivery_money
                   from scmdata.pt_ordered t2
                  inner join scmdata.t_delivery_record td
                     on td.order_code = t2.product_gress_code
                    and td.company_id = t2.company_id
                     inner join scmdata.t_ordered tor
                       on tor.order_code = t2.product_gress_code
                      and tor.company_id = t2.company_id
                  where t2.is_first_order = '0'  and tor.is_product_order = 1
                    and t2.factory_code not in ('C00563','C00216')
                  group by t2.company_id, to_char(td.delivery_origin_time,'yyyy'), decode(to_char(td.delivery_origin_time,'Q'),1,1,2,1,3,2,4,2), t2.group_name) y
        on k.company_id = y.company_id
       and k.year = y.year
       and k.halfyear = y.halfyear
       and k.group_name = y.group_name
      left join (select tp.company_id, tp.year,tp.halfyear, tp.group_name,sum(tp.sum_money) sho_order_money
                  from (select t3.company_id, t3.year,decode(t3.quarter,1,1,2,1,3,2,4,2)halfyear, t3.group_name,t3.satisfy_money sum_money
                          from scmdata.pt_ordered t3
                          where t3.factory_code not in ('C00563','C00216')
                          union all
                        select t3a.company_id,t3a.year,decode(t3a.quarter,1,1,2,1,3,2,4,2)halfyear,t3a.group_name, (t3a.order_money  - t3a.satisfy_money ) sum_money
                          from scmdata.pt_ordered t3a
                         inner join scmdata.sys_company_dept a
                            on a.company_id = t3a.company_id
                           and a.company_dept_id = t3a.responsible_dept
                           and a.pause = 0
                         where (a.dept_name like '%物流部%'or a.dept_name like '%品类部%'
                             or a.dept_name like '%事业部%' or a.dept_name = '无')
                           and t3a.factory_code not in ('C00563','C00216') ) tp
                          group by tp.company_id, tp.year,tp.halfyear, tp.group_name)z
        on k.company_id = z.company_id
       and k.year = z.year
       and k.halfyear = z.halfyear
       and k.group_name = z.group_name
      left join (select tp.company_id, tp.year,tp.halfyear, tp.group_name,sum(tp.sum_money) sho_order_money_desc
                  from (select t3b.company_id, t3b.year,decode(t3b.quarter,1,1,2,1,3,2,4,2)halfyear, t3b.group_name,t3b.satisfy_money sum_money
                          from scmdata.pt_ordered t3b
                         where t3b.is_twenty = 1
                           and t3b.factory_code not in ('C00563','C00216')
                        union all
                        select t3c.company_id,t3c.year,decode(t3c.quarter,1,1,2,1,3,2,4,2)halfyear,t3c.group_name,
                               (t3c.order_money  - t3c.satisfy_money ) sum_money
                          from scmdata.pt_ordered t3c
                         inner join scmdata.sys_company_dept a
                            on a.company_id = t3c.company_id
                           and a.company_dept_id = t3c.responsible_dept
                           and a.pause = 0
                         where t3c.is_twenty = 1
                           and t3c.factory_code not in ('C00563','C00216')
                           and (a.dept_name like '%物流部%'or a.dept_name like '%品类部%'
                             or a.dept_name like '%事业部%' or a.dept_name = '无') ) tp
                          group by tp.company_id, tp.year,tp.halfyear, tp.group_name)d
        on k.company_id = d.company_id
       and k.year = d.year
       and k.halfyear = d.halfyear
       and k.group_name = d.group_name
      left join (select ta0.company_id, ta0.year,ta0.halfyear, ta0.group_name,sum(ta0.sum1_date*ta0.sum1_money) delivery_order_money
              from (select t5.company_id, to_char(tba.delivery_origin_time,'yyyy')year, decode(to_char(tba.delivery_origin_time,'Q'),1,1,2,1,3,2,4,2) halfyear, t5.group_name,
                     (to_date(to_char(tba.delivery_origin_time, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                     to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                     (t5.fixed_price * tba.delivery_amount) sum1_money
                from scmdata.pt_ordered t5
                left join scmdata.t_delivery_record tba
                  on t5.product_gress_code = tba.order_code
                 and t5.company_id = tba.company_id
                inner join scmdata.t_ordered tor
                   on tor.company_id = tba.company_id
                  and tor.order_code = tba.order_code
                left join scmdata.t_commodity_info tb
                  on t5.goo_id = tb.rela_goo_id
                 and tb.goo_id = tba.goo_id
                 and t5.company_id = tb.company_id
               where t5.is_first_order = 0
                 and tor.is_product_order = 1
                 and t5.factory_code not in ('C00563','C00216'))ta0
              group by ta0.company_id, ta0.year, ta0.halfyear, ta0.group_name) qa
        on k.company_id = qa.company_id
       and k.year = qa.year
       and k.halfyear = qa.halfyear
       and k.group_name = qa.group_name
      left join (select t6.company_id, t6.year,t6.halfyear,t6.group_name,sum(t6.sum2_date*t6.sum2_money) delivery_order_money_desc
                from (select t5a.company_id, to_char(tab.delivery_origin_time,'yyyy')year, decode(to_char(tab.delivery_origin_time,'Q'),1,1,2,1,3,2,4,2) halfyear, t5a.group_name,
                       (to_date(to_char(tab.delivery_origin_time, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                       to_date(to_char(t5a.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum2_date,
                       (t5a.fixed_price * tab.delivery_amount) sum2_money
                  from scmdata.pt_ordered t5a
                  left join scmdata.t_delivery_record tab
                    on t5a.product_gress_code = tab.order_code
                   and t5a.company_id = tab.company_id
                inner join scmdata.t_ordered tor
                   on tor.company_id = tab.company_id
                  and tor.order_code = tab.order_code
                  left join scmdata.t_commodity_info tb
                    on t5a.goo_id = tb.rela_goo_id
                   and tb.goo_id = tab.goo_id
                   and t5a.company_id = tb.company_id
                 where t5a.is_first_order = 0
                   and t5a.is_twenty = 1
                   and tor.is_product_order = 1
                   and t5a.factory_code not in ('C00563','C00216'))t6
                group by t6.company_id, t6.year,t6.halfyear,t6.group_name) qw
        on k.company_id = qw.company_id
       and k.year = qw.year
       and k.halfyear = qw.halfyear
       and k.group_name = qw.group_name
      left join (select t.company_id,t.year,decode(t.quarter,1,1,2,1,3,2,4,2) halfyear, t.group_name,sum(t.order_money) order_20_money
                   from scmdata.pt_ordered t
                  where t.is_twenty =1
                    and t.factory_code not in ('C00563','C00216')
                  group by t.company_id, t.year, decode(t.quarter,1,1,2,1,3,2,4,2), t.group_name)qx
        on k.company_id = qx.company_id
       and k.year = qx.year
       and k.halfyear = qx.halfyear
       and k.group_name = qx.group_name
      left join (select t2.company_id, to_char(td.delivery_origin_time,'yyyy')year, decode(to_char(td.delivery_origin_time,'Q'),1,1,2,1,3,2,4,2) halfyear,
                        t2.group_name, sum(t2.fixed_price* td.delivery_amount) delivery_20_money
                     from scmdata.pt_ordered t2
                  inner join scmdata.t_delivery_record td
                     on td.order_code = t2.product_gress_code
                    and td.company_id = t2.company_id
                     inner join scmdata.t_ordered tor
                       on tor.order_code = t2.product_gress_code
                      and tor.company_id = t2.company_id
                    where t2.is_first_order = '0' and t2.is_twenty = 1    and tor.is_product_order = 1
                      and t2.factory_code not in ('C00563','C00216')
                    group by t2.company_id, to_char(td.delivery_origin_time,'yyyy'), decode(to_char(td.delivery_origin_time,'Q'),1,1,2,1,3,2,4,2), t2.group_name) qy
        on k.company_id = qy.company_id
       and k.year = qy.year
       and k.halfyear = qy.halfyear
       and k.group_name = qy.group_name
      left join (select tp.company_id, tp.year,tp.halfyear, tp.group_name,sum(tp.sum_money)sho_order_original_money
                  from (select t3.company_id, t3.year,decode(t3.quarter,1,1,2,1,3,2,4,2)halfyear, t3.group_name,t3.satisfy_money sum_money
                          from scmdata.pt_ordered t3
                          where t3.factory_code not in ('C00563','C00216')  ) tp
                          group by tp.company_id, tp.year,tp.halfyear, tp.group_name)z1
        on k.company_id = z1.company_id
       and k.year = z1.year
       and k.halfyear = z1.halfyear
       and k.group_name = z1.group_name ]';

    V_W_SQL := q'[
     where (k.year || k.halfyear) <= pkg_kpipt_order.f_yearmonth
      and k.year >=2022 ) tkb
      ON (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.is_halfyear = tkb.halfyear and tka.groupname = tkb.group_name)
     WHEN MATCHED THEN]';

    V_W1_SQL := q'[
     where (k.year || k.halfyear) = pkg_kpipt_order.f_yearmonth ) tkb
      ON (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.is_halfyear = tkb.halfyear and tka.groupname = tkb.group_name)
     WHEN MATCHED THEN]';

    V_U_SQL  := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.sho_order_money           = tkb.sho_order_money,
             tka.sho_order_20_money        = tkb.sho_order_money_desc,
             tka.delivery_money            = tkb.delivery_money,
             tka.delivery_order_money      = tkb.delivery_order_money,
             tka.delivery_order_20_money   = tkb.delivery_order_money_desc,
             tka.qua_order_money           = tkb.qua_order_money,
             tka.delivery_20_money         = tkb.delivery_20_money,
             tka.order_20_money            = tkb.order_20_money,
             tka.sho_order_original_money  = tkb.sho_order_original_money,
             tka.memo                      = '',
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U1_SQL := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.sho_order_money           = tkb.sho_order_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U2_SQL := q'[  UPDATE
         SET tka.order_20_money            = tkb.order_20_money,
             tka.sho_order_20_money        = tkb.sho_order_money_desc,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U3_SQL := q'[  UPDATE
         SET tka.delivery_money            = tkb.delivery_money,
             tka.delivery_order_money      = tkb.delivery_order_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U4_SQL := q'[  UPDATE
         SET tka.delivery_20_money         = tkb.delivery_20_money,
             tka.delivery_order_20_money   = tkb.delivery_order_money_desc,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U5_SQL := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.qua_order_money           = tkb.qua_order_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    /*只更新订单满足率(原值)指标*/
    V_U6_SQL := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.sho_order_original_money  = tkb.sho_order_original_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';

    V_IN_SQL := q'[
    WHEN NOT MATCHED THEN
      INSERT
        (t_kpiorder_qu_halfyear_id,
         tka.company_id,
         tka.year,
         tka.is_halfyear,
         tka.groupname,
         tka.order_money,
         tka.sho_order_money,
         tka.sho_order_20_money,
         tka.delivery_money,
         tka.delivery_order_money,
         tka.delivery_order_20_money,
         tka.qua_order_money,
         tka.delivery_20_money,
         tka.order_20_money,
         tka.sho_order_original_money,
         tka.memo,
         tka.create_id,
         tka.create_time,
         tka.update_id,
         tka.update_time)
      VALUES
        (scmdata.f_get_uuid(),
         tkb.company_id,
         tkb.year,
         tkb.halfyear,
         tkb.group_name,
         tkb.order_money,
         tkb.sho_order_money,
         tkb.sho_order_money_desc,
         tkb.delivery_money,
         tkb.delivery_order_money,
         tkb.delivery_order_money_desc,
         tkb.qua_order_money,
         tkb.delivery_20_money,
         tkb.order_20_money,
         tkb.sho_order_original_money,
         '',
         'ADMIN',
         sysdate,
         'ADMIN',
         sysdate)]';
    /*   t_type = 0 更新全部指标
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
    end if;
    /*   t_type = 1 只更新到仓满足率指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U1_SQL;
      end if;
    end if;
    /*   t_type = 2 只更新到前20%仓满足率指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 2 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U2_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U2_SQL;
      end if;
    end if;
    /*   t_type = 3 只更新到仓补货平均交期指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 3 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U3_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U3_SQL;
      end if;
    end if;
    /*   t_type = 4 只更新前20%到仓补货平均交期指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 4 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U4_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U4_SQL;
      end if;
    end if;
    /*   t_type = 5 只更新质量问题订单不满足率指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 5 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U5_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U5_SQL;
      end if;
    end if;

    /*   t_type = 6 只更新订单满足率(原值)指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 6 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U6_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U6_SQL;
      end if;
    end if;
    execute immediate V_SQL;
  END P_T_KPIORDER_QU_HALFYEAR;

  /*   t_type参数解析
  t_type = 0 更新全部指标
  t_type = 1 只更新到仓满足率指标  当指标只做更新不做插入
  t_type = 2 只更新到前20%仓满足率指标  当指标只做更新不做插入
  t_type = 3 只更新补货平均交期指标  当指标只做更新不做插入
  t_type = 4 只更新前20%补货平均交期指标  当指标只做更新不做插入
  t_type = 5 只更新质量问题订单不满足指标  当指标只做更新不做插入
        p_type参数解析
  p_type = 0 更新全部历史数据
  p_type = 1 只更新上一个维度（年度）的数据 */

  /*kpi指标订单满足率、前20%订单满足率、补货平均交期、前20%补货平均交期指标、质量问题订单不满足指标 更新表年度维度数据表

    修改次数
    2021-12-22上线区域组
    2022-02-28 因需求变更，更新补货平均交期、前20%补货平均交期分母的取数逻辑
    2022-03-23 因需求变更，更新订单满足率、前20%订单满足率分子的取数逻辑
    2022-04-06 因需求变更，更新订单满足率、前20%订单满足率分子的取数逻辑
    2022-04-08 因数据有问题，修改订单满足率、前20%订单满足率分子的取数全部来源于底层订单交期表
    2022-04-11 因底层订单交期表更改了责任部门，质量问题订单不满足、订单满足率、前20%订单满足率分子的责任部门全部修改
    2022-05-05 需求变更，修改订单满足率、前20%订单满足率、补货平均交期、前20%补货平均交期的取数逻辑分子分母都发生了改变
               剔除现货供应商、义乌供应商的数据
               订单满足率修改过滤条件、新增'无'也需要统计
               补货平均交期修改到仓时间为到仓确认时间、增加是生产订单过滤统计
               只更新2022往后的数据
     2022-05-07 修改到货金额的取值范围
     2022-05-11 新增到仓满足率(原值)指标、刷全部的历史数据，包括2021年
     2022-06-06 只刷新2022年数据
  统计维度：区域组
  时间维度：年度 */
  procedure P_T_KPIORDER_QU_YEAR(t_type number, p_type number) IS
    V_Q_SQL  clob;
    V_U_SQL  clob;
    V_W_SQL  clob;
    V_W1_SQL clob;
    V_U1_SQL clob;
    V_U2_SQL clob;
    V_U3_SQL clob;
    V_U4_SQL clob;
    V_U5_SQL clob;
    V_U6_SQL clob;
    V_IN_SQL clob;
    V_SQL    clob;
  BEGIN
    V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpiorder_qu_year tka
  USING (
      with kpi_order as
     (select t.company_id,t.year,t.group_name,sum(t.order_money) order_money
        from scmdata.pt_ordered t
       where t.factory_code not in ('C00563','C00216')
       group by t.company_id, t.year, t.group_name)
    select k.company_id, k.year, k.group_name, k.order_money,z.sho_order_money,d.sho_order_money_desc, y.delivery_money,
          qa.delivery_order_money,qw.delivery_order_money_desc,x.qua_order_money, qx.order_20_money, qy.delivery_20_money,z1.sho_order_original_money
      from kpi_order k
      left join (select t1.company_id, t1.year,t1.group_name, sum(t1.order_money) qua_order_money
                   from scmdata.pt_ordered t1
                  inner join scmdata.sys_company_dept a
                     on a.company_id = t1.company_id
                    and a.company_dept_id = t1.responsible_dept
                    and a.pause = 0
                  where a.dept_name = '供应链管理部'
                    and t1.is_quality = 1
                  group by t1.company_id, t1.year, t1.group_name) x
        on k.company_id = x.company_id
       and k.year = x.year
       and k.group_name = x.group_name
      left join (select t2.company_id, to_char(td.delivery_origin_time,'yyyy')year, t2.group_name, sum(t2.fixed_price* td.delivery_amount) delivery_money
                   from scmdata.pt_ordered t2
                  inner join scmdata.t_delivery_record td
                     on td.order_code = t2.product_gress_code
                    and td.company_id = t2.company_id
                   inner join scmdata.t_ordered tor
                     on tor.order_code = t2.product_gress_code
                    and tor.company_id = t2.company_id
                  where t2.is_first_order = '0'  and tor.is_product_order = 1
                  and t2.factory_code not in ('C00563','C00216')
                  group by t2.company_id, to_char(td.delivery_origin_time,'yyyy'),t2.group_name) y
        on k.company_id = y.company_id
       and k.year = y.year
       and k.group_name = y.group_name
      left join (select tp.company_id, tp.year, tp.group_name,sum(tp.sum_money) sho_order_money
                  from (select t3.company_id, t3.year, t3.group_name,t3.satisfy_money sum_money
                          from scmdata.pt_ordered t3
                         where t3.factory_code not in ('C00563','C00216')
                          union all
                        select t3a.company_id,t3a.year, t3a.group_name, (t3a.order_money  - t3a.satisfy_money ) sum_money
                          from scmdata.pt_ordered t3a
                         inner join scmdata.sys_company_dept a
                            on a.company_id = t3a.company_id
                           and a.company_dept_id = t3a.responsible_dept
                           and a.pause = 0
                         where (a.dept_name like '%物流部%'or a.dept_name like '%品类部%'
                             or a.dept_name like '%事业部%' or a.dept_name = '无')
                          and t3a.factory_code not in ('C00563','C00216') ) tp
                          group by tp.company_id, tp.year, tp.group_name)z
        on k.company_id = z.company_id
       and k.year = z.year
       and k.group_name = z.group_name
      left join (select tp.company_id, tp.year, tp.group_name,sum(tp.sum_money) sho_order_money_desc
                  from (select t3b.company_id, t3b.year, t3b.group_name,t3b.satisfy_money sum_money
                          from scmdata.pt_ordered t3b
                         where  t3b.is_twenty = 1
                           and t3b.factory_code not in ('C00563','C00216')
                        union all
                        select t3c.company_id,t3c.year,t3c.group_name, (t3c.order_money  - t3c.satisfy_money ) sum_money
                          from scmdata.pt_ordered t3c
                         inner join scmdata.sys_company_dept a
                            on a.company_id = t3c.company_id
                           and a.company_dept_id = t3c.responsible_dept
                           and a.pause = 0
                         where t3c.is_twenty = 1
                           and t3c.factory_code not in ('C00563','C00216')
                           and (a.dept_name like '%物流部%'or a.dept_name like '%品类部%'
                             or a.dept_name like '%事业部%' or a.dept_name = '无') ) tp
                          group by tp.company_id, tp.year, tp.group_name)d
        on k.company_id = d.company_id
       and k.year = d.year
       and k.group_name = d.group_name
    left join (select ta0.company_id, ta0.year, ta0.group_name,sum(ta0.sum1_date*ta0.sum1_money) delivery_order_money
              from (select t5.company_id, to_char(tba.delivery_origin_time,'yyyy')year, t5.group_name,
                     (to_date(to_char(tba.delivery_origin_time, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                     to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                     (t5.fixed_price * tba.delivery_amount) sum1_money
                from scmdata.pt_ordered t5
                left join scmdata.t_delivery_record tba
                  on t5.product_gress_code = tba.order_code
                 and t5.company_id = tba.company_id
                inner join scmdata.t_ordered tor
                   on tor.company_id = tba.company_id
                  and tor.order_code = tba.order_code
                left join scmdata.t_commodity_info tb
                  on t5.goo_id = tb.rela_goo_id
                 and tb.goo_id = tba.goo_id
                 and t5.company_id = tb.company_id
               where t5.is_first_order = 0
                 and tor.is_product_order = 1
                  and t5.factory_code not in ('C00563','C00216'))ta0
              group by ta0.company_id, ta0.year,  ta0.group_name) qa
        on k.company_id = qa.company_id
       and k.year = qa.year
       and k.group_name = qa.group_name
    left join (select t6.company_id, t6.year,t6.group_name,sum(t6.sum2_date*t6.sum2_money) delivery_order_money_desc
                from (select t5a.company_id, to_char(tab.delivery_origin_time,'yyyy')year, t5a.group_name,
                       (to_date(to_char(tab.delivery_origin_time, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                       to_date(to_char(t5a.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum2_date,
                       (t5a.fixed_price * tab.delivery_amount) sum2_money
                  from scmdata.pt_ordered t5a
                  left join scmdata.t_delivery_record tab
                    on t5a.product_gress_code = tab.order_code
                   and t5a.company_id = tab.company_id
                inner join scmdata.t_ordered tor
                   on tor.company_id = tab.company_id
                  and tor.order_code = tab.order_code
                  left join scmdata.t_commodity_info tb
                    on t5a.goo_id = tb.rela_goo_id
                   and tb.goo_id = tab.goo_id
                   and t5a.company_id = tb.company_id
                 where t5a.is_first_order = 0
                   and t5a.is_twenty = 1
                 and tor.is_product_order = 1
                  and t5a.factory_code not in ('C00563','C00216'))t6
                group by t6.company_id, t6.year,t6.group_name) qw
        on k.company_id = qw.company_id
       and k.year = qw.year
       and k.group_name = qw.group_name
      left join (select t.company_id,t.year, t.group_name,sum(t.order_money) order_20_money
                   from scmdata.pt_ordered t
                  where t.is_twenty =1
                  and t.factory_code not in ('C00563','C00216')
                  group by t.company_id, t.year, t.group_name)qx
        on k.company_id = qx.company_id
       and k.year = qx.year
       and k.group_name = qx.group_name
      left join (select t2.company_id, to_char(td.delivery_origin_time,'yyyy')year, t2.group_name, sum(t2.fixed_price* td.delivery_amount) delivery_20_money
                     from scmdata.pt_ordered t2
                  inner join scmdata.t_delivery_record td
                     on td.order_code = t2.product_gress_code
                    and td.company_id = t2.company_id
                     inner join scmdata.t_ordered tor
                       on tor.order_code = t2.product_gress_code
                      and tor.company_id = t2.company_id
                    where t2.is_first_order = '0' and t2.is_twenty = 1   and tor.is_product_order = 1
                      and t2.factory_code not in ('C00563','C00216')
                    group by t2.company_id, to_char(td.delivery_origin_time,'yyyy'), t2.group_name) qy
        on k.company_id = qy.company_id
       and k.year = qy.year
       and k.group_name = qy.group_name
      left join (select tp.company_id, tp.year, tp.group_name,sum(tp.sum_money) sho_order_original_money
                  from (select t3.company_id, t3.year, t3.group_name,t3.satisfy_money sum_money
                          from scmdata.pt_ordered t3
                         where t3.factory_code not in ('C00563','C00216') ) tp
                          group by tp.company_id, tp.year, tp.group_name )z1
        on k.company_id = z1.company_id
       and k.year = z1.year
       and k.group_name = z1.group_name ]';

    V_W_SQL := q'[
      where k.year  < to_char(sysdate,'yyyy')
      and k.year >=2022) tkb
      ON (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.groupname = tkb.group_name)
     WHEN MATCHED THEN]';

    V_W1_SQL := q'[
      where k.year  = to_char(sysdate,'yyyy')-1 ) tkb
      ON (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.groupname = tkb.group_name)
     WHEN MATCHED THEN]';

    V_U_SQL  := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.sho_order_money           = tkb.sho_order_money,
             tka.sho_order_20_money        = tkb.sho_order_money_desc,
             tka.delivery_money            = tkb.delivery_money,
             tka.delivery_order_money      = tkb.delivery_order_money,
             tka.delivery_order_20_money   = tkb.delivery_order_money_desc,
             tka.qua_order_money           = tkb.qua_order_money,
             tka.delivery_20_money         = tkb.delivery_20_money,
             tka.order_20_money            = tkb.order_20_money,
             tka.sho_order_original_money  = tkb.sho_order_original_money,
             tka.memo                      = '',
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U1_SQL := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.sho_order_money           = tkb.sho_order_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U2_SQL := q'[  UPDATE
         SET tka.order_20_money            = tkb.order_20_money,
             tka.sho_order_20_money        = tkb.sho_order_money_desc,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U3_SQL := q'[  UPDATE
         SET tka.delivery_money            = tkb.delivery_money,
             tka.delivery_order_money      = tkb.delivery_order_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U4_SQL := q'[  UPDATE
         SET tka.delivery_20_money         = tkb.delivery_20_money,
             tka.delivery_order_20_money   = tkb.delivery_order_money_desc,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U5_SQL := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.qua_order_money           = tkb.qua_order_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';

    /*只更新订单满足率(原值)指标*/
    V_U6_SQL := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.sho_order_original_money  = tkb.sho_order_original_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';

    V_IN_SQL := q'[
    WHEN NOT MATCHED THEN
      INSERT
        (t_kpiorder_qu_year_id,
         tka.company_id,
         tka.year,
         tka.groupname,
         tka.order_money,
         tka.sho_order_money,
         tka.sho_order_20_money,
         tka.delivery_money,
         tka.delivery_order_money,
         tka.delivery_order_20_money,
         tka.qua_order_money,
         tka.delivery_20_money,
         tka.order_20_money,
         tka.sho_order_original_money,
         tka.memo,
         tka.create_id,
         tka.create_time,
         tka.update_id,
         tka.update_time)
      VALUES
        (scmdata.f_get_uuid(),
         tkb.company_id,
         tkb.year,
         tkb.group_name,
         tkb.order_money,
         tkb.sho_order_money,
         tkb.sho_order_money_desc,
         tkb.delivery_money,
         tkb.delivery_order_money,
         tkb.delivery_order_money_desc,
         tkb.qua_order_money,
         tkb.delivery_20_money,
         tkb.order_20_money,
         tkb.sho_order_original_money,
         '',
         'ADMIN',
         sysdate,
         'ADMIN',
         sysdate)]';
    /*   t_type = 0 更新全部指标
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
    end if;
    /*   t_type = 1 只更新到仓满足率指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U1_SQL;
      end if;
    end if;
    /*   t_type = 2 只更新到前20%仓满足率指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 2 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U2_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U2_SQL;
      end if;
    end if;
    /*   t_type = 3 只更新到仓补货平均交期指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 3 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U3_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U3_SQL;
      end if;
    end if;
    /*   t_type = 4 只更新前20%到仓补货平均交期指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 4 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U4_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U4_SQL;
      end if;
    end if;
    /*   t_type = 5 只更新质量问题订单不满足率指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 5 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U5_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U5_SQL;
      end if;
    end if;

    /*   t_type = 6 只更新订单满足率(原值)指标  当指标只做更新不做插入
    p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
    if t_type = 6 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U6_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U6_SQL;
      end if;
    end if;
    execute immediate V_SQL;
  END P_T_KPIORDER_QU_YEAR;

  /*---------------------------------------------------------------------------
   对象：
        P_T_KPI_THISMONTH
   统计维度：
       分类、区域组、款式名称、产品子类、供应商、生产工厂、跟单、qc、qc主管
   时间维度：
       本月
   用途：
       多维度指标查询本月数据表（t_kpi_thismonth）
   更新规则：
       每天晚上凌晨4点半更新前一天的数据
   t_type参数解析
        t_type = 0 更新全部指标
        t_type = 1 更新订单满足率（原值、绩效值）指标
        t_type = 2 更新补货平均交期指标
   p_type参数解析
        p_type = 0 更新全部历史数据
        p_type = 1 只更新上一个维度（月份）的数据
   上线版本：2022-10-30
   -----------------------------------------------------------------------------*/
  PROCEDURE P_T_KPI_THISMONTH(t_type number, p_type number) IS
    V_Q_SQL clob; ---订单满足率指标
    V_Q1_SQL clob; ---补货平均交期指标
    ---更新全部历史数据
    V_W_SQL clob := q'[
    where /*k.year = to_char(sysdate,'yyyy')
      and k.month = to_char(sysdate,'mm')*/
      and to_date(k.kpi_date,'yyyy-mm-dd') < trunc(sysdate,'dd')) tkb
      ON (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.month = tkb.month and tka.kpi_date = tkb.kpi_date and tka.category = tkb.category
          and tka.groupname = tkb.group_name and tka.count_dimension = tkb.count_dimension and tka.dimension_sort = tkb.dimension_sort)
     WHEN MATCHED THEN]';
    ---更新本月数据
    V_W1_SQL clob := q'[
    where k.year = to_char(sysdate,'yyyy')
      and k.month = to_char(sysdate,'mm')
      and to_date(k.kpi_date,'yyyy-mm-dd') < trunc(sysdate,'dd')) tkb
      ON (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.month = tkb.month and tka.kpi_date = tkb.kpi_date and tka.category = tkb.category
          and tka.groupname = tkb.group_name and tka.count_dimension = tkb.count_dimension and tka.dimension_sort = tkb.dimension_sort)
     WHEN MATCHED THEN]';
    ---订单满足率指标
    V_U_SQL clob := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.sho_order_money           = tkb.sho_order_money,
             tka.sho_order_original_money  = tkb.sho_order_original_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    ---补货平均交期指标
    V_U1_SQL clob := q'[  UPDATE
         SET tka.delivery_money            = tkb.delivery_money,
             tka.delivery_order_money      = tkb.delivery_order_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    ---新增订单满足率指标
    V_IN_SQL clob := q'[
    WHEN NOT MATCHED THEN
      INSERT
        (tka.t_kpi_tm_id,
         tka.company_id,
         tka.year,
         tka.month,
         tka.kpi_date,
         tka.category,
         tka.groupname,
         tka.count_dimension,
         tka.dimension_sort,
         tka.order_money,
         tka.sho_order_money,
         tka.sho_order_original_money,
         tka.memo,
         tka.create_id,
         tka.create_time,
         tka.update_id,
         tka.update_time)
      VALUES
        (scmdata.f_get_uuid(),
         tkb.company_id,
         tkb.year,
         tkb.month,
         tkb.kpi_date,
         tkb.category,
         tkb.group_name,
         tkb.count_dimension,
         tkb.dimension_sort,
         tkb.order_money,
         tkb.sho_order_money,
         tkb.sho_order_original_money,
         ' ',
         'ADMIN',
         sysdate,
         'ADMIN',
         sysdate)]';
    ---新增 补货平均交期指标
    V_IN1_SQL clob := q'[
    WHEN NOT MATCHED THEN
      INSERT
        (tka.t_kpi_tm_id,
         tka.company_id,
         tka.year,
         tka.month,
         tka.kpi_date,
         tka.category,
         tka.groupname,
         tka.count_dimension,
         tka.dimension_sort,
         tka.delivery_money,
         tka.delivery_order_money,
         tka.memo,
         tka.create_id,
         tka.create_time,
         tka.update_id,
         tka.update_time)
      VALUES
        (scmdata.f_get_uuid(),
         tkb.company_id,
         tkb.year,
         tkb.month,
         tkb.kpi_date,
         tkb.category,
         tkb.group_name,
         tkb.count_dimension,
         tkb.dimension_sort,
         tkb.delivery_money,
         tkb.delivery_order_money,
         ' ',
         'ADMIN',
         sysdate,
         'ADMIN',
         sysdate)]';
    V_SQL    clob;
    V1_SQL    clob;
    --1.统计维度：分类
  BEGIN
--订单满足率指标
    V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_thismonth tka
  USING (  with kpi_order as
  (select t.company_id, t.year, t.month,to_char(t.delivery_date,'yyyy-mm-dd')kpi_date, t.category, (case when t.group_name is null then '1' else t.group_name end) group_name
          , '00' count_dimension, t.category dimension_sort, sum(t.order_money) order_money
     from scmdata.pt_ordered t
    group by t.company_id, t.year, t.month,to_char(t.delivery_date,'yyyy-mm-dd'),t.category, t.group_name)
 select k.company_id, k.year, k.month,to_date(k.kpi_date,'yyyy-mm-dd') kpi_date, k.category, k.group_name, k.count_dimension, k.dimension_sort,
        k.order_money, z.sho_order_money,  z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id,tp.year,tp.month,tp.kpi_date,tp.category, tp.group_name,
                     '00' count_dimension, tp.category dimension_sort, sum(tp.sum_money) sho_order_money
                from (select t3.company_id, t3.year,t3.month, to_char(t3.delivery_date,'yyyy-mm-dd')kpi_date,(case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3
                      union all
                      select t3a.company_id, t3a.year, t3a.month, to_char(t3a.delivery_date,'yyyy-mm-dd')kpi_date,(case when t3a.group_name is null then '1' else t3a.group_name end)group_name,t3a.category,(t3a.order_money - t3a.satisfy_money) sum_money
                        from scmdata.pt_ordered t3a
                       inner join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                              or a.dept_name like '%事业部%' or a.dept_name = '无')) tp
               group by tp.company_id, tp.year, tp.month,tp.kpi_date, tp.category, tp.group_name) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.month = z.month
    and k.kpi_date = z.kpi_date
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select tp.company_id, tp.year, tp.month,tp.kpi_date, tp.category, tp.group_name, '00' count_dimension,
                     tp.category dimension_sort, sum(tp.sum_money) sho_order_original_money
                from (select t3.company_id, t3.year, t3.month, to_char(t3.delivery_date,'yyyy-mm-dd')kpi_date, t3.category,
                             (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3) tp
               group by tp.company_id, tp.year, tp.month,tp.kpi_date, tp.group_name, tp.category) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.month = z1.month
    and k.kpi_date = z1.kpi_date
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort  ]';
--补货平均交期指标
    V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_thismonth tka
  USING (  select k.company_id,k.year,k.month,to_date(k.kpi_date,'yyyy-mm-dd')kpi_date,k.category,k.group_name,k.count_dimension,k.dimension_sort,k.delivery_money,qa.delivery_order_money
      from(select t2.company_id,  to_char(td.delivery_origin_time, 'yyyy') year, to_char(td.delivery_origin_time, 'mm') month,
                     to_char(td.delivery_origin_time, 'yyyy-mm-dd') kpi_date ,t2.category,
                    (case when t2.group_name is null then '1' else t2.group_name end)group_name, '00' count_dimension, t2.category dimension_sort,
                     sum(t2.fixed_price * td.delivery_amount) delivery_money
                from scmdata.pt_ordered t2
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               inner join scmdata.t_delivery_record td
                  on td.order_code = t2.product_gress_code
                 and td.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id,  to_char(td.delivery_origin_time, 'yyyy-mm-dd'), to_char(td.delivery_origin_time, 'yyyy'),
                        to_char(td.delivery_origin_time, 'mm'), t2.group_name, t2.category) k
   left join (select ta0.company_id, ta0.year, ta0.month,ta0.kpi_date, ta0.category, ta0.group_name, '00' count_dimension, ta0.category dimension_sort,
                     sum(ta0.sum1_date * ta0.sum1_money) delivery_order_money
                from (select t5.company_id, to_char(tba.delivery_origin_time, 'yyyy') year,
                             to_char(tba.delivery_origin_time, 'yyyy-mm-dd') kpi_date,
                             to_char(tba.delivery_origin_time, 'mm') month,  t5.category,
                             (case when t5.group_name is null then '1' else t5.group_name end)group_name,
                             (to_date(to_char(tba.delivery_origin_time, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                             to_date(to_char(t5.order_create_date,  'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                             (t5.fixed_price * tba.delivery_amount) sum1_money
                        from scmdata.pt_ordered t5
                       inner join scmdata.t_delivery_record tba
                          on t5.product_gress_code = tba.order_code
                         and t5.company_id = tba.company_id
                       inner join scmdata.t_ordered tor
                          on tor.company_id = tba.company_id
                         and tor.order_code = tba.order_code
                       inner join scmdata.t_commodity_info tb
                          on t5.goo_id = tb.rela_goo_id
                         and tb.goo_id = tba.goo_id
                         and t5.company_id = tb.company_id
                       where tor.isfirstordered = 0
                         and tor.is_product_order = 1) ta0
               group by ta0.company_id, ta0.year, ta0.month,ta0.kpi_date, ta0.category, ta0.group_name) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.month = qa.month
    and k.kpi_date = qa.kpi_date
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort  ]';
    /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;


    --2.统计维度：区域组
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_thismonth tka
  USING (
       with kpi_order as
  (select t.company_id, t.year,  t.month,to_char(t.delivery_date,'yyyy-mm-dd')kpi_date, t.category,
          (case when t.group_name is null then '1' else t.group_name end)group_name, '01' count_dimension,
          (case when t.group_name is null then '1' else t.group_name end) dimension_sort, sum(t.order_money) order_money
     from scmdata.pt_ordered t
    where t.group_name is not null
    group by t.company_id, t.year, t.month,to_char(t.delivery_date,'yyyy-mm-dd'), t.category, t.group_name)
 select k.company_id, k.year, k.month,to_date(k.kpi_date,'yyyy-mm-dd') kpi_date, k.category, k.group_name, k.count_dimension, k.dimension_sort,
        k.order_money, z.sho_order_money, z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id, tp.year, tp.month,tp.kpi_date, tp.category, tp.group_name,
                     '01' count_dimension, tp.group_name dimension_sort, sum(tp.sum_money) sho_order_money
                from (select t3.company_id, t3.year, t3.month, to_char(t3.delivery_date,'yyyy-mm-dd')kpi_date,
                             (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3
                      union all
                      select t3a.company_id,  t3a.year, t3a.month,to_char(t3a.delivery_date,'yyyy-mm-dd')kpi_date,
                             (case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category, (t3a.order_money - t3a.satisfy_money) sum_money
                        from scmdata.pt_ordered t3a
                       inner join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%' or a.dept_name like '%事业部%'
                             or a.dept_name like '%财务部%' or a.dept_name = '无')) tp
               group by tp.company_id, tp.year, tp.month,tp.kpi_date, tp.category, tp.group_name) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.month = z.month
    and k.kpi_date = z.kpi_date
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select tp.company_id, tp.year, tp.month,tp.kpi_date,tp.category, tp.group_name,
                     '01' count_dimension, tp.group_name dimension_sort, sum(tp.sum_money) sho_order_original_money
                from (select t3.company_id, t3.year, t3.month, to_char(t3.delivery_date,'yyyy-mm-dd')kpi_date,t3.category,
                             (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3) tp
               group by tp.company_id, tp.year, tp.month,tp.kpi_date, tp.group_name, tp.category) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.month = z1.month
    and k.kpi_date = z1.kpi_date
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--补货平均交期指标
     V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_thismonth tka
  USING (  select k.company_id,k.year,k.month,to_date(k.kpi_date,'yyyy-mm-dd')kpi_date,k.category,k.group_name,k.count_dimension,k.dimension_sort,k.delivery_money,qa.delivery_order_money
      from(select t2.company_id, to_char(td.delivery_origin_time, 'yyyy') year,to_char(td.delivery_origin_time, 'yyyy-mm-dd') kpi_date,
                     to_char(td.delivery_origin_time, 'mm') month, t2.category,(case when t2.group_name is null then '1' else t2.group_name end)group_name, '01' count_dimension,
                     (case when t2.group_name is null then '1' else t2.group_name end) dimension_sort, sum(t2.fixed_price * td.delivery_amount) delivery_money
                from scmdata.pt_ordered t2
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               inner join scmdata.t_delivery_record td
                  on td.order_code = t2.product_gress_code
                 and td.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id,  to_char(td.delivery_origin_time, 'yyyy'), to_char(td.delivery_origin_time, 'yyyy-mm-dd'),
                        to_char(td.delivery_origin_time, 'mm'), t2.group_name,  t2.category) k
   left join (select ta0.company_id, ta0.year, ta0.month,ta0.kpi_date,  ta0.category, ta0.group_name,
                     '01' count_dimension, ta0.group_name dimension_sort, sum(ta0.sum1_date * ta0.sum1_money) delivery_order_money
                from (select t5.company_id,to_char(tba.delivery_origin_time, 'yyyy') year,
                             to_char(tba.delivery_origin_time, 'yyyy-mm-dd') kpi_date,
                             to_char(tba.delivery_origin_time, 'mm') month, t5.category,
                             (case when t5.group_name is null then '1' else t5.group_name end) group_name,
                             (to_date(to_char(tba.delivery_origin_time,  'yyyy/mm/dd'), 'yyyy/mm/dd') -
                             to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                             (t5.fixed_price * tba.delivery_amount) sum1_money
                        from scmdata.pt_ordered t5
                       inner join scmdata.t_delivery_record tba
                          on t5.product_gress_code = tba.order_code
                         and t5.company_id = tba.company_id
                       inner join scmdata.t_ordered tor
                          on tor.company_id = tba.company_id
                         and tor.order_code = tba.order_code
                       inner join scmdata.t_commodity_info tb
                          on t5.goo_id = tb.rela_goo_id
                         and tb.goo_id = tba.goo_id
                         and t5.company_id = tb.company_id
                       where tor.isfirstordered = 0
                         and tor.is_product_order = 1) ta0
               group by ta0.company_id, ta0.year, ta0.month,ta0.kpi_date, ta0.category, ta0.group_name) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.month = qa.month
    and k.kpi_date = qa.kpi_date
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort ]';
    /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
      end;
    --3.统计维度：款式名称
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_thismonth tka
  USING (
        with kpi_order as
  (select t.company_id, t.year, t.month,to_char(t.delivery_date,'yyyy-mm-dd')kpi_date, t.category,
         (case when t.group_name is null then '1' else t.group_name end)group_name, '02' count_dimension,
          t.style_name dimension_sort,sum(t.order_money) order_money
     from scmdata.pt_ordered t
    group by t.company_id, t.year, t.month,to_char(t.delivery_date,'yyyy-mm-dd'), t.category, t.group_name, t.style_name)
 select k.company_id, k.year, k.month,to_date(k.kpi_date,'yyyy-mm-dd') kpi_date, k.category, k.group_name, k.count_dimension, k.dimension_sort,
        k.order_money, z.sho_order_money, z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id, tp.year, tp.month, tp.kpi_date,tp.category, tp.group_name,
                     '02' count_dimension, tp.style_name dimension_sort, sum(tp.sum_money) sho_order_money
                from (select t3.company_id, t3.year, t3.month,to_char(t3.delivery_date,'yyyy-mm-dd')kpi_date,
                             (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category, t3.style_name, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3
                      union all
                      select t3a.company_id, t3a.year, t3a.month,to_char(t3a.delivery_date,'yyyy-mm-dd')kpi_date,
                             (case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category,
                             t3a.style_name, (t3a.order_money - t3a.satisfy_money) sum_money
                        from scmdata.pt_ordered t3a
                       inner join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'
                             or a.dept_name like '%财务部%'or a.dept_name like '%事业部%' or a.dept_name = '无')) tp
               group by tp.company_id, tp.year, tp.month,tp.kpi_date, tp.category, tp.group_name, tp.style_name) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.month = z.month
    and k.kpi_date = z.kpi_date
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select tp.company_id, tp.year, tp.month,tp.kpi_date, tp.category, tp.group_name,
                     '02' count_dimension, tp.style_name dimension_sort, sum(tp.sum_money) sho_order_original_money
                from (select t3.company_id, t3.year, t3.month,to_char(t3.delivery_date,'yyyy-mm-dd')kpi_date, t3.category, t3.style_name,
                             (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3) tp
               group by tp.company_id,tp.year,tp.month,tp.kpi_date,tp.group_name,tp.category,tp.style_name) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.month = z1.month
    and k.kpi_date = z1.kpi_date
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--补货平均交期指标
      V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_thismonth tka
  USING ( select k.company_id,k.year,k.month,to_date(k.kpi_date,'yyyy-mm-dd')kpi_date,k.category,k.group_name,k.count_dimension,k.dimension_sort,k.delivery_money,qa.delivery_order_money
      from (select t2.company_id, to_char(td.delivery_origin_time, 'yyyy') year,to_char(td.delivery_origin_time, 'yyyy-mm-dd') kpi_date,
                     to_char(td.delivery_origin_time, 'mm') month,t2.category,(case when t2.group_name is null then '1' else t2.group_name end)group_name,'02' count_dimension,
                     t2.style_name dimension_sort, sum(t2.fixed_price * td.delivery_amount) delivery_money
                from scmdata.pt_ordered t2
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               inner join scmdata.t_delivery_record td
                  on td.order_code = t2.product_gress_code
                 and td.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id,to_char(td.delivery_origin_time, 'yyyy'),to_char(td.delivery_origin_time, 'yyyy-mm-dd'),
                        to_char(td.delivery_origin_time, 'mm'),t2.group_name,t2.category,t2.style_name) k
   left join (select ta0.company_id, ta0.year, ta0.month,ta0.kpi_date, ta0.category, ta0.group_name, '02' count_dimension, ta0.style_name dimension_sort,
                     sum(ta0.sum1_date * ta0.sum1_money) delivery_order_money
                from (select t5.company_id, to_char(tba.delivery_origin_time, 'yyyy') year,
                             to_char(tba.delivery_origin_time, 'yyyy-mm-dd') kpi_date,
                             to_char(tba.delivery_origin_time, 'mm') month, t5.category,
                             (case when t5.group_name is null then '1' else t5.group_name end)group_name, t5.style_name,
                             (to_date(to_char(tba.delivery_origin_time, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                             to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                             (t5.fixed_price * tba.delivery_amount) sum1_money
                        from scmdata.pt_ordered t5
                       inner join scmdata.t_delivery_record tba
                          on t5.product_gress_code = tba.order_code
                         and t5.company_id = tba.company_id
                       inner join scmdata.t_ordered tor
                          on tor.company_id = tba.company_id
                         and tor.order_code = tba.order_code
                       inner join scmdata.t_commodity_info tb
                          on t5.goo_id = tb.rela_goo_id
                         and tb.goo_id = tba.goo_id
                         and t5.company_id = tb.company_id
                       where tor.isfirstordered = 0
                         and tor.is_product_order = 1) ta0
               group by ta0.company_id, ta0.year, ta0.month,ta0.kpi_date, ta0.category, ta0.group_name, ta0.style_name) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.month = qa.month
    and k.kpi_date = qa.kpi_date
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort ]';
    /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
      end;
    --4.统计维度：产品子类
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_thismonth tka
  USING (
       with kpi_order as
  (select t.company_id, t.year, t.month,to_char(t.delivery_date,'yyyy-mm-dd')kpi_date, t.category,
          (case when t.group_name is null then '1' else t.group_name end)group_name, '03' count_dimension,
          t.samll_category dimension_sort,sum(t.order_money) order_money
     from scmdata.pt_ordered t
    group by t.company_id, t.year, t.month,to_char(t.delivery_date,'yyyy-mm-dd'), t.category, t.group_name, t.samll_category)
 select k.company_id, k.year, k.month,to_date(k.kpi_date,'yyyy-mm-dd') kpi_date, k.category, k.group_name, k.count_dimension, k.dimension_sort,
        k.order_money, z.sho_order_money, z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id, tp.year, tp.month, tp.kpi_date,tp.category, tp.group_name,
                     '03' count_dimension, tp.samll_category dimension_sort, sum(tp.sum_money) sho_order_money
                from (select t3.company_id, t3.year, t3.month,to_char(t3.delivery_date,'yyyy-mm-dd')kpi_date,
                             (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category, t3.samll_category, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3
                      union all
                      select t3a.company_id, t3a.year, t3a.month,to_char(t3a.delivery_date,'yyyy-mm-dd')kpi_date,
                             (case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category,
                             t3a.samll_category, (t3a.order_money - t3a.satisfy_money) sum_money
                        from scmdata.pt_ordered t3a
                       inner join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                              or a.dept_name like '%事业部%' or a.dept_name = '无')) tp
               group by tp.company_id, tp.year, tp.month,tp.kpi_date, tp.category, tp.group_name, tp.samll_category) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.month = z.month
    and k.kpi_date = z.kpi_date
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select tp.company_id, tp.year, tp.month,tp.kpi_date, tp.category, tp.group_name,
                     '03' count_dimension, tp.samll_category dimension_sort, sum(tp.sum_money) sho_order_original_money
                from (select t3.company_id, t3.year, t3.month,to_char(t3.delivery_date,'yyyy-mm-dd')kpi_date, t3.category, t3.samll_category,
                             (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3) tp
               group by tp.company_id,tp.year,tp.month,tp.kpi_date,tp.group_name,tp.category,tp.samll_category) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.month = z1.month
    and k.kpi_date = z1.kpi_date
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--补货平均交期指标
     V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_thismonth tka
  USING (select k.company_id,k.year,k.month,to_date(k.kpi_date,'yyyy-mm-dd')kpi_date,k.category,k.group_name,k.count_dimension,k.dimension_sort,k.delivery_money,qa.delivery_order_money
      from (select t2.company_id, to_char(td.delivery_origin_time, 'yyyy') year,to_char(td.delivery_origin_time, 'yyyy-mm-dd') kpi_date,
                     to_char(td.delivery_origin_time, 'mm') month,t2.category,
                     (case when t2.group_name is null then '1' else t2.group_name end)group_name,'03' count_dimension,
                     t2.samll_category dimension_sort, sum(t2.fixed_price * td.delivery_amount) delivery_money
                from scmdata.pt_ordered t2
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               inner join scmdata.t_delivery_record td
                  on td.order_code = t2.product_gress_code
                 and td.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id,to_char(td.delivery_origin_time, 'yyyy'),to_char(td.delivery_origin_time, 'yyyy-mm-dd'),
                        to_char(td.delivery_origin_time, 'mm'),t2.group_name,t2.category,t2.samll_category) k
   left join (select ta0.company_id, ta0.year, ta0.month,ta0.kpi_date, ta0.category, ta0.group_name, '03' count_dimension, ta0.samll_category dimension_sort,
                     sum(ta0.sum1_date * ta0.sum1_money) delivery_order_money
                from (select t5.company_id, to_char(tba.delivery_origin_time, 'yyyy') year,
                             to_char(tba.delivery_origin_time, 'yyyy-mm-dd') kpi_date,
                             to_char(tba.delivery_origin_time, 'mm') month, t5.category,
                             (case when t5.group_name is null then '1' else t5.group_name end)group_name, t5.samll_category,
                             (to_date(to_char(tba.delivery_origin_time, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                             to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                             (t5.fixed_price * tba.delivery_amount) sum1_money
                        from scmdata.pt_ordered t5
                       inner join scmdata.t_delivery_record tba
                          on t5.product_gress_code = tba.order_code
                         and t5.company_id = tba.company_id
                       inner join scmdata.t_ordered tor
                          on tor.company_id = tba.company_id
                         and tor.order_code = tba.order_code
                       inner join scmdata.t_commodity_info tb
                          on t5.goo_id = tb.rela_goo_id
                         and tb.goo_id = tba.goo_id
                         and t5.company_id = tb.company_id
                       where tor.isfirstordered = 0
                         and tor.is_product_order = 1) ta0
               group by ta0.company_id, ta0.year, ta0.month,ta0.kpi_date, ta0.category, ta0.group_name, ta0.samll_category) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.month = qa.month
    and k.kpi_date = qa.kpi_date
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort ]';
    /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
      end;
    --5.统计维度：供应商
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_thismonth tka
  USING (
      with kpi_order as
  (select t.company_id, t.year, t.month,to_char(t.delivery_date,'yyyy-mm-dd')kpi_date, t.category,
          (case when t.group_name is null then '1' else t.group_name end)group_name, '04' count_dimension,
          t.supplier_code dimension_sort,sum(t.order_money) order_money
     from scmdata.pt_ordered t
    group by t.company_id, t.year, t.month,to_char(t.delivery_date,'yyyy-mm-dd'), t.category, t.group_name, t.supplier_code)
 select k.company_id, k.year, k.month,to_date(k.kpi_date,'yyyy-mm-dd') kpi_date, k.category, k.group_name, k.count_dimension, k.dimension_sort,
        k.order_money, z.sho_order_money, z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id, tp.year, tp.month, tp.kpi_date,tp.category, tp.group_name,
                     '04' count_dimension, tp.supplier_code dimension_sort, sum(tp.sum_money) sho_order_money
                from (select t3.company_id, t3.year, t3.month,to_char(t3.delivery_date,'yyyy-mm-dd')kpi_date,
                             (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category, t3.supplier_code, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3
                      union all
                      select t3a.company_id, t3a.year, t3a.month,to_char(t3a.delivery_date,'yyyy-mm-dd')kpi_date,
                             (case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category,
                             t3a.supplier_code, (t3a.order_money - t3a.satisfy_money) sum_money
                        from scmdata.pt_ordered t3a
                       inner join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                              or a.dept_name like '%事业部%' or a.dept_name = '无')) tp
               group by tp.company_id, tp.year, tp.month,tp.kpi_date, tp.category, tp.group_name, tp.supplier_code) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.month = z.month
    and k.kpi_date = z.kpi_date
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select tp.company_id, tp.year, tp.month,tp.kpi_date, tp.category, tp.group_name,
                     '04' count_dimension, tp.supplier_code dimension_sort, sum(tp.sum_money) sho_order_original_money
                from (select t3.company_id, t3.year, t3.month,to_char(t3.delivery_date,'yyyy-mm-dd')kpi_date, t3.category, t3.supplier_code,
                             (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3) tp
               group by tp.company_id,tp.year,tp.month,tp.kpi_date,tp.group_name,tp.category,tp.supplier_code) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.month = z1.month
    and k.kpi_date = z1.kpi_date
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--补货平均交期指标
      V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_thismonth tka
  USING (select k.company_id,k.year,k.month,to_date(k.kpi_date,'yyyy-mm-dd')kpi_date,k.category,k.group_name,k.count_dimension,k.dimension_sort,k.delivery_money,qa.delivery_order_money
      from (select t2.company_id, to_char(td.delivery_origin_time, 'yyyy') year,to_char(td.delivery_origin_time, 'yyyy-mm-dd') kpi_date,
                     to_char(td.delivery_origin_time, 'mm') month,t2.category,
                     (case when t2.group_name is null then '1' else t2.group_name end)group_name,'04' count_dimension,
                     t2.supplier_code dimension_sort, sum(t2.fixed_price * td.delivery_amount) delivery_money
                from scmdata.pt_ordered t2
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               inner join scmdata.t_delivery_record td
                  on td.order_code = t2.product_gress_code
                 and td.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id,to_char(td.delivery_origin_time, 'yyyy'),to_char(td.delivery_origin_time, 'yyyy-mm-dd'),
                        to_char(td.delivery_origin_time, 'mm'),t2.group_name,t2.category,t2.supplier_code) k
   left join (select ta0.company_id, ta0.year, ta0.month,ta0.kpi_date, ta0.category, ta0.group_name, '04' count_dimension, ta0.supplier_code dimension_sort,
                     sum(ta0.sum1_date * ta0.sum1_money) delivery_order_money
                from (select t5.company_id, to_char(tba.delivery_origin_time, 'yyyy') year,
                             to_char(tba.delivery_origin_time, 'yyyy-mm-dd') kpi_date,
                             to_char(tba.delivery_origin_time, 'mm') month, t5.category,
                             (case when t5.group_name is null then '1' else t5.group_name end)group_name, t5.supplier_code,
                             (to_date(to_char(tba.delivery_origin_time, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                             to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                             (t5.fixed_price * tba.delivery_amount) sum1_money
                        from scmdata.pt_ordered t5
                       inner join scmdata.t_delivery_record tba
                          on t5.product_gress_code = tba.order_code
                         and t5.company_id = tba.company_id
                       inner join scmdata.t_ordered tor
                          on tor.company_id = tba.company_id
                         and tor.order_code = tba.order_code
                       inner join scmdata.t_commodity_info tb
                          on t5.goo_id = tb.rela_goo_id
                         and tb.goo_id = tba.goo_id
                         and t5.company_id = tb.company_id
                       where tor.isfirstordered = 0
                         and tor.is_product_order = 1) ta0
               group by ta0.company_id, ta0.year, ta0.month,ta0.kpi_date, ta0.category, ta0.group_name, ta0.supplier_code) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.month = qa.month
    and k.kpi_date = qa.kpi_date
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort ]';
    /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
      end;
    --6.统计维度：生产工厂
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_thismonth tka
  USING (
       with kpi_order as
  (select t.company_id, t.year, t.month,to_char(t.delivery_date,'yyyy-mm-dd')kpi_date, t.category,
          (case when t.group_name is null then '1' else t.group_name end)group_name, '05' count_dimension,
          t.factory_code dimension_sort,sum(t.order_money) order_money
     from scmdata.pt_ordered t
    group by t.company_id, t.year, t.month,to_char(t.delivery_date,'yyyy-mm-dd'), t.category, t.group_name, t.factory_code)
 select k.company_id, k.year, k.month,to_date(k.kpi_date,'yyyy-mm-dd') kpi_date, k.category, k.group_name, k.count_dimension, k.dimension_sort,
        k.order_money, z.sho_order_money, z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id, tp.year, tp.month, tp.kpi_date,tp.category, tp.group_name,
                     '05' count_dimension, tp.factory_code dimension_sort, sum(tp.sum_money) sho_order_money
                from (select t3.company_id, t3.year, t3.month,to_char(t3.delivery_date,'yyyy-mm-dd')kpi_date,
                             (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category, t3.factory_code, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3
                      union all
                      select t3a.company_id, t3a.year, t3a.month,to_char(t3a.delivery_date,'yyyy-mm-dd')kpi_date,
                             (case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category,
                             t3a.factory_code, (t3a.order_money - t3a.satisfy_money) sum_money
                        from scmdata.pt_ordered t3a
                       inner join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                              or a.dept_name like '%事业部%' or a.dept_name = '无')) tp
               group by tp.company_id, tp.year, tp.month,tp.kpi_date, tp.category, tp.group_name, tp.factory_code) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.month = z.month
    and k.kpi_date = z.kpi_date
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select tp.company_id, tp.year, tp.month,tp.kpi_date, tp.category, tp.group_name,
                     '05' count_dimension, tp.factory_code dimension_sort, sum(tp.sum_money) sho_order_original_money
                from (select t3.company_id, t3.year, t3.month,to_char(t3.delivery_date,'yyyy-mm-dd')kpi_date, t3.category,
                             t3.factory_code, (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3) tp
               group by tp.company_id,tp.year,tp.month,tp.kpi_date,tp.group_name,tp.category,tp.factory_code) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.month = z1.month
    and k.kpi_date = z1.kpi_date
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--补货平均交期指标
      V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_thismonth tka
  USING (select k.company_id,k.year,k.month,to_date(k.kpi_date,'yyyy-mm-dd')kpi_date,k.category,k.group_name,k.count_dimension,k.dimension_sort,k.delivery_money,qa.delivery_order_money
      from (select t2.company_id, to_char(td.delivery_origin_time, 'yyyy') year,to_char(td.delivery_origin_time, 'yyyy-mm-dd') kpi_date,
                     to_char(td.delivery_origin_time, 'mm') month,t2.category,
                     (case when t2.group_name is null then '1' else t2.group_name end)group_name,'05' count_dimension,
                     t2.factory_code dimension_sort, sum(t2.fixed_price * td.delivery_amount) delivery_money
                from scmdata.pt_ordered t2
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               inner join scmdata.t_delivery_record td
                  on td.order_code = t2.product_gress_code
                 and td.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id,to_char(td.delivery_origin_time, 'yyyy'),to_char(td.delivery_origin_time, 'yyyy-mm-dd'),
                        to_char(td.delivery_origin_time, 'mm'),t2.group_name,t2.category,t2.factory_code) k
   left join (select ta0.company_id, ta0.year, ta0.month,ta0.kpi_date, ta0.category, ta0.group_name, '05' count_dimension, ta0.factory_code dimension_sort,
                     sum(ta0.sum1_date * ta0.sum1_money) delivery_order_money
                from (select t5.company_id, to_char(tba.delivery_origin_time, 'yyyy') year,
                             to_char(tba.delivery_origin_time, 'yyyy-mm-dd') kpi_date,
                             to_char(tba.delivery_origin_time, 'mm') month, t5.category,
                             (case when t5.group_name is null then '1' else t5.group_name end)group_name, t5.factory_code,
                             (to_date(to_char(tba.delivery_origin_time, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                             to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                             (t5.fixed_price * tba.delivery_amount) sum1_money
                        from scmdata.pt_ordered t5
                       inner join scmdata.t_delivery_record tba
                          on t5.product_gress_code = tba.order_code
                         and t5.company_id = tba.company_id
                       inner join scmdata.t_ordered tor
                          on tor.company_id = tba.company_id
                         and tor.order_code = tba.order_code
                       inner join scmdata.t_commodity_info tb
                          on t5.goo_id = tb.rela_goo_id
                         and tb.goo_id = tba.goo_id
                         and t5.company_id = tb.company_id
                       where tor.isfirstordered = 0
                         and tor.is_product_order = 1) ta0
               group by ta0.company_id, ta0.year, ta0.month,ta0.kpi_date, ta0.category, ta0.group_name, ta0.factory_code) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.month = qa.month
    and k.kpi_date = qa.kpi_date
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort ]';
    /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
      end;
    --7.统计维度：跟单
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_thismonth tka
  USING (
        with kpi_order as
   (select t.company_id, t.year, t.month,to_char(t.delivery_date,'yyyy-mm-dd')kpi_date, t.category,
           (case when t.group_name is null then '1' else t.group_name end)group_name, '06' count_dimension,
           (case when x.follower_leader is null then '1' else x.follower_leader end) dimension_sort, sum(x.sum1) order_money
      from scmdata.pt_ordered t
     inner join (select t1.company_id, t1.product_gress_code, t1.order_money,
                        (t1.order_money / count(t1.product_gress_code) over(partition by t1.product_gress_code)) sum1,
                        regexp_substr(t1.flw_order, '[^,]+', 1, level) follower_leader
                   from scmdata.pt_ordered t1
                  --where t1.flw_order is not null
                 connect by prior t1.pt_ordered_id = t1.pt_ordered_id
                        and level <=  length(t1.flw_order) - length(regexp_replace(t1.flw_order, ',', '')) + 1
                        and prior dbms_random.value is not null) x
        on x.company_id = t.company_id
       and x.product_gress_code = t.product_gress_code
     group by t.company_id, t.year, t.month,to_char(t.delivery_date,'yyyy-mm-dd'), t.category, t.group_name,x.follower_leader),
  flw_leader as
 (select t.company_id, t.product_gress_code,t.fixed_price,t.order_create_date,
         (t.order_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum1,
         (t.satisfy_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum2,
         regexp_substr(t.flw_order, '[^,]+', 1, level) follower_leader
    from scmdata.pt_ordered t
   --where t.flw_order is not null
 connect by prior t.pt_ordered_id = t.pt_ordered_id
        and level <= length(t.flw_order) - length(regexp_replace(t.flw_order, ',', '')) + 1
        and prior dbms_random.value is not null)
 select k.company_id,k.year, k.month,to_date(k.kpi_date,'yyyy-mm-dd') kpi_date, k.category, k.group_name,k.count_dimension,k.dimension_sort,k.order_money,z.sho_order_money,
        z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id,  tp.year,  tp.month,tp.kpi_date, tp.category, tp.group_name,
                     '06' count_dimension,(case when tp.follower_leader is null then '1' else tp.follower_leader end) dimension_sort, sum(tp.sum2) sho_order_money
                from (select t3.company_id, t3.year, t3.month, to_char(t3.delivery_date,'yyyy-mm-dd')kpi_date,
                             (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category, x.follower_leader, x.sum2
                        from scmdata.pt_ordered t3
                        inner join flw_leader x
                          on x.company_id = t3.company_id
                         and x.product_gress_code = t3.product_gress_code
                      union all
                      select t3a.company_id, t3a.year, t3a.month, to_char(t3a.delivery_date,'yyyy-mm-dd')kpi_date,
                             (case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category, x.follower_leader, (x.sum1- x.sum2) sum_money
                        from scmdata.pt_ordered t3a
                        inner join flw_leader x
                          on x.company_id = t3a.company_id
                         and x.product_gress_code = t3a.product_gress_code
                       left join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                              or a.dept_name like '%事业部%' or a.dept_name = '无')
                      union all
                      select t3a.company_id, t3a.year, t3a.month,to_char(t3a.delivery_date,'yyyy-mm-dd')kpi_date,
                             (case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category, x.follower_leader, (x.sum1- x.sum2) sum_money
                        from scmdata.pt_ordered t3a
                        inner join flw_leader x
                          on x.company_id = t3a.company_id
                         and x.product_gress_code = t3a.product_gress_code
                       where t3a.responsible_dept = 'b550778b4f2b36b4e0533c281caca074' /*责任部门1级：供应链管理部*/
                         and t3a.responsible_dept_sec in ('DP2203124299047457','b550778b4f4336b4e0533c281caca074',
                             'b550778b4f4836b4e0533c281caca074','b550778b4f3e36b4e0533c281caca074')/*责任部门2级：直播2部、QA组、面料管控部、工艺组*/ ) tp
               group by tp.company_id, tp.year, tp.month,tp.kpi_date, tp.category, tp.group_name, tp.follower_leader) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.month = z.month
    and k.kpi_date = z.kpi_date
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select t3.company_id, t3.year, t3.month,to_char(t3.delivery_date,'yyyy-mm-dd')kpi_date,
                     (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category,
                     '06' count_dimension,(case when x.follower_leader is null then '1' else x.follower_leader end) dimension_sort, sum(x.sum2)sho_order_original_money
                from scmdata.pt_ordered t3
               inner join flw_leader x
                  on x.company_id = t3.company_id
                 and x.product_gress_code = t3.product_gress_code
               group by t3.company_id, t3.year, t3.month, to_char(t3.delivery_date,'yyyy-mm-dd'),t3.group_name, t3.category, x.follower_leader) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.month = z1.month
    and k.kpi_date = z1.kpi_date
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--补货平均交期指标
      V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_thismonth tka
  USING (
        with flw_leader as
 (select t.company_id, t.product_gress_code,t.fixed_price,t.order_create_date,
         (t.order_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum1,
         (t.satisfy_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum2,
         regexp_substr(t.flw_order, '[^,]+', 1, level) follower_leader
    from scmdata.pt_ordered t
   --where t.flw_order is not null
 connect by prior t.pt_ordered_id = t.pt_ordered_id
        and level <= length(t.flw_order) - length(regexp_replace(t.flw_order, ',', '')) + 1
        and prior dbms_random.value is not null)
select k.company_id,k.year,k.month,to_date(k.kpi_date,'yyyy-mm-dd')kpi_date,k.category,k.group_name,k.count_dimension,k.dimension_sort,k.delivery_money,qa.delivery_order_money
      from (select t2.company_id, x.year, x.month,x.kpi_date, t2.category,  '06' count_dimension,
                     (case when t2.group_name is null then '1' else t2.group_name end)group_name,
                      (case when x.follower_leader is null then '1' else x.follower_leader end) dimension_sort, sum(sum1) delivery_money
                from scmdata.pt_ordered t2
                inner join (select distinct tf.company_id,tf.follower_leader,tf.product_gress_code,
                                  to_char(td.delivery_origin_time, 'yyyy-mm-dd') kpi_date,
                                  to_char(td.delivery_origin_time, 'yyyy') year, to_char(td.delivery_origin_time, 'mm') month,
                                  ((tf.fixed_price * td.delivery_amount)/
                                    count(tf.product_gress_code) over(partition by tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyymm'))) sum1
                             from flw_leader tf
                            inner join scmdata.t_delivery_record td
                               on td.order_code = tf.product_gress_code
                              and td.company_id = tf.company_id) x
                  on x.company_id = t2.company_id
                 and x.product_gress_code = t2.product_gress_code
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id,x.year, x.month,x.kpi_date, t2.group_name, t2.category, x.follower_leader) k
   left join (select t5.company_id, x.year, x.month,x.kpi_date,t5.category,
                     (case when t5.group_name is null then '1' else t5.group_name end)group_name, '06' count_dimension,
                     (case when x.follower_leader is null then '1' else x.follower_leader end) dimension_sort, sum(x.sum1_date * x.sum1) delivery_order_money
                from scmdata.pt_ordered t5
               inner join scmdata.t_ordered tor
                  on tor.company_id = t5.company_id
                 and tor.order_code = t5.product_gress_code
                 and tor.is_product_order = '1'
               inner join (select distinct tf.company_id, tf.follower_leader, tf.product_gress_code,
                                            to_char(td.delivery_origin_time, 'yyyy') year,
                                            to_char(td.delivery_origin_time, 'mm') month,
                                            to_char(td.delivery_origin_time, 'yyyy-mm-dd') kpi_date,
                                            (to_date(to_char(td.delivery_origin_time, 'yyyy/mm/dd'),  'yyyy/mm/dd') -
                                            to_date(to_char(tf.order_create_date, 'yyyy/mm/dd'),  'yyyy/mm/dd')) sum1_date,
                                            ((tf.fixed_price * td.delivery_amount) /
                                              count(tf.product_gress_code) over(partition by tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyymm'))) sum1,
                                            tf.fixed_price,
                                            td.delivery_amount
                              from flw_leader tf
                             inner join scmdata.t_delivery_record td
                                on td.order_code = tf.product_gress_code
                               and td.company_id = tf.company_id) x
                  on x.company_id = t5.company_id
                 and x.product_gress_code = t5.product_gress_code
                 where tor.isfirstordered = 0
              group by t5.company_id, x.year, x.month,x.kpi_date,t5.category, t5.group_name,x.follower_leader) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.month = qa.month
    and k.kpi_date = qa.kpi_date
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort ]';
    /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
      end;
    --5.统计维度：QC
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_thismonth tka
  USING (
        with kpi_order as
   (select t.company_id,t.year,t.month,to_char(t.delivery_date,'yyyy-mm-dd')kpi_date,t.category,
          (case when t.group_name is null then '1' else t.group_name end)group_name, '07' count_dimension,
           (case when x.qc is null then '1' else x.qc end) dimension_sort, sum(x.sum1) order_money
      from scmdata.pt_ordered t
     inner join (select t1.company_id, t1.product_gress_code, t1.order_money,
                        (t1.order_money / count(t1.product_gress_code) over(partition by t1.product_gress_code)) sum1,
                        regexp_substr(t1.qc, '[^,]+', 1, level) qc
                   from scmdata.pt_ordered t1
                 -- where t1.qc is not null
                 connect by prior t1.pt_ordered_id = t1.pt_ordered_id
                        and level <=  length(t1.qc) - length(regexp_replace(t1.qc, ',', '')) + 1
                        and prior dbms_random.value is not null) x
        on x.company_id = t.company_id
       and x.product_gress_code = t.product_gress_code
     group by t.company_id, t.year, t.month, to_char(t.delivery_date,'yyyy-mm-dd'),t.category, t.group_name,x.qc),
  flw_leader as
 (select t.company_id, t.product_gress_code,t.fixed_price,t.order_create_date,
         (t.order_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum1,
         (t.satisfy_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum2,
         regexp_substr(t.qc, '[^,]+', 1, level) qc
    from scmdata.pt_ordered t
  -- where t.qc is not null
 connect by prior t.pt_ordered_id = t.pt_ordered_id
        and level <= length(t.qc) - length(regexp_replace(t.qc, ',', '')) + 1
        and prior dbms_random.value is not null)
 select k.company_id,k.year, k.month,to_date(k.kpi_date,'yyyy-mm-dd') kpi_date, k.category, k.group_name,k.count_dimension,k.dimension_sort,k.order_money,z.sho_order_money,
        z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id, tp.year, tp.month, tp.kpi_date,tp.category, tp.group_name,
                     '07' count_dimension, (case when tp.qc is null then '1' else tp.qc end)dimension_sort, sum(tp.sum2) sho_order_money
                from (select t3.company_id, t3.year, t3.month,to_char(t3.delivery_date,'yyyy-mm-dd')kpi_date,
                             (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category, x.qc, x.sum2
                        from scmdata.pt_ordered t3
                       inner join flw_leader x
                          on x.company_id = t3.company_id
                         and x.product_gress_code = t3.product_gress_code
                      union all
                      select t3a.company_id, t3a.year, t3a.month,to_char(t3a.delivery_date,'yyyy-mm-dd')kpi_date,
                             (case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category, x.qc, (x.sum1- x.sum2) sum_money
                        from scmdata.pt_ordered t3a
                       inner join flw_leader x
                          on x.company_id = t3a.company_id
                         and x.product_gress_code = t3a.product_gress_code
                       left join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                              or a.dept_name like '%事业部%' or a.dept_name = '无')
                      union all
                      select t3a.company_id, t3a.year, t3a.month,to_char(t3a.delivery_date,'yyyy-mm-dd')kpi_date,
                             (case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category, x.qc, (x.sum1- x.sum2) sum_money
                        from scmdata.pt_ordered t3a
                        inner join flw_leader x
                          on x.company_id = t3a.company_id
                         and x.product_gress_code = t3a.product_gress_code
                       where t3a.responsible_dept = 'b550778b4f2b36b4e0533c281caca074' /*责任部门1级：供应链管理部*/
                         and t3a.responsible_dept_sec in ('DP2203124299047457','b550778b4f4336b4e0533c281caca074',
                             'b550778b4f4836b4e0533c281caca074','b550778b4f3e36b4e0533c281caca074')/*责任部门2级：直播2部、QA组、面料管控部、工艺组*/ ) tp
               group by tp.company_id, tp.year, tp.month,tp.kpi_date, tp.category, tp.group_name, tp.qc) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.month = z.month
    and k.kpi_date = z.kpi_date
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select t3.company_id, t3.year, t3.month,to_char(t3.delivery_date,'yyyy-mm-dd')kpi_date,
                     (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category,
                     '07' count_dimension, (case when x.qc is null then '1' else x.qc end)dimension_sort, sum(x.sum2)sho_order_original_money
                from scmdata.pt_ordered t3
               inner join flw_leader x
                  on x.company_id = t3.company_id
                 and x.product_gress_code = t3.product_gress_code
               group by t3.company_id, t3.year, t3.month,to_char(t3.delivery_date,'yyyy-mm-dd'), t3.group_name, t3.category, x.qc) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.month = z1.month
    and k.kpi_date = z1.kpi_date
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--补货平均交期指标
      V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_thismonth tka
  USING (
        with flw_leader as
 (select t.company_id, t.product_gress_code,t.fixed_price,t.order_create_date,
         (t.order_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum1,
         (t.satisfy_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum2,
         regexp_substr(t.qc, '[^,]+', 1, level) qc
    from scmdata.pt_ordered t
  -- where t.qc is not null
 connect by prior t.pt_ordered_id = t.pt_ordered_id
        and level <= length(t.qc) - length(regexp_replace(t.qc, ',', '')) + 1
        and prior dbms_random.value is not null)
 select k.company_id,k.year,k.month,to_date(k.kpi_date,'yyyy-mm-dd')kpi_date,k.category,k.group_name,k.count_dimension,k.dimension_sort,k.delivery_money,qa.delivery_order_money
      from (select t2.company_id, x.year, x.month,x.kpi_date, t2.category, (case when t2.group_name is null then '1' else t2.group_name end)group_name, '07' count_dimension,
                      (case when x.qc is null then '1' else x.qc end) dimension_sort, sum(sum1) delivery_money
                from scmdata.pt_ordered t2
                inner join (select distinct tf.company_id,tf.qc,tf.product_gress_code,
                                  to_char(td.delivery_origin_time, 'yyyy-mm-dd') kpi_date,
                                  to_char(td.delivery_origin_time, 'yyyy') year, to_char(td.delivery_origin_time, 'mm') month,
                                  ((tf.fixed_price * td.delivery_amount)/
count(tf.product_gress_code) over(partition by tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyymm'))) sum1
                             from flw_leader tf
                            inner join scmdata.t_delivery_record td
                               on td.order_code = tf.product_gress_code
                              and td.company_id = tf.company_id) x
                  on x.company_id = t2.company_id
                 and x.product_gress_code = t2.product_gress_code
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id,x.year, x.month,x.kpi_date, t2.group_name, t2.category, x.qc) k
   left join (select t5.company_id, x.year, x.month,x.kpi_date,t5.category,
                     (case when t5.group_name is null then '1' else t5.group_name end)group_name, '07' count_dimension,
                      (case when x.qc is null then '1' else x.qc end) dimension_sort, sum(x.sum1_date * x.sum1) delivery_order_money
                from scmdata.pt_ordered t5
               inner join scmdata.t_ordered tor
                  on tor.company_id = t5.company_id
                 and tor.order_code = t5.product_gress_code
                 and tor.is_product_order = '1'
               inner join (select distinct tf.company_id, tf.qc, tf.product_gress_code,
                                            to_char(td.delivery_origin_time, 'yyyy-mm-dd') kpi_date,
                                            to_char(td.delivery_origin_time, 'yyyy') year,
                                            to_char(td.delivery_origin_time, 'mm') month,
                                            (to_date(to_char(td.delivery_origin_time, 'yyyy/mm/dd'),  'yyyy/mm/dd') -
                                            to_date(to_char(tf.order_create_date, 'yyyy/mm/dd'),  'yyyy/mm/dd')) sum1_date,
                                            ((tf.fixed_price * td.delivery_amount) /
                                              count(tf.product_gress_code) over(partition by tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyymm'))) sum1,
                                            tf.fixed_price,
                                            td.delivery_amount
                              from flw_leader tf
                             inner join scmdata.t_delivery_record td
                                on td.order_code = tf.product_gress_code
                               and td.company_id = tf.company_id) x
                  on x.company_id = t5.company_id
                 and x.product_gress_code = t5.product_gress_code
                 where tor.isfirstordered = 0
              group by t5.company_id, x.year, x.month,x.kpi_date,t5.category, t5.group_name,x.qc) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.month = qa.month
    and k.kpi_date = qa.kpi_date
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort ]';
    /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
      end;
    --9.统计维度：QC主管
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_thismonth tka
  USING (
        with kpi_order as
   (select t.company_id, t.year, t.month,to_char(t.delivery_date,'yyyy-mm-dd')kpi_date, t.category,
           (case when t.group_name is null then '1' else t.group_name end)group_name, '08' count_dimension,
            (case when x.qc_manager is null then '1' else x.qc_manager end)  dimension_sort, sum(x.sum1) order_money
      from scmdata.pt_ordered t
     inner join (select t1.company_id, t1.product_gress_code, t1.order_money,
                        (t1.order_money / count(t1.product_gress_code) over(partition by t1.product_gress_code)) sum1,
                        regexp_substr(t1.qc_manager, '[^,]+', 1, level) qc_manager
                   from scmdata.pt_ordered t1
                  --where t1.qc_manager is not null
                 connect by prior t1.pt_ordered_id = t1.pt_ordered_id
                        and level <=  length(t1.qc_manager) - length(regexp_replace(t1.qc_manager, ',', '')) + 1
                        and prior dbms_random.value is not null) x
        on x.company_id = t.company_id
       and x.product_gress_code = t.product_gress_code
     group by t.company_id, t.year, t.month,to_char(t.delivery_date,'yyyy-mm-dd'), t.category, t.group_name,x.qc_manager),
  flw_leader as
 (select t.company_id, t.product_gress_code,t.fixed_price,t.order_create_date,
         (t.order_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum1,
         (t.satisfy_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum2,
         regexp_substr(t.qc_manager, '[^,]+', 1, level) qc_manager
    from scmdata.pt_ordered t
  -- where t.qc_manager is not null
 connect by prior t.pt_ordered_id = t.pt_ordered_id
        and level <= length(t.qc_manager) - length(regexp_replace(t.qc_manager, ',', '')) + 1
        and prior dbms_random.value is not null)
 select k.company_id,k.year, k.month,to_date(k.kpi_date,'yyyy-mm-dd') kpi_date, k.category, k.group_name,k.count_dimension,k.dimension_sort,k.order_money,z.sho_order_money,
        z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id,  tp.year,  tp.month, tp.kpi_date,tp.category, tp.group_name,
                     '08' count_dimension,(case when tp.qc_manager is null then '1' else tp.qc_manager end) dimension_sort, sum(tp.sum2) sho_order_money
                from (select t3.company_id, t3.year, t3.month, to_char(t3.delivery_date,'yyyy-mm-dd')kpi_date,
                             (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category, x.qc_manager, x.sum2
                        from scmdata.pt_ordered t3
                        inner join flw_leader x
                          on x.company_id = t3.company_id
                         and x.product_gress_code = t3.product_gress_code
                      union all
                      select t3a.company_id, t3a.year, t3a.month,to_char(t3a.delivery_date,'yyyy-mm-dd')kpi_date,
                             (case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category, x.qc_manager, (x.sum1- x.sum2) sum_money
                        from scmdata.pt_ordered t3a
                        inner join flw_leader x
                          on x.company_id = t3a.company_id
                         and x.product_gress_code = t3a.product_gress_code
                       left join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                              or a.dept_name like '%事业部%' or a.dept_name = '无')
                      union all
                      select t3a.company_id, t3a.year, t3a.month,to_char(t3a.delivery_date,'yyyy-mm-dd')kpi_date,
                             (case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category, x.qc_manager, (x.sum1- x.sum2) sum_money
                        from scmdata.pt_ordered t3a
                        inner join flw_leader x
                          on x.company_id = t3a.company_id
                         and x.product_gress_code = t3a.product_gress_code
                       where t3a.responsible_dept = 'b550778b4f2b36b4e0533c281caca074' /*责任部门1级：供应链管理部*/
                         and t3a.responsible_dept_sec in ('DP2203124299047457','b550778b4f4336b4e0533c281caca074',
                             'b550778b4f4836b4e0533c281caca074','b550778b4f3e36b4e0533c281caca074')/*责任部门2级：直播2部、QA组、面料管控部、工艺组*/ ) tp
               group by tp.company_id, tp.year, tp.month,tp.kpi_date, tp.category, tp.group_name, tp.qc_manager) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.month = z.month
    and k.kpi_date = z.kpi_date
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select t3.company_id, t3.year, t3.month,to_char(t3.delivery_date,'yyyy-mm-dd')kpi_date,
                     (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category,
                     '08' count_dimension,(case when x.qc_manager is null then '1' else x.qc_manager end) dimension_sort, sum(x.sum2)sho_order_original_money
                from scmdata.pt_ordered t3
               inner join flw_leader x
                  on x.company_id = t3.company_id
                 and x.product_gress_code = t3.product_gress_code
               group by t3.company_id, t3.year, t3.month,to_char(t3.delivery_date,'yyyy-mm-dd'), t3.group_name, t3.category, x.qc_manager) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.month = z1.month
    and k.kpi_date = z1.kpi_date
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort  ]';
--补货平均交期指标
      V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_thismonth tka
  USING (
        with flw_leader as
 (select t.company_id, t.product_gress_code,t.fixed_price,t.order_create_date,
         (t.order_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum1,
         (t.satisfy_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum2,
         regexp_substr(t.qc_manager, '[^,]+', 1, level) qc_manager
    from scmdata.pt_ordered t
  -- where t.qc_manager is not null
 connect by prior t.pt_ordered_id = t.pt_ordered_id
        and level <= length(t.qc_manager) - length(regexp_replace(t.qc_manager, ',', '')) + 1
        and prior dbms_random.value is not null)
 select k.company_id,k.year,k.month,to_date(k.kpi_date,'yyyy-mm-dd')kpi_date,k.category,k.group_name,k.count_dimension,k.dimension_sort,k.delivery_money,qa.delivery_order_money
      from (select t2.company_id, x.year, x.month,x.kpi_date, t2.category,
                     (case when t2.group_name is null then '1' else t2.group_name end)group_name, '08' count_dimension,
                      (case when x.qc_manager is null then '1' else x.qc_manager end) dimension_sort, sum(sum1) delivery_money
                from scmdata.pt_ordered t2
                inner join (select distinct tf.company_id,tf.qc_manager,tf.product_gress_code,
                                   to_char(td.delivery_origin_time, 'yyyy-mm-dd') kpi_date,
                                   to_char(td.delivery_origin_time, 'yyyy') year, to_char(td.delivery_origin_time, 'mm') month,
                                   ((tf.fixed_price * td.delivery_amount)/
count(tf.product_gress_code) over(partition by tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyymm'))) sum1
                             from flw_leader tf
                            inner join scmdata.t_delivery_record td
                               on td.order_code = tf.product_gress_code
                              and td.company_id = tf.company_id) x
                  on x.company_id = t2.company_id
                 and x.product_gress_code = t2.product_gress_code
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id,x.year, x.month,x.kpi_date,  t2.group_name, t2.category, x.qc_manager) k
   left join (select t5.company_id, x.year, x.month,x.kpi_date, t5.category,
                     (case when t5.group_name is null then '1' else t5.group_name end)group_name, '08' count_dimension,
                     (case when x.qc_manager is null then '1' else x.qc_manager end) dimension_sort, sum(x.sum1_date * x.sum1) delivery_order_money
                from scmdata.pt_ordered t5
               inner join scmdata.t_ordered tor
                  on tor.company_id = t5.company_id
                 and tor.order_code = t5.product_gress_code
                 and tor.is_product_order = '1'
               inner join (select distinct tf.company_id, tf.qc_manager, tf.product_gress_code,
                                            to_char(td.delivery_origin_time, 'yyyy-mm-dd') kpi_date,
                                            to_char(td.delivery_origin_time, 'yyyy') year,
                                            to_char(td.delivery_origin_time, 'mm') month,
                                            (to_date(to_char(td.delivery_origin_time, 'yyyy/mm/dd'),  'yyyy/mm/dd') -
                                            to_date(to_char(tf.order_create_date, 'yyyy/mm/dd'),  'yyyy/mm/dd')) sum1_date,
                                            ((tf.fixed_price * td.delivery_amount) /
                                              count(tf.product_gress_code) over(partition by tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyymm'))) sum1,
                                            tf.fixed_price,
                                            td.delivery_amount
                              from flw_leader tf
                             inner join scmdata.t_delivery_record td
                                on td.order_code = tf.product_gress_code
                               and td.company_id = tf.company_id) x
                  on x.company_id = t5.company_id
                 and x.product_gress_code = t5.product_gress_code
                 where tor.isfirstordered = 0
              group by t5.company_id, x.year, x.month,x.kpi_date, t5.category, t5.group_name,x.qc_manager) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.month = qa.month
    and k.kpi_date = qa.kpi_date
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort  ]';
          /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
        if t_type = '0' then
          if p_type = '0' then
            V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
            V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
          elsif p_type = '1' then
            V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
            V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
          end if;
          execute immediate V_SQL;
          execute immediate V1_SQL;
        elsif t_type = '1' then
          if p_type = '0' then
            V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
          elsif p_type = '1' then
            V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
          end if;
          execute immediate V_SQL;
          elsif t_type = '2' then
          if p_type = '0' then
            V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
          elsif p_type = '1' then
            V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
          end if;
          execute immediate V1_SQL;
        end if;
    end;
  END P_T_KPI_THISMONTH;
  /*------------------------------------------------------------------------
   对象：
        P_T_KPI_MONTH
   统计维度：
       分类、区域组、款式名称、产品子类、供应商、生产工厂、跟单、qc、qc主管
   时间维度：
       月份
   用途：
       多维度指标查询月度数据表（scmdata.t_kpi_month）
   更新规则：
       每月6号凌晨4点半更新前一月的数据
   t_type参数解析
        t_type = 0 更新全部指标
        t_type = 1 更新订单满足率（原值、绩效值）指标
        t_type = 2 更新补货平均交期指标
   p_type参数解析
        p_type = 0 更新全部历史数据
        p_type = 1 只更新上一个维度（月份）的数据
   上线版本：2022-10-30
   -------------------------------------------------------------------------*/
  PROCEDURE P_T_KPI_MONTH(t_type number, p_type number) IS
    V_Q_SQL clob;--订单满足率指标
    V_Q1_SQL clob;--补货平均交期
    ---更新全部历史数据
    V_W_SQL clob := q'[
      where (k.year || lpad(k.month,2,0)) < to_char(sysdate,'yyyymm')) tkb
      ON (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.month = tkb.month and tka.category = tkb.category
          and tka.groupname = tkb.group_name and tka.count_dimension = tkb.count_dimension and tka.dimension_sort = tkb.dimension_sort)
     WHEN MATCHED THEN]';
    ---更新上月数据
    V_W1_SQL clob := q'[
      where(k.year || lpad(k.month,2,0)) = to_char(add_months(sysdate,-1),'yyyymm')) tkb
      ON (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.month = tkb.month and tka.category = tkb.category
          and tka.groupname = tkb.group_name and tka.count_dimension = tkb.count_dimension and tka.dimension_sort = tkb.dimension_sort)
     WHEN MATCHED THEN]';
    ---更新订单满足率指标
    V_U_SQL clob := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.sho_order_money           = tkb.sho_order_money,
             tka.sho_order_original_money  = tkb.sho_order_original_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    ---更新补货平均交期
    V_U1_SQL clob := q'[  UPDATE
         SET tka.delivery_money            = tkb.delivery_money,
             tka.delivery_order_money      = tkb.delivery_order_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    ---新增订单满足率指标
    V_IN_SQL clob := q'[
    WHEN NOT MATCHED THEN
      INSERT
        (tka.t_kpi_m_id,
         tka.company_id,
         tka.year,
         tka.month,
         tka.category,
         tka.groupname,
         tka.count_dimension,
         tka.dimension_sort,
         tka.order_money,
         tka.sho_order_money,
         tka.sho_order_original_money,
         tka.memo,
         tka.create_id,
         tka.create_time,
         tka.update_id,
         tka.update_time)
      VALUES
        (scmdata.f_get_uuid(),
         tkb.company_id,
         tkb.year,
         tkb.month,
         tkb.category,
         tkb.group_name,
         tkb.count_dimension,
         tkb.dimension_sort,
         tkb.order_money,
         tkb.sho_order_money,
         tkb.sho_order_original_money,
         ' ',
         'ADMIN',
         sysdate,
         'ADMIN',
         sysdate)]';
    ---新增补货平均交期
    V_IN1_SQL clob := q'[
    WHEN NOT MATCHED THEN
      INSERT
        (tka.t_kpi_m_id,
         tka.company_id,
         tka.year,
         tka.month,
         tka.category,
         tka.groupname,
         tka.count_dimension,
         tka.dimension_sort,
         tka.delivery_money,
         tka.delivery_order_money,
         tka.memo,
         tka.create_id,
         tka.create_time,
         tka.update_id,
         tka.update_time)
      VALUES
        (scmdata.f_get_uuid(),
         tkb.company_id,
         tkb.year,
         tkb.month,
         tkb.category,
         tkb.group_name,
         tkb.count_dimension,
         tkb.dimension_sort,
         tkb.delivery_money,
         tkb.delivery_order_money,
         ' ',
         'ADMIN',
         sysdate,
         'ADMIN',
         sysdate)]';
    V_SQL    clob;
    V1_SQL    clob;
    --1.统计维度：分类
  BEGIN
--订单满足率指标
    V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_month tka
  USING (
      with kpi_order as
  (select t.company_id, t.year, t.month, t.category,(case when t.group_name is null then '1' else t.group_name end) group_name ,
           '00' count_dimension, t.category dimension_sort, sum(t.order_money) order_money
     from scmdata.pt_ordered t
    group by t.company_id, t.year, t.month, t.category, t.group_name)
 select k.company_id, k.year, k.month, k.category, k.group_name, k.count_dimension, k.dimension_sort,
        k.order_money, z.sho_order_money, z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id,tp.year,tp.month,tp.category, tp.group_name,
                     '00' count_dimension, tp.category dimension_sort, sum(tp.sum_money) sho_order_money
                from (select t3.company_id, t3.year,t3.month, (case when t3.group_name is null then '1' else t3.group_name end )group_name, t3.category, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3
                      union all
                      select t3a.company_id, t3a.year, t3a.month, (case when t3a.group_name is null then '1' else t3a.group_name end )group_name,t3a.category,(t3a.order_money - t3a.satisfy_money) sum_money
                        from scmdata.pt_ordered t3a
                       inner join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                             or a.dept_name like '%事业部%' or a.dept_name = '无')) tp
               group by tp.company_id, tp.year, tp.month, tp.category, tp.group_name) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.month = z.month
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select tp.company_id, tp.year, tp.month, tp.category, tp.group_name, '00' count_dimension,
                     tp.category dimension_sort, sum(tp.sum_money) sho_order_original_money
                from (select t3.company_id, t3.year, t3.month, t3.category, (case when t3.group_name is null then '1' else t3.group_name end ) group_name, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3) tp
               group by tp.company_id, tp.year, tp.month, tp.group_name, tp.category) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.month = z1.month
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--补货平均交期指标
    V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_month tka
  USING ( select k.company_id,k.year,k.month,k.category,k.group_name,k.count_dimension,k.dimension_sort,k.delivery_money,qa.delivery_order_money
      from (select t2.company_id,  to_char(td.delivery_origin_time, 'yyyy') year, to_char(td.delivery_origin_time, 'mm') month,
                     t2.category,  (case when t2.group_name is null then '1' else t2.group_name end ) group_name, '00' count_dimension, t2.category dimension_sort,
                     sum(t2.fixed_price * td.delivery_amount) delivery_money
                from scmdata.pt_ordered t2
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               inner join scmdata.t_delivery_record td
                  on td.order_code = t2.product_gress_code
                 and td.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id,  to_char(td.delivery_origin_time, 'yyyy'),
                        to_char(td.delivery_origin_time, 'mm'), t2.group_name, t2.category) k
   left join (select ta0.company_id, ta0.year, ta0.month, ta0.category, ta0.group_name, '00' count_dimension, ta0.category dimension_sort,
                     sum(ta0.sum1_date * ta0.sum1_money) delivery_order_money
                from (select t5.company_id, to_char(tba.delivery_origin_time, 'yyyy') year,
                             to_char(tba.delivery_origin_time, 'mm') month,  t5.category, (case when t5.group_name is null then '1' else t5.group_name end )group_name,
                             (to_date(to_char(tba.delivery_origin_time, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                             to_date(to_char(t5.order_create_date,  'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                             (t5.fixed_price * tba.delivery_amount) sum1_money
                        from scmdata.pt_ordered t5
                       inner join scmdata.t_delivery_record tba
                          on t5.product_gress_code = tba.order_code
                         and t5.company_id = tba.company_id
                       inner join scmdata.t_ordered tor
                          on tor.company_id = tba.company_id
                         and tor.order_code = tba.order_code
                       inner join scmdata.t_commodity_info tb
                          on t5.goo_id = tb.rela_goo_id
                         and tb.goo_id = tba.goo_id
                         and t5.company_id = tb.company_id
                       where tor.isfirstordered = 0
                         and tor.is_product_order = 1) ta0
               group by ta0.company_id, ta0.year, ta0.month, ta0.category, ta0.group_name) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.month = qa.month
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort ]';
    /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;

    --2.统计维度：区域组
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_month tka
  USING (
       with kpi_order as
  (select t.company_id, t.year, t.month,t.category, (case when t.group_name is null then '1' else t.group_name end) group_name,
          '01' count_dimension,(case when t.group_name is null then '1' else t.group_name end) dimension_sort, sum(t.order_money) order_money
     from scmdata.pt_ordered t
    group by t.company_id, t.year, t.month, t.category, t.group_name)
 select k.company_id, k.year, k.month, k.category, k.group_name, k.count_dimension, k.dimension_sort,
        k.order_money, z.sho_order_money, z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id, tp.year, tp.month, tp.category, tp.group_name,
                     '01' count_dimension, tp.group_name dimension_sort, sum(tp.sum_money) sho_order_money
                from (select t3.company_id, t3.year, t3.month, (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3
                      union all
                      select t3a.company_id,  t3a.year, t3a.month, (case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category, (t3a.order_money - t3a.satisfy_money) sum_money
                        from scmdata.pt_ordered t3a
                       inner join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                              or a.dept_name like '%事业部%' or a.dept_name = '无')) tp
               group by tp.company_id, tp.year, tp.month, tp.category, tp.group_name) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.month = z.month
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select tp.company_id, tp.year, tp.month,tp.category, tp.group_name,
                     '01' count_dimension, tp.group_name dimension_sort, sum(tp.sum_money) sho_order_original_money
                from (select t3.company_id, t3.year, t3.month, t3.category, (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3) tp
               group by tp.company_id, tp.year, tp.month, tp.group_name, tp.category) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.month = z1.month
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--补货平均交期指标
      V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_month tka
  USING ( select k.company_id,k.year,k.month,k.category,k.group_name,k.count_dimension,k.dimension_sort,k.delivery_money,qa.delivery_order_money
      from (select t2.company_id, to_char(td.delivery_origin_time, 'yyyy') year,
                     to_char(td.delivery_origin_time, 'mm') month, t2.category, (case when t2.group_name is null then '1' else t2.group_name end)group_name, '01' count_dimension,
                     (case when t2.group_name is null then '1' else t2.group_name end) dimension_sort, sum(t2.fixed_price * td.delivery_amount) delivery_money
                from scmdata.pt_ordered t2
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               inner join scmdata.t_delivery_record td
                  on td.order_code = t2.product_gress_code
                 and td.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id,  to_char(td.delivery_origin_time, 'yyyy'),
                        to_char(td.delivery_origin_time, 'mm'), t2.group_name,  t2.category) k
   left join (select ta0.company_id, ta0.year, ta0.month,  ta0.category, ta0.group_name,
                     '01' count_dimension, ta0.group_name dimension_sort, sum(ta0.sum1_date * ta0.sum1_money) delivery_order_money
                from (select t5.company_id,   to_char(tba.delivery_origin_time, 'yyyy') year,
                             to_char(tba.delivery_origin_time, 'mm') month, t5.category,  (case when t5.group_name is null then '1' else t5.group_name end)group_name,
                             (to_date(to_char(tba.delivery_origin_time,  'yyyy/mm/dd'), 'yyyy/mm/dd') -
                             to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                             (t5.fixed_price * tba.delivery_amount) sum1_money
                        from scmdata.pt_ordered t5
                       inner join scmdata.t_delivery_record tba
                          on t5.product_gress_code = tba.order_code
                         and t5.company_id = tba.company_id
                       inner join scmdata.t_ordered tor
                          on tor.company_id = tba.company_id
                         and tor.order_code = tba.order_code
                       inner join scmdata.t_commodity_info tb
                          on t5.goo_id = tb.rela_goo_id
                         and tb.goo_id = tba.goo_id
                         and t5.company_id = tb.company_id
                       where tor.isfirstordered = 0
                         and tor.is_product_order = 1) ta0
               group by ta0.company_id, ta0.year, ta0.month, ta0.category, ta0.group_name) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.month = qa.month
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort ]';
    /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
    end;

    --3.统计维度：款式名称
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_month tka
  USING (
        with kpi_order as
  (select t.company_id, t.year, t.month, t.category,(case when t.group_name is null then '1' else t.group_name end)group_name, '02' count_dimension,
          t.style_name dimension_sort,sum(t.order_money) order_money
     from scmdata.pt_ordered t
    group by t.company_id, t.year, t.month, t.category, t.group_name, t.style_name)
 select k.company_id, k.year, k.month, k.category, k.group_name, k.count_dimension, k.dimension_sort,
        k.order_money, z.sho_order_money, z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id, tp.year, tp.month, tp.category, tp.group_name,
                     '02' count_dimension, tp.style_name dimension_sort, sum(tp.sum_money) sho_order_money
                from (select t3.company_id, t3.year, t3.month, (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category, t3.style_name, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3
                      union all
                      select t3a.company_id, t3a.year, t3a.month, (case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category,
                             t3a.style_name, (t3a.order_money - t3a.satisfy_money) sum_money
                        from scmdata.pt_ordered t3a
                       inner join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                              or a.dept_name like '%事业部%' or a.dept_name = '无')) tp
               group by tp.company_id, tp.year, tp.month, tp.category, tp.group_name, tp.style_name) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.month = z.month
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select tp.company_id, tp.year, tp.month, tp.category, tp.group_name,
                     '02' count_dimension, tp.style_name dimension_sort, sum(tp.sum_money) sho_order_original_money
                from (select t3.company_id, t3.year, t3.month, t3.category, t3.style_name, (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3) tp
               group by tp.company_id,tp.year,tp.month,tp.group_name,tp.category,tp.style_name) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.month = z1.month
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--补货平均交期指标
     V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_month tka
  USING ( select k.company_id,k.year,k.month,k.category,k.group_name,k.count_dimension,k.dimension_sort,k.delivery_money,qa.delivery_order_money
      from(select t2.company_id, to_char(td.delivery_origin_time, 'yyyy') year,
                     to_char(td.delivery_origin_time, 'mm') month,t2.category,(case when t2.group_name is null then '1' else t2.group_name end)group_name,'02' count_dimension,
                     t2.style_name dimension_sort, sum(t2.fixed_price * td.delivery_amount) delivery_money
                from scmdata.pt_ordered t2
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               inner join scmdata.t_delivery_record td
                  on td.order_code = t2.product_gress_code
                 and td.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id,to_char(td.delivery_origin_time, 'yyyy'),
                        to_char(td.delivery_origin_time, 'mm'),t2.group_name,t2.category,t2.style_name) k
   left join (select ta0.company_id, ta0.year, ta0.month, ta0.category, ta0.group_name, '02' count_dimension, ta0.style_name dimension_sort,
                     sum(ta0.sum1_date * ta0.sum1_money) delivery_order_money
                from (select t5.company_id, to_char(tba.delivery_origin_time, 'yyyy') year,
                             to_char(tba.delivery_origin_time, 'mm') month, t5.category,(case when t5.group_name is null then '1' else t5.group_name end)group_name, t5.style_name,
                             (to_date(to_char(tba.delivery_origin_time, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                             to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                             (t5.fixed_price * tba.delivery_amount) sum1_money
                        from scmdata.pt_ordered t5
                       inner join scmdata.t_delivery_record tba
                          on t5.product_gress_code = tba.order_code
                         and t5.company_id = tba.company_id
                       inner join scmdata.t_ordered tor
                          on tor.company_id = tba.company_id
                         and tor.order_code = tba.order_code
                       inner join scmdata.t_commodity_info tb
                          on t5.goo_id = tb.rela_goo_id
                         and tb.goo_id = tba.goo_id
                         and t5.company_id = tb.company_id
                       where tor.isfirstordered = 0
                         and tor.is_product_order = 1) ta0
               group by ta0.company_id, ta0.year, ta0.month, ta0.category, ta0.group_name, ta0.style_name) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.month = qa.month
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort ]';
    /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
    end;

    --4.统计维度：产品子类
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_month tka
  USING (
        with kpi_order as
  (select t.company_id,  t.year, t.month, t.category, (case when t.group_name is null then '1' else t.group_name end)group_name, '03' count_dimension, t.samll_category dimension_sort, sum(t.order_money) order_money
     from scmdata.pt_ordered t
    group by t.company_id, t.year, t.month, t.category, t.group_name, t.samll_category)
 select k.company_id, k.year,  k.month, k.category, k.group_name, k.count_dimension, k.dimension_sort, k.order_money,
        z.sho_order_money, z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id,  tp.year, tp.month, tp.category, tp.group_name, '03' count_dimension,
                     tp.samll_category dimension_sort, sum(tp.sum_money) sho_order_money
                from (select t3.company_id, t3.year, t3.month, (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category, t3.samll_category,  t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3
                      union all
                      select t3a.company_id, t3a.year, t3a.month, (case when t3a.group_name is null then '1' else t3a.group_name end)group_name,  t3a.category,
                             t3a.samll_category, (t3a.order_money - t3a.satisfy_money) sum_money
                        from scmdata.pt_ordered t3a
                       inner join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                                or a.dept_name like '%事业部%' or a.dept_name = '无')) tp
               group by tp.company_id,tp.year, tp.month, tp.category, tp.group_name,  tp.samll_category) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.month = z.month
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select tp.company_id, tp.year, tp.month, tp.category, tp.group_name, '03' count_dimension,
                     tp.samll_category dimension_sort, sum(tp.sum_money) sho_order_original_money
                from (select t3.company_id, t3.year, t3.month, t3.category, t3.samll_category,
                             (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3) tp
               group by tp.company_id, tp.year, tp.month, tp.group_name, tp.category, tp.samll_category) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.month = z1.month
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--补货平均交期指标
      V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_month tka
  USING ( select k.company_id,k.year,k.month,k.category,k.group_name,k.count_dimension,k.dimension_sort,k.delivery_money,qa.delivery_order_money
      from (select t2.company_id,  to_char(td.delivery_origin_time, 'yyyy') year,
                     to_char(td.delivery_origin_time, 'mm') month, t2.category, (case when t2.group_name is null then '1' else t2.group_name end)group_name, '03' count_dimension,
                     t2.samll_category dimension_sort, sum(t2.fixed_price * td.delivery_amount) delivery_money
                from scmdata.pt_ordered t2
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               inner join scmdata.t_delivery_record td
                  on td.order_code = t2.product_gress_code
                 and td.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id, to_char(td.delivery_origin_time, 'yyyy'), to_char(td.delivery_origin_time, 'mm'),
                        t2.group_name, t2.category, t2.samll_category) k
   left join (select ta0.company_id,  ta0.year, ta0.month, ta0.category, ta0.group_name, '03' count_dimension,
                     ta0.samll_category dimension_sort, sum(ta0.sum1_date * ta0.sum1_money) delivery_order_money
                from (select t5.company_id, to_char(tba.delivery_origin_time, 'yyyy') year,
                             to_char(tba.delivery_origin_time, 'mm') month, t5.category, (case when t5.group_name is null then '1' else t5.group_name end)group_name, t5.samll_category,
                             (to_date(to_char(tba.delivery_origin_time, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                             to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                             (t5.fixed_price * tba.delivery_amount) sum1_money
                        from scmdata.pt_ordered t5
                       inner join scmdata.t_delivery_record tba
                          on t5.product_gress_code = tba.order_code
                         and t5.company_id = tba.company_id
                       inner join scmdata.t_ordered tor
                          on tor.company_id = tba.company_id
                         and tor.order_code = tba.order_code
                       inner join scmdata.t_commodity_info tb
                          on t5.goo_id = tb.rela_goo_id
                         and tb.goo_id = tba.goo_id
                         and t5.company_id = tb.company_id
                       where tor.isfirstordered = 0
                         and tor.is_product_order = 1) ta0
               group by ta0.company_id, ta0.year, ta0.month, ta0.category, ta0.group_name, ta0.samll_category) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.month = qa.month
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort ]';
    /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
    end;

    --5.统计维度：供应商
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_month tka
  USING (
        with kpi_order as
  (select t.company_id, t.year, t.month, t.category, (case when t.group_name is null then '1' else t.group_name end)group_name,'04' count_dimension, t.supplier_code dimension_sort, sum(t.order_money) order_money
     from scmdata.pt_ordered t
    group by t.company_id, t.year, t.month, t.category, t.group_name, t.supplier_code)
 select k.company_id, k.year, k.month, k.category, k.group_name, k.count_dimension, k.dimension_sort, k.order_money,
        z.sho_order_money, z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id, tp.year, tp.month, tp.category, tp.group_name, '04' count_dimension,
                     tp.supplier_code dimension_sort, sum(tp.sum_money) sho_order_money
                from (select t3.company_id, t3.year, t3.month, (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category, t3.supplier_code, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3
                      union all
                      select t3a.company_id, t3a.year,  t3a.month,  (case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category, t3a.supplier_code,
                             (t3a.order_money - t3a.satisfy_money) sum_money
                        from scmdata.pt_ordered t3a
                       inner join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                               or  a.dept_name like '%事业部%' or a.dept_name = '无')) tp
               group by tp.company_id,tp.year,tp.month,tp.category,tp.group_name,tp.supplier_code) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.month = z.month
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select tp.company_id,tp.year,tp.month,tp.category,tp.group_name,'04' count_dimension,
                     tp.supplier_code dimension_sort,sum(tp.sum_money) sho_order_original_money
                from (select t3.company_id, t3.year, t3.month, t3.category, t3.supplier_code, (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3) tp
               group by tp.company_id,tp.year,tp.month,tp.group_name,tp.category,tp.supplier_code) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.month = z1.month
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--补货平均交期指标
      V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_month tka
  USING ( select k.company_id,k.year,k.month,k.category,k.group_name,k.count_dimension,k.dimension_sort,k.delivery_money,qa.delivery_order_money
      from (select t2.company_id,to_char(td.delivery_origin_time, 'yyyy') year,
                     to_char(td.delivery_origin_time, 'mm') month, t2.category, (case when t2.group_name is null then '1' else t2.group_name end)group_name,'04' count_dimension,
                     t2.supplier_code dimension_sort, sum(t2.fixed_price * td.delivery_amount) delivery_money
                from scmdata.pt_ordered t2
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               inner join scmdata.t_delivery_record td
                  on td.order_code = t2.product_gress_code
                 and td.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id, to_char(td.delivery_origin_time, 'yyyy'),
                        to_char(td.delivery_origin_time, 'mm'), t2.group_name, t2.category, t2.supplier_code) k
   left join (select ta0.company_id,ta0.year,ta0.month,ta0.category,ta0.group_name,'04' count_dimension,
                     ta0.supplier_code dimension_sort, sum(ta0.sum1_date * ta0.sum1_money) delivery_order_money
                from (select t5.company_id, to_char(tba.delivery_origin_time, 'yyyy') year,
                             to_char(tba.delivery_origin_time, 'mm') month, t5.category,
                             (case when t5.group_name is null then '1' else t5.group_name end)group_name, t5.supplier_code,
                             (to_date(to_char(tba.delivery_origin_time, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                             to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'),'yyyy/mm/dd')) sum1_date,
                             (t5.fixed_price * tba.delivery_amount) sum1_money
                        from scmdata.pt_ordered t5
                       inner join scmdata.t_delivery_record tba
                          on t5.product_gress_code = tba.order_code
                         and t5.company_id = tba.company_id
                       inner join scmdata.t_ordered tor
                          on tor.company_id = tba.company_id
                         and tor.order_code = tba.order_code
                       inner join scmdata.t_commodity_info tb
                          on t5.goo_id = tb.rela_goo_id
                         and tb.goo_id = tba.goo_id
                         and t5.company_id = tb.company_id
                       where tor.isfirstordered = 0
                         and tor.is_product_order = 1) ta0
               group by ta0.company_id,ta0.year,ta0.month,ta0.category,ta0.group_name,ta0.supplier_code) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.month = qa.month
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort ]';
    /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
    end;

    --6.统计维度：生产工厂
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_month tka
  USING (
        with kpi_order as
  (select t.company_id,t.year,t.month,t.category,(case when t.group_name is null then '1' else t.group_name end)group_name,'05' count_dimension,t.factory_code dimension_sort,sum(t.order_money) order_money
     from scmdata.pt_ordered t
    group by t.company_id,t.year,t.month,t.category,t.group_name,t.factory_code)
 select k.company_id,k.year,k.month,k.category,k.group_name,k.count_dimension,k.dimension_sort,k.order_money,z.sho_order_money,
        z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id, tp.year, tp.month,tp.category, tp.group_name, '05' count_dimension, tp.factory_code dimension_sort,
                      sum(tp.sum_money) sho_order_money
                from (select t3.company_id, t3.year, t3.month, (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category, t3.factory_code, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3
                      union all
                      select t3a.company_id, t3a.year, t3a.month, (case when t3a.group_name is null then '1' else t3a.group_name end)group_name,t3a.category, t3a.factory_code,
                             (t3a.order_money - t3a.satisfy_money) sum_money
                        from scmdata.pt_ordered t3a
                       inner join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                             or a.dept_name like '%事业部%' or a.dept_name = '无')) tp
               group by tp.company_id,tp.year,tp.month,tp.category,tp.group_name,tp.factory_code) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.month = z.month
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select tp.company_id,tp.year,tp.month,tp.category,tp.group_name,'05' count_dimension,
                     tp.factory_code dimension_sort, sum(tp.sum_money) sho_order_original_money
                from (select t3.company_id, t3.year, t3.month, t3.category, t3.factory_code,(case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3) tp
               group by tp.company_id,tp.year,tp.month,tp.group_name,tp.category,tp.factory_code) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.month = z1.month
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--补货平均交期指标
      V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_month tka
  USING ( select k.company_id,k.year,k.month,k.category,k.group_name,k.count_dimension,k.dimension_sort,k.delivery_money,qa.delivery_order_money
      from (select t2.company_id, to_char(td.delivery_origin_time, 'yyyy') year,
                     to_char(td.delivery_origin_time, 'mm') month,
                     t2.category, (case when t2.group_name is null then '1' else t2.group_name end)group_name,'05' count_dimension,t2.factory_code dimension_sort,
                     sum(t2.fixed_price * td.delivery_amount) delivery_money
                from scmdata.pt_ordered t2
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               inner join scmdata.t_delivery_record td
                  on td.order_code = t2.product_gress_code
                 and td.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id, to_char(td.delivery_origin_time, 'yyyy'),
                        to_char(td.delivery_origin_time, 'mm'),t2.group_name,t2.category,t2.factory_code) k
   left join (select ta0.company_id, ta0.year, ta0.month, ta0.category, ta0.group_name, '05' count_dimension,
                     ta0.factory_code dimension_sort, sum(ta0.sum1_date * ta0.sum1_money) delivery_order_money
                from (select t5.company_id, to_char(tba.delivery_origin_time, 'yyyy') year,
                             to_char(tba.delivery_origin_time, 'mm') month,
                             t5.category, (case when t5.group_name is null then '1' else t5.group_name end)group_name, t5.factory_code,
                             (to_date(to_char(tba.delivery_origin_time,  'yyyy/mm/dd'), 'yyyy/mm/dd') -
                             to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                             (t5.fixed_price * tba.delivery_amount) sum1_money
                        from scmdata.pt_ordered t5
                       inner join scmdata.t_delivery_record tba
                          on t5.product_gress_code = tba.order_code
                         and t5.company_id = tba.company_id
                       inner join scmdata.t_ordered tor
                          on tor.company_id = tba.company_id
                         and tor.order_code = tba.order_code
                       inner join scmdata.t_commodity_info tb
                          on t5.goo_id = tb.rela_goo_id
                         and tb.goo_id = tba.goo_id
                         and t5.company_id = tb.company_id
                       where tor.isfirstordered = 0
                         and tor.is_product_order = 1) ta0
               group by ta0.company_id,ta0.year,ta0.month,ta0.category,ta0.group_name,ta0.factory_code) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.month = qa.month
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort ]';
    /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
    end;

    --7.统计维度：跟单
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_month tka
  USING (
        with kpi_order as
   (select t.company_id, t.year, t.month, t.category, (case when t.group_name is null then '1' else t.group_name end)group_name, '06' count_dimension,
           (case when x.follower_leader is null then '1' else x.follower_leader end) dimension_sort, sum(x.sum1) order_money
      from scmdata.pt_ordered t
     inner join (select t1.company_id, t1.product_gress_code, t1.order_money,
                        (t1.order_money / count(t1.product_gress_code) over(partition by t1.product_gress_code)) sum1,
                        regexp_substr(t1.flw_order, '[^,]+', 1, level) follower_leader
                   from scmdata.pt_ordered t1
                 ---where t1.flw_order is not null
                 connect by prior t1.pt_ordered_id = t1.pt_ordered_id
                        and level <=  length(t1.flw_order) - length(regexp_replace(t1.flw_order, ',', '')) + 1
                        and prior dbms_random.value is not null) x
        on x.company_id = t.company_id
       and x.product_gress_code = t.product_gress_code
     group by t.company_id, t.year, t.month, t.category, t.group_name,x.follower_leader),
  flw_leader as
 (select t.company_id, t.product_gress_code,t.fixed_price,t.order_create_date,
         (t.order_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum1,
         (t.satisfy_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum2,
         regexp_substr(t.flw_order, '[^,]+', 1, level) follower_leader
    from scmdata.pt_ordered t
   ---where t.flw_order is not null
 connect by prior t.pt_ordered_id = t.pt_ordered_id
        and level <= length(t.flw_order) - length(regexp_replace(t.flw_order, ',', '')) + 1
        and prior dbms_random.value is not null)
 select k.company_id,k.year, k.month, k.category, k.group_name,k.count_dimension,k.dimension_sort,k.order_money,z.sho_order_money,
        z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id,  tp.year,  tp.month, tp.category, tp.group_name,
                     '06' count_dimension,(case when tp.follower_leader is null then '1' else tp.follower_leader end) dimension_sort, sum(tp.sum2) sho_order_money
                from (select t3.company_id, t3.year, t3.month, (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category, x.follower_leader, x.sum2
                        from scmdata.pt_ordered t3
                        inner join flw_leader x
                          on x.company_id = t3.company_id
                         and x.product_gress_code = t3.product_gress_code
                      union all
                      select t3a.company_id, t3a.year, t3a.month, (case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category, x.follower_leader, (x.sum1- x.sum2) sum_money
                        from scmdata.pt_ordered t3a
                        inner join flw_leader x
                          on x.company_id = t3a.company_id
                         and x.product_gress_code = t3a.product_gress_code
                       left join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                               or a.dept_name like '%事业部%' or a.dept_name = '无')
                      union all
                      select t3a.company_id, t3a.year, t3a.month, (case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category, x.follower_leader, (x.sum1- x.sum2) sum_money
                        from scmdata.pt_ordered t3a
                        inner join flw_leader x
                          on x.company_id = t3a.company_id
                         and x.product_gress_code = t3a.product_gress_code
                       where t3a.responsible_dept = 'b550778b4f2b36b4e0533c281caca074' /*责任部门1级：供应链管理部*/
                         and t3a.responsible_dept_sec in ('DP2203124299047457','b550778b4f4336b4e0533c281caca074',
                             'b550778b4f4836b4e0533c281caca074','b550778b4f3e36b4e0533c281caca074')/*责任部门2级：直播2部、QA组、面料管控部、工艺组*/ ) tp
               group by tp.company_id, tp.year, tp.month, tp.category, tp.group_name, tp.follower_leader) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.month = z.month
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select t3.company_id, t3.year, t3.month, (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category,
                     '06' count_dimension,(case when x.follower_leader is null then '1' else x.follower_leader end) dimension_sort, sum(x.sum2)sho_order_original_money
                from scmdata.pt_ordered t3
               inner join flw_leader x
                  on x.company_id = t3.company_id
                 and x.product_gress_code = t3.product_gress_code
               group by t3.company_id, t3.year, t3.month, t3.group_name, t3.category, x.follower_leader) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.month = z1.month
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--补货平均交期指标
      V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_month tka
  USING (
        with flw_leader as
 (select t.company_id, t.product_gress_code,t.fixed_price,t.order_create_date,
         (t.order_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum1,
         (t.satisfy_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum2,
         regexp_substr(t.flw_order, '[^,]+', 1, level) follower_leader
    from scmdata.pt_ordered t
   ---where t.flw_order is not null
 connect by prior t.pt_ordered_id = t.pt_ordered_id
        and level <= length(t.flw_order) - length(regexp_replace(t.flw_order, ',', '')) + 1
        and prior dbms_random.value is not null)
 select k.company_id,k.year,k.month,k.category,k.group_name,k.count_dimension,k.dimension_sort,k.delivery_money,qa.delivery_order_money
      from (select t2.company_id, x.year, x.month, t2.category, (case when t2.group_name is null then '1' else t2.group_name end)group_name, '06' count_dimension,
                      (case when x.follower_leader is null then '1' else x.follower_leader end) dimension_sort, sum(sum1) delivery_money
                from scmdata.pt_ordered t2
                inner join (select distinct tf.company_id,tf.follower_leader,
                                  tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyy') year, to_char(td.delivery_origin_time, 'mm') month,
                                  ((tf.fixed_price * td.delivery_amount)/
 count(tf.product_gress_code) over(partition by tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyymm'))) sum1
                             from flw_leader tf
                            inner join scmdata.t_delivery_record td
                               on td.order_code = tf.product_gress_code
                              and td.company_id = tf.company_id) x
                  on x.company_id = t2.company_id
                 and x.product_gress_code = t2.product_gress_code
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id,x.year, x.month, t2.group_name, t2.category, x.follower_leader) k
   left join (select t5.company_id, x.year, x.month,t5.category, (case when t5.group_name is null then '1' else t5.group_name end)group_name, '06' count_dimension,
                     (case when x.follower_leader is null then '1' else x.follower_leader end)dimension_sort, sum(x.sum1_date * x.sum1) delivery_order_money
                from scmdata.pt_ordered t5
               inner join scmdata.t_ordered tor
                  on tor.company_id = t5.company_id
                 and tor.order_code = t5.product_gress_code
                 and tor.is_product_order = '1'
               inner join (select distinct tf.company_id,
                                            tf.follower_leader,
                                            tf.product_gress_code,
                                            to_char(td.delivery_origin_time, 'yyyy') year,
                                            to_char(td.delivery_origin_time, 'mm') month,
                                            (to_date(to_char(td.delivery_origin_time, 'yyyy/mm/dd'),  'yyyy/mm/dd') -
                                            to_date(to_char(tf.order_create_date, 'yyyy/mm/dd'),  'yyyy/mm/dd')) sum1_date,
                                            ((tf.fixed_price * td.delivery_amount) /
                                              count(tf.product_gress_code) over(partition by tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyymm'))) sum1,
                                            tf.fixed_price,
                                            td.delivery_amount
                              from flw_leader tf
                             inner join scmdata.t_delivery_record td
                                on td.order_code = tf.product_gress_code
                               and td.company_id = tf.company_id) x
                  on x.company_id = t5.company_id
                 and x.product_gress_code = t5.product_gress_code
                 where tor.isfirstordered = 0
              group by t5.company_id, x.year, x.month,t5.category, t5.group_name,x.follower_leader) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.month = qa.month
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort ]';
    /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
    end;

    --5.统计维度：QC
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_month tka
  USING (
        with kpi_order as
   (select t.company_id, t.year, t.month, t.category, (case when t.group_name is null then '1' else t.group_name end)group_name, '07' count_dimension,
           (case when x.qc is null then '1' else x.qc end) dimension_sort, sum(x.sum1) order_money
      from scmdata.pt_ordered t
     inner join (select t1.company_id, t1.product_gress_code, t1.order_money,
                        (t1.order_money / count(t1.product_gress_code) over(partition by t1.product_gress_code)) sum1,
                        regexp_substr(t1.qc, '[^,]+', 1, level) qc
                   from scmdata.pt_ordered t1
                 -- where t1.qc is not null
                 connect by prior t1.pt_ordered_id = t1.pt_ordered_id
                        and level <=  length(t1.qc) - length(regexp_replace(t1.qc, ',', '')) + 1
                        and prior dbms_random.value is not null) x
        on x.company_id = t.company_id
       and x.product_gress_code = t.product_gress_code
     group by t.company_id, t.year, t.month, t.category, t.group_name,x.qc),
  flw_leader as
 (select t.company_id, t.product_gress_code,t.fixed_price,t.order_create_date,
         (t.order_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum1,
         (t.satisfy_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum2,
         regexp_substr(t.qc, '[^,]+', 1, level) qc
    from scmdata.pt_ordered t
   --where t.qc is not null
 connect by prior t.pt_ordered_id = t.pt_ordered_id
        and level <= length(t.qc) - length(regexp_replace(t.qc, ',', '')) + 1
        and prior dbms_random.value is not null)
 select k.company_id,k.year, k.month, k.category, k.group_name,k.count_dimension,k.dimension_sort,k.order_money,z.sho_order_money,
        z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id,  tp.year,  tp.month, tp.category, tp.group_name,
                     '07' count_dimension,(case when tp.qc is null then '1' else tp.qc end) dimension_sort, sum(tp.sum2) sho_order_money
                from (select t3.company_id, t3.year, t3.month, (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category, x.qc, x.sum2
                        from scmdata.pt_ordered t3
                        inner join flw_leader x
                          on x.company_id = t3.company_id
                         and x.product_gress_code = t3.product_gress_code
                      union all
                      select t3a.company_id, t3a.year, t3a.month, (case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category, x.qc, (x.sum1- x.sum2) sum_money
                        from scmdata.pt_ordered t3a
                        inner join flw_leader x
                          on x.company_id = t3a.company_id
                         and x.product_gress_code = t3a.product_gress_code
                       left join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                              or a.dept_name like '%事业部%' or a.dept_name = '无')
                      union all
                      select t3a.company_id, t3a.year, t3a.month, (case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category, x.qc, (x.sum1- x.sum2) sum_money
                        from scmdata.pt_ordered t3a
                        inner join flw_leader x
                          on x.company_id = t3a.company_id
                         and x.product_gress_code = t3a.product_gress_code
                       where t3a.responsible_dept = 'b550778b4f2b36b4e0533c281caca074' /*责任部门1级：供应链管理部*/
                         and t3a.responsible_dept_sec in ('DP2203124299047457','b550778b4f4336b4e0533c281caca074',
                             'b550778b4f4836b4e0533c281caca074','b550778b4f3e36b4e0533c281caca074')/*责任部门2级：直播2部、QA组、面料管控部、工艺组*/ ) tp
               group by tp.company_id, tp.year, tp.month, tp.category, tp.group_name, tp.qc) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.month = z.month
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select t3.company_id, t3.year, t3.month, (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category,
                     '07' count_dimension,(case when x.qc is null then '1' else x.qc end)dimension_sort, sum(x.sum2)sho_order_original_money
                from scmdata.pt_ordered t3
               inner join flw_leader x
                  on x.company_id = t3.company_id
                 and x.product_gress_code = t3.product_gress_code
               group by t3.company_id, t3.year, t3.month, t3.group_name, t3.category, x.qc) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.month = z1.month
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--补货平均交期指标
      V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_month tka
  USING (
        with  flw_leader as
 (select t.company_id, t.product_gress_code,t.fixed_price,t.order_create_date,
         (t.order_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum1,
         (t.satisfy_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum2,
         regexp_substr(t.qc, '[^,]+', 1, level) qc
    from scmdata.pt_ordered t
   --where t.qc is not null
 connect by prior t.pt_ordered_id = t.pt_ordered_id
        and level <= length(t.qc) - length(regexp_replace(t.qc, ',', '')) + 1
        and prior dbms_random.value is not null)
 select k.company_id,k.year,k.month,k.category,k.group_name,k.count_dimension,k.dimension_sort,k.delivery_money,qa.delivery_order_money
      from(select t2.company_id, x.year, x.month, t2.category, (case when t2.group_name is null then '1' else t2.group_name end)group_name, '07' count_dimension,
                      (case when x.qc is null then '1' else x.qc end) dimension_sort, sum(sum1) delivery_money
                from scmdata.pt_ordered t2
                inner join (select distinct tf.company_id,tf.qc,
                                  tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyy') year, to_char(td.delivery_origin_time, 'mm') month,
                                  ((tf.fixed_price * td.delivery_amount)/
 count(tf.product_gress_code) over(partition by tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyymm'))) sum1
                             from flw_leader tf
                            inner join scmdata.t_delivery_record td
                               on td.order_code = tf.product_gress_code
                              and td.company_id = tf.company_id) x
                  on x.company_id = t2.company_id
                 and x.product_gress_code = t2.product_gress_code
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id,x.year, x.month, t2.group_name, t2.category, x.qc) k
   left join (select t5.company_id, x.year, x.month,t5.category, (case when t5.group_name is null then '1' else t5.group_name end)group_name, '07' count_dimension,
                     (case when x.qc is null then '1' else x.qc end) dimension_sort, sum(x.sum1_date * x.sum1) delivery_order_money
                from scmdata.pt_ordered t5
               inner join scmdata.t_ordered tor
                  on tor.company_id = t5.company_id
                 and tor.order_code = t5.product_gress_code
                 and tor.is_product_order = '1'
               inner join (select distinct tf.company_id,
                                            tf.qc,
                                            tf.product_gress_code,
                                            to_char(td.delivery_origin_time, 'yyyy') year,
                                            to_char(td.delivery_origin_time, 'mm') month,
                                            (to_date(to_char(td.delivery_origin_time, 'yyyy/mm/dd'),  'yyyy/mm/dd') -
                                            to_date(to_char(tf.order_create_date, 'yyyy/mm/dd'),  'yyyy/mm/dd')) sum1_date,
                                            ((tf.fixed_price * td.delivery_amount) /
                                              count(tf.product_gress_code) over(partition by tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyymm'))) sum1,
                                            tf.fixed_price,
                                            td.delivery_amount
                              from flw_leader tf
                             inner join scmdata.t_delivery_record td
                                on td.order_code = tf.product_gress_code
                               and td.company_id = tf.company_id) x
                  on x.company_id = t5.company_id
                 and x.product_gress_code = t5.product_gress_code
                 where tor.isfirstordered = 0
              group by t5.company_id, x.year, x.month,t5.category, t5.group_name,x.qc) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.month = qa.month
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort ]';
    /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
    end;

    --9.统计维度：QC主管
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_month tka
  USING (
        with kpi_order as
   (select t.company_id, t.year, t.month, t.category, (case when t.group_name is null then '1' else t.group_name end)group_name, '08' count_dimension,
           (case when x.qc_manager is null then '1' else x.qc_manager end) dimension_sort, sum(x.sum1) order_money
      from scmdata.pt_ordered t
     inner join (select t1.company_id, t1.product_gress_code, t1.order_money,
                        (t1.order_money / count(t1.product_gress_code) over(partition by t1.product_gress_code)) sum1,
                        regexp_substr(t1.qc_manager, '[^,]+', 1, level) qc_manager
                   from scmdata.pt_ordered t1
                  ---where t1.qc_manager is not null
                 connect by prior t1.pt_ordered_id = t1.pt_ordered_id
                        and level <=  length(t1.qc_manager) - length(regexp_replace(t1.qc_manager, ',', '')) + 1
                        and prior dbms_random.value is not null) x
        on x.company_id = t.company_id
       and x.product_gress_code = t.product_gress_code
     group by t.company_id, t.year, t.month, t.category, t.group_name,x.qc_manager),
  flw_leader as
 (select t.company_id, t.product_gress_code,t.fixed_price,t.order_create_date,
         (t.order_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum1,
         (t.satisfy_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum2,
         regexp_substr(t.qc_manager, '[^,]+', 1, level) qc_manager
    from scmdata.pt_ordered t
   ---where t.qc_manager is not null
 connect by prior t.pt_ordered_id = t.pt_ordered_id
        and level <= length(t.qc_manager) - length(regexp_replace(t.qc_manager, ',', '')) + 1
        and prior dbms_random.value is not null)
 select k.company_id,k.year, k.month, k.category, k.group_name,k.count_dimension,k.dimension_sort,k.order_money,z.sho_order_money,
        z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id,  tp.year,  tp.month, tp.category, tp.group_name,
                     '08' count_dimension,(case when tp.qc_manager is null then '1' else tp.qc_manager end)  dimension_sort, sum(tp.sum2) sho_order_money
                from (select t3.company_id, t3.year, t3.month, (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category, x.qc_manager, x.sum2
                        from scmdata.pt_ordered t3
                        inner join flw_leader x
                          on x.company_id = t3.company_id
                         and x.product_gress_code = t3.product_gress_code
                      union all
                      select t3a.company_id, t3a.year, t3a.month, (case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category, x.qc_manager, (x.sum1- x.sum2) sum_money
                        from scmdata.pt_ordered t3a
                        inner join flw_leader x
                          on x.company_id = t3a.company_id
                         and x.product_gress_code = t3a.product_gress_code
                       left join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                                or a.dept_name like '%事业部%' or a.dept_name = '无')
                      union all
                      select t3a.company_id, t3a.year, t3a.month, (case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category, x.qc_manager, (x.sum1- x.sum2) sum_money
                        from scmdata.pt_ordered t3a
                        inner join flw_leader x
                          on x.company_id = t3a.company_id
                         and x.product_gress_code = t3a.product_gress_code
                       where t3a.responsible_dept = 'b550778b4f2b36b4e0533c281caca074' /*责任部门1级：供应链管理部*/
                         and t3a.responsible_dept_sec in ('DP2203124299047457','b550778b4f4336b4e0533c281caca074',
                             'b550778b4f4836b4e0533c281caca074','b550778b4f3e36b4e0533c281caca074')/*责任部门2级：直播2部、QA组、面料管控部、工艺组*/ ) tp
               group by tp.company_id, tp.year, tp.month, tp.category, tp.group_name, tp.qc_manager) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.month = z.month
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select t3.company_id, t3.year, t3.month, (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category,
                     '08' count_dimension,(case when x.qc_manager is null then '1' else x.qc_manager end)  dimension_sort, sum(x.sum2)sho_order_original_money
                from scmdata.pt_ordered t3
               inner join flw_leader x
                  on x.company_id = t3.company_id
                 and x.product_gress_code = t3.product_gress_code
               group by t3.company_id, t3.year, t3.month, t3.group_name, t3.category, x.qc_manager) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.month = z1.month
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--补货平均交期指标
      V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_month tka
  USING (
        with flw_leader as
 (select t.company_id, t.product_gress_code,t.fixed_price,t.order_create_date,
         (t.order_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum1,
         (t.satisfy_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum2,
         regexp_substr(t.qc_manager, '[^,]+', 1, level) qc_manager
    from scmdata.pt_ordered t
   ---where t.qc_manager is not null
 connect by prior t.pt_ordered_id = t.pt_ordered_id
        and level <= length(t.qc_manager) - length(regexp_replace(t.qc_manager, ',', '')) + 1
        and prior dbms_random.value is not null)
  select k.company_id,k.year,k.month,k.category,k.group_name,k.count_dimension,k.dimension_sort,k.delivery_money,qa.delivery_order_money
      from (select t2.company_id, x.year, x.month, t2.category, (case when t2.group_name is null then '1' else t2.group_name end)group_name, '08' count_dimension,
                      (case when x.qc_manager is null then '1' else x.qc_manager end)  dimension_sort, sum(sum1) delivery_money
                from scmdata.pt_ordered t2
                inner join (select distinct tf.company_id,tf.qc_manager,
                                  tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyy') year, to_char(td.delivery_origin_time, 'mm') month,
                                  ((tf.fixed_price * td.delivery_amount)/
count(tf.product_gress_code) over(partition by tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyymm'))) sum1
                             from flw_leader tf
                            inner join scmdata.t_delivery_record td
                               on td.order_code = tf.product_gress_code
                              and td.company_id = tf.company_id) x
                  on x.company_id = t2.company_id
                 and x.product_gress_code = t2.product_gress_code
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id,x.year, x.month, t2.group_name, t2.category, x.qc_manager) k
   left join (select t5.company_id, x.year, x.month,t5.category, (case when t5.group_name is null then '1' else t5.group_name end)group_name, '08' count_dimension,
                     (case when x.qc_manager is null then '1' else x.qc_manager end)  dimension_sort, sum(x.sum1_date * x.sum1) delivery_order_money
                from scmdata.pt_ordered t5
               inner join scmdata.t_ordered tor
                  on tor.company_id = t5.company_id
                 and tor.order_code = t5.product_gress_code
                 and tor.is_product_order = '1'
               inner join (select distinct tf.company_id,
                                            tf.qc_manager,
                                            tf.product_gress_code,
                                            to_char(td.delivery_origin_time, 'yyyy') year,
                                            to_char(td.delivery_origin_time, 'mm') month,
                                            (to_date(to_char(td.delivery_origin_time, 'yyyy/mm/dd'),  'yyyy/mm/dd') -
                                            to_date(to_char(tf.order_create_date, 'yyyy/mm/dd'),  'yyyy/mm/dd')) sum1_date,
                                            ((tf.fixed_price * td.delivery_amount)  /
                                              count(tf.product_gress_code) over(partition by tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyymm'))) sum1,
                                            tf.fixed_price,
                                            td.delivery_amount
                              from flw_leader tf
                             inner join scmdata.t_delivery_record td
                                on td.order_code = tf.product_gress_code
                               and td.company_id = tf.company_id) x
                  on x.company_id = t5.company_id
                 and x.product_gress_code = t5.product_gress_code
                 where tor.isfirstordered = 0
              group by t5.company_id, x.year, x.month,t5.category, t5.group_name,x.qc_manager) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.month = qa.month
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort ]';
    /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
    end;
  END P_T_KPI_MONTH;

  /*----------------------------------------------------------------------------
   对象：
        P_T_KPI_QUARTER
   统计维度：
       分类、区域组、款式名称、产品子类、供应商、生产工厂、跟单、qc、qc主管
   时间维度：
       季度
   用途：
       多维度指标查询季度数据表（scmdata.t_kpi_quarter）
   更新规则：
       每季度6号（1月6号、4月6号、7月6号、10月6号）凌晨4点半更新前一季度的数据
   t_type参数解析
        t_type = 0 更新全部指标
        t_type = 1 更新订单满足率（原值、绩效值）指标
        t_type = 2 更新补货平均交期指标
   p_type参数解析
        p_type = 0 更新全部历史数据
        p_type = 1 只更新上一个维度（季度）的数据
   上线版本：2022-10-30
   -----------------------------------------------------------------------------*/
  PROCEDURE P_T_KPI_QUARTER(t_type number, p_type number) IS
    V_Q_SQL  clob;--订单满足率指标
    V_Q1_SQL clob;--补货平均交期指标
    ---更新全部历史数据
    V_W_SQL clob := q'[
   where (k.year || k.quarter) <= (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q')) ) tkb
      ON (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.quarter = tkb.quarter and tka.category = tkb.category
          and tka.groupname = tkb.group_name and tka.count_dimension = tkb.count_dimension and tka.dimension_sort = tkb.dimension_sort)
     WHEN MATCHED THEN]';
    ---更新上季度数据
    V_W1_SQL clob := q'[
   where (k.year || k.quarter) = (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q')) ) tkb
      ON (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.quarter = tkb.quarter and tka.category = tkb.category
          and tka.groupname = tkb.group_name and tka.count_dimension = tkb.count_dimension and tka.dimension_sort = tkb.dimension_sort)
     WHEN MATCHED THEN]';
    ---更新全部指标
    V_U_SQL clob := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.sho_order_money           = tkb.sho_order_money,
             tka.sho_order_original_money  = tkb.sho_order_original_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    ---更新补货平均交期
    V_U1_SQL clob := q'[  UPDATE
         SET tka.delivery_money            = tkb.delivery_money,
             tka.delivery_order_money      = tkb.delivery_order_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    ---新增订单满足率指标
    V_IN_SQL clob := q'[
    WHEN NOT MATCHED THEN
      INSERT
        (tka.t_kpi_q_id,
         tka.company_id,
         tka.year,
         tka.quarter,
         tka.category,
         tka.groupname,
         tka.count_dimension,
         tka.dimension_sort,
         tka.order_money,
         tka.sho_order_money,
         tka.sho_order_original_money,
         tka.memo,
         tka.create_id,
         tka.create_time,
         tka.update_id,
         tka.update_time)
      VALUES
        (scmdata.f_get_uuid(),
         tkb.company_id,
         tkb.year,
         tkb.quarter,
         tkb.category,
         tkb.group_name,
         tkb.count_dimension,
         tkb.dimension_sort,
         tkb.order_money,
         tkb.sho_order_money,
         tkb.sho_order_original_money,
         ' ',
         'ADMIN',
         sysdate,
         'ADMIN',
         sysdate)]';
    ---新增补货平均交期指标
    V_IN1_SQL clob := q'[
    WHEN NOT MATCHED THEN
      INSERT
        (tka.t_kpi_q_id,
         tka.company_id,
         tka.year,
         tka.quarter,
         tka.category,
         tka.groupname,
         tka.count_dimension,
         tka.dimension_sort,
         tka.delivery_money,
         tka.delivery_order_money,
         tka.memo,
         tka.create_id,
         tka.create_time,
         tka.update_id,
         tka.update_time)
      VALUES
        (scmdata.f_get_uuid(),
         tkb.company_id,
         tkb.year,
         tkb.quarter,
         tkb.category,
         tkb.group_name,
         tkb.count_dimension,
         tkb.dimension_sort,
         tkb.delivery_money,
         tkb.delivery_order_money,
         ' ',
         'ADMIN',
         sysdate,
         'ADMIN',
         sysdate)]';
    V_SQL    clob;
    V1_SQL    clob;
    --1.统计维度：分类
  BEGIN
--订单满足率指标
    V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_quarter tka
  USING (
      with kpi_order as
  (select t.company_id, t.year, t.quarter, t.category, (case when t.group_name is null then '1' else t.group_name end)group_name,
         '00' count_dimension, t.category dimension_sort, sum(t.order_money) order_money
     from scmdata.pt_ordered t
    group by t.company_id, t.year, t.quarter, t.category, t.group_name)
 select k.company_id, k.year, k.quarter, k.category, k.group_name, k.count_dimension, k.dimension_sort,
        k.order_money, z.sho_order_money,  z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id,tp.year,tp.quarter,tp.category, tp.group_name,
                     '00' count_dimension, tp.category dimension_sort, sum(tp.sum_money) sho_order_money
                from (select t3.company_id, t3.year,t3.quarter, (case when t3.group_name is null then '1' else t3.group_name end)group_name,
                             t3.category, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3
                      union all
                      select t3a.company_id, t3a.year, t3a.quarter, (case when t3a.group_name is null then '1' else t3a.group_name end)group_name,
                             t3a.category,(t3a.order_money - t3a.satisfy_money) sum_money
                        from scmdata.pt_ordered t3a
                       inner join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                               or a.dept_name like '%事业部%' or a.dept_name = '无')) tp
               group by tp.company_id, tp.year, tp.quarter, tp.category, tp.group_name) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.quarter = z.quarter
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select tp.company_id, tp.year, tp.quarter, tp.category, tp.group_name, '00' count_dimension,
                     tp.category dimension_sort, sum(tp.sum_money) sho_order_original_money
                from (select t3.company_id, t3.year, t3.quarter, t3.category,
                             (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3) tp
               group by tp.company_id, tp.year, tp.quarter, tp.group_name, tp.category) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.quarter = z1.quarter
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--补货平均交期指标
    V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_quarter tka
  USING (select k.company_id, k.year, k.quarter, k.category, k.group_name, k.count_dimension, k.dimension_sort,
        k.delivery_money,qa.delivery_order_money
        from( select t2.company_id,  to_char(td.delivery_origin_time, 'yyyy') year, to_char(td.delivery_origin_time, 'Q') quarter,
                     t2.category,(case when t2.group_name is null then '1' else t2.group_name end)group_name, '00' count_dimension, t2.category dimension_sort,
                     sum(t2.fixed_price * td.delivery_amount) delivery_money
                from scmdata.pt_ordered t2
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               inner join scmdata.t_delivery_record td
                  on td.order_code = t2.product_gress_code
                 and td.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id,  to_char(td.delivery_origin_time, 'yyyy'),
                        to_char(td.delivery_origin_time, 'Q'), t2.group_name, t2.category) k
   left join (select ta0.company_id, ta0.year, ta0.quarter, ta0.category, ta0.group_name, '00' count_dimension, ta0.category dimension_sort,
                     sum(ta0.sum1_date * ta0.sum1_money) delivery_order_money
                from (select t5.company_id, to_char(tba.delivery_origin_time, 'yyyy') year,
                             to_char(tba.delivery_origin_time, 'Q') quarter,  t5.category,
                             (case when t5.group_name is null then '1' else t5.group_name end)group_name,
                             (to_date(to_char(tba.delivery_origin_time, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                             to_date(to_char(t5.order_create_date,  'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                             (t5.fixed_price * tba.delivery_amount) sum1_money
                        from scmdata.pt_ordered t5
                       inner join scmdata.t_delivery_record tba
                          on t5.product_gress_code = tba.order_code
                         and t5.company_id = tba.company_id
                       inner join scmdata.t_ordered tor
                          on tor.company_id = tba.company_id
                         and tor.order_code = tba.order_code
                       inner join scmdata.t_commodity_info tb
                          on t5.goo_id = tb.rela_goo_id
                         and tb.goo_id = tba.goo_id
                         and t5.company_id = tb.company_id
                       where tor.isfirstordered = 0
                         and tor.is_product_order = 1) ta0
               group by ta0.company_id, ta0.year, ta0.quarter, ta0.category, ta0.group_name) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.quarter = qa.quarter
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort ]';

   /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;

    --2.统计维度：区域组
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_quarter tka
  USING (
        with kpi_order as
  (select t.company_id, t.year,t.quarter, t.category, (case when t.group_name is null then '1' else t.group_name end)group_name, '01' count_dimension,
          (case when t.group_name is null then '1' else t.group_name end) dimension_sort, sum(t.order_money) order_money
     from scmdata.pt_ordered t
    group by t.company_id, t.year, t.quarter, t.category, t.group_name)
 select k.company_id, k.year, k.quarter, k.category, k.group_name, k.count_dimension, k.dimension_sort,
        k.order_money, z.sho_order_money, z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id, tp.year, tp.quarter, tp.category, tp.group_name,
                     '01' count_dimension, tp.group_name dimension_sort, sum(tp.sum_money) sho_order_money
                from (select t3.company_id, t3.year, t3.quarter, (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3
                      union all
                      select t3a.company_id,  t3a.year, t3a.quarter,(case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category, (t3a.order_money - t3a.satisfy_money) sum_money
                        from scmdata.pt_ordered t3a
                       inner join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                               or a.dept_name like '%事业部%' or a.dept_name = '无')) tp
               group by tp.company_id, tp.year, tp.quarter, tp.category, tp.group_name) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.quarter = z.quarter
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select tp.company_id, tp.year, tp.quarter,tp.category, tp.group_name,
                     '01' count_dimension, tp.group_name dimension_sort, sum(tp.sum_money) sho_order_original_money
                from (select t3.company_id, t3.year, t3.quarter, t3.category, (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3) tp
               group by tp.company_id, tp.year, tp.quarter, tp.group_name, tp.category) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.quarter = z1.quarter
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--补货平均交期指标
      V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_quarter tka
  USING (select k.company_id, k.year, k.quarter, k.category, k.group_name, k.count_dimension, k.dimension_sort,
       k.delivery_money,qa.delivery_order_money
  from  (select t2.company_id, to_char(td.delivery_origin_time, 'yyyy') year,
                     to_char(td.delivery_origin_time, 'Q') quarter, t2.category, (case when t2.group_name is null then '1' else t2.group_name end)group_name, '01' count_dimension,
                     (case when t2.group_name is null then '1' else t2.group_name end) dimension_sort, sum(t2.fixed_price * td.delivery_amount) delivery_money
                from scmdata.pt_ordered t2
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               inner join scmdata.t_delivery_record td
                  on td.order_code = t2.product_gress_code
                 and td.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id,  to_char(td.delivery_origin_time, 'yyyy'),
                        to_char(td.delivery_origin_time, 'Q'), t2.group_name,  t2.category) k
   left join (select ta0.company_id, ta0.year, ta0.quarter,  ta0.category, ta0.group_name,
                     '01' count_dimension, ta0.group_name dimension_sort, sum(ta0.sum1_date * ta0.sum1_money) delivery_order_money
                from (select t5.company_id,   to_char(tba.delivery_origin_time, 'yyyy') year,
                             to_char(tba.delivery_origin_time, 'Q') quarter, t5.category,
                             (case when t5.group_name is null then '1' else t5.group_name end)group_name,
                             (to_date(to_char(tba.delivery_origin_time,  'yyyy/mm/dd'), 'yyyy/mm/dd') -
                             to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                             (t5.fixed_price * tba.delivery_amount) sum1_money
                        from scmdata.pt_ordered t5
                       inner join scmdata.t_delivery_record tba
                          on t5.product_gress_code = tba.order_code
                         and t5.company_id = tba.company_id
                       inner join scmdata.t_ordered tor
                          on tor.company_id = tba.company_id
                         and tor.order_code = tba.order_code
                       inner join scmdata.t_commodity_info tb
                          on t5.goo_id = tb.rela_goo_id
                         and tb.goo_id = tba.goo_id
                         and t5.company_id = tb.company_id
                       where tor.isfirstordered = 0
                         and tor.is_product_order = 1) ta0
               group by ta0.company_id, ta0.year, ta0.quarter, ta0.category, ta0.group_name) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.quarter = qa.quarter
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort ]';

   /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
    end;

    --3.统计维度：款式名称
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_quarter tka
  USING (
        with kpi_order as
  (select t.company_id, t.year, t.quarter, t.category, (case when t.group_name is null then '1' else t.group_name end)group_name, '02' count_dimension,
          t.style_name dimension_sort,sum(t.order_money) order_money
     from scmdata.pt_ordered t
    group by t.company_id, t.year, t.quarter, t.category, t.group_name, t.style_name)
 select k.company_id, k.year, k.quarter, k.category, k.group_name, k.count_dimension, k.dimension_sort,
        k.order_money, z.sho_order_money, z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id, tp.year, tp.quarter, tp.category, tp.group_name,
                     '02' count_dimension, tp.style_name dimension_sort, sum(tp.sum_money) sho_order_money
                from (select t3.company_id, t3.year, t3.quarter,(case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category, t3.style_name, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3
                      union all
                      select t3a.company_id, t3a.year, t3a.quarter, (case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category,
                             t3a.style_name, (t3a.order_money - t3a.satisfy_money) sum_money
                        from scmdata.pt_ordered t3a
                       inner join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                              or a.dept_name like '%事业部%' or a.dept_name = '无')) tp
               group by tp.company_id, tp.year, tp.quarter, tp.category, tp.group_name, tp.style_name) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.quarter = z.quarter
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select tp.company_id, tp.year, tp.quarter, tp.category, tp.group_name,
                     '02' count_dimension, tp.style_name dimension_sort, sum(tp.sum_money) sho_order_original_money
                from (select t3.company_id, t3.year, t3.quarter, t3.category, t3.style_name, (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3) tp
               group by tp.company_id,tp.year,tp.quarter,tp.group_name,tp.category,tp.style_name) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.quarter = z1.quarter
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--补货平均交期指标
      V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_quarter tka
  USING (select k.company_id, k.year, k.quarter, k.category, k.group_name, k.count_dimension, k.dimension_sort,
       k.delivery_money,qa.delivery_order_money
  from (select t2.company_id, to_char(td.delivery_origin_time, 'yyyy') year,
                     to_char(td.delivery_origin_time, 'Q') quarter,t2.category,(case when t2.group_name is null then '1' else t2.group_name end)group_name,'02' count_dimension,
                     t2.style_name dimension_sort, sum(t2.fixed_price * td.delivery_amount) delivery_money
                from scmdata.pt_ordered t2
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               inner join scmdata.t_delivery_record td
                  on td.order_code = t2.product_gress_code
                 and td.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id,to_char(td.delivery_origin_time, 'yyyy'),
                        to_char(td.delivery_origin_time, 'Q'),t2.group_name,t2.category,t2.style_name) k
   left join (select ta0.company_id, ta0.year, ta0.quarter, ta0.category, ta0.group_name, '02' count_dimension, ta0.style_name dimension_sort,
                     sum(ta0.sum1_date * ta0.sum1_money) delivery_order_money
                from (select t5.company_id, to_char(tba.delivery_origin_time, 'yyyy') year,
                             to_char(tba.delivery_origin_time, 'Q') quarter, t5.category, (case when t5.group_name is null then '1' else t5.group_name end)group_name, t5.style_name,
                             (to_date(to_char(tba.delivery_origin_time, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                             to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                             (t5.fixed_price * tba.delivery_amount) sum1_money
                        from scmdata.pt_ordered t5
                       inner join scmdata.t_delivery_record tba
                          on t5.product_gress_code = tba.order_code
                         and t5.company_id = tba.company_id
                       inner join scmdata.t_ordered tor
                          on tor.company_id = tba.company_id
                         and tor.order_code = tba.order_code
                       inner join scmdata.t_commodity_info tb
                          on t5.goo_id = tb.rela_goo_id
                         and tb.goo_id = tba.goo_id
                         and t5.company_id = tb.company_id
                       where tor.isfirstordered = 0
                         and tor.is_product_order = 1) ta0
               group by ta0.company_id, ta0.year, ta0.quarter, ta0.category, ta0.group_name, ta0.style_name) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.quarter = qa.quarter
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort ]';
   /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
    end;

    --4.统计维度：产品子类
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_quarter tka
  USING (
        with kpi_order as
  (select t.company_id,  t.year, t.quarter, t.category, (case when t.group_name is null then '1' else t.group_name end)group_name, '03' count_dimension, t.samll_category dimension_sort, sum(t.order_money) order_money
     from scmdata.pt_ordered t
    group by t.company_id, t.year, t.quarter, t.category, t.group_name, t.samll_category)
 select k.company_id, k.year,  k.quarter, k.category, k.group_name, k.count_dimension, k.dimension_sort, k.order_money,
        z.sho_order_money, z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id,  tp.year, tp.quarter, tp.category, tp.group_name, '03' count_dimension,
                     tp.samll_category dimension_sort, sum(tp.sum_money) sho_order_money
                from (select t3.company_id, t3.year, t3.quarter, (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category, t3.samll_category,  t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3
                      union all
                      select t3a.company_id, t3a.year, t3a.quarter, (case when t3a.group_name is null then '1' else t3a.group_name end)group_name,  t3a.category,
                             t3a.samll_category, (t3a.order_money - t3a.satisfy_money) sum_money
                        from scmdata.pt_ordered t3a
                       inner join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                              or a.dept_name like '%事业部%' or a.dept_name = '无')) tp
               group by tp.company_id,tp.year, tp.quarter, tp.category, tp.group_name,  tp.samll_category) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.quarter = z.quarter
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select tp.company_id, tp.year, tp.quarter, tp.category, tp.group_name, '03' count_dimension,
                     tp.samll_category dimension_sort, sum(tp.sum_money) sho_order_original_money
                from (select t3.company_id, t3.year, t3.quarter, t3.category, t3.samll_category,
                             (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3) tp
               group by tp.company_id, tp.year, tp.quarter, tp.group_name, tp.category, tp.samll_category) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.quarter = z1.quarter
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--补货平均交期指标
      V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_quarter tka
  USING (select k.company_id, k.year, k.quarter, k.category, k.group_name, k.count_dimension, k.dimension_sort,
       k.delivery_money,qa.delivery_order_money
  from (select t2.company_id,  to_char(td.delivery_origin_time, 'yyyy') year,
                     to_char(td.delivery_origin_time, 'Q') quarter, t2.category,  (case when t2.group_name is null then '1' else t2.group_name end)group_name, '03' count_dimension,
                     t2.samll_category dimension_sort, sum(t2.fixed_price * td.delivery_amount) delivery_money
                from scmdata.pt_ordered t2
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               inner join scmdata.t_delivery_record td
                  on td.order_code = t2.product_gress_code
                 and td.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id, to_char(td.delivery_origin_time, 'yyyy'), to_char(td.delivery_origin_time, 'Q'),
                        t2.group_name, t2.category, t2.samll_category) k
   left join (select ta0.company_id,  ta0.year, ta0.quarter, ta0.category, ta0.group_name, '03' count_dimension,
                     ta0.samll_category dimension_sort, sum(ta0.sum1_date * ta0.sum1_money) delivery_order_money
                from (select t5.company_id, to_char(tba.delivery_origin_time, 'yyyy') year,
                             to_char(tba.delivery_origin_time, 'Q') quarter, t5.category, (case when t5.group_name is null then '1' else t5.group_name end)group_name, t5.samll_category,
                             (to_date(to_char(tba.delivery_origin_time, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                             to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                             (t5.fixed_price * tba.delivery_amount) sum1_money
                        from scmdata.pt_ordered t5
                       inner join scmdata.t_delivery_record tba
                          on t5.product_gress_code = tba.order_code
                         and t5.company_id = tba.company_id
                       inner join scmdata.t_ordered tor
                          on tor.company_id = tba.company_id
                         and tor.order_code = tba.order_code
                       inner join scmdata.t_commodity_info tb
                          on t5.goo_id = tb.rela_goo_id
                         and tb.goo_id = tba.goo_id
                         and t5.company_id = tb.company_id
                       where tor.isfirstordered = 0
                         and tor.is_product_order = 1) ta0
               group by ta0.company_id, ta0.year, ta0.quarter, ta0.category, ta0.group_name, ta0.samll_category) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.quarter = qa.quarter
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort ]';
   /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
    end;

    --5.统计维度：供应商
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_quarter tka
  USING (
        with kpi_order as
  (select t.company_id, t.year, t.quarter, t.category, (case when t.group_name is null then '1' else t.group_name end)group_name,'04' count_dimension, t.supplier_code dimension_sort, sum(t.order_money) order_money
     from scmdata.pt_ordered t
    group by t.company_id, t.year, t.quarter, t.category, t.group_name, t.supplier_code)
 select k.company_id, k.year, k.quarter, k.category, k.group_name, k.count_dimension, k.dimension_sort, k.order_money,
        z.sho_order_money, z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id, tp.year, tp.quarter, tp.category, tp.group_name, '04' count_dimension,
                     tp.supplier_code dimension_sort, sum(tp.sum_money) sho_order_money
                from (select t3.company_id, t3.year, t3.quarter, (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category, t3.supplier_code, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3
                      union all
                      select t3a.company_id, t3a.year,  t3a.quarter, (case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category, t3a.supplier_code,
                             (t3a.order_money - t3a.satisfy_money) sum_money
                        from scmdata.pt_ordered t3a
                       inner join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                              or  a.dept_name like '%事业部%' or a.dept_name = '无')) tp
               group by tp.company_id,tp.year,tp.quarter,tp.category,tp.group_name,tp.supplier_code) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.quarter = z.quarter
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select tp.company_id,tp.year,tp.quarter,tp.category,tp.group_name,'04' count_dimension,
                     tp.supplier_code dimension_sort,sum(tp.sum_money) sho_order_original_money
                from (select t3.company_id, t3.year, t3.quarter, t3.category, t3.supplier_code,
                             (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3) tp
               group by tp.company_id,tp.year,tp.quarter,tp.group_name,tp.category,tp.supplier_code) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.quarter = z1.quarter
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort  ]';
--补货平均交期指标
      V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_quarter tka
  USING ( select k.company_id, k.year, k.quarter, k.category, k.group_name, k.count_dimension, k.dimension_sort,
       k.delivery_money,qa.delivery_order_money
  from (select t2.company_id,to_char(td.delivery_origin_time, 'yyyy') year,
                     to_char(td.delivery_origin_time, 'Q') quarter, t2.category,(case when t2.group_name is null then '1' else t2.group_name end)group_name,'04' count_dimension,
                     t2.supplier_code dimension_sort, sum(t2.fixed_price * td.delivery_amount) delivery_money
                from scmdata.pt_ordered t2
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               inner join scmdata.t_delivery_record td
                  on td.order_code = t2.product_gress_code
                 and td.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id, to_char(td.delivery_origin_time, 'yyyy'),
                        to_char(td.delivery_origin_time, 'Q'), t2.group_name, t2.category, t2.supplier_code) k
   left join (select ta0.company_id,ta0.year,ta0.quarter,ta0.category,ta0.group_name,'04' count_dimension,
                     ta0.supplier_code dimension_sort, sum(ta0.sum1_date * ta0.sum1_money) delivery_order_money
                from (select t5.company_id, to_char(tba.delivery_origin_time, 'yyyy') year,
                             to_char(tba.delivery_origin_time, 'Q') quarter, t5.category,(case when t5.group_name is null then '1' else t5.group_name end)group_name, t5.supplier_code,
                             (to_date(to_char(tba.delivery_origin_time, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                             to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'),'yyyy/mm/dd')) sum1_date,
                             (t5.fixed_price * tba.delivery_amount) sum1_money
                        from scmdata.pt_ordered t5
                       inner join scmdata.t_delivery_record tba
                          on t5.product_gress_code = tba.order_code
                         and t5.company_id = tba.company_id
                       inner join scmdata.t_ordered tor
                          on tor.company_id = tba.company_id
                         and tor.order_code = tba.order_code
                       inner join scmdata.t_commodity_info tb
                          on t5.goo_id = tb.rela_goo_id
                         and tb.goo_id = tba.goo_id
                         and t5.company_id = tb.company_id
                       where tor.isfirstordered = 0
                         and tor.is_product_order = 1) ta0
               group by ta0.company_id,ta0.year,ta0.quarter,ta0.category,ta0.group_name,ta0.supplier_code) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.quarter = qa.quarter
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort  ]';
   /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
    end;

    --6.统计维度：生产工厂
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_quarter tka
  USING (
        with kpi_order as
  (select t.company_id,t.year,t.quarter,t.category,(case when t.group_name is null then '1' else t.group_name end)group_name,'05' count_dimension,t.factory_code dimension_sort,sum(t.order_money) order_money
     from scmdata.pt_ordered t
    group by t.company_id,t.year,t.quarter,t.category,t.group_name,t.factory_code)
 select k.company_id,k.year,k.quarter,k.category,k.group_name,k.count_dimension,k.dimension_sort,k.order_money,z.sho_order_money,
        z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id, tp.year, tp.quarter,tp.category, tp.group_name, '05' count_dimension, tp.factory_code dimension_sort,
                      sum(tp.sum_money) sho_order_money
                from (select t3.company_id, t3.year, t3.quarter,(case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category, t3.factory_code, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3
                      union all
                      select t3a.company_id, t3a.year, t3a.quarter, (case when t3a.group_name is null then '1' else t3a.group_name end)group_name,t3a.category, t3a.factory_code,
                             (t3a.order_money - t3a.satisfy_money) sum_money
                        from scmdata.pt_ordered t3a
                       inner join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                                or a.dept_name like '%事业部%' or a.dept_name = '无')) tp
               group by tp.company_id,tp.year,tp.quarter,tp.category,tp.group_name,tp.factory_code) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.quarter = z.quarter
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select tp.company_id,tp.year,tp.quarter,tp.category,tp.group_name,'05' count_dimension,
                     tp.factory_code dimension_sort, sum(tp.sum_money) sho_order_original_money
                from (select t3.company_id, t3.year, t3.quarter, t3.category, t3.factory_code,(case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3) tp
               group by tp.company_id,tp.year,tp.quarter,tp.group_name,tp.category,tp.factory_code) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.quarter = z1.quarter
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort  ]';
--补货平均交期指标
      V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_quarter tka
  USING ( select k.company_id, k.year, k.quarter, k.category, k.group_name, k.count_dimension, k.dimension_sort,
       k.delivery_money,qa.delivery_order_money
  from  (select t2.company_id, to_char(td.delivery_origin_time, 'yyyy') year,
                     to_char(td.delivery_origin_time, 'Q') quarter,
                     t2.category, (case when t2.group_name is null then '1' else t2.group_name end)group_name,'05' count_dimension,t2.factory_code dimension_sort,
                     sum(t2.fixed_price * td.delivery_amount) delivery_money
                from scmdata.pt_ordered t2
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               inner join scmdata.t_delivery_record td
                  on td.order_code = t2.product_gress_code
                 and td.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id, to_char(td.delivery_origin_time, 'yyyy'),
                        to_char(td.delivery_origin_time, 'Q'),t2.group_name,t2.category,t2.factory_code) k
   left join (select ta0.company_id, ta0.year, ta0.quarter, ta0.category, ta0.group_name, '05' count_dimension,
                     ta0.factory_code dimension_sort, sum(ta0.sum1_date * ta0.sum1_money) delivery_order_money
                from (select t5.company_id, to_char(tba.delivery_origin_time, 'yyyy') year,
                             to_char(tba.delivery_origin_time, 'Q') quarter,
                             t5.category, (case when t5.group_name is null then '1' else t5.group_name end)group_name, t5.factory_code,
                             (to_date(to_char(tba.delivery_origin_time,  'yyyy/mm/dd'), 'yyyy/mm/dd') -
                             to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                             (t5.fixed_price * tba.delivery_amount) sum1_money
                        from scmdata.pt_ordered t5
                       inner join scmdata.t_delivery_record tba
                          on t5.product_gress_code = tba.order_code
                         and t5.company_id = tba.company_id
                       inner join scmdata.t_ordered tor
                          on tor.company_id = tba.company_id
                         and tor.order_code = tba.order_code
                       inner join scmdata.t_commodity_info tb
                          on t5.goo_id = tb.rela_goo_id
                         and tb.goo_id = tba.goo_id
                         and t5.company_id = tb.company_id
                       where tor.isfirstordered = 0
                         and tor.is_product_order = 1) ta0
               group by ta0.company_id,ta0.year,ta0.quarter,ta0.category,ta0.group_name,ta0.factory_code) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.quarter = qa.quarter
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort  ]';
     /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
    end;

    --7.统计维度：跟单
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_quarter tka
  USING (
        with kpi_order as
   (select t.company_id, t.year, t.quarter, t.category, (case when t.group_name is null then '1' else t.group_name end)group_name, '06' count_dimension,
           (case when x.follower_leader is null then '1' else x.follower_leader end) dimension_sort, sum(x.sum1) order_money
      from scmdata.pt_ordered t
     inner join (select t1.company_id, t1.product_gress_code, t1.order_money,
                        (t1.order_money / count(t1.product_gress_code) over(partition by t1.product_gress_code)) sum1,
                        regexp_substr(t1.flw_order, '[^,]+', 1, level) follower_leader
                   from scmdata.pt_ordered t1
                  ---where t1.flw_order is not null
                 connect by prior t1.pt_ordered_id = t1.pt_ordered_id
                        and level <=  length(t1.flw_order) - length(regexp_replace(t1.flw_order, ',', '')) + 1
                        and prior dbms_random.value is not null) x
        on x.company_id = t.company_id
       and x.product_gress_code = t.product_gress_code
     group by t.company_id, t.year, t.quarter, t.category, t.group_name,x.follower_leader),
  flw_leader as
 (select t.company_id, t.product_gress_code,t.fixed_price,t.order_create_date,
         (t.order_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum1,
         (t.satisfy_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum2,
         regexp_substr(t.flw_order, '[^,]+', 1, level) follower_leader
    from scmdata.pt_ordered t
   ---where t.flw_order is not null
 connect by prior t.pt_ordered_id = t.pt_ordered_id
        and level <= length(t.flw_order) - length(regexp_replace(t.flw_order, ',', '')) + 1
        and prior dbms_random.value is not null)
 select k.company_id,k.year, k.quarter, k.category, k.group_name,k.count_dimension,k.dimension_sort,k.order_money,z.sho_order_money,
        z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id,  tp.year,  tp.quarter, tp.category, tp.group_name,
                     '06' count_dimension,(case when tp.follower_leader is null then '1' else tp.follower_leader end) dimension_sort, sum(tp.sum2) sho_order_money
                from (select t3.company_id, t3.year, t3.quarter, (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category, x.follower_leader, x.sum2
                        from scmdata.pt_ordered t3
                        inner join flw_leader x
                          on x.company_id = t3.company_id
                         and x.product_gress_code = t3.product_gress_code
                      union all
                      select t3a.company_id, t3a.year, t3a.quarter, (case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category, x.follower_leader, (x.sum1- x.sum2) sum_money
                        from scmdata.pt_ordered t3a
                        inner join flw_leader x
                          on x.company_id = t3a.company_id
                         and x.product_gress_code = t3a.product_gress_code
                       left join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                                  or a.dept_name like '%事业部%' or a.dept_name = '无')
                      union all
                      select t3a.company_id, t3a.year, t3a.quarter, (case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category, x.follower_leader, (x.sum1- x.sum2) sum_money
                        from scmdata.pt_ordered t3a
                        inner join flw_leader x
                          on x.company_id = t3a.company_id
                         and x.product_gress_code = t3a.product_gress_code
                       where t3a.responsible_dept = 'b550778b4f2b36b4e0533c281caca074' /*责任部门1级：供应链管理部*/
                         and t3a.responsible_dept_sec in ('DP2203124299047457','b550778b4f4336b4e0533c281caca074',
                             'b550778b4f4836b4e0533c281caca074','b550778b4f3e36b4e0533c281caca074')/*责任部门2级：直播2部、QA组、面料管控部、工艺组*/ ) tp
               group by tp.company_id, tp.year, tp.quarter, tp.category, tp.group_name, tp.follower_leader) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.quarter = z.quarter
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select t3.company_id, t3.year, t3.quarter, (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category,
                     '06' count_dimension,(case when x.follower_leader is null then '1' else x.follower_leader end) dimension_sort, sum(x.sum2)sho_order_original_money
                from scmdata.pt_ordered t3
               inner join flw_leader x
                  on x.company_id = t3.company_id
                 and x.product_gress_code = t3.product_gress_code
               group by t3.company_id, t3.year, t3.quarter, t3.group_name, t3.category, x.follower_leader) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.quarter = z1.quarter
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--补货平均交期指标
      V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_quarter tka
  USING (
        with flw_leader as
 (select t.company_id, t.product_gress_code,t.fixed_price,t.order_create_date,
         (t.order_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum1,
         (t.satisfy_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum2,
         regexp_substr(t.flw_order, '[^,]+', 1, level) follower_leader
    from scmdata.pt_ordered t
   ---where t.flw_order is not null
 connect by prior t.pt_ordered_id = t.pt_ordered_id
        and level <= length(t.flw_order) - length(regexp_replace(t.flw_order, ',', '')) + 1
        and prior dbms_random.value is not null)
   select k.company_id, k.year, k.quarter, k.category, k.group_name, k.count_dimension, k.dimension_sort,
       k.delivery_money,qa.delivery_order_money
  from (select t2.company_id, x.year, x.quarter, t2.category, (case when t2.group_name is null then '1' else t2.group_name end)group_name, '06' count_dimension,
                      (case when x.follower_leader is null then '1' else x.follower_leader end) dimension_sort, sum(sum1) delivery_money
                from scmdata.pt_ordered t2
                inner join (select distinct tf.company_id,tf.follower_leader,
                                  tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyy') year, to_char(td.delivery_origin_time, 'Q') quarter,
                                  ((tf.fixed_price * td.delivery_amount)/ count(tf.product_gress_code)
 over(partition by tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyy'), to_char(td.delivery_origin_time, 'Q'))) sum1
                             from flw_leader tf
                            inner join scmdata.t_delivery_record td
                               on td.order_code = tf.product_gress_code
                              and td.company_id = tf.company_id) x
                  on x.company_id = t2.company_id
                 and x.product_gress_code = t2.product_gress_code
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id,x.year, x.quarter, t2.group_name, t2.category, x.follower_leader) k
   left join (select t5.company_id, x.year, x.quarter,t5.category, (case when t5.group_name is null then '1' else t5.group_name end)group_name, '06' count_dimension,
                     (case when x.follower_leader is null then '1' else x.follower_leader end) dimension_sort, sum(x.sum1_date * x.sum1) delivery_order_money
                from scmdata.pt_ordered t5
               inner join scmdata.t_ordered tor
                  on tor.company_id = t5.company_id
                 and tor.order_code = t5.product_gress_code
                 and tor.is_product_order = '1'
               inner join (select distinct tf.company_id,
                                            tf.follower_leader,
                                            tf.product_gress_code,
                                            to_char(td.delivery_origin_time, 'yyyy') year,
                                            to_char(td.delivery_origin_time, 'Q') quarter,
                                            (to_date(to_char(td.delivery_origin_time, 'yyyy/mm/dd'),  'yyyy/mm/dd') -
                                            to_date(to_char(tf.order_create_date, 'yyyy/mm/dd'),  'yyyy/mm/dd')) sum1_date,
                                            ((tf.fixed_price * td.delivery_amount) /
                                              count(tf.product_gress_code) over(partition by tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyy'), to_char(td.delivery_origin_time, 'Q'))) sum1,
                                            tf.fixed_price,
                                            td.delivery_amount
                              from flw_leader tf
                             inner join scmdata.t_delivery_record td
                                on td.order_code = tf.product_gress_code
                               and td.company_id = tf.company_id) x
                  on x.company_id = t5.company_id
                 and x.product_gress_code = t5.product_gress_code
                 where tor.isfirstordered = 0
              group by t5.company_id, x.year, x.quarter,t5.category, t5.group_name,x.follower_leader) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.quarter = qa.quarter
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort ]';
       /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
    end;

    --5.统计维度：QC
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_quarter tka
  USING (
        with kpi_order as
   (select t.company_id, t.year, t.quarter, t.category, (case when t.group_name is null then '1' else t.group_name end)group_name, '07' count_dimension,
           (case when x.qc is null then '1' else x.qc end) dimension_sort, sum(x.sum1) order_money
      from scmdata.pt_ordered t
      inner join (select t1.company_id, t1.product_gress_code, t1.order_money,
                        (t1.order_money / count(t1.product_gress_code) over(partition by t1.product_gress_code)) sum1,
                        regexp_substr(t1.qc, '[^,]+', 1, level) qc
                   from scmdata.pt_ordered t1
                  --where t1.qc is not null
                 connect by prior t1.pt_ordered_id = t1.pt_ordered_id
                        and level <=  length(t1.qc) - length(regexp_replace(t1.qc, ',', '')) + 1
                        and prior dbms_random.value is not null) x
        on x.company_id = t.company_id
       and x.product_gress_code = t.product_gress_code
     group by t.company_id, t.year, t.quarter, t.category, t.group_name,x.qc),
  flw_leader as
 (select t.company_id, t.product_gress_code,t.fixed_price,t.order_create_date,
         (t.order_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum1,
         (t.satisfy_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum2,
         regexp_substr(t.qc, '[^,]+', 1, level) qc
    from scmdata.pt_ordered t
   --where t.qc is not null
 connect by prior t.pt_ordered_id = t.pt_ordered_id
        and level <= length(t.qc) - length(regexp_replace(t.qc, ',', '')) + 1
        and prior dbms_random.value is not null)
 select k.company_id,k.year, k.quarter, k.category, k.group_name,k.count_dimension,k.dimension_sort,k.order_money,z.sho_order_money,
        z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id,  tp.year,  tp.quarter, tp.category, tp.group_name,
                     '07' count_dimension,(case when tp.qc is null then '1' else tp.qc end) dimension_sort, sum(tp.sum2) sho_order_money
                from (select t3.company_id, t3.year, t3.quarter, (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category, x.qc, x.sum2
                        from scmdata.pt_ordered t3
                        inner join flw_leader x
                          on x.company_id = t3.company_id
                         and x.product_gress_code = t3.product_gress_code
                      union all
                      select t3a.company_id, t3a.year, t3a.quarter, (case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category, x.qc, (x.sum1- x.sum2) sum_money
                        from scmdata.pt_ordered t3a
                        inner join flw_leader x
                          on x.company_id = t3a.company_id
                         and x.product_gress_code = t3a.product_gress_code
                       left join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                              or a.dept_name like '%事业部%' or a.dept_name = '无')
                      union all
                      select t3a.company_id, t3a.year, t3a.quarter, (case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category, x.qc, (x.sum1- x.sum2) sum_money
                        from scmdata.pt_ordered t3a
                        inner join flw_leader x
                          on x.company_id = t3a.company_id
                         and x.product_gress_code = t3a.product_gress_code
                       where t3a.responsible_dept = 'b550778b4f2b36b4e0533c281caca074' /*责任部门1级：供应链管理部*/
                         and t3a.responsible_dept_sec in ('DP2203124299047457','b550778b4f4336b4e0533c281caca074',
                             'b550778b4f4836b4e0533c281caca074','b550778b4f3e36b4e0533c281caca074')/*责任部门2级：直播2部、QA组、面料管控部、工艺组*/ ) tp
               group by tp.company_id, tp.year, tp.quarter, tp.category, tp.group_name, tp.qc) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.quarter = z.quarter
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select t3.company_id, t3.year, t3.quarter,(case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category,
                     '07' count_dimension,(case when x.qc is null then '1' else x.qc end) dimension_sort, sum(x.sum2)sho_order_original_money
                from scmdata.pt_ordered t3
               inner join flw_leader x
                  on x.company_id = t3.company_id
                 and x.product_gress_code = t3.product_gress_code
               group by t3.company_id, t3.year, t3.quarter, t3.group_name, t3.category, x.qc) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.quarter = z1.quarter
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--补货平均交期指标
      V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_quarter tka
  USING (
        with flw_leader as
 (select t.company_id, t.product_gress_code,t.fixed_price,t.order_create_date,
         (t.order_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum1,
         (t.satisfy_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum2,
         regexp_substr(t.qc, '[^,]+', 1, level) qc
    from scmdata.pt_ordered t
   --where t.qc is not null
 connect by prior t.pt_ordered_id = t.pt_ordered_id
        and level <= length(t.qc) - length(regexp_replace(t.qc, ',', '')) + 1
        and prior dbms_random.value is not null)
select k.company_id, k.year, k.quarter, k.category, k.group_name, k.count_dimension, k.dimension_sort,
       k.delivery_money,qa.delivery_order_money
  from  (select t2.company_id, x.year, x.quarter, t2.category,(case when t2.group_name is null then '1' else t2.group_name end)group_name, '07' count_dimension,
                      (case when x.qc is null then '1' else x.qc end) dimension_sort, sum(sum1) delivery_money
                from scmdata.pt_ordered t2
                inner join (select distinct tf.company_id,tf.qc,
                                  tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyy') year, to_char(td.delivery_origin_time, 'Q') quarter,
                                  ((tf.fixed_price * td.delivery_amount)/
 count(tf.product_gress_code) over(partition by tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyy'), to_char(td.delivery_origin_time, 'Q'))) sum1
                             from flw_leader tf
                            inner join scmdata.t_delivery_record td
                               on td.order_code = tf.product_gress_code
                              and td.company_id = tf.company_id) x
                  on x.company_id = t2.company_id
                 and x.product_gress_code = t2.product_gress_code
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id,x.year, x.quarter, t2.group_name, t2.category, x.qc) k
   left join (select t5.company_id, x.year, x.quarter,t5.category, (case when t5.group_name is null then '1' else t5.group_name end)group_name, '07' count_dimension,
                     (case when x.qc is null then '1' else x.qc end) dimension_sort, sum(x.sum1_date * x.sum1) delivery_order_money
                from scmdata.pt_ordered t5
               inner join scmdata.t_ordered tor
                  on tor.company_id = t5.company_id
                 and tor.order_code = t5.product_gress_code
                 and tor.is_product_order = '1'
               inner join (select distinct tf.company_id,
                                            tf.qc,
                                            tf.product_gress_code,
                                            to_char(td.delivery_origin_time, 'yyyy') year,
                                            to_char(td.delivery_origin_time, 'Q') quarter,
                                            (to_date(to_char(td.delivery_origin_time, 'yyyy/mm/dd'),  'yyyy/mm/dd') -
                                            to_date(to_char(tf.order_create_date, 'yyyy/mm/dd'),  'yyyy/mm/dd')) sum1_date,
                                            ((tf.fixed_price * td.delivery_amount) /
                                              count(tf.product_gress_code) over(partition by tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyy'), to_char(td.delivery_origin_time, 'Q'))) sum1,
                                            tf.fixed_price,
                                            td.delivery_amount
                              from flw_leader tf
                             inner join scmdata.t_delivery_record td
                                on td.order_code = tf.product_gress_code
                               and td.company_id = tf.company_id) x
                  on x.company_id = t5.company_id
                 and x.product_gress_code = t5.product_gress_code
                 where tor.isfirstordered = 0
              group by t5.company_id, x.year, x.quarter,t5.category, t5.group_name,x.qc) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.quarter = qa.quarter
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort ]';
       /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
    end;

    --9.统计维度：QC主管
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_quarter tka
  USING (
        with kpi_order as
   (select t.company_id, t.year, t.quarter, t.category, (case when t.group_name is null then '1' else t.group_name end)group_name, '08' count_dimension,
           (case when x.qc_manager is null then '1' else x.qc_manager end) dimension_sort, sum(x.sum1) order_money
      from scmdata.pt_ordered t
     inner join (select t1.company_id, t1.product_gress_code, t1.order_money,
                        (t1.order_money / count(t1.product_gress_code) over(partition by t1.product_gress_code)) sum1,
                        regexp_substr(t1.qc_manager, '[^,]+', 1, level) qc_manager
                   from scmdata.pt_ordered t1
                  --where t1.qc_manager is not null
                 connect by prior t1.pt_ordered_id = t1.pt_ordered_id
                        and level <=  length(t1.qc_manager) - length(regexp_replace(t1.qc_manager, ',', '')) + 1
                        and prior dbms_random.value is not null) x
        on x.company_id = t.company_id
       and x.product_gress_code = t.product_gress_code
     group by t.company_id, t.year, t.quarter, t.category, t.group_name,x.qc_manager),
  flw_leader as
 (select t.company_id, t.product_gress_code,t.fixed_price,t.order_create_date,
         (t.order_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum1,
         (t.satisfy_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum2,
         regexp_substr(t.qc_manager, '[^,]+', 1, level) qc_manager
    from scmdata.pt_ordered t
   --where t.qc_manager is not null
 connect by prior t.pt_ordered_id = t.pt_ordered_id
        and level <= length(t.qc_manager) - length(regexp_replace(t.qc_manager, ',', '')) + 1
        and prior dbms_random.value is not null)
 select k.company_id,k.year, k.quarter, k.category, k.group_name,k.count_dimension,k.dimension_sort,k.order_money,z.sho_order_money,
        z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id,  tp.year,  tp.quarter, tp.category, tp.group_name,
                     '08' count_dimension,(case when tp.qc_manager is null then '1' else tp.qc_manager end) dimension_sort, sum(tp.sum2) sho_order_money
                from (select t3.company_id, t3.year, t3.quarter,(case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category, x.qc_manager, x.sum2
                        from scmdata.pt_ordered t3
                        inner join flw_leader x
                          on x.company_id = t3.company_id
                         and x.product_gress_code = t3.product_gress_code
                      union all
                      select t3a.company_id, t3a.year, t3a.quarter, (case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category, x.qc_manager, (x.sum1- x.sum2) sum_money
                        from scmdata.pt_ordered t3a
                        inner join flw_leader x
                          on x.company_id = t3a.company_id
                         and x.product_gress_code = t3a.product_gress_code
                       left join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                             or a.dept_name like '%事业部%' or a.dept_name = '无')
                      union all
                      select t3a.company_id, t3a.year, t3a.quarter, (case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category, x.qc_manager, (x.sum1- x.sum2) sum_money
                        from scmdata.pt_ordered t3a
                        inner join flw_leader x
                          on x.company_id = t3a.company_id
                         and x.product_gress_code = t3a.product_gress_code
                       where t3a.responsible_dept = 'b550778b4f2b36b4e0533c281caca074' /*责任部门1级：供应链管理部*/
                         and t3a.responsible_dept_sec in ('DP2203124299047457','b550778b4f4336b4e0533c281caca074',
                             'b550778b4f4836b4e0533c281caca074','b550778b4f3e36b4e0533c281caca074')/*责任部门2级：直播2部、QA组、面料管控部、工艺组*/ ) tp
               group by tp.company_id, tp.year, tp.quarter, tp.category, tp.group_name, tp.qc_manager) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.quarter = z.quarter
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select t3.company_id, t3.year, t3.quarter, (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category,
                     '08' count_dimension,(case when x.qc_manager is null then '1' else x.qc_manager end) dimension_sort, sum(x.sum2)sho_order_original_money
                from scmdata.pt_ordered t3
               inner join flw_leader x
                  on x.company_id = t3.company_id
                 and x.product_gress_code = t3.product_gress_code
               group by t3.company_id, t3.year, t3.quarter, t3.group_name, t3.category, x.qc_manager) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.quarter = z1.quarter
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--补货平均交期指标
      V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_quarter tka
  USING (
        with flw_leader as
 (select t.company_id, t.product_gress_code,t.fixed_price,t.order_create_date,
         (t.order_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum1,
         (t.satisfy_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum2,
         regexp_substr(t.qc_manager, '[^,]+', 1, level) qc_manager
    from scmdata.pt_ordered t
   --where t.qc_manager is not null
 connect by prior t.pt_ordered_id = t.pt_ordered_id
        and level <= length(t.qc_manager) - length(regexp_replace(t.qc_manager, ',', '')) + 1
        and prior dbms_random.value is not null)
select k.company_id, k.year, k.quarter, k.category, k.group_name, k.count_dimension, k.dimension_sort,
       k.delivery_money,qa.delivery_order_money
  from (select t2.company_id, x.year, x.quarter, t2.category, (case when t2.group_name is null then '1' else t2.group_name end)group_name, '08' count_dimension,
                      (case when x.qc_manager is null then '1' else x.qc_manager end) dimension_sort, sum(sum1) delivery_money
                from scmdata.pt_ordered t2
                inner join (select distinct tf.company_id,tf.qc_manager,
                                  tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyy') year, to_char(td.delivery_origin_time, 'Q') quarter,
                                  ((tf.fixed_price * td.delivery_amount)/
count(tf.product_gress_code) over(partition by tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyy'), to_char(td.delivery_origin_time, 'Q'))) sum1
                             from flw_leader tf
                            inner join scmdata.t_delivery_record td
                               on td.order_code = tf.product_gress_code
                              and td.company_id = tf.company_id) x
                  on x.company_id = t2.company_id
                 and x.product_gress_code = t2.product_gress_code
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id,x.year, x.quarter, t2.group_name, t2.category, x.qc_manager) k
   left join (select t5.company_id, x.year, x.quarter,t5.category, (case when t5.group_name is null then '1' else t5.group_name end)group_name, '08' count_dimension,
                     (case when x.qc_manager is null then '1' else x.qc_manager end) dimension_sort, sum(x.sum1_date * x.sum1) delivery_order_money
                from scmdata.pt_ordered t5
               inner join scmdata.t_ordered tor
                  on tor.company_id = t5.company_id
                 and tor.order_code = t5.product_gress_code
                 and tor.is_product_order = '1'
               inner join (select distinct tf.company_id,
                                            tf.qc_manager,
                                            tf.product_gress_code,
                                            to_char(td.delivery_origin_time, 'yyyy') year,
                                            to_char(td.delivery_origin_time, 'Q') quarter,
                                            (to_date(to_char(td.delivery_origin_time, 'yyyy/mm/dd'),  'yyyy/mm/dd') -
                                            to_date(to_char(tf.order_create_date, 'yyyy/mm/dd'),  'yyyy/mm/dd')) sum1_date,
                                            ((tf.fixed_price * td.delivery_amount) /
                                              count(tf.product_gress_code) over(partition by tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyy'), to_char(td.delivery_origin_time, 'Q'))) sum1,
                                            tf.fixed_price,
                                            td.delivery_amount
                              from flw_leader tf
                             inner join scmdata.t_delivery_record td
                                on td.order_code = tf.product_gress_code
                               and td.company_id = tf.company_id) x
                  on x.company_id = t5.company_id
                 and x.product_gress_code = t5.product_gress_code
                 where tor.isfirstordered = 0
              group by t5.company_id, x.year, x.quarter,t5.category, t5.group_name,x.qc_manager) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.quarter = qa.quarter
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort ]';
        /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
    end;

  END P_T_KPI_QUARTER;

  /*--------------------------------------------------------------------------
   对象：
        P_T_KPI_HALFYEAR
   统计维度：
       分类、区域组、款式名称、产品子类、供应商、生产工厂、跟单、qc、qc主管
   时间维度：
       半年度
   用途：
       多维度指标查询半年度数据表（scmdata.t_kpi_halfyear）
   更新规则：
       每半年度6号（1月6号、7月6号）凌晨4点半更新前半年度的数据
   t_type参数解析
        t_type = 0 更新全部指标
        t_type = 1 更新订单满足率（原值、绩效值）指标
        t_type = 2 更新补货平均交期指标
   p_type参数解析
        p_type = 0 更新全部历史数据
        p_type = 1 只更新上一个维度（半年）的数据
   上线版本：2022-10-30
   ------------------------------------------------------------------------------*/
  PROCEDURE P_T_KPI_HALFYEAR(t_type number, p_type number) IS
    V_Q_SQL clob;--订单满足率指标
    V_Q1_SQL clob;--补货平均交期指标
    ---更新全部历史数据
    V_W_SQL clob := q'[
    where (k.year || k.halfyear) <= pkg_kpipt_order.f_yearmonth ) tkb
      ON (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.halfyear = tkb.halfyear and tka.category = tkb.category
          and tka.groupname = tkb.group_name and tka.count_dimension = tkb.count_dimension and tka.dimension_sort = tkb.dimension_sort)
     WHEN MATCHED THEN]';
    ---更新上半年数据
    V_W1_SQL clob := q'[
   where (k.year || k.halfyear) = pkg_kpipt_order.f_yearmonth ) tkb
      ON (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.halfyear = tkb.halfyear and tka.category = tkb.category
          and tka.groupname = tkb.group_name and tka.count_dimension = tkb.count_dimension and tka.dimension_sort = tkb.dimension_sort)
     WHEN MATCHED THEN]';
    ---更新订单满足率
    V_U_SQL clob := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.sho_order_money           = tkb.sho_order_money,
             tka.sho_order_original_money  = tkb.sho_order_original_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    ---更新补货平均交期
    V_U1_SQL clob := q'[  UPDATE
         SET tka.delivery_money            = tkb.delivery_money,
             tka.delivery_order_money      = tkb.delivery_order_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    ---新增订单满足率
    V_IN_SQL clob := q'[
    WHEN NOT MATCHED THEN
      INSERT
        (tka.t_kpi_hf_id,
         tka.company_id,
         tka.year,
         tka.halfyear,
         tka.category,
         tka.groupname,
         tka.count_dimension,
         tka.dimension_sort,
         tka.order_money,
         tka.sho_order_money,
         tka.sho_order_original_money,
         tka.memo,
         tka.create_id,
         tka.create_time,
         tka.update_id,
         tka.update_time)
      VALUES
        (scmdata.f_get_uuid(),
         tkb.company_id,
         tkb.year,
         tkb.halfyear,
         tkb.category,
         tkb.group_name,
         tkb.count_dimension,
         tkb.dimension_sort,
         tkb.order_money,
         tkb.sho_order_money,
         tkb.sho_order_original_money,
         ' ',
         'ADMIN',
         sysdate,
         'ADMIN',
         sysdate)]';
    ---新增补货平均交期
    V_IN1_SQL clob := q'[
    WHEN NOT MATCHED THEN
      INSERT
        (tka.t_kpi_hf_id,
         tka.company_id,
         tka.year,
         tka.halfyear,
         tka.category,
         tka.groupname,
         tka.count_dimension,
         tka.dimension_sort,
         tka.delivery_money,
         tka.delivery_order_money,
         tka.memo,
         tka.create_id,
         tka.create_time,
         tka.update_id,
         tka.update_time)
      VALUES
        (scmdata.f_get_uuid(),
         tkb.company_id,
         tkb.year,
         tkb.halfyear,
         tkb.category,
         tkb.group_name,
         tkb.count_dimension,
         tkb.dimension_sort,
         tkb.delivery_money,
         tkb.delivery_order_money,
         ' ',
         'ADMIN',
         sysdate,
         'ADMIN',
         sysdate)]';
    V_SQL    clob;
    V1_SQL    clob;
    --1.统计维度：分类
  BEGIN
--订单满足率指标
    V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_halfyear tka
  USING (
      with kpi_order as
  (select t.company_id, t.year, decode(t.quarter,1,1,2,1,3,2,4,2) halfyear, t.category,
          (case when t.group_name is null then '1' else t.group_name end)group_name, '00' count_dimension, t.category dimension_sort, sum(t.order_money) order_money
     from scmdata.pt_ordered t
    group by t.company_id, t.year, decode(t.quarter,1,1,2,1,3,2,4,2), t.category, t.group_name)
 select k.company_id, k.year, k.halfyear, k.category, k.group_name, k.count_dimension, k.dimension_sort,
        k.order_money, z.sho_order_money,  z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id,tp.year,tp.halfyear,tp.category, tp.group_name,
                     '00' count_dimension, tp.category dimension_sort, sum(tp.sum_money) sho_order_money
                from (select t3.company_id, t3.year,decode(t3.quarter,1,1,2,1,3,2,4,2) halfyear,
                             (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3
                      union all
                      select t3a.company_id, t3a.year, decode(t3a.quarter,1,1,2,1,3,2,4,2) halfyear,
                             (case when t3a.group_name is null then '1' else t3a.group_name end)group_name,t3a.category,(t3a.order_money - t3a.satisfy_money) sum_money
                        from scmdata.pt_ordered t3a
                       inner join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                                or a.dept_name like '%事业部%' or a.dept_name = '无')) tp
               group by tp.company_id, tp.year, tp.halfyear, tp.category, tp.group_name) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.halfyear = z.halfyear
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select tp.company_id, tp.year, tp.halfyear, tp.category, tp.group_name, '00' count_dimension,
                     tp.category dimension_sort, sum(tp.sum_money) sho_order_original_money
                from (select t3.company_id, t3.year, decode(t3.quarter,1,1,2,1,3,2,4,2) halfyear, t3.category,
                             (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3) tp
               group by tp.company_id, tp.year, tp.halfyear, tp.group_name, tp.category) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.halfyear = z1.halfyear
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort  ]';
--补货平均交期指标
   V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_halfyear tka
  USING ( select k.company_id, k.year, k.halfyear, k.category, k.group_name, k.count_dimension, k.dimension_sort,
       k.delivery_money,  qa.delivery_order_money
   from (select t2.company_id,  to_char(td.delivery_origin_time, 'yyyy') year,
                     decode(to_char(td.delivery_origin_time, 'Q'),1,1,2,1,3,2,4,2) halfyear,
                     t2.category,  (case when t2.group_name is null then '1' else t2.group_name end)group_name, '00' count_dimension, t2.category dimension_sort,
                     sum(t2.fixed_price * td.delivery_amount) delivery_money
                from scmdata.pt_ordered t2
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               inner join scmdata.t_delivery_record td
                  on td.order_code = t2.product_gress_code
                 and td.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id,  to_char(td.delivery_origin_time, 'yyyy'),
                        decode(to_char(td.delivery_origin_time, 'Q'),1,1,2,1,3,2,4,2), t2.group_name, t2.category) k
   left join (select ta0.company_id, ta0.year, ta0.halfyear, ta0.category, ta0.group_name, '00' count_dimension, ta0.category dimension_sort,
                     sum(ta0.sum1_date * ta0.sum1_money) delivery_order_money
                from (select t5.company_id, to_char(tba.delivery_origin_time, 'yyyy') year,
                             decode(to_char(tba.delivery_origin_time, 'Q') ,1,1,2,1,3,2,4,2) halfyear,  t5.category,
                             (case when t5.group_name is null then '1' else t5.group_name end)group_name,
                             (to_date(to_char(tba.delivery_origin_time, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                             to_date(to_char(t5.order_create_date,  'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                             (t5.fixed_price * tba.delivery_amount) sum1_money
                        from scmdata.pt_ordered t5
                       inner join scmdata.t_delivery_record tba
                          on t5.product_gress_code = tba.order_code
                         and t5.company_id = tba.company_id
                       inner join scmdata.t_ordered tor
                          on tor.company_id = tba.company_id
                         and tor.order_code = tba.order_code
                       inner join scmdata.t_commodity_info tb
                          on t5.goo_id = tb.rela_goo_id
                         and tb.goo_id = tba.goo_id
                         and t5.company_id = tb.company_id
                       where tor.isfirstordered = 0
                         and tor.is_product_order = 1) ta0
               group by ta0.company_id, ta0.year, ta0.halfyear, ta0.category, ta0.group_name) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.halfyear = qa.halfyear
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort  ]';
   /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;

    --2.统计维度：区域组
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_halfyear tka
  USING (
        with kpi_order as
  (select t.company_id, t.year,decode(t.quarter,1,1,2,1,3,2,4,2) halfyear, t.category,
          (case when t.group_name is null then '1' else t.group_name end)group_name, '01' count_dimension,
          (case when t.group_name is null then '1' else t.group_name end) dimension_sort, sum(t.order_money) order_money
     from scmdata.pt_ordered t
    group by t.company_id, t.year,decode(t.quarter,1,1,2,1,3,2,4,2), t.category, t.group_name)
 select k.company_id, k.year, k.halfyear, k.category, k.group_name, k.count_dimension, k.dimension_sort,
        k.order_money, z.sho_order_money, z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id, tp.year, tp.halfyear, tp.category, tp.group_name,
                     '01' count_dimension, tp.group_name dimension_sort, sum(tp.sum_money) sho_order_money
                from (select t3.company_id, t3.year, decode(t3.quarter,1,1,2,1,3,2,4,2) halfyear,
                             (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3
                      union all
                      select t3a.company_id,  t3a.year,decode(t3a.quarter,1,1,2,1,3,2,4,2) halfyear,
                             (case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category, (t3a.order_money - t3a.satisfy_money) sum_money
                        from scmdata.pt_ordered t3a
                       inner join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                              or a.dept_name like '%事业部%' or a.dept_name = '无')) tp
               group by tp.company_id, tp.year, tp.halfyear, tp.category, tp.group_name) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.halfyear = z.halfyear
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select tp.company_id, tp.year, tp.halfyear,tp.category, tp.group_name,
                     '01' count_dimension, tp.group_name dimension_sort, sum(tp.sum_money) sho_order_original_money
                from (select t3.company_id, t3.year, decode(t3.quarter,1,1,2,1,3,2,4,2) halfyear , t3.category,
                             (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3) tp
               group by tp.company_id, tp.year, tp.halfyear, tp.group_name, tp.category) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.halfyear = z1.halfyear
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--补货平均交期指标
      V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_halfyear tka
  USING (select k.company_id, k.year, k.halfyear, k.category, k.group_name, k.count_dimension, k.dimension_sort,
       k.delivery_money,  qa.delivery_order_money
   from  (select t2.company_id, to_char(td.delivery_origin_time, 'yyyy') year,
                     decode(to_char(td.delivery_origin_time, 'Q'),1,1,2,1,3,2,4,2) halfyear, t2.category,
                     (case when t2.group_name is null then '1' else t2.group_name end)group_name, '01' count_dimension,
                     (case when t2.group_name is null then '1' else t2.group_name end) dimension_sort, sum(t2.fixed_price * td.delivery_amount) delivery_money
                from scmdata.pt_ordered t2
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               inner join scmdata.t_delivery_record td
                  on td.order_code = t2.product_gress_code
                 and td.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id,  to_char(td.delivery_origin_time, 'yyyy'),
                         decode(to_char(td.delivery_origin_time, 'Q'),1,1,2,1,3,2,4,2), t2.group_name,  t2.category) k
   left join (select ta0.company_id, ta0.year, ta0.halfyear,  ta0.category, ta0.group_name,
                     '01' count_dimension, ta0.group_name dimension_sort, sum(ta0.sum1_date * ta0.sum1_money) delivery_order_money
                from (select t5.company_id,   to_char(tba.delivery_origin_time, 'yyyy') year,
                             decode(to_char(tba.delivery_origin_time, 'Q'),1,1,2,1,3,2,4,2) halfyear, t5.category,
                             (case when t5.group_name is null then '1' else t5.group_name end)group_name,
                             (to_date(to_char(tba.delivery_origin_time,  'yyyy/mm/dd'), 'yyyy/mm/dd') -
                             to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                             (t5.fixed_price * tba.delivery_amount) sum1_money
                        from scmdata.pt_ordered t5
                       inner join scmdata.t_delivery_record tba
                          on t5.product_gress_code = tba.order_code
                         and t5.company_id = tba.company_id
                       inner join scmdata.t_ordered tor
                          on tor.company_id = tba.company_id
                         and tor.order_code = tba.order_code
                       inner join scmdata.t_commodity_info tb
                          on t5.goo_id = tb.rela_goo_id
                         and tb.goo_id = tba.goo_id
                         and t5.company_id = tb.company_id
                       where tor.isfirstordered = 0
                         and tor.is_product_order = 1) ta0
               group by ta0.company_id, ta0.year, ta0.halfyear, ta0.category, ta0.group_name) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.halfyear = qa.halfyear
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort ]';
       /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
    end;

    --3.统计维度：款式名称
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_halfyear tka
  USING (
       with kpi_order as
  (select t.company_id, t.year, decode(t.quarter,1,1,2,1,3,2,4,2) halfyear , t.category,
          (case when t.group_name is null then '1' else t.group_name end)group_name, '02' count_dimension,
          t.style_name dimension_sort,sum(t.order_money) order_money
     from scmdata.pt_ordered t
    group by t.company_id, t.year,decode(t.quarter,1,1,2,1,3,2,4,2), t.category, t.group_name, t.style_name)
 select k.company_id, k.year, k.halfyear, k.category, k.group_name, k.count_dimension, k.dimension_sort,
        k.order_money, z.sho_order_money, z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id, tp.year, tp.halfyear, tp.category, tp.group_name,
                     '02' count_dimension, tp.style_name dimension_sort, sum(tp.sum_money) sho_order_money
                from (select t3.company_id, t3.year, decode(t3.quarter,1,1,2,1,3,2,4,2) halfyear,
                             (case when t3.group_name is null then '1' else t3.group_name end)group_name,
                             t3.category, t3.style_name, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3
                      union all
                      select t3a.company_id, t3a.year, decode(t3a.quarter,1,1,2,1,3,2,4,2) halfyear,
                             (case when t3a.group_name is null then '1' else t3a.group_name end)group_name,
                             t3a.category, t3a.style_name, (t3a.order_money - t3a.satisfy_money) sum_money
                        from scmdata.pt_ordered t3a
                       inner join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%' or a.dept_name like '%财务部%'
                                or a.dept_name like '%事业部%' or a.dept_name = '无')) tp
               group by tp.company_id, tp.year, tp.halfyear, tp.category, tp.group_name, tp.style_name) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.halfyear = z.halfyear
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select tp.company_id, tp.year, tp.halfyear, tp.category, tp.group_name,
                     '02' count_dimension, tp.style_name dimension_sort, sum(tp.sum_money) sho_order_original_money
                from (select t3.company_id, t3.year,decode(t3.quarter,1,1,2,1,3,2,4,2) halfyear, t3.category, t3.style_name,
                             (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3) tp
               group by tp.company_id,tp.year,tp.halfyear,tp.group_name,tp.category,tp.style_name) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.halfyear = z1.halfyear
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--补货平均交期指标
      V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_halfyear tka
  USING (select k.company_id, k.year, k.halfyear, k.category, k.group_name, k.count_dimension, k.dimension_sort,
       k.delivery_money,  qa.delivery_order_money
   from (select t2.company_id, to_char(td.delivery_origin_time, 'yyyy') year,
                     decode(to_char(td.delivery_origin_time, 'Q'),1,1,2,1,3,2,4,2) halfyear,t2.category,
                     (case when t2.group_name is null then '1' else t2.group_name end)group_name,'02' count_dimension,
                     t2.style_name dimension_sort, sum(t2.fixed_price * td.delivery_amount) delivery_money
                from scmdata.pt_ordered t2
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               inner join scmdata.t_delivery_record td
                  on td.order_code = t2.product_gress_code
                 and td.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id,to_char(td.delivery_origin_time, 'yyyy'),
                         decode(to_char(td.delivery_origin_time, 'Q'),1,1,2,1,3,2,4,2),t2.group_name,t2.category,t2.style_name) k
   left join (select ta0.company_id, ta0.year, ta0.halfyear, ta0.category, ta0.group_name, '02' count_dimension, ta0.style_name dimension_sort,
                     sum(ta0.sum1_date * ta0.sum1_money) delivery_order_money
                from (select t5.company_id, to_char(tba.delivery_origin_time, 'yyyy') year,
                             decode(to_char(tba.delivery_origin_time, 'Q'),1,1,2,1,3,2,4,2) halfyear, t5.category,
                             (case when t5.group_name is null then '1' else t5.group_name end)group_name, t5.style_name,
                             (to_date(to_char(tba.delivery_origin_time, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                             to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                             (t5.fixed_price * tba.delivery_amount) sum1_money
                        from scmdata.pt_ordered t5
                       inner join scmdata.t_delivery_record tba
                          on t5.product_gress_code = tba.order_code
                         and t5.company_id = tba.company_id
                       inner join scmdata.t_ordered tor
                          on tor.company_id = tba.company_id
                         and tor.order_code = tba.order_code
                       inner join scmdata.t_commodity_info tb
                          on t5.goo_id = tb.rela_goo_id
                         and tb.goo_id = tba.goo_id
                         and t5.company_id = tb.company_id
                       where tor.isfirstordered = 0
                         and tor.is_product_order = 1) ta0
               group by ta0.company_id, ta0.year, ta0.halfyear, ta0.category, ta0.group_name, ta0.style_name) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.halfyear = qa.halfyear
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort  ]';
   /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
    end;

    --4.统计维度：产品子类
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_halfyear tka
  USING (
       with kpi_order as
  (select t.company_id,  t.year, decode(t.quarter,1,1,2,1,3,2,4,2) halfyear, t.category,
          (case when t.group_name is null then '1' else t.group_name end)group_name, '03' count_dimension, t.samll_category dimension_sort, sum(t.order_money) order_money
     from scmdata.pt_ordered t
    group by t.company_id, t.year, decode(t.quarter,1,1,2,1,3,2,4,2), t.category, t.group_name, t.samll_category)
 select k.company_id, k.year,  k.halfyear, k.category, k.group_name, k.count_dimension, k.dimension_sort, k.order_money,
        z.sho_order_money, z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id,  tp.year, tp.halfyear, tp.category, tp.group_name, '03' count_dimension,
                     tp.samll_category dimension_sort, sum(tp.sum_money) sho_order_money
                from (select t3.company_id, t3.year,decode(t3.quarter,1,1,2,1,3,2,4,2) halfyear ,
                             (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category, t3.samll_category,  t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3
                      union all
                      select t3a.company_id, t3a.year, decode(t3a.quarter,1,1,2,1,3,2,4,2) halfyear,
                             (case when t3a.group_name is null then '1' else t3a.group_name end)group_name,  t3a.category,
                             t3a.samll_category, (t3a.order_money - t3a.satisfy_money) sum_money
                        from scmdata.pt_ordered t3a
                       inner join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                               or a.dept_name like '%事业部%' or a.dept_name = '无')) tp
               group by tp.company_id,tp.year, tp.halfyear, tp.category, tp.group_name,  tp.samll_category) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.halfyear = z.halfyear
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select tp.company_id, tp.year, tp.halfyear, tp.category, tp.group_name, '03' count_dimension,
                     tp.samll_category dimension_sort, sum(tp.sum_money) sho_order_original_money
                from (select t3.company_id, t3.year, decode(t3.quarter,1,1,2,1,3,2,4,2) halfyear, t3.category, t3.samll_category,
                             (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3) tp
               group by tp.company_id, tp.year, tp.halfyear, tp.group_name, tp.category, tp.samll_category) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.halfyear = z1.halfyear
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--补货平均交期指标
     V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_halfyear tka
  USING (select k.company_id, k.year, k.halfyear, k.category, k.group_name, k.count_dimension, k.dimension_sort,
       k.delivery_money,  qa.delivery_order_money
   from  (select t2.company_id,  to_char(td.delivery_origin_time, 'yyyy') year,
                     decode(to_char(td.delivery_origin_time, 'Q'),1,1,2,1,3,2,4,2) halfyear, t2.category,
                     (case when t2.group_name is null then '1' else t2.group_name end)group_name, '03' count_dimension,
                     t2.samll_category dimension_sort, sum(t2.fixed_price * td.delivery_amount) delivery_money
                from scmdata.pt_ordered t2
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               inner join scmdata.t_delivery_record td
                  on td.order_code = t2.product_gress_code
                 and td.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id, to_char(td.delivery_origin_time, 'yyyy'),  decode(to_char(td.delivery_origin_time, 'Q'),1,1,2,1,3,2,4,2) ,
                        t2.group_name, t2.category, t2.samll_category) k
   left join (select ta0.company_id,  ta0.year, ta0.halfyear, ta0.category, ta0.group_name, '03' count_dimension,
                     ta0.samll_category dimension_sort, sum(ta0.sum1_date * ta0.sum1_money) delivery_order_money
                from (select t5.company_id, to_char(tba.delivery_origin_time, 'yyyy') year,
                              decode(to_char(tba.delivery_origin_time, 'Q') ,1,1,2,1,3,2,4,2) halfyear, t5.category,
                              (case when t5.group_name is null then '1' else t5.group_name end)group_name, t5.samll_category,
                             (to_date(to_char(tba.delivery_origin_time, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                             to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                             (t5.fixed_price * tba.delivery_amount) sum1_money
                        from scmdata.pt_ordered t5
                       inner join scmdata.t_delivery_record tba
                          on t5.product_gress_code = tba.order_code
                         and t5.company_id = tba.company_id
                       inner join scmdata.t_ordered tor
                          on tor.company_id = tba.company_id
                         and tor.order_code = tba.order_code
                       inner join scmdata.t_commodity_info tb
                          on t5.goo_id = tb.rela_goo_id
                         and tb.goo_id = tba.goo_id
                         and t5.company_id = tb.company_id
                       where tor.isfirstordered = 0
                         and tor.is_product_order = 1) ta0
               group by ta0.company_id, ta0.year, ta0.halfyear, ta0.category, ta0.group_name, ta0.samll_category) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.halfyear = qa.halfyear
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort ]';
   /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
    end;

    --5.统计维度：供应商
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_halfyear tka
  USING (
        with kpi_order as
  (select t.company_id, t.year, decode(t.quarter,1,1,2,1,3,2,4,2) halfyear, t.category,
          (case when t.group_name is null then '1' else t.group_name end)group_name,'04' count_dimension, t.supplier_code dimension_sort, sum(t.order_money) order_money
     from scmdata.pt_ordered t
    group by t.company_id, t.year, decode(t.quarter,1,1,2,1,3,2,4,2),t.category, t.group_name, t.supplier_code)
 select k.company_id, k.year, k.halfyear, k.category, k.group_name, k.count_dimension, k.dimension_sort, k.order_money,
        z.sho_order_money, z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id, tp.year, tp.halfyear, tp.category, tp.group_name, '04' count_dimension,
                     tp.supplier_code dimension_sort, sum(tp.sum_money) sho_order_money
                from (select t3.company_id, t3.year, decode(t3.quarter,1,1,2,1,3,2,4,2) halfyear,
                             (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category, t3.supplier_code, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3
                      union all
                      select t3a.company_id, t3a.year,  decode(t3a.quarter,1,1,2,1,3,2,4,2) halfyear,
                              (case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category, t3a.supplier_code,
                             (t3a.order_money - t3a.satisfy_money) sum_money
                        from scmdata.pt_ordered t3a
                       inner join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                                or  a.dept_name like '%事业部%' or a.dept_name = '无')) tp
               group by tp.company_id,tp.year,tp.halfyear,tp.category,tp.group_name,tp.supplier_code) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.halfyear = z.halfyear
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select tp.company_id,tp.year,tp.halfyear,tp.category,tp.group_name,'04' count_dimension,
                     tp.supplier_code dimension_sort,sum(tp.sum_money) sho_order_original_money
                from (select t3.company_id, t3.year, decode(t3.quarter,1,1,2,1,3,2,4,2) halfyear, t3.category,
                             t3.supplier_code, (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3) tp
               group by tp.company_id,tp.year,tp.halfyear,tp.group_name,tp.category,tp.supplier_code) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.halfyear = z1.halfyear
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort  ]';
--补货平均交期指标
     V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_halfyear tka
  USING (select k.company_id, k.year, k.halfyear, k.category, k.group_name, k.count_dimension, k.dimension_sort,
       k.delivery_money,  qa.delivery_order_money
   from (select t2.company_id,to_char(td.delivery_origin_time, 'yyyy') year,
                     decode(to_char(td.delivery_origin_time, 'Q') ,1,1,2,1,3,2,4,2) halfyear, t2.category,
                     (case when t2.group_name is null then '1' else t2.group_name end)group_name,'04' count_dimension,
                     t2.supplier_code dimension_sort, sum(t2.fixed_price * td.delivery_amount) delivery_money
                from scmdata.pt_ordered t2
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               inner join scmdata.t_delivery_record td
                  on td.order_code = t2.product_gress_code
                 and td.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id, to_char(td.delivery_origin_time, 'yyyy'),
                        decode(to_char(td.delivery_origin_time, 'Q') ,1,1,2,1,3,2,4,2), t2.group_name, t2.category, t2.supplier_code) k
   left join (select ta0.company_id,ta0.year,ta0.halfyear,ta0.category,ta0.group_name,'04' count_dimension,
                     ta0.supplier_code dimension_sort, sum(ta0.sum1_date * ta0.sum1_money) delivery_order_money
                from (select t5.company_id, to_char(tba.delivery_origin_time, 'yyyy') year,
                             decode(to_char(tba.delivery_origin_time, 'Q') ,1,1,2,1,3,2,4,2) halfyear,t5.category,
                             (case when t5.group_name is null then '1' else t5.group_name end)group_name, t5.supplier_code,
                             (to_date(to_char(tba.delivery_origin_time, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                             to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'),'yyyy/mm/dd')) sum1_date,
                             (t5.fixed_price * tba.delivery_amount) sum1_money
                        from scmdata.pt_ordered t5
                       inner join scmdata.t_delivery_record tba
                          on t5.product_gress_code = tba.order_code
                         and t5.company_id = tba.company_id
                       inner join scmdata.t_ordered tor
                          on tor.company_id = tba.company_id
                         and tor.order_code = tba.order_code
                       inner join scmdata.t_commodity_info tb
                          on t5.goo_id = tb.rela_goo_id
                         and tb.goo_id = tba.goo_id
                         and t5.company_id = tb.company_id
                       where tor.isfirstordered = 0
                         and tor.is_product_order = 1) ta0
               group by ta0.company_id,ta0.year,ta0.halfyear,ta0.category,ta0.group_name,ta0.supplier_code) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.halfyear = qa.halfyear
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort  ]';
   /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
    end;

    --6.统计维度：生产工厂
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_halfyear tka
  USING (
        with kpi_order as
  (select t.company_id,t.year,decode(t.quarter,1,1,2,1,3,2,4,2) halfyear,t.category,
          (case when t.group_name is null then '1' else t.group_name end)group_name,'05' count_dimension,
           t.factory_code dimension_sort,sum(t.order_money) order_money
     from scmdata.pt_ordered t
    group by t.company_id,t.year,decode(t.quarter,1,1,2,1,3,2,4,2),t.category,t.group_name,t.factory_code)
 select k.company_id,k.year,k.halfyear,k.category,k.group_name,k.count_dimension,k.dimension_sort,k.order_money,z.sho_order_money,
        z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id, tp.year, tp.halfyear,tp.category, tp.group_name, '05' count_dimension, tp.factory_code dimension_sort,
                      sum(tp.sum_money) sho_order_money
                from (select t3.company_id, t3.year, decode(t3.quarter,1,1,2,1,3,2,4,2) halfyear,
                             (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category, t3.factory_code, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3
                      union all
                      select t3a.company_id, t3a.year, decode(t3a.quarter,1,1,2,1,3,2,4,2) halfyear,
                             (case when t3a.group_name is null then '1' else t3a.group_name end)group_name,t3a.category, t3a.factory_code,
                             (t3a.order_money - t3a.satisfy_money) sum_money
                        from scmdata.pt_ordered t3a
                       inner join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                              or a.dept_name like '%事业部%' or a.dept_name = '无')) tp
               group by tp.company_id,tp.year,tp.halfyear,tp.category,tp.group_name,tp.factory_code) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.halfyear = z.halfyear
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select tp.company_id,tp.year,tp.halfyear,tp.category,tp.group_name,'05' count_dimension,
                     tp.factory_code dimension_sort, sum(tp.sum_money) sho_order_original_money
                from (select t3.company_id, t3.year, decode(t3.quarter,1,1,2,1,3,2,4,2) halfyear, t3.category, t3.factory_code,
                             (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3) tp
               group by tp.company_id,tp.year,tp.halfyear,tp.group_name,tp.category,tp.factory_code) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.halfyear = z1.halfyear
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--补货平均交期指标
      V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_halfyear tka
  USING (select k.company_id, k.year, k.halfyear, k.category, k.group_name, k.count_dimension, k.dimension_sort,
       k.delivery_money,  qa.delivery_order_money
   from (select t2.company_id, to_char(td.delivery_origin_time, 'yyyy') year,
                      decode(to_char(td.delivery_origin_time, 'Q'),1,1,2,1,3,2,4,2) halfyear,
                     t2.category, (case when t2.group_name is null then '1' else t2.group_name end)group_name,'05' count_dimension,t2.factory_code dimension_sort,
                     sum(t2.fixed_price * td.delivery_amount) delivery_money
                from scmdata.pt_ordered t2
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               inner join scmdata.t_delivery_record td
                  on td.order_code = t2.product_gress_code
                 and td.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id, to_char(td.delivery_origin_time, 'yyyy'),
                        decode(to_char(td.delivery_origin_time, 'Q'),1,1,2,1,3,2,4,2),t2.group_name,t2.category,t2.factory_code) k
   left join (select ta0.company_id, ta0.year, ta0.halfyear, ta0.category, ta0.group_name, '05' count_dimension,
                     ta0.factory_code dimension_sort, sum(ta0.sum1_date * ta0.sum1_money) delivery_order_money
                from (select t5.company_id, to_char(tba.delivery_origin_time, 'yyyy') year,
                              decode(to_char(tba.delivery_origin_time, 'Q') ,1,1,2,1,3,2,4,2) halfyear,
                             t5.category, (case when t5.group_name is null then '1' else t5.group_name end)group_name, t5.factory_code,
                             (to_date(to_char(tba.delivery_origin_time,  'yyyy/mm/dd'), 'yyyy/mm/dd') -
                             to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                             (t5.fixed_price * tba.delivery_amount) sum1_money
                        from scmdata.pt_ordered t5
                       inner join scmdata.t_delivery_record tba
                          on t5.product_gress_code = tba.order_code
                         and t5.company_id = tba.company_id
                       inner join scmdata.t_ordered tor
                          on tor.company_id = tba.company_id
                         and tor.order_code = tba.order_code
                       inner join scmdata.t_commodity_info tb
                          on t5.goo_id = tb.rela_goo_id
                         and tb.goo_id = tba.goo_id
                         and t5.company_id = tb.company_id
                       where tor.isfirstordered = 0
                         and tor.is_product_order = 1) ta0
               group by ta0.company_id,ta0.year,ta0.halfyear,ta0.category,ta0.group_name,ta0.factory_code) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.halfyear = qa.halfyear
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort ]';
   /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
    end;

    --7.统计维度：跟单
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_halfyear tka
  USING (
        with kpi_order as
   (select t.company_id, t.year,decode(t.quarter,1,1,2,1,3,2,4,2) halfyear, t.category,
           (case when t.group_name is null then '1' else t.group_name end)group_name, '06' count_dimension,
           (case when x.follower_leader is null then '1' else x.follower_leader end) dimension_sort, sum(x.sum1) order_money
      from scmdata.pt_ordered t
     inner join (select t1.company_id, t1.product_gress_code, t1.order_money,
                        (t1.order_money / count(t1.product_gress_code) over(partition by t1.product_gress_code)) sum1,
                        regexp_substr(t1.flw_order, '[^,]+', 1, level) follower_leader
                   from scmdata.pt_ordered t1
                  --where t1.flw_order is not null
                 connect by prior t1.pt_ordered_id = t1.pt_ordered_id
                        and level <=  length(t1.flw_order) - length(regexp_replace(t1.flw_order, ',', '')) + 1
                        and prior dbms_random.value is not null) x
        on x.company_id = t.company_id
       and x.product_gress_code = t.product_gress_code
     group by t.company_id, t.year, decode(t.quarter,1,1,2,1,3,2,4,2), t.category, t.group_name,x.follower_leader),
  flw_leader as
 (select t.company_id, t.product_gress_code,t.fixed_price,t.order_create_date,
         (t.order_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum1,
         (t.satisfy_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum2,
         regexp_substr(t.flw_order, '[^,]+', 1, level) follower_leader
    from scmdata.pt_ordered t
   --where t.flw_order is not null
 connect by prior t.pt_ordered_id = t.pt_ordered_id
        and level <= length(t.flw_order) - length(regexp_replace(t.flw_order, ',', '')) + 1
        and prior dbms_random.value is not null)
 select k.company_id,k.year, k.halfyear, k.category, k.group_name,k.count_dimension,k.dimension_sort,k.order_money,z.sho_order_money,
        z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id,  tp.year,  tp.halfyear, tp.category, tp.group_name,
                     '06' count_dimension,(case when tp.follower_leader is null then '1' else tp.follower_leader end) dimension_sort, sum(tp.sum2) sho_order_money
                from (select t3.company_id, t3.year,decode(t3.quarter,1,1,2,1,3,2,4,2) halfyear,
                              (case when t3.group_name is null then '1' else t3.group_name end)group_name,
                              t3.category, x.follower_leader, x.sum2
                        from scmdata.pt_ordered t3
                        inner join flw_leader x
                          on x.company_id = t3.company_id
                         and x.product_gress_code = t3.product_gress_code
                      union all
                      select t3a.company_id, t3a.year, decode(t3a.quarter,1,1,2,1,3,2,4,2) halfyear,
                              (case when t3a.group_name is null then '1' else t3a.group_name end)group_name,
                              t3a.category, x.follower_leader, (x.sum1- x.sum2) sum_money
                        from scmdata.pt_ordered t3a
                        inner join flw_leader x
                          on x.company_id = t3a.company_id
                         and x.product_gress_code = t3a.product_gress_code
                       left join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                                or a.dept_name like '%事业部%' or a.dept_name = '无')
                      union all
                      select t3a.company_id, t3a.year,decode(t3a.quarter,1,1,2,1,3,2,4,2) halfyear,
                             (case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category,
                              x.follower_leader, (x.sum1- x.sum2) sum_money
                        from scmdata.pt_ordered t3a
                        inner join flw_leader x
                          on x.company_id = t3a.company_id
                         and x.product_gress_code = t3a.product_gress_code
                       where t3a.responsible_dept = 'b550778b4f2b36b4e0533c281caca074' /*责任部门1级：供应链管理部*/
                         and t3a.responsible_dept_sec in ('DP2203124299047457','b550778b4f4336b4e0533c281caca074',
                             'b550778b4f4836b4e0533c281caca074','b550778b4f3e36b4e0533c281caca074')/*责任部门2级：直播2部、QA组、面料管控部、工艺组*/ ) tp
               group by tp.company_id, tp.year, tp.halfyear, tp.category, tp.group_name, tp.follower_leader) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.halfyear = z.halfyear
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select t3.company_id, t3.year, decode(t3.quarter,1,1,2,1,3,2,4,2) halfyear,
                     (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category,
                     '06' count_dimension,(case when x.follower_leader is null then '1' else x.follower_leader end) dimension_sort, sum(x.sum2)sho_order_original_money
                from scmdata.pt_ordered t3
               inner join flw_leader x
                  on x.company_id = t3.company_id
                 and x.product_gress_code = t3.product_gress_code
               group by t3.company_id, t3.year, decode(t3.quarter,1,1,2,1,3,2,4,2), t3.group_name, t3.category, x.follower_leader) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.halfyear = z1.halfyear
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort  ]';
--补货平均交期指标
      V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_halfyear tka
  USING (
        with flw_leader as
 (select t.company_id, t.product_gress_code,t.fixed_price,t.order_create_date,
         (t.order_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum1,
         (t.satisfy_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum2,
         regexp_substr(t.flw_order, '[^,]+', 1, level) follower_leader
    from scmdata.pt_ordered t
   --where t.flw_order is not null
 connect by prior t.pt_ordered_id = t.pt_ordered_id
        and level <= length(t.flw_order) - length(regexp_replace(t.flw_order, ',', '')) + 1
        and prior dbms_random.value is not null)
select k.company_id, k.year, k.halfyear, k.category, k.group_name, k.count_dimension, k.dimension_sort,
       k.delivery_money,  qa.delivery_order_money
   from  (select t2.company_id, x.year, x.halfyear, t2.category,
                     (case when t2.group_name is null then '1' else t2.group_name end)group_name,
                     '06' count_dimension,(case when x.follower_leader is null then '1' else x.follower_leader end) dimension_sort, sum(sum1) delivery_money
                from scmdata.pt_ordered t2
                inner join (select distinct tf.company_id,tf.follower_leader,
                                  tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyy') year,
                                   decode(to_char(td.delivery_origin_time, 'Q'),1,1,2,1,3,2,4,2) halfyear,
                                  ((tf.fixed_price * td.delivery_amount) /
count(tf.product_gress_code) over(partition by tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyy'),decode(to_char(td.delivery_origin_time, 'Q'),1,1,2,1,3,2,4,2))) sum1
                             from flw_leader tf
                            inner join scmdata.t_delivery_record td
                               on td.order_code = tf.product_gress_code
                              and td.company_id = tf.company_id) x
                  on x.company_id = t2.company_id
                 and x.product_gress_code = t2.product_gress_code
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id,x.year, x.halfyear, t2.group_name, t2.category, x.follower_leader) k
   left join (select t5.company_id, x.year, x.halfyear,t5.category,
                     (case when t5.group_name is null then '1' else t5.group_name end)group_name, '06' count_dimension,
                     (case when x.follower_leader is null then '1' else x.follower_leader end) dimension_sort, sum(x.sum1_date * x.sum1) delivery_order_money
                from scmdata.pt_ordered t5
               inner join scmdata.t_ordered tor
                  on tor.company_id = t5.company_id
                 and tor.order_code = t5.product_gress_code
                 and tor.is_product_order = '1'
               inner join (select distinct tf.company_id,
                                            tf.follower_leader,
                                            tf.product_gress_code,
                                            to_char(td.delivery_origin_time, 'yyyy') year,
                                             decode(to_char(td.delivery_origin_time, 'Q') ,1,1,2,1,3,2,4,2) halfyear,
                                            (to_date(to_char(td.delivery_origin_time, 'yyyy/mm/dd'),  'yyyy/mm/dd') -
                                            to_date(to_char(tf.order_create_date, 'yyyy/mm/dd'),  'yyyy/mm/dd')) sum1_date,
                                            ((tf.fixed_price * td.delivery_amount)  /
                                              count(tf.product_gress_code) over(partition by tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyy'),decode(to_char(td.delivery_origin_time, 'Q'),1,1,2,1,3,2,4,2))) sum1,
                                            tf.fixed_price,
                                            td.delivery_amount
                              from flw_leader tf
                             inner join scmdata.t_delivery_record td
                                on td.order_code = tf.product_gress_code
                               and td.company_id = tf.company_id) x
                  on x.company_id = t5.company_id
                 and x.product_gress_code = t5.product_gress_code
                 where tor.isfirstordered = 0
              group by t5.company_id, x.year, x.halfyear,t5.category, t5.group_name,x.follower_leader) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.halfyear = qa.halfyear
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort  ]';
   /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
    end;

    --5.统计维度：QC
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_halfyear tka
  USING (
       with kpi_order as
   (select t.company_id, t.year, decode(t.quarter,1,1,2,1,3,2,4,2) halfyear, t.category,
           (case when t.group_name is null then '1' else t.group_name end)group_name, '07' count_dimension,
           (case when x.qc is null then '1' else x.qc end) dimension_sort, sum(x.sum1) order_money
      from scmdata.pt_ordered t
      inner join (select t1.company_id, t1.product_gress_code, t1.order_money,
                        (t1.order_money / count(t1.product_gress_code) over(partition by t1.product_gress_code)) sum1,
                        regexp_substr(t1.qc, '[^,]+', 1, level) qc
                   from scmdata.pt_ordered t1
                  --where t1.qc is not null
                 connect by prior t1.pt_ordered_id = t1.pt_ordered_id
                        and level <=  length(t1.qc) - length(regexp_replace(t1.qc, ',', '')) + 1
                        and prior dbms_random.value is not null) x
        on x.company_id = t.company_id
       and x.product_gress_code = t.product_gress_code
     group by t.company_id, t.year, decode(t.quarter,1,1,2,1,3,2,4,2), t.category, t.group_name,x.qc),
  flw_leader as
 (select t.company_id, t.product_gress_code,t.fixed_price,t.order_create_date,
         (t.order_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum1,
         (t.satisfy_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum2,
         regexp_substr(t.qc, '[^,]+', 1, level) qc
    from scmdata.pt_ordered t
   --where t.qc is not null
 connect by prior t.pt_ordered_id = t.pt_ordered_id
        and level <= length(t.qc) - length(regexp_replace(t.qc, ',', '')) + 1
        and prior dbms_random.value is not null)
 select k.company_id,k.year, k.halfyear, k.category, k.group_name,k.count_dimension,k.dimension_sort,k.order_money,z.sho_order_money,
        z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id,  tp.year,  tp.halfyear, tp.category, tp.group_name,
                     '07' count_dimension,(case when tp.qc is null then '1' else tp.qc end) dimension_sort, sum(tp.sum2) sho_order_money
                from (select t3.company_id, t3.year, decode(t3.quarter,1,1,2,1,3,2,4,2) halfyear,
                              (case when t3.group_name is null then '1' else t3.group_name end)group_name,
                               t3.category, x.qc, x.sum2
                        from scmdata.pt_ordered t3
                        inner join flw_leader x
                          on x.company_id = t3.company_id
                         and x.product_gress_code = t3.product_gress_code
                      union all
                      select t3a.company_id, t3a.year, decode(t3a.quarter,1,1,2,1,3,2,4,2) halfyear,
                              (case when t3a.group_name is null then '1' else t3a.group_name end)group_name,
                              t3a.category, x.qc, (x.sum1- x.sum2) sum_money
                        from scmdata.pt_ordered t3a
                        inner join flw_leader x
                          on x.company_id = t3a.company_id
                         and x.product_gress_code = t3a.product_gress_code
                       left join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                              or a.dept_name like '%事业部%' or a.dept_name = '无')
                      union all
                      select t3a.company_id, t3a.year, decode(t3a.quarter,1,1,2,1,3,2,4,2) halfyear,
                              (case when t3a.group_name is null then '1' else t3a.group_name end)group_name,
                              t3a.category, x.qc, (x.sum1- x.sum2) sum_money
                        from scmdata.pt_ordered t3a
                        inner join flw_leader x
                          on x.company_id = t3a.company_id
                         and x.product_gress_code = t3a.product_gress_code
                       where t3a.responsible_dept = 'b550778b4f2b36b4e0533c281caca074' /*责任部门1级：供应链管理部*/
                         and t3a.responsible_dept_sec in ('DP2203124299047457','b550778b4f4336b4e0533c281caca074',
                             'b550778b4f4836b4e0533c281caca074','b550778b4f3e36b4e0533c281caca074')/*责任部门2级：直播2部、QA组、面料管控部、工艺组*/ ) tp
               group by tp.company_id, tp.year, tp.halfyear, tp.category, tp.group_name, tp.qc) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.halfyear = z.halfyear
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select t3.company_id, t3.year, decode(t3.quarter,1,1,2,1,3,2,4,2) halfyear,
                    (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category,
                     '07' count_dimension,(case when x.qc is null then '1' else x.qc end) dimension_sort, sum(x.sum2)sho_order_original_money
                from scmdata.pt_ordered t3
               inner join flw_leader x
                  on x.company_id = t3.company_id
                 and x.product_gress_code = t3.product_gress_code
               group by t3.company_id, t3.year, decode(t3.quarter,1,1,2,1,3,2,4,2), t3.group_name, t3.category, x.qc) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.halfyear = z1.halfyear
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--补货平均交期指标
      V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_halfyear tka
  USING (
       with flw_leader as
 (select t.company_id, t.product_gress_code,t.fixed_price,t.order_create_date,
         (t.order_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum1,
         (t.satisfy_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum2,
         regexp_substr(t.qc, '[^,]+', 1, level) qc
    from scmdata.pt_ordered t
   --where t.qc is not null
 connect by prior t.pt_ordered_id = t.pt_ordered_id
        and level <= length(t.qc) - length(regexp_replace(t.qc, ',', '')) + 1
        and prior dbms_random.value is not null)
select k.company_id, k.year, k.halfyear, k.category, k.group_name, k.count_dimension, k.dimension_sort,
       k.delivery_money,  qa.delivery_order_money
   from  (select t2.company_id, x.year, x.halfyear, t2.category,
                     (case when t2.group_name is null then '1' else t2.group_name end)group_name, '07' count_dimension,
                     (case when x.qc is null then '1' else x.qc end) dimension_sort, sum(sum1) delivery_money
                from scmdata.pt_ordered t2
                inner join (select distinct tf.company_id,tf.qc,
                                  tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyy') year,
                                   decode(to_char(td.delivery_origin_time, 'Q'),1,1,2,1,3,2,4,2) halfyear,
                                  ((tf.fixed_price * td.delivery_amount)/
 count(tf.product_gress_code) over(partition by tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyy'),decode(to_char(td.delivery_origin_time, 'Q'),1,1,2,1,3,2,4,2))) sum1
                             from flw_leader tf
                            inner join scmdata.t_delivery_record td
                               on td.order_code = tf.product_gress_code
                              and td.company_id = tf.company_id) x
                  on x.company_id = t2.company_id
                 and x.product_gress_code = t2.product_gress_code
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id,x.year, x.halfyear, t2.group_name, t2.category, x.qc) k
   left join (select t5.company_id, x.year, x.halfyear,t5.category,
                     (case when t5.group_name is null then '1' else t5.group_name end)group_name, '07' count_dimension,
                     (case when x.qc is null then '1' else x.qc end) dimension_sort, sum(x.sum1_date * x.sum1) delivery_order_money
                from scmdata.pt_ordered t5
               inner join scmdata.t_ordered tor
                  on tor.company_id = t5.company_id
                 and tor.order_code = t5.product_gress_code
                 and tor.is_product_order = '1'
               inner join (select distinct tf.company_id,
                                            tf.qc,
                                            tf.product_gress_code,
                                            to_char(td.delivery_origin_time, 'yyyy') year,
                                            decode(to_char(td.delivery_origin_time, 'Q'),1,1,2,1,3,2,4,2) halfyear,
                                            (to_date(to_char(td.delivery_origin_time, 'yyyy/mm/dd'),  'yyyy/mm/dd') -
                                            to_date(to_char(tf.order_create_date, 'yyyy/mm/dd'),  'yyyy/mm/dd')) sum1_date,
                                            ((tf.fixed_price * td.delivery_amount)/
                                              count(tf.product_gress_code) over(partition by tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyy'),decode(to_char(td.delivery_origin_time, 'Q'),1,1,2,1,3,2,4,2))) sum1,
                                            tf.fixed_price,
                                            td.delivery_amount
                              from flw_leader tf
                             inner join scmdata.t_delivery_record td
                                on td.order_code = tf.product_gress_code
                               and td.company_id = tf.company_id) x
                  on x.company_id = t5.company_id
                 and x.product_gress_code = t5.product_gress_code
                 where tor.isfirstordered = 0
              group by t5.company_id, x.year, x.halfyear,t5.category, t5.group_name,x.qc) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.halfyear = qa.halfyear
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort ]';
   /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
    end;

    --9.统计维度：QC主管
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_halfyear tka
  USING (
       with kpi_order as
   (select t.company_id, t.year, decode(t.quarter,1,1,2,1,3,2,4,2) halfyear, t.category,
           (case when t.group_name is null then '1' else t.group_name end)group_name, '08' count_dimension,
           (case when x.qc_manager is null then '1' else x.qc_manager end) dimension_sort, sum(x.sum1) order_money
      from scmdata.pt_ordered t
     inner join (select t1.company_id, t1.product_gress_code, t1.order_money,
                        (t1.order_money / count(t1.product_gress_code) over(partition by t1.product_gress_code)) sum1,
                        regexp_substr(t1.qc_manager, '[^,]+', 1, level) qc_manager
                   from scmdata.pt_ordered t1
                  --where t1.qc_manager is not null
                 connect by prior t1.pt_ordered_id = t1.pt_ordered_id
                        and level <=  length(t1.qc_manager) - length(regexp_replace(t1.qc_manager, ',', '')) + 1
                        and prior dbms_random.value is not null) x
        on x.company_id = t.company_id
       and x.product_gress_code = t.product_gress_code
     group by t.company_id, t.year,decode(t.quarter,1,1,2,1,3,2,4,2), t.category, t.group_name,x.qc_manager),
  flw_leader as
 (select t.company_id, t.product_gress_code,t.fixed_price,t.order_create_date,
         (t.order_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum1,
         (t.satisfy_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum2,
         regexp_substr(t.qc_manager, '[^,]+', 1, level) qc_manager
    from scmdata.pt_ordered t
 --  where t.qc_manager is not null
 connect by prior t.pt_ordered_id = t.pt_ordered_id
        and level <= length(t.qc_manager) - length(regexp_replace(t.qc_manager, ',', '')) + 1
        and prior dbms_random.value is not null)
 select k.company_id,k.year, k.halfyear, k.category, k.group_name,k.count_dimension,k.dimension_sort,k.order_money,z.sho_order_money,
        z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id,  tp.year,  tp.halfyear, tp.category, tp.group_name,
                     '08' count_dimension,(case when tp.qc_manager is null then '1' else tp.qc_manager end) dimension_sort, sum(tp.sum2) sho_order_money
                from (select t3.company_id, t3.year, decode(t3.quarter,1,1,2,1,3,2,4,2) halfyear,
                              (case when t3.group_name is null then '1' else t3.group_name end)group_name,
                              t3.category, x.qc_manager, x.sum2
                        from scmdata.pt_ordered t3
                        inner join flw_leader x
                          on x.company_id = t3.company_id
                         and x.product_gress_code = t3.product_gress_code
                      union all
                      select t3a.company_id, t3a.year, decode(t3a.quarter,1,1,2,1,3,2,4,2) halfyear,
                              (case when t3a.group_name is null then '1' else t3a.group_name end)group_name,
                              t3a.category, x.qc_manager, (x.sum1- x.sum2) sum_money
                        from scmdata.pt_ordered t3a
                        inner join flw_leader x
                          on x.company_id = t3a.company_id
                         and x.product_gress_code = t3a.product_gress_code
                       left join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%' or a.dept_name like '%财务部%'
                                or a.dept_name like '%事业部%' or a.dept_name = '无')
                      union all
                      select t3a.company_id, t3a.year, decode(t3a.quarter,1,1,2,1,3,2,4,2) halfyear,
                              (case when t3a.group_name is null then '1' else t3a.group_name end)group_name,
                              t3a.category, x.qc_manager, (x.sum1- x.sum2) sum_money
                        from scmdata.pt_ordered t3a
                        inner join flw_leader x
                          on x.company_id = t3a.company_id
                         and x.product_gress_code = t3a.product_gress_code
                       where t3a.responsible_dept = 'b550778b4f2b36b4e0533c281caca074' /*责任部门1级：供应链管理部*/
                         and t3a.responsible_dept_sec in ('DP2203124299047457','b550778b4f4336b4e0533c281caca074',
                             'b550778b4f4836b4e0533c281caca074','b550778b4f3e36b4e0533c281caca074')/*责任部门2级：直播2部、QA组、面料管控部、工艺组*/ ) tp
               group by tp.company_id, tp.year, tp.halfyear, tp.category, tp.group_name, tp.qc_manager) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.halfyear = z.halfyear
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select t3.company_id, t3.year, decode(t3.quarter,1,1,2,1,3,2,4,2) halfyear,
              (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category,
                     '08' count_dimension,(case when x.qc_manager is null then '1' else x.qc_manager end) dimension_sort, sum(x.sum2)sho_order_original_money
                from scmdata.pt_ordered t3
               inner join flw_leader x
                  on x.company_id = t3.company_id
                 and x.product_gress_code = t3.product_gress_code
               group by t3.company_id, t3.year, decode(t3.quarter,1,1,2,1,3,2,4,2), t3.group_name, t3.category, x.qc_manager) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.halfyear = z1.halfyear
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--补货平均交期指标
      V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_halfyear tka
  USING (
       with  flw_leader as
 (select t.company_id, t.product_gress_code,t.fixed_price,t.order_create_date,
         (t.order_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum1,
         (t.satisfy_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum2,
         regexp_substr(t.qc_manager, '[^,]+', 1, level) qc_manager
    from scmdata.pt_ordered t
 --  where t.qc_manager is not null
 connect by prior t.pt_ordered_id = t.pt_ordered_id
        and level <= length(t.qc_manager) - length(regexp_replace(t.qc_manager, ',', '')) + 1
        and prior dbms_random.value is not null)
select k.company_id, k.year, k.halfyear, k.category, k.group_name, k.count_dimension, k.dimension_sort,
       k.delivery_money,  qa.delivery_order_money
   from (select t2.company_id, x.year, x.halfyear, t2.category,
                     (case when t2.group_name is null then '1' else t2.group_name end)group_name, '08' count_dimension,
                      (case when x.qc_manager is null then '1' else x.qc_manager end) dimension_sort, sum(sum1) delivery_money
                from scmdata.pt_ordered t2
                inner join (select distinct tf.company_id,tf.qc_manager,
                                  tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyy') year,
                                   decode(to_char(td.delivery_origin_time, 'Q'),1,1,2,1,3,2,4,2) halfyear,
                                  ((tf.fixed_price * td.delivery_amount)/
 count(tf.product_gress_code) over(partition by tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyy'),decode(to_char(td.delivery_origin_time, 'Q'),1,1,2,1,3,2,4,2))) sum1
                             from flw_leader tf
                            inner join scmdata.t_delivery_record td
                               on td.order_code = tf.product_gress_code
                              and td.company_id = tf.company_id) x
                  on x.company_id = t2.company_id
                 and x.product_gress_code = t2.product_gress_code
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id,x.year, x.halfyear, t2.group_name, t2.category, x.qc_manager) k
   left join (select t5.company_id, x.year, x.halfyear,t5.category, (case when t5.group_name is null then '1' else t5.group_name end)group_name, '08' count_dimension,
                     (case when x.qc_manager is null then '1' else x.qc_manager end) dimension_sort, sum(x.sum1_date * x.sum1) delivery_order_money
                from scmdata.pt_ordered t5
               inner join scmdata.t_ordered tor
                  on tor.company_id = t5.company_id
                 and tor.order_code = t5.product_gress_code
                 and tor.is_product_order = '1'
               inner join (select distinct tf.company_id,
                                            tf.qc_manager,
                                            tf.product_gress_code,
                                            to_char(td.delivery_origin_time, 'yyyy') year,
                                             decode(to_char(td.delivery_origin_time, 'Q'),1,1,2,1,3,2,4,2) halfyear,
                                            (to_date(to_char(td.delivery_origin_time, 'yyyy/mm/dd'),  'yyyy/mm/dd') -
                                            to_date(to_char(tf.order_create_date, 'yyyy/mm/dd'),  'yyyy/mm/dd')) sum1_date,
                                            ((tf.fixed_price * td.delivery_amount) /
                                              count(tf.product_gress_code) over(partition by tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyy'),decode(to_char(td.delivery_origin_time, 'Q'),1,1,2,1,3,2,4,2))) sum1,
                                            tf.fixed_price,
                                            td.delivery_amount
                              from flw_leader tf
                             inner join scmdata.t_delivery_record td
                                on td.order_code = tf.product_gress_code
                               and td.company_id = tf.company_id) x
                  on x.company_id = t5.company_id
                 and x.product_gress_code = t5.product_gress_code
                 where tor.isfirstordered = 0
              group by t5.company_id, x.year, x.halfyear,t5.category, t5.group_name,x.qc_manager) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.halfyear = qa.halfyear
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort  ]';
   /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
    end;
  END P_T_KPI_HALFYEAR;

  /*------------------------------------------------------------------------------
   对象：
        P_T_KPI_YEAR
   统计维度：
       分类、区域组、款式名称、产品子类、供应商、生产工厂、跟单、qc、qc主管
   时间维度：
       年度
   用途：
       多维度指标查询年度数据表（scmdata.t_kpi_year）
   更新规则：
       每年6号（1月6号）凌晨4点半更新前一年度的数据
   t_type参数解析
        t_type = 0 更新全部指标
        t_type = 1 更新订单满足率（原值、绩效值）指标
        t_type = 2 更新补货平均交期指标
   p_type参数解析
        p_type = 0 更新全部历史数据
        p_type = 1 只更新上一个维度（年）的数据
   上线版本：2022-10-30
   ----------------------------------------------------------------------------------*/
  PROCEDURE P_T_KPI_YEAR(t_type number, p_type number) IS
    V_Q_SQL clob;--订单满足率指标
    V_Q1_SQL clob;--补货平均交期指标
    ---更新全部历史数据
    V_W_SQL clob := q'[
    where k.year < to_char(sysdate,'yyyy') ) tkb
      ON (tka.company_id = tkb.company_id and tka.year = tkb.year and  tka.category = tkb.category
          and tka.groupname = tkb.group_name and tka.count_dimension = tkb.count_dimension and tka.dimension_sort = tkb.dimension_sort)
     WHEN MATCHED THEN]';
    ---更新上一年数据
    V_W1_SQL clob := q'[
   where k.year = to_char(sysdate,'yyyy')-1) tkb
      ON (tka.company_id = tkb.company_id and tka.year = tkb.year  and tka.category = tkb.category
          and tka.groupname = tkb.group_name and tka.count_dimension = tkb.count_dimension and tka.dimension_sort = tkb.dimension_sort)
     WHEN MATCHED THEN]';
    ---更新订单满足率
    V_U_SQL clob := q'[  UPDATE
         SET tka.order_money               = tkb.order_money,
             tka.sho_order_money           = tkb.sho_order_money,
             tka.sho_order_original_money  = tkb.sho_order_original_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    ---更新补货平均交期
    V_U1_SQL clob := q'[  UPDATE
         SET tka.delivery_money            = tkb.delivery_money,
             tka.delivery_order_money      = tkb.delivery_order_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    ---新增订单满足率
    V_IN_SQL clob := q'[
    WHEN NOT MATCHED THEN
      INSERT
        (tka.t_kpi_y_id,
         tka.company_id,
         tka.year,
         tka.category,
         tka.groupname,
         tka.count_dimension,
         tka.dimension_sort,
         tka.order_money,
         tka.sho_order_money,
         tka.sho_order_original_money,
         tka.memo,
         tka.create_id,
         tka.create_time,
         tka.update_id,
         tka.update_time)
      VALUES
        (scmdata.f_get_uuid(),
         tkb.company_id,
         tkb.year,
         tkb.category,
         tkb.group_name,
         tkb.count_dimension,
         tkb.dimension_sort,
         tkb.order_money,
         tkb.sho_order_money,
         tkb.sho_order_original_money,
         ' ',
         'ADMIN',
         sysdate,
         'ADMIN',
         sysdate)]';
    ---新增补货平均交期
    V_IN1_SQL clob := q'[
    WHEN NOT MATCHED THEN
      INSERT
        (tka.t_kpi_y_id,
         tka.company_id,
         tka.year,
         tka.category,
         tka.groupname,
         tka.count_dimension,
         tka.dimension_sort,
         tka.delivery_money,
         tka.delivery_order_money,
         tka.memo,
         tka.create_id,
         tka.create_time,
         tka.update_id,
         tka.update_time)
      VALUES
        (scmdata.f_get_uuid(),
         tkb.company_id,
         tkb.year,
         tkb.category,
         tkb.group_name,
         tkb.count_dimension,
         tkb.dimension_sort,
         tkb.delivery_money,
         tkb.delivery_order_money,
         ' ',
         'ADMIN',
         sysdate,
         'ADMIN',
         sysdate)]';
    V_SQL    clob;
    V1_SQL    clob;
    --1.统计维度：分类
  BEGIN
--订单满足率指标
    V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_year tka
  USING (
     with kpi_order as
  (select t.company_id, t.year, t.category, (case when t.group_name is null then '1' else t.group_name end)group_name,
          '00' count_dimension, t.category dimension_sort, sum(t.order_money) order_money
     from scmdata.pt_ordered t
    group by t.company_id, t.year, t.category, t.group_name)
 select k.company_id, k.year, k.category, k.group_name, k.count_dimension, k.dimension_sort,
        k.order_money, z.sho_order_money,  z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id,tp.year,tp.category, tp.group_name,
                     '00' count_dimension, tp.category dimension_sort, sum(tp.sum_money) sho_order_money
                from (select t3.company_id, t3.year, (case when t3.group_name is null then '1' else t3.group_name end)group_name,
                              t3.category, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3
                      union all
                      select t3a.company_id, t3a.year,(case when t3a.group_name is null then '1' else t3a.group_name end)group_name,
                             t3a.category,(t3a.order_money - t3a.satisfy_money) sum_money
                        from scmdata.pt_ordered t3a
                       inner join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                             or a.dept_name like '%事业部%' or a.dept_name = '无')) tp
               group by tp.company_id, tp.year,  tp.category, tp.group_name) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select tp.company_id, tp.year, tp.category, tp.group_name, '00' count_dimension,
                     tp.category dimension_sort, sum(tp.sum_money) sho_order_original_money
                from (select t3.company_id, t3.year,  t3.category,
                             (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3) tp
               group by tp.company_id, tp.year, tp.group_name, tp.category) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--补货平均交期指标
    V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_year tka
  USING ( select k.company_id, k.year, k.category, k.group_name, k.count_dimension, k.dimension_sort,
           k.delivery_money, qa.delivery_order_money
   from (select t2.company_id,  to_char(td.delivery_origin_time, 'yyyy') year,
                     t2.category,(case when t2.group_name is null then '1' else t2.group_name end)group_name, '00' count_dimension, t2.category dimension_sort,
                     sum(t2.fixed_price * td.delivery_amount) delivery_money
                from scmdata.pt_ordered t2
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               inner join scmdata.t_delivery_record td
                  on td.order_code = t2.product_gress_code
                 and td.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id,  to_char(td.delivery_origin_time, 'yyyy'), t2.group_name, t2.category) k
   left join (select ta0.company_id, ta0.year, ta0.category, ta0.group_name, '00' count_dimension, ta0.category dimension_sort,
                     sum(ta0.sum1_date * ta0.sum1_money) delivery_order_money
                from (select t5.company_id, to_char(tba.delivery_origin_time, 'yyyy') year,  t5.category,
                             (case when t5.group_name is null then '1' else t5.group_name end)group_name,
                             (to_date(to_char(tba.delivery_origin_time, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                              to_date(to_char(t5.order_create_date,  'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                             (t5.fixed_price * tba.delivery_amount) sum1_money
                        from scmdata.pt_ordered t5
                       inner join scmdata.t_delivery_record tba
                          on t5.product_gress_code = tba.order_code
                         and t5.company_id = tba.company_id
                       inner join scmdata.t_ordered tor
                          on tor.company_id = tba.company_id
                         and tor.order_code = tba.order_code
                       inner join scmdata.t_commodity_info tb
                          on t5.goo_id = tb.rela_goo_id
                         and tb.goo_id = tba.goo_id
                         and t5.company_id = tb.company_id
                       where tor.isfirstordered = 0
                         and tor.is_product_order = 1) ta0
               group by ta0.company_id, ta0.year, ta0.category, ta0.group_name) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort ]';
   /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;

    --2.统计维度：区域组
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_year tka
  USING (
         with kpi_order as
  (select t.company_id, t.year, t.category, (case when t.group_name is null then '1' else t.group_name end)group_name,
          '01' count_dimension, (case when t.group_name is null then '1' else t.group_name end) dimension_sort, sum(t.order_money) order_money
     from scmdata.pt_ordered t
    group by t.company_id, t.year, t.category, t.group_name)
 select k.company_id, k.year, k.category, k.group_name, k.count_dimension, k.dimension_sort,
        k.order_money, z.sho_order_money, z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id, tp.year, tp.category, tp.group_name,
                     '01' count_dimension, tp.group_name dimension_sort, sum(tp.sum_money) sho_order_money
                from (select t3.company_id, t3.year, (case when t3.group_name is null then '1' else t3.group_name end)group_name,
                             t3.category, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3
                      union all
                      select t3a.company_id,  t3a.year,(case when t3a.group_name is null then '1' else t3a.group_name end)group_name,
                             t3a.category, (t3a.order_money - t3a.satisfy_money) sum_money
                        from scmdata.pt_ordered t3a
                       inner join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                              or a.dept_name like '%事业部%' or a.dept_name = '无')) tp
               group by tp.company_id, tp.year, tp.category, tp.group_name) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select tp.company_id, tp.year,tp.category, tp.group_name,
                     '01' count_dimension, tp.group_name dimension_sort, sum(tp.sum_money) sho_order_original_money
                from (select t3.company_id, t3.year,  t3.category,
                             (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3) tp
               group by tp.company_id, tp.year,tp.group_name, tp.category) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--补货平均交期指标
      V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_year tka
  USING (select k.company_id, k.year, k.category, k.group_name, k.count_dimension, k.dimension_sort,
       k.delivery_money, qa.delivery_order_money
   from (select t2.company_id, to_char(td.delivery_origin_time, 'yyyy') year,
                     t2.category, (case when t2.group_name is null then '1' else t2.group_name end)group_name, '01' count_dimension,
                     (case when t2.group_name is null then '1' else t2.group_name end) dimension_sort, sum(t2.fixed_price * td.delivery_amount) delivery_money
                from scmdata.pt_ordered t2
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               inner join scmdata.t_delivery_record td
                  on td.order_code = t2.product_gress_code
                 and td.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id,  to_char(td.delivery_origin_time, 'yyyy'), t2.group_name,  t2.category) k
   left join (select ta0.company_id, ta0.year,  ta0.category, ta0.group_name,
                     '01' count_dimension, ta0.group_name dimension_sort, sum(ta0.sum1_date * ta0.sum1_money) delivery_order_money
                from (select t5.company_id,   to_char(tba.delivery_origin_time, 'yyyy') year, t5.category,
                             (case when t5.group_name is null then '1' else t5.group_name end)group_name,
                             (to_date(to_char(tba.delivery_origin_time,  'yyyy/mm/dd'), 'yyyy/mm/dd') -
                             to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                             (t5.fixed_price * tba.delivery_amount) sum1_money
                        from scmdata.pt_ordered t5
                       inner join scmdata.t_delivery_record tba
                          on t5.product_gress_code = tba.order_code
                         and t5.company_id = tba.company_id
                       inner join scmdata.t_ordered tor
                          on tor.company_id = tba.company_id
                         and tor.order_code = tba.order_code
                       inner join scmdata.t_commodity_info tb
                          on t5.goo_id = tb.rela_goo_id
                         and tb.goo_id = tba.goo_id
                         and t5.company_id = tb.company_id
                       where tor.isfirstordered = 0
                         and tor.is_product_order = 1) ta0
               group by ta0.company_id, ta0.year, ta0.category, ta0.group_name) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort ]';
   /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
    end;

    --3.统计维度：款式名称
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_year tka
  USING (
        with kpi_order as
  (select t.company_id, t.year,  t.category,(case when t.group_name is null then '1' else t.group_name end)group_name, '02' count_dimension,
          t.style_name dimension_sort,sum(t.order_money) order_money
     from scmdata.pt_ordered t
    group by t.company_id, t.year,t.category, t.group_name, t.style_name)
 select k.company_id, k.year, k.category, k.group_name, k.count_dimension, k.dimension_sort,
        k.order_money, z.sho_order_money, z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id, tp.year,  tp.category, tp.group_name,
                     '02' count_dimension, tp.style_name dimension_sort, sum(tp.sum_money) sho_order_money
                from (select t3.company_id, t3.year, (case when t3.group_name is null then '1' else t3.group_name end)group_name,
                             t3.category, t3.style_name, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3
                      union all
                      select t3a.company_id, t3a.year, (case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category,
                             t3a.style_name, (t3a.order_money - t3a.satisfy_money) sum_money
                        from scmdata.pt_ordered t3a
                       inner join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                              or a.dept_name like '%事业部%' or a.dept_name = '无')) tp
               group by tp.company_id, tp.year, tp.category, tp.group_name, tp.style_name) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select tp.company_id, tp.year,  tp.category, tp.group_name,
                     '02' count_dimension, tp.style_name dimension_sort, sum(tp.sum_money) sho_order_original_money
                from (select t3.company_id, t3.year, t3.category, t3.style_name, (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3) tp
               group by tp.company_id,tp.year,tp.group_name,tp.category,tp.style_name) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--补货平均交期指标
      V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_year tka
  USING (select k.company_id, k.year, k.category, k.group_name, k.count_dimension, k.dimension_sort,
       k.delivery_money, qa.delivery_order_money
   from (select t2.company_id, to_char(td.delivery_origin_time, 'yyyy') year,
                      t2.category,(case when t2.group_name is null then '1' else t2.group_name end)group_name,'02' count_dimension,
                     t2.style_name dimension_sort, sum(t2.fixed_price * td.delivery_amount) delivery_money
                from scmdata.pt_ordered t2
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               inner join scmdata.t_delivery_record td
                  on td.order_code = t2.product_gress_code
                 and td.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id,to_char(td.delivery_origin_time, 'yyyy'), t2.group_name,t2.category,t2.style_name) k
   left join (select ta0.company_id, ta0.year, ta0.category, ta0.group_name, '02' count_dimension, ta0.style_name dimension_sort,
                     sum(ta0.sum1_date * ta0.sum1_money) delivery_order_money
                from (select t5.company_id, to_char(tba.delivery_origin_time, 'yyyy') year,
                             t5.category, (case when t5.group_name is null then '1' else t5.group_name end)group_name, t5.style_name,
                             (to_date(to_char(tba.delivery_origin_time, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                             to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                             (t5.fixed_price * tba.delivery_amount) sum1_money
                        from scmdata.pt_ordered t5
                       inner join scmdata.t_delivery_record tba
                          on t5.product_gress_code = tba.order_code
                         and t5.company_id = tba.company_id
                       inner join scmdata.t_ordered tor
                          on tor.company_id = tba.company_id
                         and tor.order_code = tba.order_code
                       inner join scmdata.t_commodity_info tb
                          on t5.goo_id = tb.rela_goo_id
                         and tb.goo_id = tba.goo_id
                         and t5.company_id = tb.company_id
                       where tor.isfirstordered = 0
                         and tor.is_product_order = 1) ta0
               group by ta0.company_id, ta0.year, ta0.category, ta0.group_name, ta0.style_name) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort ]';
   /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
    end;

    --4.统计维度：产品子类
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_year tka
  USING (
        with kpi_order as
  (select t.company_id,  t.year,t.category, (case when t.group_name is null then '1' else t.group_name end)group_name, '03' count_dimension, t.samll_category dimension_sort, sum(t.order_money) order_money
     from scmdata.pt_ordered t
    group by t.company_id, t.year,  t.category, t.group_name, t.samll_category)
 select k.company_id, k.year, k.category, k.group_name, k.count_dimension, k.dimension_sort, k.order_money,
        z.sho_order_money, z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id,  tp.year,  tp.category, tp.group_name, '03' count_dimension,
                     tp.samll_category dimension_sort, sum(tp.sum_money) sho_order_money
                from (select t3.company_id, t3.year,(case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category, t3.samll_category,  t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3
                      union all
                      select t3a.company_id, t3a.year,  (case when t3a.group_name is null then '1' else t3a.group_name end)group_name,  t3a.category,
                             t3a.samll_category, (t3a.order_money - t3a.satisfy_money) sum_money
                        from scmdata.pt_ordered t3a
                       inner join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%' or a.dept_name like '%财务部%'
                              or a.dept_name like '%事业部%' or a.dept_name = '无')) tp
               group by tp.company_id,tp.year,  tp.category, tp.group_name,  tp.samll_category) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select tp.company_id, tp.year, tp.category, tp.group_name, '03' count_dimension,
                     tp.samll_category dimension_sort, sum(tp.sum_money) sho_order_original_money
                from (select t3.company_id, t3.year,  t3.category, t3.samll_category,
                            (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3) tp
               group by tp.company_id, tp.year,  tp.group_name, tp.category, tp.samll_category) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--补货平均交期指标
      V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_year tka
  USING (select k.company_id, k.year, k.category, k.group_name, k.count_dimension, k.dimension_sort,
       k.delivery_money, qa.delivery_order_money
   from  (select t2.company_id,  to_char(td.delivery_origin_time, 'yyyy') year,
                      t2.category,(case when t2.group_name is null then '1' else t2.group_name end)group_name, '03' count_dimension,
                     t2.samll_category dimension_sort, sum(t2.fixed_price * td.delivery_amount) delivery_money
                from scmdata.pt_ordered t2
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               inner join scmdata.t_delivery_record td
                  on td.order_code = t2.product_gress_code
                 and td.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id, to_char(td.delivery_origin_time, 'yyyy'),
                        t2.group_name, t2.category, t2.samll_category) k
   left join (select ta0.company_id,  ta0.year, ta0.category, ta0.group_name, '03' count_dimension,
                     ta0.samll_category dimension_sort, sum(ta0.sum1_date * ta0.sum1_money) delivery_order_money
                from (select t5.company_id, to_char(tba.delivery_origin_time, 'yyyy') year,
                              t5.category, (case when t5.group_name is null then '1' else t5.group_name end)group_name, t5.samll_category,
                             (to_date(to_char(tba.delivery_origin_time, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                             to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                             (t5.fixed_price * tba.delivery_amount) sum1_money
                        from scmdata.pt_ordered t5
                       inner join scmdata.t_delivery_record tba
                          on t5.product_gress_code = tba.order_code
                         and t5.company_id = tba.company_id
                       inner join scmdata.t_ordered tor
                          on tor.company_id = tba.company_id
                         and tor.order_code = tba.order_code
                       inner join scmdata.t_commodity_info tb
                          on t5.goo_id = tb.rela_goo_id
                         and tb.goo_id = tba.goo_id
                         and t5.company_id = tb.company_id
                       where tor.isfirstordered = 0
                         and tor.is_product_order = 1) ta0
               group by ta0.company_id, ta0.year,  ta0.category, ta0.group_name, ta0.samll_category) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort ]';
   /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
    end;

    --5.统计维度：供应商
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_year tka
  USING (
       with kpi_order as
  (select t.company_id, t.year, t.category, (case when t.group_name is null then '1' else t.group_name end)group_name,'04' count_dimension, t.supplier_code dimension_sort, sum(t.order_money) order_money
     from scmdata.pt_ordered t
    group by t.company_id, t.year, t.category, t.group_name, t.supplier_code)
 select k.company_id, k.year,  k.category, k.group_name, k.count_dimension, k.dimension_sort, k.order_money,
        z.sho_order_money, z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id, tp.year, tp.category, tp.group_name, '04' count_dimension,
                     tp.supplier_code dimension_sort, sum(tp.sum_money) sho_order_money
                from (select t3.company_id, t3.year, (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category, t3.supplier_code, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3
                      union all
                      select t3a.company_id, t3a.year, (case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category, t3a.supplier_code,
                             (t3a.order_money - t3a.satisfy_money) sum_money
                        from scmdata.pt_ordered t3a
                       inner join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                               or  a.dept_name like '%事业部%' or a.dept_name = '无')) tp
               group by tp.company_id,tp.year,tp.category,tp.group_name,tp.supplier_code) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select tp.company_id,tp.year,tp.category,tp.group_name,'04' count_dimension,
                     tp.supplier_code dimension_sort,sum(tp.sum_money) sho_order_original_money
                from (select t3.company_id, t3.year,  t3.category, t3.supplier_code, (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3) tp
               group by tp.company_id,tp.year,tp.group_name,tp.category,tp.supplier_code) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--补货平均交期指标
      V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_year tka
  USING ( select k.company_id, k.year, k.category, k.group_name, k.count_dimension, k.dimension_sort,
       k.delivery_money, qa.delivery_order_money
   from (select t2.company_id,to_char(td.delivery_origin_time, 'yyyy') year,
                      t2.category, (case when t2.group_name is null then '1' else t2.group_name end)group_name,'04' count_dimension,
                     t2.supplier_code dimension_sort, sum(t2.fixed_price * td.delivery_amount) delivery_money
                from scmdata.pt_ordered t2
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               inner join scmdata.t_delivery_record td
                  on td.order_code = t2.product_gress_code
                 and td.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id, to_char(td.delivery_origin_time, 'yyyy'), t2.group_name, t2.category, t2.supplier_code) k
   left join (select ta0.company_id,ta0.year,ta0.category,ta0.group_name,'04' count_dimension,
                     ta0.supplier_code dimension_sort, sum(ta0.sum1_date * ta0.sum1_money) delivery_order_money
                from (select t5.company_id, to_char(tba.delivery_origin_time, 'yyyy') year,
                             t5.category,(case when t5.group_name is null then '1' else t5.group_name end)group_name, t5.supplier_code,
                             (to_date(to_char(tba.delivery_origin_time, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                             to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'),'yyyy/mm/dd')) sum1_date,
                             (t5.fixed_price * tba.delivery_amount) sum1_money
                        from scmdata.pt_ordered t5
                       inner join scmdata.t_delivery_record tba
                          on t5.product_gress_code = tba.order_code
                         and t5.company_id = tba.company_id
                       inner join scmdata.t_ordered tor
                          on tor.company_id = tba.company_id
                         and tor.order_code = tba.order_code
                       inner join scmdata.t_commodity_info tb
                          on t5.goo_id = tb.rela_goo_id
                         and tb.goo_id = tba.goo_id
                         and t5.company_id = tb.company_id
                       where tor.isfirstordered = 0
                         and tor.is_product_order = 1) ta0
               group by ta0.company_id,ta0.year,ta0.category,ta0.group_name,ta0.supplier_code) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort ]';
   /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
    end;

    --6.统计维度：生产工厂
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_year tka
  USING (
      with kpi_order as
  (select t.company_id,t.year,t.category,(case when t.group_name is null then '1' else t.group_name end)group_name,
          '05' count_dimension,t.factory_code dimension_sort,sum(t.order_money) order_money
     from scmdata.pt_ordered t
    group by t.company_id,t.year,t.category,t.group_name,t.factory_code)
 select k.company_id,k.year,k.category,k.group_name,k.count_dimension,k.dimension_sort,k.order_money,z.sho_order_money,
        z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id, tp.year, tp.category, tp.group_name, '05' count_dimension, tp.factory_code dimension_sort,
                      sum(tp.sum_money) sho_order_money
                from (select t3.company_id, t3.year, (case when t3.group_name is null then '1' else t3.group_name end)group_name,
                             t3.category, t3.factory_code, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3
                      union all
                      select t3a.company_id, t3a.year, (case when t3a.group_name is null then '1' else t3a.group_name end)group_name,
                              t3a.category, t3a.factory_code,
                             (t3a.order_money - t3a.satisfy_money) sum_money
                        from scmdata.pt_ordered t3a
                       inner join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                              or a.dept_name like '%事业部%' or a.dept_name = '无')) tp
               group by tp.company_id,tp.year,tp.category,tp.group_name,tp.factory_code) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select tp.company_id,tp.year,tp.category,tp.group_name,'05' count_dimension,
                     tp.factory_code dimension_sort, sum(tp.sum_money) sho_order_original_money
                from (select t3.company_id, t3.year, t3.category, t3.factory_code,
                             (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.satisfy_money sum_money
                        from scmdata.pt_ordered t3) tp
               group by tp.company_id,tp.year,tp.group_name,tp.category,tp.factory_code) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--订单满足率指标
      V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_year tka
  USING (select k.company_id, k.year, k.category, k.group_name, k.count_dimension, k.dimension_sort,
       k.delivery_money, qa.delivery_order_money
   from (select t2.company_id, to_char(td.delivery_origin_time, 'yyyy') year,
                     t2.category, (case when t2.group_name is null then '1' else t2.group_name end)group_name,
                     '05' count_dimension,t2.factory_code dimension_sort,
                     sum(t2.fixed_price * td.delivery_amount) delivery_money
                from scmdata.pt_ordered t2
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               inner join scmdata.t_delivery_record td
                  on td.order_code = t2.product_gress_code
                 and td.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id, to_char(td.delivery_origin_time, 'yyyy'),
                      t2.group_name,t2.category,t2.factory_code) k
   left join (select ta0.company_id, ta0.year, ta0.category, ta0.group_name, '05' count_dimension,
                     ta0.factory_code dimension_sort, sum(ta0.sum1_date * ta0.sum1_money) delivery_order_money
                from (select t5.company_id, to_char(tba.delivery_origin_time, 'yyyy') year,
                             t5.category, (case when t5.group_name is null then '1' else t5.group_name end)group_name, t5.factory_code,
                             (to_date(to_char(tba.delivery_origin_time,  'yyyy/mm/dd'), 'yyyy/mm/dd') -
                             to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                             (t5.fixed_price * tba.delivery_amount) sum1_money
                        from scmdata.pt_ordered t5
                       inner join scmdata.t_delivery_record tba
                          on t5.product_gress_code = tba.order_code
                         and t5.company_id = tba.company_id
                       inner join scmdata.t_ordered tor
                          on tor.company_id = tba.company_id
                         and tor.order_code = tba.order_code
                       inner join scmdata.t_commodity_info tb
                          on t5.goo_id = tb.rela_goo_id
                         and tb.goo_id = tba.goo_id
                         and t5.company_id = tb.company_id
                       where tor.isfirstordered = 0
                         and tor.is_product_order = 1) ta0
               group by ta0.company_id,ta0.year,ta0.category,ta0.group_name,ta0.factory_code) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort ]';
   /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
    end;

    --7.统计维度：跟单
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_year tka
  USING (
        with kpi_order as
   (select t.company_id, t.year, t.category,(case when t.group_name is null then '1' else t.group_name end)group_name, '06' count_dimension,
           (case when x.follower_leader is null then '1' else x.follower_leader end) dimension_sort, sum(x.sum1) order_money
      from scmdata.pt_ordered t
     inner join (select t1.company_id, t1.product_gress_code, t1.order_money,
                        (t1.order_money / count(t1.product_gress_code) over(partition by t1.product_gress_code)) sum1,
                        regexp_substr(t1.flw_order, '[^,]+', 1, level) follower_leader
                   from scmdata.pt_ordered t1
                 -- where t1.flw_order is not null
                 connect by prior t1.pt_ordered_id = t1.pt_ordered_id
                        and level <=  length(t1.flw_order) - length(regexp_replace(t1.flw_order, ',', '')) + 1
                        and prior dbms_random.value is not null) x
        on x.company_id = t.company_id
       and x.product_gress_code = t.product_gress_code
     group by t.company_id, t.year, t.category, t.group_name,x.follower_leader),
  flw_leader as
 (select t.company_id, t.product_gress_code,t.fixed_price,t.order_create_date,
         (t.order_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum1,
         (t.satisfy_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum2,
         regexp_substr(t.flw_order, '[^,]+', 1, level) follower_leader
    from scmdata.pt_ordered t
   --where t.flw_order is not null
 connect by prior t.pt_ordered_id = t.pt_ordered_id
        and level <= length(t.flw_order) - length(regexp_replace(t.flw_order, ',', '')) + 1
        and prior dbms_random.value is not null)
 select k.company_id,k.year, k.category, k.group_name,k.count_dimension,k.dimension_sort,k.order_money,z.sho_order_money,
        z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id,  tp.year, tp.category, tp.group_name,
                     '06' count_dimension,(case when tp.follower_leader is null then '1' else tp.follower_leader end) dimension_sort, sum(tp.sum2) sho_order_money
                from (select t3.company_id, t3.year, (case when t3.group_name is null then '1' else t3.group_name end)group_name,
                              t3.category, x.follower_leader, x.sum2
                        from scmdata.pt_ordered t3
                        inner join flw_leader x
                          on x.company_id = t3.company_id
                         and x.product_gress_code = t3.product_gress_code
                      union all
                      select t3a.company_id, t3a.year, (case when t3a.group_name is null then '1' else t3a.group_name end)group_name,
                             t3a.category, x.follower_leader, (x.sum1- x.sum2) sum_money
                        from scmdata.pt_ordered t3a
                        inner join flw_leader x
                          on x.company_id = t3a.company_id
                         and x.product_gress_code = t3a.product_gress_code
                       left join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                             or a.dept_name like '%事业部%' or a.dept_name = '无')
                      union all
                      select t3a.company_id, t3a.year, (case when t3a.group_name is null then '1' else t3a.group_name end)group_name,
                             t3a.category, x.follower_leader, (x.sum1- x.sum2) sum_money
                        from scmdata.pt_ordered t3a
                        inner join flw_leader x
                          on x.company_id = t3a.company_id
                         and x.product_gress_code = t3a.product_gress_code
                       where t3a.responsible_dept = 'b550778b4f2b36b4e0533c281caca074' /*责任部门1级：供应链管理部*/
                         and t3a.responsible_dept_sec in ('DP2203124299047457','b550778b4f4336b4e0533c281caca074',
                             'b550778b4f4836b4e0533c281caca074','b550778b4f3e36b4e0533c281caca074')/*责任部门2级：直播2部、QA组、面料管控部、工艺组*/ ) tp
               group by tp.company_id, tp.year, tp.category, tp.group_name, tp.follower_leader) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select t3.company_id, t3.year, (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category,
                     '06' count_dimension,(case when x.follower_leader is null then '1' else x.follower_leader end) dimension_sort, sum(x.sum2)sho_order_original_money
                from scmdata.pt_ordered t3
               inner join flw_leader x
                  on x.company_id = t3.company_id
                 and x.product_gress_code = t3.product_gress_code
               group by t3.company_id, t3.year,t3.group_name, t3.category, x.follower_leader) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--补货平均交期指标
      V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_year tka
  USING (
        with flw_leader as
 (select t.company_id, t.product_gress_code,t.fixed_price,t.order_create_date,
         (t.order_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum1,
         (t.satisfy_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum2,
         regexp_substr(t.flw_order, '[^,]+', 1, level) follower_leader
    from scmdata.pt_ordered t
   --where t.flw_order is not null
 connect by prior t.pt_ordered_id = t.pt_ordered_id
        and level <= length(t.flw_order) - length(regexp_replace(t.flw_order, ',', '')) + 1
        and prior dbms_random.value is not null)
select k.company_id, k.year, k.category, k.group_name, k.count_dimension, k.dimension_sort,
       k.delivery_money, qa.delivery_order_money
   from  (select t2.company_id, x.year, t2.category,(case when t2.group_name is null then '1' else t2.group_name end)group_name, '06' count_dimension,
                      (case when x.follower_leader is null then '1' else x.follower_leader end)dimension_sort, sum(sum1) delivery_money
                from scmdata.pt_ordered t2
                inner join (select distinct tf.company_id,tf.follower_leader,
                                  tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyy') year,
                                  ((tf.fixed_price * td.delivery_amount)/
count(tf.product_gress_code) over(partition by tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyy'))) sum1
                             from flw_leader tf
                            inner join scmdata.t_delivery_record td
                               on td.order_code = tf.product_gress_code
                              and td.company_id = tf.company_id) x
                  on x.company_id = t2.company_id
                 and x.product_gress_code = t2.product_gress_code
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id,x.year, t2.group_name, t2.category, x.follower_leader) k
   left join (select t5.company_id, x.year, t5.category, (case when t5.group_name is null then '1' else t5.group_name end)group_name, '06' count_dimension,
                     (case when x.follower_leader is null then '1' else x.follower_leader end) dimension_sort, sum(x.sum1_date * x.sum1) delivery_order_money
                from scmdata.pt_ordered t5
               inner join scmdata.t_ordered tor
                  on tor.company_id = t5.company_id
                 and tor.order_code = t5.product_gress_code
                 and tor.is_product_order = '1'
               inner join (select distinct tf.company_id,
                                            tf.follower_leader,
                                            tf.product_gress_code,
                                            to_char(td.delivery_origin_time, 'yyyy') year,
                                            (to_date(to_char(td.delivery_origin_time, 'yyyy/mm/dd'),  'yyyy/mm/dd') -
                                            to_date(to_char(tf.order_create_date, 'yyyy/mm/dd'),  'yyyy/mm/dd')) sum1_date,
                                            ((tf.fixed_price * td.delivery_amount) /
                                              count(tf.product_gress_code) over(partition by tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyy'))) sum1,
                                            tf.fixed_price,
                                            td.delivery_amount
                              from flw_leader tf
                             inner join scmdata.t_delivery_record td
                                on td.order_code = tf.product_gress_code
                               and td.company_id = tf.company_id) x
                  on x.company_id = t5.company_id
                 and x.product_gress_code = t5.product_gress_code
                 where tor.isfirstordered = 0
              group by t5.company_id, x.year,t5.category, t5.group_name,x.follower_leader) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort  ]';
   /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
    end;

    --5.统计维度：QC
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_year tka
  USING (
        with kpi_order as
   (select t.company_id, t.year, t.category, (case when t.group_name is null then '1' else t.group_name end)group_name, '07' count_dimension,
           (case when x.qc is null then '1' else x.qc end) dimension_sort, sum(x.sum1) order_money
      from scmdata.pt_ordered t
      inner join (select t1.company_id, t1.product_gress_code, t1.order_money,
                        (t1.order_money / count(t1.product_gress_code) over(partition by t1.product_gress_code)) sum1,
                        regexp_substr(t1.qc, '[^,]+', 1, level) qc
                   from scmdata.pt_ordered t1
                  --where t1.qc is not null
                 connect by prior t1.pt_ordered_id = t1.pt_ordered_id
                        and level <=  length(t1.qc) - length(regexp_replace(t1.qc, ',', '')) + 1
                        and prior dbms_random.value is not null) x
        on x.company_id = t.company_id
       and x.product_gress_code = t.product_gress_code
     group by t.company_id, t.year,  t.category, t.group_name,x.qc),
  flw_leader as
 (select t.company_id, t.product_gress_code,t.fixed_price,t.order_create_date,
         (t.order_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum1,
         (t.satisfy_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum2,
         regexp_substr(t.qc, '[^,]+', 1, level) qc
    from scmdata.pt_ordered t
   --where t.qc is not null
 connect by prior t.pt_ordered_id = t.pt_ordered_id
        and level <= length(t.qc) - length(regexp_replace(t.qc, ',', '')) + 1
        and prior dbms_random.value is not null)
 select k.company_id,k.year, k.category, k.group_name,k.count_dimension,k.dimension_sort,k.order_money,z.sho_order_money,
        z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id,  tp.year,tp.category, tp.group_name,
                     '07' count_dimension,(case when tp.qc is null then '1' else tp.qc end) dimension_sort, sum(tp.sum2) sho_order_money
                from (select t3.company_id, t3.year,(case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category, x.qc, x.sum2
                        from scmdata.pt_ordered t3
                        inner join flw_leader x
                          on x.company_id = t3.company_id
                         and x.product_gress_code = t3.product_gress_code
                      union all
                      select t3a.company_id, t3a.year,(case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category, x.qc, (x.sum1- x.sum2) sum_money
                        from scmdata.pt_ordered t3a
                        inner join flw_leader x
                          on x.company_id = t3a.company_id
                         and x.product_gress_code = t3a.product_gress_code
                       left join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%'  or a.dept_name like '%财务部%'
                                or a.dept_name like '%事业部%' or a.dept_name = '无')
                      union all
                      select t3a.company_id, t3a.year,(case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category, x.qc, (x.sum1- x.sum2) sum_money
                        from scmdata.pt_ordered t3a
                        inner join flw_leader x
                          on x.company_id = t3a.company_id
                         and x.product_gress_code = t3a.product_gress_code
                       where t3a.responsible_dept = 'b550778b4f2b36b4e0533c281caca074' /*责任部门1级：供应链管理部*/
                         and t3a.responsible_dept_sec in ('DP2203124299047457','b550778b4f4336b4e0533c281caca074',
                             'b550778b4f4836b4e0533c281caca074','b550778b4f3e36b4e0533c281caca074')/*责任部门2级：直播2部、QA组、面料管控部、工艺组*/ ) tp
               group by tp.company_id, tp.year, tp.category, tp.group_name, tp.qc) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select t3.company_id, t3.year,(case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category,
                     '07' count_dimension,(case when x.qc is null then '1' else x.qc end) dimension_sort, sum(x.sum2)sho_order_original_money
                from scmdata.pt_ordered t3
               inner join flw_leader x
                  on x.company_id = t3.company_id
                 and x.product_gress_code = t3.product_gress_code
               group by t3.company_id, t3.year, t3.group_name, t3.category, x.qc) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort ]';
--补货平均交期指标
      V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_year tka
  USING (
        with flw_leader as
 (select t.company_id, t.product_gress_code,t.fixed_price,t.order_create_date,
         (t.order_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum1,
         (t.satisfy_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum2,
         regexp_substr(t.qc, '[^,]+', 1, level) qc
    from scmdata.pt_ordered t
   --where t.qc is not null
 connect by prior t.pt_ordered_id = t.pt_ordered_id
        and level <= length(t.qc) - length(regexp_replace(t.qc, ',', '')) + 1
        and prior dbms_random.value is not null)
select k.company_id, k.year, k.category, k.group_name, k.count_dimension, k.dimension_sort,
       k.delivery_money, qa.delivery_order_money
   from  (select t2.company_id, x.year,t2.category,(case when t2.group_name is null then '1' else t2.group_name end)group_name, '07' count_dimension,
                      (case when x.qc is null then '1' else x.qc end) dimension_sort, sum(sum1) delivery_money
                from scmdata.pt_ordered t2
                inner join (select distinct tf.company_id,tf.qc,
                                  tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyy') year,
                                  ((tf.fixed_price * td.delivery_amount)/
count(tf.product_gress_code) over(partition by tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyy'))) sum1
                             from flw_leader tf
                            inner join scmdata.t_delivery_record td
                               on td.order_code = tf.product_gress_code
                              and td.company_id = tf.company_id) x
                  on x.company_id = t2.company_id
                 and x.product_gress_code = t2.product_gress_code
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id,x.year, t2.group_name, t2.category, x.qc) k
   left join (select t5.company_id, x.year,t5.category, (case when t5.group_name is null then '1' else t5.group_name end)group_name, '07' count_dimension,
                     (case when x.qc is null then '1' else x.qc end) dimension_sort, sum(x.sum1_date * x.sum1) delivery_order_money
                from scmdata.pt_ordered t5
               inner join scmdata.t_ordered tor
                  on tor.company_id = t5.company_id
                 and tor.order_code = t5.product_gress_code
                 and tor.is_product_order = '1'
               inner join (select distinct tf.company_id,
                                            tf.qc,
                                            tf.product_gress_code,
                                            to_char(td.delivery_origin_time, 'yyyy') year,
                                            (to_date(to_char(td.delivery_origin_time, 'yyyy/mm/dd'),  'yyyy/mm/dd') -
                                            to_date(to_char(tf.order_create_date, 'yyyy/mm/dd'),  'yyyy/mm/dd')) sum1_date,
                                            ((tf.fixed_price * td.delivery_amount)/
                                              count(tf.product_gress_code) over(partition by tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyy'))) sum1,
                                            tf.fixed_price,
                                            td.delivery_amount
                              from flw_leader tf
                             inner join scmdata.t_delivery_record td
                                on td.order_code = tf.product_gress_code
                               and td.company_id = tf.company_id) x
                  on x.company_id = t5.company_id
                 and x.product_gress_code = t5.product_gress_code
                 where tor.isfirstordered = 0
              group by t5.company_id, x.year,t5.category, t5.group_name,x.qc) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort ]';
   /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
    end;

    --9.统计维度：QC主管
    BEGIN
--订单满足率指标
      V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpi_year tka
  USING (
        with kpi_order as
   (select t.company_id, t.year, t.category, (case when t.group_name is null then '1' else t.group_name end)group_name, '08' count_dimension,
           (case when x.qc_manager is null then '1' else x.qc_manager end) dimension_sort, sum(x.sum1) order_money
      from scmdata.pt_ordered t
     inner join (select t1.company_id, t1.product_gress_code, t1.order_money,
                        (t1.order_money / count(t1.product_gress_code) over(partition by t1.product_gress_code)) sum1,
                        regexp_substr(t1.qc_manager, '[^,]+', 1, level) qc_manager
                   from scmdata.pt_ordered t1
                  --where t1.qc_manager is not null
                 connect by prior t1.pt_ordered_id = t1.pt_ordered_id
                        and level <=  length(t1.qc_manager) - length(regexp_replace(t1.qc_manager, ',', '')) + 1
                        and prior dbms_random.value is not null) x
        on x.company_id = t.company_id
       and x.product_gress_code = t.product_gress_code
     group by t.company_id, t.year, t.category, t.group_name,x.qc_manager),
  flw_leader as
 (select t.company_id, t.product_gress_code,t.fixed_price,t.order_create_date,
         (t.order_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum1,
         (t.satisfy_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum2,
         regexp_substr(t.qc_manager, '[^,]+', 1, level) qc_manager
    from scmdata.pt_ordered t
  -- where t.qc_manager is not null
 connect by prior t.pt_ordered_id = t.pt_ordered_id
        and level <= length(t.qc_manager) - length(regexp_replace(t.qc_manager, ',', '')) + 1
        and prior dbms_random.value is not null)
 select k.company_id,k.year,  k.category, k.group_name,k.count_dimension,k.dimension_sort,k.order_money,z.sho_order_money,
        z1.sho_order_original_money
   from kpi_order k
   left join (select tp.company_id,tp.year,tp.category, tp.group_name,
                     '08' count_dimension, (case when tp.qc_manager is null then '1' else tp.qc_manager end) dimension_sort, sum(tp.sum2) sho_order_money
                from (select t3.company_id, t3.year, (case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category, x.qc_manager, x.sum2
                        from scmdata.pt_ordered t3
                        inner join flw_leader x
                          on x.company_id = t3.company_id
                         and x.product_gress_code = t3.product_gress_code
                      union all
                      select t3a.company_id, t3a.year,(case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category, x.qc_manager, (x.sum1- x.sum2) sum_money
                        from scmdata.pt_ordered t3a
                        inner join flw_leader x
                          on x.company_id = t3a.company_id
                         and x.product_gress_code = t3a.product_gress_code
                       left join scmdata.sys_company_dept a
                          on a.company_id = t3a.company_id
                         and a.company_dept_id = t3a.responsible_dept
                         and a.pause = 0
                       where (a.dept_name like '%物流部%' or a.dept_name like '%品类部%' or a.dept_name like '%财务部%'
                              or a.dept_name like '%事业部%' or a.dept_name = '无')
                      union all
                      select t3a.company_id, t3a.year,(case when t3a.group_name is null then '1' else t3a.group_name end)group_name, t3a.category, x.qc_manager, (x.sum1- x.sum2) sum_money
                        from scmdata.pt_ordered t3a
                        inner join flw_leader x
                          on x.company_id = t3a.company_id
                         and x.product_gress_code = t3a.product_gress_code
                       where t3a.responsible_dept = 'b550778b4f2b36b4e0533c281caca074' /*责任部门1级：供应链管理部*/
                         and t3a.responsible_dept_sec in ('DP2203124299047457','b550778b4f4336b4e0533c281caca074',
                             'b550778b4f4836b4e0533c281caca074','b550778b4f3e36b4e0533c281caca074')/*责任部门2级：直播2部、QA组、面料管控部、工艺组*/ ) tp
               group by tp.company_id, tp.year,  tp.category, tp.group_name, tp.qc_manager) z
     on k.company_id = z.company_id
    and k.year = z.year
    and k.category = z.category
    and k.group_name = z.group_name
    and k.count_dimension = z.count_dimension
    and k.dimension_sort = z.dimension_sort
   left join (select t3.company_id, t3.year,(case when t3.group_name is null then '1' else t3.group_name end)group_name, t3.category,
                     '08' count_dimension, (case when x.qc_manager is null then '1' else x.qc_manager end) dimension_sort, sum(x.sum2)sho_order_original_money
                from scmdata.pt_ordered t3
               inner join flw_leader x
                  on x.company_id = t3.company_id
                 and x.product_gress_code = t3.product_gress_code
               group by t3.company_id, t3.year, t3.group_name, t3.category, x.qc_manager) z1
     on k.company_id = z1.company_id
    and k.year = z1.year
    and k.category = z1.category
    and k.group_name = z1.group_name
    and k.count_dimension = z1.count_dimension
    and k.dimension_sort = z1.dimension_sort  ]';
--补货平均交期指标
      V_Q1_SQL := q'[
  MERGE INTO scmdata.t_kpi_year tka
  USING (
        with flw_leader as
 (select t.company_id, t.product_gress_code,t.fixed_price,t.order_create_date,
         (t.order_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum1,
         (t.satisfy_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum2,
         regexp_substr(t.qc_manager, '[^,]+', 1, level) qc_manager
    from scmdata.pt_ordered t
  -- where t.qc_manager is not null
 connect by prior t.pt_ordered_id = t.pt_ordered_id
        and level <= length(t.qc_manager) - length(regexp_replace(t.qc_manager, ',', '')) + 1
        and prior dbms_random.value is not null)
select k.company_id, k.year, k.category, k.group_name, k.count_dimension, k.dimension_sort,
       k.delivery_money, qa.delivery_order_money
   from  (select t2.company_id, x.year, t2.category, (case when t2.group_name is null then '1' else t2.group_name end)group_name, '08' count_dimension,
                       (case when x.qc_manager is null then '1' else x.qc_manager end) dimension_sort, sum(sum1) delivery_money
                from scmdata.pt_ordered t2
                inner join (select distinct tf.company_id,tf.qc_manager,
                                  tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyy') year,
                                  ((tf.fixed_price * td.delivery_amount)/
count(tf.product_gress_code) over(partition by tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyy'))) sum1
                             from flw_leader tf
                            inner join scmdata.t_delivery_record td
                               on td.order_code = tf.product_gress_code
                              and td.company_id = tf.company_id) x
                  on x.company_id = t2.company_id
                 and x.product_gress_code = t2.product_gress_code
               inner join scmdata.t_ordered tor
                  on tor.order_code = t2.product_gress_code
                 and tor.company_id = t2.company_id
               where tor.isfirstordered = '0'
                 and tor.is_product_order = 1
               group by t2.company_id,x.year, t2.group_name, t2.category, x.qc_manager) k
   left join (select t5.company_id, x.year,t5.category, (case when t5.group_name is null then '1' else t5.group_name end)group_name, '08' count_dimension,
                      (case when x.qc_manager is null then '1' else x.qc_manager end) dimension_sort, sum(x.sum1_date * x.sum1) delivery_order_money
                from scmdata.pt_ordered t5
               inner join scmdata.t_ordered tor
                  on tor.company_id = t5.company_id
                 and tor.order_code = t5.product_gress_code
                 and tor.is_product_order = '1'
               inner join (select distinct tf.company_id,
                                            tf.qc_manager,
                                            tf.product_gress_code,
                                            to_char(td.delivery_origin_time, 'yyyy') year,
                                            (to_date(to_char(td.delivery_origin_time, 'yyyy/mm/dd'),  'yyyy/mm/dd') -
                                            to_date(to_char(tf.order_create_date, 'yyyy/mm/dd'),  'yyyy/mm/dd')) sum1_date,
                                            ((tf.fixed_price * td.delivery_amount)/
                                              count(tf.product_gress_code) over(partition by tf.product_gress_code,to_char(td.delivery_origin_time, 'yyyy'))) sum1,
                                            tf.fixed_price,
                                            td.delivery_amount
                              from flw_leader tf
                             inner join scmdata.t_delivery_record td
                                on td.order_code = tf.product_gress_code
                               and td.company_id = tf.company_id) x
                  on x.company_id = t5.company_id
                 and x.product_gress_code = t5.product_gress_code
                 where tor.isfirstordered = 0
              group by t5.company_id, x.year,t5.category, t5.group_name,x.qc_manager) qa
     on k.company_id = qa.company_id
    and k.year = qa.year
    and k.category = qa.category
    and k.group_name = qa.group_name
    and k.count_dimension = qa.count_dimension
    and k.dimension_sort = qa.dimension_sort  ]';
   /*   t_type = 0 更新全部指标
         t_type = 1 更新订单满足率指标
         t_type = 2 更新补货平均交期指标
    p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    if t_type = 0 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V_SQL;
      execute immediate V1_SQL;
    elsif t_type = 1 then
      if p_type = 0 then
        V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
      elsif p_type = 1 then
        V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
      end if;
      execute immediate V_SQL;
      elsif t_type = 2 then
      if p_type = 0 then
        V1_SQL := V_Q1_SQL || V_W_SQL || V_U1_SQL || V_IN1_SQL;
      elsif p_type = 1 then
        V1_SQL := V_Q1_SQL || V_W1_SQL || V_U1_SQL || V_IN1_SQL;
      end if;
      execute immediate V1_SQL;
    end if;
    end;
  END P_T_KPI_YEAR;

  --获取数据权限sql
  FUNCTION F_GET_DATAPRIVS_SQL(p_class_data_privs VARCHAR2,
                               p_pre              VARCHAR2 DEFAULT 't')
    RETURN CLOB IS
  BEGIN
    RETURN q'[ AND ((%is_company_admin%) = 1 OR instr_priv(p_str1 => ']' || p_class_data_privs || q'[', p_str2 => ]' || p_pre || q'[.category, p_split => ';') > 0) ]';
  END F_GET_DATAPRIVS_SQL;

  /*---------------------------------------------------------
   对象: F_KPI_160_SELECTSQL
   用途: 报表中心==>交期==>指标查询==>订单满足率页面
   参数解析
        KPI_TIMETYPE        查询时间类型
        KPI_TIME            查询统计时间
        KPI_DIMENSION       统计维度
        KPI_GROUP           区域组
        KPI_CATEGORY        分类
        P_CLASS_DATA_PRIVS  数据权限
        COMPANY_ID          公司id
   返回：订单满足率页面select_sql
   上线版本：2022-10-30
   -----------------------------------------------------------*/
  FUNCTION F_KPI_160_SELECTSQL(KPI_TIMETYPE       VARCHAR2,
                               KPI_TIME           VARCHAR2,
                               KPI_DIMENSION      VARCHAR2,
                               KPI_GROUP          VARCHAR2,
                               KPI_CATEGORY       VARCHAR2,
                               P_CLASS_DATA_PRIVS CLOB,
                               COMPANY_ID         VARCHAR2) RETURN CLOB IS

    VC_SQL       CLOB;
    VC_SQL1      clob;
    K_TIME       varchar2(128) := KPI_TIME;
    v_where      CLOB;
    v1_where     clob;
    v2_where     clob;
    v_b          clob;
    v_b2         clob;
    v_s          clob;
    v_s1         clob;
    v_s2         clob;
    v_dimension  clob;
    v1_dimension clob;
    v2_dimension clob;
    v_sort       clob := '';
    v_group      clob;
    v_orderby    clob ;
  BEGIN
    ---汇总字段条件
    if K_TIME = '本月' then
      K_TIME := to_char(sysdate, 'yyyy-mm');
    end if;
    ---汇总主键
     v1_dimension := '{"COL_1":' || K_TIME || ',"COL_2":' || KPI_GROUP ||
                    ',"COL_3":' || KPI_CATEGORY || ' ,"COL_4":' ||
                    KPI_DIMENSION || ' }';
      ---拼接主键
      v2_dimension := '''{"COL_1":' || K_TIME || ',"COL_2":' || KPI_GROUP ||
                      ',"COL_3":' || KPI_CATEGORY || ' ,"COL_4":' ||
                      KPI_DIMENSION || ' ,"COL_5":''' ||
                      '|| t.dimension_sort' || '||'' }''';
    --统计维度
    if kpi_dimension = '00' THEN
      --统计维度：分类
      v1_where := ' and count_dimension = ''00''';
      if KPI_GROUP = '1' then
        v_dimension := ' ''全部'' area_group  , category_name,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time , category_name,category,count_dimension,dimension_sort,' ||
                       v2_dimension ;
      else
        v_dimension := ' area_group,category_name,'|| v2_dimension ||
                       ' pid ,';
        v_group     := ' group by total_time,area_group,category_name,count_dimension,dimension_sort,' ||
                       v2_dimension ;
      end if;
    elsif kpi_dimension = '01' THEN
      --统计维度：区域组
      v1_where := ' and count_dimension = ''01''';
      if KPI_CATEGORY = '1' then
        v_dimension := ' area_group ,''全部'' category_name,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time, area_group,count_dimension,dimension_sort,' ||
                       v2_dimension ;
      else
        v_dimension := ' area_group,category_name,' || v2_dimension ||
                       ' pid ,';
        v_group     := ' group by total_time,area_group, category_name,count_dimension,dimension_sort,' ||
                       v2_dimension ;
      end if;
    elsif kpi_dimension = '02' THEN
      --统计维度：款式名称
      v1_where := ' and count_dimension = ''02''';
      v_sort   := ' '' ''style_names, ';
  /*    ---拼接主键
      v2_dimension := '''{"COL_1":' || K_TIME || ',"COL_2":' || KPI_GROUP ||
                      ',"COL_3":' || KPI_CATEGORY || ' ,"COL_4":' ||
                      KPI_DIMENSION || ' ,"COL_5":''' ||
                      '|| t.dimension_sort' || '||'' }''';*/
      if KPI_CATEGORY = '1' and KPI_GROUP = '1' then
        v_dimension := ' ''全部'' area_group ,''全部'' category_name,dimension_sort style_names,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,dimension_sort,count_dimension,' ||
                       v2_dimension;
      elsif KPI_CATEGORY = '1' and KPI_GROUP <> '1' then
        v_dimension := ' area_group ,''全部'' category_name,dimension_sort style_names,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,area_group ,dimension_sort,count_dimension,' ||
                       v2_dimension;
      elsif KPI_CATEGORY <> '1' and KPI_GROUP = '1' then
        v_dimension := '''全部'' area_group ,category_name,dimension_sort style_names,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time ,category_name,dimension_sort,count_dimension,' ||
                       v2_dimension;
      else
        v_dimension := ' area_group ,category_name,dimension_sort style_names,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,area_group ,category_name,dimension_sort,count_dimension,' ||
                       v2_dimension;
      end if;
    elsif kpi_dimension = '03' THEN
      --统计维度：产品子类
      v1_where := ' and count_dimension = ''03''';
      v_sort   := ''' '' product_cate,'' ''samll_category,'' ''small_category_gd, ';
    /*  ---拼接主键
      v2_dimension := '''{"COL_1":' || K_TIME || ',"COL_2":' || KPI_GROUP ||
                      ',"COL_3":' || KPI_CATEGORY || ' ,"COL_4":' ||
                      KPI_DIMENSION || ' ,"COL_5":''' ||
                      '|| t.dimension_sort' || '||'' }''';*/
      if KPI_CATEGORY = '1' and KPI_GROUP = '1' then
        v_dimension := ' ''全部'' area_group ,''全部'' category_name,cate_category product_cate, samll_category,dimension_sort small_category_gd,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,samll_category,cate_category,count_dimension,dimension_sort,' ||
                       v2_dimension;
      elsif KPI_CATEGORY = '1' and KPI_GROUP <> '1' then
        v_dimension := ' area_group ,''全部'' category_name,cate_category product_cate, samll_category,dimension_sort small_category_gd,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,area_group ,cate_category,samll_category,count_dimension,dimension_sort,' ||
                       v2_dimension;
      elsif KPI_CATEGORY <> '1' and KPI_GROUP = '1' then
        v_dimension := '''全部'' area_group ,category_name,cate_category product_cate,  samll_category,dimension_sort small_category_gd,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time ,category_name,cate_category,samll_category,count_dimension,dimension_sort,' ||
                       v2_dimension;
      else
        v_dimension := ' area_group ,category_name,cate_category product_cate, samll_category,dimension_sort small_category_gd,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,area_group ,cate_category,category_name,samll_category,dimension_sort,count_dimension,' ||
                       v2_dimension;
      end if;
    elsif kpi_dimension = '04' THEN
      --统计维度：供应商
      v1_where := ' and count_dimension = ''04''';
      v_sort   := ''' ''supplier_code, '' ''supplier, ';
      /*---拼接主键
      v2_dimension := '''{"COL_1":' || K_TIME || ',"COL_2":' || KPI_GROUP ||
                      ',"COL_3":' || KPI_CATEGORY || ' ,"COL_4":' ||
                      KPI_DIMENSION || ' ,"COL_5":''' ||
                      '|| t.dimension_sort' || '||'' }''';*/
      if KPI_CATEGORY = '1' and KPI_GROUP = '1' then
        v_dimension := ' ''全部'' area_group ,''全部'' category_name, supplier_code,supplier,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,supplier_code,supplier,count_dimension,dimension_sort,' ||
                       v2_dimension;
      elsif KPI_CATEGORY = '1' and KPI_GROUP <> '1' then
        v_dimension := ' area_group ,''全部'' category_name, supplier_code, supplier,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,area_group ,supplier_code,supplier,count_dimension,dimension_sort,' ||
                       v2_dimension;
      elsif KPI_CATEGORY <> '1' and KPI_GROUP = '1' then
        v_dimension := '''全部'' area_group ,category_name, supplier_code, supplier,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time ,category_name,supplier_code,supplier,count_dimension,dimension_sort,' ||
                       v2_dimension;
      else
        v_dimension := ' area_group ,category_name, supplier_code,supplier,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,area_group ,category_name,supplier_code,supplier,count_dimension,dimension_sort,' ||
                       v2_dimension;
      end if;
    elsif kpi_dimension = '05' THEN
      --统计维度：生产工厂
      v1_where := ' and count_dimension = ''05''';
      v_sort   := ''' ''supplier_code, '' ''factory_company_name, ';
      /*---拼接主键
      v2_dimension := '''{"COL_1":' || K_TIME || ',"COL_2":' || KPI_GROUP ||
                      ',"COL_3":' || KPI_CATEGORY || ' ,"COL_4":' ||
                      KPI_DIMENSION || ' ,"COL_5":''' ||
                      '|| t.dimension_sort' || '||'' }''';*/
      if KPI_CATEGORY = '1' and KPI_GROUP = '1' then
        v_dimension := ' ''全部'' area_group ,''全部'' category_name, dimension_sort supplier_code,factory_company_name,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,dimension_sort,factory_company_name,count_dimension,dimension_sort,' ||
                       v2_dimension;
      elsif KPI_CATEGORY = '1' and KPI_GROUP <> '1' then
        v_dimension := ' area_group ,''全部'' category_name,dimension_sort supplier_code, factory_company_name,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,area_group ,dimension_sort,factory_company_name,count_dimension,dimension_sort,' ||
                       v2_dimension;
      elsif KPI_CATEGORY <> '1' and KPI_GROUP = '1' then
        v_dimension := '''全部'' area_group ,category_name,dimension_sort supplier_code, factory_company_name,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time ,category_name,dimension_sort,factory_company_name,count_dimension,dimension_sort,' ||
                       v2_dimension;
      else
        v_dimension := ' area_group ,category_name, dimension_sort supplier_code,factory_company_name,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,area_group ,category_name,dimension_sort,factory_company_name,count_dimension,dimension_sort,' ||
                       v2_dimension;
      end if;
    elsif kpi_dimension = '06' THEN
      --统计维度：跟单
      v1_where := ' and count_dimension = ''06''';
      v_sort   := ''' ''flw_order, ';
      /*---拼接主键
      v2_dimension := '''{"COL_1":' || K_TIME || ',"COL_2":' || KPI_GROUP ||
                      ',"COL_3":' || KPI_CATEGORY || ' ,"COL_4":' ||
                      KPI_DIMENSION || ' ,"COL_5":''' || '|| t.dimension_sort' ||
                      '||'' }''';*/
      if KPI_CATEGORY = '1' and KPI_GROUP = '1' then
        v_dimension := ' ''全部'' area_group ,''全部'' category_name, flw_order,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,flw_order,count_dimension,dimension_sort,' ||
                       v2_dimension;
      elsif KPI_CATEGORY = '1' and KPI_GROUP <> '1' then
        v_dimension := ' area_group ,''全部'' category_name,flw_order,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,area_group ,flw_order,count_dimension,dimension_sort,' ||
                       v2_dimension;
      elsif KPI_CATEGORY <> '1' and KPI_GROUP = '1' then
        v_dimension := '''全部'' area_group ,category_name,flw_order,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,category_name,flw_order,count_dimension,dimension_sort,' ||
                       v2_dimension;
      else
        v_dimension := ' area_group ,category_name, flw_order,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,area_group ,category_name,flw_order,count_dimension,dimension_sort,' ||
                       v2_dimension;
      end if;
    elsif kpi_dimension = '07' THEN
      --统计维度：QC
      v1_where := ' and count_dimension = ''07''';
      v_sort   := ''' ''qc, ';
    /*  ---拼接主键
      v2_dimension := '''{"COL_1":' || K_TIME || ',"COL_2":' || KPI_GROUP ||
                      ',"COL_3":' || KPI_CATEGORY || ' ,"COL_4":' ||
                      KPI_DIMENSION || ' ,"COL_5":''' || '|| t.dimension_sort' ||
                      '||'' }''';*/
      if KPI_CATEGORY = '1' and KPI_GROUP = '1' then
        v_dimension := ' ''全部'' area_group ,''全部'' category_name, qc,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,qc,count_dimension,dimension_sort,' ||
                       v2_dimension;
      elsif KPI_CATEGORY = '1' and KPI_GROUP <> '1' then
        v_dimension := ' area_group ,''全部'' category_name,qc,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,area_group ,qc,count_dimension,dimension_sort,' ||
                       v2_dimension;
      elsif KPI_CATEGORY <> '1' and KPI_GROUP = '1' then
        v_dimension := '''全部'' area_group ,category_name,qc,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,category_name,qc,count_dimension,dimension_sort,' ||
                       v2_dimension;
      else
        v_dimension := ' area_group ,category_name, qc,' || v2_dimension ||
                       ' pid ,';
        v_group     := ' group by total_time,area_group ,category_name,qc,count_dimension,dimension_sort,' ||
                       v2_dimension;
      end if;
    elsif kpi_dimension = '08' THEN
      --统计维度：QC主管
      v1_where := ' and count_dimension = ''08''';
      v_sort   := ''' ''qc_leader, ';
    /*  ---拼接主键
      v2_dimension := '''{"COL_1":' || K_TIME || ',"COL_2":' || KPI_GROUP ||
                      ',"COL_3":' || KPI_CATEGORY || ' ,"COL_4":' ||
                      KPI_DIMENSION || ' ,"COL_5":''' || '|| t.dimension_sort' ||
                      '||'' }''';*/
      if KPI_CATEGORY = '1' and KPI_GROUP = '1' then
        v_dimension := ' ''全部'' area_group ,''全部'' category_name, qc_leader,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,qc_leader,count_dimension,dimension_sort,' ||
                       v2_dimension;
      elsif KPI_CATEGORY = '1' and KPI_GROUP <> '1' then
        v_dimension := ' area_group ,''全部'' category_name,qc_leader,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,area_group ,qc_leader,count_dimension,dimension_sort,' ||
                       v2_dimension;
      elsif KPI_CATEGORY <> '1' and KPI_GROUP = '1' then
        v_dimension := '''全部'' area_group ,category_name,qc_leader,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,category_name,qc_leader,count_dimension,dimension_sort,' ||
                       v2_dimension;
      else
        v_dimension := ' area_group ,category_name, qc_leader,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,area_group ,category_name,flw_order,count_dimension,dimension_sort,' ||
                       v2_dimension;
      end if;
    end if;
    --过滤条件：分部
    CASE
      WHEN KPI_CATEGORY = '1' THEN
        v1_where := v1_where || ' AND 1 = 1 ';

      ELSE
        v1_where := v1_where || ' AND category = ''' || KPI_CATEGORY ||
                    ''' ';
    END CASE;
    --过滤条件：区域组
    CASE
      WHEN KPI_GROUP = '1' THEN
        v1_where := v1_where || ' AND 1 = 1 ';

      ELSE
        v1_where := v1_where || ' AND groupname = ''' || KPI_GROUP || ''' ';
    END CASE;

    --字段
    v_s2 := '  a.group_dict_name category_name,
       t.category,
       t.groupname,
       ts.group_name area_group,
       t.count_dimension,
       t.dimension_sort,
       samll.samll_category,
       samll.cate_category,
       tsup.supplier_code,
       tsup.supplier_company_name  supplier,
       tf.supplier_company_name factory_company_name,
       fel.company_user_name flw_order,
       q.company_user_name qc,
       q1.company_user_name qc_leader,
       t.order_money,
       t.sho_order_money,
       t.sho_order_original_money ';
    --表关联
    v_b2 := q'[inner join scmdata.sys_group_dict a
            on a.group_dict_type = 'PRODUCT_TYPE'
           and a.group_dict_value = t.category
          left join scmdata.t_supplier_group_config ts
            on ts.group_config_id = t.groupname
          left join (select distinct c.group_dict_value,c1.group_dict_name cate_category,
                                    cd.company_dict_value,
                                    cd.company_dict_name samll_category
                      from scmdata.sys_group_dict c
                     inner join scmdata.sys_group_dict c1
                        on c1.group_dict_type = c.group_dict_value
                     inner join scmdata.sys_company_dict cd
                        on cd.company_dict_type = c1.group_dict_value
                       and cd.company_id = %default_company_id%
                     where c.group_dict_type = 'PRODUCT_TYPE') samll
            on samll.group_dict_value = t.category
           and samll.company_dict_value = t.dimension_sort
           and t.count_dimension = '03'
          left join scmdata.t_supplier_info tsup
            on tsup.company_id = t.company_id
           and tsup.inside_supplier_code = t.dimension_sort
           and t.count_dimension = '04'
          left join scmdata.t_supplier_info tf
            on tf.company_id = t.company_id
           and tf.supplier_code = t.dimension_sort
           and t.count_dimension = '05'
          left join scmdata.sys_company_user fel
            on fel.company_id = t.company_id
           and fel.user_id = t.dimension_sort
           and t.count_dimension = '06'
          left join scmdata.sys_company_user q
            on q.company_id = t.company_id
           and q.user_id = t.dimension_sort
           and t.count_dimension = '07'
          left join scmdata.sys_company_user q1 --qc_leader
            on q1.company_id = t.company_id
           and q1.user_id = t.dimension_sort
           and t.count_dimension = '08'
         where t.order_money is not null
           and t.company_id = ']' || COMPANY_ID || ''' ' ||
            scmdata.pkg_kpipt_order.f_get_dataprivs_sql(p_class_data_privs => P_CLASS_DATA_PRIVS,
                                                        p_pre              => 't') ||
            v1_where || '   order by  dimension_sort )t';
    --过滤条件：时间
    if KPI_TIME = '本月' then
      v_where := ' where total_time2 = to_char(sysdate,''yyyy-mm'')';
    else
      v_where := ' where total_time = ''' || K_TIME || ''' ';
    end if;

  v_orderby := ' order by dimension_sort nulls first ,area_group nulls first ,category_name nulls first';
    --时间维度
    IF KPI_TIMETYPE = '本月' then
      v_b := ' from scmdata.t_kpi_thismonth t ';
/*      v_s1 := 'to_char(t.kpi_date,''yyyy-mm'') ';*/
      v_s1 := ' to_char(t.kpi_date,''yyyy-mm'') total_time2, ''本月'' ';
      v_s  := ' select ' || v_s1 || ' total_time,' || v_s2 || v_b || v_b2 ||
              v_where || v_group || v_orderby;
    elsif KPI_TIMETYPE = '月度' then
      v_b  := ' from scmdata.t_kpi_month t ';
      v_s1 := '(t.year || ''年'' || lpad(t.month, 2, 0) || ''月'')';
      v_s  := ' select ' || v_s1 || ' total_time,' || v_s2 || v_b || v_b2 ||
              v_where || v_group || v_orderby;
    elsif KPI_TIMETYPE = '季度' then
      v_b  := ' from scmdata.t_kpi_quarter t ';
      v_s1 := '(t.year || ''年第'' || t.quarter || ''季度'')';
      v_s  := ' select ' || v_s1 || ' total_time,' || v_s2 || v_b || v_b2 ||
              v_where || v_group || v_orderby;
    elsif KPI_TIMETYPE = '半年度' then
      v_b  := ' from scmdata.t_kpi_halfyear t ';
      v_s1 := '(t.year || ''年'' || decode(t.halfyear,1,''上'',2,''下'') || ''半年'' )';
      v_s  := ' select ' || v_s1 || ' total_time,' || v_s2 || v_b || v_b2 ||
              v_where || v_group || v_orderby;
    elsif KPI_TIMETYPE = '年度' then
      v_b  := ' from scmdata.t_kpi_year t ';
      v_s1 := '(t.year || ''年'' )';
      v_s  := ' select ' || v_s1 || ' total_time,' || v_s2 || v_b || v_b2 ||
              v_where || v_group || v_orderby;
    end if;

    ---汇总字段条件
    if KPI_TIME = '本月' then
      v2_where := ' where to_char(t.kpi_date,''yyyy-mm'') = to_char(sysdate,''yyyy-mm'')  ' ||  v1_where;
    else
      v2_where := ' where ' || v_s1 || '= ''' || K_TIME || '''' || v1_where;
    end if;

    ---汇总语句
    VC_SQL1 := q'[select '汇总' total_time,
       ' ' area_group,
       ' ' category_name,
]' || v_sort ||''''||  v1_dimension || ''' pid, ''' ||
               q'[' count_dimension, ' ' dimension_sort, sum(t.sho_order_money )/ sum(nullif(t.order_money, 0)) performance_value,
       sum(t.sho_order_original_money) / sum(nullif(t.order_money, 0)) original_value,
       (sum(t.sho_order_money) / sum(nullif(t.order_money, 0)) -
       sum(t.sho_order_original_money) / sum(nullif(t.order_money, 0))) difference_value ]' || v_b ||
               v2_where ;
    ---返回sql
    VC_SQL := VC_SQL1 || q'[
union all
select total_time,
]' || v_dimension || q'[t.count_dimension,t.dimension_sort,sum(t.sho_order_money) / sum(nullif(t.order_money, 0)) performance_value,
       sum(t.sho_order_original_money) / sum(nullif(t.order_money, 0)) original_value,
       (sum(t.sho_order_money) / sum(nullif(t.order_money, 0)) -
       sum(t.sho_order_original_money) / sum(nullif(t.order_money, 0))) difference_value
  from ( ]' || v_s;

    RETURN VC_SQL;

  END F_KPI_160_SELECTSQL;
  /*---------------------------------------------------------
   对象: f_kpi_161_captionsql
   用途: 报表中心==>交期==>指标查询==>订单满足率页面==>查看差异值按钮跳转==>订单满足率责任部门差异分布动态表头
   参数解析
        v_string       订单满足率页面拼接主键
        v_id          公司id
   返回：订单满足率责任部门差异分布动态表头captionsql
   上线版本：2022-10-30
   -----------------------------------------------------------*/
 function f_kpi_161_captionsql(v_string varchar2,v_id varchar2) return clob is
   v_time      varchar2(32);
   v_group     varchar2(64);
   v1_group    varchar2(64);
   v_category  varchar2(32);
   v1_category varchar2(32);
   v_dimension varchar2(32);
   v_sort      varchar2(128);
   v1_sort      varchar2(128);
   v_sql       clob; --返回值
 begin
  v_time      := scmdata.parse_json(v_string, 'COL_1');--查询时间
  v_group     := scmdata.parse_json(v_string, 'COL_2');--区域组
  v_category  := scmdata.parse_json(v_string, 'COL_3');--分类
  v_dimension := scmdata.parse_json(v_string, 'COL_4');--统计维度
  v_sort      := scmdata.parse_json(v_string, 'COL_5');--维度分类
  if v_sort is null then
    if v_category = '1' then
      v1_category := '全部';
    else
      select t.group_dict_name
        into v1_category
        from scmdata.sys_group_dict t
       where t.group_dict_type = 'PRODUCT_TYPE'
         and t.group_dict_value = v_category;
    end if;
    if v_group = '1' then
      v1_group := '全部';
    else
      select ts.group_name
        into v1_group
        from scmdata.t_supplier_group_config ts
       where ts.group_config_id = v_group;
    end if;
  else
   if v_dimension = '00' then
    if v_group = '1' then
      v1_group := '全部';
    else
      select ts.group_name
        into v1_group
        from scmdata.t_supplier_group_config ts
       where ts.group_config_id = v_group;
    end if;
    if v_sort = '1' then
      v1_category := '全部';
    else
      select t.group_dict_name
        into v1_category
        from scmdata.sys_group_dict t
       where t.group_dict_type = 'PRODUCT_TYPE'
         and t.group_dict_value = v_sort;
    end if;
  elsif v_dimension = '01' then
    if v_category = '1' then
      v1_category := '全部';
    else
      select t.group_dict_name
        into v1_category
        from scmdata.sys_group_dict t
       where t.group_dict_type = 'PRODUCT_TYPE'
         and t.group_dict_value = v_category;
    end if;
    if v_sort = '1' then
      v1_group := '全部';
    else
      select ts.group_name
        into v1_group
        from scmdata.t_supplier_group_config ts
       where ts.group_config_id = v_sort;
    end if;
  elsif v_dimension not in ('00', '01') then
    if v_category = '1' then
      v1_category := '全部';
    else
      select t.group_dict_name
        into v1_category
        from scmdata.sys_group_dict t
       where t.group_dict_type = 'PRODUCT_TYPE'
         and t.group_dict_value = v_category;
    end if;
    if v_group = '1' then
      v1_group := '全部';
    else
      select ts.group_name
        into v1_group
        from scmdata.t_supplier_group_config ts
       where ts.group_config_id = v_group;
    end if;
  end if;
end if;
  if v_dimension = '02' then
    --统计维度：款式名称
    v1_sort := v_sort;
  elsif v_dimension = '03' then
    --统计维度：产品子类
    select max(cd.company_dict_name) samll_category
      into v1_sort
      from scmdata.sys_group_dict c
     inner join scmdata.sys_group_dict c1
        on c1.group_dict_type = c.group_dict_value
     inner join scmdata.sys_company_dict cd
        on cd.company_dict_type = c1.group_dict_value
       and cd.company_id = v_id
     where c.group_dict_type = 'PRODUCT_TYPE'
       and cd.company_dict_value = v_sort;
  elsif v_dimension = '04' then
    --统计维度：供应商
    select max(t.supplier_company_abbreviation)
      into v1_sort
      from scmdata.t_supplier_info t
     where t.inside_supplier_code = v_sort
       and t.company_id = v_id;
  elsif v_dimension = '05' then
    --统计维度：生产工厂
    select max(t.supplier_company_abbreviation)
      into v1_sort
      from scmdata.t_supplier_info t
     where t.supplier_code = v_sort
       and t.company_id = v_id;
  elsif v_dimension in ('06', '07', '08') then
    --统计维度：跟单/QC/QC主管
    select max(f.company_user_name)
      into v1_sort
      from scmdata.sys_company_user f
     where f.user_id = v_sort
       and f.company_id = v_id;
  end if;
  if  v_sort is null then
    if v_group = '1' and v_category = '1' then
      v_sql := 'select ''' || v_time || ' 订单满足率责任部门分布'' from dual';
    elsif v_group = '1' and v_category <> '1' then
      v_sql := 'select ''' || v1_category || ',' || v_time || ' 订单满足率责任部门分布'' from dual';
    elsif v_group <> '1' and v_category = '1' then
      v_sql := 'select ''' || v1_group || ',' || v_time || ' 订单满足率责任部门分布'' from dual';
    elsif v_group <> '1' and v_category <> '1' then
      v_sql := 'select ''' || v1_group || ',' || v1_category || ',' || v_time || ' 订单满足率责任部门分布'' from dual';
    end if;
  elsif v1_sort is null and v_dimension = '06' then
    if v_group = '1' and v_category = '1' then
      v_sql := 'select ''' || v_time || '跟单为空 订单满足率责任部门分布'' from dual';
    elsif v_group = '1' and v_category <> '1' then
      v_sql := 'select ''' || v1_category || ',' || v_time || '跟单为空 订单满足率责任部门分布'' from dual';
    elsif v_group <> '1' and v_category = '1' then
      v_sql := 'select ''' || v1_group || ',' || v_time || '跟单为空 订单满足率责任部门分布'' from dual';
    elsif v_group <> '1' and v_category <> '1' then
      v_sql := 'select ''' || v1_group || ',' || v1_category || ',' || v_time || '跟单为空 订单满足率责任部门分布'' from dual';
    end if;
  elsif v1_sort is null and v_dimension = '07' then
    if v_group = '1' and v_category = '1' then
      v_sql := 'select ''' || v_time || ' QC为空 订单满足率责任部门分布'' from dual';
    elsif v_group = '1' and v_category <> '1' then
      v_sql := 'select ''' || v1_category || ',' || v_time || ' QC为空 订单满足率责任部门分布'' from dual';
    elsif v_group <> '1' and v_category = '1' then
      v_sql := 'select ''' || v1_group || ',' || v_time || ' QC为空 订单满足率责任部门分布'' from dual';
    elsif v_group <> '1' and v_category <> '1' then
      v_sql := 'select ''' || v1_group || ',' || v1_category || ',' || v_time || ' qc为空 订单满足率责任部门分布'' from dual';
    end if;
  elsif v1_sort is null and v_dimension = '08' then
    if v_group = '1' and v_category = '1' then
      v_sql := 'select ''' || v_time || ' QC主管为空 订单满足率责任部门分布'' from dual';
    elsif v_group = '1' and v_category <> '1' then
      v_sql := 'select ''' || v1_category || ',' || v_time || ' QC主管为空 订单满足率责任部门分布'' from dual';
    elsif v_group <> '1' and v_category = '1' then
      v_sql := 'select ''' || v1_group || ',' || v_time || ' QC主管为空 订单满足率责任部门分布'' from dual';
    elsif v_group <> '1' and v_category <> '1' then
      v_sql := 'select ''' || v1_group || ',' || v1_category || ',' || v_time || ' QC主管为空 订单满足率责任部门分布'' from dual';
    end if;
  elsif v_dimension = '00' then
    if v_group = '1'  then
      v_sql := 'select ''' || v1_category || ',' || v_time || ' 订单满足率责任部门分布'' from dual';
    else
      v_sql := 'select ''' || v1_group || ',' || v1_category || ',' || v_time || ' 订单满足率责任部门分布'' from dual';
    end if;
  elsif v_dimension = '01' then
    if  v_category = '1' then
      v_sql := 'select ''' || v1_group || ',' || v_time || ' 订单满足率责任部门分布'' from dual';
    else
      v_sql := 'select ''' || v1_group || ',' || v1_category || ',' ||
                v_time || ' 订单满足率责任部门分布'' from dual';
    end if;
  else
    if v_group = '1' and v_category = '1' then
      v_sql := 'select ''' || v1_sort || ',' || v_time || ' 订单满足率责任部门分布'' from dual';
    elsif v_group = '1' and v_category <> '1' then
      v_sql := 'select ''' || v1_category || ',' || v1_sort || ',' ||
               v_time || ' 订单满足率责任部门分布'' from dual';
    elsif v_group <> '1' and v_category = '1' then
      v_sql := 'select ''' || v1_group || ',' || v1_sort || ',' ||
               v_time || ' 订单满足率责任部门分布'' from dual';
    elsif v_group <> '1' and v_category <> '1' then
      v_sql := 'select ''' || v1_group || ',' || v1_category || ',' ||
               v1_sort || ',' || v_time || ' 订单满足率责任部门分布'' from dual';
    end if;
  end if;
   return v_sql;
 end f_kpi_161_captionsql;

  /*---------------------------------------------------------
   对象: F_KPI_161_SELECTSQL
   用途: 报表中心==>交期==>指标查询==>订单满足率页面==>查看差异值按钮跳转==>订单满足率责任部门差异分布图表
   参数解析
        KPI_TIMETYPE        查询时间类型
        KPI_TIME            查询统计时间
        KPI_DIMENSION       统计维度
        KPI_GROUP           区域组
        KPI_CATEGORY        分类
        P_CLASS_DATA_PRIVS  数据权限
        COMPANY_ID          公司id
   返回：订单满足率责任部门差异分布select_sql
   上线版本：2022-10-30
   -----------------------------------------------------------*/
  FUNCTION F_KPI_161_SELECTSQL(P_TIME       VARCHAR2,
                               P_DIMENSION  VARCHAR2,
                               P_SORT       VARCHAR2,
                               P_GROUP      VARCHAR2,
                               P_CATEGORY   VARCHAR2,
                               P_COMPANY_ID VARCHAR2) RETURN CLOB IS
    vc_sql clob;
    v_s    clob;
    v_s2   clob;
    v_s1   clob;
    v_f    clob;
    v_f2   clob  := ' ';
    v_f3   clob  := ' ';
    v_f4   clob  ;
    v_b    clob  := ' ';
    v_t3   clob  := ' ';
    v1_where clob;
    v2_where clob;
  BEGIN
    v1_where := 'where pt.company_id = ''' || p_company_id || '''';
    --统计维度
    if p_sort is null then
      if p_dimension in ('00','01') THEN
        --统计维度：分类
          --过滤条件：分类
            case
              when p_category = '1' then
                v1_where := v1_where || ' and 1 = 1 ';
              else
                v1_where := v1_where || ' and pt.category = ''' || p_category || ''' ';
            end case;
          --过滤条件：区域组
            case
              when p_group = '1' then
                v1_where := v1_where || ' and 1 = 1 ';
              else
                v1_where := v1_where || ' and pt.group_name = ''' || p_group || ''' ';
            end case;
      else
       v1_where := v1_where;
      end if;
    else
      if p_dimension = '00' THEN
        --统计维度：分类
          --过滤条件：分类
            v1_where := v1_where || ' and pt.category = ''' || p_sort || ''' ';
          --过滤条件：区域组
            case
              when p_group = '1' then
                v1_where := v1_where || ' and 1 = 1 ';
              else
                v1_where := v1_where || ' and pt.group_name = ''' || p_group || ''' ';
            end case;
      elsif p_dimension = '01' THEN
        --统计维度：区域组
            --过滤条件：分类
            case
              when p_category = '1' then
                v1_where := v1_where || ' and 1 = 1 ';
              else
                v1_where := v1_where || ' and pt.category = ''' || p_category || ''' ';
            end case;
            --过滤条件：区域组
                v1_where := v1_where || ' and pt.group_name = ''' || p_sort || ''' ';
      elsif p_dimension = '02' THEN
        --统计维度：款式名称
        v1_where := v1_where || ' and pt.style_name = ''' || p_sort || '''';
      elsif p_dimension = '03' THEN
        --统计维度：产品子类
        v1_where := v1_where || ' and pt.samll_category = ''' || p_sort || '''';
      elsif p_dimension = '04' THEN
        --统计维度：供应商
        v1_where := v1_where || ' and pt.supplier_code = ''' || p_sort || '''';
      elsif p_dimension = '05' THEN
        --统计维度：生产工厂
        v1_where := v1_where || ' and pt.factory_code = ''' || p_sort || '''';
      elsif p_dimension = '06' THEN
        --统计维度：跟单
       if p_sort = '1' then
        v1_where := v1_where || ' and f1.follower_leader is null ';
         else
        v1_where := v1_where || ' and f1.follower_leader = ''' || p_sort || '''';
       end if;
      elsif p_dimension = '07' THEN
        --统计维度：QC
       if p_sort = '1' then
        v1_where := v1_where || ' and q1.qc is null ';
         else
        v1_where := v1_where || ' and q1.qc = ''' || p_sort || '''';
       end if;
      elsif p_dimension = '08' THEN
        --统计维度：QC主管
       if p_sort = '1' then
        v1_where := v1_where || ' and q2.qc_manager is null ';
         else
        v1_where := v1_where || ' and q2.qc_manager = ''' || p_sort || '''';
       end if;
      end if;
    end if;
--跟单、QC、QC主管
    if p_dimension = '06' THEN
        v_f3 := ' f1.follower_leader, ';
        v_t3 := ' ,f1.follower_leader ';
        v_f4 := q'[  left join (select t.company_id,t.pt_ordered_id, t.product_gress_code,
                   (t.order_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum1,
                   (t.satisfy_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum2,
                    regexp_substr(t.flw_order, '[^,]+', 1, level) follower_leader
               from scmdata.pt_ordered t
             connect by prior t.pt_ordered_id = t.pt_ordered_id
                    and level <= length(t.flw_order) - length(regexp_replace(t.flw_order, ',', '')) + 1
                    and prior dbms_random.value is not null) f1
    on f1.company_id = pt.company_id
   and f1.pt_ordered_id = pt.pt_ordered_id ]';
      elsif p_dimension = '07' THEN
        v_f3 := ' q1.qc ,';
        v_t3 := ' ,q1.qc ';
        v_f4 := q'[   left join (select t.company_id, t.pt_ordered_id, t.product_gress_code,
                   (t.order_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum1,
                   (t.satisfy_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum2,
                    regexp_substr(t.qc, '[^,]+', 1, level) qc
               from scmdata.pt_ordered t
             connect by prior t.pt_ordered_id = t.pt_ordered_id
                    and level <= length(t.qc) - length(regexp_replace(t.qc, ',', '')) + 1
                    and prior dbms_random.value is not null) q1
    on q1.company_id = pt.company_id
   and q1.pt_ordered_id = pt.pt_ordered_id ]';
      elsif p_dimension = '08' THEN
        v_f3 := ' q2.qc_manager ,';
        v_t3 := ' ,q2.qc_manager  ';
        v_f4 := q'[  left join (select t.company_id, t.pt_ordered_id, t.product_gress_code,
                   (t.order_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum1,
                   (t.satisfy_money / count(t.product_gress_code) over(partition by t.product_gress_code)) sum2,
                    regexp_substr(t.qc_manager, '[^,]+', 1, level) qc_manager
               from scmdata.pt_ordered t
             connect by prior t.pt_ordered_id = t.pt_ordered_id
                    and level <= length(t.qc_manager) -length(regexp_replace(t.qc_manager, ',', '')) + 1
                    and prior dbms_random.value is not null) q2
    on q2.company_id = pt.company_id
   and q2.pt_ordered_id = pt.pt_ordered_id ]';
    end if;

    if p_dimension not in ('00','01') then
         --过滤条件：分类
        case
          when p_category = '1' then
            v1_where := v1_where || ' and 1 = 1 ';
          else
            v1_where := v1_where || ' and pt.category = ''' || p_category || ''' ';
        end case;
        --过滤条件：区域组
        case
          when p_group = '1' then
            v1_where := v1_where || ' and 1 = 1 ';
          else
            v1_where := v1_where || ' and pt.group_name = ''' || p_group || ''' ';
        end case;
    end if;
    --时间维度
    if substr(p_time,5,1) = '-' then
      v_s1     := ' to_char(pt.delivery_date,''yyyy-mm'')';
      v_f2     := ' group by to_char(pt.delivery_date,''yyyy-mm''), pt.category_name, ts.group_name, pt.style_name, pt.samll_category,
          pt.supplier_code, pt.factory_code ' || v_t3;
      v1_where := v1_where || ' and to_char(pt.delivery_date,''yyyy-mm'') = to_char(sysdate,''yyyy-mm'')
                                and pt.delivery_date < trunc(sysdate,''dd'')';
    elsif substr(p_time, -1) = '月' then
      v_s1     := ' (pt.year || ''年'' || lpad(pt.month, 2, 0) || ''月'') ';
      v_f2     := ' group by pt.year, pt.month,  pt.category_name, ts.group_name, pt.style_name,pt.samll_category,
          pt.supplier_code, pt.factory_code ' || v_t3;
      v1_where := v1_where ||
                  ' and (pt.year || ''年'' || lpad(pt.month, 2, 0) || ''月'') = ''' ||
                  p_time || '''';
    elsif substr(p_time, -2) = '季度' then
      v_s1     := ' (pt.year || ''年第'' || pt.quarter || ''季度'')';
      v_f2     := ' group by pt.year, pt.quarter,  pt.category_name, ts.group_name, pt.style_name, pt.samll_category,
          pt.supplier_code, pt.factory_code '|| v_t3;
      v1_where := v1_where ||
                  ' and (pt.year || ''年第'' || pt.quarter || ''季度'') = ''' ||
                  p_time || '''';
    elsif substr(p_time, -2) = '半年' then
      v_s1     := ' (pt.year || ''年'' || decode(pt.quarter,1,''上'',2,''上'',3,''下'',4,''下'') || ''半年'') ';
      v_f2     := ' group by pt.year,decode(pt.quarter,1,''上'',2,''上'',3,''下'',4,''下''), pt.category_name, ts.group_name, pt.style_name, pt.samll_category,
          pt.supplier_code, pt.factory_code ' || v_t3;
      v1_where := v1_where || '
 and (pt.year || ''年'' || decode(pt.quarter,1,''上'',2,''上'',3,''下'',4,''下'') || ''半年'') = ''' ||
                  p_time || '''';
    elsif length(p_time) = '5' then
      v_s1     := ' (pt.year || ''年'' ) ';
      v_f2     := ' group by pt.year, pt.category_name, ts.group_name, pt.style_name, pt.samll_category,
          pt.supplier_code, pt.factory_code ' || v_t3;
      v1_where := v1_where || ' and (pt.year || ''年'' ) = ''' || p_time || '''';
    end if;
    v2_where := ' )';
    v_s  := q'[ select distinct total_time,responsible_dept,
      round( sum(sum_money)over (partition by total_time,responsible_dept)/sum(sum_money) over (partition by total_time)*100,2) sum_money
      from ( ]';
    v_s2 := ' select ' || v_s1 ||
            q'[ total_time, pt.category_name, ts.group_name, pt.style_name,pt.samll_category,
        pt.supplier_code, pt.factory_code, ]'|| v_f3 ;
    v_f  := q'[ from scmdata.pt_ordered pt
  left join scmdata.t_supplier_group_config ts
    on ts.group_config_id = pt.group_name  ]' ;

    v_b    := '  left join scmdata.sys_company_dept a
    on a.company_id = pt.company_id
   and a.company_dept_id = pt.responsible_dept
   and a.pause = 0 ';
--判断维度是否是跟单、qc、qc主管
  if p_dimension in ('06','07','08') then
    vc_sql := v_s || v_s2 ||
              ' sum(sum2) sum_money, ''满足订单'' responsible_dept ' || v_f || v_f4 ||
              v1_where || v_f2 || 'union all' || v_s2 ||
              'sum(sum1) - sum(sum2) sum_money,''供应链'' responsible_dept ' || v_f || v_f4 ||
              v1_where ||
              ' and (pt.responsible_dept = ''b550778b4f2b36b4e0533c281caca074'' or pt.responsible_dept is null) ' || v_f2 ||
              'union all' || v_s2 ||
              'sum(sum1) - sum(sum2) sum_money, ''品类部'' responsible_dept ' || v_f  || v_f4 || v_b ||
              v1_where ||
              ' and (a.dept_name like ''%品类部%'' or a.dept_name like ''%事业部%'') ' || v_f2 ||
              'union all' || v_s2 ||
              'sum(sum1) - sum(sum2) sum_money,''物流部'' responsible_dept ' || v_f  || v_f4 || v_b ||
              v1_where || ' and a.dept_name like ''%物流部%''  ' || v_f2 ||
              'union all' || v_s2 ||
              'sum(sum1) - sum(sum2) sum_money,''无'' responsible_dept ' || v_f || v_f4 || v_b ||
              v1_where || ' and a.dept_name =''无''  ' || v_f2 || v2_where;
  else
    vc_sql := v_s || v_s2 ||
              ' sum(pt.satisfy_money) sum_money, ''满足订单'' responsible_dept ' || v_f ||
              v1_where || v_f2 || 'union all' || v_s2 ||
              'sum(pt.order_money) - sum(pt.satisfy_money) sum_money,''供应链'' responsible_dept ' || v_f ||
              v1_where ||
              ' and (pt.responsible_dept = ''b550778b4f2b36b4e0533c281caca074'' or pt.responsible_dept is null) ' || v_f2 ||
              'union all' || v_s2 ||
              'sum(pt.order_money) - sum(pt.satisfy_money) sum_money, ''品类部'' responsible_dept ' || v_f || v_b ||
              v1_where ||
              ' and (a.dept_name like ''%品类部%'' or a.dept_name like ''%事业部%'') ' || v_f2 ||
              'union all' || v_s2 ||
              'sum(pt.order_money) - sum(pt.satisfy_money) sum_money,''物流部'' responsible_dept ' || v_f || v_b ||
              v1_where || ' and a.dept_name like ''%物流部%''  ' || v_f2 ||
              'union all' || v_s2 ||
              'sum(pt.order_money) - sum(pt.satisfy_money) sum_money,''无'' responsible_dept ' || v_f || v_b ||
              v1_where || ' and a.dept_name =''无''  ' || v_f2 || v2_where;
end if;

    RETURN vc_sql;
  END F_KPI_161_SELECTSQL;
  /*---------------------------------------------------------
   对象: f_kpi_162_captionsql
   用途: 报表中心==>交期==>指标查询==>订单满足率页面==>查看趋势按钮跳转==>订单满足率趋势图动态表头
   参数解析
        v_string       订单满足率页面拼接主键
        v_id          公司id
   返回：订单满足率趋势图动态表头captionsql
   上线版本：2022-10-30
   -----------------------------------------------------------*/
 function f_kpi_162_captionsql(v_string varchar2,v_id varchar2) return clob is
 --  v_time      varchar2(32);
   v_group     varchar2(64);
   v1_group    varchar2(64);
   v_category  varchar2(32);
   v1_category varchar2(32);
   v_dimension varchar2(32);
   v_sort      varchar2(128);
   v1_sort      varchar2(128);
   v_sql       clob; --返回值
 begin
  -- v_time      := scmdata.parse_json(v_string, 'COL_1');
   v_group     := scmdata.parse_json(v_string, 'COL_2');
   v_category  := scmdata.parse_json(v_string, 'COL_3');
   v_dimension := scmdata.parse_json(v_string, 'COL_4');
   v_sort      := scmdata.parse_json(v_string, 'COL_5');
  if v_sort is null then
    if v_category = '1' then
      v1_category := '全部';
    else
      select t.group_dict_name
        into v1_category
        from scmdata.sys_group_dict t
       where t.group_dict_type = 'PRODUCT_TYPE'
         and t.group_dict_value = v_category;
    end if;
    if v_group = '1' then
      v1_group := '全部';
    else
      select ts.group_name
        into v1_group
        from scmdata.t_supplier_group_config ts
       where ts.group_config_id = v_group;
    end if;
  else
   if v_dimension = '00' then
    if v_group = '1' then
      v1_group := '全部';
    else
      select ts.group_name
        into v1_group
        from scmdata.t_supplier_group_config ts
       where ts.group_config_id = v_group;
    end if;
    if v_sort = '1' then
      v1_category := '全部';
    else
      select t.group_dict_name
        into v1_category
        from scmdata.sys_group_dict t
       where t.group_dict_type = 'PRODUCT_TYPE'
         and t.group_dict_value = v_sort;
    end if;
  elsif v_dimension = '01' then
    if v_category = '1' then
      v1_category := '全部';
    else
      select t.group_dict_name
        into v1_category
        from scmdata.sys_group_dict t
       where t.group_dict_type = 'PRODUCT_TYPE'
         and t.group_dict_value = v_category;
    end if;
    if v_sort = '1' then
      v1_group := '全部';
    else
      select ts.group_name
        into v1_group
        from scmdata.t_supplier_group_config ts
       where ts.group_config_id = v_sort;
    end if;
  elsif v_dimension not in ('00', '01') then
    if v_category = '1' then
      v1_category := '全部';
    else
      select t.group_dict_name
        into v1_category
        from scmdata.sys_group_dict t
       where t.group_dict_type = 'PRODUCT_TYPE'
         and t.group_dict_value = v_category;
    end if;
    if v_group = '1' then
      v1_group := '全部';
    else
      select ts.group_name
        into v1_group
        from scmdata.t_supplier_group_config ts
       where ts.group_config_id = v_group;
    end if;
  end if;
end if;
  if v_dimension = '02' then
    --统计维度：款式名称
    v1_sort := v_sort;
  elsif v_dimension = '03' then
    --统计维度：产品子类
    select max(cd.company_dict_name) samll_category
      into v1_sort
      from scmdata.sys_group_dict c
     inner join scmdata.sys_group_dict c1
        on c1.group_dict_type = c.group_dict_value
     inner join scmdata.sys_company_dict cd
        on cd.company_dict_type = c1.group_dict_value
       and cd.company_id = v_id
     where c.group_dict_type = 'PRODUCT_TYPE'
       and cd.company_dict_value = v_sort;
  elsif v_dimension = '04' then
    --统计维度：供应商
    select max(t.supplier_company_abbreviation)
      into v1_sort
      from scmdata.t_supplier_info t
     where t.inside_supplier_code = v_sort
       and t.company_id = v_id;
  elsif v_dimension = '05' then
    --统计维度：生产工厂
    select max(t.supplier_company_abbreviation)
      into v1_sort
      from scmdata.t_supplier_info t
     where t.supplier_code = v_sort
       and t.company_id = v_id;
  elsif v_dimension in ('06', '07', '08') then
    --统计维度：跟单/QC/QC主管
    select max(f.company_user_name)
      into v1_sort
      from scmdata.sys_company_user f
     where f.user_id = v_sort
       and f.company_id = v_id;
  end if;
  if v_sort is null then
    if v_group = '1' and v_category = '1' then
      v_sql := 'select ''' ||  ' 订单满足率趋势图'' from dual';
    elsif v_group = '1' and v_category <> '1' then
      v_sql := 'select ''' || v1_category ||  ' 订单满足率趋势图'' from dual';
    elsif v_group <> '1' and v_category = '1' then
      v_sql := 'select ' || v1_group || ' 订单满足率趋势图'' from dual';
    elsif v_group <> '1' and v_category <> '1' then
      v_sql := 'select ''' || v1_group || ',' || v1_category || ' 订单满足率趋势图'' from dual';
    end if;
  elsif v1_sort is null and v_dimension = '06' then
    if v_group = '1' and v_category = '1' then
      v_sql := 'select ''' ||  ' 跟单为空 订单满足率趋势图'' from dual';
    elsif v_group = '1' and v_category <> '1' then
      v_sql := 'select ''' || v1_category ||  ' 跟单为空 订单满足率趋势图'' from dual';
    elsif v_group <> '1' and v_category = '1' then
      v_sql := 'select ' || v1_group || ' 跟单为空 订单满足率趋势图'' from dual';
    elsif v_group <> '1' and v_category <> '1' then
      v_sql := 'select ''' || v1_group || ',' || v1_category || ' 跟单为空 订单满足率趋势图'' from dual';
    end if;
  elsif v1_sort is null and v_dimension = '07' then
    if v_group = '1' and v_category = '1' then
      v_sql := 'select ''' ||  ' QC为空 订单满足率趋势图'' from dual';
    elsif v_group = '1' and v_category <> '1' then
      v_sql := 'select ''' || v1_category ||  ' QC为空 订单满足率趋势图'' from dual';
    elsif v_group <> '1' and v_category = '1' then
      v_sql := 'select ' || v1_group || ' QC为空 订单满足率趋势图'' from dual';
    elsif v_group <> '1' and v_category <> '1' then
      v_sql := 'select ''' || v1_group || ',' || v1_category || ' QC为空 订单满足率趋势图'' from dual';
    end if;
  elsif v1_sort is null and v_dimension = '08' then
    if v_group = '1' and v_category = '1' then
      v_sql := 'select ''' ||  'QC主管为空 订单满足率趋势图'' from dual';
    elsif v_group = '1' and v_category <> '1' then
      v_sql := 'select ''' || v1_category ||  'QC主管为空 订单满足率趋势图'' from dual';
    elsif v_group <> '1' and v_category = '1' then
      v_sql := 'select ' || v1_group || 'QC主管为空 订单满足率趋势图'' from dual';
    elsif v_group <> '1' and v_category <> '1' then
      v_sql := 'select ''' || v1_group || ',' || v1_category || 'QC主管为空 订单满足率趋势图'' from dual';
    end if;
  elsif v_dimension = '00' then
    if v_group = '1'  then
      v_sql := 'select ''' || v1_category ||  ' 订单满足率趋势图'' from dual';
    else
      v_sql := 'select ''' || v1_group || ',' || v1_category  || ' 订单满足率趋势图'' from dual';
    end if;
  elsif v_dimension = '01' then
    if  v_category = '1' then
      v_sql := 'select ''' || v1_group || ' 订单满足率趋势图'' from dual';
    else
      v_sql := 'select ''' || v1_group || ',' || v1_category ||  ' 订单满足率趋势图'' from dual';
    end if;
  else
    if v_group = '1' and v_category = '1' then
      v_sql := 'select ''' || v1_sort ||   ' 订单满足率趋势图'' from dual';
    elsif v_group = '1' and v_category <> '1' then
      v_sql := 'select ''' || v1_category || ',' || v1_sort || ' 订单满足率趋势图'' from dual';
    elsif v_group <> '1' and v_category = '1' then
      v_sql := 'select ''' || v1_group || ',' || v1_sort || ' 订单满足率趋势图'' from dual';
    elsif v_group <> '1' and v_category <> '1' then
      v_sql := 'select ''' || v1_group || ',' || v1_category || ',' ||  v1_sort || ' 订单满足率趋势图'' from dual';
    end if;
  end if;
   return v_sql;
 end f_kpi_162_captionsql;
  /*---------------------------------------------------------
   对象: F_KPI_162_SELECTSQL
   用途: 报表中心==>交期==>指标查询==>订单满足率页面==>查看趋势按钮跳转==>订单满足率趋势图
   参数解析
        V_TIME           查询时间
        V_DIMENSION      统计维度
        V_SORT           维度分类
        V_GROUP          区域组
        V_CATEGORY       分类
        V_COMPANY_ID     公司id
   返回：订单满足率趋势图select_sql
   上线版本：2022-10-30
   -----------------------------------------------------------*/
 FUNCTION F_KPI_162_SELECTSQL(V_TIME       VARCHAR2,
                              V_DIMENSION  VARCHAR2,
                              V_SORT       VARCHAR2,
                              V_GROUP      VARCHAR2,
                              V_CATEGORY   VARCHAR2,
                              V_COMPANY_ID VARCHAR2) RETURN CLOB IS
   V_SQL      CLOB;
   V_WHERE    CLOB;
   V1_WHERE   CLOB;
   V1_TIME    VARCHAR2(128);
   V_F        VARCHAR2(128);
   V_S        VARCHAR2(128);
   V_C        CLOB;
   V_MAX_DATE VARCHAR2(32);
   V_MIN_DATE VARCHAR2(32);
 BEGIN
   V_WHERE := ' where t.company_id = ''' || V_COMPANY_ID || '''';
   --过滤条件：分部
   CASE
     WHEN V_CATEGORY = '1' THEN
       V_WHERE := V_WHERE || ' and 1 = 1 ';
     ELSE
       V_WHERE := V_WHERE || ' and t.category = ''' || V_CATEGORY || ''' ';
   END CASE;
   --过滤条件：区域组
   CASE
     WHEN V_GROUP = '1' THEN
       V_WHERE := V_WHERE || ' and 1 = 1 ';
     ELSE
       V_WHERE := V_WHERE || ' and t.groupname = ''' || V_GROUP || ''' ';
   END CASE;
   --统计维度过滤
   IF V_SORT IS NULL THEN
     V_WHERE := V_WHERE || ' and t.count_dimension = '''|| V_DIMENSION ||'''';
   ELSIF  V_DIMENSION in ('06','07','08') then
     IF V_SORT = '1' THEN
     V_WHERE := V_WHERE || ' and t.count_dimension = '''|| V_DIMENSION ||''' and t.dimension_sort = ''1''';
     ELSE
     V_WHERE := V_WHERE || ' and t.count_dimension = '''|| V_DIMENSION ||''' and t.dimension_sort = ''' || V_SORT || '''';
     END IF;
   ELSE
     V_WHERE := V_WHERE || ' and t.count_dimension = '''|| V_DIMENSION ||''' and t.dimension_sort = ''' || V_SORT || '''';
   END IF;

   --时间维度
   IF SUBSTR(V_TIME,5,1) = '-' THEN
     V1_TIME    := TO_CHAR(SYSDATE, 'yyyy') || '年' || TO_CHAR(SYSDATE, 'mm') || '月';
     V_C        := SCMDATA.PKG_KPIPT_ORDER.F_KPI_MONTH(TOTAL_TIME => V1_TIME);
     V_MAX_DATE := SCMDATA.PARSE_JSON(V_C, 'COL_1');
     V_MIN_DATE := SCMDATA.PARSE_JSON(V_C, 'COL_2');
     V_SQL      := q'[ select total_time,
       (sum(t1.sho_order_money) / sum(nullif(t1.order_money, 0))) * 100 performance_value,
       (sum(t1.sho_order_original_money) / sum(nullif(t1.order_money, 0))) * 100 original_value
  from (select to_char(t.kpi_date, 'yyyy') || '年' || to_char(t.kpi_date, 'mm') || '月' total_time,
               t.category, t.groupname, t.count_dimension, t.dimension_sort, t.order_money,
               t.sho_order_money, t.sho_order_original_money
          from scmdata.t_kpi_thismonth t ]' || v_where || q'[
           and to_char(t.kpi_date, 'yyyy-mm') = to_char(sysdate, 'yyyy-mm')
        union all
        select t.year || '年' || lpad(t.month, 2, 0) || '月' total_time,
               t.category, t.groupname, t.count_dimension, t.dimension_sort, t.order_money,
               t.sho_order_money, t.sho_order_original_money
          from scmdata.t_kpi_month t ]' || v_where || q'[
           and t.year || lpad(t.month, 2, 0) > ']' ||
                   v_min_date || q'['
           and t.year || lpad(t.month, 2, 0) <= ']' ||
                   v_max_date || q'[') t1
 group by total_time
 order by total_time ]';
   ELSE
     IF SUBSTR(V_TIME, -1) = '月' THEN
       V_C := SCMDATA.PKG_KPIPT_ORDER.F_KPI_MONTH(TOTAL_TIME => V_TIME);
       V_S := ' t.year||lpad(t.month, 2, 0) total_date,(t.year || ''年'' || lpad(t.month, 2, 0) || ''月'') ';
       V_F := ' from scmdata.t_kpi_month t';
     ELSIF SUBSTR(V_TIME, -2) = '季度' THEN
       V_C := SCMDATA.PKG_KPIPT_ORDER.F_KPI_QUARTER(TOTAL_TIME => V_TIME);
       V_S := ' t.year|| t.quarter total_date,(t.year || ''年第'' || t.quarter || ''季度'') ';
       V_F := ' from scmdata.t_kpi_quarter t';
     ELSIF SUBSTR(V_TIME, -2) = '半年' THEN
       V_C := SCMDATA.PKG_KPIPT_ORDER.F_KPI_HALFYEAR(TOTAL_TIME => V_TIME);
       V_S := 't.year||t.halfyear total_date,(t.year || ''年'' ||  decode(t.halfyear,1,''上'',2,''下'')  || ''半年'') ';
       V_F := ' from scmdata.t_kpi_halfyear t';
     ELSIF LENGTH(V_TIME) = '5' THEN
       V_C := SCMDATA.PKG_KPIPT_ORDER.F_KPI_YEAR(TOTAL_TIME => V_TIME);
       V_S := ' t.year total_date,(t.year || ''年'') ';
       V_F := ' from scmdata.t_kpi_year t';
     END IF;
     V_MAX_DATE := SCMDATA.PARSE_JSON(V_C, 'COL_1');
     V_MIN_DATE := SCMDATA.PARSE_JSON(V_C, 'COL_2');
     V1_WHERE   := ' where total_date >= ''' || V_MIN_DATE ||
                   ''' and total_date <= ''' || V_MAX_DATE || ''' ';
     V_SQL      := 'select total_time,total_date,
       (sum(t1.sho_order_money) / sum(nullif(t1.order_money, 0)))*100 performance_value,
       (sum(t1.sho_order_original_money) / sum(nullif(t1.order_money, 0)))*100 original_value
  from ( select ' || v_s ||
                   'total_time,t.category,t.groupname,t.count_dimension,t.dimension_sort,t.order_money,
            t.sho_order_money,t.sho_order_original_money' || v_f ||
                   v_where || ' ) t1 ' || v1_where || '
 group by total_time,total_date
 order by total_time';
   END IF;
   RETURN V_SQL;
 END F_KPI_162_SELECTSQL;

/*------------------------------------------------------------------------------------
    对象：f_kpi_month
    参数：total_time 传入时间
    用途：动态返回月份范围12个月
         （参数所在月份 往前加6个月，往后加5个月，若后面不足5个月，则向前移，补足12个月）
    返回值：JSON拼接传出，需要用SCMDATA.PARSE_JSON解析
            COL_1 最大时间（格式：YYYYMM）
            COL_2 最小时间（格式：YYYYMM）
    注： 由于报表数据是6号凌晨4点半更新，当前最大时间维度6号为基准
-------------------------------------------------------------------------------------*/
  function f_kpi_month(total_time varchar2) return clob is
  time_year  number(4); --参数带进来所在年
  time_month number(2); --参数带进来所在月
  v_year     number(4); --当前时间最大年
  v_month    number(2); --当前时间最大月
  max_year   number(4); --最大时间年
  max_month  number(2); --最大时间月
  min_year   number(4); --最小时间年
  min_month  number(2); --最小时间月
  v_t        number;
  v_t1       number;
  v_t2       number;
  kpi_month  clob;
  begin
   time_year  := substr(total_time, 1, 4); --2022
   time_month := substr(total_time, 6, 2); --09
  --获取当前最大年月
  if to_char(sysdate, 'mm') = '01' then
    v_year := to_char(sysdate, 'yyyy') - 1;
    if to_char(sysdate, 'dd') >= '04' then
      v_month := 12;
    else
      v_month := 11;
    end if;
  else
    v_year := to_char(sysdate, 'yyyy');
    if to_char(sysdate, 'dd') >= 04 then
      v_month := to_char(sysdate, 'mm') - 1;
    else
      v_month := to_char(sysdate, 'mm') - 2;
    end if;
  end if;
/*  select t1.year, lpad(max(t.month), 2, 0) month
    into v_year, v_month
    from scmdata.t_kpi_month t
   inner join (select max(t.year) year from scmdata.t_kpi_month t) t1
      on t.year = t1.year
   group by t1.year;*/
  ---参数带进来的时间是否等于当前最大时间
  if time_year || time_month = v_year || lpad(v_month,2,0) then
    max_year  := v_year; --最大时间年
    max_month := v_month; --最大时间月
    v_t       := time_month - 11;
    if v_t <= 0 then
      min_year  := time_year - 1; --最小时间年
      min_month := 12 + v_t; --最小时间月
    else
      min_year  := time_year; --最小时间年
      min_month := v_t; --最小时间月
    end if;
  else
    --a.年份相等
    if time_year = v_year then
      v_t := time_month + 5; --带入参数获取月份往后推5个月
      --判断往后推5个月是否超出当前最大月份
      if v_t > v_month then
        ---1.往后推5个月大于当前最大月份
        max_year  := v_year; ---当前最大年份=最大范围年份
        max_month := v_month; ---当前最大月份=最大范围月份
        v_t1      := (max_month - time_month); ---v_t1 计算往后推了几个月
        v_t2      := 11 - v_t1; ---v_t2 计算往前要加多个月（补足12个月）
        if time_month - v_t2 <= 0 then
          min_year  := time_year - 1;
          min_month := 11 - (v_t2 - time_month) + 1;
        else
          min_year  := time_year;
          min_month := time_month - v_t2;
        end if;
      else
        ----2.往后推5个月小于等于当前最大月份
        max_year  := time_year;
        max_month := time_month + 5;
        v_t1      := time_month - 6;
        if v_t1 > 0 then
          min_year  := time_year;
          min_month := time_month - 6;
        else
          min_year  := time_year - 1;
          min_month := 12 + v_t1;
        end if;
      end if;
      --b.参数带入年份小于当前最大年份
    elsif time_year < v_year then
      ---往后推5个月大于12 ，年份+1
      if time_month + 5 > 12 then
        max_year := time_year + 1; --最大时间年
        if max_year < v_year then
          --往后推5个月获取的年份是否小于当前最大年份
          max_month := (time_month + 5) - 12; --最大时间月
        else
          if (time_month + 5) - 12 < v_month then
            max_month := (time_month + 5) - 12; --最大时间月
          else
            max_month := v_month; --最大时间月
          end if;
        end if;
        v_t       := (12 - time_month) + max_month; ---计算往后推了多少个月
        v_t1      := 11 - v_t; --计算往前要加多少个月
        min_year  := time_year; --最小时间年
        min_month := time_month - v_t1; --最小时间月
      else
        v_t       := time_month + 5; ---往后推5个月小于12
        max_year  := time_year;
        max_month := v_t; --time_month + 5;
        v_t1      := time_month - 6; ---计算往前加6个月是否为负数，如果<0，年份-1
        if v_t1 > 0 then
          min_year  := time_year;
          min_month := time_month - 6;
        else
          min_year  := time_year - 1;
          min_month := 12 + v_t1;
        end if;
      end if;
     else
        max_year  := v_year;
        max_month := v_month; 
        min_year  := v_year;
        min_month := v_month - 11; 
    end if;
  end if;
    kpi_month := '{"COL_1":' ||  max_year||lpad(max_month,2,0) ||
                 ',"COL_2":' ||  min_year||lpad(min_month,2,0) || ' }';
    return kpi_month;
  end f_kpi_month;

/*------------------------------------------------------------------------------------
    对象：f_kpi_quarter
    参数：total_time 传入年份、季度（格式：YYYY年第Q季度）
    用途：动态返回季度范围8个季度
         （参数所在季度 往前加5个季度，往后加2个季度，若后面不足2个季度，则向前移，补足8个季度）
    返回值：JSON拼接传出，需要用SCMDATA.PARSE_JSON解析
            COL_1 最大时间（格式：YYYYQ）
            COL_2 最小时间（格式：YYYYQ）
    注： 由于报表数据是6号凌晨4点半更新，当前最大时间维度6号为基准
-------------------------------------------------------------------------------------*/
  function f_kpi_quarter(total_time varchar2) return clob is
  time_year    number(4);
  time_quarter number(1);
  v_year       number(4);
  v_quarter    number(1);
  max_year     number(4); --最大时间年
  max_quarter  number(1); --最大时间季度
  min_year     number(4); --最小时间年
  min_quarter  number(1); --最小时间季度
  v_t          number;
  v_t1         number;
  v_t2         number;
  kpi_quarter clob;
  begin

  time_year    := substr(total_time, 1, 4); --获取参数传进来的年份
  time_quarter := substr(total_time, 7, 1); --获取参数传进来的季度

 --获取当前最大时间年、季度
  if to_char(sysdate, 'Q') = '1' then
    v_year := to_char(sysdate, 'yyyy') - 1;
    if to_char(sysdate, 'mmdd') >= '0104' then
      v_quarter := '4';
    else
      v_quarter := '3';
    end if;
  elsif to_char(sysdate, 'Q') = '2' then
    if to_char(sysdate, 'mmdd') >= '0404' then
      v_year    := to_char(sysdate, 'yyyy');
      v_quarter := 1;
    else
      v_year    := to_char(sysdate, 'yyyy') - 1;
      v_quarter := 4;
    end if;
  elsif to_char(sysdate, 'Q') = '3' then
    v_year := to_char(sysdate, 'yyyy');
    if to_char(sysdate, 'mmdd') >= '0704' then
      v_quarter := 2;
    else
      v_quarter := 1;
    end if;
  elsif to_char(sysdate, 'Q') = '4' then
    v_year := to_char(sysdate, 'yyyy');
    if to_char(sysdate, 'mmdd') >= '1004' then
      v_quarter := 3;
    else
      v_quarter := 2;
    end if;
  end if;

/*  select t1.year, max(t.quarter) quarter
    into v_year, v_quarter
    from scmdata.t_kpi_quarter t
   inner join (select max(t.year) year from scmdata.t_kpi_quarter t) t1
      on t.year = t1.year
   group by t1.year;*/
if v_year = time_year then
    if v_quarter = time_quarter then
      --参数带进来的时间是否等于当前最大时间
      max_year    := v_year;
      max_quarter := v_quarter;
      v_t         := 8 - max_quarter; --往前推多少个季度
      v_t1        := v_t - 4;
      if v_t1 = 0 then
        min_year    := time_year - 1; --减一年
        min_quarter := 1;
      elsif v_t1 = 1 then
        min_year    := time_year - 2; --减二年
        min_quarter := 4;
      elsif v_t1 = 2 then
        min_year    := time_year - 2; --减二年
        min_quarter := 3;
      elsif v_t1 = 3 then
        min_year    := time_year - 2; --减二年
        min_quarter := 2;
      end if;
    else
      if v_quarter - time_quarter >= 2 then
        max_year    := time_year;
        max_quarter := time_quarter + 2;
        v_t         := 5 - time_quarter;
        v_t1        := v_t - 4;
        if v_t1 = 0 then
          min_year    := time_year - 2; --减二年
          min_quarter := 4;
        else
          min_year    := time_year - 1; --减一年
          min_quarter := 1;
        end if;
      else
        max_year    := v_year;
        max_quarter := v_quarter;
      --  v_t         := max_quarter - time_quarter; --往后推多少个季度
       -- v_t1        := 7 - v_t; --计算要往前推多少个季度
        --v_t1        := v_t1 - time_quarter;
        min_year    := time_year - 1; --减一年
        min_quarter := 2;
      end if;
    end if;
  else
    v_t  := 4 - time_quarter;
    v_t1 := v_t - 2;
    if v_t1 >= 0 then
      --往后推2 不跨年
      max_year    := time_year;
      max_quarter := time_quarter + 2;
      v_t2        := 6 - time_quarter - 4;
      if v_t2 > 0 then
        min_year    := time_year - 2; --减二年
        min_quarter := 4;
      else
        min_year    := time_year - 1; --减一年
        min_quarter := 1;
      end if;
    else
      --往后推2 跨年
      max_year := time_year + 1;
      if max_year = v_year then
        v_t := 4 - time_quarter;
        if v_quarter >= 2 then
          if v_t = 1 then
            max_quarter := 1;
          elsif v_t = 0 then
            max_quarter := 2;
          end if;
          v_t2     := 5 - time_quarter;
          min_year := time_year - 1; --减一年
          if v_t2 = 2 then
            min_quarter := 2;
          elsif v_t2 = 1 then
            min_quarter := 3;
          end if;
        else
          max_quarter := v_quarter;
          min_year    := time_year - 1; --减一年
          min_quarter := 2;
        end if;
      else
        if time_quarter = 3 then
          max_quarter := 1;
          min_year    := time_year - 1; --减一年
          min_quarter := 2;
        elsif time_quarter = 4 then
          max_quarter := 2;
          min_year    := time_year - 1; --减一年
          min_quarter := 3;
        end if;
      end if;
    end if;
  end if;
    kpi_quarter := '{"COL_1":' ||  max_year||max_quarter ||
                   ',"COL_2":' ||  min_year||min_quarter || ' }';
    return kpi_quarter;
  end f_kpi_quarter;

/*------------------------------------------------------------------------------------
    对象：f_kpi_quarter
    参数：total_time 传入年份、半年度（格式：YYYY年上半年、YYYY年下半年）
    用途：动态返回季度范围6个半年
         （参数所在半年度 往前加3个半年度，往后加2个半年度，若后面不足2个半年度，则向前移，补足6个半年度数据）
    返回值：JSON拼接传出，需要用SCMDATA.PARSE_JSON解析
            COL_1 最大时间（格式：YYYYA）A:1上半年，2下半年
            COL_2 最小时间（格式：YYYYA）A:1上半年，2下半年
    注： 由于报表数据是6号凌晨4点半更新，当前最大时间维度6号为基准
-------------------------------------------------------------------------------------*/
  function f_kpi_halfyear(total_time varchar2) return clob is
  time_year     number(4);
  time_halfyear number(1);
  v_year        number(4);
  v_halfyear    number(1);
  max_year      number(4); --最大时间年
  max_halfyear  number(1); --最大时间半年度
  min_year      number(4); --最小时间年
  min_halfyear  number(1); --最小时间半年度
  kpi_halfyear clob; --返回值
  begin

  time_year     := substr(total_time, 1, 4); --2022
  time_halfyear := (case  when substr(total_time, 6, 1) = '上' then '1'
                          when substr(total_time, 6, 1) = '下' then '2' end); --2
  -- v_year        := 2022;
  --v_halfyear    := 1;
  --获取当前最大时间维度
    if to_char(sysdate, 'mmdd') >= '0104' and to_char(sysdate, 'mmdd') < '0704' then
    select to_char(sysdate, 'yyyy') - 1 into v_year from dual;
    v_halfyear := 2;
  else
    select to_char(sysdate, 'yyyy') into v_year from dual;
    v_halfyear := 1;
  end if;
  if v_year = time_year then
    if v_halfyear = time_halfyear then
      max_year     := v_year;
      max_halfyear := v_halfyear;
      if time_halfyear = 1 then
        min_year     := time_year - 3;
        min_halfyear := 2;
      else
        min_year     := time_year - 2;
        min_halfyear := 1;
      end if;
    else
      max_year     := v_year;
      max_halfyear := v_halfyear;
      min_year     := time_year - 2;
      min_halfyear := 1;
    end if;
  else
    if time_halfyear = 1 then  --带入参数是上半年
      max_year     := time_year + 1;
      max_halfyear := 1;
      min_year     := time_year - 2;
      min_halfyear := 2;
    else --time_halfyear =  2
      if time_year + 1 = v_year then
          max_year     := v_year;
          max_halfyear := v_halfyear;
        if v_halfyear = 1 then  --往后1
          min_year     := time_year - 2;
          min_halfyear := 2;
        else   --往后2
          min_year     := time_year - 1;
          min_halfyear := 1;
        end if;
      else
          max_year     := time_year + 1;
          max_halfyear := 2;
          min_year     := time_year - 1;
          min_halfyear := 1;
      end if;
    end if;
  end if;
    kpi_halfyear := '{"COL_1":' ||  max_year||max_halfyear||  ',"COL_2":' ||  min_year||min_halfyear || ' }';
    return kpi_halfyear;
  end f_kpi_halfyear;

/*----------------------------------------------------------------------------------------
    对象：f_kpi_year
    参数：total_time 传入年份（格式：YYYY年）
    用途：动态返回年度范围3个年份
         （参数所在半年度 往前加1年度，往后加1年度，若后面不足1年度，则向前移，补足3年度数据）
    返回值：JSON拼接传出，需要用SCMDATA.PARSE_JSON解析
            COL_1 最大时间（格式：YYYY）
            COL_2 最小时间（格式：YYYY）
    注： 由于报表数据是6号凌晨4点半更新，当前最大时间维度6号为基准
-------------------------------------------------------------------------------------------*/
  function f_kpi_year(total_time varchar2) return clob is
  time_year  number(4);
  v_year     number(4);
  max_year   number(4); --最大时间年
  min_year   number(4); --最小时间年
  kpi_year clob; --返回值
  begin
  time_year := substr(total_time, 1, 4);
  --v_year    := 2022;
  --获取当前最大时间维度
  if to_char(sysdate, 'mmdd') < '0104' then
    select to_char(sysdate, 'yyyy') - 2 into v_year from dual;
  else
    select to_char(sysdate, 'yyyy') - 1 into v_year from dual;
  end if;
  if v_year = time_year then
    max_year := v_year;
    min_year := v_year - 2;
  else
    max_year := time_year + 1;
    min_year := time_year - 1;
  end if;
    kpi_year := '{"COL_1":' ||  max_year || ',"COL_2":' ||  min_year || ' }';
    return kpi_year;
  end f_kpi_year;
  /*---------------------------------------------------------
   对象: F_KPI_170_SELECTSQL
   用途: 报表中心==>交期==>指标查询==>补货平均交期页面
   参数解析
        KPI_TIMETYPE        查询时间类型
        KPI_TIME            查询统计时间
        KPI_DIMENSION       统计维度
        KPI_GROUP           区域组
        KPI_CATEGORY        分类
        P_CLASS_DATA_PRIVS  数据权限
        COMPANY_ID          公司id
   返回：补货平均交期页面select_sql
   上线版本：2022-10-30
   -----------------------------------------------------------*/
 FUNCTION F_KPI_170_SELECTSQL( KPI_TIMETYPE       VARCHAR2,
                               KPI_TIME           VARCHAR2,
                               KPI_DIMENSION      VARCHAR2,
                               KPI_GROUP          VARCHAR2,
                               KPI_CATEGORY       VARCHAR2,
                               P_CLASS_DATA_PRIVS CLOB,
                               COMPANY_ID         VARCHAR2) RETURN CLOB IS

    VC_SQL       CLOB;
    VC_SQL1      clob;
    K_TIME       varchar2(128) := KPI_TIME;
    v_where      CLOB;
    v1_where     clob;
    v2_where     clob;
    v_b          clob;
    v_b2         clob;
    v_s          clob;
    v_s1         clob;
    v_s2         clob;
    v_dimension  clob;
    v1_dimension clob;
    v2_dimension clob;
    v_sort       clob := '';
    v_group      clob;
    v_orderby    clob ;
  BEGIN
    ---汇总字段条件
    if K_TIME = '本月' then
      K_TIME := to_char(sysdate, 'yyyy-mm');
    end if;
    ---汇总主键
     v1_dimension := '{"COL_1":' || K_TIME || ',"COL_2":' || KPI_GROUP ||
                    ',"COL_3":' || KPI_CATEGORY || ' ,"COL_4":' ||
                    KPI_DIMENSION || ' }';
      ---拼接主键
      v2_dimension := '''{"COL_1":' || K_TIME || ',"COL_2":' || KPI_GROUP ||
                      ',"COL_3":' || KPI_CATEGORY || ' ,"COL_4":' ||
                      KPI_DIMENSION || ' ,"COL_5":''' ||
                      '|| t.dimension_sort' || '||'' }''';
    --统计维度
    if kpi_dimension = '00' THEN
      --统计维度：分类
      v1_where := ' and count_dimension = ''00''';
      if KPI_GROUP = '1' then
        v_dimension := ' ''全部'' area_group  , category_name,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time , category_name,category,count_dimension,dimension_sort,' ||
                       v2_dimension ;
      else
        v_dimension := ' area_group,category_name,'|| v2_dimension ||
                       ' pid ,';
        v_group     := ' group by total_time,area_group,category_name,count_dimension,dimension_sort,' ||
                       v2_dimension ;
      end if;
    elsif kpi_dimension = '01' THEN
      --统计维度：区域组
      v1_where := ' and count_dimension = ''01''';
      if KPI_CATEGORY = '1' then
        v_dimension := ' area_group ,''全部'' category_name,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time, area_group,count_dimension,dimension_sort,' ||
                       v2_dimension ;
      else
        v_dimension := ' area_group,category_name,' || v2_dimension ||
                       ' pid ,';
        v_group     := ' group by total_time,area_group, category_name,count_dimension,dimension_sort,' ||
                       v2_dimension ;
      end if;
    elsif kpi_dimension = '02' THEN
      --统计维度：款式名称
      v1_where := ' and count_dimension = ''02''';
      v_sort   := ' '' ''style_names, ';
      if KPI_CATEGORY = '1' and KPI_GROUP = '1' then
        v_dimension := ' ''全部'' area_group ,''全部'' category_name,dimension_sort style_names,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,dimension_sort,count_dimension,' ||
                       v2_dimension;
      elsif KPI_CATEGORY = '1' and KPI_GROUP <> '1' then
        v_dimension := ' area_group ,''全部'' category_name,dimension_sort style_names,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,area_group ,dimension_sort,count_dimension,' ||
                       v2_dimension;
      elsif KPI_CATEGORY <> '1' and KPI_GROUP = '1' then
        v_dimension := '''全部'' area_group ,category_name,dimension_sort style_names,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time ,category_name,dimension_sort,count_dimension,' ||
                       v2_dimension;
      else
        v_dimension := ' area_group ,category_name,dimension_sort style_names,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,area_group ,category_name,dimension_sort,count_dimension,' ||
                       v2_dimension;
      end if;
    elsif kpi_dimension = '03' THEN
      --统计维度：产品子类
      v1_where := ' and count_dimension = ''03''';
      v_sort   := ''' '' product_cate,'' ''samll_category,'' ''small_category_gd, ';
      if KPI_CATEGORY = '1' and KPI_GROUP = '1' then
        v_dimension := ' ''全部'' area_group ,''全部'' category_name,cate_category product_cate, samll_category,dimension_sort small_category_gd,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,samll_category,cate_category,count_dimension,dimension_sort,' ||
                       v2_dimension;
      elsif KPI_CATEGORY = '1' and KPI_GROUP <> '1' then
        v_dimension := ' area_group ,''全部'' category_name,cate_category product_cate, samll_category,dimension_sort small_category_gd,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,area_group ,cate_category,samll_category,count_dimension,dimension_sort,' ||
                       v2_dimension;
      elsif KPI_CATEGORY <> '1' and KPI_GROUP = '1' then
        v_dimension := '''全部'' area_group ,category_name,cate_category product_cate,  samll_category,dimension_sort small_category_gd,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time ,category_name,cate_category,samll_category,count_dimension,dimension_sort,' ||
                       v2_dimension;
      else
        v_dimension := ' area_group ,category_name,cate_category product_cate, samll_category,dimension_sort small_category_gd,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,area_group ,cate_category,category_name,samll_category,dimension_sort,count_dimension,' ||
                       v2_dimension;
      end if;
    elsif kpi_dimension = '04' THEN
      --统计维度：供应商
      v1_where := ' and count_dimension = ''04''';
      v_sort   := ''' ''supplier_code, '' ''supplier, ';
      if KPI_CATEGORY = '1' and KPI_GROUP = '1' then
        v_dimension := ' ''全部'' area_group ,''全部'' category_name, supplier_code,supplier,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,supplier_code,supplier,count_dimension,dimension_sort,' ||
                       v2_dimension;
      elsif KPI_CATEGORY = '1' and KPI_GROUP <> '1' then
        v_dimension := ' area_group ,''全部'' category_name, supplier_code, supplier,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,area_group ,supplier_code,supplier,count_dimension,dimension_sort,' ||
                       v2_dimension;
      elsif KPI_CATEGORY <> '1' and KPI_GROUP = '1' then
        v_dimension := '''全部'' area_group ,category_name, supplier_code, supplier,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time ,category_name,supplier_code,supplier,count_dimension,dimension_sort,' ||
                       v2_dimension;
      else
        v_dimension := ' area_group ,category_name, supplier_code,supplier,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,area_group ,category_name,supplier_code,supplier,count_dimension,dimension_sort,' ||
                       v2_dimension;
      end if;
    elsif kpi_dimension = '05' THEN
      --统计维度：生产工厂
      v1_where := ' and count_dimension = ''05''';
      v_sort   := ''' ''supplier_code, '' ''factory_company_name, ';
      if KPI_CATEGORY = '1' and KPI_GROUP = '1' then
        v_dimension := ' ''全部'' area_group ,''全部'' category_name, dimension_sort supplier_code,factory_company_name,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,dimension_sort,factory_company_name,count_dimension,dimension_sort,' ||
                       v2_dimension;
      elsif KPI_CATEGORY = '1' and KPI_GROUP <> '1' then
        v_dimension := ' area_group ,''全部'' category_name,dimension_sort supplier_code, factory_company_name,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,area_group ,dimension_sort,factory_company_name,count_dimension,dimension_sort,' ||
                       v2_dimension;
      elsif KPI_CATEGORY <> '1' and KPI_GROUP = '1' then
        v_dimension := '''全部'' area_group ,category_name,dimension_sort supplier_code, factory_company_name,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time ,category_name,dimension_sort,factory_company_name,count_dimension,dimension_sort,' ||
                       v2_dimension;
      else
        v_dimension := ' area_group ,category_name, dimension_sort supplier_code,factory_company_name,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,area_group ,category_name,dimension_sort,factory_company_name,count_dimension,dimension_sort,' ||
                       v2_dimension;
      end if;
    elsif kpi_dimension = '06' THEN
      --统计维度：跟单
      v1_where := ' and count_dimension = ''06''';
      v_sort   := ''' ''flw_order, ';
      if KPI_CATEGORY = '1' and KPI_GROUP = '1' then
        v_dimension := ' ''全部'' area_group ,''全部'' category_name, flw_order,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,flw_order,count_dimension,dimension_sort,' ||
                       v2_dimension;
      elsif KPI_CATEGORY = '1' and KPI_GROUP <> '1' then
        v_dimension := ' area_group ,''全部'' category_name,flw_order,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,area_group ,flw_order,count_dimension,dimension_sort,' ||
                       v2_dimension;
      elsif KPI_CATEGORY <> '1' and KPI_GROUP = '1' then
        v_dimension := '''全部'' area_group ,category_name,flw_order,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,category_name,flw_order,count_dimension,dimension_sort,' ||
                       v2_dimension;
      else
        v_dimension := ' area_group ,category_name, flw_order,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,area_group ,category_name,flw_order,count_dimension,dimension_sort,' ||
                       v2_dimension;
      end if;
    elsif kpi_dimension = '07' THEN
      --统计维度：QC
      v1_where := ' and count_dimension = ''07''';
      v_sort   := ''' ''qc, ';
      if KPI_CATEGORY = '1' and KPI_GROUP = '1' then
        v_dimension := ' ''全部'' area_group ,''全部'' category_name, qc,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,qc,count_dimension,dimension_sort,' ||
                       v2_dimension;
      elsif KPI_CATEGORY = '1' and KPI_GROUP <> '1' then
        v_dimension := ' area_group ,''全部'' category_name,qc,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,area_group ,qc,count_dimension,dimension_sort,' ||
                       v2_dimension;
      elsif KPI_CATEGORY <> '1' and KPI_GROUP = '1' then
        v_dimension := '''全部'' area_group ,category_name,qc,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,category_name,qc,count_dimension,dimension_sort,' ||
                       v2_dimension;
      else
        v_dimension := ' area_group ,category_name, qc,' || v2_dimension ||
                       ' pid ,';
        v_group     := ' group by total_time,area_group ,category_name,qc,count_dimension,dimension_sort,' ||
                       v2_dimension;
      end if;
    elsif kpi_dimension = '08' THEN
      --统计维度：QC主管
      v1_where := ' and count_dimension = ''08''';
      v_sort   := ''' ''qc_leader, ';
      if KPI_CATEGORY = '1' and KPI_GROUP = '1' then
        v_dimension := ' ''全部'' area_group ,''全部'' category_name, qc_leader,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,qc_leader,count_dimension,dimension_sort,' ||
                       v2_dimension;
      elsif KPI_CATEGORY = '1' and KPI_GROUP <> '1' then
        v_dimension := ' area_group ,''全部'' category_name,qc_leader,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,area_group ,qc_leader,count_dimension,dimension_sort,' ||
                       v2_dimension;
      elsif KPI_CATEGORY <> '1' and KPI_GROUP = '1' then
        v_dimension := '''全部'' area_group ,category_name,qc_leader,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,category_name,qc_leader,count_dimension,dimension_sort,' ||
                       v2_dimension;
      else
        v_dimension := ' area_group ,category_name, qc_leader,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,area_group ,category_name,flw_order,count_dimension,dimension_sort,' ||
                       v2_dimension;
      end if;
    end if;
    --过滤条件：分部
    CASE
      WHEN KPI_CATEGORY = '1' THEN
        v1_where := v1_where || ' AND 1 = 1 ';
      ELSE
        v1_where := v1_where || ' AND category = ''' || KPI_CATEGORY || ''' ';
    END CASE;
    --过滤条件：区域组
    CASE
      WHEN KPI_GROUP = '1' THEN
        v1_where := v1_where || ' AND 1 = 1 ';
      ELSE
        v1_where := v1_where || ' AND groupname = ''' || KPI_GROUP || ''' ';
    END CASE;
    --字段
    v_s2 := '  a.group_dict_name category_name,
       t.category,
       t.groupname,
       ts.group_name area_group,
       t.count_dimension,
       t.dimension_sort,
       samll.samll_category,
       samll.cate_category,
       tsup.supplier_code,
       tsup.supplier_company_name  supplier,
       tf.supplier_company_name factory_company_name,
       fel.company_user_name flw_order,
       q.company_user_name qc,
       q1.company_user_name qc_leader,
       t.delivery_order_money,
       t.delivery_money';
    --表关联
    v_b2 := q'[inner join scmdata.sys_group_dict a
            on a.group_dict_type = 'PRODUCT_TYPE'
           and a.group_dict_value = t.category
          left join scmdata.t_supplier_group_config ts
            on ts.group_config_id = t.groupname
          left join (select distinct c.group_dict_value, c1.group_dict_name    cate_category,
                           cd.company_dict_value, cd.company_dict_name samll_category
                      from scmdata.sys_group_dict c
                     inner join scmdata.sys_group_dict c1
                        on c1.group_dict_type = c.group_dict_value
                     inner join scmdata.sys_company_dict cd
                        on cd.company_dict_type = c1.group_dict_value
                       and cd.company_id = %default_company_id%
                     where c.group_dict_type = 'PRODUCT_TYPE') samll
            on samll.group_dict_value = t.category
           and samll.company_dict_value = t.dimension_sort
           and t.count_dimension = '03'
          left join scmdata.t_supplier_info tsup
            on tsup.company_id = t.company_id
           and tsup.inside_supplier_code = t.dimension_sort
           and t.count_dimension = '04'
          left join scmdata.t_supplier_info tf
            on tf.company_id = t.company_id
           and tf.supplier_code = t.dimension_sort
           and t.count_dimension = '05'
          left join scmdata.sys_company_user fel
            on fel.company_id = t.company_id
           and fel.user_id = t.dimension_sort
           and t.count_dimension = '06'
          left join scmdata.sys_company_user q
            on q.company_id = t.company_id
           and q.user_id = t.dimension_sort
           and t.count_dimension = '07'
          left join scmdata.sys_company_user q1 --qc_leader
            on q1.company_id = t.company_id
           and q1.user_id = t.dimension_sort
           and t.count_dimension = '08'
         where t.delivery_money is not null
           and t.company_id = ']' || COMPANY_ID || ''' ' ||
            scmdata.pkg_kpipt_order.f_get_dataprivs_sql(p_class_data_privs => P_CLASS_DATA_PRIVS,
                                                        p_pre              => 't') ||
            v1_where || ' )t';
    --过滤条件：时间
    if KPI_TIME = '本月' then
      v_where := ' where total_time2 = to_char(sysdate,''yyyy-mm'')';
    else
      v_where := ' where total_time = ''' || K_TIME || ''' ';
    end if;

  v_orderby := ' order by dimension_sort nulls first ,area_group nulls first ,category_name nulls first';

    --时间维度
    IF KPI_TIMETYPE = '本月' then
      v_b := ' from scmdata.t_kpi_thismonth t ';
      v_s1 := ' to_char(t.kpi_date,''yyyy-mm'') total_time2, ''本月'' ';
      v_s  := ' select ' || v_s1 || ' total_time,' || v_s2 || v_b || v_b2 ||
              v_where || v_group ||v_orderby;
    elsif KPI_TIMETYPE = '月度' then
      v_b  := ' from scmdata.t_kpi_month t ';
      v_s1 := '(t.year || ''年'' || lpad(t.month, 2, 0) || ''月'')';
      v_s  := ' select ' || v_s1 || ' total_time,' || v_s2 || v_b || v_b2 ||
              v_where || v_group ||v_orderby;
    elsif KPI_TIMETYPE = '季度' then
      v_b  := ' from scmdata.t_kpi_quarter t ';
      v_s1 := '(t.year || ''年第'' || t.quarter || ''季度'')';
      v_s  := ' select ' || v_s1 || ' total_time,' || v_s2 || v_b || v_b2 ||
              v_where || v_group ||v_orderby;
    elsif KPI_TIMETYPE = '半年度' then
      v_b  := ' from scmdata.t_kpi_halfyear t ';
      v_s1 := '(t.year || ''年'' || decode(t.halfyear,1,''上'',2,''下'') || ''半年'' )';
      v_s  := ' select ' || v_s1 || ' total_time,' || v_s2 || v_b || v_b2 ||
              v_where || v_group ||v_orderby;
    elsif KPI_TIMETYPE = '年度' then
      v_b  := ' from scmdata.t_kpi_year t ';
      v_s1 := '(t.year || ''年'' )';
      v_s  := ' select ' || v_s1 || ' total_time,' || v_s2 || v_b || v_b2 ||
              v_where || v_group ||v_orderby;
    end if;
    ---汇总字段条件
    if KPI_TIME = '本月' then
      v2_where := ' where to_char(t.kpi_date,''yyyy-mm'') = to_char(sysdate,''yyyy-mm'')  ' ||  v1_where;
    else
      v2_where := ' where ' || v_s1 || '= ''' || K_TIME || '''' || v1_where;
    end if;

    ---汇总语句
    VC_SQL1 := q'[select '汇总' total_time,
       ' ' area_group,
       ' ' category_name,
]' || v_sort || '''' || v1_dimension || ''' pid, ' ||
               q'[' ' count_dimension,' 'dimension_sort, sum(t.delivery_order_money )/ sum(nullif(t.delivery_money, 0)) replenishment_average_delivery ]' || v_b ||
               v2_where;
    ---返回sql
    VC_SQL := VC_SQL1 || q'[
union all
select total_time,
]' || v_dimension || q'[t.count_dimension,t.dimension_sort, sum(t.delivery_order_money )/ sum(nullif(t.delivery_money, 0)) replenishment_average_delivery
  from ( ]' || v_s;


    RETURN VC_SQL;

  END F_KPI_170_SELECTSQL;

  /*---------------------------------------------------------
   对象: f_kpi_171_captionsql
   用途: 报表中心==>交期==>指标查询==>补货平均交期==>查看趋势按钮跳转==>补货平均交期趋势图动态表头
   参数解析
        v_string       补货平均交期页面拼接主键
        v_id          公司id
   返回：补货平均交期趋势图页面表头captionsql
   上线版本：2022-10-30
   -----------------------------------------------------------*/
function f_kpi_171_captionsql(v_string varchar2,v_id varchar2) return clob is
   v_group     varchar2(64);
   v1_group    varchar2(64);
   v_category  varchar2(32);
   v1_category varchar2(32);
   v_dimension varchar2(32);
   v_sort      varchar2(128);
   v1_sort      varchar2(128);
   v_sql       clob; --返回值
 begin
   v_group     := scmdata.parse_json(v_string, 'COL_2');
   v_category  := scmdata.parse_json(v_string, 'COL_3');
   v_dimension := scmdata.parse_json(v_string, 'COL_4');
   v_sort      := scmdata.parse_json(v_string, 'COL_5');
  if v_sort is null then
    if v_category = '1' then
      v1_category := '全部';
    else
      select t.group_dict_name
        into v1_category
        from scmdata.sys_group_dict t
       where t.group_dict_type = 'PRODUCT_TYPE'
         and t.group_dict_value = v_category;
    end if;
    if v_group = '1' then
      v1_group := '全部';
    else
      select ts.group_name
        into v1_group
        from scmdata.t_supplier_group_config ts
       where ts.group_config_id = v_group;
    end if;
  else
   if v_dimension = '00' then
    if v_group = '1' then
      v1_group := '全部';
    else
      select ts.group_name
        into v1_group
        from scmdata.t_supplier_group_config ts
       where ts.group_config_id = v_group;
    end if;
    if v_sort = '1' then
      v1_category := '全部';
    else
      select t.group_dict_name
        into v1_category
        from scmdata.sys_group_dict t
       where t.group_dict_type = 'PRODUCT_TYPE'
         and t.group_dict_value = v_sort;
    end if;
  elsif v_dimension = '01' then
    if v_category = '1' then
      v1_category := '全部';
    else
      select t.group_dict_name
        into v1_category
        from scmdata.sys_group_dict t
       where t.group_dict_type = 'PRODUCT_TYPE'
         and t.group_dict_value = v_category;
    end if;
    if v_sort = '1' then
      v1_group := '全部';
    else
      select ts.group_name
        into v1_group
        from scmdata.t_supplier_group_config ts
       where ts.group_config_id = v_sort;
    end if;
  elsif v_dimension not in ('00', '01') then
    if v_category = '1' then
      v1_category := '全部';
    else
      select t.group_dict_name
        into v1_category
        from scmdata.sys_group_dict t
       where t.group_dict_type = 'PRODUCT_TYPE'
         and t.group_dict_value = v_category;
    end if;
    if v_group = '1' then
      v1_group := '全部';
    else
      select ts.group_name
        into v1_group
        from scmdata.t_supplier_group_config ts
       where ts.group_config_id = v_group;
    end if;
  end if;
end if;
  if v_dimension = '02' then
    --统计维度：款式名称
    v1_sort := v_sort;
  elsif v_dimension = '03' then
    --统计维度：产品子类
    select max(cd.company_dict_name) samll_category
      into v1_sort
      from scmdata.sys_group_dict c
     inner join scmdata.sys_group_dict c1
        on c1.group_dict_type = c.group_dict_value
     inner join scmdata.sys_company_dict cd
        on cd.company_dict_type = c1.group_dict_value
       and cd.company_id = v_id
     where c.group_dict_type = 'PRODUCT_TYPE'
       and cd.company_dict_value = v_sort;
  elsif v_dimension = '04' then
    --统计维度：供应商
    select max(t.supplier_company_abbreviation)
      into v1_sort
      from scmdata.t_supplier_info t
     where t.inside_supplier_code = v_sort
       and t.company_id = v_id;
  elsif v_dimension = '05' then
    --统计维度：生产工厂
    select max(t.supplier_company_abbreviation)
      into v1_sort
      from scmdata.t_supplier_info t
     where t.supplier_code = v_sort
       and t.company_id = v_id;
  elsif v_dimension in ('06', '07', '08') then
    --统计维度：跟单/QC/QC主管
    select max(f.company_user_name)
      into v1_sort
      from scmdata.sys_company_user f
     where f.user_id = v_sort
       and f.company_id = v_id;
  end if;
  if v_sort is null then
    if v_group = '1' and v_category = '1' then
      v_sql := 'select ''' || ' 补货平均交期趋势图'' from dual';
    elsif v_group = '1' and v_category <> '1' then
      v_sql := 'select ''' || v1_category ||  ' 补货平均交期趋势图'' from dual';
    elsif v_group <> '1' and v_category = '1' then
      v_sql := 'select ''' || v1_group || ' 补货平均交期趋势图'' from dual';
    elsif v_group <> '1' and v_category <> '1' then
      v_sql := 'select ''' || v1_group || ',' || v1_category ||  ' 补货平均交期趋势图'' from dual';
    end if;
  elsif v1_sort is null and v_dimension = '06' then
    if v_group = '1' and v_category = '1' then
      v_sql := 'select ''' || ' 跟单为空 补货平均交期趋势图'' from dual';
    elsif v_group = '1' and v_category <> '1' then
      v_sql := 'select ''' || v1_category ||  ' 跟单为空 补货平均交期趋势图'' from dual';
    elsif v_group <> '1' and v_category = '1' then
      v_sql := 'select ''' || v1_group || ' 跟单为空 补货平均交期趋势图'' from dual';
    elsif v_group <> '1' and v_category <> '1' then
      v_sql := 'select ''' || v1_group || ',' || v1_category ||  ' 跟单为空 补货平均交期趋势图'' from dual';
    end if;
  elsif v1_sort is null and v_dimension = '07' then
    if v_group = '1' and v_category = '1' then
      v_sql := 'select ''' || ' QC为空 补货平均交期趋势图'' from dual';
    elsif v_group = '1' and v_category <> '1' then
      v_sql := 'select ''' || v1_category ||  ' QC为空 补货平均交期趋势图'' from dual';
    elsif v_group <> '1' and v_category = '1' then
      v_sql := 'select ''' || v1_group || ' QC为空 补货平均交期趋势图'' from dual';
    elsif v_group <> '1' and v_category <> '1' then
      v_sql := 'select ''' || v1_group || ',' || v1_category ||  ' QC为空 补货平均交期趋势图'' from dual';
    end if;
  elsif v1_sort is null and v_dimension = '08' then
    if v_group = '1' and v_category = '1' then
      v_sql := 'select ''' || ' QC主管为空 补货平均交期趋势图'' from dual';
    elsif v_group = '1' and v_category <> '1' then
      v_sql := 'select ''' || v1_category ||  ' QC主管为空 补货平均交期趋势图'' from dual';
    elsif v_group <> '1' and v_category = '1' then
      v_sql := 'select ''' || v1_group || ' QC主管为空 补货平均交期趋势图'' from dual';
    elsif v_group <> '1' and v_category <> '1' then
      v_sql := 'select ''' || v1_group || ',' || v1_category ||  ' QC主管为空 补货平均交期趋势图'' from dual';
    end if;
  elsif v_dimension = '00' then
    if v_group = '1'  then
      v_sql := 'select ''' || v1_category ||  ' 补货平均交期趋势图'' from dual';
    else
      v_sql := 'select ''' || v1_group || ',' || v1_category ||  ' 补货平均交期趋势图'' from dual';
    end if;
  elsif v_dimension = '01' then
    if  v_category = '1' then
      v_sql := 'select ''' || v1_group ||  ' 补货平均交期趋势图'' from dual';
    else
      v_sql := 'select ''' || v1_group || ',' || v1_category || ' 补货平均交期趋势图'' from dual';
    end if;
  else
    if v_group = '1' and v_category = '1' then
      v_sql := 'select ''' || v1_sort ||   ' 补货平均交期趋势图'' from dual';
    elsif v_group = '1' and v_category <> '1' then
      v_sql := 'select ''' || v1_category || ',' || v1_sort || ' 补货平均交期趋势图'' from dual';
    elsif v_group <> '1' and v_category = '1' then
      v_sql := 'select ''' || v1_group || ',' || v1_sort || ' 补货平均交期趋势图'' from dual';
    elsif v_group <> '1' and v_category <> '1' then
      v_sql := 'select ''' || v1_group || ',' || v1_category || ',' ||  v1_sort || ' 补货平均交期趋势图'' from dual';
    end if;
  end if;
   return v_sql;
 end f_kpi_171_captionsql;
  /*---------------------------------------------------------
   对象: F_KPI_171_SELECTSQL
   用途: 报表中心==>交期==>指标查询==>补货平均交期页面==>查看趋势按钮跳转==>补货平均交期趋势图
   参数解析
        V_TIME           查询时间
        V_DIMENSION      统计维度
        V_SORT           维度分类
        V_GROUP          区域组
        V_CATEGORY       分类
        V_COMPANY_ID     公司id
   返回：补货平均交期趋势图页面select_sql
   上线版本：2022-10-30
   -----------------------------------------------------------*/
 FUNCTION F_KPI_171_SELECTSQL(V_TIME       VARCHAR2,
                              V_DIMENSION  VARCHAR2,
                              V_SORT       VARCHAR2,
                              V_GROUP      VARCHAR2,
                              V_CATEGORY   VARCHAR2,
                              V_COMPANY_ID VARCHAR2) RETURN CLOB IS
   V_SQL      CLOB;
   V_WHERE    CLOB;
   V1_WHERE   CLOB;
   V1_TIME    VARCHAR2(128);
   V_F        VARCHAR2(128);
   V_S        VARCHAR2(128);
   V_C        CLOB;
   V_MAX_DATE VARCHAR2(32);
   V_MIN_DATE VARCHAR2(32);
 BEGIN
   V_WHERE := ' where t.company_id = ''' || V_COMPANY_ID || '''';
   --过滤条件：分部
   CASE
     WHEN V_CATEGORY = '1' THEN
       V_WHERE := V_WHERE || ' and 1 = 1 ';
     ELSE
       V_WHERE := V_WHERE || ' and t.category = ''' || V_CATEGORY || ''' ';
   END CASE;
   --过滤条件：区域组
   CASE
     WHEN V_GROUP = '1' THEN
       V_WHERE := V_WHERE || ' and 1 = 1 ';
     ELSE
       V_WHERE := V_WHERE || ' and t.groupname = ''' || V_GROUP || ''' ';
   END CASE;

   --统计维度过滤
   IF V_SORT IS NULL THEN
     V_WHERE := V_WHERE || ' and t.count_dimension = '''|| V_DIMENSION ||'''';
   ELSIF  V_DIMENSION in ('06','07','08') then
     IF V_SORT = '1' THEN
     V_WHERE := V_WHERE || ' and t.count_dimension = '''|| V_DIMENSION ||''' and t.dimension_sort = ''1''';
     ELSE
     V_WHERE := V_WHERE || ' and t.count_dimension = '''|| V_DIMENSION ||''' and t.dimension_sort = ''' || V_SORT || '''';
     END IF;
   ELSE
     V_WHERE := V_WHERE || ' and t.count_dimension = '''|| V_DIMENSION ||''' and t.dimension_sort = ''' || V_SORT || '''';
   END IF;
   --时间维度
   IF SUBSTR(V_TIME,5,1) = '-' THEN
     V1_TIME    := TO_CHAR(SYSDATE, 'yyyy') || '年' ||  TO_CHAR(SYSDATE, 'mm') || '月';
     V_C        := SCMDATA.PKG_KPIPT_ORDER.F_KPI_MONTH(TOTAL_TIME => V1_TIME);
     V_MAX_DATE := SCMDATA.PARSE_JSON(V_C, 'COL_1');
     V_MIN_DATE := SCMDATA.PARSE_JSON(V_C, 'COL_2');
     V_SQL      := q'[ select total_time,
       sum(t1.delivery_order_money) / sum(nullif(t1.delivery_money, 0)) replenishment_average_delivery
  from (select to_char(t.kpi_date, 'yyyy') || '年' || to_char(t.kpi_date, 'mm') || '月' total_time,
               t.category, t.groupname, t.count_dimension, t.dimension_sort, t.delivery_money,
               t.delivery_order_money
          from scmdata.t_kpi_thismonth t ]' || v_where || q'[
           and to_char(t.kpi_date, 'yyyy-mm') = to_char(sysdate, 'yyyy-mm')
        union all
        select t.year || '年' || lpad(t.month, 2, 0) || '月' total_time,
               t.category, t.groupname, t.count_dimension, t.dimension_sort, t.delivery_money,
               t.delivery_order_money
          from scmdata.t_kpi_month t ]' || v_where || q'[
           and t.year || lpad(t.month, 2, 0) > ']' ||
                   v_min_date || q'['
           and t.year || lpad(t.month, 2, 0) <= ']' ||
                   v_max_date || q'[') t1
 group by total_time
 order by total_time ]';
   ELSE
     IF SUBSTR(V_TIME, -1) = '月' THEN
       V_C := SCMDATA.PKG_KPIPT_ORDER.F_KPI_MONTH(TOTAL_TIME => V_TIME);
       V_S := ' t.year||lpad(t.month, 2, 0) total_date,(t.year || ''年'' || lpad(t.month, 2, 0) || ''月'') ';
       V_F := ' from scmdata.t_kpi_month t';
     ELSIF SUBSTR(V_TIME, -2) = '季度' THEN
       V_C := SCMDATA.PKG_KPIPT_ORDER.F_KPI_QUARTER(TOTAL_TIME => V_TIME);
       V_S := ' t.year|| t.quarter total_date,(t.year || ''年第'' || t.quarter || ''季度'') ';
       V_F := ' from scmdata.t_kpi_quarter t';
     ELSIF SUBSTR(V_TIME, -2) = '半年' THEN
       V_C := SCMDATA.PKG_KPIPT_ORDER.F_KPI_HALFYEAR(TOTAL_TIME => V_TIME);
       V_S := ' t.year||t.halfyear total_date,(t.year || ''年'' ||  decode(t.halfyear,1,''上'',2,''下'')  || ''半年'') ';
       V_F := ' from scmdata.t_kpi_halfyear t';
     ELSIF LENGTH(V_TIME) = '5' THEN
       V_C := SCMDATA.PKG_KPIPT_ORDER.F_KPI_YEAR(TOTAL_TIME => V_TIME);
       V_S := ' t.year total_date,(t.year || ''年'') ';
       V_F := ' from scmdata.t_kpi_year t';
     END IF;
     V_MAX_DATE := SCMDATA.PARSE_JSON(V_C, 'COL_1');
     V_MIN_DATE := SCMDATA.PARSE_JSON(V_C, 'COL_2');
     V1_WHERE   := ' where total_date >= ''' || V_MIN_DATE ||
                   ''' and total_date <= ''' || V_MAX_DATE || ''' ';
     V_SQL      := ' select total_time,total_date,
       sum(t1.delivery_order_money) / sum(nullif(t1.delivery_money, 0)) replenishment_average_delivery
  from ( select ' || v_s ||
                   'total_time,t.category,t.groupname,t.count_dimension,t.dimension_sort,t.delivery_money,
            t.delivery_order_money ' || v_f ||
                   v_where || ' ) t1 ' || v1_where || '
 group by total_time,total_date
 order by total_time';
   END IF;
   RETURN V_SQL;

 END F_KPI_171_SELECTSQL;

END PKG_KPIPT_ORDER;
/

