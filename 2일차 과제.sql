--1. ���� �����ڸ� ����� ��� ����� ����  $300�� �޿��λ��� ����� �Ŀ�
--   �λ�� �޿��� ����� ��



SELECT ename ����̸�, salary �޿�, (salary+300) "�λ�� �޿�" 
from employee;

--2. ����� �̸�, �޿�, ���� �Ѽ����� �����ͺ��� ������ ���
SELECT ename ����̸�, salary �޿�, (salary*12+100) "�λ�� �޿�" 
from employee;

--3. �޿��� 2000�� �Ѵ� ����� �̸��� �޿��� �޿��� ���� ������ ���

SELECT ename ����, salary 
FROM employee
order by salary asc;

--4. �����ȣ�� 7788�� ����� �̸��� �μ���ȣ ���

SELECT ename ����, dno �μ��ڵ�
from employee
where eno = 7788;

--5 �޿��� 2õ~3õ ���̿� ���Ե��� �ʴ� ����� �̸��� �޿��� ���

SELECT ename ����, salary ����
from employee
where salary < 2000 or salary > 3000;

--6. 1981 2�� 20�Ϻ��� 81�� 5�� 1�� ������ �Ի��� ����� �̸� ������, �Ի��� ���

SELECT ename ����, job ����, hiredate �Ի���
FROM employee
where hiredate BETWEEN '1981/2/20' and '1981/5/1';

--7. �μ���ȣ�� 20 �� 30�� ���� ����� �̸� / �μ���ȣ ��� (�̸� �������� ����)
SELECT ename ����, dno �μ���ȣ
from employee
where dno = 20 or dno = 30
order by ename desc;

--8. ����� �޿��� 2000 ~ 3000 ���� / �μ���ȣ 20 �Ǵ� 30 �� �����
-- �̸�, �޿�, �μ���ȣ�� �̸��� ������������ �Է�

SELECT ename ����, salary ����, dno �μ���ȣ
from employee
where salary BETWEEN 2000 and 3000 and dno in (20,30)
ORDER by ename asc;


--9 1981 �⵵�� �Ի��� ����� �̸��� �Ի��� ���(lke ������ �� ���ϵ�ī�� Ȱ��)

SELECT ename �̸�, hiredate �Ի���
FROM employee
where hiredate like '81/%';

--10. �����ڰ� ���� ����� �̸��� ������ ���

SELECT ename ����, job ���� 
from EMPLOYEE
where manager is null;

--11. Ŀ�̼��� ���� �� �ִ� �ڰ��� �Ǵ� ����� �̸�/�޿�/Ŀ�̼� ���
-- �� �޿��� Ŀ�̼��� �������� �������� ����

SELECT ename ����, salary ����, commission ���ʽ�
FROM employee
where commission is not null
ORDER BY salary, commission desc;

--12. �̸��� ����° ���ڰ� R�� ����� �̸��� ǥ���Ͻÿ�.

SELECT ename ����
from employee
where ename like '__R%'; 

--13. DLFMADP A�� E�� �����ϰ� �ִ� ����� �̸��� ǥ���Ͻÿ�

SELECT ename ����
from employee
where ename like '%A%' AND ename like '%E%'; 

--14. �������� �繫�� (CLERK) �Ǵ� ������� (SALESMAN)�̸鼭 �޿���
-- 1600/950/1300/�� �ش����� �ʴ� �ο��� �̸� ������ �޿� ���

SELECT ename ����, job ����, salary ����
FROM employee
WHERE JOB in ('CLERK','SALESMAN') AND salary NOT IN (1600,950,1300);

--15. Ŀ�̼��� 500 �̻��� ����� �̸��� �޿� �� Ŀ�̼� ���

SELECT ename ����, salary ����, commission ���ʽ�
FROM employee
WHERE commission >= 500;