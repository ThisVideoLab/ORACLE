-- 1.��� ����� �޿� �ְ��, ������, �Ѿ�, �� ��� �޿��� ��� �Ͻÿ�. �÷��� ��Ī�� ����
--  (�ְ��, ������, �Ѿ�, ���)�ϰ� �����ϰ� ��տ� ���ؼ��� ������ �ݿø� �Ͻÿ�. 

select max(salary) �ְ��, min(salary) ������, sum(salary) �Ѿ�, ROUND(avg(salary),0) ��� 
from employee;

--2. �� ������ �������� �޿� �ְ��, ������, �Ѿ� �� ��վ��� ����Ͻÿ�. �÷��� ��Ī�� 
--  ����(�ְ��, ������, �Ѿ�, ���)�ϰ� �����ϰ� ��տ� ���ؼ��� ������ �ݿø� �Ͻÿ�. 

select job ����, max(salary) �ְ��, min(salary) ������, sum(salary) �Ѿ�, ROUND(avg(salary),0) ���
from employee
group by job;

--3. count(*)�Լ��� ����Ͽ� ��� ������ ������ ������� ����Ͻÿ�. 
select job ����, count(job) ����ο� from
employee
group by job;

--4. ������ ���� ���� �Ͻÿ�. �÷��� ��Ī�� "�����ڼ�" �� ���� �Ͻÿ�. 
select job ����, count(job) �����ڼ� from employee
group by job
having job = 'MANAGER';

--5. �޿� �ְ��, ���� �޿����� ������ ��� �Ͻÿ�, �÷��� ��Ī�� "DIFFERENCE"�� �����Ͻÿ�. 
SELECT max(salary) �ְ�޿�, min(salary) �����޿�, max(salary) - min(salary) difference
FROM employee;

--6. ���޺� ����� ���� �޿��� ����Ͻÿ�. �����ڸ� �� �� ���� ��� �� ���� �޿��� 
--   2000�̸��� �׷��� ���� ��Ű�� ����� �޿��� ���� ������������ �����Ͽ� ��� �Ͻÿ�. 

select job ����, min(salary) �����޿�
from employee
where manager is not null
group by job
having min(salary) >= 2000
order by job;
 
-- 7. �� �μ������� �μ���ȣ, �����, �μ����� ��� ����� ��� �޿��� ����Ͻÿ�. 
--    �÷��� ��Ī�� [�μ���ȣ, �����, ��ձ޿�] �� �ο��ϰ� ��ձ޿��� �Ҽ��� 2°�ڸ����� �ݿø� �Ͻÿ�. 

select dno �μ���ȣ, count(dno) �����, round(avg(salary),2) ��ձ޿�
from employee
GROUP BY dno;

-- 8. �� �μ��� ���� �μ���ȣ�̸�, ������, �����, �μ����� ��� ����� ��� �޿��� ����Ͻÿ�.
--    �ᷳ�� ��Ī�� �Ʒ� [ ��¿���] �� �����ϰ� ��ձ޿��� ������ �ݿø� �Ͻÿ�.  

select decode(dno, 10, 'SALES', 20, 'RESEARCH', 30, 'ACCOUNTING','Default') Dname,
        decode(dno, 10, 'CHICAGO', 20, 'DALLAS', 30, 'NEWYORK','Default') Location,
        count(dno) "Number of Peoeple",
        round(avg(salary),0) salary
from employee
group by dno;



-- ���̺� ���� ���� - 06

--1. EQUI ������ ����Ͽ� SCOTT ����� �μ� ��ȣ�� �μ� �̸��� ��� �Ͻÿ�. 

select ename, e.dno, dname from employee e, department d
where e.dno = d.dno
AND ename = 'SCOTT';

--2. INNER JOIN�� ON �����ڸ� ����Ͽ� ����̸��� �Բ� �� ����� �Ҽӵ� �μ��̸��� �������� ����Ͻÿ�. 

select ename, dname, loc from employee e INNER join department d
on e.dno = d.dno;

--4. NATUAL JOIN�� ����Ͽ� Ŀ�Լ��� �޴� ��� ����� �̸�, �μ��̸�, �������� ��� �Ͻÿ�. 

select ename, dname, loc 
from employee e natural join department
where  e.commission is not null;


-- 5. EQUI ���ΰ� WildCard�� ����Ͽ� �̸��� A �� ���Ե� ��� ����� �̸��� �μ����� ��� �Ͻÿ�. 
select ename, dname from employee,department 
where department.dno = employee.dno
and ename like '%A%';


-- 6. NATURAL JOIN�� ����Ͽ� NEW YORK�� �ٹ��ϴ� ��� ����� �̸�, ����, �μ���ȣ �� �μ����� ����Ͻÿ�. 

select ename, job, dno, dname, loc 
from employee e natural join department
where  loc = 'NEW YORK';
