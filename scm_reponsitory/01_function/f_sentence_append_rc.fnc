CREATE OR REPLACE FUNCTION SCMDATA.f_sentence_append_rc(v_sentence   IN CLOB,
                                                        v_appendstr  IN VARCHAR2,
                                                        v_middliestr IN VARCHAR2)
  RETURN CLOB IS
  v_retst CLOB := v_sentence;
BEGIN
  IF v_appendstr IS NOT NULL THEN
    IF v_retst IS NULL THEN
      v_retst := v_appendstr;
    ELSE
      v_retst := v_retst || v_middliestr || v_appendstr;
    END IF;
  END IF;

  RETURN v_retst;
END f_sentence_append_rc;
/

