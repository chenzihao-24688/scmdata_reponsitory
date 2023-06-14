BEGIN
  DELETE FROM SCMDATA.T_EXPORT;
  COMMIT;
  SCMDATA.PKG_EXPORT_ITEM_AND_ELEMENT.P_GET_ALL_DATA_FROM_ROOTITEM(ROOT_ITEMID => 'a_check_100',
                                                                   OPERATOR => 'zc314',
                                                                   OPER_TIME => SYSDATE);
  COMMIT;
END;
