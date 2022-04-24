
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
where e1.manager = e2.eno (+) -- outer join이 있어야 직속상관명이 null인 행도 불러와짐
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


4. 평균 월급이 가장 낮은 직급의 가장 박봉인 직원의 직급과 급여를 표시하시오

select ename 성명, job 직급, salary 급여
from employee
where salary = (select min(salary) from employee 
                                   group by job 
                                   having avg(salary) = (select min(avg(salary)) 
                                                        from employee group by job))


5. 각 부서의 최소 급여를 받는 사원의 이름, 급여, 부서번호를 표시하시오.

select ename 이름, salary 급여, dno 부서번호
from employee
where salary in (select min(salary) from employee 
                                   group by dno)

6. 담당 업무가 분석가(ANALYST) 인 사원보다 급여가 적으면서 업무가 분석가가 아닌 사원들을 표시 (사원번호, 이름, 담당업무, 급여) 하시오.

select eno, ename, job, salary
    from employee
    where salary <all (select (salary) 
                    from employee 
                    where job = 'ANALYST')
          and job <> 'ANALYST'
    order by salary asc;



7. 부하직원이 없는 사원의 이름을 표시 하시오. 

select eno, ename
from employee 
where eno not in (select manager from employee where manager is not null);

8. 부하직원이 있는 사원의 이름을 표시 하시오. 
(부하직원이 있다 -> 누군가의 매니저 컬럼에, 나의 사번이 들어있다.)

select eno 사번, ename 성명
from employee
where eno in (select manager from employee);

9. BLAKE 와 동일한 부서에 속한 사원의 이름과 입사일을 표시하는 질의를 작성하시오(단, BLAKE 는 제외). 

select ename 성명, hiredate 입사일
from employee 
where dno = (select dno from employee where ename = 'BLAKE') and ename != 'BLAKE';

10. 급여가 평균보다 많은 사원들의 사원번호와 이름을 표시하되 결과를 급여에 대해서 오름 차순으로 정렬 하시오. 

select eno 사번, ename 성명, salary 월급
from employee
where salary > (select avg(salary) from employee)
order by salary asc;

11. 이름에 K 가 포함된 사원과 같은 부서에서 일하는 사원의 사원번호와 이름을 표시하시오. 

select eno 사원번호, ename 이름
from employee
where dno in (select dno from employee where ename like '%K%'group by dno);

12. 부서 위치가 DALLAS 인 사원의 이름과 부서 번호 및 담당 업무를 표시하시오. 

select ename 이름, e.dno "부서 번호", job "담당 업무"
from employee e, department d
where  e.dno in (select dno from department where loc = 'DALLAS') and e.dno = d.dno;

13. KING에게 보고하는 사원의 이름과 급여를 표시하시오. 

    보고란 표현의 모호성이 존재함. 일반적으로 보고란 상급자를 대상으로 한 하급자의 내용 전달을
    의미하는데, 이 때 상급자는 위계상 자신 위의 모든 사람이 해당됨. 이러한 관점에서 PRESIEDNT의
    직함을 지닌 KING에게 보고가 가능한 사원은 사실상 KING 본인을 제외한 구성원 전부로 볾이 옳음.
    고로 문제를 다음과 같이 해석해여 풀도록 하였음.
    
-> KING을 직속상관으로 둔 사원의 이름과 급여를 표시하시오.

select ename 이름, salary 급여
from employee
where  manager = (select eno from employee where ename = 'KING');

14. RESEARCH 부서의 사원에 대한 부서번호, 사원이름 및 담당 업무를 표시 하시오. 

select ename 이름, e.dno "부서 번호", job "담당 업무"
from employee e, department d
where  e.dno in (select dno from department where dname = 'RESEARCH') and e.dno = d.dno;

15. 평균 급여보다 많은 급여를 받고 이름에 M이 포함된 사원과 같은 부서에서 근무하는 사원의 사원번호, 이름, 급여를 표시하시오. 

1)((조건1: 평균 급여보다 많은 급여를 받고 / 조건2: 이름에 M이 포함된 사원)과 같은 부서에서 근무하는 사원의 사원번호, 이름, 급여를 표시하시오. 

select dno 부서번호, eno 사원번호, ename 이름, salary 급여 
from employee
where dno = (select dno 
             from employee 
             where salary >all (select avg(salary)
                                from employee) 
                                and ename like '%M%');

2) (조건1:평균 급여보다 많은 급여를 받고) (조건2:이름에 M이 포함된 사원과 같은 부서에서 근무하는) 사원의 사원번호, 이름, 급여를 표시하시오.

select dno 부서번호, eno 사원번호, ename 이름, salary 급여 
from employee
where dno in (select dno
             from employee 
             where ename like '%M%')
      and salary > (select avg(salary) from employee)
order by dno asc;

16. 평균 급여가 가장 적은 업무를 찾으시오. 

select job 직무, avg(salary) 평균월급
from employee
group by job
having avg(salary) = (select min(avg(salary)) from employee group by job);

17. 담당업무가 MANAGER인 사원이 소속된 부서와 동일한 부서의 사원을 표시하시오. 

select eno, ename
from employee
where dno in (select dno from employee where job = 'MANAGER');