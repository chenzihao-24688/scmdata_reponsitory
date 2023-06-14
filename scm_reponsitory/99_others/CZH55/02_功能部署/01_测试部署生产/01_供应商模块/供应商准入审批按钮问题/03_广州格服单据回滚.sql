begin
update scmdata.t_factory_ask_oper_log t set t.status_af_oper = 'FA02'  where t.log_id = 'd33810f438e5ae93e0531164a8c00298';
update scmdata.t_factory_ask t set t.factrory_ask_flow_status = 'FA02' where t.factory_ask_id = 'CA2112153702337685' and t.company_id = 'b6cc680ad0f599cde0531164a8c0337f';
end;
