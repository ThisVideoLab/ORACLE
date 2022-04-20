/* 숫자 함수
ROUND : 특정 자릿수에서 반올림.
ROUND(대상): 소수점의 첫번째 자리를 반올림해버림
ROUND(대상, 소수점 자릿수)
    소숫점 자리수가 양수일 경우 : 소수점 기준 오른쪽으로 자릿수만큼 이동한 뒤에 그 다음 값을 반올림.
    소숫점 자리수가 음수일 경우 : 소수점 기준 왼쪽으로 자릿수만큼 이동한 뒤에 그 자리 값을 반올림.

TRUNC : 특정 자릿숭에서 잘라내서 버림
MOD : 입력받은 수를 나눈 나머지 값만을 출력함
*/

-- ROUND: 소수점 자리수가 양수일 경우의 이동 경로
select 99.7564, ROUND (98.7654), round (98.7654,2) from dual; -- 소수점 기준 2자리 오른쪽 이동, 그 후 값을 읽으면 5가 나옴.
                                                              -- 그 결과 98.77이 출력됨.ㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍ


-- ROUND: 소수점 자리수가 음수일 경우의 이동 경로
select ROUND (98.7654,-1) from dual; -- 소수점 기준 1자리만큼 왼쪽으로 이동하면,
                                     --  한자리수인 8을 반올림하여 100의 값을 출력 함.
select ROUND (98.7654,-3) from dual; -- 소수점 기준 3자리만큼 왼쪽으로 이동하면,
                                     -- 세자리수를 보고 반올림하는데, 0이므로 반올림하지 못하고 나머지 다 버려버림.

-- TRUNC: ROUND와 작동 방식이 동일함
select 98.7654 원본숫자, TRUNC(98.7654) as "turnc 기본적용", 
TRUNC(98.7654,2)as "turnc 2입력", TRUNC(98.7654,-1) as "turnc -1 입력"  from dual;

-- MOD (대상, 나누는 수) : 대상을 나누어서 나머지 값만 출력함.
SELECT mod (31,2), mod(31, 5), mod(31,8) from dual;

select *  from employee;

select salary, mod (salary, 300) from employee;

-- employee 테이블에서 사원번호가 짝수인 인원들만 출력함

SELECT ename 성명, eno 사원번호
FROM employee
where mod(eno, 2) = 0;

select 12345.6789, round (12345.6789), round (12345.6789, -3) from dual;
 
/* 날짜 함수

sysdate: 시스템에 저장된 현재 날짜를 출력함.
month_between: 두 날짜 사이가 몇개월인지를 반환함.
add_month: 특정 날짜에 개월수를 더한다.
next_day: 특정 날짜에 최초로 도래하는 인자로 받은 요일의 날짜를 반환함
*/

-- sysdate: 자신 시스템 기준의 년월일을 출력함.
select sysdate from dual;

-- sysdate ± n: n일 만큼 앞 또는 뒤의 날짜를 출력함.
select sysdate - 1 어제날짜 , sysdate 오늘날짜, sysdate + 1 내일날짜 from dual;

-- 마찬가지로 날짜에 관련된 함수라면, 앞선 sysdate처럼 n 일을 추가 또는 제외 가능함.
select ename 성명,hiredate 입사일, hiredate +365 입사1주년 from employee;

-- 각 사원들의 근무한 개월 수 구하기.
SELECT ename 성명, hiredate 입사일, trunc((sysdate - hiredate)/30) 근속개월수 from employee;

-- months_between(data1, data2): data1과 data2 사이의 개월수를 출력
SELECT ename 성명, hiredate 입사일, trunc(months_between (sysdate, hiredate)) 근속개월수 from employee;

-- 각 사원들의 근속 년수 구하기.
SELECT ename 성명, hiredate 입사일, trunc((sysdate - hiredate)/365) 근속년수 from employee;

-- 특정 월에 입사한 인원들 구하기: 12월 입사자 출력
SELECT ename 성명, hiredate 입사일 from employee where hiredate like '%/12/%';
SELECT ename 성명, hiredate 입사일 from employee where hiredate ('month')= 12;

-- trunck를 날짜에 적용하기 : 01일이나 01월, 01년 등의 초기값으로 출력됨
select hiredate, trunc(hiredate, 'month') 입사월 from employee;

-- round를 날짜에 적용하기 : 기간의 절반 이상이 되면 반올림 되서 올려버림.
select hiredate, round(hiredate, 'year') 입사월 from employee;

-- 압사한 후 6개월 지난 시점을 출력함
SELECT hiredate, add_months (hiredate,6) from employee;


--next_day (data, '요일'): date의 도래하는 요일에 대한 날짜를 출력하는 함수
select sysdate 오늘, next_day(sysdate, '토요일') as"이번주 토요일" from dual;

--last_day(date): date에 들어간 달의 마지막 날짜.
select hiredate, last_day(hiredate) from employee; --입사월의 마지막 날을 찍어줌

/* 형변환 함수 (매우 중요함)

TO_cHAR:  날짜형 또는 숫자형 데이터를 문자형으로 변환하는 함수
TO_DATE: 문자형을 날짜형으로 변환하는 함수
TO_NUMBER: 문자형을 숫자형으로 변환하는 함수

*/

-- 날짜 함수 사용하기
-- TO_CHAR(date, 'yymmdd') : 예제와 같이 자유롭게 설정 가능함
select ename 성명, hiredate 입사일, to_char(hiredate, 'yyyymmdd') 입사일2 from employee;
select ename 성명, hiredate 입사일, to_char(hiredate, 'yymmdd') 입사일2 from employee;
select ename 성명, hiredate 입사일, to_char(hiredate, 'yydd') 입사일2 from employee;
select ename 성명, hiredate 입사일, to_char(hiredate, 'yd') 입사일2 from employee;

--날짜도 입력 가능함
select ename 성명, to_char(hiredate, 'DaY') 입사요일 from employee;
select ename 성명, to_char(hiredate, 'DY') 입사요일 from employee; --'DY'는 요일의 약어

-- 현재 시스템의 오늘 날짜를 출력하고 시간 초까지 출력함.
select sysdate 오늘, to_char(sysdate, 'dy') 요일, to_char(sysdate,'yymmdd hh:mi:ss') from dual;

desc employee;

select hiredate
from employee;

SELECT ename, hiredate, to_char(hiredate, 'yyyy-mm_dd hh:mi:ss') from employee;

/* TO_CHAR에서 숫자와 관련된 형식

0: 자릿수를 나타내며 자릿수가 맞지 않을 경우 0으로 채웁니다.
9: 자릿수를 나타내며 자릿수가 맞지 않을 경우에는 채우지 않습니다,
L: 각 지역별 통화 기호를 출력
. : 소수점으로 표현
, : K 단위의 구분자

*/

-- to_char(컬럼명, 'L+자릿수): 컬럼의 숫자를 출력하되, L(각국 통화기호 출력)과 함께
--                           숫자가 차있는 만큼, 6자리를 출력하고, 만약 자릿수를
--                           초과하는 경우에는 채우지 않는 옵션을 선택함.
SELECT ename 성명, salary 월급, to_char(salary, 'L999,999') from employee;
SELECT ename 성명, salary 월급, to_char(salary, 'L000,000') from employee;

-- 허용한 자릿수를 초과하면 모든 칸이 ###으로 도배되어서 출력됨. 이건 0과 9가 동일함.
SELECT ename 성명, salary 월급, to_char(salary, 'L999') from employee;
SELECT ename 성명, salary 월급, to_char(salary, 'L000') from employee;

-- to_date('char', 'fornat'): 날짜 형식으로 전환
SELECT SYSDATE, trunc((SYSDATE - to_date('20000101', 'yyyymmdd'))/365) as "년수(만)" FROM dual;

select sysdate 시작일,to_date('201010') 종료일, trunc((sysdate - to_date('201010'))/30) 소요개월 from dual;

select hiredate from employee;

select ename 성명, hiredate 입사일 from employee
where hiredate = '81/02/22';

select  ename,  hiredate 
from employee
where hiredate = to_date ('1981-02-22', 'yyyy-mm-dd') ;

-- 2000년 12월 25일부터 지금까지 총 몇달이 지났는지

select trunc((sysdate - to_date('2000-12-25'))/30) 경과개월수 from dual;

-- to_number: number 데이터 타입으로 변환
select '100,000' - '50,000' from dual;

select to_number('100,000', '999,999') - to_number ('50,000', '999,999') as 거스름돈 from dual;


-- NVL 함수: null을 다른 값으로 치환해주는 함수
select ename, commission from employee;

select ename 성명, nvl(commission, 0)보너스 from employee;

select ename 성명, nvl(manager, 1111) "직속상사 사번" from employee;

--NVL 함수2

--nvl2 (Expr1, expr2, expr3): expr1 != null => expr2 출력
--                            expr1 == null => expr3 출력

select salary, commision from employee;

--nvl 함수로 연봉 계산하기

select ename 성명, salary "       월급        ",nvl(commission,0) "       보너스        " , (salary*12 + nvl(commission,0)) 
"       연봉       " from employee;

--nvl2 함수로 연봉 계산하기
select ename 성명, salary "       월급        ",nvl(commission,0) "       보너스        " ,
nvl2(commission,(salary*12)+commission, salary*12)"       연봉       " 
from employee;

-- nullif : 두 표현식을 배교해서 동일한 경우, null을 반환하고 동일하지 않을 경우에만 
--          첫번째 표현식을 반환함.

select nullif('A','A'), nullif('A','B') from dual; -- 앞 nullif는 null, 뒷 nullif는 앞의 값을 내줌

-- nullif와 nvl2의 혼합 사용 -> 일치 판독기
select nvl2(nullif('A','A'),'불일치','일치' ), nullif('A','B') from dual;


/* coalesce 함수

coalesce (expr1,expr2,expr3,....expr(n));
좌측부터 순차적으로 체크해서 null값이면 우측으로 옮겨가면서 가장 먼저 나오는 null이외의 값을 출력해줌.

*/

select coalesce ('abc','bcd','def','efg','fgh') from dual;
select coalesce (null,null,'def','efg','fgh') from dual;
select coalesce (null,null,null,'efg',null) from dual;

--coalesce함수를 활용한 연봉 계산
SELECT ename, salary 월급, nvl(commission,0) 보너스, coalesce(commission + salary*12, salary*12, 0) 연봉 from employee;

/* decode 함수

DECODE (표현식, 조건1, 결과1,
               조건2, 결과2,
               조건3, 결과3,
               기본결과n
        )

*/

select ename 성명, dno 부서번호, decode(dno, 10, 'Accounting',
                                           20, 'Research',
                                           30, 'Sales',
                                           40, 'Operation',
                                           'Default') as 부서명
from employee;

--dno 칼럼이 10번 부서 + 300 / 20번 부서 +500 / 30번 부서 + 500/
                          
select ename 성명, dno 부서번호,salary "인상 전 월급", decode(dno, 10, 300,
                                                               20, 500,
                                                               30, 700,
                                                               'Default') "인상액",

                                                   decode(dno, 10, salary + 300,
                                                               20, salary + 500,
                                                               30, salary + 700,
                                                               'Default') "인상 후 월급"
from employee;             


-- case: 
~ else if, else if ~~
/*

case 표현식 when 조건1 then 결과1
           when 조건2 then 결과2
           when 조건3 then 결과3
           else 결과n
           end
*/

select ename 성명, dno 부서번호, case when dno = 10 then 'Accounting'
                                    when dno = 20 then 'Research'
                                    when dno = 30 then 'Sales'
                                    when dno = 40 then 'Operation'
                                    else 'Default'
                                    end as 부서명

from employee
order by dno;