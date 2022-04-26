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

