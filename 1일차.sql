
-- 한줄주석 /* 여러줄 주석 */

create database myDB;

use myDB; -- 반드시 해당 DB에 use를 사용해서 접속해서 작업해야 함

Create Table abc(
a int not null,
b char(10) null,
c varchar(50) null
);
select * from abc;
insert into abc values(1, '홍길동', 'aaa@aaa.com');

use world;

select * from city;

use sys;

use sakila;