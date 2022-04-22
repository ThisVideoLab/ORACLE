-- 5일차 서브쿼리

--sub query: select 문 내에 select 문이 있는 쿼리

select ename, salary from employee;
select salary from employee where ename = 'SCOTT';

-- SCOTT의 월급보다 더 많이 받는 직원을 출력하라

    -- 서브쿼리 미사용    
    select ename, salary from employee 
    where salary > 3000;
    
    -- 서브쿼리 사용
    select ename , salary 
    from employee
    where salary > (select salary from employee where ename = 'SCOTT');
    
-- SCOTT과 동일한 부서에 근무하는 사원들 출력하기 (dno 사용)
select ename, dno
from employee
where dno = (select dno from employee where ename = 'SCOTT');

-- SCOTT과 동일한 부서에 근무하는 사원들 출력하기 (dname 사용, join을 사용하기)
select e.ename, d.dname
from employee e, department d
where d.dno = (select dno from employee where ename = 'SCOTT') and e.dno = d.dno;

select * from department;
select * from department;

-- 최소 급여를 받는 사원의 이름, 담당업무, 급여 출력하기

select ename 성명, job 직무, salary 월급
from employee
where salary = (select min(salary) from employee);

-- 30번 부서의 최소 월급을 받는 사원보다 많은 월급을 받는 사람들

select min(salary) from employee; -- 800만원

select ename, dno,salary 
from employee
where salary > (select min(salary) from employee) and dno = 30
order by dno asc;

-- having 절에 sub query 사용하기

-- 30번 부서의 최소 월급을 구하고, 각 부서에서 그 월급보다 큰 월급 중에서 최소값을 구하라

select dno, min(salary) ,count(dno)
from employee
group by dno
having min(salary) > (select min(salary) from employee where dno = 30);

-- 단일행 서브쿼리 : sub query의 결과값이 단 하나만 출력됨
    -- 단일행 비교 연산자: >, =, >=, <,<=,<>,<=
-- 다중행 서브 쿼리: sub query의 결과 값이 여러개 출력
-- 다중행 서브 쿼리 연산자: IN, ANY, SOME, ALL, EXISTS
--    IN: 메인 쿼리의 비교 조건 ('*'연산자로 비교할 경우) 이 서브쿼리의 결과 값 중에서 하나라도 일치하면 참
--        ANY, SOME: 메인 쿼리의 비교 조건이 서브쿼리의 검색 결과와 하나 이상 일치하면 참
--        ALL : 메인 쿼리의 비교 조건이 서브 쿼리의 검색 결과와 모든 값이 일치하면 참
--        EXIST: 메인 쿼리의 비교 조건이 서브 쿼리의 결과값 중에서 만족하는 값이 하나라도 존재하면 참.
        

--IN 연산자 사용하기

-- 부서별로 최소 월급을 받는 직원을 출력하기 (sub query 반드시 사용해서 출력할 것)

select ename, eno, dno, salary 
from employee
order by dno asc;

select ename, dno, salary 
from employee
where salary in(950, 800, 1300); -- 이 값중에 하나를 가지고 있으면 출력

select ename, dno, salary 
from employee
where salary in(select  min(salary) from employee group by dno);

-- Any 연산자
    --sub query가 가지는 각각의 값과 비교함
    --'<any'는 최대값보다 작음을 나타냄.
    --'>any'는 최소값보다 큼을 나타냄.
    
    -- 예) 직급이 SALESMAN이 아니면서 급여가 임의의 SALESMAN보다 작은 사원을 출력하시오
    select eno, ename, job, salary
    from employee
    where salary < any ( select salary from employee
                            where job = 'SALESMAN')
                            and job <> 'SALESMAN';
                            
    select ename, job, salary 
    from employee
    order by job;
    
-- ALL 연산자
    -- subquery의 반환하는 모든 값과 비교함        
    -- '>all': 최대값보다 큼을 나타냄
    --'<all': 최소값보다 작음을 나타냄

-- 예)직급이 세일즈맨이 아니면서, 급여가 세일즈맨보다 작은 사람들
    
    select eno, ename, job, salary
    from employee
    where salary <= (select min(salary) 
                    from employee 
                    where job = 'SALESMAN')
          and job <> 'SALESMAN'
    order by salary asc;
    
    
    
-- 예) 담당업무가 분석가인 사람보다 급여가 적으면서, 업무가 분석가가 아닌 사람들을 출력함

select eno, ename, job, salary
    from employee
    where salary <all (select (salary) 
                    from employee 
                    where job = 'ANALYST')
          and job <> 'ANALYST'
    order by salary asc;

SELECT * FROM employee
where job = 'ANALYST';






