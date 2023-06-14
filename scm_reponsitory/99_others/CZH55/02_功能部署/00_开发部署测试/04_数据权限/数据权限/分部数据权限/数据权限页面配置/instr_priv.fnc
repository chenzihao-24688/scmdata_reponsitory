CREATE OR REPLACE FUNCTION instr_priv(p_str1  VARCHAR2,
                                      p_str2  VARCHAR2,
                                      p_split VARCHAR2 DEFAULT ';')
  RETURN NUMBER IS
  v_str1  VARCHAR2(2000) := p_str1;
  v_str2  VARCHAR2(2000) := p_str2;
  v_count NUMBER := 0;
BEGIN
  IF v_str2 IS NULL THEN
    RETURN 0;
  ELSE
    IF instr(v_str2, p_split) > 0 THEN
      FOR str_rec IN (SELECT regexp_substr(v_str2, '[^'||p_split||']+', 1, LEVEL, 'i') AS str
                        FROM dual
                      CONNECT BY LEVEL <=
                                 length(v_str2) -
                                 length(regexp_replace(v_str2, p_split, '')) + 1) LOOP
      
        IF instr(v_str1, str_rec.str) > 0 THEN
          v_count := v_count + 1;
        ELSE
          NULL;
        END IF;
      END LOOP;
      IF v_count > 0 THEN
        RETURN 1;
      ELSE
        RETURN 0;
      END IF;
    ELSE
      IF instr(v_str1, v_str2) > 0 THEN
        RETURN 1;
      ELSE
        RETURN 0;
      END IF;
    END IF;
  END IF;

END instr_priv;
/
