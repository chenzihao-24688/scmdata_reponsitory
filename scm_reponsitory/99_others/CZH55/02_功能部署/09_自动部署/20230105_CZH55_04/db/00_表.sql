ALTER TABLE scmdata.T_ABNORMAL ADD  orgin_type  VARCHAR2(32);
ALTER TABLE scmdata.T_ABNORMAL ADD   abnormal_orgin       VARCHAR2(32);
ALTER TABLE scmdata.T_ABNORMAL ADD   checker              VARCHAR2(512);
ALTER TABLE scmdata.T_ABNORMAL ADD   check_link           VARCHAR2(32);
ALTER TABLE scmdata.T_ABNORMAL ADD   check_num            NUMBER;
COMMENT on column scmdata.T_ABNORMAL.origin
  is '��Դ    MA:�ֶ�����  SC:ϵͳ�������ۿ��QC���桢QA�����Զ�������Ӧ�쳣����';
comment on column scmdata.T_ABNORMAL.origin_id
  is '��ԴID,����ԴΪMAʱ�����쳣��ID;   ����ԴΪSCʱ��������Դ���ʹ�ֵ��TD:�ۿID��QC:QC����ID��QA:QA����ID��';
comment on column scmdata.T_ABNORMAL.abnormal_range
  is '�쳣��Χ��00 ȫ����01 ָ��������02 ������ɫ-���ݶ�����ϸ��̬չʾ��';
comment on column scmdata.T_ABNORMAL.delivery_amount
  is '�ѽ�������';
comment on column scmdata.T_ABNORMAL.orgin_type
  is '����ԴΪMAʱ����ABN:�쳣��;   ����ԴΪSCʱ���������ʹ�ֵ��TD:�ۿ��QC:QC���棬QA:QA���棩';
comment on column scmdata.T_ABNORMAL.abnormal_orgin
  is '�쳣��Դ�������˶�Ӧ��������������';
comment on column scmdata.T_ABNORMAL.checker
  is '����ˣ�������Դ=ϵͳ�����ģ������=�����ˣ�������Դ=�ֶ������ģ��������ֵ��';
comment on column scmdata.T_ABNORMAL.check_link
  is '������ڣ� ������Դ=ϵͳ�����ģ��������ȡQC��������Ӧ�ֶΡ�������ڡ���������Դ=�ֶ������ģ��������ֵ��';
comment on column scmdata.T_ABNORMAL.check_num
  is '������Դ���ͼ�¼���/�ּ������1.����ԴΪQC�����¼QC������� 2.����ԴΪQAʱ����¼QA�ּ����  3.������Ϊ��';
/
