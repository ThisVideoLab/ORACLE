--1번 테이블 생성
create table sale(
    sale_date date default sysdate not null constraint PK_sale_sale_date Primary Key,
    wine_code varchar2(6) not null,
    men_id varchar2(30) not null,
    sale_amount varchar2(5) default 0 not null,
    sale_price varchar2(6) default 0 not null,
    sale_tot_price varchar2(15) default 0 not null,
    constraint FK_sale_wine_code foreign key (wine_code) references wine(wine_code),
    constraint FK_sale_men_id foreign key (men_id) references member(men_id)
    );

--2번 테이블 생성
create table member(
    men_id varchar2(6) not null constraint PK_member_men_id Primary Key,
    men_grade varchar2(20),
    men_pw varchar2(20) not null,
    men_birth date default sysdate,
    men_tel varchar2(20),
    men_pt varchar2(20) default 0 not null,
    constraint FK_member_men_grade foreign key (men_grade) references grade_pt_rade(men_grade)
    );

--3번 테이블 생성
create table grade_pt_rade(
    men_grade varchar2(20) not null constraint PK_grade_pt_rade_men_grade Primary Key,
    grade_pt_rade number(3,2)
    );

-- 4번 테이블 생성
create table today(
    today_code varchar2(6) not null constraint PK_today_today_code Primary Key,
    today_sens_value number(3),
    today_intell_value number(3),
    today_phy_value number(3)
    );

--  5번 테이블 생성
create table nation(
    nation_code varchar2(26) not null constraint PK_nation_nation_code Primary Key,
    nation_name varchar2(50) not null
    );

--6번 테이블 생성
create table wine(
    wine_code varchar2(26) not null constraint PK_wine_wine_code Primary Key,
    wine_name varchar2(100) not null,
    wine_url blob,
    nation_code varchar2(6),
    wine_type_code  varchar2(6),
    wine_sugar_code number(2),
    wine_price number(15) default 0 not null,
    wine_vintage date,
    theme_code varchar2(6),
    today_code varchar2(6),
    constraint FK_wine_wine_type_code foreign key (wine_type_code) references wine_type(wine_type_code),
    constraint FK_wine_nation_code foreign key (nation_code) references nation(nation_code),
    constraint FK_wine_theme_code foreign key (theme_code) references theme(theme_code),
    constraint FK_wine_today_code foreign key (today_code) references today(today_code)
    );
        
--  7번 테이블 생성
create table theme(
    theme_code varchar2(6) not null constraint PK_theme_theme_code Primary Key,
    theme_name varchar2(50) not null
    );

--8번 테이블 생성
create table stock_management(
    stock_code varchar2(6) not null constraint PK_stock_management_stock_code Primary Key,
    wine_code varchar2(6) not null,
    manager_id varchar2(30) not null,
    ware_date date default sysdate not null,
    stock_amount number(5)default 0 not null,
    constraint FK_stock_management_wine_code foreign key (wine_code) references wine(wine_code),
    constraint FK_stock_management_manager_id foreign key (manager_id) references manager(manager_id)
    );
    
--  9번 테이블 생성
create table manager(
    manager_id varchar2(30) not null constraint PK_manager_manager_id Primary Key,
    manager_pwd varchar2(20) not null,
    manager_tel varchar2(20)
    );

--  10번 테이블 생성
create table wine_type(
    wine_type_code varchar2(6) not null constraint PK_wine_type_wine_type_code Primary Key,
    wine_type_name varchar2(50)
    );

select count(*) from user_tables;
commit;