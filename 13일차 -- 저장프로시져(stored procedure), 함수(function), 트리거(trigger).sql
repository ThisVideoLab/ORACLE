-- 13���� �������ν���(stored procedure), �Լ�(function), Ʈ����(trigger)

/* ���� ���ν����� ����
    1. PL/SQL�� ��밡���ϴ�. �ڵ�ȭ��
    2. ������ ������.
        �Ϲ����� SQL ����: �����м� -> ��ü �̸� Ȯ�� -> ��� ���� Ȯ�� -> ����ȭ -> ������ -> ����
        �������ν��� ù����: �����м� -> ��ü �̸� Ȯ�� -> ��� ���� Ȯ�� -> ����ȭ -> ������ -> ����
        �������ν��� �����: ������(�޸𸮿� �ε�) -> ����
    3. �Է� �Ű�����, ��� �Ű������� ����� �� �ִ�.
    4. �Ϸ��� �۾��� ��� ����(���ȭ�� ���α׷����� �����ϴ�.)
*/

--1. ���� ���ν��� ����

create procedure sp_salary
is
    v_salary employee.salary%type;  -- ���� ���ν����� is ������� ������ ����
begin
    select salary into v_salary
    from employee
    where ename = 'SCOTT';
    
    dbms_output.put_line ('SCOTT�� �޿��� : '||V_SALARY||'�Դϴ�.');
end;

--2. ���� ���ν��� ������ Ȯ���ϴ� ������ ����
select * from user_source
where name ='SP_SALARY'; -- �빮�ڷ� �Է��� ��
-- ���� HR ������ ���ν��� ���� �������� Ȯ���� ������

--3. ���� ���ν��� ����
execute sp_salary; -- ���� ǥ��
exec sp_salary; -- ��� ǥ��

--4.  ���� ���ν��� ����

create or replace procedure sp_salary -- ���� or ����
is
    v_salary employee.salary%type;  -- ���� ���ν����� is ������� ������ ����
    v_commission employee.commission%type;
begin
    select salary, commission into v_salary, v_commission
    from employee
    where ename = 'SCOTT';
    if (v_commission is null) then
        v_commission :=0;
    end if;
    
    dbms_output.put_line ('SCOTT�� �޿��� : '||V_SALARY||
    ', ���ʽ��� : '||v_commission||'�Դϴ�.');
end;

exec sp_salary;

--5.  ���� ���ν��� ����
drop procedure sp_salary; -- ���� HR ������ ���ν��� ���� �������� Ȯ���� ������

----------------------<<��ǲ �Ű������� ó���ϴ� ���� ��������>>----------------------
create or replace procedure sp_salary_ename (  --�Է� �Ű�����, ���� �Ű� ������ ������
    v_ename in employee.ename%type  -- �����ݷ� ���� ������ in �ڷ���  <== �ſ� ����
    -- 2�����ʹ� , �� ����
)
is -- ���� ���� (���� ���ν������� ����� ���� ������) 
    v_salary employee.salary%type;
begin
    select salary into v_salary
    from employee
    where ename = v_ename;
    
    dbms_output.put_line(v_ename||'�� �޿��� : '||V_SALARY||'�Դϴ�.');
end;

exec sp_salary_ename ('SCOTT'); -- �������ν����� �Ű����� �� SCOTT�� V_ename�� �Ҵ���.
exec sp_salary_ename ('SMITH');
select * from employee;

-- �̸��� �μ���ȣ�� ��ǲ�޾Ƽ� �̸�, ��å, �μ���ȣ�� ����ϴ� ���� ���ν��� ����(Ŀ�� �̿�)

create or replace procedure sp_ename_dno (  --�Է� �Ű�����, ���� �Ű� ������ ������
    v_ename in employee.ename%type,  -- �����ݷ� ���� ������ in �ڷ���  <== �ſ� ����
    v_dno in employee.dno%type -- 2�����ʹ� , �� ����
    )
is -- ���� ���� (���� ���ν������� ����� ���� ������) 
    v_job employee.job%type;
    cursor c1 -- Ŀ�� ���� ����
    is 
    select job
    from employee
    where ename = v_ename and dno= v_dno;
begin
    open c1; -- Ŀ�� ����
        loop -- ���� ��ŸƮ
            fetch c1 into v_job;
            exit when c1%notfound;
    dbms_output.put_line(v_ename||'�� ��å�� '||V_JOB||'�̰� �μ���ȣ�� '||V_DNO||'�Դϴ�.');
    end loop; -- ���� ����
    close c1; -- Ŀ�� Ŭ����
end;
/
exec sp_ename_dno ('SCOTT',20);

--�׾ߺ� �̸��� �Է¹޾Ƽ� EMPLOYEEE TABLE �����ؼ� �����ϴ� ���ν����� �����Ͻÿ�.

create or replace procedure sp_createTable (
    v_name in varchar2
    )
is
    cursor1 INTEGER;
    v_sql varchar2 (100); -- SQL������ �����ϴ� ����
begin
    v_sql := 'CREATE TABLE ' ||v_name||' as select * from employee'; -- ���̺� �������� ������ �Ҵ�
    
    CURSOR1 := DBMS_SQL.OPEN_CURSOR; --Ŀ�� ���
    DBMS_SQL.PARSE ( cursor1, v_sql, dbms_sql.v7); -- Ŀ���� ����ؼ� SQL ������ ����
    DBMS_SQL.CLOSE_CURSOR(cursor1); -- Ŀ�� ����
end;
/

grant create table to public;  -- SYS ���� ��� �ο��� ��
exec sp_createTable ('emp_copy33');
select * from emp_copy33;

------------<<��� �Ű� ���� ���>>------------

--���� ���ν���: ��� �Ű������� ������ ���� ( <-> �Լ�: ��� �Ű������� �ϳ��� ����)
    -- out Ű���带 ���.
    -- ���� ���ν����� ȣ���, ���� ��� �Ű����� ���� ���� �� ȣ���� ������.
    -- ȣ��� ��� �Ű����� �̸� �տ� ':������ (��¸Ű�������)'
    -- ��� �Ű������� ����ϱ� ���ؼ� PRINT ��ɹ��̳� PL/SQL�� ����ؼ� ����� �� ����.
    
create or replace procedure sp_salary_ename2( -- �Է�/ ��� �Ű����� �����
    v_ename in employee.ename%type,  -- �����ݷ� ���� �޸��θ� ó���Կ� ������ ��
    v_salary out employee.salary%type
    )
is
begin
    select salary into v_salary
    from employee
    where ename = v_ename;
end;
/

select * from user_source where name = 'SP_SALARY_ENAME2'; --Data �������� Ȯ��

-- �Ʒ� 3���� ��� �巡���ؼ� �ѹ��� ������ ��

variable var_salary varchar2(50); 
exec sp_salary_ename2 ('SCOTT', :var_salary);
print var_salary;

-- ���� �ּ� �޸� ���� ���� �ؿ��ٰ� �ٴϱ� �� ������ �� �����ؼ� ���캼 ��
-- variable var_salary varchar(50); ȣ��ο��� �ƿ�ǲ �Ű������� ��������� ��.
-- exec sp_salary_ename2 ('SCOTT', :var_salary); -- �ƿ�ǲ �Ű����� �տ� �ݷ��� �ٿ��� ǥ������, �� �ݷ��� �־�� ��.

/* �ƿ�ǲ ����

exec sp_salary_ename2 ('SCOTT', :var_salary) ���� ��ǲ �� SCOTT�� ������,
SCOTT�� sp_salary_ename2 ���ν������� v_ename ������ ��ǲ�� ��.
�� �� ���ν��� ���� ���������� ename = v_ename�� �������� ������ ename�� �ش��ϴ�
salary ���� �ҷ���. �� salary ���� �ٽ� v_salary ������ ����, ���ν���������
v_salary out employee.salary%type ������ ���� �� v_salary ���� �ƿ�ǲ���� ������.
�̷��� �������� �ƿ�ǲ ���� ('SCOTT', :var_salary)���� var_salary������ �Էµǰ�
�� �� print var_salary; �� ���ؼ� SCOTT�� salary ���� 3000�� ���������� ��µ�.

*/

-- �ƿ� �Ķ���͸� ������ ������ ���� ���ν��� ���� �� ��� (PL/SQL ���)
-- ��� ��ȣ�� ��ǲ�޾Ƽ� ����̸�, �޿�, ��å�� OUT �Ķ���Ϳ� �Ѱ��ִ� ���ν����� PL/SQL�� ����ؼ� ����غ���
create or replace procedure sel_empno(
    v_eno in number,
    v_ename out varchar2,
    v_sal out number,
    v_job out varchar2
)
is
begin
    select ename, salary, job into v_ename, v_sal, v_job
    from employee
    where eno = v_eno;
end;
/

--PL/SQL�� ����� �������ν��� ȣ��
declare 
    var_ename varchar2(50);
    var_sal number;
    var_job varchar2(50);
begin
    -- �͸� ��� ����
    -- ���� ���ν��� ȣ�� �� exec�� ������ ����. 
    sel_empno (7788, var_ename, var_sal, var_job); -- ���� ���ν��� ȣ��
    dbms_output.put_line('��ȸ ��� : '||var_ename||'   '||var_sal||'   '||var_job);
end;
/

-- �Լ� (Function) : ���� �־ �ϳ��� ���� ��ȯ �޾ƿ´�. <== SQL ���� ������ ��� ����
    -- ��, ���� ���ν����� out �Ű������� ������ ��ȯ�޾� �� �� ���� < == SQL ���� �������� ��� �Ұ���

create or replace function fn_salary_ename ( -- ��ǲ �Ű� ����
    v_ename in employee.ename%type
)
RETURN number -- ������ �ڷ����� �ѹ��� ����
is
    v_salary number(7,2);
begin 
    select salary into v_salary -- 3. �ش� ���� ������ v_salary ���� �ְ�
    from employee -- 1. employee ���̺�κ���
    where ename = v_ename; -- 2. �Է� ���� �̸��� ��ġ�ϴ� �̸��� ���� ã�Ƽ�
    RETURN v_salary; -- 4. v_salary ���� �����ؼ� ������ְڴ�
end;
/

select * from user_source
where name = 'FN_SALARY_ENAME'; -- �Լ� ������ �������� ��ȸ�غ���

-- 1. �Լ��� ���

variable var_salary number;
exec :var_salary := fn_salary_ename('SCOTT');
print var_salary;

--2. �Լ� ��� (SQL ���� ������ �Լ� ���)
select ename, fn_salary_ename('SCOTT') AS ����
from employee
where ename = 'SCOTT';

/* 

fn_salary_ename('SCOTT') AS ���� �κ�ó�� �׳� SQL ���� �������� �̸� �ۼ��س���
�Լ��� ������� �� �� ����. �̷��� �Լ��� �ش� ���������� �ƹ��� �����̳� ���� ���� �۵���.
�׷��ٰ� �� ��� ��Ģ�� �����ϴ°� �ƴ�����, ���������� ����ȴٴ� ��.

*/

--3. �Լ� ����
drop function fn_salary_ename;

