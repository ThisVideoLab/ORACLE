-- 1.모든 사원의 급여 최고액, 최저액, 총액, 및 평균 급여를 출력 하시오. 컬럼의 별칭은 동일
--  (최고액, 최저액, 총액, 평균)하게 지정하고 평균에 대해서는 정수로 반올림 하시오. 

select max(salary) 최고액, min(salary) 최저액, sum(salary) 총액, ROUND(avg(salary),0) 평균 
from employee;

--2. 각 담당업무 유형별로 급여 최고액, 최저액, 총액 및 평균액을 출력하시오. 컬럼의 별칭은 
--  동일(최고액, 최저액, 총액, 평균)하게 지정하고 평균에 대해서는 정수로 반올림 하시오. 

select job 직무, max(salary) 최고액, min(salary) 최저액, sum(salary) 총액, ROUND(avg(salary),0) 평균
from employee
group by job;

--3. count(*)함수를 사용하여 담당 업무가 동일한 사원수를 출력하시오. 
select job 직무, count(job) 담당인원 from
employee
group by job;

--4. 관리자 수를 나열 하시오. 컬럼의 별칭은 "관리자수" 로 나열 하시오. 
select job 직무, count(job) 관리자수 from employee
group by job
having job = 'MANAGER';

--5. 급여 최고액, 최저 급여액의 차액을 출력 하시오, 컬럼의 별칭은 "DIFFERENCE"로 지정하시오. 
SELECT max(salary) 최고급여, min(salary) 최저급여, max(salary) - min(salary) difference
FROM employee;

--6. 직급별 사원의 최저 급여를 출력하시오. 관리자를 알 수 없는 사원 및 최저 급여가 
--   2000미만인 그룹은 제외 시키고 결과를 급여에 대한 내림차순으로 정렬하여 출력 하시오. 

select job 직급, min(salary) 최저급여
from employee
where manager is not null
group by job
having min(salary) >= 2000
order by job;
 
-- 7. 각 부서에대해 부서번호, 사원수, 부서내의 모든 사원의 평균 급여를 출력하시오. 
--    컬럼의 별칭은 [부서번호, 사원수, 평균급여] 로 부여하고 평균급여는 소숫점 2째자리에서 반올림 하시오. 

select dno 부서번호, count(dno) 사원수, round(avg(salary),2) 평균급여
from employee
GROUP BY dno;

-- 8. 각 부서에 대해 부서번호이름, 지역명, 사원수, 부서내의 모든 사원의 평균 급여를 출력하시오.
--    결럼의 별칭은 아래 [ 출력예시] 로 지정하고 평균급여는 정수로 반올림 하시오.  

select decode(dno, 10, 'SALES', 20, 'RESEARCH', 30, 'ACCOUNTING','Default') Dname,
        decode(dno, 10, 'CHICAGO', 20, 'DALLAS', 30, 'NEWYORK','Default') Location,
        count(dno) "Number of Peoeple",
        round(avg(salary),0) salary
from employee
group by dno;



-- 테이블 조인 문제 - 06

--1. EQUI 조인을 사용하여 SCOTT 사원의 부서 번호와 부서 이름을 출력 하시오. 

select ename, e.dno, dname from employee e, department d
where e.dno = d.dno
AND ename = 'SCOTT';

--2. INNER JOIN과 ON 연산자를 사용하여 사원이름과 함께 그 사원이 소속된 부서이름과 지역명을 출력하시오. 

select ename, dname, loc from employee e INNER join department d
on e.dno = d.dno;

--4. NATUAL JOIN을 사용하여 커밋션을 받는 모든 사원의 이름, 부서이름, 지역명을 출력 하시오. 

select ename, dname, loc 
from employee e natural join department
where  e.commission is not null;


-- 5. EQUI 조인과 WildCard를 사용하여 이름에 A 가 포함된 모든 사원의 이름과 부서명을 출력 하시오. 
select ename, dname from employee,department 
where department.dno = employee.dno
and ename like '%A%';


-- 6. NATURAL JOIN을 사용하여 NEW YORK에 근무하는 모든 사원의 이름, 업무, 부서번호 및 부서명을 출력하시오. 

select ename, job, dno, dname, loc 
from employee e natural join department
where  loc = 'NEW YORK';
