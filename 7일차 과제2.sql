-------------------------------------------------------------------------------
1. 테이블정의서 - shopping 파일을 내려받아, 해당 양식에 맞는 테이블들을 만드시오.
-------------------------------------------------------------------------------

create table member(
    id varchar2(20) not null constraint PK_member_id Primary Key,
    pwd varchar2(20)not null,
    name varchar2(50)not null,
    zipcode varchar2(7)not null,
    address varchar2(20)not null,
    tell varchar2(13)not null,
    indate date default sysdate,
    constraint FK_member_id_tb_zipcode foreign key (zipcode) references tb_zipcode(zipcode)
    )

create table tb_zipcode(
    zipcode varchar2(7) not null constraint PK_tb_zipcode_zipcode Primary Key,
    sido varchar2(30),
    gugum varchar2(30),
    dong varchar2(30),
    bungi varchar2(30)
    )
    
create table products(
    product_code varchar(20) not null constraint PK_products_product_code Primary Key,
    product_name varchar2(100),
    product_kind char(1),
    product_price1 varchar2(10),
    product_price2 varchar2(10),
    product_content varchar2(100),
    product_image varchar2(50),
    sizeSt varchar2(5),
    sizeEt varchar2(5),
    product_qyantity varchar2(5),
    useyn char(1),
    indate date
    )
    
create table orders(
    o_seq number(10) not null constraint PK_oders_o_seq Primary Key,
    product_code varchar2(20),
    id varchar2(16),
    product_size varchar2(5),
    quantity varchar2(5),
    result char(1),
    indate date,
    constraint FK_orders_product foreign key (product_code) references products(product_code),
    -- 길다고 에러나서 줄였습니다. FK_orders_product_code_products => FK_orders_product
    constraint FK_orders_id_member foreign key (id) references member(id)
    )
    
----- 값입력

insert into tb_zipcode
values('404-830','인천시','서구','신석동','일번지')
insert into member
values ('0001', 'pswd', '김덕배', '404-830', '서구 신석로', '010-0000-0000', default)
insert into products
values ('0001','모코코방석','T','1000','10000','인기게임 케릭터 머천다이즈','준비중','12','15','1','N',to_date(220425))
insert into orders
values (1000000001, '0001', '0001', '12x15', '1', 'N', SYSDATE)
commit;

select * from member;
select * from tb_zipcode;
select * from products;
select * from orders;

insert into tb_zipcode
values('404-831','서구시','인천구','석신동','이번지')
insert into member
values ('0004', 'bmbh', '곽춘덕', '404-831', '서구 구석로', '010-0000-0000', default)
insert into products
values ('0003','모코코머그컵','C','1100','11000','인기게임 케릭터 머천다이즈','준비중','11','14','2','N',to_date(220425))
insert into orders
values (1000000002, '0003', '0004', '12x15', '1', 'N', SYSDATE)
commit;

insert into tb_zipcode
values('404-832','서구시','인천구','석신동','이번지')
insert into member
values ('0006', 'bmbh', '박동팔', '404-832', '서구 구석로', '010-0000-0000', default)
insert into products
values ('0005','모코코마우스','M','1100','11000','인기게임 케릭터 머천다이즈','준비중','11','14','2','N',to_date(220425))
insert into orders
values (1000000003, '0005', '0006', '12x15', '1', 'N', SYSDATE)
commit;

select * from member;
select * from tb_zipcode;
select * from products;
select * from orders;

------------------------------------------------------------------------------------------------
2. zip.sql을 내려받은 후 데이터를 원활히 받을 수 있도록 기존 tb_zipcode  테이블을 수정하시오
------------------------------------------------------------------------------------------------

/* desc tb_zipcode;

ZIPCODE NOT NULL VARCHAR2(7)  
SIDO             VARCHAR2(30) 
GUGUM            VARCHAR2(30) 
DONG             VARCHAR2(30) 
BUNGI            VARCHAR2(30)

1. ZIP_SEQ 컬럼 추가하기
2. BUNGI -> BUNJI 로 고치기
3. 전체 자리수 3자리 이상으로 고치기
4. gugum -> gugun
*/ 

-- 1. ZIP_SEQ 컬럼 추가하기
Alter Table tb_zipcode add(ZIP_SEQ number(5));

-- 2. 오타가 발생한 컬럼 명 고치기
Alter Table tb_zipcode
rename column BUNGI TO BUNJI;

Alter Table tb_zipcode
rename column gugum TO gugun;

--3. 부족한 자리수 늘려주기
Alter Table tb_zipcode
modify ZIPCODE varchar2 (100);

Alter Table tb_zipcode
modify DONG varchar2 (100);

--4. unique constraint (HR.PK_TB_ZIPCODE_ZIPCODE) violated 해소하기

alter table member drop constraint FK_member_id_tb_zipcode; -- member 테이블의 FOREIGN KEY 해제
alter table tb_zipcode drop PRIMARY KEY; -- tb_zipcode 테이블의 PRIMARY KEY 해제


5. ZIP.SQL 자체의 오류 1

--------------------------------------------------------------------------------------------
명령의 143,348 행에서 시작하는 중 오류 발생 -
INSERT INTO tb_zipcode ( ZIPCODE, SIDO, GUGUN, DONG, BUNJI,
ZIP_SEQ ) VALUES ( INSERT INTO tb_zipcode ( ZIPCODE, SIDO, GUGUN, DONG, BUNJI,
ZIP_SEQ ) VALUES ( 
'135-512', '서울', '강남구', '역삼2동 진달래아파트', '(10∼17동)', '446')
오류 발생 명령행: 143,349 열: 20
오류 보고 -
SQL 오류: ORA-00936: missing expression
00936. 00000 -  "missing expression"
*Cause:    
*Action:

--------------------------------------------------------------------------------------------
143350 행에 이중으로 입력된 다음과 같은 구문 삭제
INSERT INTO tb_zipcode ( ZIPCODE, SIDO, GUGUN, DONG, BUNJI,
ZIP_SEQ ) VALUES 
--------------------------------------------------------------------------------------------

ZIP.SQL 자체의 오류 2


--------------------------------------------------------------------------------------------
명령의 286,723 행에서 시작하는 중 오류 발생 -
'363-822', '충북', '청원군', '현도면 시목리', NULL, '47697')
오류 보고 -
알 수 없는 명령
--------------------------------------------------------------------------------------------
286722행에 다음과 같은 코드 삽입

INSERT INTO tb_zipcode ( ZIPCODE, SIDO, GUGUN, DONG, BUNJI,
ZIP_SEQ ) VALUES ( 

