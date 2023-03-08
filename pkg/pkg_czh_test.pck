CREATE OR REPLACE PACKAGE pkg_czh_test IS

-- Author  : SANFU
-- Created : 2023/3/8 10:59:48
-- Purpose : 
FUNCTION f_test RETURN VARCHAR2;
END pkg_czh_test;
/
CREATE OR REPLACE PACKAGE BODY pkg_czh_test IS

  FUNCTION f_test RETURN VARCHAR2 IS
  BEGIN
    IF 1 = 1 THEN
      NULL;
      END IF;
    RETURN '456456123123123';
  END;
END pkg_czh_test;
/
