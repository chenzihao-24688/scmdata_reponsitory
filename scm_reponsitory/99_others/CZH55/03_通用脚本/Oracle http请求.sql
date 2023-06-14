DECLARE
  req            utl_http.req;
  resp           utl_http.resp;
  VALUE          VARCHAR2(1024); -- URL to post to
  v_url          VARCHAR2(4000) := 'http://172.28.108.55:8001/material/mrpTemporarySupplierArchives/select/name?name=1';
  v_param        VARCHAR2(4000) := '1';
  v_param_length NUMBER := lengthb(v_param);
BEGIN
  dbms_output.enable(buffer_size => NULL);
  req := utl_http.begin_request(url => v_url, method => 'GET');
  utl_http.set_body_charset('UTF-8');
  utl_http.set_header(r     => req,
                      NAME  => 'Content-Type',
                      VALUE => 'application/x-www-form-urlencoded');
  utl_http.set_header(req, 'Keep-Alive', ' timeout=1');
  utl_http.set_header(r     => req,
                      NAME  => 'Content-Length',
                      VALUE => v_param_length);
  utl_http.write_raw(r => req, data => utl_raw.cast_to_raw(v_param));
  resp := utl_http.get_response(req);
  LOOP  
    utl_http.read_line(resp, VALUE, TRUE); 
    dbms_output.put_line(VALUE); 
  END LOOP;
  utl_http.end_response(resp);
EXCEPTION
  WHEN utl_http.end_of_body THEN
    utl_http.end_response(resp);  
END;
