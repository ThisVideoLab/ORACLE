
--subquery ����. 

--Join ����.
--�Ϸ� �ð� : 6:20�б���. 

--7. SELF JOIN�� ����Ͽ� ����� �̸� �� �����ȣ�� ������ �̸� �� ������ ��ȣ�� �Բ� ��� �Ͻÿ�. ������ ��Ī���� �ѱ۷� �����ÿ�. 
 	
select e1.ename �̸�, e1.eno �����ȣ, nvl(e1.manager,'0') �����ڹ�ȣ, e2.ename �������̸�
from employee e1, employee e2
where e1.manager = e2.eno
order by e1.ename asc;

-- 8. OUTER JOIN, SELF JOIN�� ����Ͽ� �����ڰ� ���� ����� �����Ͽ� �����ȣ�� �������� �������� �����Ͽ� ��� �Ͻÿ�. 

select e1.eno �����ȣ, e1.ename �����, e2.ename ���ӻ����
from employee e1, employee e2
 e1.manager = e2.eno (+) -- outer join�� �־�� ���ӻ������ null�� �൵ �ҷ�����
order by e1.eno asc;

--9. SELF JOIN�� ����Ͽ� ������ ����� �̸�, �μ���ȣ, ������ ����� ������ �μ����� �ٹ��ϴ� ����� ����Ͻÿ�. 
--   ��, �� ���� ��Ī�� �̸�, �μ���ȣ, ����� �Ͻÿ�. 

select  e1.ename �����, e1.dno �μ���ȣ, e2.ename ����
from employee e1, employee e2
where e1.ename = 'SCOTT' and e1.dno = e2.dno
order by e1.eno asc;

-- 10. SELF JOIN�� ����Ͽ� WARD ������� �ʰ� �Ի��� ����� �̸��� �Ի����� ����Ͻÿ�. 

select  e2.ename �̸�, e2.hiredate �Ի���
from employee e1, employee e2
where e1.ename = 'WARD' and e1.hiredate < e2.hiredate
order by e1.eno asc;



11. SELF JOIN�� ����Ͽ� ������ ���� ���� �Ի��� ��� ����� �̸� �� �Ի����� ������ �̸� �� �Ի��ϰ� �Բ� ����Ͻÿ�. 
    ��, �� ���� ��Ī�� �ѱ۷� �־ ��� �Ͻÿ�. 
    
select  e1.ename ����̸�, e1.hiredate ����Ի���, e2.ename �������̸�, e2.hiredate �������Ի���
from employee e1, employee e2
where e1.manager = e2.eno and e1.hiredate < e2.hiredate 
order by e2.ename asc;




-- ������ �������� : sub query�� ������� �� �ϳ��� ��µ�
    -- ������ �� ������: >, =, >=, <,<=,<>,<=
-- ������ ���� ����: sub query�� ��� ���� ������ ���
-- ������ ���� ���� ������: IN, ANY, SOME, ALL, EXISTS
--    IN: ���� ������ �� ���� ('*'�����ڷ� ���� ���) �� ���������� ��� �� �߿��� �ϳ��� ��ġ�ϸ� ��
--        ANY, SOME: ���� ������ �� ������ ���������� �˻� ����� �ϳ� �̻� ��ġ�ϸ� ��
--        ALL : ���� ������ �� ������ ���� ������ �˻� ����� ��� ���� ��ġ�ϸ� ��
--        EXIST: ���� ������ �� ������ ���� ������ ����� �߿��� �����ϴ� ���� �ϳ��� �����ϸ� ��.
        
-- ALL ������
    -- subquery�� ��ȯ�ϴ� ��� ���� ����        
    -- '>all': �ִ밪���� ŭ�� ��Ÿ��
    --'<all': �ּҰ����� ������ ��Ÿ��

<<�Ʒ� ������ ��� Subquery�� ����Ͽ� ������ Ǫ����.>>

1. �����ȣ�� 7788�� ����� ��� ������ ���� ����� ǥ��(����̸� �� ������) �Ͻÿ�.  

select ename, job
from employee
where job = (select job from employee where eno = 7788);

2. �����ȣ�� 7499�� ������� �޿��� ���� ����� ǥ�� (����̸� �� ������) �Ͻÿ�. 

select ename, job
from employee
where salary > (select salary from employee where eno = 7499);

3. ���޺� �ּ� �޿��� �޴� ����� �̸�, ��� ���� �� �޿��� ǥ�� �Ͻÿ�(�׷� �Լ� ���)

select ename, job, salary 
from employee
where salary in(select  min(salary) 
                from employee 
                group by job)
order by salary asc;


4. ����� ���� ���� ������ ���� �ں��� ������ ���ް� �޿��� ǥ���Ͻÿ�

select job ,min(salary)
from employee
where dno =  (select dno salary from employee group by dno having min(avg(salary)));

����� ���� ���� ������ ���� = select min(avg(salary)) from employee group by dno
                            

select min(avg(salary)) from employee group by dno

order by salary asc;

5. �� �μ��� �ּ� �޿��� �޴� ����� �̸�, �޿�, �μ���ȣ�� ǥ���Ͻÿ�.

select ename ����, job ����, salary ����
from employee
where salary = (select min(salary) from employee);

6. ��� ������ �м���(ANALYST) �� ������� �޿��� �����鼭 ������ �м����� �ƴ� ������� ǥ�� (�����ȣ, �̸�, ������, �޿�) �Ͻÿ�.

select eno, ename, job, salary
    from employee
    where salary <all (select (salary) 
                    from employee 
                    where job = 'ANALYST')
          and job <> 'ANALYST'
    order by salary asc;

select * from employee;

7. ���������� ���� ����� �̸��� ǥ�� �Ͻÿ�. 

select eno
from employee 
where NO EXISTS (select manager from employee);

8. ���������� �ִ� ����� �̸��� ǥ�� �Ͻÿ�. 

���������� �ִ� -> �������� �Ŵ��� �÷���, ���� ���̵� ����ִ�.

select eno, ename
from employee 
where EXISTS (select manager from employee);

9. BLAKE �� ������ �μ��� ���� ����� �̸��� �Ի����� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�(��, BLAKE �� ����). 

10. �޿��� ��պ��� ���� ������� �����ȣ�� �̸��� ǥ���ϵ� ����� �޿��� ���ؼ� ���� �������� ���� �Ͻÿ�. 

11. �̸��� K �� ���Ե� ����� ���� �μ����� ���ϴ� ����� �����ȣ�� �̸��� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�. 

12. �μ� ��ġ�� DALLAS �� ����� �̸��� �μ� ��ȣ �� ��� ������ ǥ���Ͻÿ�. 

13. KING���� �����ϴ� ����� �̸��� �޿��� ǥ���Ͻÿ�. 

14. RESEARCH �μ��� ����� ���� �μ���ȣ, ����̸� �� ��� ������ ǥ�� �Ͻÿ�. 

15. ��� �޿����� ���� �޿��� �ް� �̸��� M�� ���Ե� ����� ���� �μ����� �ٹ��ϴ� ����� �����ȣ, �̸�, �޿��� ǥ���Ͻÿ�. 

16. ��� �޿��� ���� ���� ������ ã���ÿ�. 

17. �������� MANAGER�� ����� �Ҽӵ� �μ��� ������ �μ��� ����� ǥ���Ͻÿ�. 


