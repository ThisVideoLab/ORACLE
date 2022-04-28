-- �ְ� ������ ���� (sys) : ������ ������ �� �ִ� ������ ����

-- ���̵� : usertest 01 , ��ȣ : 1234
create user usertest01 identified by 1234;

-- ������ ��ȣ�� �����ߴٰ� �ؼ� ����Ŭ�� ������ �� �ִ� ���� �ƴ�
-- ������ �� �ִ� ������ �ο��޾ƾ� ��μ� ������ ������,.

-- System Privileages
    -- Create Session: ����Ŭ�� ������ �� �ִ� ����
    -- Create table: ����Ŭ���� ���̺��� ������ �� �ִ� ����
    -- Create sequence: �������� ������ �� �ִ� ����
    -- Create view: �並 ������ �� �ִ� ����
    
/* ������ �������� ����Ŭ�� ������ �� �ִ� Create Session ������ �ο���

DDL: ��ü ����(Create, Alter, Drop)
DML: ���ڵ� ����( Insert, Update, Delete)
DQL: ���ڵ� �˻� (Select)
DTL: Ʈ����� (Begin transaction, rollback, commit)
DCL: ���Ѱ��� (Grant, Revoke, Deny)

*/
grant create session to usertest01; -- ����Ŭ ���� ����    
grant create table to usertest01; -- ���̺� ���� ����
-- �̻��¿��� crate table �� ����ؼ� ���̺� ������ �õ��ϸ� ���� ������ ��µ�.

/* ���̺� �����̽� (table space)

    ��ü (���̺�, ��, ������, �ε���, Ʈ����, ���� ���ν���, �Լ� ���)�� �����ϴ� ������
    ���̺� �����̽���� Ī��. ������ �������� �� ����ں� ���̺� �����̽��� Ȯ����.

*/

select * from dba_users; -- db�� ��ϵ� user���� ����� �����.
-- �̷��� ��µǴ� ��� �߿��� default_tablespace�� temporary_tablespace�� ������.
-- default_tablespace�� �Ϲ� ������ ������ �� ����, �ְ� �����ڸ� ���� ������ ������.
-- ������ ������ temporary_tablespace ���� ������ ������.

select username, default_tablespace as dataFile, temporary_tablespace as logFile
from dba_users
where username in ('HR','USERTEST01');

/*
USERNAME   |DATEFILE | LOGFILE
---------------------------------
USERTEST01 |SYSTEM	 | TEMP
HR	       | USERS	 | TEMP

�̿� ���� ������� ����� ��. �׷��� ���⼭ ������ ���̺� �����̽��� ��������� ��.
SYSTEM�� �ɷ��ִ� default_tablespace AS DATAFILE�� USERS�� �ٲ���� ��μ�
���̺� ������ ��������. �ڵ�� ������ ����
*/

ALTER user usertest01
default tablespace users
temporary tablespace temp;
-- ���� �ٽ� SQL CMD���� create table�� �õ������� ���� ������ ��µ�

-- �������� users ���̺� �����̽��� ����� �� �ִ� ���� �Ҵ�.

alter user usertest01
quota 2m on users;

=============================
����) usertest02 ������ ���� �ڿ� user ���̺� �����̽����� ���̺� tbl2 ���� �� insert �ƹ��ų�

create user usertest02 identified by 1234; -- ���� ����
grant create session to usertest02; -- ����Ŭ ���� ����    
grant create table to usertest02; -- ���̺� ���� ����
-- �������� grant create session, create table to usertest02;
ALTER user usertest02
default tablespace users
temporary tablespace temp;  -- usertest02���� default tablespace ��� temporary tablespace ������ �Ҵ�.
alter user usertest02 
quota 2m on users; --  usertest02���� default tablespace ������ 2mb �Ը��� ��ü ���� ���� �Ҵ�
--------------------------------------

select * from all_tables; -- ���̺��� �����ָ� ����ϴ� �ڵ�
select * from all_tables
where owner in ('HR','USERTEST01','USERTEST02');
