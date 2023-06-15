create or replace function scmdata.f_sentence_append_rc(v_sentence   in clob,
                                                        v_appendstr  in varchar2,
                                                        v_middliestr in varchar2)
  return clob is
  v_retst clob := v_sentence;
begin
  if v_appendstr is not null then
    if v_retst is null then
      v_retst := v_appendstr;
    else
      v_retst := v_retst || v_middliestr || v_appendstr;
    end if;
  end if;

  return v_retst;
end f_sentence_append_rc;
/

