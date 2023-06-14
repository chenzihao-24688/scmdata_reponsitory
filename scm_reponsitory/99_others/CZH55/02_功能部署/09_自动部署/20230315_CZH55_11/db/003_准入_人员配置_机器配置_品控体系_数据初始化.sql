--ar人员配置，机器配置，品控体系初始化
BEGIN
  FOR ar_rec IN (SELECT * FROM scmdata.t_ask_record ar WHERE 1 = 1) LOOP
    scmdata.pkg_ask_record_mange.p_generate_person_machine_config(p_company_id    => ar_rec.be_company_id,
                                                                  p_user_id       => ar_rec.create_id,
                                                                  p_ask_record_id => ar_rec.ask_record_id);
  END LOOP;
END;
/
--fa人员配置，机器配置，品控体系初始化
BEGIN
  FOR fa_rec IN (SELECT * FROM scmdata.t_factory_ask fa WHERE 1 = 1) LOOP
    scmdata.pkg_ask_record_mange_a.p_generate_person_machine_config(p_company_id     => fa_rec.company_id,
                                                                    p_user_id        => fa_rec.create_id,
                                                                    p_factory_ask_id => fa_rec.factory_ask_id,
                                                                    p_ask_record_id  => fa_rec.ask_record_id);
  END LOOP;
END;
/
--fr
declare
  v_company_id varchar2(32) := 'b6cc680ad0f599cde0531164a8c0337f';
begin
  ---人员配置
  declare
    v_t_per_rec scmdata.t_person_config_fr%ROWTYPE;
  begin
    for i in (select t.factory_report_id,
                     decode(t.worker_num,
                            null,
                            nvl(tfa.worker_num, 0),
                            nvl(t.worker_num, 0)) worker_num
                from scmdata.t_factory_report t
               inner join scmdata.t_factory_ask tfa
                  on tfa.company_id = t.company_id
                 and tfa.factory_ask_id = t.factory_ask_id
               where t.company_id = v_company_id
                 and not exists
               (select 1
                        from scmdata.t_person_config_fr t1
                       where t1.factory_report_id = t.factory_report_id)) loop
      for p_t_per_rec in (select *
                            from scmdata.t_person_config t
                           WHERE t.company_id = v_company_id
                           ORDER BY t.seqno ASC) loop
      
        v_t_per_rec.person_config_id  := scmdata.f_get_uuid();
        v_t_per_rec.company_id        := v_company_id;
        v_t_per_rec.person_role_id    := p_t_per_rec.person_role_id;
        v_t_per_rec.department_id     := p_t_per_rec.department_id;
        v_t_per_rec.person_job_id     := p_t_per_rec.person_job_id;
        v_t_per_rec.apply_category_id := p_t_per_rec.apply_category_id;
        v_t_per_rec.job_state         := p_t_per_rec.job_state;
        v_t_per_rec.person_num        := 0;
        v_t_per_rec.seqno             := p_t_per_rec.seqno;
        v_t_per_rec.pause             := 0;
        v_t_per_rec.remarks           := NULL;
        v_t_per_rec.update_id         := 'admin';
        v_t_per_rec.update_time       := sysdate;
        v_t_per_rec.create_id         := 'admin';
        v_t_per_rec.create_time       := sysdate;
        v_t_per_rec.factory_report_id := i.factory_report_id;
        scmdata.pkg_ask_mange.p_insert_t_person_config_fr(p_t_per_rec => v_t_per_rec);
      end loop;
      update scmdata.t_person_config_fr t
         set t.person_num = i.worker_num
       where t.factory_report_id = i.factory_report_id
         and t.person_job_id = 'ROLE_01_01_01';
    end loop;
  
  end person_config_fr;

  --机器配置
  declare
    v_t_mac_rec scmdata.t_machine_equipment_fr%ROWTYPE;
  begin
    for i in (select t.factory_report_id
                from scmdata.t_factory_report t
               where t.company_id = v_company_id
                 and not exists
               (select 1
                        from scmdata.t_machine_equipment_fr t1
                       where t1.factory_report_id = t.factory_report_id)) loop
      for p_t_mac_rec in (select *
                            from scmdata.t_machine_equipment t
                           where t.company_id = v_company_id
                             and t.template_type = 'TYPE_00'
                             ORDER BY t.seqno ASC) loop
        v_t_mac_rec.machine_equipment_id  := scmdata.f_get_uuid();
        v_t_mac_rec.company_id            := v_company_id;
        v_t_mac_rec.equipment_category_id := p_t_mac_rec.equipment_category_id;
        v_t_mac_rec.equipment_name        := p_t_mac_rec.equipment_name;
        v_t_mac_rec.machine_num           := 0;
        v_t_mac_rec.seqno                 := p_t_mac_rec.seqno;
        v_t_mac_rec.orgin                 := 'AA';
        v_t_mac_rec.pause                 := 0;
        v_t_mac_rec.remarks               := null;
        v_t_mac_rec.update_id             := 'admin';
        v_t_mac_rec.update_time           := SYSDATE;
        v_t_mac_rec.create_id             := 'admin';
        v_t_mac_rec.create_time           := SYSDATE;
        v_t_mac_rec.factory_report_id     := i.factory_report_id;
      
        scmdata.pkg_ask_mange.p_insert_t_machine_equipment_fr(p_t_mac_rec => v_t_mac_rec);
      end loop;
    end loop;
  end machine_equipment_fr;

  --品控体系配置
  declare
    v_t_qua_rec scmdata.t_quality_control_fr%ROWTYPE;
  begin
    for i in (select t.factory_report_id
                from scmdata.t_factory_report t
               where t.company_id = v_company_id
                 and not exists
               (select 1
                        from scmdata.t_quality_control_fr t1
                       where t1.factory_report_id = t.factory_report_id)) loop
      for p_t_mac_rec in (select *
                            from scmdata.t_quality_control t
                           where t.company_id = v_company_id
                           ORDER BY t.seqno ASC) loop
        v_t_qua_rec.quality_control_id      := scmdata.f_get_uuid();
        v_t_qua_rec.company_id              := v_company_id;
        v_t_qua_rec.department_id           := p_t_mac_rec.department_id;
        v_t_qua_rec.quality_control_link_id := p_t_mac_rec.quality_control_link_id;
        v_t_qua_rec.seqno                   := p_t_mac_rec.seqno;
        v_t_qua_rec.pause                   := 0;
        v_t_qua_rec.remarks                 := NULL;
        v_t_qua_rec.update_id               := 'admin';
        v_t_qua_rec.update_time             := SYSDATE;
        v_t_qua_rec.create_id               := 'admin';
        v_t_qua_rec.create_time             := SYSDATE;
        v_t_qua_rec.factory_report_id       := i.factory_report_id;
      
        scmdata.pkg_ask_mange.p_insert_t_quality_control_fr(p_t_qua_rec => v_t_qua_rec);
      end loop;
    end loop;
  end quality_control_fr;

end;
/
--sp人员配置，机器配置，品控体系初始化
DECLARE
  v_cnt               INT;
  v_factory_report_id VARCHAR2(32);
BEGIN
  FOR sp_rec IN (SELECT * FROM scmdata.t_supplier_info sp WHERE 1 = 1) LOOP
    IF sp_rec.supplier_info_origin = 'MA' THEN
      scmdata.pkg_supplier_info_a.p_generate_person_machine_config(p_company_id => sp_rec.company_id,
                                                                   p_user_id    => sp_rec.create_id,
                                                                   p_sup_id     => sp_rec.supplier_info_id);
    ELSE
      SELECT COUNT(1), MAX(fr.factory_report_id)
        INTO v_cnt, v_factory_report_id
        FROM scmdata.t_factory_ask t
       INNER JOIN scmdata.t_factory_report fr
          ON fr.factory_ask_id = t.factory_ask_id
         AND fr.company_id = t.company_id
       WHERE t.factory_ask_id = sp_rec.supplier_info_origin_id
         AND t.company_id = sp_rec.company_id;
      IF v_cnt > 0 THEN
        scmdata.pkg_supplier_info_a.p_generate_person_machine_quality_config_fr(p_company_id        => sp_rec.company_id,
                                                                                p_user_id           => sp_rec.create_id,
                                                                                p_factory_report_id => v_factory_report_id,
                                                                                p_supp_id           => sp_rec.supplier_info_id);
      ELSE
        scmdata.pkg_supplier_info_a.p_generate_person_machine_config_fa(p_company_id     => sp_rec.company_id,
                                                                        p_user_id        => sp_rec.create_id,
                                                                        p_factory_ask_id => sp_rec.supplier_info_origin_id,
                                                                        p_supp_id        => sp_rec.supplier_info_id);
      END IF;
    END IF;
  END LOOP;
END;
/
