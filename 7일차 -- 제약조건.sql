-- 7일차 제약조건

-- 테이블 복사: 테이블의 전체를 복사함
--            테이블을 복사하면, 컬럼과 레코드만 복사가 됨
--            테이블의 할당된 제약조건은 복사되지 아니함
--            (alter table을 사용해 따로 할당해 주어야 함)

-- 제약조건: 컬럼에 할당되어서 입력받는 데이터값을 제한해 무결성을 체크함
--          NOT NULL, Primary Key, Unique, Foreign key, Check 등등

Create table dept_copy
as
select * from dept;

select * from dept_copy;

Create table emp_copy
as
select * from employee;

-- 테이블 복사 : 특정 컬럼만 복사하기

create table emp_second
as
select eno, ename, salary, dno from employee;

select * from emp_second;

-- 테이블 복사 :조건을 사용해서 복사하기
create table emp_third
as
select eno, ename, salary
from employee
where salary > 3000;

select * from emp_third;

-- 테이블 복사 :컬럼명을 바꿔서 복사하기
create table emp_fourth
as
select * from emp_fourth;


select 사원번호, 사원명, 월급 from emp_fourth; -- 가져올때 컬럼명을 한글로 바꿧다면
    -- 앞으로 쭉 한글명 컬럼 이름을 가지게 됨. 그래서 반드시 이 별칭만을 사용해야 함

create table emp_fifth
as
select eno 사원번호, ename 사원명, salary 월급
from employee

select * from emp_fifth;

--테이블만 복사: 레코드는 그대로 두고 틀만을 복사하는 방법

create table emp_sixth
as
select * from employee
where 0=1  -- where whrjs : false를 리턴

select * from emp_sixth;

--테이블 수정 : Alter Table

create table dept20
as
select * from department;

desc dept20;


--기존의 테이블에 컬럼을 추가함, 이 때 반드시 추가할 컬럼에 NULL을 허용해야 함
Alter Table dept20
add(birth date);

Alter Table dept20
add (email varchar2 (100));

Alter Table dept20
add (address varchar2 (200));

-- 컬럼의 자료형 수정

Alter Table dept20
modify dname varchar2 (100);

Alter Table dept20
modify dno number (4);

Alter Table dept20
modify address varchar2 (200);

-- 특정 컬럼 삭제: 컬럼 삭제는 서버에 다량의 부하를 발생시킴 ( 보통 업무시간 외에 작업함)
Alter Table dept20
drop COLUMN birth;

Alter Table dept20
drop COLUMN email;

-- 업무중일때 특정 컬럼을 제거하는 방법
-- set unused: 업무중이라면 특정 컬럼을 사용 중지시킴
-- drop unused column: 사용중지된 컬럼 일괄 삭제

Alter Table dept20
set unused (address);

Alter Table dept20
set unused (address); -- 사용 중지 상태로만 만들어둠, 목록에 있지만 존재하긴 함

Alter Table dept20
drop unused COLUMNS; -- 사용중지 컬럼만을 골라서 드랍함. 

-- 컬럼 이름 변경

Alter Table dept20
rename column LOC TO LOCATIONS;

Alter Table dept20
rename column DNO TO DEPART_NUMBER;

-- 테이블 이름 변경

Rename dept20 to dept30; 
Rename dept30 to dept20; -- 편의를 위해 되돌려 놓음

-- 테이블 삭제

drop table dept20;

/*
DDL: Create(생성), Alter(수정), Drop(삭제)
     객체를 생성, 수정, 삭제할때 사용하는 것이 DDL문
     객체: 테이블, 뷰, 인덱스, 트리거, 시퀀스, 함수. 저장 프로시저 등등

DML: Insert(레코드 추가), Update(레코드 수정), Delete (레코드 삭제)
    << 테이블의 값(레코드, 로우) >>

DQL: select 

테이블의 내용이나 테이블 자체를 삭제하는 경우
1. delete: 테이블의 레코드를 삭제, where을 사용하지 않을 시 모든 레코드를 삭제함. 테이블은 유지됨. <<일반포멧>>
2. truncate: 테이블의 레코드를 삭제, 굉장히 빠른 속도를 자랑함. 테이블은 유지됨. <<빠른포멧>>
3. drop: 테이블 전체 또는 지칭한 테이블 컬럼까지 함께 날려버림. <<디스크 빼버림>>
    
*/

create table emp10
as
select * from employee;

select * from emp10;
desc dept20;

--실습해보기
create table emp20
as
select * from employee;

create table emp30
as
select * from employee;

-- emp10: delete를 사용해서 삭제

delete emp10;
select * from emp10; -- 테이블은 남아있음
commit;

-- emp20: truncate를 사용해서 삭제
truncate table emp20;
select * from emp20; -- 테이블은 남아있음
commit;

-- emp30: drop을 사용해서 삭제

drop table emp30;
select * from emp30; -- 테이블은 남아있음
commit;

drop table emp_copy;


/* 

데이터 사전: 시스템의 각종 정보를 출력해주는 테이블
    user_: 자신의 계정에 속한 객체 정보를 출력
     all_: 자신의 계정이 소유한 객체나 권한을 부여 받은 객체 정보를 출력함
     dba_: 데이타 베이스 관리자만 접근 가능한 객체 정보를 출력함
     
*/
-- sys 전용 명령어

select * from dba_tables; 
select * from dba_views;
select * from dba_constraints;
select * from dba_sequences;

-- user 명령어

show user;

select * from all_tables; -- 부여받은 권한 내에서 가능한 모든 테이블을 출력함
select * from all_views;

select * from user_tables;  -- 사용자가 생성한 테이블 정보 출력
select table_name from user_tables; 
select * from user_views; -- 사용자가 생성한 뷰에 대한 정보
select * from user_indexes; -- 사용자가 생성한 인덱스 정보
select * from user_constraints; -- 제약 조건 확인
select * from user_sequences; --시퀀스 정보를 출력함

/* 
제약조건: 테이블의 무결성을 확보하기 위해 컬럼에 부여되는 규칙
        
        1. Primary Key
        2. NOT NULL
        3. Unique
        4. Foreign key
        5. Check
        6. Default

*/

-- 1. Primary Key : 중복된 값을 넣을 수 없음.  
--                  테이블 생성시 컬럼 단 하나에만 부여가 가능함
--                  제약조건 이름: 지정하지 않을 경우 Oracle에서 랜덤한 이름으로 지정함
--                               제약조건을 수정할 때 제약 조건 이름을 사용해서 수정함.
--                               고로 미리 만들어 주는 것이 좋음.
--                               PK_customer01_id: Primary Key, customer01, id
--                               NN_customer01_id: Not Null, customer01(테이블명), id(컬럼명)

create table customer01(
id varchar2(20) not null constraint PK_customer01_id Primary Key,
pwd varchar2(20) constraint NN_customer01_pwd not null,
name varchar2(20) constraint NN_customer01_name not null,
phone varchar2(30)null,
address varchar2(100)null
);

select * from user_constraints
where table_name = 'CUSTOMER01'; -- DB에서 찾을때는 반드시 대문자로 검색


create table customer02(
id varchar2(20) not null constraint PK_customer01_id Primary Key,
pwd varchar2(20) constraint NN_customer01_pwd not null,
name varchar2(20) constraint NN_customer01_name not null,
phone varchar2(30)null,
address varchar2(100)null
);

select * from user_contraints
where tabe_name = 'customer02'

--테이블의 컬럼 생성 후 제약조건 할당

create table customer03(
id varchar2(20) not null constraint PK_customer01_id Primary Key,
pwd varchar2(20) constraint NN_customer01_pwd not null,
name varchar2(20) constraint NN_customer01_name not null,
phone varchar2(30)null,
address varchar2(100)null,
constraints PK_customer01_id Primary key (id) -- 이와 같이 뒤에서 할당이 가능함
);

/*
foreign key (참조키): 다른 테이블(부모)의 Primary Key, Unique 컬럼을 참조해서 값을 할당함
check: 컬럼에 값을 할당할 때  check에 명시해놓은 조건에 부합하는 값만을 입력받음.
*/

-- 부모테이블

create table ParentTbl(
    name varchar2(20),
    age number(3) constraint CK_ParentTbl_age check (AGE > 0 AND AGE < 200),
    gender varchar(3) constraint CK_ParentTbl_gender check (gender IN ('M','W')), --check해서 in 안의 값만 입력받음
    infono number constraint PK_ParentTble_infono Primary Key
    );

desc parentTbl
select * from user_constraints
where table_name = 'PARENTTBL'

select * from ParentTbl;
insert into ParentTbl
values ('홍길동', 30 ,'M', 1)

insert into ParentTbl
values ('김똘똘', 50 ,'M', 2)

select * from ParentTbl;

-- 자식 테이블 

create table ChildTbl(
    id varchar2(40) constraint PK_ChildTbl_id Primary Key,
    pw varchar2(40),
    infono number,
    constraint FK_ChildTble_infono foreign key (infono) references ParentTbl(infono)
    );                                                  -- 참조구문 : 부모테이블 참조
    
insert into ChildTbl
values ('aaa','1234',1); -- foriegn key 위반 -> gender 들어갈 자리에                                                                                                         

insert into ChildTbl
values ('bbb','1234',2);

select * from ChildTbl;
commit;

-- 부모테이블

create table ParentTbl2(
    dno number(2) not null Primary key,
    dname varchar2(50),
    loc varchar2(50)
);

insert into ParentTbl2
values (10, 'SALES', 'SEOUL')

--자식 테이블

create table childTbl2(
    no number not null,
    ename varchar2(50),
    dno number(2) not null,
    foreign key (dno) references ParentTbl2 (dno)
);

insert into childTbl2
values (1, 'Park', 10)

select * from childTbl2;

desc parentTbl
select * from user_constraints
where table_name = 'PARENTTBL'



-- default 제약 조건 : 값을 할당하지 않으면 default 값이 할당도미.

Create Table emp_sample01(
    eno number(4) not null primary key,
    ename varchar(50),
    salary number (7,2) default 1000
    );

-- default 컬럼에 값을 할당한 경우
insert into emp_sample01
values (1111, '홍길동', 1500);

-- default 컬럼에 값을 할당하지 않은 경우
insert into emp_sample01 (eno, ename)
values (2222, '홍길soon'); -- 일부러 default가 걸린 컬럼을 생략하고 값 입력을 시도함

insert into emp_sample01
values (3333, '홍길later', default); -- 이렇게 직접 default를 명기할수도 있음

select * from emp_sample01; -- 새로입력된 행의 salary 컬럼에 default로 걸어놓은 1000이 입력됨


Create Table emp_sample02(
    eno number(4) not null primary key,
    ename varchar(50) default '기본이름',
    salary number (7,2) default 1000
    );

insert into emp_sample02 (eno)
values (10)

insert into emp_sample02
values (20, default, default)

select * from emp_sample02; 

/*

    Primary Key, Foreign Key, Unique, Check, Default, Not null

*/

create table member10(
    no number not null constraint PK_member10_no Primary Key,
    name varchar(50) constraint NN_member10_name Not null,
    birthday date default sysdate,
    age number(3) check (age > 0 and age <150),
    gender char(1) check ( gender in ('M','W')),
    dno number(2) unique 
    )
    
insert into member10
values (1, '홍길동', default, 30,'M', 10)

insert into member10
values (2, '김유신', default, 30,'M', 20)

select * from member10

create table orders10(
    no number not null primary key,
    p_no varchar(100) not null,
    p_name varchar(100) not null,
    price number check (price > 10),
    phone varchar(100) default '없음',
    dno number(2) not null,
    foreign key (dno) references member10(dno)
    )

insert into orders10
values (1, '태극기', '유관순', 1000 , default, 10)

select * from orders10;


-- 제약조건의 해제

-- 1. 제약조건명으로 삭제하기
alter table (테이블명) drop constraint (제약조건이름) 
-- 미리 지정해 둔 제약조건의 이름을 입력, 이러한 이유 때문에 제약조건명을 잘 파악해야함.

-- 2. 키 이름으로 삭제하기
alter table (테이블명) drop PRIMARY KEY;

-- 3. cascade constraints 사용해서 테이블과 함께 지우기
drop table (테이블명) cascade constraints; -- 이 방법은 사실 위와는 좀 다름. 테이블에 뭐가 걸려있던간에 그냥 한꺼번에 날리는 코드임.
                                          --  사실상 가장 많이 사용하는 방식이라고 하심

-- 4.제약 조건 비활성화 하기
alter table (테이블명) disable constraint (제약조건명); -- 보통 이렇게 치면 목표 테이블을 다른 테이블에서 참고중이라며 에러가 뜬다
                                                    -- 이때 다른 테이블을 걸리적거리는 테이블이라고 칭하겠음.
                                                    -- 일단 뭐가 걸리적거리는지 아래 코드를 입력해서 상황을 파악하자
                                                    
select constraint_name, table_name, status from user_constraints where table_name IN (('목표 테이블명'),('걸리적거리는 테이블명'));
-- 이대 괄호안에 들어간 이름은 반드시 대소문자를 구분해서 테이블의 명칭과 일치시켜줘야 한다.
-- 이렇게 찾으면 목표 테이블과 걸리적거리는 테이블 간에 키들이 어떤 방식으로 얽혀있는지 파악이 가능하다
                                                    
alter table (테이블명) disable constraint (제약조건명) cascade;  -- 이렇게 밀어버리면 목표테이블과 걸리적거리는 테이블에 걸려있던
                                                              -- 여러 키들을 한번에 다 풀어버릴 수 있음. 골라 풀기는 불가능함.
                                                              
select constraint_name, table_name, status from user_constraints where table_name IN (('목표 테이블명'),('걸리적거리는 테이블명'));
-- 다시 키 정보를 확인할 수 있는 코드를 입력해보면 모든 키들이 DIASABLED 된 것을 볼 수 있음.

-- 제약조건의 수정 (alter table): 기존 테이블의 제약 조건을 수정함

create table emp_copy50 as select * from employee;  -- 먼저 제약조건 수정을 실습할 테이블들을 복사해 옴
create table dept_copy50 as select * from department; -- 다만 이렇게 복사해도 제약조건은 복사할 수 없음.

select * from user_constraints
where table_name in ('EMPLOYEE','DEPARTMENT'); -- 원본 테이블간의 제약 조건 조회 - 3개의 제약 조건

select * from user_constraints
where table_name in ('EMP_COPY50','DEPT_COPY50'); -- 복제 테이블간의 제약 조건 조회 - 0개 - 제약조건은 복사되지 않음

select * from emp_copy50

alter table emp_copy50
add constraint PK_emp_copy50_eno Primary Key (eno); --  add constraint 제약조건명 Primary Key (해당 컬럼명);

alter table dept_copy50
add constraint PK_dept_copy50_dno Primary Key (dno);

alter table emp_copy50
add constraint FK_emp_copy50_dno_dept_copy50 Foreign Key (dno) references dept_copy50 (dno);

-- NOT NULL 제약 조건 추가
  -- 다른 제약조건들과 구문이 다름. add 대신 modify를 사용함.

desc employee;
desc emp_copy50; -- Not Null을 넣지 않았지만, Primary Key 제약 조건이 not null을 자동으로 할당함.
desc department;
desc dept_copy50; -- Not Null을 넣지 않았지만, Primary Key 제약 조건이 not null을 자동으로 할당함.

-- 당연한 이야기지만, 기존에 null 값이 있는 곳에는 적용할 수 없음

select ename from emp_copy50
where ename is null -- 먼저 해당 컬럼에 null 값이 있는지를 체크함

alter table emp_copy50
modify ename constraint NN_emp_copy50_ename not null; --modify (컬럼명) constraint (제약조건명) not null;

alter table emp_copy50
modify commission constraint NN_emp_copy50_commission not null;  -- cannot enable: null values found

update emp_copy50
set commission = 0
where commission is null; --  commission 컬럼의 null 값을 0으로 대체함

alter table emp_copy50
modify commission constraint NN_emp_copy50_commission not null;  -- null 값이 없어져서 성공적으로 저장됨

desc emp_copy50; -- commission 컬럼에 not null이 성공적으로 저장되었음을 알 수 있음.

-- Unique 제약 조건: 컬럼에 중복된 값이 있으면 할당할 수 없음

select ename, count(*)
from emp_copy50
group by ename
having count (*)>2; -- ename 컬럼이 중복된 값이 있는지 확인하는 코드 : 출력 결과 없음

alter table emp_copy50
add constraint UK_emp_copy50_enmae unique (ename);

-- check 제약 조건 추가: 대상 컬럼의 데이터들이 체크 제약 조건 안에 지정해둔 값과 일치해야 함

alter table emp_copy50
add constraint CK_emp_copy50_salary check ( salary > 0 and salary < 100000);

--default 제약 조건 추가
    -- 사실 default는 제약조건이 아님. 고로 제약조건명을 할당할 순 없음. 기본값의 개념임.
    -- 값을 넣지 않을 경우 default 값이 들어가게 됨.
    
alter table emp_copy50
modify salary default 1000;

insert into emp_copy50 (eno, ename, commission)
values (9999,'JULI',100);

alter table emp_copy50
modify hiredate default sysdate;

insert into emp_copy50
values (8888,'JULLIA',NULL, NULL, DEFAULT, DEFAULT, 1500, NULL);

-- 제약조건 제거 : alter table 테이블명 drop

alter table emp_copy50
drop primary key;

alter table dept_copy50 -- 이경우에는 안됨. this key is referenced by some foreign keys  출력됨
drop primary key cascade; -- 먼저 엮인 다른 키들을 제거한 후에 primary key를 제거함

select * from user_constraints
where table_name in ('EMP_COPY50','DEPT_COPY50');

--not null 컬럼 제거: - 제약 조건 이름으로 삭제하기

alter table emp_copy50
drop constraint NN_EMP_COPY50_ENAME;  

alter table emp_copy50
drop constraint UK_EMP_COPY50_ENMAE;  

alter table emp_copy50
drop constraint NN_EMP_COPY50_COMMISSION;  

--default는 null 허용 컬럼은 default null로 세팅: default 제약 조건을 제거하는 것.
  -- default는 제약조건이 아니기 때문에 이렇게 null로 만들어서 리셋시킴.

alter table emp_copy50
modify hiredate default null;

-- 제약조건 isable & enable
    -- 제약 조건을 잠시 중지시킴.
    -- 대량으로 데이터를 넣는 경우(bulk insert)에 부하가 많이 걸린다  disable => enable
    -- index를 생성시에 부하가 많이 걸린다 disable => enable

alter table dept_copy50
add constraint PK_dept_copy50_dno Primary Key (dno);

alter table emp_copy50
add constraint PK_emp_copy50_eno Primary Key (eno);

alter table emp_copy50
add constraint FK_emp_copy50_dno Foreign Key (dno) references dept_copy50(dno);

select * from user_constraints
where table_name in ('EMP_COPY50','DEPT_COPY50')

select * from emp_copy50;
select * from dept_copy50;

insert into emp_copy50 (eno, ename, dno)
values(8989, 'aaaa', 50); -- Foreign key 때문에 입력이 불가능함

alter table emp_copy50
disable constraint FK_emp_copy50_dno; -- Foreign key 잠시 중단

insert into emp_copy50 (eno, ename, dno)
values(8989, 'aaaa', 50); -- 다시 정상적으로 넣어줌

insert into dept_copy50
values(50, 'DINGDOO', 'INCHEON');  -- emp_copy50 테이블의 dno = 50에 대응하는 열을 dept_copy50 테이블에도 넣어줌



