--1. 덧셈 연산자를 사용해 모든 사원에 대해  $300의 급여인상을 계산한 후에
--   인산된 급여를 출력할 것



SELECT ename 사원이름, salary 급여, (salary+300) "인상된 급여" 
from employee;

--2. 사원의 이름, 급여, 연강 총수입이 많은것부터 작은순 출력
SELECT ename 사원이름, salary 급여, (salary*12+100) "인상된 급여" 
from employee;

--3. 급여가 2000을 넘는 사원의 이름과 급여를 급여가 작은 순으로 출력

SELECT ename 성명, salary 
FROM employee
order by salary asc;

--4. 사원번호가 7788인 사원의 이름과 부서번호 출력

SELECT ename 성명, dno 부서코드
from employee
where eno = 7788;

--5 급여가 2천~3천 사이에 포함되지 않는 사원의 이름과 급여를 출력

SELECT ename 성명, salary 월급
from employee
where salary < 2000 or salary > 3000;

--6. 1981 2월 20일부터 81년 5월 1일 사이의 입사한 사원의 이름 담당업무, 입사일 출력

SELECT ename 성명, job 직무, hiredate 입사일
FROM employee
where hiredate BETWEEN '1981/2/20' and '1981/5/1';

--7. 부서번호가 20 및 30에 속한 사원의 이름 / 부서번호 출력 (이름 내림차순 기준)
SELECT ename 성명, dno 부서번호
from employee
where dno = 20 or dno = 30
order by ename desc;

--8. 사원의 급여가 2000 ~ 3000 사이 / 부서번호 20 또는 30 인 사원의
-- 이름, 급여, 부서번호를 이름의 오름차순으로 입력

SELECT ename 성명, salary 월급, dno 부서번호
from employee
where salary BETWEEN 2000 and 3000 and dno in (20,30)
ORDER by ename asc;


--9 1981 년도에 입사한 사원의 이름과 입사일 출력(lke 연산자 및 와일드카드 활용)

SELECT ename 이름, hiredate 입사일
FROM employee
where hiredate like '81/%';

--10. 관리자가 없는 사원의 이름과 담당업무 출력

SELECT ename 성명, job 직무 
from EMPLOYEE
where manager is null;

--11. 커미션을 받을 수 있는 자격이 되는 사원의 이름/급여/커미션 출력
-- 단 급여및 커미션을 기준으로 내림차순 정렬

SELECT ename 성명, salary 월급, commission 보너스
FROM employee
where commission is not null
ORDER BY salary, commission desc;

--12. 이름의 세번째 문자가 R인 사원의 이름을 표시하시오.

SELECT ename 성명
from employee
where ename like '__R%'; 

--13. DLFMADP A와 E를 포함하고 있는 사원의 이름을 표시하시오

SELECT ename 성명
from employee
where ename like '%A%' AND ename like '%E%'; 

--14. 담당업무가 사무원 (CLERK) 또는 영업사원 (SALESMAN)이면서 급여가
-- 1600/950/1300/에 해당하지 않는 인원의 이름 담당업무 급여 출력

SELECT ename 성명, job 직무, salary 월급
FROM employee
WHERE JOB in ('CLERK','SALESMAN') AND salary NOT IN (1600,950,1300);

--15. 커미션이 500 이상인 사원의 이름과 급여 및 커미션 출력

SELECT ename 성명, salary 월급, commission 보너스
FROM employee
WHERE commission >= 500;