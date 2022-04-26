-- 7���� ��������

-- ���̺� ����: ���̺��� ��ü�� ������
--            ���̺��� �����ϸ�, �÷��� ���ڵ常 ���簡 ��
--            ���̺��� �Ҵ�� ���������� ������� �ƴ���
--            (alter table�� ����� ���� �Ҵ��� �־�� ��)

-- ��������: �÷��� �Ҵ�Ǿ �Է¹޴� �����Ͱ��� ������ ���Ἲ�� üũ��
--          NOT NULL, Primary Key, Unique, Foreign key, Check ���

Create table dept_copy
as
select * from dept;

select * from dept_copy;

Create table emp_copy
as
select * from employee;

-- ���̺� ���� : Ư�� �÷��� �����ϱ�

create table emp_second
as
select eno, ename, salary, dno from employee;

select * from emp_second;

-- ���̺� ���� :������ ����ؼ� �����ϱ�
create table emp_third
as
select eno, ename, salary
from employee
where salary > 3000;

select * from emp_third;

-- ���̺� ���� :�÷����� �ٲ㼭 �����ϱ�
create table emp_fourth
as
select * from emp_fourth;


select �����ȣ, �����, ���� from emp_fourth; -- �����ö� �÷����� �ѱ۷� �مf�ٸ�
    -- ������ �� �ѱ۸� �÷� �̸��� ������ ��. �׷��� �ݵ�� �� ��Ī���� ����ؾ� ��

create table emp_fifth
as
select eno �����ȣ, ename �����, salary ����
from employee

select * from emp_fifth;

--���̺� ����: ���ڵ�� �״�� �ΰ� Ʋ���� �����ϴ� ���

create table emp_sixth
as
select * from employee
where 0=1  -- where whrjs : false�� ����

select * from emp_sixth;

--���̺� ���� : Alter Table

create table dept20
as
select * from department;

desc dept20;


--������ ���̺� �÷��� �߰���, �� �� �ݵ�� �߰��� �÷��� NULL�� ����ؾ� ��
Alter Table dept20
add(birth date);

Alter Table dept20
add (email varchar2 (100));

Alter Table dept20
add (address varchar2 (200));

-- �÷��� �ڷ��� ����

Alter Table dept20
modify dname varchar2 (100);

Alter Table dept20
modify dno number (4);

Alter Table dept20
modify address varchar2 (200);

-- Ư�� �÷� ����: �÷� ������ ������ �ٷ��� ���ϸ� �߻���Ŵ ( ���� �����ð� �ܿ� �۾���)
Alter Table dept20
drop COLUMN birth;

Alter Table dept20
drop COLUMN email;

-- �������϶� Ư�� �÷��� �����ϴ� ���
-- set unused: �������̶�� Ư�� �÷��� ��� ������Ŵ
-- drop unused column: ��������� �÷� �ϰ� ����

Alter Table dept20
set unused (address);

Alter Table dept20
set unused (address); -- ��� ���� ���·θ� ������, ��Ͽ� ������ �����ϱ� ��

Alter Table dept20
drop unused COLUMNS; -- ������� �÷����� ��� �����. 

-- �÷� �̸� ����

Alter Table dept20
rename column LOC TO LOCATIONS;

Alter Table dept20
rename column DNO TO DEPART_NUMBER;

-- ���̺� �̸� ����

Rename dept20 to dept30; 
Rename dept30 to dept20; -- ���Ǹ� ���� �ǵ��� ����

-- ���̺� ����

drop table dept20;

/*
DDL: Create(����), Alter(����), Drop(����)
     ��ü�� ����, ����, �����Ҷ� ����ϴ� ���� DDL��
     ��ü: ���̺�, ��, �ε���, Ʈ����, ������, �Լ�. ���� ���ν��� ���

DML: Insert(���ڵ� �߰�), Update(���ڵ� ����), Delete (���ڵ� ����)
    << ���̺��� ��(���ڵ�, �ο�) >>

DQL: select 

���̺��� �����̳� ���̺� ��ü�� �����ϴ� ���
1. delete: ���̺��� ���ڵ带 ����, where�� ������� ���� �� ��� ���ڵ带 ������. ���̺��� ������. <<�Ϲ�����>>
2. truncate: ���̺��� ���ڵ带 ����, ������ ���� �ӵ��� �ڶ���. ���̺��� ������. <<��������>>
3. drop: ���̺� ��ü �Ǵ� ��Ī�� ���̺� �÷����� �Բ� ��������. <<��ũ ������>>
    
*/

create table emp10
as
select * from employee;

select * from emp10;
desc dept20;

--�ǽ��غ���
create table emp20
as
select * from employee;

create table emp30
as
select * from employee;

-- emp10: delete�� ����ؼ� ����

delete emp10;
select * from emp10; -- ���̺��� ��������
commit;

-- emp20: truncate�� ����ؼ� ����
truncate table emp20;
select * from emp20; -- ���̺��� ��������
commit;

-- emp30: drop�� ����ؼ� ����

drop table emp30;
select * from emp30; -- ���̺��� ��������
commit;

drop table emp_copy;


/* 

������ ����: �ý����� ���� ������ ������ִ� ���̺�
    user_: �ڽ��� ������ ���� ��ü ������ ���
     all_: �ڽ��� ������ ������ ��ü�� ������ �ο� ���� ��ü ������ �����
     dba_: ����Ÿ ���̽� �����ڸ� ���� ������ ��ü ������ �����
     
*/
-- sys ���� ��ɾ�

select * from dba_tables; 
select * from dba_views;
select * from dba_constraints;
select * from dba_sequences;

-- user ��ɾ�

show user;

select * from all_tables; -- �ο����� ���� ������ ������ ��� ���̺��� �����
select * from all_views;

select * from user_tables;  -- ����ڰ� ������ ���̺� ���� ���
select table_name from user_tables; 
select * from user_views; -- ����ڰ� ������ �信 ���� ����
select * from user_indexes; -- ����ڰ� ������ �ε��� ����
select * from user_constraints; -- ���� ���� Ȯ��
select * from user_sequences; --������ ������ �����

/* 
��������: ���̺��� ���Ἲ�� Ȯ���ϱ� ���� �÷��� �ο��Ǵ� ��Ģ
        
        1. Primary Key
        2. NOT NULL
        3. Unique
        4. Foreign key
        5. Check
        6. Default

*/

-- 1. Primary Key : �ߺ��� ���� ���� �� ����.  
--                  ���̺� ������ �÷� �� �ϳ����� �ο��� ������
--                  �������� �̸�: �������� ���� ��� Oracle���� ������ �̸����� ������
--                               ���������� ������ �� ���� ���� �̸��� ����ؼ� ������.
--                               ��� �̸� ����� �ִ� ���� ����.
--                               PK_customer01_id: Primary Key, customer01, id
--                               NN_customer01_id: Not Null, customer01(���̺��), id(�÷���)

create table customer01(
id varchar2(20) not null constraint PK_customer01_id Primary Key,
pwd varchar2(20) constraint NN_customer01_pwd not null,
name varchar2(20) constraint NN_customer01_name not null,
phone varchar2(30)null,
address varchar2(100)null
);

select * from user_constraints
where table_name = 'CUSTOMER01'; -- DB���� ã������ �ݵ�� �빮�ڷ� �˻�


create table customer02(
id varchar2(20) not null constraint PK_customer01_id Primary Key,
pwd varchar2(20) constraint NN_customer01_pwd not null,
name varchar2(20) constraint NN_customer01_name not null,
phone varchar2(30)null,
address varchar2(100)null
);

select * from user_contraints
where tabe_name = 'customer02'

--���̺��� �÷� ���� �� �������� �Ҵ�

create table customer03(
id varchar2(20) not null constraint PK_customer01_id Primary Key,
pwd varchar2(20) constraint NN_customer01_pwd not null,
name varchar2(20) constraint NN_customer01_name not null,
phone varchar2(30)null,
address varchar2(100)null,
constraints PK_customer01_id Primary key (id) -- �̿� ���� �ڿ��� �Ҵ��� ������
);

/*
foreign key (����Ű): �ٸ� ���̺�(�θ�)�� Primary Key, Unique �÷��� �����ؼ� ���� �Ҵ���
check: �÷��� ���� �Ҵ��� ��  check�� ����س��� ���ǿ� �����ϴ� ������ �Է¹���.
*/

-- �θ����̺�

create table ParentTbl(
    name varchar2(20),
    age number(3) constraint CK_ParentTbl_age check (AGE > 0 AND AGE < 200),
    gender varchar(3) constraint CK_ParentTbl_gender check (gender IN ('M','W')), --check�ؼ� in ���� ���� �Է¹���
    infono number constraint PK_ParentTble_infono Primary Key
    );

desc parentTbl
select * from user_constraints
where table_name = 'PARENTTBL'

select * from ParentTbl;
insert into ParentTbl
values ('ȫ�浿', 30 ,'M', 1)

insert into ParentTbl
values ('��ʶ�', 50 ,'M', 2)

select * from ParentTbl;

-- �ڽ� ���̺� 

create table ChildTbl(
    id varchar2(40) constraint PK_ChildTbl_id Primary Key,
    pw varchar2(40),
    infono number,
    constraint FK_ChildTble_infono foreign key (infono) references ParentTbl(infono)
    );                                                  -- �������� : �θ����̺� ����
    
insert into ChildTbl
values ('aaa','1234',1); -- foriegn key ���� -> gender �� �ڸ���                                                                                                         

insert into ChildTbl
values ('bbb','1234',2);

select * from ChildTbl;
commit;

-- �θ����̺�

create table ParentTbl2(
    dno number(2) not null Primary key,
    dname varchar2(50),
    loc varchar2(50)
);

insert into ParentTbl2
values (10, 'SALES', 'SEOUL')

--�ڽ� ���̺�

create table childTbl2(
    no number not null,
    ename varchar2(50),
    dno number(2) not null,
    foreign key (dno) references ParentTbl2 (dno)
);

insert into childTbl2
values (1, 'Park', 10)

select * from childTbl2;

desc parentTbl
select * from user_constraints
where table_name = 'PARENTTBL'



-- default ���� ���� : ���� �Ҵ����� ������ default ���� �Ҵ絵��.

Create Table emp_sample01(
    eno number(4) not null primary key,
    ename varchar(50),
    salary number (7,2) default 1000
    );

-- default �÷��� ���� �Ҵ��� ���
insert into emp_sample01
values (1111, 'ȫ�浿', 1500);

-- default �÷��� ���� �Ҵ����� ���� ���
insert into emp_sample01 (eno, ename)
values (2222, 'ȫ��soon'); -- �Ϻη� default�� �ɸ� �÷��� �����ϰ� �� �Է��� �õ���

insert into emp_sample01
values (3333, 'ȫ��later', default); -- �̷��� ���� default�� ����Ҽ��� ����

select * from emp_sample01; -- �����Էµ� ���� salary �÷��� default�� �ɾ���� 1000�� �Էµ�


Create Table emp_sample02(
    eno number(4) not null primary key,
    ename varchar(50) default '�⺻�̸�',
    salary number (7,2) default 1000
    );

insert into emp_sample02 (eno)
values (10)

insert into emp_sample02
values (20, default, default)

select * from emp_sample02; 

/*

    Primary Key, Foreign Key, Unique, Check, Default, Not null

*/

create table member10(
    no number not null constraint PK_member10_no Primary Key,
    name varchar(50) constraint NN_member10_name Not null,
    birthday date default sysdate,
    age number(3) check (age > 0 and age <150),
    gender char(1) check ( gender in ('M','W')),
    dno number(2) unique 
    )
    
insert into member10
values (1, 'ȫ�浿', default, 30,'M', 10)

insert into member10
values (2, '������', default, 30,'M', 20)

select * from member10

create table orders10(
    no number not null primary key,
    p_no varchar(100) not null,
    p_name varchar(100) not null,
    price number check (price > 10),
    phone varchar(100) default '����',
    dno number(2) not null,
    foreign key (dno) references member10(dno)
    )

insert into orders10
values (1, '�±ر�', '������', 1000 , default, 10)

select * from orders10;

