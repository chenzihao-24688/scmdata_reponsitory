CREATE OR REPLACE PACKAGE SCMDATA.pkg_delivery_date IS
   function date_w(V_D in date) return number;
   function date_y(V_D in date) return number;
END pkg_delivery_date;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_delivery_date IS

  function date_w(V_D in date) return number is
    V_W number;
    V_P number;
    V_Y number;
  begin
    V_Y := to_char(V_D, 'yyyy');
    V_P := to_char(trunc(to_date(to_char(V_D, 'yyyy-MM-dd'), 'YYYY-MM-DD'),
                         'IW') + 6,
                   'yyyy');
    if V_Y <> V_P then
      V_W := 01;
      return V_W;
    else
      V_W := to_char(V_D + to_char(trunc(V_D, 'yyyy'), 'd') - 2, 'WW');
      return V_W;
    end if;
  end date_w;

  function date_y(V_D in date) return number is
    V_P number;
    V_Y number;
  begin
    V_Y := to_char(V_D, 'yyyy');
    V_P := to_char(trunc(to_date(to_char(V_D, 'yyyy-MM-dd'), 'YYYY-MM-DD'),
                         'IW') + 6,
                   'yyyy');
    if V_Y <> V_P then
      V_Y := V_P;
      return V_Y;
    else
      V_Y := to_char(V_D, 'yyyy');
      return V_Y;
    end if;
  end date_y;

END pkg_delivery_date;
/

