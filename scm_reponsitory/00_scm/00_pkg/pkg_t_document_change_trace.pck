CREATE OR REPLACE PACKAGE SCMDATA.pkg_t_document_change_trace IS
  --查询 T_DOCUMENT_CHANGE_TRACE
  FUNCTION f_query_t_document_change_trace RETURN CLOB;
  
  --新增 T_DOCUMENT_CHANGE_TRACE
  PROCEDURE p_insert_t_document_change_trace(p_t_doc_rec t_document_change_trace%ROWTYPE);

  --修改 T_DOCUMENT_CHANGE_TRACE
  PROCEDURE p_update_t_document_change_trace(p_t_doc_rec t_document_change_trace%ROWTYPE);

  --删除 T_DOCUMENT_CHANGE_TRACE
  PROCEDURE p_delete_t_document_change_trace(p_t_doc_rec t_document_change_trace%ROWTYPE);

END pkg_t_document_change_trace;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_t_document_change_trace IS
  --查询 T_DOCUMENT_CHANGE_TRACE
  FUNCTION f_query_t_document_change_trace RETURN CLOB IS
    v_sql CLOB;  
  BEGIN
    v_sql := '
SELECT t.id, --主键
       t.company_id, --企业ID（品牌方）
       t.document_id, --单据ID
       t.operate_company_id, --操作方企业ID
       t.data_source_parent_code, --来源父级编码（取对应数据字典）
       t.data_source_child_code, --来源子级编码（取对应数据字典）
       t.create_id, --创建人
       t.create_time, --创建时间
       t.update_id, --修改人
       t.update_time, --修改时间
       t.memo --备注
  FROM t_document_change_trace t
 WHERE 1 = 1
';
    RETURN v_sql;
  END f_query_t_document_change_trace;

  --新增 T_DOCUMENT_CHANGE_TRACE
  PROCEDURE p_insert_t_document_change_trace(p_t_doc_rec t_document_change_trace%ROWTYPE) IS
  BEGIN 
    INSERT INTO t_document_change_trace
      (id, company_id, document_id, operate_company_id,
       data_source_parent_code, data_source_child_code, create_id,
       create_time, update_id, update_time, memo)
    VALUES
      (p_t_doc_rec.id, p_t_doc_rec.company_id, p_t_doc_rec.document_id,
       p_t_doc_rec.operate_company_id, p_t_doc_rec.data_source_parent_code,
       p_t_doc_rec.data_source_child_code, p_t_doc_rec.create_id,
       p_t_doc_rec.create_time, p_t_doc_rec.update_id,
       p_t_doc_rec.update_time, p_t_doc_rec.memo);
  END p_insert_t_document_change_trace;

  --修改 T_DOCUMENT_CHANGE_TRACE
  PROCEDURE p_update_t_document_change_trace(p_t_doc_rec t_document_change_trace%ROWTYPE) IS
  BEGIN
    UPDATE t_document_change_trace t
       SET t.operate_company_id      = p_t_doc_rec.operate_company_id, --操作方企业ID
           t.data_source_parent_code = p_t_doc_rec.data_source_parent_code, --来源父级编码（取对应数据字典）
           t.data_source_child_code  = p_t_doc_rec.data_source_child_code, --来源子级编码（取对应数据字典）
           t.update_id               = p_t_doc_rec.update_id, --修改人
           t.update_time             = p_t_doc_rec.update_time, --修改时间
           t.memo                    = p_t_doc_rec.memo --备注
     WHERE t.company_id = p_t_doc_rec.company_id
       AND t.document_id = p_t_doc_rec.document_id;
  END p_update_t_document_change_trace;

  --删除 T_DOCUMENT_CHANGE_TRACE
  PROCEDURE p_delete_t_document_change_trace(p_t_doc_rec t_document_change_trace%ROWTYPE) IS
  BEGIN
  
    DELETE FROM t_document_change_trace t WHERE t.id = p_t_doc_rec.id;
  END p_delete_t_document_change_trace;

END pkg_t_document_change_trace;
/

