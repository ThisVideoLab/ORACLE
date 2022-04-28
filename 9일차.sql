-- 9���� ������ , �ε���,

/*
    ������ : �ڵ� ��ȣ �߻���
        -- ��ȣ�� �ڵ� �߻��� �Ǹ� �ڷ� �ǵ��� �� ����. (���� �� �ٽ� �����ؾ� �Ѵ�.)
*/

-- �ʱⰪ : 10 , ������ : 10
create sequence sample_seq
    increment by 10         -- ������
    start with 10;          -- �ʱⰪ
    
-- �������� ������ ����ϴ� ������ ����
select * from user_sequences;

select sample_seq.nextval from dual;    -- �������� ���� ���� ���
select sample_seq.currval from dual;    -- ���� �������� ���� ���

-- �ʱⰪ : 2 , ������ : 2
create sequence sample_seq2
    increment by 2
    start with 2
    nocache;                 -- ĳ���� ������� �ʰڴ�. (RAM)  -- ������ ���ϸ� �ٿ��ټ� �ִ�.
    
select sample_seq2.nextval from dual;
select sample_seq2.currval from dual;

-- �������� Primary Key�� �����ϱ�

create table dept_copy80
as
select * from department
where 0 = 1;

select * from dept_copy80;

-- ������ ���� : �ʱⰪ 10, ������ : 10
create sequence dept_seq
    increment by 10
    start with 10
    nocache;
    
    /* Sequence�� cache�� ����ϴ� ��� / ������� �ʴ� ��� */
        -- chche : ������ ������ ��� �ϱ� ���ؼ� ��� (�⺻�� : 20��)
        -- ������ �ٿ�� ��� :  ĳ���� �ѹ����� ��� ���󰣴�. ���ο� ���� �Ҵ� �޴´�.
        
    
insert into dept_copy80 (dno, dname, loc)
values (dept_seq.nextval , 'HR' , 'SEOUL');

select * from dept_copy80;

create sequence emp_seq_no;
    --increment by 1 -- �̷��� �ʱⰪ�� �������� ���� �ʾƵ� �⺻�� 1���� ���ۿ�
    --start with 1; -- �������� 1�� ���·� �ö󰣴�

create table emp_copy80
as
select * from employee
where 0 = 1;

select * from emp_copy80;

--�������� ���̺��� Ư�� �÷��� �����غ���

insert into emp_copy80 -- �������� ���� �ε��� ��ȣ ����
values (emp_seq_no.nextval,  'SMITH', 'SALESMAN', 2222, sysdate, 3000, 300, 20);

-- ������ �������� �����غ���

select * from user_sequences; -- emp_seq_no�� max_value : ���Ѵ�

alter sequence emp_seq_no
    maxvalue 1000; -- ������ �������� �ִ밪�� 1000���� ����
    
select * from user_sequences; -- �ٽ� �Է��غ��� 1000���� �Ǿ� ����.


alter sequence emp_seq_no
    cycle; -- ���������� �ִ밪�� ������ �Ŀ� �ٽ� �ʱⰪ���� ������
    
alter sequence emp_seq_no
    nocycle; -- ����Ŭ�� �������� ����.

drop sequence sample_seq;

/* INDEX

    -- �ε����� ���̺��� �÷��� ����, Ư�� �÷��� �˻��� ������ ����� �� �ֵ��� �Ѵ�.
    -- index page: �÷��� �߿� Ű���带 �ɷ��� ��ġ ������ ��Ƴ��� ������, db ������ 10% ����
    -- ���� (INDEX): å�� ����, å�� ������ �ֿ� Ű���庰�� �����ؼ� ������.
    -- ���̺� ��ĵ: ���ڵ��� ó�� ~ ���������� �˻� (�˻� �ӵ��� ����), �ε����� ������� �ʰ� �˻���
        - Index��  �����Ǿ� ���� ���� �÷��� ���̺� ��ĵ�� �ǽ���.
    -- primary key, Unique key�� ����� �÷��� Index page  �� �����Ǿ� �˻��� ������ �Ѵ�.
    -- where������ ���� �˻����ϴ� �÷��� index�� ����.
    -- ��� ���̺��� �˻��� �����ϴ� �÷��� ���� INDEX�� ��������. �ٸ� �߸� �����ϸ� �� ������
    
*/
    
-- index ������ ����Ǿ� �ִ� ������ ����
    -- user_columns, user_ind_columns
    
    select * from user_columns;
    select * from user_ind_columns; -- user index columns �� ����ǥ��
    
    select * from user_tab_columns
    where table_name in ('EMPLOYEE', 'DEPARTMENT');
    
    select index_name, table_name, column _name
    from user_ind_columns
    where table_name in ('EMPLOYEE', 'DEPARTMENT');
    
    select * from employee;

-- INDEX �ڵ� ���� (Primary key, Uniquie) �÷����� index page�� �ڵ����� ������.

create table tbl1(
a number (4) constraint PK_tbl1_a Primary Key,
b number (4),
c number (4)
)


select index_name, table_name, column_name
from user_ind_columns
where table_name in ('TBL1','TBL2','EMPLOYEE','DEPARTMENT');

select * from tbl1;

create table tbl2(
a number (4) constraint PK_tbl2_a Primary Key,
b number (4) constraint UK_tb12_b Unique, 
c number (4) constraint UK_tbl2_c Unique,
d number (4),
e number (4)
)

create table emp_copy90 -- ���ο� ���̺� emp_copy90 ����
as
select * from employee;

select * from emp_copy90; -- emp_copy90 ���̺� Ȯ��, �̻� ����

select index_name, table_name, column_name -- emp_copy90�� �ε����� ������ Ȯ��
from user_ind_columns
where table_name in ('EMP_COPY90');

select * from emp_copy90 -- emp_copy90�� ename �÷����� �ε����� �����Ƿ� ���̺� ��ĵ��
where ename = 'KING'; -- �ǽ��ؼ� ������ ���ʴ�� KING�� �˻���.
                      -- �۾��ð� 0.001�� �ҿ�. ��������� ���� ���ϰ� �߻���.

create index id_emp_copy90_ename -- �۾��ð� 0.018�� �ҿ�.
on emp_copy90 (ename);           -- ���� 0.001�ʿ� ���ϸ� ����� ���� ���ϰ� �߻���.

/*
    �ٸ� ���̺� �˻��� ����ø��� ������ ���ϸ� �߻���Ű�� ������, �ռ� ���ѹٿ� ���� ����
    �˻��ϴ� �÷��� ���ؼ� �ε����� �ɾ ���Ϸ��� ��Ʈ�� �� �� ����.
    �̷� �ε��� �����ÿ� ��������, �ݵ�� ���� ��뷮�� ���� �ð��뿡 �����ؾ� �Ѵٴ� ����.
    �׷��� ������ �߻��ϴ� ���� ���ϸ� ȿ�������� ������ �� ����.
*/

select * from emp_copy90 
where ename = 'KING'; -- �� ������ �巡�� �� �Ŀ� F10 �Ǵ� ��� ���� ��ư ����  ��°��
-- �ִ� ��ȹ ���� ��ư�� ��������, �ش� ���̺��� kING�̶�� �÷��� ã�µ� � �����
-- ����� �������� ���� ������ ����. ����� �߰��� INDEX�� ���� ã�´ٰ� ����.

select * from emp_copy90  -- �ݴ�� �ε����� �߰����� ���� �� ������ �巡���ؼ� ��ȹ ������
where job ='SALESMAN';  -- ���� ���̺� ������ ���ؼ� ���� �÷��� �˻��Ѵٴ� ��ȹ�� ��µ�

-- ���� �ݺ��ؼ� KING�� �˻��ϱ� ���� �ε����� ��������
drop index id_emp_copy90_ename; -- �� �� �ݵ�� ������ �� ������ �ε��� ������ ������ ��

select * from emp_copy90 -- ���� ������ǰ� ���������� ���̺� ������ ���� �˻� ��ȹ�� ����
where ename = 'KING';

create index id_emp_copy90_ename -- �۾��ð� 0.004�� �ҿ�.
on emp_copy90 (ename);           -- �Ƹ� �ѹ� �ҷ��� «�ٷ� �ð��� ����ȵ��ϴ�.

/* 
index�� �ֱ������� REBUILD ����� �Ѵ�.
�������ｼ, INDEX�� DML(insert, update, delete)�� ����ϸ� �������� �����̴�.
���� ���ϸ��� ��Դ� ���� �������� �������� �ʿ��ϴ�.
*/

-- �������ؾ� �� ���̺��� ã�� �ڵ� (�������� ���÷� �˷��ֽ�)
SELECT I.TABLESPACE_NAME,I.TABLE_NAME,I.INDEX_NAME, I.BLEVEL,
       DECODE(SIGN(NVL(I.BLEVEL,99)-3),1,DECODE(NVL(I.BLEVEL,99),99,'?','Rebuild'),'Check') CNF
FROM   USER_INDEXES I
WHERE   I.BLEVEL > 4
ORDER BY I.BLEVEL DESC;

-- index rebuild

alter index id_emp_ename rebuild; -- index�� ���Ӱ� ����
select * from emp_copy90;

/* 

    <<index�� ����ؾ� �ϴ� ���>>
    
    1. ���̺��� ��(�ο�, ���ڵ�)�� ���� ���, ���� ������ �̻�
    2. where ������ ���� ���Ǵ� �÷�.
    3. Join �� ���Ǵ� Ű �÷�. 
    4. �˻� ����� ���� ���̺� �������� 2%~ 4% ������ ������ ������ ���� ���
    5. �ش� �÷��� null�� ���ԵǴ� ��� (index������ null�� ������)
    
    <<index�� ���� ���ƾ� �ϴ� ���>>
    
    1. ���̺��� ���� ������ ���� ���
    2. �˻� ����� ���� ���̺��� ���� ������ �����ϴ� ���
    3. insert, delete, update�� ����� �÷��� ������ �������� ������
*/

/*
    index�� ����
    1. ���� �ε��� (Unique index): �÷��� �ߺ����� �ʴ� ������ ���� ���� Index
                                (Primary key, Uniqe)
    2. ���� �ε��� (Single Index): �� �÷��� �ο��Ǵ� Index
    3. ���� �ε��� (composite Index): ���� �÷��� ��� ������ index
    4. �Լ� �ε��� (Function Index): �Լ��� ������ �÷��� ������ �ε���

*/

-- ���� index ����
create index inx_emp_copy90_salary
on emp_copy90 (salary);

-- ���� �ε��� ����: �� �÷� �̻��� �����ؼ� �ε����� ������.

create table dept_copy91  -- ���� �ε����� ���̺� ����
as
select * from department;

create index inx_dept_copy91_dname_loc
on dept_copy91 (dname,loc);

select * from user_ind_columns
where table_name in 'DEPT_COPY91';

-- �Լ� ��� �ε��� : �Լ��� ������ �÷��� �ο��Ǵ� index

create table emp_copy91
as
select * from employee;

create index inx_empcopy91_allsal
on emp_copy91 (salary*12);


-- �Լ� ����
drop index inx_empcopy91_allsal;

/* ���� ����

    ������: DBMS�� �������� ����ϴٺ��� ����� ��ġ�⵵ ��
    -- �� ����ں���  ������ ����: DMBS �� ������ �� �ִ� ����ڸ� ������
        (���� (Authentication): Credential( Idnetity+ Password ) Ȯ��)
        (�㰡 (Autheriztion): ������ ����ڿ��� Oracle�� �ý��� ����, ��ü (���̺� �� Ʈ���� �Լ�) ����
            -system privileges: ����Ŭ�� �������� ���� �Ҵ�
            - Object privileges:  ���̺�, ��, Ʈ����, �Լ�, �������ν���, ������, �ε���( ���� ����,

*/

-- Oracle���� ���� �����ϱ�

    --1. Run sql command line ���� (�Ϲ� ���������� ������ ������ �� �ִ� ������ ����)
    create user usertest01 identified by 1234;


