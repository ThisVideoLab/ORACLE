-- 2일차 : DQL : Select

desc department;

select * from department;

/*
SQL : 구조화된 질의 언어

Select 구문의 전체 필드 내용

Select   <== 컬럼명
Distinct <== 컬럼내의 값의 중복을 제거해라.
From     <== 테이블 명, 뷰 명.
Where    <== 조건
Group By <== 특정 값을 그룹핑
Having   <== 그룹핑 한 값을 정렬
Order by <== 값을 정렬해서 출력
(순서 중요)
*/
desc employee;
select *
from employees;

-- 특정 컬럼만 출력 하기
select eno, ename from employees;

select * from employees;

select employee_id, first_name, salary from employees;

-- 컬럼명 알리어스 ( Alias) : 컬럼의 이름을 변경
-- 컬럼에서 연산하거나 함수를 사용하면 컬럼명이 없어짐



-- as를 붙여서 컬럼명을 바꿀 수 있음
select employee_id, first_name, salary as 월급 from employees;

-- as는 생략이 가능함
select employee_id 사원번호, first_name 사원명, salary 월급 from employees;

-- 공백이나 특수문자가 들어갈 때는 ""으로 처리해줘야 함.
select employee_id "사원 % 번호", first_name 사원명, salary 월급 from employees;

-- nvl  함수 : 연산시에 null을 처리하는 함수
select * from employees;

select employee_id 사원번호, first_name 사원명, salary 월급, commission_pct 보너스,
salary*12 + commission_pct 연봉-- 전 인원의 연봉 계산
from employees;

-- 이렇게 null이 들어간 컬럼의 연산을 출력하면 포함되었다는 그 사실 하나만으로 값이 모두
-- null로 바뀌어버림. 고로 null을 0으로 바꿔 처리하는 것이 필요함. 이대 필요한 것이
-- nvl 함수임. 

select employee_id 사원번호, first_name 사원명, salary 월급, nvl(commission_pct,0)
보너스, salary*12 + nvl(commission_pct,0) 연봉-- 전 인원의 연봉 계산
from employees;

-- 이와 같이 nvl(컬럼명,0)에 넣고 0자리에 대체하고 싶은 값을 넣으면 null을 대체함.

-- 특정 컬럼의 내용에서 중복을 제거한 후에 출력함.

select * from employees;
select department_id from employees;
select nvl(commission_pct,0) from employees;

-- 조건을 사용해서 검색 (where)

select * from employees;
select employee_id 사원번호, first_name 사원명, salary 월급, nvl(commission_pct,0)
보너스, salary*12 + nvl(commission_pct,0) 연봉-- 전 인원의 연봉 계산
from employees;

-- 사원번호가 109인 사원의 전체 정보를 검색
select * from employees 
where employee_id = 109;

-- 사원번호가 109인 사원의 원하는 정보만을 검색함
select employee_id 사원번호, first_name 사원명, salary 월급, nvl(commission_pct,0)
보너스, salary*12 + nvl(commission_pct,0) 연봉 from employees 
where employee_id = 109;

-- 사원 이름으로 검색할 때, 문자는 ''를 써줘야 함.
select * from employees where first_name = 'Daniel';



-- 레코드 가져올 때
-- number 에는 ''을 붙이지 않아도 된다. 다만 문자데이터 (char)를 가져올때는 사용해야함.
-- 또한 대소문자를 구분하지 않는 코드와는 다르게, 값을 불러올 때는 대소문자를 구분함

-- 입사날짜가 06/02/05 인 사람의 이름만 출력
select first_name 성명, hire_date 입사일 from employees where hire_date = '06/02/05';

-- 부서코드가 60인 사람들을 보두 출력
select first_name 성명, department_id 부서코드  from employees
where department_id = 60;

-- 월급이 3000 이상인 사원의 이름과 부서와 입사 날짜를 출력하기
select first_name 사원명, department_id 부서코드, hire_date 입사일,  salary 월급
from employees
where salary > 3000;

-- Null 검색 : is 키워드 사용
-- 자바와는 다르게 null은 다르게 취급해서 is로 사용해야 함.
select *
from employees
where commission_pct is null;

--commision이 2할 이상인 사원들의 이름과 직책, 월급 출력
select first_name 성명,job_id 직책, salary 월급, commission_pct 보너스
from employees
where commission_pct > 0.2;

--commision이 없는 사원들의 이름과 직책, 월급 출력
select first_name 성명,job_id 직책, salary 월급, commission_pct 보너스
from employees
where commission_pct is null;

-- 월급이 500이상 2500 미만인 사원들의 이름, 사원번호, 입사날짜 월급을 출력

select first_name 성명, employee_id 사원번호, hire_date 입사일, salary 월급
from employees
where salary >=2300 and 2500> salary;

-- 직책이  account이거나, 부서코드가 30(pu_man)인 사람의
-- 사원이름, 직책, 월급, 부서코드를 출력
select * from employees;
select first_name 성명,job_id 직책, salary 월급, department_id 부서코드
from employees
where job_id = 'FI_ACCOUNT' or department_id = 30;

-- 커미션이 없는 사용자 중에서 부서코드가 20인 사용자의 이름, 부서코드와 입사날짜를 출력
SELECT first_name 성명, department_id 부서코드, hire_date 입사일,
       nvl(commission_pct,0) 보너스
from employees
where commission_pct is null and department_id = 20;

-- 커미션이 null이 아닌 사용자의 이름, 입사날짜, 월급을 출력
SELECT first_name 성명, hire_date 입사일, salary 월급, commission_pct 보너스
FROM employees
where commission_pct is not null;

-- 날짜검색
SELECT *
from employees
where hire_date >= '2002/1/1' and hire_date <= '2003/12/31';

-- between A and B : A 이상 B 이하

SELECT *
from employees
where hire_date between '2002/1/1' and '2003/12/31';

-- In 연산자 
-- 커미션이 2할, 3할, 4할인 사원의 이름, 직책, 입사일을 출력
select first_name 성명, job_id 직책, hire_date 입사일, commission_pct 보너스
from employees
where commission_pct in (0.2, 0.3, 0.4);
-- where commission_pct = 0.2 or  commission_pct = 0.3 or commission_pct = 0.4;
-- 보통은 이렇게 or로 입력하는데 인간적으로  넘모 길다

--like  : 컬럼내의 특정한 문자열을 검색 <== 게시판, 자료실의 글 검색 기능 제공
    -- % : 앞 또는 뒤에 붙여서 그 이전이나 이후로 어떤 글자가 와도 상관 없음
    -- _ : 한글자가 어떤 값이 와도 상관 없음
    
-- S로 시작하는 모든 직원들을 출력 -- 이 때 대소문자를 꼭 구분할 것

SELECT *
from employees
where first_name like 'S%';

-- es로 끝나는 모든 직원들을 출력 -- 이 때 대소문자를 꼭 구분할 것
SELECT *
from employees
where first_name like '%es';

-- J로 시작해서 J 뒤에는 어떤것이 와도 상관 없으되ㅡ, 마지막이 es로 끝나는 직원들

SELECT * from employees
where first_name like 'J_mes'; -- 딱 1글자

-- 직책의 맨 마지막이 MAN이 들어가는 모든 사람 출력

SELECT *
from employees
where job_id like '%MAN%'; -- 앞뒤로 뭐가 붙던 노상관

-- 02년도에 입사한 직원 목록 출력

select *
from employees
where hire_date like '02%';

-- 02년도 6월에 입사한 직원 목록 출력

select *
from employees
where hire_date like '02/06%';

-- 정렬 : order by, asc(오름차순 정렬), desc(내림차순 정렬)

SELECT *
from employees
ORDER BY employee_id asc;

SELECT *
from employees
ORDER BY employee_id desc;

-- 이름 컬럼을 정렬

SELECT *
from employees
ORDER BY first_name asc;

SELECT *
from employees
ORDER BY first_name desc;

-- 입사 날짜로 정렬

SELECT *
from employees
ORDER BY hire_date asc;

-- 질문답변형 게시판에서 주로 사용 두개 이상의 컬럼을 정렬할 때
-- 1순위로 첫번째 컬럼을 정렬하고, 첫 컬럼이 같으면 2번째를 기준으로 정렬함.

SELECT *
from employees
ORDER BY department_id, first_name; 

-- 오름차순 내림차순 혼합해서 사용하기

SELECT department_id 부서명, first_name 성명
from employees
ORDER BY department_id desc, first_name; 

--where절과 order by 절이 같이 사용될 때의 옳은 순서

select *
from employees
where commission_pct is null
order by first_name desc;  -- oder by는 항상 제일 마지막에 입력할 것.



/* 다양한 함수 사용하기
    
1. 문자를 처리하는 함수
    UPPER: 대문자로 변환
    LOWER: 소문자로 변환
    INITCAP: 첫자만 대문자로, 나머지는 소문자로 변환
    
     dual 테이블 : 하나의 결과를 출력 하도록 하는 테이블
*/

SELECT '안녕하세요' as 안녕
from dual; --실제로 이런 테이블은 없지만, 그냥 출력하도록 해줌

SELECT 'Oracle mania', UPPER ('Oracle mania'), LOWER ('Oracle mania'),
initcap ('Oracle mania')
from dual;

SELECT * FROM employee;


SELECT ename, lower(ename), UPPER(ename), initcap(ename)
from employee;

SELECT * FROM employee
WHERE ename = 'allen'; -- 검색이 안됨.

SELECT * FROM employee
WHERE lower(ename) = 'allen';

SELECT * FROM employee
WHERE initcap(ename) = 'Allen';

-- 문자 길이를 출력하는 함수
    --length: 문자의 길이를 반환, 영문이나 한글 관계없이 글자수를 리턴함
    --lengthb: 문자의 길이를 반환, 영문은 1byte 한글 3byte로 반환

SELECT LENGTH ('Oracle mania'), length ('오라클 매니아')from dual;

SELECT LENGTHb ('Oracle mania'), lengthb ('오라클 매니아')from dual;

SELECT * FROM employee;

SELECT ename, length (ename), job, length(job) from employee;

/* 문자 조작 함수
    concat: 문자와 문자를 연결해서 출력함
    substr:  문자를 특정 위치에서 잘라오는 함수 (영문, 한글 모두 1byte로 처리)
    substrb: 문자를 특정 위치에서 잘라오는 함수 ( 영문은 1byte, 한글은 3byte처리)
    instr: 문자의 특정 위치의 인덱스 값을 반환함 ( 영문은 1byte, 한글은 3byte처리)
    lpad: 좌측부터 시작해, 지정한 글자수만큼, 특정 문자열을 추가로 입력해줌.
    rpad: 우측부터 시작해, 지정한 글자수만큼, 특정 문자열을 추가로 입력해줌.
*/



-- concat: 붙여서 출력하기
SELECT 'Oracle', 'mania', concat ('Oracle', 'mania') from dual;

-- 여러 컬럼을 한 문장으로 연결하기

SELECT 'Oracle', 'mania', concat ( 'Oracle', 'mania') from dual;
SELECT * from employee;
SELECT concat (ename, '   ' ||job) from employee; -- 한 컬럼 내에 여러 것

SELECT '이름은 ' || ename || '이고, 직책은 ' || job || '입니다' as 컬럼연결
from employee;

SELECT '이름은 ' || ename || '이고, 직속상관 사번은 ' || manager || '입니다'
as 컬럼연결
from employee;

--substr(대상, 시작위치, 추출갯수): 특정 위치에서 문자를 잘라옴. 공백도 포함한다
SELECT 'Oracle mania', substr ('Oracle mania', 4,3), substr('오라클 매니아', 2,4)
from dual;

SELECT 'Oracle mania', substr ('Oracle mania', -4,3), substr('오라클 매니아', -6,4)
from dual; -- 첫 시작을 0으로 잡아서 끝에서부터 n 번째부터 출력함

SELECT ename, substr(ename, 2,3), substr(ename, -5, 2) from employee;
-- 칸이 모자라는 경우나 기타 경우에는 null이 뜰 수 있음

SELECT substrb ('Oracle mania', 3,3), substrb ('오라클 매니아', 4,6) from dual;

-- 이름이 N으로 끝나는 서원들 출력하기 (substr 함수를 사용해서 사용)

SELECT ename 성명 from employee
where substr (ename, -1, 1) = 'N';

-- 87년도에 입사한 사원들 출력하기 (substr 함수를 사용해서 출력)
select ename 성명, hiredate 입사일 from employee
where substr (hiredate, 0, 2) = '87';

--instr (대상, 찾을 글자, 시작 위치) 몇번째 발견) 

select 'Oracle mania', instr ('oracle mania', 'a') from dual;

select 'Oraclea mania', instr ('oracle mania', 'a', 5, 2) from dual;
    -- 5번째 부터 시작해서 2번째 발견되는 a의 인덱스 번호를 출력함
    
select 'Oraclea mania', instr ('oracle mania', 'a', -5, 1) from dual;
    -- 음수는 역순으로 검색함. 역순으로 검색하고 출력값은 정방향의 인덱스 번호 출력함
    
select distinct instr (job, 'A',1,1) 직책 from employee
where lower(job) = 'manager';

-- lpad 좌측부터 시작해, 입력한 글자수만큼, 특정 문자열을 추가로 입력해줌.
select lpad( salary, 10 ,'*') from employee;

-- rpad: 우측부터 시작해, 지정한 글자수만큼, 특정 문자열을 추가로 입력해줌.
select rpad( salary, 10 ,'*') from employee;

-- TRIM : 공백제거, 특정 문자도 제거
    --LTRIM: 왼쪽의 공백을 제거
    --RTRIM: 오른쪽의 공백을 제거
    --TRIM: 양쪽의 공백을 제거
    
SELECT LTRIM ('   orcale mania   ') a, rtrim ('   ocalce mania   ') b, 
trim ('   oracle mania   ') c from dual;