BEGIN
  insert into bw3.sys_Field_List_File t values('1','','bmp,jpg,png,tif,gif,pcx,tga,exif,fpx,svg,psd,cdr,pcd,dxf,ufo,eps,ai,raw,WMF,webp,avif,apng,jpeg','ASK_FILES_SP');
  UPDATE bw3.sys_detail_group t
     SET t.clo_names = 'certificate_file_sp,ASK_FILES_SP,SUPPLIER_GATE,SUPPLIER_OFFICE,SUPPLIER_SITE,SUPPLIER_PRODUCT'
   WHERE t.item_id IN ('a_supp_151', 'a_supp_161', 'a_supp_171')
     AND t.seq_no = 4;
END;
