
--subquery 문제. 

--Join 문제.
--완료 시간 : 6:20분까지. 

--7. SELF JOIN을 사용하여 사원의 이름 및 사원번호를 관리자 이름 및 관리자 번호와 함께 출력 하시오. 각열에 별칭값을 한글로 넣으시오. 
 	
select e1.ename 이름, e1.eno 사원번호, nvl(e1.manager,'0') 관리자번호, e2.ename 관리자이름
from employee e1, employee e2
where e1.manager = e2.eno
order by e1.ename asc;

-- 8. OUTER JOIN, SELF JOIN을 사용하여 관리자가 없는 사원을 포함하여 사원번호를 기준으로 내림차순 정렬하여 출력 하시오. 

select e1.eno 사원번호, e1.ename 사원명, e2.ename 직속상관명
from employee e1, employee e2
 e1.manager = e2.eno (+) -- outer join이 있어야 직속상관명이 null인 행도 불러와짐
order by e1.eno asc;

--9. SELF JOIN을 사용하여 지정한 사원의 이름, 부서번호, 지정한 사원과 동일한 부서에서 근무하는 사원을 출력하시오. 
--   단, 각 열의 별칭은 이름, 부서번호, 동료로 하시오. 

select  e1.ename 사원명, e1.dno 부서번호, e2.ename 동료
from employee e1, employee e2
where e1.ename = 'SCOTT' and e1.dno = e2.dno
order by e1.eno asc;

-- 10. SELF JOIN을 사용하여 WARD 사원보다 늦게 입사한 사원의 이름과 입사일을 출력하시오. 

select  e2.ename 이름, e2.hiredate 입사일
from employee e1, employee e2
where e1.ename = 'WARD' and e1.hiredate < e2.hiredate
order by e1.eno asc;



11. SELF JOIN을 사용하여 관리자 보다 먼저 입사한 모든 사원의 이름 및 입사일을 관리자 이름 및 입사일과 함께 출력하시오. 
    단, 각 열의 별칭을 한글로 넣어서 출력 하시오. 
    
select  e1.ename 사원이름, e1.hiredate 사원입사일, e2.ename 관리자이름, e2.hiredate 관리자입사일
from employee e1, employee e2
where e1.manager = e2.eno and e1.hiredate < e2.hiredate 
order by e2.ename asc;




-- 단일행 서브쿼리 : sub query의 결과값이 단 하나만 출력됨
    -- 단일행 비교 연산자: >, =, >=, <,<=,<>,<=
-- 다중행 서브 쿼리: sub query의 결과 값이 여러개 출력
-- 다중행 서브 쿼리 연산자: IN, ANY, SOME, ALL, EXISTS
--    IN: 메인 쿼리의 비교 조건 ('*'연산자로 비교할 경우) 이 서브쿼리의 결과 값 중에서 하나라도 일치하면 참
--        ANY, SOME: 메인 쿼리의 비교 조건이 서브쿼리의 검색 결과와 하나 이상 일치하면 참
--        ALL : 메인 쿼리의 비교 조건이 서브 쿼리의 검색 결과와 모든 값이 일치하면 참
--        EXIST: 메인 쿼리의 비교 조건이 서브 쿼리의 결과값 중에서 만족하는 값이 하나라도 존재하면 참.
        
-- ALL 연산자
    -- subquery의 반환하는 모든 값과 비교함        
    -- '>all': 최대값보다 큼을 나타냄
    --'<all': 최소값보다 작음을 나타냄

<<아래 문제는 모두 Subquery를 사용하여 문제를 푸세요.>>

1. 사원번호가 7788인 사원과 담당 업무가 같은 사원을 표시(사원이름 과 담당업무) 하시오.  

select ename, job
from employee
where job = (select job from employee where eno = 7788);

2. 사원번호가 7499인 사원보다 급여가 많은 사원을 표시 (사원이름 과 담당업무) 하시오. 

select ename, job
from employee
where salary > (select salary from employee where eno = 7499);

3. 직급별 최소 급여를 받는 사원의 이름, 담당 업무 및 급여를 표시 하시오(그룹 함수 사용)

select ename, job, salary 
from employee
where salary in(select  min(salary) 
                from employee 
                group by job)
order by salary asc;


4. 평균이 가장 낮은 직급의 가장 박봉인 직원의 직급과 급여를 표시하시오

select job ,min(salary)
from employee
where dno =  (select dno salary from employee group by dno having min(avg(salary)));

평균이 가장 낮은 직급의 연봉 = select min(avg(salary)) from employee group by dno
                            

select min(avg(salary)) from employee group by dno

order by salary asc;

5. 각 부서의 최소 급여를 받는 사원의 이름, 급여, 부서번호를 표시하시오.

select ename 성명, job 직무, salary 월급
from employee
where salary = (select min(salary) from employee);

6. 담당 업무가 분석가(ANALYST) 인 사원보다 급여가 적으면서 업무가 분석가가 아닌 사원들을 표시 (사원번호, 이름, 담당업무, 급여) 하시오.

select eno, ename, job, salary
    from employee
    where salary <all (select (salary) 
                    from employee 
                    where job = 'ANALYST')
          and job <> 'ANALYST'
    order by salary asc;

select * from employee;

7. 부하직원이 없는 사원의 이름을 표시 하시오. 

select eno
from employee 
where NO EXISTS (select manager from employee);

8. 부하직원이 있는 사원의 이름을 표시 하시오. 

부하직원이 있다 -> 누군가의 매니저 컬럼에, 나의 아이디가 들어있다.

select eno, ename
from employee 
where EXISTS (select manager from employee);

9. BLAKE 와 동일한 부서에 속한 사원의 이름과 입사일을 표시하는 질의를 작성하시오(단, BLAKE 는 제외). 

10. 급여가 평균보다 많은 사원들의 사원번호와 이름을 표시하되 결과를 급여에 대해서 오름 차순으로 정렬 하시오. 

11. 이름에 K 가 포함된 사원과 같은 부서에서 일하는 사원의 사원번호와 이름을 표시하는 질의를 작성하시오. 

12. 부서 위치가 DALLAS 인 사원의 이름과 부서 번호 및 담당 업무를 표시하시오. 

13. KING에게 보고하는 사원의 이름과 급여를 표시하시오. 

14. RESEARCH 부서의 사원에 대한 부서번호, 사원이름 및 담당 업무를 표시 하시오. 

15. 평균 급여보다 많은 급여를 받고 이름에 M이 포함된 사원과 같은 부서에서 근무하는 사원의 사원번호, 이름, 급여를 표시하시오. 

16. 평균 급여가 가장 적은 업무를 찾으시오. 

17. 담당업무가 MANAGER인 사원이 소속된 부서와 동일한 부서의 사원을 표시하시오. 


