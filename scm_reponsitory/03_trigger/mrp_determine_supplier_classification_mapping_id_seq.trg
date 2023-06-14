create or replace trigger scmdata.MRP_DETERMINE_SUPPLIER_CLASSIFICATION_MAPPING_id_seq
before insert on MRP_DETERMINE_SUPPLIER_CLASSIFICATION_MAPPING for each row 
begin 
        select MRP_DETERMINE_SUPPLIER_CLASSIFICATION_MAPPING_id_seq.nextval into :new.ID from dual; 
end;
/

