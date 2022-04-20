-- 완료시간 : 6: 10분까지 . p.jangwoo@gmail.com, 조장님들에게도 전송. 

-- 1. SUBSTR 함수를 사용하여 사원들의 입사한 년도와 입사한 달만 출력 하시오. 

select ename 성명, substr(hiredate,1,5) 입사년월 from employee;

-- 2. SUBSTR 함수를 사용하여 4월에 입사한 사원을 출력 하시오. 

select ename 성명, substr(hiredate,4,2) 입사월
from employee
where substr(hiredate,4,2) ='04';

-- 3. MOD 함수를 사용하여 직속상관이 홀수인 사원만 출력하시오. 
SELECT ename 성명, manager "직속상관 사원번호" FROM employee
where mod(manager, 2) = 1;

--3-1. MOD 함수를 사용하여 월급이 3의 배수인 사원들만 출력하세요.

SELECT ename 성명, salary "3배수 월급" FROM employee
where mod(salary , 3) = 0;

-- 4. 입사한 년도는 2자리 (YY), 월은 (MON)로 표시하고 요일은 약어 (DY)로 지정하여 출력 하시오. 
select ename 성명, to_char(hiredate, 'yy') 입사년도,
to_char(hiredate, 'MON') 입사월, to_char(hiredate, 'DY') 입사요일 from employee;

--5. 올해 몇 일이 지났는지 출력 하시오. 현재 날짜에서 올해 1월 1일을 뺀 결과를 출력하고
--   TO_DATE 함수를 사용하여 데이터 형식을 일치 시키시오. 
SELECT  to_date('20220101', 'yyyymmdd') 기준일자 ,SYSDATE 오늘일자, 
trunc(SYSDATE - to_date('20220101', 'yyyymmdd'))as "경과일" FROM dual;


-- 5-1. 자신이 태어난 날짜에서 현재까지 몇 일이 지났는지 출력 하세요. 
SELECT  to_date('19880509', 'yyyymmdd') 기준일자 ,SYSDATE 오늘일자,
trunc(SYSDATE - to_date('19880509', 'yyyymmdd')) as "경과일수" FROM dual;

--5-2. 자신이 태어난 날짜에서 현재까지 몇 개월이 지났는지 출력 하세요. 

SELECT  to_date('19880509', 'yyyymmdd') 기준일자 ,SYSDATE 오늘일자,
trunc(months_between (sysdate,to_date('19880509', 'yyyymmdd'))) from dual;

--6. 사원들의 상관 사번을 출력하되 상관이 없는 사원에 대해서는 null 갑대신 0으로 출력 하시오. 

SELECT ename 성명, eno 사원번호, nvl(manager,0) "직속상관 사원번호" 
from employee
order by ename;

--7.  DECODE 함수로 직급에 따라 급여를 인상하도록 하시오. 직급이 'ANALYST' 사원은 200 , 'SALESMAN' 사원은 180,
--    'MANAGER'인 사원은 150, 'CLERK'인 사원은 100을 인상하시오. 
select ename 성명, dno 부서번호, salary "인상 전 월급", decode(JOB, 'ANALYST', 200,
                                                               'SALESMAN', 180,
                                                               'MANAGER', 150,
                                                               'CLERK', 100,
                                                               salary) as "인상액",

                                                  decode(JOB, 'ANALYST', salary + 200,
                                                               'SALESMAN', salary + 180,
                                                               'MANAGER', salary + 150,
                                                               'CLERK', salary + 100,
                                                               salary) as "인상후월급" 
from employee;

--8. 사원번호, 사원번호 2자리만 출력하고 나머지는 가름 as 가린 번호 ,
select eno 사원번호, rpad(substr(eno,2,2),4,'*') 가린번호, ename 성명, rpad(substr(ename,2,2),4,'*') 가린성명 from employee;

--9.
select rpad(substr('880509-1000000',0,8),14,'*') "가린 주민번호", rpad(substr('010-8998-7325',0,6),13,'*') "가린 전화번호" from dual;

--10.사원번호, 직속상관 사원번호(없으면 0000)직속상관
select eno 사원번호, nvl2(manager,manager,'0000') 직속상관,decode(substr(manager,0,2), 75 , 5555,
                                                               76, 6666,
                                                               77, 77777,
                                                               78, 8888,
                                                               substr(manager,0,2))  "변환번호"
from employee;
