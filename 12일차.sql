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
/


select * from employee;





