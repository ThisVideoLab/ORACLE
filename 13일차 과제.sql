--저장 프로시져 문제 

-- 1. 각 부서별로 최소급여, 최대급여, 평균급여를 출력하는 저장프로시져를 생성하시오. 
--	[employee, department ] 테이블 이용

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
    dbms_output.put_line ('부서번호   최소급여   최대급여   평균급여');
    dbms_output.put_line ('------------------------------------');
    open c1;
        loop
        fetch c1 into v_dno, v_min_salary, v_max_salary, v_avg_salary;
        exit when c1%notfound;
        dbms_output.put_line (v_dno||'   '||v_min_salary||'   '||v_max_salary||'   '||v_avg_salary);
    end loop; -- 루프 엔드
    close c1; -- 커서 클로즈
end;
/
exec pcd_q1;

--2.  사원번호, 사원이름, 부서명, 부서위치를 출력하는 저장프로시져를 생성하시오.  
--	[employee, department ] 테이블 이용

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
    dbms_output.put_line ('사원번호   사원성명   부서명   부서위치');
    dbms_output.put_line ('----------------------------------');
    open c1;
        loop
        fetch c1 into v_eno, v_ename, v_dname, v_loc;
        exit when c1%notfound;
        dbms_output.put_line (v_eno||'   '||v_ename||'   '||v_dname||'   '||v_loc);
    end loop; -- 루프 엔드
    close c1; -- 커서 클로즈
end;
/
exec pcd_q2;

--3. 급여를 입력 받아  입력받은 급여보다 높은 사원의 사원이름, 급여, 직책을 출력 하세요.
--	저장프로시져명 : sp_salary_b

create or replace procedure sp_salary_b (
    ipt_salary in employee.salary%type
    )
is -- 변수 선언 (저장 프로시저에서 사용할 변수 선언블락) 
    v_ename employee.ename%type;
    v_job employee.job%type;
    v_salary employee.salary%type;
    
    cursor c1 -- 커서 선언 시작
    is 
    select ename, job, salary 
    from employee
    where salary > ipt_salary
    ORDER by salary;
begin
    dbms_output.put_line('월급이'||ipt_salary||' 이상인 직원 명단');
    dbms_output.put_line('------------------------------------');
    dbms_output.put_line('사원성명           직무           월급');
    dbms_output.put_line('------------------------------------');
    open c1; -- 커서 오픈
        loop -- 루프 스타트
            fetch c1 into v_ename, v_job, v_salary ;
            exit when c1%notfound;
        dbms_output.put_line(v_ename||'           '||V_JOB||'           '||V_SALARY);
    end loop; -- 루프 엔드
    close c1; -- 커서 클로즈
end;
/
exec sp_salary_b (1000);

--4. 인풋 매개변수 : emp_c10, dept_c10  두개를 입력 받아 각각 employee, department 테이블을 복사하는 저장프로시져를 생성하세요. 
--   저장프로시져명 : sp_copy_table

create or replace procedure sp_createTable (
    v_table1 in varchar2,
    v_table2 in varchar2
    )
is
    cursor1 INTEGER;
    v_sql1 varchar2 (100);-- SQL쿼리를 저장하는 변수
    v_sql2 varchar2 (100);
begin
    v_sql1 := 'CREATE TABLE ' ||v_table1||' as select * from employee'; -- 테이블 생성쿼리 변수에 할당
    v_sql2 := 'CREATE TABLE ' ||v_table2||' as select * from department';
    
    CURSOR1 := DBMS_SQL.OPEN_CURSOR; --커서 사용
    DBMS_SQL.PARSE ( cursor1, v_sql1,dbms_sql.v7); -- 커서를 사용해서 SQL 쿼리를 실행
    DBMS_SQL.PARSE ( cursor1, v_sql2,dbms_sql.v7);
    DBMS_SQL.CLOSE_CURSOR(cursor1); -- 커서 중지
end;
/	
exec sp_createTable ('emp_c10','dept_c10');

SELECT * FROM EMP_C10; -- 복사 성공
SELECT * FROM DEPT_C10; -- 복사 성공

--5.dept_c10 테이블의 dno, dname, loc 컬럼에 들어갈 값을 인풋 받아 insert하는 저장프로시져를 생성하시요. 
--	입력 값 : 50  'HR'  'SEOUL'
--	입력 값 : 60  'HR2'  'PUSAN' 

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

--6. 인풋 받은 모든 컬럼의 값을 emp_c10 테이블에 insert하는 저장프로시져를 생성하시오. 
--	입력 값 : 8000  'SONG'    'PROGRAMMER'  7788  sysdate  4500  1000  50 

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

--7. dept_c10 테이블에서 4번문항의 부서번호 50의 HR 을 'PROGRAM' 으로 수정하는 저장프로시져를 생성하세요. 
--	<부서번호와 부서명을 인풋받아 수정하도록 하시오.> 
--	입력갑 : 50  PROGRAMER 

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


--8. emp_c10 테이블에서 사원번호를 인풋 받아 월급을 수정하는 저장 프로시져를 생성하시오. 
--	입력 값 : 8000  6000
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


--9. 위의 두 테이블명을 인풋 받아 두 테이블을 삭제하는 저장프로시져를 생성 하시오. 

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
    
    CURSOR1 := DBMS_SQL.OPEN_CURSOR; --커서 사용
    DBMS_SQL.PARSE ( cursor1, v_sql1,dbms_sql.v7); -- 커서를 사용해서 SQL 쿼리를 실행
    DBMS_SQL.PARSE ( cursor1, v_sql2,dbms_sql.v7);
    DBMS_SQL.CLOSE_CURSOR(cursor1); -- 커서 중지
end;
/	
exec sp_dropTable ('emp_c10','dept_c10');

SELECT * FROM EMP_C10; -- 제거 성공
SELECT * FROM DEPT_C10; -- 제거 성공

--10. 이름을 인풋 받아서 사원명, 급여, 부서번호, 부서명, 부서위치을 OUT 파라미터에 넘겨주는 프로시저를 PL / SQL에서 호출
-- 이름은 SCOTT을 사용함

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

--PL/SQL을 사용한 저장프로시저 호출
declare 
    var_ename varchar2(50);
    var_sal number;
    var_dno number;
    var_dname varchar2(50);
    var_loc varchar2(50);
begin
    sel_empInfo ('SCOTT',var_ename, var_sal, var_dno, var_dname, var_loc);
    dbms_output.put_line('직원 정보 : '||var_ename||'   '||var_sal||'   '||var_dno||'   '||var_dname||'   '||var_loc);
end;
/

--11. 부서번호를 받아서 사원명, 급여, 직책을 OUT 파라미터에 넘겨주는 프로시저를 PL / SQL에서 호출 (커서 이용)

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
    open c1; -- 커서 오픈
        loop -- 루프 스타트
            fetch c1 into v_ename, v_sal, v_job;
            exit when c1%notfound;
    end loop;
    close c1;
end;
/
--PL/SQL을 사용한 저장프로시저 호출
declare 
    var_ename varchar2(50);
    var_sal number;
    var_job varchar2(50);
begin
    dbms_output.put_line('사원명   급여   직책');
    dbms_output.put_line('------------------');
    -- 익명 블록 시작
    -- 저장 프로시저 호출 시 exec를 붙이지 않음. 
    dbms_output.put_line(var_ename||'   '||var_sal||'   '||var_job);
    sel_empDeptInfo (10, var_ename, var_sal, var_job); -- 저장 프로시저 호출
end;
/

select  * from employee
where dno =10 ;