-- 8일차 view, sequence, index

/* 뷰 (view) 

- 가상의 테이블을 뷰라고 칭함. 
- 테이블은 데이터값을 가지지만, 뷰는 데이터값을 가지지 못함.
- 오로지 실행 코드만을 가지고 있음.
- 그럼에도, 뷰를 사용하는 목적은 다음과 같음.
        1. 보안: 실제 테이블의 특정 컬럼만을 가져올 수 있어서, 정보 은폐가 가능함.
        2. 복잡한 쿼리(ex 복잡한 join 쿼리)도 뷰를 통하면 편하게 사용이 가능함 
- 뷰는 일반적으로 select 구문으로 사용한다
- 뷰 내부의 as 구문에는 insert, update, delete 사용이 불가능하다.
- 다만 뷰 자체에 insert, update, delete 하면 실제 테이블에 저장이 된다. 
- 이 때 반드시 해당 원본 테이블의 제약 조건을 만족해야 한다.
- 그룹함수를 적용한 뷰에는 insert를 할 수 없다.

*/

create table dept_copy60
as
select * from department;

create table emp_copy60
as
select * from employee;

-- 뷰 생성하기

create view v_emp_job -- 뷰명
as
select eno, ename, dno, job  -- 아래로 쭉 뷰가 실행할 코드들을 입력함
from emp_copy60
where job like 'SALESMAN';

select * from user_views;

-- 뷰의 실행

select * from v_emp_job; -- 유사 테이블이 로딩됨

-- 복잡한 조인 쿼리를 뷰로 처리하기

create view v_join
as
select e.dno, ename, job, dname, loc
from employee e, department d
where e.dno = d.dno
and job = 'SALESMAN';

select * from v_join;

-- 뷰를 사용해서 실제 테이블의 중요한 정보 숨기기

select * from emp_copy60; -- 실제 테이블의 정보

create view simple_emp -- 실제 테이블의 정보를 뷰를 이용해 불러옴
as
select ename, job, dno
from emp_copy60;

select * from simple_emp; -- 실제 테이블은 숨기고, 뷰값을 출력해서 사용자들에게 보여줌

select * from user_views; -- 대상이 뷰라는 사실은 이 코드로 확인이 가능함.

create view v_groupping
as
select dno, count(*) "number of people", trunc(AVG(salary)) "average salary", SUM(salary) "sum of salary"--  여기 이름을 꼭 별칭으로 설정해줘야 함
from emp_copy60
group by dno;

select * from v_groupping; -- 마찬가지로 테이블처럼 나타난다


-- 뷰를 생성할때는 반드시 select 구문을 사용해야 함
create view v_error
as
insert into dnop  -- 바로 오류가 발생함.
values (60, 'HR', 'BUSAN');

--view에 값을 insert 할 수 있을까? 컬럼의 제약 조건을 만족하면 view에도 값을 넣을수 있다,
    -- 실제 테이블에 값이 insert 되긴 함
    
create view v_dept
as
select dno, dname
from dept_copy60;

select * from v_dept;

insert into v_dept   -- VIEW 에 값을 INSERT 시도
values ( 70, 'HR'); -- 메시지 상으로는 삽입되었다고 뜸.

select * from v_dept; -- 실제로 뷰에 값이 삽입됨
select * from department; -- 당연하게도, 뷰의 대상이 되는 테이블에는 입력되지 않음.

create or replace view v_dept -- (뷰명)이 존재하면 대체하고, 없으면 새로 만들어라
as
select dname, loc
from dept_copy60;  -- 기존에 있던 뷰를 대체해서 지정한 내용을 입력함.

select * from v_dept; -- 성공적으로 입력되어 있음

insert into v_dept -- 행 하나를 추가해보자
values('HR2', 'BUSAN')

select * from v_dept; -- 성공적으로 입력되어 있음
SELECT * FROM DEPT_COPY60;

update dept_copy60
set dno = 80
where dno is null; -- 프라이머리키를 넣기 위해 위에 넣었던 행의 dno 컬럼의 null값을 채워줌.

alter table dept_copy60
add constraint PK_dept_copy60_dno Primary Key (dno); -- 프라이머리 키 입력

select * from user_constraints
where table_name = ('DEPT_COPY60') -- 성공적으로 입력된 모습을 볼 수 있음.

insert into v_dept
values ('HR3','INCHEON'); -- DNO를 입력하지 않고 NULL로 넣자 에러가 발생함
                          -- 프라이머리 키가 NULL 값 입력을 거부함

-- 뷰 내용 대체하기2

create or replace view v_groupping
as
select dno, count(*) "number of people", round(AVG(salary),2) "average salary", SUM(salary) "sum of salary"
from emp_copy60
group by dno;

select * from v_groupping; -- 성공적으로 내용이 대체됨

-- 뷰 내용 삭제하기
drop view v_groupping; -- 테이블 자체가 삭제됨.

-- insert, update, delete가 가능한 뷰

create view v_dept10
as
select dno, dname, loc
from dept_copy60;

insert into v_dept10 -- insert 해보기
values (90, 'HR4', 'BUSAN');

SELECT * FROM v_dept10; -- 뷰에 행 삽입 완료
SELECT * FROM dept_copy60; -- 원본 테이블에 행 삽입 완료

update v_dept10  -- update 해보기
set dname = 'HR5', loc = 'BUSAN5'
where dno = 90;
commit;

SELECT * FROM v_dept10; -- 뷰에 행 업데이트 완료
SELECT * FROM dept_copy60; -- 원본 테이블에 행 업데이트 완료

delete v_dept10; -- delete 해보기

-- 읽기만 가능한 뷰를 생성:

create view v_read_only
as
select dno, dname, loc
from dept_copy50 with read only;

select * from v_read_only;

insert into v_read_only
values (88, 'HR7', 'BUSAN7') -- v_read_only는 읽기전용이라는 경고가 뜸

UPDATE v_read_only
set dname = 'HR7', loc = 'BUSAN7', dno = 88; -- v_read_only는 읽기전용이라는 경고가 뜸

DELETE v_read_only -- v_read_only는 읽기전용이라는 경고가 뜸


