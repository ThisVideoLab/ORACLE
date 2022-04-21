-- 4일차

/* 
그룹함수 : 동일한 값에 대해 그룹핑해서 처리하는 함수
grout by 절에서 특정 컬럼을 정의할 경우, 해당 ㅋ러럼의 동일한 값들을 그룹핑해서 연산을 적용함

집계함수:
 - suim: 그룹의 합계
 - avg: 그룹의 평균
 - max: 그룹의 최대값
 - min: 그룹의 최소값
 - count : 그룹의 총 개수 (레코드수 record, 로우수 row)
 */
 
 select sum (salary), round(avg(salary)), max(salary), min(salary) from employee;
 
 -- 주의: 집계함수를 처리할 때 ,출력컬럼이 단일 값으로 나오는 컬럼을 정의함
 
 select sum(salary)
 from employee;
 
 SELECT ENAME
 FROM employee;
 
 SELECT * from employee;
 -- 집계함수는 null 값도 진계해서 처리가 가능함
 select sum(commission), avg(commission), max(commission), min(commission) from employee;
 
 -- count (): 레코드 수 , 로우 수
 --           다만 null은 처리할 수 없음
 --           테이블 전체 레코드 수를 가져올 경우 : count (*) 또는 not null 컬럼을 count()
 --           이러한 경우는 description을 볼 수 잇는 desc 명령어로 해당 문서를 확인해서
 --           null 가능 여부를 확인하는 것이 좋음.
 
 desc employee;
 
select eno from employee;
select count (eno) from employee;
 
select commission from employee; -- 14개 컬럼 출력됨
select count(commission) from employee; -- 4가 출력됨 // null 컬럼 가산 불가능

-- 전체 레코드 카운트
select count (*) from employee; -- 이처럼 전체 컬럼 수로 카운팅하는 방법도 있음

-- 중복되지 않는 직업의 갯수
select job from employee; -- 전체 직업 출력
select distinct job from employee; -- 중복 없는 직업 리스트 출력
select count(distinct job)from employee; -- 중복 없는 직업들의 수

-- 부서의 갯수
select dno from employee; -- 전체 부서 출력
select distinct dno from employee; -- 중복 없는 부서 리스트 출력
select count(distinct dno) from employee; -- 중복 없는 부서들의 수

/* group by : 특정 컬럼의 갓을 그룹핑한다. 주로 집계 함수를 select 절에서 같이 사용함.
              다만 select할 때, 그루핑할 수 있는 컬럼을 잘 선택해야 함.

    순서 ---
    select: 컬럼명, 집계함수 처리된 컬럼
    from 테이블
    where 조건
    group by 컬럼명 (결과로 출력)
    having 조건 (group by한 결과의 조건)
    order by 정렬

*/

select dno 부서번호, trunc(avg(salary)) 평균급여
from employee
group by dno; -- 그룹별로 위 컬럼들을 수입해서 출력해줌

select dno from employee order by dno;

-- 전체 평균 급여
select trunc(avg(salary)) 평균급여 from employee;

select dno,count(dno), sum(salary), trunc(avg(salary))
from employee 
group by dno;

-- 여러 항목들 그루핑해보기
select job 직책, count(job) 인원, trunc(avg(salary)) 평균월급, sum(salary) "직책별 월급 총액", 
max(salary) 최고월급, min(salary) 최저월급
from employee
group by job;

-- 다중 그루핑

select dno 부서명, job 직무, count(*) 인원, trunc(avg(salary)) 평균월급
from employee
group by dno, job -- 두 컬럼이 일치하는 항목들을 그루핑함
order by dno;

select dno, job
from employee
where dno = 20 and job = 'CLERK';

--having group by에서 나온 결과를 조건으로 처리할 때
    --별칭 이름을 조건으로 사용하면 안됨.
select dno 부서명, count(*) 인원, sum(salary) 월급총액, round(avg(salary),2) 월급평균
from employee
group by dno
having sum (salary) > 9000;

-- 부서별 월급의 평균이 2000 이상인 부서만을 출력

select dno 부서명, count(*) 인원, sum(salary) 월급총액, round(avg(salary),0) 월급평균
from employee
group by dno
having avg(salary) > 2000;

--where와 having 절이 같이 사용되는 경우
    -- where: 실제 테이블의 조건으로 검색
    -- having: group by 결과에 대해 조건을 처리함.
    
select dno 부서명, count(*) 인원, sum(salary) 월급총액, round(avg(salary),0) 월급평균
from employee
where salary > 1500
group by dno
having avg(salary) > 2000;

-- GROUP BY 절에서만 사용하는 특수한 함수들.
-- 여러 컬럼을 나열할 수 있음. 또한 GROUP BY 함수들의 자세한 정보들을 출력 가능함.

-- 원본
SELECT dno, count(*), sum(salary), round(avg(salary)) 
from employee
group by dno
order by dno;

-- rollup 사용: 부서별 합계와 평균을 출력 후, 마지막 라인에 전체에 대해 각 컬럼에 적용된
--              함수를 다시 사용해서 해당 컬럼 전체의 값을 출력함.
SELECT dno, count(*), sum(salary), round(avg(salary)) 
from employee
group by ROLLUP(dno)
order by dno;

-- rollup 사용하지 않은 경우: 
SELECT dno, job, count(*), max(salary), sum(salary), round(avg(salary)) 
from employee
group by (dno, job)
order by dno asc;

/* 컬럼을 2개로 잡아 롤업하는 경우

   위 예제에서 본 것처럼 dno에 대해서 전체적으로 rollup을 해줌. 그리고나서 롤업에 조건으로
   넣은 A 컬럼과 B 컬럼이 일치하는 것끼리 모아서 그루핑해서 개별적으로 ROLLUP을 해줌.
   그 후 마지막으로 전체 결과에 대한 rollup으로 마무리 함.

*/

-- rollup 사용: 두 컬럼 이상 묶어서 사용 가능함.
SELECT dno, job, count(*), max(salary), sum(salary), round(avg(salary)) 
from employee
group by ROLLUP(dno, job) -- 두개의 컬럼에 적용됨, 두 컬럼을 잡고 첫번째 먼저 정렬한 뒤
order by dno;             -- 두번째 컬럼으로 하위 정렬을 시도함

/* 컬럼을 2개로 잡아 큐빙하는 경우
   위 예제에서 본 것처럼 dno에 대해서 전체적으로 rollup을 해줌. 그리고나서 롤업에 조건으로
   넣은 A 컬럼과 B 컬럼이 일치하는 것끼리 모아서 그루핑해서 개별적으로 ROLLUP을 해줌.
   큐빙은 롤업에서 한단계 더 자세하게, 앞에서 그루핑별로 rollup한 내역을 모아서 한번 더
   출력해준 다음에 마지막으로 전체 결과에 대한 rollup으로 마무리 함.
*/
 
 --cube:  부서별 합계와 평균을 출력 후, 마지막 라인에 전체 합계
SELECT dno, job, count(*), max(salary), sum(salary), round(avg(salary)) 
from employee
group by cube (dno, job)
order by dno, job;

--JOIN : 
-- department와 employee는 원래 하나의 테이블이었으나, 모델링(중복제거, 성능향상의 효과가 있음)을 통해서 두 테이블로 분리되었음.
-- 두 테이블의 공통키는 (dno) 컬럼, elmplyee 테이블의 dno 컬럼은 department테이블의 dno 컬럼을 참조하고 있음.
-- 이렇게 2개 이상의 테이블을 함께 가져올 때 join이라는 함수를 사용해 출력함.

SELECT* FROM department; -- 부서 정보를 저장하는 테이블
SELECT* FROM employee; --  사원의 정보를 저장하는 테이블

-- EQUI JOIN : 오라클에서 제일 많이 사용하는 JOIN, oracle에서만 사용 가능함
    -- from절: 조인할 테이블을 ","로 처리함
    -- where절: 두 테이블의 공통의 키 컬럼을 "="로 처리
    -- and절: 조건을 실질적으로 처리하는 구문

select * 
from employee,department 
where department.dno = employee.dno
and job = 'MANAGER';

--join시 테이블 알리아스(별칭화 - 기니까 보통 알리아스 해서 많이 씀)
select * 
from employee e,department d 
where e.dno = d.dno
AND salary >1500;

-- select 절에서 공통 key colunm을 출력하는 경우에는, 어느 테이블의 컬럼을 출력할지 명시해야함.
SELECT eno, job, d.dno, dname -- 공통 부분을 출력하는 경우에 이렇게 d.dno라고 어디를 출력할지 명시해야 함.
from employee e, department d
where e.dno = d.dno;

-- 두 테이블을 JOIN해서 부서별로 월급의 최대값을 나타내시오

SELECT dname, count(*), max(e.salary) 
from employee e, department d
where d.dno = e.dno
GROUP by d.dname;

-- NATURAL JOIN: ORACLE 9I 지원
    --EQUI JOIN의 WHERE절을 없앰: 두 테이블의 공통의 키 컬럼을 "="로 정의함
    -- 공통의 키 컬럼을 oralce 내부적으로 자동으로 감지해서 처리함.
    -- 다만 공통 키컬럼을 별칭이름을 사용하면 오류가 발생하는 단점이 있음.
    -- 반드시 공통 키 컬럼은 데이터 타입이 같아야 함.
    
select eno, dname, ename, dno 
from employee e natural join department d;
    
-- 주의: select 절의 공통키 컬럼을 출력시, 테이블 명을 명시하면 오류가 발생함.

select eno, dname, ename, d.dno -- 다른 컬럼들은 다 괜찮은데, 공통키컬럼 dno에다가
from employee e natural join department d; -- 테이블 알리아스 달면 에러남

-- equi join vs natural join의 공통 키 컬럼 처리
    -- equi join: select 부분에서 공통 키 컬럼을 출력할 때, 테이블 명을 반드시 명시해야함
    -- natural join: select 부분에서 공통 키 컬럼을 출력할 때, 테이블 명을 명시하면 에러가 남.

--where 절: 공통 키 컬럼을 처리한 경우
select * 
from employee, department
where department.dno = employee.dno  -- 공통 키 적용
and job = 'MANAGER';                 -- 조건을 처리

--on절: 공통 키 컬럼을 처리한 경우

select * from employee e join department d
on e.dno = d.dno  -- 공통 키 적용
where job = 'MANAGER';                 -- 조건을 처리

--ANSI 호환: INNER JOIN < == 모든 SQL에서 사용 가능한 JOIN 구문
    --ON 절: 두 테이블의 공통의 키 컬럼을 "="로 처리
        --WHERE 절: 조건을 처리함

select * from employee e INNER join department d
on e.dno = d.dno  -- 공통 키 적용
where job = 'MANAGER';                 -- 조건을 처리

select * from employee e INNER join department d
on e.dno = d.dno  -- 공통 키 적용
where job = 'MANAGER';                 -- 조건을 처리

-- equi join 예시
select ename, salary, dname, e.dno   --e.dno: equi join에서는 명시
from employee e, department d
where e.dno = d.dno
and salary >2000;    --equi join만 특이하게 조건절에 and를 씀

-- natural join 예시
select ename, salary, dname, dno   --dno: natural join에서는 테이블 명시하면 에러남
from employee e natural join department
where  salary >2000;

--  Ansi : inner join
select ename, salary, dname, e.dno  
from employee e join department d
on e.dno = d.dno
where salary >2000;

--NON EQUI JOIN : EQUI JOIN에서 Where 절의 "="를 사용하지 않은 JOIN

select * from salgrade; -- 월급의 등급을 표시하는 테이블

select ename, salary, grade
from employee, salgrade
where salary between losal and hisal;

-- 테이블 3개 조인시키기

select ename, dname, salary, grade -- 여러 테이블의 컬럼들을 출력함
from employee e, department d, salgrade s

-- SELECT * FROM department;