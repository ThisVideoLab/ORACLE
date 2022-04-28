-- 최고 관리자 계정 (sys) : 계정을 생성할 수 있는 권한을 지님

-- 아이디 : usertest 01 , 암호 : 1234
create user usertest01 identified by 1234;

-- 계정과 암호를 생성했다고 해서 오라클에 접속할 수 있는 것이 아님
-- 접속할 수 있는 권한을 부여받아야 비로소 접속이 가능함,.

-- System Privileages
    -- Create Session: 오라클에 접속할 수 있는 권한
    -- Create table: 오라클에서 테이블을 생성할 수 있는 권한
    -- Create sequence: 시퀀스를 생성할 수 있는 권한
    -- Create view: 뷰를 생성할 수 있는 권한
    
/* 생성한 계정에게 오라클에 접속할 수 있는 Create Session 권한을 부여함

DDL: 객체 생성(Create, Alter, Drop)
DML: 레코드 조작( Insert, Update, Delete)
DQL: 레코드 검색 (Select)
DTL: 트랜잭션 (Begin transaction, rollback, commit)
DCL: 권한관리 (Grant, Revoke, Deny)

*/
grant create session to usertest01; -- 오라클 접속 승인    
grant create table to usertest01; -- 테이블 생성 승인
-- 이상태에서 crate table 을 사용해서 테이블 생성을 시도하면 권한 없음이 출력됨.

/* 테이블 스페이스 (table space)

    객체 (테이블, 뷰, 시퀀스, 인덱스, 트리거, 저장 프로시저, 함수 등등)를 저장하는 공간을
    테이블 스페이스라고 칭함. 관리자 계정에서 각 사용자별 테이블 스페이스를 확인함.

*/

select * from dba_users; -- db에 등록된 user들의 목록을 출력함.
-- 이렇게 출력되는 목록 중에서 default_tablespace와 temporary_tablespace를 봐야함.
-- default_tablespace는 일반 유저는 접근할 수 없고, 최고 관리자만 접근 가능한 공간임.
-- 유저는 오로지 temporary_tablespace 에만 접근이 가능함.

select username, default_tablespace as dataFile, temporary_tablespace as logFile
from dba_users
where username in ('HR','USERTEST01');

/*
USERNAME   |DATEFILE | LOGFILE
---------------------------------
USERTEST01 |SYSTEM	 | TEMP
HR	       | USERS	 | TEMP

이와 같은 모습으로 출력이 됨. 그러면 여기서 계정의 테이블 스페이스를 변경해줘야 함.
SYSTEM에 걸려있는 default_tablespace AS DATAFILE을 USERS로 바꿔줘야 비로소
테이블 생성이 가능해짐. 코드는 다음과 같음
*/

ALTER user usertest01
default tablespace users
temporary tablespace temp;
-- 이후 다시 SQL CMD에서 create table을 시도했으나 권한 부족이 출력됨

-- 계정에게 users 테이블 스페이스를 사용할 수 있는 권한 할당.

alter user usertest01
quota 2m on users;

=============================
문제) usertest02 계정을 만든 뒤에 user 테이블 스페이스에서 테이블 tbl2 생성 후 insert 아무거나

create user usertest02 identified by 1234; -- 계정 생성
grant create session to usertest02; -- 오라클 접속 승인    
grant create table to usertest02; -- 테이블 생성 승인
-- 선생님은 grant create session, create table to usertest02;
ALTER user usertest02
default tablespace users
temporary tablespace temp;  -- usertest02에게 default tablespace 대신 temporary tablespace 사용권한 할당.
alter user usertest02 
quota 2m on users; --  usertest02에게 default tablespace 내에서 2mb 규모의 객체 생성 권한 할당
--------------------------------------

select * from all_tables; -- 테이블의 소유주를 출력하는 코드
select * from all_tables
where owner in ('HR','USERTEST01','USERTEST02');
