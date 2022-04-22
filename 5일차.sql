-- 5���� ��������

--sub query: select �� ���� select ���� �ִ� ����

select ename, salary from employee;
select salary from employee where ename = 'SCOTT';

-- SCOTT�� ���޺��� �� ���� �޴� ������ ����϶�

    -- �������� �̻��    
    select ename, salary from employee 
    where salary > 3000;
    
    -- �������� ���
    select ename , salary 
    from employee
    where salary > (select salary from employee where ename = 'SCOTT');
    
-- SCOTT�� ������ �μ��� �ٹ��ϴ� ����� ����ϱ� (dno ���)
select ename, dno
from employee
where dno = (select dno from employee where ename = 'SCOTT');

-- SCOTT�� ������ �μ��� �ٹ��ϴ� ����� ����ϱ� (dname ���, join�� ����ϱ�)
select e.ename, d.dname
from employee e, department d
where d.dno = (select dno from employee where ename = 'SCOTT') and e.dno = d.dno;

select * from department;
select * from department;

-- �ּ� �޿��� �޴� ����� �̸�, ������, �޿� ����ϱ�

select ename ����, job ����, salary ����
from employee
where salary = (select min(salary) from employee);

-- 30�� �μ��� �ּ� ������ �޴� ������� ���� ������ �޴� �����

select min(salary) from employee; -- 800����

select ename, dno,salary 
from employee
where salary > (select min(salary) from employee) and dno = 30
order by dno asc;

-- having ���� sub query ����ϱ�

-- 30�� �μ��� �ּ� ������ ���ϰ�, �� �μ����� �� ���޺��� ū ���� �߿��� �ּҰ��� ���϶�

select dno, min(salary) ,count(dno)
from employee
group by dno
having min(salary) > (select min(salary) from employee where dno = 30);

-- ������ �������� : sub query�� ������� �� �ϳ��� ��µ�
    -- ������ �� ������: >, =, >=, <,<=,<>,<=
-- ������ ���� ����: sub query�� ��� ���� ������ ���
-- ������ ���� ���� ������: IN, ANY, SOME, ALL, EXISTS
--    IN: ���� ������ �� ���� ('*'�����ڷ� ���� ���) �� ���������� ��� �� �߿��� �ϳ��� ��ġ�ϸ� ��
--        ANY, SOME: ���� ������ �� ������ ���������� �˻� ����� �ϳ� �̻� ��ġ�ϸ� ��
--        ALL : ���� ������ �� ������ ���� ������ �˻� ����� ��� ���� ��ġ�ϸ� ��
--        EXIST: ���� ������ �� ������ ���� ������ ����� �߿��� �����ϴ� ���� �ϳ��� �����ϸ� ��.
        

--IN ������ ����ϱ�

-- �μ����� �ּ� ������ �޴� ������ ����ϱ� (sub query �ݵ�� ����ؼ� ����� ��)

select ename, eno, dno, salary 
from employee
order by dno asc;

select ename, dno, salary 
from employee
where salary in(950, 800, 1300); -- �� ���߿� �ϳ��� ������ ������ ���

select ename, dno, salary 
from employee
where salary in(select  min(salary) from employee group by dno);

-- Any ������
    --sub query�� ������ ������ ���� ����
    --'<any'�� �ִ밪���� ������ ��Ÿ��.
    --'>any'�� �ּҰ����� ŭ�� ��Ÿ��.
    
    -- ��) ������ SALESMAN�� �ƴϸ鼭 �޿��� ������ SALESMAN���� ���� ����� ����Ͻÿ�
    select eno, ename, job, salary
    from employee
    where salary < any ( select salary from employee
                            where job = 'SALESMAN')
                            and job <> 'SALESMAN';
                            
    select ename, job, salary 
    from employee
    order by job;
    
-- ALL ������
    -- subquery�� ��ȯ�ϴ� ��� ���� ����        
    -- '>all': �ִ밪���� ŭ�� ��Ÿ��
    --'<all': �ּҰ����� ������ ��Ÿ��

-- ��)������ ��������� �ƴϸ鼭, �޿��� ������Ǻ��� ���� �����
    
    select eno, ename, job, salary
    from employee
    where salary <= (select min(salary) 
                    from employee 
                    where job = 'SALESMAN')
          and job <> 'SALESMAN'
    order by salary asc;
    
    
    
-- ��) �������� �м����� ������� �޿��� �����鼭, ������ �м����� �ƴ� ������� �����

select eno, ename, job, salary
    from employee
    where salary <all (select (salary) 
                    from employee 
                    where job = 'ANALYST')
          and job <> 'ANALYST'
    order by salary asc;

SELECT * FROM employee
where job = 'ANALYST';






