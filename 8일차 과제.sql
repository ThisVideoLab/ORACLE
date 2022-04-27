--8���� ����

10 : ������ ���Ἲ�� ���� ����

1. employee ���̺��� ������ �����Ͽ� emp_sample �� �̸��� ���̺��� ����ÿ�. ��� ���̺��� �����ȣ �÷���
    ���̺� ������ primary key ���������� �����ϵ� �������� �̸��� my_emp_pk�� �����Ͻÿ�. 

    -- ���̺� ����
    create table emp_sample 
    as
    select * from employee;

    -- �������� �߰�
    alter table emp_sample 
    add constraint my_emp_pk Primary Key (eno);

    -- �������� �߰� ���� Ȯ��
    select * from user_constraints
    where table_name IN 'EMP_SAMPLE';


2. department ���̺��� ������ �����Ͽ� dept_sample �� �̸��� ���̺��� ����ÿ�. 
    �μ� ���̺��� �μ���ȣ �÷��� ������ primary key ���� ������ �����ϵ� ���� �����̸��� my_dept_pk�� �����Ͻÿ�. 
    
    -- ���̺� ����
    create table dept_sample
    as
    select * from department;

    -- �������� �߰�
    alter table dept_sample
    add constraint my_dept_pk Primary Key (dno);

    -- �������� �߰� ���� Ȯ��
    select * from user_constraints
    where table_name IN 'DEPT_SAMPLE';
    

3. ��� ���̺��� �μ���ȣ �÷��� �������� �ʴ� �μ��� ����� �������� �ʵ��� �ܷ�Ű
    ���������� �����ϵ� ���� �����̸��� my_emp_dept_fk �� �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
    
    -- �������� �߰�
    alter table emp_sample 
    add constraint my_emp_dept_fk Foreign Key (dno) references dept_sample (dno);
    -- alter table (���̺��)
    -- add constraint (�������Ǹ�) Foreign Key (�ش� ���̺� �÷�) references dept_sample (���� ���̺� �÷�);
    
    
    -- �������� ���� ���� Ȯ��
    select * from user_constraints
    where table_name IN 'EMP_SAMPLE';
    
4. ������̺��� Ŀ�Լ� �÷��� 0���� ū ������ �Է��� �� �ֵ��� ���� ������ �����Ͻÿ�.
    [���� : �� ������ ���̺��� ����Ͻÿ�]
    
    -- �������� �߰�
    alter table emp_sample
    add constraint CK_emp_sample_salaryCondition check (salary > 0);
    
    -- �������� �߰� ���� Ȯ��
    select * from user_constraints
    where table_name IN 'EMP_SAMPLE';

5. ������̺��� ���� �÷��� �⺻ ������ 1000 �� �Է��� �� �ֵ��� ���� ������ �����Ͻÿ�.
    [���� : �� ������ ���̺��� ����Ͻÿ�]
    
    -- �������� �߰�
    alter table emp_sample
    modify salary default 1000;
    
    -- �������� �߰� ���� Ȯ��
    select * from user_constraints
    where table_name IN 'EMP_SAMPLE';
    

6. ������̺��� �̸� �÷��� �ߺ����� �ʵ���  ���� ������ �����Ͻÿ�.
    [���� : �� ������ ���̺��� ����Ͻÿ�]
    
    -- �������� �߰�
    alter table emp_sample
    add constraint UK_emp_sample_enmae unique (ename);
    
    -- �������� �߰� ���� Ȯ��
    select * from user_constraints
    where table_name IN 'EMP_SAMPLE';

7. ������̺��� Ŀ�Լ� �÷��� null �� �Է��� �� ������ ���� ������ �����Ͻÿ�.
    [���� : �� ������ ���̺��� ����Ͻÿ�]
    
    -- not null �������� �߰��� ���� ���� ���̺��� null �� ����
    update emp_sample
    set commission = 0
    where commission is null;
    
    
    -- �������� �߰�
    alter table emp_sample
    modify commission constraint NN_emp_sample_commission not null;

    -- �������� �߰� ���� Ȯ��
    select * from user_constraints
    where table_name IN 'EMP_SAMPLE';

8. ���� ������ ��� ���� ������ ���� �Ͻÿ�. 

    -- EMP_SAMPLE ���̺��� �������� ����
    alter table emp_sample drop primary key cascade; -- froeign Ű ���� �� primary key ����
    alter table emp_sample drop constraint my_emp_dept_fk;
    alter table emp_sample drop constraint NN_emp_sample_commission;  
    alter table emp_sample drop constraint UK_emp_sample_enmae;
    alter table emp_sample drop constraint CK_emp_sample_salaryCondition;
    alter table emp_sample modify salary default null; -- ������ �������� not null ���¸� null�� �ʱ�ȭ
    
    -- DEPT_SAMPLE �������� ����
    alter table dept_sample drop primary key;
    
    commit;
        
    -- EMP_SAMPLE ���̺��� �������� ���� ���� Ȯ��
    select * from user_constraints
    where table_name IN 'EMP_SAMPLE';
    
    -- DEPT_SAMPLE �������� ���� ���� Ȯ��
    select * from user_constraints
    where table_name IN 'DEPT_SAMPLE';
    


11 : ��

1. 20�� �μ��� �Ҽӵ� ����� �����ȣ�� �̸��� �μ���ȣ�� ����ϴ� select ���� �ϳ��� view �� ���� �Ͻÿ�.
	���� �̸� : v_em_dno  
    
    -- ��� ���̺� ���� : �� �������� ���̺� ���������� ����ų�� �𸣴� �ϴ� �����ϰ� ����
    create table emp_temp
    as
    select * from employee;
    
    -- �� ����
    create view v_em_dno
    as
    select eno �����ȣ,  ename �����, dno �μ���ȣ
    from emp_temp;
    
    -- �� ���
    select * from v_em_dno;
    

2. �̹� ������ ��( v_em_dno ) �� ���ؼ� �޿� ���� ��� �� �� �ֵ��� �����Ͻÿ�. 
    
    -- �̹� ������ �� ����
    create or replace view v_em_dno
    as
    select eno �����ȣ,  ename �����, dno �μ���ȣ, salary �޿�
    from emp_temp;
    
    -- �� ���
    select * from v_em_dno;
    
3. ������  �並 ���� �Ͻÿ�. 

    -- ������ �� ����
    drop view v_em_dno;
    
    -- �� ���� ���� Ȯ��
    select * from v_em_dno; -- not exist ���

4. �� �μ��� �޿���  �ּҰ�, �ִ밪, ���, ������ ���ϴ� �並 ���� �Ͻÿ�. 
	���̸� : v_sal_emp
    
    -- �� ����
    create view v_sal_emp
    as
    select dno �μ���ȣ, min(salary) �ּұ޿�, max(salary) �ִ�޿�, round(AVG(salary),0) �޿����, SUM(salary) �޿��Ѿ�
    from emp_temp
    group by dno;
    
    -- �� ���
    select * from v_sal_emp;
    
5. �̹� ������ ��( v_em_dno ) �� ���ؼ� �б� ���� ��� �����Ͻÿ�.

    -- v_em_dno �����
    create or replace view v_em_dno
    as
    select eno �����ȣ,  ename �����, dno �μ���ȣ, salary �޿�
    from emp_temp;
    
    create or replace view v_em_dno
    as
    select eno �����ȣ,  ename �����, dno �μ���ȣ, salary �޿�
    from employee with read only;
    
    -- �� ���
    select * from v_em_dno;
        
    -- Read Only ����
    DELETE v_em_dno; --  cannot perform a DML operation on a read-only view ���
