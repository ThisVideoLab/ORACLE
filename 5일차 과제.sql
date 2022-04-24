
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
where e1.manager = e2.eno (+) -- outer join�� �־�� ���ӻ������ null�� �൵ �ҷ�����
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


4. ��� ������ ���� ���� ������ ���� �ں��� ������ ���ް� �޿��� ǥ���Ͻÿ�

select ename ����, job ����, salary �޿�
from employee
where salary = (select min(salary) from employee 
                                   group by job 
                                   having avg(salary) = (select min(avg(salary)) 
                                                        from employee group by job))


5. �� �μ��� �ּ� �޿��� �޴� ����� �̸�, �޿�, �μ���ȣ�� ǥ���Ͻÿ�.

select ename �̸�, salary �޿�, dno �μ���ȣ
from employee
where salary in (select min(salary) from employee 
                                   group by dno)

6. ��� ������ �м���(ANALYST) �� ������� �޿��� �����鼭 ������ �м����� �ƴ� ������� ǥ�� (�����ȣ, �̸�, ������, �޿�) �Ͻÿ�.

select eno, ename, job, salary
    from employee
    where salary <all (select (salary) 
                    from employee 
                    where job = 'ANALYST')
          and job <> 'ANALYST'
    order by salary asc;



7. ���������� ���� ����� �̸��� ǥ�� �Ͻÿ�. 

select eno, ename
from employee 
where eno not in (select manager from employee where manager is not null);

8. ���������� �ִ� ����� �̸��� ǥ�� �Ͻÿ�. 
(���������� �ִ� -> �������� �Ŵ��� �÷���, ���� ����� ����ִ�.)

select eno ���, ename ����
from employee
where eno in (select manager from employee);

9. BLAKE �� ������ �μ��� ���� ����� �̸��� �Ի����� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�(��, BLAKE �� ����). 

select ename ����, hiredate �Ի���
from employee 
where dno = (select dno from employee where ename = 'BLAKE') and ename != 'BLAKE';

10. �޿��� ��պ��� ���� ������� �����ȣ�� �̸��� ǥ���ϵ� ����� �޿��� ���ؼ� ���� �������� ���� �Ͻÿ�. 

select eno ���, ename ����, salary ����
from employee
where salary > (select avg(salary) from employee)
order by salary asc;

11. �̸��� K �� ���Ե� ����� ���� �μ����� ���ϴ� ����� �����ȣ�� �̸��� ǥ���Ͻÿ�. 

select eno �����ȣ, ename �̸�
from employee
where dno in (select dno from employee where ename like '%K%'group by dno);

12. �μ� ��ġ�� DALLAS �� ����� �̸��� �μ� ��ȣ �� ��� ������ ǥ���Ͻÿ�. 

select ename �̸�, e.dno "�μ� ��ȣ", job "��� ����"
from employee e, department d
where  e.dno in (select dno from department where loc = 'DALLAS') and e.dno = d.dno;

13. KING���� �����ϴ� ����� �̸��� �޿��� ǥ���Ͻÿ�. 

    ����� ǥ���� ��ȣ���� ������. �Ϲ������� ����� ����ڸ� ������� �� �ϱ����� ���� ������
    �ǹ��ϴµ�, �� �� ����ڴ� ����� �ڽ� ���� ��� ����� �ش��. �̷��� �������� PRESIEDNT��
    ������ ���� KING���� ���� ������ ����� ��ǻ� KING ������ ������ ������ ���η� �A�� ����.
    ��� ������ ������ ���� �ؼ��ؿ� Ǯ���� �Ͽ���.
    
-> KING�� ���ӻ������ �� ����� �̸��� �޿��� ǥ���Ͻÿ�.

select ename �̸�, salary �޿�
from employee
where  manager = (select eno from employee where ename = 'KING');

14. RESEARCH �μ��� ����� ���� �μ���ȣ, ����̸� �� ��� ������ ǥ�� �Ͻÿ�. 

select ename �̸�, e.dno "�μ� ��ȣ", job "��� ����"
from employee e, department d
where  e.dno in (select dno from department where dname = 'RESEARCH') and e.dno = d.dno;

15. ��� �޿����� ���� �޿��� �ް� �̸��� M�� ���Ե� ����� ���� �μ����� �ٹ��ϴ� ����� �����ȣ, �̸�, �޿��� ǥ���Ͻÿ�. 

1)((����1: ��� �޿����� ���� �޿��� �ް� / ����2: �̸��� M�� ���Ե� ���)�� ���� �μ����� �ٹ��ϴ� ����� �����ȣ, �̸�, �޿��� ǥ���Ͻÿ�. 

select dno �μ���ȣ, eno �����ȣ, ename �̸�, salary �޿� 
from employee
where dno = (select dno 
             from employee 
             where salary >all (select avg(salary)
                                from employee) 
                                and ename like '%M%');

2) (����1:��� �޿����� ���� �޿��� �ް�) (����2:�̸��� M�� ���Ե� ����� ���� �μ����� �ٹ��ϴ�) ����� �����ȣ, �̸�, �޿��� ǥ���Ͻÿ�.

select dno �μ���ȣ, eno �����ȣ, ename �̸�, salary �޿� 
from employee
where dno in (select dno
             from employee 
             where ename like '%M%')
      and salary > (select avg(salary) from employee)
order by dno asc;

16. ��� �޿��� ���� ���� ������ ã���ÿ�. 

select job ����, avg(salary) ��տ���
from employee
group by job
having avg(salary) = (select min(avg(salary)) from employee group by job);

17. �������� MANAGER�� ����� �Ҽӵ� �μ��� ������ �μ��� ����� ǥ���Ͻÿ�. 

select eno, ename
from employee
where dno in (select dno from employee where job = 'MANAGER');