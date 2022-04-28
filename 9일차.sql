-- 9일차 시퀀스 , 인덱스,

/*
    시퀀스 : 자동 번호 발생기
        -- 번호가 자동 발생이 되면 뒤로 되돌릴 수 없다. (삭제 후 다시 생성해야 한다.)
*/

-- 초기값 : 10 , 증가값 : 10
create sequence sample_seq
    increment by 10         -- 증가값
    start with 10;          -- 초기값
    
-- 시퀀스의 정보를 출력하는 데이터 사전
select * from user_sequences;

select sample_seq.nextval from dual;    -- 시퀀스의 다음 값을 출력
select sample_seq.currval from dual;    -- 현재 시퀀스의 값을 출력

-- 초기값 : 2 , 증가값 : 2
create sequence sample_seq2
    increment by 2
    start with 2
    nocache;                 -- 캐쉬를 사용하지 않겠다. (RAM)  -- 서버의 부하를 줄여줄수 있다.
    
select sample_seq2.nextval from dual;
select sample_seq2.currval from dual;

-- 시퀀스를 Primary Key에 적용하기

create table dept_copy80
as
select * from department
where 0 = 1;

select * from dept_copy80;

-- 시퀀스 생성 : 초기값 10, 증가값 : 10
create sequence dept_seq
    increment by 10
    start with 10
    nocache;
    
    /* Sequence에 cache를 사용하는 경우 / 사용하지 않는 경우 */
        -- chche : 서버의 성능을 향상 하기 위해서 사용 (기본값 : 20개)
        -- 서버가 다운된 경우 :  캐쉬된 넘버링이 모두 날라간다. 새로운 값을 할당 받는다.
        
    
insert into dept_copy80 (dno, dname, loc)
values (dept_seq.nextval , 'HR' , 'SEOUL');

select * from dept_copy80;

create sequence emp_seq_no;
    --increment by 1 -- 이렇게 초기값과 증가값을 적지 않아도 기본이 1부터 시작에
    --start with 1; -- 증가값이 1인 상태로 올라간다

create table emp_copy80
as
select * from employee
where 0 = 1;

select * from emp_copy80;

--시퀀스를 테이블의 특정 컬럼에 적용해보자

insert into emp_copy80 -- 시퀀스를 통한 인덱스 번호 삽입
values (emp_seq_no.nextval,  'SMITH', 'SALESMAN', 2222, sysdate, 3000, 300, 20);

-- 기존의 시퀀스를 수정해보자

select * from user_sequences; -- emp_seq_no의 max_value : 무한대

alter sequence emp_seq_no
    maxvalue 1000; -- 시퀀스 증가값의 최대값을 1000으로 설정
    
select * from user_sequences; -- 다시 입력해보면 1000으로 되어 있음.


alter sequence emp_seq_no
    cycle; -- 시퀀스값이 최대값에 도달한 후에 다시 초기값부터 시작함
    
alter sequence emp_seq_no
    nocycle; -- 사이클을 적용하지 않음.

drop sequence sample_seq;

/* INDEX

    -- 인덱스는 테이블의 컬럼에 생성, 특정 컬럼의 검색을 빠르게 사용할 수 있도록 한다.
    -- index page: 컬럼의 중요 키워드를 걸러서 위치 정보를 담아놓은 페이지, db 공간의 10% 가량
    -- 색인 (INDEX): 책의 색인, 책의 내용을 주요 키워드별로 정리해서 보여줌.
    -- 테이블 스캔: 레코드의 처음 ~ 마지막까지 검색 (검색 속도가 느림), 인덱스를 사용하지 않고 검색함
        - Index가  생성되어 있지 않은 컬럼은 테이블 스캔을 실시함.
    -- primary key, Unique key가 적용된 컬럼은 Index page  가 생성되어 검색을 빠르게 한다.
    -- where절에서 자주 검색을하는 컬럼에 index를 생성.
    -- 고로 테이블의 검색을 자주하는 컬럼에 대해 INDEX를 생성해줌. 다만 잘못 설정하면 더 느려짐
    
*/
    
-- index 정보가 저장되어 있는 데이터 사전
    -- user_columns, user_ind_columns
    
    select * from user_columns;
    select * from user_ind_columns; -- user index columns 의 줄임표현
    
    select * from user_tab_columns
    where table_name in ('EMPLOYEE', 'DEPARTMENT');
    
    select index_name, table_name, column _name
    from user_ind_columns
    where table_name in ('EMPLOYEE', 'DEPARTMENT');
    
    select * from employee;

-- INDEX 자동 생성 (Primary key, Uniquie) 컬럼에는 index page가 자동으로 생성됨.

create table tbl1(
a number (4) constraint PK_tbl1_a Primary Key,
b number (4),
c number (4)
)


select index_name, table_name, column_name
from user_ind_columns
where table_name in ('TBL1','TBL2','EMPLOYEE','DEPARTMENT');

select * from tbl1;

create table tbl2(
a number (4) constraint PK_tbl2_a Primary Key,
b number (4) constraint UK_tb12_b Unique, 
c number (4) constraint UK_tbl2_c Unique,
d number (4),
e number (4)
)

create table emp_copy90 -- 새로운 테이블 emp_copy90 생성
as
select * from employee;

select * from emp_copy90; -- emp_copy90 테이블 확인, 이상 없음

select index_name, table_name, column_name -- emp_copy90의 인덱스가 없음을 확인
from user_ind_columns
where table_name in ('EMP_COPY90');

select * from emp_copy90 -- emp_copy90의 ename 컬럼에는 인덱스가 없으므로 테이블 스캔을
where ename = 'KING'; -- 실시해서 위부터 차례대로 KING를 검색함.
                      -- 작업시간 0.001초 소요. 상대적으로 적은 부하가 발생함.

create index id_emp_copy90_ename -- 작업시간 0.018초 소요.
on emp_copy90 (ename);           -- 위의 0.001초에 비하면 상당한 양의 부하가 발생함.

/*
    다만 테이블 검색은 실행시마다 일정량 부하를 발생시키기 때문에, 앞서 말한바와 같이 자주
    검색하는 컬럼에 한해서 인덱스를 걸어서 부하량을 컨트롤 할 수 있음.
    이런 인덱스 생성시에 주의점은, 반드시 서버 사용량이 적은 시간대에 실행해야 한다는 것임.
    그래야 서버에 발생하는 많은 부하를 효율적으로 관리할 수 있음.
*/

select * from emp_copy90 
where ename = 'KING'; -- 이 내용을 드래그 한 후에 F10 또는 상단 실행 버튼 우측  번째에
-- 있는 계획 설명 버튼을 눌러보면, 해당 테이블에서 kING이라는 컬럼을 찾는데 어떤 방식을
-- 사용할 것인지에 대한 정보가 나옴. 현재는 추가한 INDEX를 통해 찾는다고 나옴.

select * from emp_copy90  -- 반대로 인덱스를 추가하지 않은 이 문장을 드래그해서 계획 설명을
where job ='SALESMAN';  -- 보면 테이블 접근을 통해서 조건 컬럼을 검색한다는 계획이 출력됨

-- 이제 반복해서 KING을 검색하기 위해 인덱스를 지워보자
drop index id_emp_copy90_ename; -- 이 때 반드시 생성할 때 지정한 인덱스 명으로 지워야 함

select * from emp_copy90 -- 위의 세일즈맨과 마찬가지로 테이블 접근을 통한 검색 계획이 나옴
where ename = 'KING';

create index id_emp_copy90_ename -- 작업시간 0.004초 소요.
on emp_copy90 (ename);           -- 아마 한번 불러온 짬바로 시간이 단축된듯하다.

/* 
index는 주기적으로 REBUILD 해줘야 한다.
이유인즉슨, INDEX는 DML(insert, update, delete)가 빈번하면 조각나기 때문이다.
보통 수일마다 길게는 수주 단위마다 리빌딩이 필요하다.
*/

-- 리빌딩해야 할 테이블을 찾는 코드 (선생님이 예시로 알려주심)
SELECT I.TABLESPACE_NAME,I.TABLE_NAME,I.INDEX_NAME, I.BLEVEL,
       DECODE(SIGN(NVL(I.BLEVEL,99)-3),1,DECODE(NVL(I.BLEVEL,99),99,'?','Rebuild'),'Check') CNF
FROM   USER_INDEXES I
WHERE   I.BLEVEL > 4
ORDER BY I.BLEVEL DESC;

-- index rebuild

alter index id_emp_ename rebuild; -- index를 새롭게 생성
select * from emp_copy90;

/* 

    <<index를 사용해야 하는 경우>>
    
    1. 테이블의 행(로우, 레코드)가 많을 경우, 보통 만단위 이상
    2. where 절에서 자주 사용되는 컬럼.
    3. Join 시 사용되는 키 컬럼. 
    4. 검색 결과가 원본 테이블 데이터의 2%~ 4% 정도에 육박할 정도로 많은 경우
    5. 해당 컬럼에 null이 포함되는 경우 (index에서는 null을 제외함)
    
    <<index를 쓰지 말아야 하는 경우>>
    
    1. 테이블의 행의 갯수가 적은 경우
    2. 검색 결과가 원본 테이블의 많은 비중을 차지하는 경우
    3. insert, delete, update가 빈번한 컬럼은 어차피 조각나서 무쓸모
*/

/*
    index의 종류
    1. 고유 인덱스 (Unique index): 컬럼의 중복되지 않는 고유한 값을 갖는 Index
                                (Primary key, Uniqe)
    2. 단일 인덱스 (Single Index): 한 컬럼에 부여되는 Index
    3. 결합 인덱스 (composite Index): 여러 컬럼을 묶어서 생성한 index
    4. 함수 인덱스 (Function Index): 함수를 적용한 컬럼에 생성한 인덱스

*/

-- 단일 index 생성
create index inx_emp_copy90_salary
on emp_copy90 (salary);

-- 결합 인덱스 생성: 두 컬럼 이상을 결합해서 인덱스를 생성함.

create table dept_copy91  -- 결합 인덱스용 테이블 생성
as
select * from department;

create index inx_dept_copy91_dname_loc
on dept_copy91 (dname,loc);

select * from user_ind_columns
where table_name in 'DEPT_COPY91';

-- 함수 기반 인덱스 : 함수를 적용한 컬럼에 부여되는 index

create table emp_copy91
as
select * from employee;

create index inx_empcopy91_allsal
on emp_copy91 (salary*12);


-- 함수 삭제
drop index inx_empcopy91_allsal;

/* 권한 관리

    사용권한: DBMS는 여러명이 사용하다보니 사용이 겹치기도 함
    -- 각 사용자별로  계정을 생성: DMBS 에 접속할 수 있는 사용자를 생성함
        (인증 (Authentication): Credential( Idnetity+ Password ) 확인)
        (허가 (Autheriztion): 인증된 사용자에게 Oracle의 시스템 권한, 객체 (테이블 뷰 트리거 함수) 권한
            -system privileges: 오라클의 전반적인 권한 할당
            - Object privileges:  테이블, 뷰, 트리거, 함수, 저장프로시저, 시퀀스, 인덱스( 접근 권한,

*/

-- Oracle에서 계정 생성하기

    --1. Run sql command line 실행 (일반 계정에서는 계정을 생성할 수 있는 권한이 없음)
    create user usertest01 identified by 1234;


