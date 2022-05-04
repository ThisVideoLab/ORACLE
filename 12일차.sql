--12 ���� PL/SQL

/* PL/SQL
 
 SQL�� ����ȭ�� ���� ����, ������ ���α׷��� ����� ������ �� ���ٴ� ������ ����.
 PL/SQL�� ����Ŭ�� ���α׷��� ��Ҹ� ������ SQL��, �����ϰ� ó���ؼ� ������ �� ����.
 MSSQL������ T-SQL�̶�� Ī��

set serveroutput on -- PL/SQL�� ����� Ȱ��ȭ

*/

/* PL/SQL�� �⺻ ���� �ۼ�


begin -- begin���� ������ 
    (PL/SQL ���� �ڸ�)
end; -- end�� ���� ��

*/

--PL/SQL�� �⺻ ��� ����
set serveroutput on 
begin
    dbms_output.put_line('welcome to Oracle');
end;
/

/* PL / SQL���� ���� �����ϱ�.

(������ ) : = (������ ��) */

desc employee;

/* �ڷ��� ����

    1. Oracle�� �ڷ����� ���
    2. �����ڷ���: ����� ���̺��� �÷��� ����� �ڷ����� �״�� �����ؼ� �����
            %type: ���̺��� Ư�� �÷��� �ڷ����� �����ؼ� �����.
            %rowtype: ���̺� ��ü �÷��� �ڷ����� ��� �����ؼ� �����.

*/


set serveroutput on

declare
    v_eno number(4);    -- ����Ŭ���� �����ϴ� �ڷ����� ����ؼ� �����ϴ� ���
    v_ename employee.ename%type; -- ���� �ڷ���: �ش� ���̺��� �÷��� �ڷ����� �����ؼ� �״�� �����ϴ� ���
begin
v_eno:= 7788;  -- := ������ ���� �Ҵ��� �� �����.
v_ename:= 'SCOTT';

dbms_output.put_line('�����ȣ  ����̸�');
dbms_output.put_line('---------------');
dbms_output.put_line(v_eno||'     '||v_ename);  -- || �����ڷ� �����

end;
/

/* ��� ��ȣ�� ��� �̸� ����ϱ� */

set serveroutput on
declare
    v_eno employee.eno%type;
    v_ename employee.ename%type;
begin
    dbms_output.put_line('�����ȣ  ����̸�');
    dbms_output.put_line('---------------');
    
    select eno, ename into v_eno, v_ename 
    from employee 
    where ename = 'SCOTT'; -- ���� ���������� ������ �־��� �÷������� ���������� ã�ƿ����� ��
    
    dbms_output.put_line(v_eno||'     '||v_ename);  -- || �����ڷ� �����    
end;
/

-- ������ �������� ���غ���
select eno, ename 
from employee 
where ename = 'SCOTT';

/* PL/SQL���� ��� ����ϱ� */

-- IF ~ END IF �� ����ϱ�

set serveroutput on
declare
    v_employee employee%rowtype; -- rowtype: employee ���̺��� ��� �÷��� �ڷ����� �����ؼ� �����.
                                 -- v_employee ������ employee �׿����� ��� �÷��� ������.
    annsal number(7,2);
begin
    select * into v_employee
    from employee
    where ename = 'SCOTT';
    if (v_employee.commission is null) then
        v_employee.commission :=0;
    end if;
    annsal:= v_employee.salary*12 + v_employee.commission;
    dbms_output.put_line('�����ȣ    ����̸�    ����');
    dbms_output.put_line('-------------------------');
    dbms_output.put_line(v_employee.eno || '    ' || v_employee.ename|| '    ' || annsal);
end;
/

-- PL/SQL�� ����ؼ� department ���̺��� ����غ��ÿ�
-- ���ǿ� dno = 20�� ������ ��Ƽ� ����غ�����

set serveroutput on
declare
    v_department department%rowtype;
begin
    select * into v_department
    from department
    where dno = 20;
    if (v_department.loc = 'DALLAS') then
        v_department.loc :='DALLAS DOLLAR';
    end if;
    dbms_output.put_line('�μ���ȣ    �μ��̸�    �μ���ġ');
    dbms_output.put_line('-------------------------');
    dbms_output.put_line(v_department.DNO || '         ' || v_department.dname|| '  ' ||v_department.loc);
end;
/

/* IF ~ ELSIF ~ END IF */

set serveroutput on
declare
    v_eno employee.eno%type;
    v_ename employee.ename%type;
    v_dno employee.dno%type;
    v_dname department.dname%type;
begin
    select eno, ename, dno into v_eno, v_ename, v_dno
    from employee
    where ename ='SCOTT';
    
    if(v_dno = 10) then
    v_dname := 'ACCOUNT';
    elsif(v_dno = 20) then
    v_dname := 'RESEARCH';
    elsif(v_dno = 30) then
    v_dname := 'SALES';
    elsif(v_dno = 40) then
    v_dname := 'OPERATIONS';
    end if;

    dbms_output.put_line('�����ȣ   �����   �μ���   �μ���ġ');
    dbms_output.put_line('-----------------------');
    dbms_output.put_line(v_eno||'   '||v_ename||'   '||v_dno||'   '||v_dname);

end;
/

/* employee ���̺��� eno, ename, saslary, dno�� PL/SQL�� ����Ͽ� ���
    ������ commission�� 1400�� �Ϳ� ���ؼ� ����Ͻÿ�.
    1. %type���� ���
    2. %rowtype���� ���
*/

--1. %type���� ���

set serveroutput on
declare
    v_eno employee.eno%type;
    v_ename employee.ename%type;
    v_salary employee.salary%type;
    v_dno employee.dno%type;
begin
    select eno, ename, salary, dno into v_eno, v_ename, v_salary, v_dno
    from employee
    where commission = 1400;
    dbms_output.put_line('�����ȣ   ����̸�   ����   �μ���ȣ');
    dbms_output.put_line('-----------------------');
    dbms_output.put_line(v_eno||'   '||v_ename||'   '||v_salary||'   '||v_dno);
end;
/



--2. %rowtype���� ���

set serveroutput on
declare
    v_employee employee%rowtype;
begin
    select * into v_employee
    from employee
    where commission = 1400;
    dbms_output.put_line('�����ȣ   ����̸�   ����   �μ���ȣ');
    dbms_output.put_line('-----------------------');
    dbms_output.put_line(v_employee.eno||'   '||v_employee.ename||'   '||v_employee.salary||'   '||v_employee.dno);
end;
/

select * from employee
where commission = 1400; -- ���غ� ��

/* Ŀ�� (cursor) : PL/SQL���� select �� ����� ���Ϸ��ڵ尡 �ƴ϶� ���ڵ� ���� ��쿡
                  ���� ���ڵ� ���� ó���� �� �ֵ��� �����ִ� ������
                  
    Ŀ���� �Ϲ����� ����
    declare
         cursor Ŀ����  --1. Ŀ�� ����
            is
            Ŀ���� ������ select ����
            
        begin
            open Ŀ����; --2. Ŀ�� ����
            loop
                fetch ���� --3. Ŀ���� �̵��ϰ� ���
                
            end loop;
            close Ŀ����; --4. Ŀ�� Ŭ����
        
        end;
        /
*/

-- Ŀ���� ����ؼ� department�� ��� ������ ����غ���

set serveroutput on
declare
    v_dept department%rowtype; -- ���� ����
    cursor c1 -- Ŀ�� ���� ����
    is 
    select *from department; -- Ŀ�� ���� ����
begin
    dbms_output.put_line('�μ���ȣ   �μ��̸�   �μ���ġ');
    dbms_output.put_line('--------------------------');
    open c1; -- Ŀ�� ����
        loop -- ���� ��ŸƮ
            fetch c1 into v_dept.dno, v_dept.dname, v_dept.loc;
            exit when c1%notfound;
            dbms_output.put_line(v_dept.dno||'   '||v_dept.dname||'   '||v_dept.loc);
    end loop; -- ���� ����
    close c1; -- Ŀ�� Ŭ����
end;
/

/* Ŀ���� �Ӽ��� ��Ÿ���� �Ӽ��� 

Ŀ����%notfound: Ŀ�� �������� ��� �ڷᰡ fetch �Ǿ��ٸ� true�� return��
Ŀ����%found: Ŀ�� �������� ��� �ڷᰡ fetch ���� �ʾҴٸ� true�� return��
Ŀ����%isopen: Ŀ���� ���µǾ��ٸ� true�� return��
Ŀ����%rowcount: Ŀ���� ���� ���ڵ��� ����

*/

-- �����, �μ���, �μ���ġ, ������ ����ϼ���. PL/SQL�� Ŀ�� ����� ����Ͻÿ�


set serveroutput on
declare
    v_dept department%rowtype; -- ���� ����
    v_emp employee%rowtype;
    cursor c1 -- Ŀ�� ���� ����
    is 
    select e.ename, d.dname, d.loc, e.salary
    from employee e, department d
    where e.dno = d.dno; -- Ŀ�� ���� ����
begin
    dbms_output.put_line('�����   �μ���   �μ���ġ   ����');
    dbms_output.put_line('-----------------------------');
    open c1; -- Ŀ�� ����
        loop -- ���� ��ŸƮ
            fetch c1 into v_emp.ename, v_dept.dname, v_dept.loc, v_emp.salary;
            exit when c1%notfound;
            dbms_output.put_line(v_emp.ename||'   '||v_dept.dname||'   '||v_dept.loc||'   '||v_emp.salary);
    end loop; -- ���� ����
    close c1; -- Ŀ�� Ŭ����
end;
/

/* CURSOR FOR LOOP ������ Ŀ���� ����ؼ� ���� ���ڵ� �� ����ϱ�
    - open, close�� ������ �� ����
    - �� ���̺� ������ ��ü ������ ����� �� ���
*/

set serveroutput on
declare
    v_dept department%rowtype;
    cursor c1  -- Ŀ�� ����
    is
    select * from department;
begin
    dbms_output.put_line('�μ���ȣ   �μ���   ������');
    dbms_output.put_line('-----------------------');
    for v_dept in c1 loop
        dbms_output.put_line(v_dept.dno||'   '||v_dept.dname||'   '||v_dept.loc);
    end loop;
end;
/
    
-- �ǽ�1: employee table�� ��� ������ cursor for loop�� ����ؼ� ����� ������

set serveroutput on
declare
    v_emp employee%rowtype;
    cursor c1  -- Ŀ�� ����
    is
    select * from employee;
begin
    dbms_output.put_line('�����ȣ   �����   ����   �����ȣ   �Ի���   ����   ���ʽ�   �μ���ȣ');
    dbms_output.put_line('---------------------------------------------------------------');
    for v_emp in c1 loop
        dbms_output.put_line(v_emp.eno||'   '||v_emp.ename||'   '||v_emp.job||'   '||v_emp.manager
        ||'   '||v_emp.hiredate||'   '||v_emp.salary||'   '||v_emp.commission||'   '||v_emp.dno);
    end loop;  
end;
/

-- �ǽ�2: employee table�� �����ȣ, �����, ������ cursor for loop�� ����ؼ� ����ϵ�, 
--        ���� 2000 �̻�, �μ���ȣ 20, 30�� ����� ��

set serveroutput on
declare
    v_emp employee%rowtype;
    cursor c1  -- Ŀ�� ����
    is
    select * from employee
    where salary >= 2000 and dno in (20,30);
begin
    dbms_output.put_line('�����ȣ   �����   ����   �μ���ȣ');
    dbms_output.put_line('-------------------------------');
    for v_emp in c1 loop
        dbms_output.put_line(v_emp.eno||'   '||v_emp.ename||'   '||v_emp.salary||'   '||v_emp.dno);
    end loop;  
end;


/* Ʈ���� (Trigger)

������ ��Ƽ�(Ʈ����), ��Ƽ踦 ���� ���� �߻�Ǵ� ��ó�� ���̺� �����Ǿ ���̺�
�̺�Ʈ�� �߻��ϸ� �ڵ����� �۵��Ǵ� ���α׷� �ڵ�. ���̺� �߻��Ǵ� �̺�Ʈ(INSERT, UPDATE,DELETE)
Ʈ���ſ� ���ǵ� BEGIN ~ END ������ ������ �����.

BEFORE Ʈ����: ���̺��� Ʈ���� ���� ���� �� insert, update, delete�� �����.
AFTER Ʈ����: ���̺��� insert, update, delete��  ���� ����� �� Ʈ���Ű� �����.

��) �ֹ� ���̺� ���� �־��� �� ��� ���̺� �ڵ����� �����
��) �߿� ���̺��� �α׸� �ڵ����� ������

-- :new ) ������ �ӽ� ���̺�, Ʈ���Ű� ������ ���̺� ���Ӱ� ������ ���ڵ带 ���� �ӽ� ���̺�
-- :old ) ������ �ӽ� ���̺�, Ʈ���Ű� ������ ���̺��� �����Ǵ� ���ڵ带 ���� �ӽ� ���̺�
-- Ʈ���Ŵ� �ϳ��� ���̺� �� 3������ ������ ������(insert. update, delete)

*/

-- �ǽ� ���̺� 2�� ����: ���̺� 2�� ������ ����

create table dept_original
as
select * from department
where 0 = 1;

create table dept_copy
as
select * from department
where 0 = 1;

-- Ʈ���� ���� (dept_original ���̺� ����, insert�� �ڵ����� �۵�)

create or replace trigger tri_sample1
-- �� �������� Ʈ���Ű� ������ ���̺���, �̺�Ʈ(insert,update,delete) ����
-- �׸���  before���� after������ ���
    after insert -- insert�� �۵��ϰ� �� �Ŀ� begin ~ end ������ �ڵ尡 �۵���
    on dept_original --on������ Ʈ���Ű� ������ ���̺���� ��
    for each row  -- ��� row�� ���ؼ�
begin -- Ʈ���Ű� ������ �ڵ尡 ��
    if inserting then 
        dbms_output.put_line ('Insert Trigger �߻�!!');
        insert into dept_copy 
        values (:new.dno, :new.dname, :new.loc); -- ���⼭ new ��� �� ���� ���̺��� ����
    end if;
end;
/

-- Ʈ���� ���� ���θ� Ȯ���ϴ� ������ ���� : user_source */

select * from user_source where name ='TRI_SAMPLE1';

select * from dept_original;  -- Ʈ���� ���� ���̺�� ��� ���̺��� ���� Ȯ��
select * from dept_copy;

insert into dept_original
values (12, 'PROGRAM', 'PUSAN'); -- �������� ���̺� ���� ������ ī�� ���̺��� ��

create or replace trigger tri_del
    --  Ʈ���Ű� �۵���ų ���̺�, �̺�Ʈ, ������or����
    after delete -- ���� ���̺��� delete�� ���� ���� �� �Ŀ� Ʈ���Ÿ� �۵���Ŵ
    on dept_original
    for each row

begin
    dbms_output.put_line('delete trigger �߻�!!!');
    delete dept_copy
    where dept_copy.dno = :old.dno;  --dept original���� �����Ǵ� ���� �ӽ� ���̺� : old
end;
/

select * from user_source where name ='TRI_del';

select * from dept_original;  -- Ʈ���� ���� ���̺�� ��� ���̺��� ���� Ȯ��
select * from dept_copy;

delete dept_original
where dno = 12;

/* update Ʈ����: dept_original ���̺��� Ư�� ���� �����ϸ� dept_copy ���̺��� ������ ������Ʈ �� */

create or replace trigger tri_update
    after update
    on dept_original
    for each row
begin
    dbms_outpuT.put_linE('update trigger �߻�!!!');
     update dept_copy
     set dept_copy.dname = :new.dname
     where dept_copy.dno = :old.dno;
end;
/

select * from dept_original;  -- �ֹ� ���̺��̶�� �����ϰ�
select * from dept_copy; -- ��� ���̺��̶�� �����ϸ�

update dept_original 
set dname = 'prog'
where dno = 13;

insert into dept_original -- �ֹ� ���̺��� �����Ǹ� ��� ���̺��� ���뵵 ������
values (13,'prog','pusan')