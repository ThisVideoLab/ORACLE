08 ���̺� ���� ���� ����   <<�Ϸ� �ð� : 12: 20>>

1. ���� ǥ�� ��õ� ��� DEPT ���̺��� ���� �Ͻÿ�. 

�÷���	������Ÿ��	ũ��	NULL
---------------------------------------------------------------
DNO	number		2	NOT NULL
DNAME	varchar2		14	NULL
LOC	varchar2		13	NULL
---------------------------------------------------------------

create table dept(
dno number(2) not null,
dname varchar2(14) null,
loc varchar2(13) null
);
commit;

desc dept;

2. ���� ǥ�� ��õ� ��� EMP ���̺��� ���� �Ͻÿ�. 

�÷���	������Ÿ��	ũ��	NULL
---------------------------------------------------------------
ENO	number		4	NOT NULL
ENAME	varchar2		10	NULL
DNO	number		2	NULL
---------------------------------------------------------------

create table emp(
eno number(4) not null,
ename varchar2(10) null,
dno number(2) null
);
commit;

desc emp;

3. ���̸��� ���� �� �ֵ��� EMP ���̺��� ENAME �÷��� ũ�⸦ �ø��ÿ�. 

�÷���	������Ÿ��	ũ��	NULL
---------------------------------------------------------------
ENO	number		4	NOT NULL
ENAME	varchar2		25	NULL		<<==���� �÷�  : 10 => 25  �� �ø�
DNO	number		2	NULL
---------------------------------------------------------------

Alter Table emp
modify ename varchar2 (25);
commit;

desc emp;


4. EMPLOYEE ���̺��� �����ؼ� EMPLOYEE2 �� �̸��� ���̺��� �����ϵ� �����ȣ, �̸�, �޿�, �μ���ȣ �÷��� �����ϰ� ���� ������ ���̺��� �÷����� ���� EMP_ID, NAME, SAL, DEPT_ID �� ���� �Ͻÿ�. 

create table employee2
as
select eno EMP_ID, ename NAME, salary SAL, dno DEPT_ID from employee;
commit;

desc employee2;

5. EMP ���̺��� ���� �Ͻÿ�. 

drop table emp;
commit;

desc emp; -- ���� ���

6. EMPLOYEE2 �� ���̺� �̸��� EMP�� ���� �Ͻÿ�. 

Rename employee2 to emp; 
commit;

desc emp;

7. DEPT ���̺��� DNAME �÷��� ���� �Ͻÿ�

Alter Table dept
drop COLUMN dname;
commit;

desc dept;

8. DEPT ���̺��� LOC �÷��� UNUSED�� ǥ�� �Ͻÿ�. 

Alter Table dept
set unused (loc);
commit;

desc dept;

9. UNUSED Ŀ���� ��� ���� �Ͻÿ�. 

Alter Table dept
drop unused COLUMNS;
commit;

desc dept;

09 - ������ ���۰� Ʈ����� ����. 
========================================

1. EMP ���̺��� ������ �����Ͽ� EMP_INSERT �� �̸��� �� ���̺��� ����ÿ�. 

create table emp_insert
as
select * from emp
where 0=1;
commit;

desc emp_insert;
select * from emp_insert;

2. ������ EMP_INSERT ���̺� �߰��ϵ� SYSDATE�� �̿��ؼ� �Ի����� ���÷� �Է��Ͻÿ�. 

-- ���� �������� emp ���̺��� ���鶧 hireadte �÷��� �����ؿ��� �ʾƼ� �߰��ϴ� ������ �ʿ���
Alter Table emp_insert add(hiredate date);
commit;

desc emp_insert; 
select * from emp_insert; -- ���������� �߰���
---------------------------------------------------------------

insert into emp_insert (EMP_ID, NAME, SAL, DEPT_ID, HIREDATE)
VALUES (1000,'�̿���',1000, 10,sysdate);
commit;

select * from emp_insert;

3. EMP_INSERT ���̺� �� ����� �߰��ϵ� TO_DATE �Լ��� �̿��ؼ� �Ի����� ������ �Է��Ͻÿ�. 

insert into emp_insert (EMP_ID, NAME, SAL, DEPT_ID, HIREDATE)
VALUES (1001,'�����',1001, 10,to_date(sysdate-1));
commit;

select * from emp_insert;

4. employee���̺��� ������ ������ �����Ͽ� EMP_COPY�� �̸��� ���̺��� ����ÿ�. 

create table emp_copy
as
select * from employee;

desc emp_copy;
select * from emp_copy;

commit;

5. �����ȣ�� 7788�� ����� �μ���ȣ�� 10������ �����Ͻÿ�. [ EMP_COPY ���̺� ���] 

UPDATE emp_copy
set dno = 10
WHERE eno= 7788;

select * from emp_copy;

commit;

6. �����ȣ�� 7788 �� ��� ���� �� �޿��� �����ȣ 7499�� ������ �� �޿��� ��ġ �ϵ��� �����Ͻÿ�. [ EMP_COPY ���̺� ���] 

UPDATE emp_copy
set job = (select job from emp_copy where eno =7499) , salary = (select salary from emp_copy where eno =7499)
WHERE eno= 7788;

select * from emp_copy; -- salary 1600 job salesman

commit;

7. �����ȣ 7369�� ������ ������ ����� �μ���ȣ�� ��� 7369�� ���� �μ���ȣ�� ���� �Ͻÿ�. [ EMP_COPY ���̺� ���] 

UPDATE emp_copy
set dno = (select dno from emp_copy where eno = 7369)
where job = (select job from emp_copy where eno = 7369);

select * from emp_copy; -- 4�� �ٲ�

commit;



8. department ���̺��� ������ ������ �����Ͽ� DEPT_COPY �� �̸��� ���̺��� ����ÿ�. 

create table dept_copy
as
select * from department;

desc dept_copy;
select * from dept_copy;

commit;

9. DEPT_COPY�� ���̺��� �μ����� RESEARCH�� �μ��� ���� �Ͻÿ�. 

delete from dept_copy where dname = 'RESEARCH';
select * from dept_copy;
commit;

10. DEPT_COPY ���̺��� �μ���ȣ�� 10 �̰ų� 40�� �μ��� ���� �Ͻÿ�. 

delete from dept_copy where dno in (10,40);
select * from dept_copy;
commit;


