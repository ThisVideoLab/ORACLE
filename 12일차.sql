--12 일차 PL/SQL

/* PL/SQL
 
 SQL은 구조화된 질의 언어로, 유연한 프로그래밍 기능을 제공할 수 없다는 단점이 있음.
 PL/SQL은 오라클에 프로그래밍 요소를 적용한 SQL로, 유연하게 처리해서 적용할 수 있음.
 MSSQL에서는 T-SQL이라고 칭함

set serveroutput on -- PL/SQL의 출력을 활성화

*/

/* PL/SQL의 기본 구문 작성


begin -- begin으로 시작함 
    (PL/SQL 구문 자리)
end; -- end로 끝이 남

*/

--PL/SQL의 기본 출력 구문
set serveroutput on 
begin
    dbms_output.put_line('welcome to Oracle');
end;
/

/* PL / SQL에서 변수 선언하기.

(변수명 ) : = (변수의 값) */

desc employee;

/* 자료형 선언

    1. Oracle의 자료형을 사용
    2. 참조자료형: 언급한 테이블의 컬럼의 선언된 자료형을 그대로 참조해서 사용함
            %type: 테이블의 특정 컬럼의 자료형을 참조해서 사용함.
            %rowtype: 테이블 전체 컬럼의 자료형을 모두 참조해서 사용함.

*/


set serveroutput on

declare
    v_eno number(4);    -- 오라클에서 제공하는 자료형을 명시해서 선언하는 방법
    v_ename employee.ename%type; -- 참조 자료형: 해당 테이블의 컬럼의 자료형을 참조해서 그대로 적용하는 방법
begin
v_eno:= 7788;  -- := 변수의 값을 할당할 때 사용함.
v_ename:= 'SCOTT';

dbms_output.put_line('사원번호  사원이름');
dbms_output.put_line('---------------');
dbms_output.put_line(v_eno||'     '||v_ename);  -- || 연결자로 사용함

end;
/

/* 사원 번호와 사원 이름 출력하기 */

set serveroutput on
declare
    v_eno employee.eno%type;
    v_ename employee.ename%type;
begin
    dbms_output.put_line('사원번호  사원이름');
    dbms_output.put_line('---------------');
    
    select eno, ename into v_eno, v_ename 
    from employee 
    where ename = 'SCOTT'; -- 위의 구문에서는 값으로 주어진 컬럼값들을 쿼리문으로 찾아오도록 함
    
    dbms_output.put_line(v_eno||'     '||v_ename);  -- || 연결자로 사용함    
end;
/

-- 기존의 쿼리문과 비교해보기
select eno, ename 
from employee 
where ename = 'SCOTT';

/* PL/SQL에서 제어문 사용하기 */

-- IF ~ END IF 문 사용하기

set serveroutput on
declare
    v_employee employee%rowtype; -- rowtype: employee 테이블의 모든 컬럼의 자료형을 참조해서 사용함.
                                 -- v_employee 변수는 employee 테에블의 모든 컬럼을 참조함.
    annsal number(7,2);
begin
    select * into v_employee
    from employee
    where ename = 'SCOTT';
    if (v_employee.commission is null) then
        v_employee.commission :=0;
    end if;
    annsal:= v_employee.salary*12 + v_employee.commission;
    dbms_output.put_line('사원번호    사원이름    연봉');
    dbms_output.put_line('-------------------------');
    dbms_output.put_line(v_employee.eno || '    ' || v_employee.ename|| '    ' || annsal);
end;
/

-- PL/SQL을 사용해서 department 테이블을 출력해보시오
-- 조건에 dno = 20을 변수에 담아서 출력해보세요

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
    dbms_output.put_line('부서번호    부서이름    부서위치');
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

    dbms_output.put_line('사원번호   사원명   부서명   부서워치');
    dbms_output.put_line('-----------------------');
    dbms_output.put_line(v_eno||'   '||v_ename||'   '||v_dno||'   '||v_dname);

end;
/

/* employee 테이블의 eno, ename, saslary, dno를 PL/SQL을 사용하여 출력
    조건은 commission이 1400인 것에 대해서 출력하시오.
    1. %type으로 출력
    2. %rowtype으로 출력
*/

--1. %type으로 출력

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
    dbms_output.put_line('사원번호   사원이름   월급   부서번호');
    dbms_output.put_line('-----------------------');
    dbms_output.put_line(v_eno||'   '||v_ename||'   '||v_salary||'   '||v_dno);
end;
/



--2. %rowtype으로 출력

set serveroutput on
declare
    v_employee employee%rowtype;
begin
    select * into v_employee
    from employee
    where commission = 1400;
    dbms_output.put_line('사원번호   사원이름   월급   부서번호');
    dbms_output.put_line('-----------------------');
    dbms_output.put_line(v_employee.eno||'   '||v_employee.ename||'   '||v_employee.salary||'   '||v_employee.dno);
end;
/

select * from employee
where commission = 1400; -- 비교해볼 것

/* 커서 (cursor) : PL/SQL에서 select 한 결과가 단일레코드가 아니라 레코드 셋인 경우에
                  여러 레코드 값을 처리할 수 있도록 도와주는 쿼리문
                  
    커서의 일반적인 형태
    declare
         cursor 커서명  --1. 커서 선언
            is
            커서를 부착할 select 구문
            
        begin
            open 커서명; --2. 커서 오픈
            loop
                fetch 구문 --3. 커서를 이동하고 출력
                
            end loop;
            close 커서명; --4. 커서 클로즈
        
        end;
        /
*/

-- 커서를 사용해서 department의 모든 내용을 출력해보기

set serveroutput on
declare
    v_dept department%rowtype; -- 변수 선언
    cursor c1 -- 커서 선언 시작
    is 
    select *from department; -- 커서 선언 종료
begin
    dbms_output.put_line('부서번호   부서이름   부서위치');
    dbms_output.put_line('--------------------------');
    open c1; -- 커서 오픈
        loop -- 루프 스타트
            fetch c1 into v_dept.dno, v_dept.dname, v_dept.loc;
            exit when c1%notfound;
            dbms_output.put_line(v_dept.dno||'   '||v_dept.dname||'   '||v_dept.loc);
    end loop; -- 루프 엔드
    close c1; -- 커서 클로즈
end;
/

/* 커서의 속성을 나타내는 속성값 

커서명%notfound: 커서 영역내에 모든 자료가 fetch 되었다면 true를 return함
커서명%found: 커서 영역내에 모든 자료가 fetch 되지 않았다면 true를 return함
커서명%isopen: 커서가 오픈되었다면 true를 return함
커서명%rowcount: 커서가 얻어온 레코드의 갯수

*/

-- 사원명, 부서명, 부서워치, 월급을 출력하세요. PL/SQL의 커서 기능을 사용하시오


set serveroutput on
declare
    v_dept department%rowtype; -- 변수 선언
    v_emp employee%rowtype;
    cursor c1 -- 커서 선언 시작
    is 
    select e.ename, d.dname, d.loc, e.salary
    from employee e, department d
    where e.dno = d.dno; -- 커서 선언 종료
begin
    dbms_output.put_line('사원명   부서명   부서위치   월급');
    dbms_output.put_line('-----------------------------');
    open c1; -- 커서 오픈
        loop -- 루프 스타트
            fetch c1 into v_emp.ename, v_dept.dname, v_dept.loc, v_emp.salary;
            exit when c1%notfound;
            dbms_output.put_line(v_emp.ename||'   '||v_dept.dname||'   '||v_dept.loc||'   '||v_emp.salary);
    end loop; -- 루프 엔드
    close c1; -- 커서 클로즈
end;
/

/* CURSOR FOR LOOP 문으로 커서를 사용해서 여러 레코드 셋 출력하기
    - open, close를 생략할 수 있음
    - 한 테이블 내에서 전체 내용을 출력할 때 사용
*/

set serveroutput on
declare
    v_dept department%rowtype;
    cursor c1  -- 커서 선언
    is
    select * from department;
begin
    dbms_output.put_line('부서번호   부서명   지역명');
    dbms_output.put_line('-----------------------');
    for v_dept in c1 loop
        dbms_output.put_line(v_dept.dno||'   '||v_dept.dname||'   '||v_dept.loc);
    end loop;
end;
/
    
-- 실습1: employee table의 모든 내용을 cursor for loop를 사용해서 출력해 보세요

set serveroutput on
declare
    v_emp employee%rowtype;
    cursor c1  -- 커서 선언
    is
    select * from employee;
begin
    dbms_output.put_line('사원번호   사원명   직무   상관번호   입사일   월급   보너스   부서번호');
    dbms_output.put_line('---------------------------------------------------------------');
    for v_emp in c1 loop
        dbms_output.put_line(v_emp.eno||'   '||v_emp.ename||'   '||v_emp.job||'   '||v_emp.manager
        ||'   '||v_emp.hiredate||'   '||v_emp.salary||'   '||v_emp.commission||'   '||v_emp.dno);
    end loop;  
end;
/

-- 실습2: employee table의 사원번호, 사원명, 월급을 cursor for loop를 사용해서 출력하되, 
--        월급 2000 이상, 부서번호 20, 30만 출력할 것

set serveroutput on
declare
    v_emp employee%rowtype;
    cursor c1  -- 커서 선언
    is
    select * from employee
    where salary >= 2000 and dno in (20,30);
begin
    dbms_output.put_line('사원번호   사원명   월급   부서번호');
    dbms_output.put_line('-------------------------------');
    for v_emp in c1 loop
        dbms_output.put_line(v_emp.eno||'   '||v_emp.ename||'   '||v_emp.salary||'   '||v_emp.dno);
    end loop;  
end;


/* 트리거 (Trigger)

권총의 방아쇠(트리거), 방아쇠를 당기면 총이 발사되는 것처럼 테이블에 부착되어서 테이블에
이벤트가 발생하면 자동으로 작동되는 프로그램 코드. 테이블에 발생되는 이벤트(INSERT, UPDATE,DELETE)
트리거에 정의된 BEGIN ~ END 사이의 문장이 실행됨.

BEFORE 트리거: 테이블에서 트리거 먼저 실행 후 insert, update, delete가 적용됨.
AFTER 트리거: 테이블에서 insert, update, delete가  먼저 적용된 후 트리거가 실행됨.

예) 주문 테이블에 값을 넣었을 때 배송 테이블에 자동으로 저장됨
예) 중요 테이블의 로그를 자동으로 저장함

-- :new ) 가상의 임시 테이블, 트리거가 부착된 테이블에 새롭게 들어오는 레코드를 위한 임시 테이블
-- :old ) 가상의 임시 테이블, 트리거가 부착된 테이블에서 삭제되는 레코드를 위한 임시 테이블
-- 트리거는 하나의 테이블에 총 3개까지 부착이 가능함(insert. update, delete)

*/

-- 실습 테이블 2개 생성: 테이블 2개 구조만 복사

create table dept_original
as
select * from department
where 0 = 1;

create table dept_copy
as
select * from department
where 0 = 1;

-- 트리거 생성 (dept_original 테이블에 부착, insert시 자동으로 작동)

create or replace trigger tri_sample1
-- 이 공간에는 트리거가 부착될 테이블명과, 이벤트(insert,update,delete) 내용
-- 그리고  before인지 after인지가 담김
    after insert -- insert가 작동하고 난 후에 begin ~ end 사이의 코드가 작동됨
    on dept_original --on절에는 트리거가 부착될 테이블명이 옴
    for each row  -- 모든 row에 대해서
begin -- 트리거가 실행할 코드가 들어감
    if inserting then 
        dbms_output.put_line ('Insert Trigger 발생!!');
        insert into dept_copy 
        values (:new.dno, :new.dname, :new.loc); -- 여기서 new 라는 건 가상 테이블을 뜻함
    end if;
end;
/

-- 트리거 생성 여부를 확인하는 데이터 사전 : user_source */

select * from user_source where name ='TRI_SAMPLE1';

select * from dept_original;  -- 트리거 부착 테이블과 대상 테이블의 상태 확인
select * from dept_copy;

insert into dept_original
values (12, 'PROGRAM', 'PUSAN'); -- 오리지날 테이블에 값을 넣으면 카파 테이블에도 들어감

create or replace trigger tri_del
    --  트리거가 작동시킬 테이블, 이벤트, 에프터or비포
    after delete -- 원본 테이블의 delete를 먼저 실행 한 후에 트리거를 작동시킴
    on dept_original
    for each row

begin
    dbms_output.put_line('delete trigger 발생!!!');
    delete dept_copy
    where dept_copy.dno = :old.dno;  --dept original에서 삭제되는 가상 임시 테이블 : old
end;
/

select * from user_source where name ='TRI_del';

select * from dept_original;  -- 트리거 부착 테이블과 대상 테이블의 상태 확인
select * from dept_copy;

delete dept_original
where dno = 12;

/* update 트리거: dept_original 테이블의 특정 값을 수정하면 dept_copy 테이블의 내용을 업데이트 함 */

create or replace trigger tri_update
    after update
    on dept_original
    for each row
begin
    dbms_outpuT.put_linE('update trigger 발생!!!');
     update dept_copy
     set dept_copy.dname = :new.dname
     where dept_copy.dno = :old.dno;
end;
/

select * from dept_original;  -- 주문 테이블이라고 가정하고
select * from dept_copy; -- 배송 테이블이라고 가정하면

update dept_original 
set dname = 'prog'
where dno = 13;

insert into dept_original -- 주문 테이블이 수정되면 배송 테이블의 내용도 수정함
values (13,'prog','pusan')