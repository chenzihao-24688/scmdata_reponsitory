CREATE OR REPLACE PACKAGE SCMDATA.PKG_KPIPT_ORDER_PROC IS

/*分部*/
  /*时间维度：月度*/
 procedure p_t_kpiorder_month_proc(t1_type number,p1_type number);
  /*时间维度：季度 */
 procedure p_t_kpiorder_quarter_proc(t1_type number,p1_type number);
  /*时间维度：半年度 */
 procedure p_t_kpiorder_halfyear_proc(t1_type number,p1_type number);
  /*时间维度：年度 */
 procedure p_t_kpiorder_year_proc(t1_type number,p1_type number);

/*区域组*/
  /*时间维度：月度*/
  procedure p_t_kpiorder_qu_month_proc(t1_type number,p1_type number);
  /*时间维度：季度 */
  procedure p_t_kpiorder_qu_quarter_proc(t1_type number,p1_type number);
  /*时间维度：半年度 */
  procedure p_t_kpiorder_qu_halfyear_proc(t1_type number,p1_type number);
  /*时间维度：年度 */
  procedure p_t_kpiorder_qu_year_proc(t1_type number,p1_type number);

END PKG_KPIPT_ORDER_PROC;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.PKG_KPIPT_ORDER_PROC IS

/*分部*/
  /*时间维度：月度*/
  procedure p_t_kpiorder_month_proc(t1_type number,p1_type number) is
  begin
    pkg_kpipt_order.p_t_kpiorder_month(t_type => t1_type,p_type =>p1_type );
  end p_t_kpiorder_month_proc;

  /*时间维度：季度 */
  procedure p_t_kpiorder_quarter_proc(t1_type number,p1_type number) is
  begin
    pkg_kpipt_order.p_t_kpiorder_quarter(t_type => t1_type,p_type =>p1_type);
  end p_t_kpiorder_quarter_proc;

  /*时间维度：半年度 */
  procedure p_t_kpiorder_halfyear_proc(t1_type number,p1_type number) is
  begin
    pkg_kpipt_order.p_t_kpiorder_halfyear(t_type => t1_type,p_type =>p1_type);
  end p_t_kpiorder_halfyear_proc;

  /*时间维度：年度 */
  procedure p_t_kpiorder_year_proc(t1_type number,p1_type number) is
  begin
    pkg_kpipt_order.p_t_kpiorder_year(t_type => t1_type,p_type =>p1_type);
  end p_t_kpiorder_year_proc;

/*区域组*/
  /*时间维度：月度*/
  procedure p_t_kpiorder_qu_month_proc(t1_type number,p1_type number) is
  begin
    pkg_kpipt_order.p_t_kpiorder_qu_month(t_type => t1_type,p_type => p1_type );
  end p_t_kpiorder_qu_month_proc;

  /*时间维度：季度 */
  procedure p_t_kpiorder_qu_quarter_proc(t1_type number,p1_type number) is
  begin
    pkg_kpipt_order.p_t_kpiorder_qu_quarter(t_type => t1_type,p_type => p1_type);
  end p_t_kpiorder_qu_quarter_proc;

  /*时间维度：半年度 */
  procedure p_t_kpiorder_qu_halfyear_proc(t1_type number,p1_type number) is
  begin
    pkg_kpipt_order.p_t_kpiorder_qu_halfyear(t_type => t1_type,p_type => p1_type);
  end p_t_kpiorder_qu_halfyear_proc;

  /*时间维度：年度 */
  procedure p_t_kpiorder_qu_year_proc(t1_type number,p1_type number) is
  begin
    pkg_kpipt_order.p_t_kpiorder_qu_year(t_type => t1_type,p_type => p1_type);
  end p_t_kpiorder_qu_year_proc;

END PKG_KPIPT_ORDER_PROC;
/

