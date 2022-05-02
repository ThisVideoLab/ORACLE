create table test10Tbl(
a number not null,
b varchar(50) null
);

-- when user_test10 accuont access Employee table which is owned by HR account, it needs object access authority. 

select * from employee; -- fail to print. when access the other account's object, u should write the owner
select * from HR.employee; -- write with owner 'HR', but fail to print cuz of authority

grant select on hr.employee to user_test10; -- authority asign, it should be done by SYS account.

select * from HR.employee; --now we can access to other account's table

select * from test10tbl; -- when call out account's own object, the owner name can be omitted.

-- grant code:
-- grant (Privilege name) on (target object name) to (user name)
-- ex) grant select on hr.employee to user_test10;

-- insert authority on other user's table
    --1) making other account's table copy for practice :
    create table emp_copy55
    as
    select * from employee; -- it must be done by HR account.
    
    --2)grant select authority
    grant select on hr.emp_copy55 to user_test10; -- it must be done by SYS account.
    select * from hr.emp_copy55; -- success
    
    --2)grant insert authority
    grant insert on hr.emp_copy55 to user_test10; -- it must be done by SYS account.
    insert into hr.emp_copy55 (eno)
    values (3333);
    select * from hr.emp_copy55; -- success
    
    --3) grant multiple authority
    grant select, insert, delete, update on hr.emp_copy55 to user_test10; -- it must be done by SYS account.
    
    --4) deprive authority
    revoke select, insert, delete, update on hr.emp_copy55 from user_test10; -- it must be done by SYS account.
    
-- with grant option: the authority can grant an authority to specific account 
--                    and simultaneously grant it to another user.

    grant select on hr.employee to user_test10 with grant option; -- it must be done by SYS account.
    -- user_test10 account can grant select authority to other user regarding hr.employee table.
    
    create table dept_copy55
    as
    select * from department; -- it must be done by HR account.
    
    grant select on hr.dept_copy55 to user_test10 with grant option; -- it must be done by SYS account.
    
    grant select on hr.dept_copy55 to usertest01; -- successfully granted

-- PUBLIC: 모든 사용자에게 권한을 부여하는 것
    
    -- 1) crate table copy for practice
    create table dept_copy56
    as
    select * from department; -- it must be done by HR account.
    
    select * from hr.dept_copy56; -- fail to load -> no authority to load
    
    grant select, insert, delete, update on hr.dept_copy56 to public; -- it must be done by SYS account.
    
    select * from hr.dept_copy56; -- It can be loaded by every user now.
    
select * from user_role_privs;

select * from hr.dept_copy57;


