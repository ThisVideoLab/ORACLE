--���� ���ν��� ���� 

-- 1. �� �μ����� �ּұ޿�, �ִ�޿�, ��ձ޿��� ����ϴ� �������ν����� �����Ͻÿ�. 
--	[employee, department ] ���̺� �̿�

create or replace procedure  pcd_q1
is
    v_dno employee.dno%type;
    v_min_salary employee.salary%type;
    v_max_salary employee.salary%type;
    v_avg_salary employee.salary%type;
    cursor c1
    is 
    select dno, min(salary), max(salary), avg(salary)
    from employee
    group by dno
    order by dno;
begin
    dbms_output.put_line ('�μ���ȣ   �ּұ޿�   �ִ�޿�   ��ձ޿�');
    dbms_output.put_line ('------------------------------------');
    open c1;
        loop
        fetch c1 into v_dno, v_min_salary, v_max_salary, v_avg_salary;
        exit when c1%notfound;
        dbms_output.put_line (v_dno||'   '||v_min_salary||'   '||v_max_salary||'   '||v_avg_salary);
    end loop; -- ���� ����
    close c1; -- Ŀ�� Ŭ����
end;
/
exec pcd_q1;

--2.  �����ȣ, ����̸�, �μ���, �μ���ġ�� ����ϴ� �������ν����� �����Ͻÿ�.  
--	[employee, department ] ���̺� �̿�

create or replace procedure  pcd_q2
is
    v_eno employee.eno%type;
    v_ename employee.ename%type;
    v_dname department.dname%type;
    v_loc department.loc%type;
    cursor c1
    is 
    select e.eno, e.ename, d.dname, d.loc
    from employee e, department d
    where e.dno = d.dno
    order by eno;
begin
    dbms_output.put_line ('�����ȣ   �������   �μ���   �μ���ġ');
    dbms_output.put_line ('----------------------------------');
    open c1;
        loop
        fetch c1 into v_eno, v_ename, v_dname, v_loc;
        exit when c1%notfound;
        dbms_output.put_line (v_eno||'   '||v_ename||'   '||v_dname||'   '||v_loc);
    end loop; -- ���� ����
    close c1; -- Ŀ�� Ŭ����
end;
/
exec pcd_q2;

--3. �޿��� �Է� �޾�  �Է¹��� �޿����� ���� ����� ����̸�, �޿�, ��å�� ��� �ϼ���.
--	�������ν����� : sp_salary_b

create or replace procedure sp_salary_b (
    ipt_salary in employee.salary%type
    )
is -- ���� ���� (���� ���ν������� ����� ���� ������) 
    v_ename employee.ename%type;
    v_job employee.job%type;
    v_salary employee.salary%type;
    
    cursor c1 -- Ŀ�� ���� ����
    is 
    select ename, job, salary 
    from employee
    where salary > ipt_salary
    ORDER by salary;
begin
    dbms_output.put_line('������'||ipt_salary||' �̻��� ���� ���');
    dbms_output.put_line('------------------------------------');
    dbms_output.put_line('�������           ����           ����');
    dbms_output.put_line('------------------------------------');
    open c1; -- Ŀ�� ����
        loop -- ���� ��ŸƮ
            fetch c1 into v_ename, v_job, v_salary ;
            exit when c1%notfound;
        dbms_output.put_line(v_ename||'           '||V_JOB||'           '||V_SALARY);
    end loop; -- ���� ����
    close c1; -- Ŀ�� Ŭ����
end;
/
exec sp_salary_b (1000);

--4. ��ǲ �Ű����� : emp_c10, dept_c10  �ΰ��� �Է� �޾� ���� employee, department ���̺��� �����ϴ� �������ν����� �����ϼ���. 
--   �������ν����� : sp_copy_table

create or replace procedure sp_createTable (
    v_table1 in varchar2,
    v_table2 in varchar2
    )
is
    cursor1 INTEGER;
    v_sql1 varchar2 (100);-- SQL������ �����ϴ� ����
    v_sql2 varchar2 (100);
begin
    v_sql1 := 'CREATE TABLE ' ||v_table1||' as select * from employee'; -- ���̺� �������� ������ �Ҵ�
    v_sql2 := 'CREATE TABLE ' ||v_table2||' as select * from department';
    
    CURSOR1 := DBMS_SQL.OPEN_CURSOR; --Ŀ�� ���
    DBMS_SQL.PARSE ( cursor1, v_sql1,dbms_sql.v7); -- Ŀ���� ����ؼ� SQL ������ ����
    DBMS_SQL.PARSE ( cursor1, v_sql2,dbms_sql.v7);
    DBMS_SQL.CLOSE_CURSOR(cursor1); -- Ŀ�� ����
end;
/	
exec sp_createTable ('emp_c10','dept_c10');

SELECT * FROM EMP_C10; -- ���� ����
SELECT * FROM DEPT_C10; -- ���� ����

--5.dept_c10 ���̺��� dno, dname, loc �÷��� �� ���� ��ǲ �޾� insert�ϴ� �������ν����� �����Ͻÿ�. 
--	�Է� �� : 50  'HR'  'SEOUL'
--	�Է� �� : 60  'HR2'  'PUSAN' 

create or replace procedure sp_inputTable (
    v_dno_ipt in dept_c10.dno%type,
    v_dname_ipt in dept_c10.dname%type,
    v_loc_ipt in dept_c10.loc%type
    )
is
begin
    insert into dept_c10 values (v_dno_ipt,v_dname_ipt,v_loc_ipt);
end;
/	

exec sp_inputTable (50,'HR','SEOUL');
exec sp_inputTable (60,'HR2','PUSAN');
select *from dept_c10;

--6. ��ǲ ���� ��� �÷��� ���� emp_c10 ���̺� insert�ϴ� �������ν����� �����Ͻÿ�. 
--	�Է� �� : 8000  'SONG'    'PROGRAMMER'  7788  sysdate  4500  1000  50 

create or replace procedure sp_inputColumn (
    v_eno_ipt in emp_c10.eno%type,
    v_ename_ipt in emp_c10.ename%type,
    v_job_ipt in emp_c10.job%type,
    v_manager_ipt in emp_c10.manager%type,
    v_hiredate_ipt in emp_c10.hiredate%type,
    v_salary_ipt in emp_c10.salary%type,
    v_commission_ipt in emp_c10.commission%type,
    v_dno_ipt in emp_c10.dno%type    
    )
is
begin
    insert into emp_c10 values (v_eno_ipt,v_ename_ipt,v_job_ipt,v_manager_ipt,
                                v_hiredate_ipt,v_salary_ipt,v_commission_ipt,v_dno_ipt);
end;
/

exec sp_inputColumn(8000,'SONG','PROGRAMER',7788,sysdate,4500,1000,50);
select *from emp_c10;

--7. dept_c10 ���̺��� 4�������� �μ���ȣ 50�� HR �� 'PROGRAM' ���� �����ϴ� �������ν����� �����ϼ���. 
--	<�μ���ȣ�� �μ����� ��ǲ�޾� �����ϵ��� �Ͻÿ�.> 
--	�Է°� : 50  PROGRAMER 

create or replace procedure sp_q7 (
    v_dno_ipt in dept_c10.dno%type,
    v_dname_ipt in dept_c10.dname%type
    )
is
begin
    update dept_c10
    set dname = v_dname_ipt
    where dno = v_dno_ipt;
end;
/

exec sp_q7(50,'PROGRAMER');
select *from dept_c10;


--8. emp_c10 ���̺��� �����ȣ�� ��ǲ �޾� ������ �����ϴ� ���� ���ν����� �����Ͻÿ�. 
--	�Է� �� : 8000  6000
create or replace procedure sp_q8 (
    v_eno_ipt in emp_c10.eno%type,
    v_salary_ipt in emp_c10.salary%type
    )
is
begin
    update emp_c10
    set salary = v_salary_ipt
    where eno = v_eno_ipt;
end;
/

exec sp_q8(8000,6000);
select *from emp_c10;


--9. ���� �� ���̺���� ��ǲ �޾� �� ���̺��� �����ϴ� �������ν����� ���� �Ͻÿ�. 

create or replace procedure sp_dropTable (
    v_table1 in varchar2,
    v_table2 in varchar2
    )
is
    cursor1 INTEGER;
    v_sql1 varchar2 (100);
    v_sql2 varchar2 (100);
begin
    v_sql1 := 'DROP TABLE '||v_table1||' ';
    v_sql2 := 'DROP TABLE ' ||v_table2||' ';
    
    CURSOR1 := DBMS_SQL.OPEN_CURSOR; --Ŀ�� ���
    DBMS_SQL.PARSE ( cursor1, v_sql1,dbms_sql.v7); -- Ŀ���� ����ؼ� SQL ������ ����
    DBMS_SQL.PARSE ( cursor1, v_sql2,dbms_sql.v7);
    DBMS_SQL.CLOSE_CURSOR(cursor1); -- Ŀ�� ����
end;
/	
exec sp_dropTable ('emp_c10','dept_c10');

SELECT * FROM EMP_C10; -- ���� ����
SELECT * FROM DEPT_C10; -- ���� ����

--10. �̸��� ��ǲ �޾Ƽ� �����, �޿�, �μ���ȣ, �μ���, �μ���ġ�� OUT �Ķ���Ϳ� �Ѱ��ִ� ���ν����� PL / SQL���� ȣ��
-- �̸��� SCOTT�� �����

create or replace procedure sel_empInfo(
    v_ename_in in varchar2,
    v_ename_out out varchar2,
    v_sal out number,
    v_dno out number,
    v_dname out varchar2,
    v_loc out varchar2
)
is
begin
    select e.ename, e.salary, d.dno, d.dname, d.loc into v_ename_out, v_sal, v_dno, v_dname, v_loc
    from employee e, department d
    where ename = v_ename_in and d.dno = e.dno;
end;
/

--PL/SQL�� ����� �������ν��� ȣ��
declare 
    var_ename varchar2(50);
    var_sal number;
    var_dno number;
    var_dname varchar2(50);
    var_loc varchar2(50);
begin
    sel_empInfo ('SCOTT',var_ename, var_sal, var_dno, var_dname, var_loc);
    dbms_output.put_line('���� ���� : '||var_ename||'   '||var_sal||'   '||var_dno||'   '||var_dname||'   '||var_loc);
end;
/

--11. �μ���ȣ�� �޾Ƽ� �����, �޿�, ��å�� OUT �Ķ���Ϳ� �Ѱ��ִ� ���ν����� PL / SQL���� ȣ�� (Ŀ�� �̿�)

create or replace procedure sel_empDeptInfo(
    v_dno in varchar2,
    v_ename out varchar2,
    v_sal out number,
    v_job out varchar2
)
is
    cursor c1
    is 
    select ename, salary, job
    from employee
    where dno = v_dno;
begin
    open c1; -- Ŀ�� ����
        loop -- ���� ��ŸƮ
            fetch c1 into v_ename, v_sal, v_job;
            exit when c1%notfound;
    end loop;
    close c1;
end;
/
--PL/SQL�� ����� �������ν��� ȣ��
declare 
    var_ename varchar2(50);
    var_sal number;
    var_job varchar2(50);
begin
    dbms_output.put_line('�����   �޿�   ��å');
    dbms_output.put_line('------------------');
    -- �͸� ��� ����
    -- ���� ���ν��� ȣ�� �� exec�� ������ ����. 
    dbms_output.put_line(var_ename||'   '||var_sal||'   '||var_job);
    sel_empDeptInfo (10, var_ename, var_sal, var_job); -- ���� ���ν��� ȣ��
end;
/

select  * from employee
where dno =10 ;