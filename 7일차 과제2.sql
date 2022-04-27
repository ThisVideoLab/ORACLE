-------------------------------------------------------------------------------
1. ���̺����Ǽ� - shopping ������ �����޾�, �ش� ��Ŀ� �´� ���̺���� ����ÿ�.
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
    -- ��ٰ� �������� �ٿ����ϴ�. FK_orders_product_code_products => FK_orders_product
    constraint FK_orders_id_member foreign key (id) references member(id)
    )
    
----- ���Է�

insert into tb_zipcode
values('404-830','��õ��','����','�ż���','�Ϲ���')
insert into member
values ('0001', 'pswd', '�����', '404-830', '���� �ż���', '010-0000-0000', default)
insert into products
values ('0001','�����ڹ漮','T','1000','10000','�α���� �ɸ��� ��õ������','�غ���','12','15','1','N',to_date(220425))
insert into orders
values (1000000001, '0001', '0001', '12x15', '1', 'N', SYSDATE)
commit;

select * from member;
select * from tb_zipcode;
select * from products;
select * from orders;

insert into tb_zipcode
values('404-831','������','��õ��','���ŵ�','�̹���')
insert into member
values ('0004', 'bmbh', '�����', '404-831', '���� ������', '010-0000-0000', default)
insert into products
values ('0003','�����ڸӱ���','C','1100','11000','�α���� �ɸ��� ��õ������','�غ���','11','14','2','N',to_date(220425))
insert into orders
values (1000000002, '0003', '0004', '12x15', '1', 'N', SYSDATE)
commit;

insert into tb_zipcode
values('404-832','������','��õ��','���ŵ�','�̹���')
insert into member
values ('0006', 'bmbh', '�ڵ���', '404-832', '���� ������', '010-0000-0000', default)
insert into products
values ('0005','�����ڸ��콺','M','1100','11000','�α���� �ɸ��� ��õ������','�غ���','11','14','2','N',to_date(220425))
insert into orders
values (1000000003, '0005', '0006', '12x15', '1', 'N', SYSDATE)
commit;

select * from member;
select * from tb_zipcode;
select * from products;
select * from orders;

------------------------------------------------------------------------------------------------
2. zip.sql�� �������� �� �����͸� ��Ȱ�� ���� �� �ֵ��� ���� tb_zipcode  ���̺��� �����Ͻÿ�
------------------------------------------------------------------------------------------------

/* desc tb_zipcode;

ZIPCODE NOT NULL VARCHAR2(7)  
SIDO             VARCHAR2(30) 
GUGUM            VARCHAR2(30) 
DONG             VARCHAR2(30) 
BUNGI            VARCHAR2(30)

1. ZIP_SEQ �÷� �߰��ϱ�
2. BUNGI -> BUNJI �� ��ġ��
3. ��ü �ڸ��� 3�ڸ� �̻����� ��ġ��
4. gugum -> gugun
*/ 

-- 1. ZIP_SEQ �÷� �߰��ϱ�
Alter Table tb_zipcode add(ZIP_SEQ number(5));

-- 2. ��Ÿ�� �߻��� �÷� �� ��ġ��
Alter Table tb_zipcode
rename column BUNGI TO BUNJI;

Alter Table tb_zipcode
rename column gugum TO gugun;

--3. ������ �ڸ��� �÷��ֱ�
Alter Table tb_zipcode
modify ZIPCODE varchar2 (100);

Alter Table tb_zipcode
modify DONG varchar2 (100);

--4. unique constraint (HR.PK_TB_ZIPCODE_ZIPCODE) violated �ؼ��ϱ�

alter table member drop constraint FK_member_id_tb_zipcode; -- member ���̺��� FOREIGN KEY ����
alter table tb_zipcode drop PRIMARY KEY; -- tb_zipcode ���̺��� PRIMARY KEY ����


5. ZIP.SQL ��ü�� ���� 1

--------------------------------------------------------------------------------------------
����� 143,348 �࿡�� �����ϴ� �� ���� �߻� -
INSERT INTO tb_zipcode ( ZIPCODE, SIDO, GUGUN, DONG, BUNJI,
ZIP_SEQ ) VALUES ( INSERT INTO tb_zipcode ( ZIPCODE, SIDO, GUGUN, DONG, BUNJI,
ZIP_SEQ ) VALUES ( 
'135-512', '����', '������', '����2�� ���޷�����Ʈ', '(10��17��)', '446')
���� �߻� �����: 143,349 ��: 20
���� ���� -
SQL ����: ORA-00936: missing expression
00936. 00000 -  "missing expression"
*Cause:    
*Action:

--------------------------------------------------------------------------------------------
143350 �࿡ �������� �Էµ� ������ ���� ���� ����
INSERT INTO tb_zipcode ( ZIPCODE, SIDO, GUGUN, DONG, BUNJI,
ZIP_SEQ ) VALUES 
--------------------------------------------------------------------------------------------

ZIP.SQL ��ü�� ���� 2


--------------------------------------------------------------------------------------------
����� 286,723 �࿡�� �����ϴ� �� ���� �߻� -
'363-822', '���', 'û����', '������ �ø�', NULL, '47697')
���� ���� -
�� �� ���� ���
--------------------------------------------------------------------------------------------
286722�࿡ ������ ���� �ڵ� ����

INSERT INTO tb_zipcode ( ZIPCODE, SIDO, GUGUN, DONG, BUNJI,
ZIP_SEQ ) VALUES ( 

