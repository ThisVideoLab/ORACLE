-- 13일차 저장프로시져(stored procedure), 함수(function), 트리거(trigger)

/* 저장 프로시져의 장점
    1. PL/SQL을 사용가능하다. 자동화됨
    2. 성능이 빠르다.
        일반적인 SQL 구문: 구문분석 -> 개체 이름 확인 -> 사용 권한 확인 -> 최적화 -> 컴파일 -> 실행
        저장프로시져 첫실행: 구문분석 -> 개체 이름 확인 -> 사용 권한 확인 -> 최적화 -> 컴파일 -> 실행
        저장프로시져 재실행: 컴파일(메모리에 로드) -> 실행
    3. 입력 매개변수, 출력 매개변수를 사용할 수 있다.
    4. 일련의 작업을 묶어서 저장(모듈화된 프로그래밍이 가능하다.)
*/

--1. 저장 프로시져 생성

create procedure sp_salary
is
    v_salary employee.salary%type;  -- 저장 프로시져는 is 블락에서 변수를 선언
begin
    select salary into v_salary
    from employee
    where ename = 'SCOTT';
    
    dbms_output.put_line ('SCOTT의 급여는 : '||V_SALARY||'입니다.');
end;

--2. 저장 프로시져 정보를 확인하는 데이터 사전
select * from user_source
where name ='SP_SALARY'; -- 대문자로 입력할 것
-- 좌측 HR 계정의 프로시저 폴더 내에서도 확인이 가능함

--3. 저장 프로시져 실행
execute sp_salary; -- 정식 표현
exec sp_salary; -- 약식 표현

--4.  저장 프로시져 수정

create or replace procedure sp_salary -- 생성 or 수정
is
    v_salary employee.salary%type;  -- 저장 프로시져는 is 블락에서 변수를 선언
    v_commission employee.commission%type;
begin
    select salary, commission into v_salary, v_commission
    from employee
    where ename = 'SCOTT';
    if (v_commission is null) then
        v_commission :=0;
    end if;
    
    dbms_output.put_line ('SCOTT의 급여는 : '||V_SALARY||
    ', 보너스는 : '||v_commission||'입니다.');
end;

exec sp_salary;

--5.  저장 프로시져 삭제
drop procedure sp_salary; -- 좌측 HR 계정의 프로시저 폴더 내에서도 확인이 삭제됨

----------------------<<인풋 매개변수를 처리하는 저장 프로지저>>----------------------
create or replace procedure sp_salary_ename (  --입력 매개변수, 츨력 매개 변수를 정의함
    v_ename in employee.ename%type  -- 새미콜론 없이 변수명 in 자료형  <== 매우 주의
    -- 2개부터는 , 로 구분
)
is -- 변수 선언 (저장 프로시저에서 사용할 변수 선언블락) 
    v_salary employee.salary%type;
begin
    select salary into v_salary
    from employee
    where ename = v_ename;
    
    dbms_output.put_line(v_ename||'의 급여는 : '||V_SALARY||'입니다.');
end;

exec sp_salary_ename ('SCOTT'); -- 저장프로시저의 매개변수 값 SCOTT을 V_ename에 할당함.
exec sp_salary_ename ('SMITH');
select * from employee;

-- 이름과 부서번호를 인풋받아서 이름, 직책, 부서번호를 출력하는 저장 프로시저 생성(커서 이용)

create or replace procedure sp_ename_dno (  --입력 매개변수, 츨력 매개 변수를 정의함
    v_ename in employee.ename%type,  -- 새미콜론 없이 변수명 in 자료형  <== 매우 주의
    v_dno in employee.dno%type -- 2개부터는 , 로 구분
    )
is -- 변수 선언 (저장 프로시저에서 사용할 변수 선언블락) 
    v_job employee.job%type;
    cursor c1 -- 커서 선언 시작
    is 
    select job
    from employee
    where ename = v_ename and dno= v_dno;
begin
    open c1; -- 커서 오픈
        loop -- 루프 스타트
            fetch c1 into v_job;
            exit when c1%notfound;
    dbms_output.put_line(v_ename||'의 직책은 '||V_JOB||'이고 부서번호는 '||V_DNO||'입니다.');
    end loop; -- 루프 엔드
    close c1; -- 커서 클로즈
end;
/
exec sp_ename_dno ('SCOTT',20);

--테야블 이름을 입력받아서 EMPLOYEEE TABLE 복사해서 저장하는 프로시져를 생성하시오.

create or replace procedure sp_createTable (
    v_name in varchar2
    )
is
    cursor1 INTEGER;
    v_sql varchar2 (100); -- SQL쿼리를 저장하는 변수
begin
    v_sql := 'CREATE TABLE ' ||v_name||' as select * from employee'; -- 테이블 생성쿼리 변수에 할당
    
    CURSOR1 := DBMS_SQL.OPEN_CURSOR; --커서 사용
    DBMS_SQL.PARSE ( cursor1, v_sql, dbms_sql.v7); -- 커서를 사용해서 SQL 쿼리를 실행
    DBMS_SQL.CLOSE_CURSOR(cursor1); -- 커서 중지
end;
/

grant create table to public;  -- SYS 계정 열어서 부여할 것
exec sp_createTable ('emp_copy33');
select * from emp_copy33;

------------<<출력 매개 변수 사용>>------------

--저장 프로시져: 출력 매개변수를 여러개 지원 ( <-> 함수: 출력 매개변수를 하나만 지님)
    -- out 키워드를 사용.
    -- 저장 프로시저를 호출시, 먼저 출력 매개변수 변수 선언 후 호출이 가능함.
    -- 호출시 출력 매개변수 이름 앞에 ':변수명 (출력매개변수명)'
    -- 출력 매개변수를 출력하기 위해서 PRINT 명령문이나 PL/SQL을 사용해서 출력할 수 있음.
    
create or replace procedure sp_salary_ename2( -- 입력/ 출력 매개변수 선언부
    v_ename in employee.ename%type,  -- 세미콜론 없이 콤마로만 처리함에 주의할 것
    v_salary out employee.salary%type
    )
is
begin
    select salary into v_salary
    from employee
    where ename = v_ename;
end;
/

select * from user_source where name = 'SP_SALARY_ENAME2'; --Data 사전에서 확인

-- 아래 3줄을 모두 드래그해서 한번에 실행할 것

variable var_salary varchar2(50); 
exec sp_salary_ename2 ('SCOTT', :var_salary);
print var_salary;

-- 옆에 주석 달면 오류 나서 밑에다가 다니까 위 구문과 잘 연결해서 살펴볼 것
-- variable var_salary varchar(50); 호출부에서 아웃풋 매개변수를 선언해줘야 함.
-- exec sp_salary_ename2 ('SCOTT', :var_salary); -- 아웃풋 매개변수 앞에 콜론을 붙여서 표시해줌, 꼭 콜론이 있어야 함.

/* 아웃풋 절차

exec sp_salary_ename2 ('SCOTT', :var_salary) 에서 인풋 값 SCOTT을 넣으면,
SCOTT은 sp_salary_ename2 프로시져에서 v_ename 값으로 인풋이 됨.
그 후 프로시져 내의 쿼리문에서 ename = v_ename의 조건으로 쓰여서 ename에 해당하는
salary 값을 불러냄. 이 salary 값은 다시 v_salary 값으로 들어가고, 프로시저에서는
v_salary out employee.salary%type 구문을 통해 이 v_salary 값을 아웃풋으로 내보냄.
이렇게 내보내진 아웃풋 값은 ('SCOTT', :var_salary)에서 var_salary값으로 입력되고
그 후 print var_salary; 을 통해서 SCOTT의 salary 값인 3000이 최종적으로 출력됨.

*/

-- 아웃 파라미터를 여러개 가지는 저장 프로시져 생성 및 출력 (PL/SQL 사용)
-- 사원 번호를 인풋받아서 사원이름, 급여, 직책을 OUT 파라미터에 넘겨주는 프로시져를 PL/SQL을 사용해서 출력해보자
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

--PL/SQL을 사용한 저장프로시저 호출
declare 
    var_ename varchar2(50);
    var_sal number;
    var_job varchar2(50);
begin
    -- 익명 블록 시작
    -- 저장 프로시저 호출 시 exec를 붙이지 않음. 
    sel_empno (7788, var_ename, var_sal, var_job); -- 저장 프로시저 호출
    dbms_output.put_line('조회 결과 : '||var_ename||'   '||var_sal||'   '||var_job);
end;
/

-- 함수 (Function) : 값을 넣어서 하나의 값을 반환 받아온다. <== SQL 구문 내에서 사용 가능
    -- 비교, 저장 프로시져는 out 매개변수를 여러개 반환받아 올 수 있음 < == SQL 구문 내에서는 사용 불가능

create or replace function fn_salary_ename ( -- 인풋 매개 변수
    v_ename in employee.ename%type
)
RETURN number -- 리턴의 자료형은 넘버로 선언
is
    v_salary number(7,2);
begin 
    select salary into v_salary -- 3. 해당 열의 월급을 v_salary 값에 넣고
    from employee -- 1. employee 테이블로부터
    where ename = v_ename; -- 2. 입력 받은 이름과 일치하는 이름의 열을 찾아서
    RETURN v_salary; -- 4. v_salary 값을 리턴해서 출력해주겠다
end;
/

select * from user_source
where name = 'FN_SALARY_ENAME'; -- 함수 데이터 사전에서 조회해보기

-- 1. 함수의 사용

variable var_salary number;
exec :var_salary := fn_salary_ename('SCOTT');
print var_salary;

--2. 함수 사용 (SQL 구문 내에서 함수 사용)
select ename, fn_salary_ename('SCOTT') AS 월급
from employee
where ename = 'SCOTT';

/* 

fn_salary_ename('SCOTT') AS 월급 부분처럼 그냥 SQL 구문 내에서도 미리 작성해놓은
함수를 마음대로 쓸 수 있음. 이러한 함수는 해당 구문내에서 아무런 조건이나 제약 없이 작동함.
그렇다고 막 모든 규칙을 무시하는건 아니지만, 독립적으로 실행된다는 점.

*/

--3. 함수 삭제
drop function fn_salary_ename;

