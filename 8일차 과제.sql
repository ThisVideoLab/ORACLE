--8일차 과제

10 : 테이터 무결성과 제약 조건

1. employee 테이블의 구조를 복사하여 emp_sample 란 이름의 테이블을 만드시오. 사원 테이블의 사원번호 컬럼에
    테이블 레벨로 primary key 제약조건을 지정하되 제약조건 이름은 my_emp_pk로 지정하시오. 

    -- 테이블 복사
    create table emp_sample 
    as
    select * from employee;

    -- 제약조건 추가
    alter table emp_sample 
    add constraint my_emp_pk Primary Key (eno);

    -- 제약조건 추가 내역 확인
    select * from user_constraints
    where table_name IN 'EMP_SAMPLE';


2. department 테이블의 구조를 복사하여 dept_sample 란 이름의 테이블을 만드시오. 
    부서 테이블의 부서번호 컬럼에 레벨로 primary key 제약 조건을 지정하되 제약 조건이름은 my_dept_pk로 지정하시오. 
    
    -- 테이블 복사
    create table dept_sample
    as
    select * from department;

    -- 제약조건 추가
    alter table dept_sample
    add constraint my_dept_pk Primary Key (dno);

    -- 제약조건 추가 내역 확인
    select * from user_constraints
    where table_name IN 'DEPT_SAMPLE';
    

3. 사원 테이블의 부서번호 컬럼에 존재하지 않는 부서의 사원이 배정되지 않도록 외래키
    제약조건을 지정하되 제약 조건이름은 my_emp_dept_fk 로 지정하시오. [주의 : 위 복사한 테이블을 사용하시오]
    
    -- 제약조건 추가
    alter table emp_sample 
    add constraint my_emp_dept_fk Foreign Key (dno) references dept_sample (dno);
    -- alter table (테이블명)
    -- add constraint (제약조건명) Foreign Key (해당 테이블 컬럼) references dept_sample (참조 테이블 컬럼);
    
    
    -- 제약조건 지정 내역 확인
    select * from user_constraints
    where table_name IN 'EMP_SAMPLE';
    
4. 사원테이블의 커밋션 컬럼에 0보다 큰 값만을 입력할 수 있도록 제약 조건을 지정하시오.
    [주의 : 위 복사한 테이블을 사용하시오]
    
    -- 제약조건 추가
    alter table emp_sample
    add constraint CK_emp_sample_salaryCondition check (salary > 0);
    
    -- 제약조건 추가 내역 확인
    select * from user_constraints
    where table_name IN 'EMP_SAMPLE';

5. 사원테이블의 웝급 컬럼에 기본 값으로 1000 을 입력할 수 있도록 제약 조건을 지정하시오.
    [주의 : 위 복사한 테이블을 사용하시오]
    
    -- 제약조건 추가
    alter table emp_sample
    modify salary default 1000;
    
    -- 제약조건 추가 내역 확인
    select * from user_constraints
    where table_name IN 'EMP_SAMPLE';
    

6. 사원테이블의 이름 컬럼에 중복되지 않도록  제약 조건을 지정하시오.
    [주의 : 위 복사한 테이블을 사용하시오]
    
    -- 제약조건 추가
    alter table emp_sample
    add constraint UK_emp_sample_enmae unique (ename);
    
    -- 제약조건 추가 내역 확인
    select * from user_constraints
    where table_name IN 'EMP_SAMPLE';

7. 사원테이블의 커밋션 컬럼에 null 을 입력할 수 없도록 제약 조건을 지정하시오.
    [주의 : 위 복사한 테이블을 사용하시오]
    
    -- not null 제약조건 추가를 위한 기존 테이블의 null 값 제거
    update emp_sample
    set commission = 0
    where commission is null;
    
    
    -- 제약조건 추가
    alter table emp_sample
    modify commission constraint NN_emp_sample_commission not null;

    -- 제약조건 추가 내역 확인
    select * from user_constraints
    where table_name IN 'EMP_SAMPLE';

8. 위의 생성된 모든 제약 조건을 제거 하시오. 

    -- EMP_SAMPLE 테이블의 제약조건 삭제
    alter table emp_sample drop primary key cascade; -- froeign 키 삭제 후 primary key 삭제
    alter table emp_sample drop constraint my_emp_dept_fk;
    alter table emp_sample drop constraint NN_emp_sample_commission;  
    alter table emp_sample drop constraint UK_emp_sample_enmae;
    alter table emp_sample drop constraint CK_emp_sample_salaryCondition;
    alter table emp_sample modify salary default null; -- 샐러리 제약조건 not null 상태를 null로 초기화
    
    -- DEPT_SAMPLE 제약조건 삭제
    alter table dept_sample drop primary key;
    
    commit;
        
    -- EMP_SAMPLE 테이블의 제약조건 삭제 내역 확인
    select * from user_constraints
    where table_name IN 'EMP_SAMPLE';
    
    -- DEPT_SAMPLE 제약조건 삭제 내역 확인
    select * from user_constraints
    where table_name IN 'DEPT_SAMPLE';
    


11 : 뷰

1. 20번 부서에 소속된 사원의 사원번호과 이름과 부서번호를 출력하는 select 문을 하나의 view 로 정의 하시오.
	뷰의 이름 : v_em_dno  
    
    -- 뷰용 테이블 복사 : 뒤 문제에서 테이블에 수정사항을 일으킬지 모르니 일단 복사하고 시작
    create table emp_temp
    as
    select * from employee;
    
    -- 뷰 생성
    create view v_em_dno
    as
    select eno 사원번호,  ename 사원명, dno 부서번호
    from emp_temp;
    
    -- 뷰 출력
    select * from v_em_dno;
    

2. 이미 생성된 뷰( v_em_dno ) 에 대해서 급여 역시 출력 할 수 있도록 수정하시오. 
    
    -- 이미 생성된 뷰 수정
    create or replace view v_em_dno
    as
    select eno 사원번호,  ename 사원명, dno 부서번호, salary 급여
    from emp_temp;
    
    -- 뷰 출력
    select * from v_em_dno;
    
3. 생성된  뷰를 제거 하시오. 

    -- 생성된 뷰 제거
    drop view v_em_dno;
    
    -- 뷰 제거 여부 확인
    select * from v_em_dno; -- not exist 출력

4. 각 부서의 급여의  최소값, 최대값, 평균, 총합을 구하는 뷰를 생성 하시오. 
	뷰이름 : v_sal_emp
    
    -- 뷰 생성
    create view v_sal_emp
    as
    select dno 부서번호, min(salary) 최소급여, max(salary) 최대급여, round(AVG(salary),0) 급여평균, SUM(salary) 급여총액
    from emp_temp
    group by dno;
    
    -- 뷰 출력
    select * from v_sal_emp;
    
5. 이미 생성된 뷰( v_em_dno ) 에 대해서 읽기 전용 뷰로 수정하시오.

    -- v_em_dno 재생성
    create or replace view v_em_dno
    as
    select eno 사원번호,  ename 사원명, dno 부서번호, salary 급여
    from emp_temp;
    
    create or replace view v_em_dno
    as
    select eno 사원번호,  ename 사원명, dno 부서번호, salary 급여
    from employee with read only;
    
    -- 뷰 출력
    select * from v_em_dno;
        
    -- Read Only 검증
    DELETE v_em_dno; --  cannot perform a DML operation on a read-only view 출력
