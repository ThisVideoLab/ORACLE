-- 2���� : DQL : Select

desc department;

select * from department;

/*
SQL : ����ȭ�� ���� ���

Select ������ ��ü �ʵ� ����

Select   <== �÷���
Distinct <== �÷����� ���� �ߺ��� �����ض�.
From     <== ���̺� ��, �� ��.
Where    <== ����
Group By <== Ư�� ���� �׷���
Having   <== �׷��� �� ���� ����
Order by <== ���� �����ؼ� ���
(���� �߿�)
*/
desc employee;
select *
from employees;

-- Ư�� �÷��� ��� �ϱ�
select eno, ename from employees;

select * from employees;

select employee_id, first_name, salary from employees;

-- �÷��� �˸�� ( Alias) : �÷��� �̸��� ����
-- �÷����� �����ϰų� �Լ��� ����ϸ� �÷����� ������



-- as�� �ٿ��� �÷����� �ٲ� �� ����
select employee_id, first_name, salary as ���� from employees;

-- as�� ������ ������
select employee_id �����ȣ, first_name �����, salary ���� from employees;

-- �����̳� Ư�����ڰ� �� ���� ""���� ó������� ��.
select employee_id "��� % ��ȣ", first_name �����, salary ���� from employees;

-- nvl  �Լ� : ����ÿ� null�� ó���ϴ� �Լ�
select * from employees;

select employee_id �����ȣ, first_name �����, salary ����, commission_pct ���ʽ�,
salary*12 + commission_pct ����-- �� �ο��� ���� ���
from employees;

-- �̷��� null�� �� �÷��� ������ ����ϸ� ���ԵǾ��ٴ� �� ��� �ϳ������� ���� ���
-- null�� �ٲ�����. ��� null�� 0���� �ٲ� ó���ϴ� ���� �ʿ���. �̴� �ʿ��� ����
-- nvl �Լ���. 

select employee_id �����ȣ, first_name �����, salary ����, nvl(commission_pct,0)
���ʽ�, salary*12 + nvl(commission_pct,0) ����-- �� �ο��� ���� ���
from employees;

-- �̿� ���� nvl(�÷���,0)�� �ְ� 0�ڸ��� ��ü�ϰ� ���� ���� ������ null�� ��ü��.

-- Ư�� �÷��� ���뿡�� �ߺ��� ������ �Ŀ� �����.

select * from employees;
select department_id from employees;
select nvl(commission_pct,0) from employees;

-- ������ ����ؼ� �˻� (where)

select * from employees;
select employee_id �����ȣ, first_name �����, salary ����, nvl(commission_pct,0)
���ʽ�, salary*12 + nvl(commission_pct,0) ����-- �� �ο��� ���� ���
from employees;

-- �����ȣ�� 109�� ����� ��ü ������ �˻�
select * from employees 
where employee_id = 109;

-- �����ȣ�� 109�� ����� ���ϴ� �������� �˻���
select employee_id �����ȣ, first_name �����, salary ����, nvl(commission_pct,0)
���ʽ�, salary*12 + nvl(commission_pct,0) ���� from employees 
where employee_id = 109;

-- ��� �̸����� �˻��� ��, ���ڴ� ''�� ����� ��.
select * from employees where first_name = 'Daniel';



-- ���ڵ� ������ ��
-- number ���� ''�� ������ �ʾƵ� �ȴ�. �ٸ� ���ڵ����� (char)�� �����ö��� ����ؾ���.
-- ���� ��ҹ��ڸ� �������� �ʴ� �ڵ�ʹ� �ٸ���, ���� �ҷ��� ���� ��ҹ��ڸ� ������

-- �Ի糯¥�� 06/02/05 �� ����� �̸��� ���
select first_name ����, hire_date �Ի��� from employees where hire_date = '06/02/05';

-- �μ��ڵ尡 60�� ������� ���� ���
select first_name ����, department_id �μ��ڵ�  from employees
where department_id = 60;

-- ������ 3000 �̻��� ����� �̸��� �μ��� �Ի� ��¥�� ����ϱ�
select first_name �����, department_id �μ��ڵ�, hire_date �Ի���,  salary ����
from employees
where salary > 3000;

-- Null �˻� : is Ű���� ���
-- �ڹٿʹ� �ٸ��� null�� �ٸ��� ����ؼ� is�� ����ؾ� ��.
select *
from employees
where commission_pct is null;

--commision�� 2�� �̻��� ������� �̸��� ��å, ���� ���
select first_name ����,job_id ��å, salary ����, commission_pct ���ʽ�
from employees
where commission_pct > 0.2;

--commision�� ���� ������� �̸��� ��å, ���� ���
select first_name ����,job_id ��å, salary ����, commission_pct ���ʽ�
from employees
where commission_pct is null;

-- ������ 500�̻� 2500 �̸��� ������� �̸�, �����ȣ, �Ի糯¥ ������ ���

select first_name ����, employee_id �����ȣ, hire_date �Ի���, salary ����
from employees
where salary >=2300 and 2500> salary;

-- ��å��  account�̰ų�, �μ��ڵ尡 30(pu_man)�� �����
-- ����̸�, ��å, ����, �μ��ڵ带 ���
select * from employees;
select first_name ����,job_id ��å, salary ����, department_id �μ��ڵ�
from employees
where job_id = 'FI_ACCOUNT' or department_id = 30;

-- Ŀ�̼��� ���� ����� �߿��� �μ��ڵ尡 20�� ������� �̸�, �μ��ڵ�� �Ի糯¥�� ���
SELECT first_name ����, department_id �μ��ڵ�, hire_date �Ի���,
       nvl(commission_pct,0) ���ʽ�
from employees
where commission_pct is null and department_id = 20;

-- Ŀ�̼��� null�� �ƴ� ������� �̸�, �Ի糯¥, ������ ���
SELECT first_name ����, hire_date �Ի���, salary ����, commission_pct ���ʽ�
FROM employees
where commission_pct is not null;

-- ��¥�˻�
SELECT *
from employees
where hire_date >= '2002/1/1' and hire_date <= '2003/12/31';

-- between A and B : A �̻� B ����

SELECT *
from employees
where hire_date between '2002/1/1' and '2003/12/31';

-- In ������ 
-- Ŀ�̼��� 2��, 3��, 4���� ����� �̸�, ��å, �Ի����� ���
select first_name ����, job_id ��å, hire_date �Ի���, commission_pct ���ʽ�
from employees
where commission_pct in (0.2, 0.3, 0.4);
-- where commission_pct = 0.2 or  commission_pct = 0.3 or commission_pct = 0.4;
-- ������ �̷��� or�� �Է��ϴµ� �ΰ�������  �Ѹ� ���

--like  : �÷����� Ư���� ���ڿ��� �˻� <== �Խ���, �ڷ���� �� �˻� ��� ����
    -- % : �� �Ǵ� �ڿ� �ٿ��� �� �����̳� ���ķ� � ���ڰ� �͵� ��� ����
    -- _ : �ѱ��ڰ� � ���� �͵� ��� ����
    
-- S�� �����ϴ� ��� �������� ��� -- �� �� ��ҹ��ڸ� �� ������ ��

SELECT *
from employees
where first_name like 'S%';

-- es�� ������ ��� �������� ��� -- �� �� ��ҹ��ڸ� �� ������ ��
SELECT *
from employees
where first_name like '%es';

-- J�� �����ؼ� J �ڿ��� ����� �͵� ��� �����Ǥ�, �������� es�� ������ ������

SELECT * from employees
where first_name like 'J_mes'; -- �� 1����

-- ��å�� �� �������� MAN�� ���� ��� ��� ���

SELECT *
from employees
where job_id like '%MAN%'; -- �յڷ� ���� �ٴ� ����

-- 02�⵵�� �Ի��� ���� ��� ���

select *
from employees
where hire_date like '02%';

-- 02�⵵ 6���� �Ի��� ���� ��� ���

select *
from employees
where hire_date like '02/06%';

-- ���� : order by, asc(�������� ����), desc(�������� ����)

SELECT *
from employees
ORDER BY employee_id asc;

SELECT *
from employees
ORDER BY employee_id desc;

-- �̸� �÷��� ����

SELECT *
from employees
ORDER BY first_name asc;

SELECT *
from employees
ORDER BY first_name desc;

-- �Ի� ��¥�� ����

SELECT *
from employees
ORDER BY hire_date asc;

-- �����亯�� �Խ��ǿ��� �ַ� ��� �ΰ� �̻��� �÷��� ������ ��
-- 1������ ù��° �÷��� �����ϰ�, ù �÷��� ������ 2��°�� �������� ������.

SELECT *
from employees
ORDER BY department_id, first_name; 

-- �������� �������� ȥ���ؼ� ����ϱ�

SELECT department_id �μ���, first_name ����
from employees
ORDER BY department_id desc, first_name; 

--where���� order by ���� ���� ���� ���� ���� ����

select *
from employees
where commission_pct is null
order by first_name desc;  -- oder by�� �׻� ���� �������� �Է��� ��.



/* �پ��� �Լ� ����ϱ�
    
1. ���ڸ� ó���ϴ� �Լ�
    UPPER: �빮�ڷ� ��ȯ
    LOWER: �ҹ��ڷ� ��ȯ
    INITCAP: ù�ڸ� �빮�ڷ�, �������� �ҹ��ڷ� ��ȯ
    
     dual ���̺� : �ϳ��� ����� ��� �ϵ��� �ϴ� ���̺�
*/

SELECT '�ȳ��ϼ���' as �ȳ�
from dual; --������ �̷� ���̺��� ������, �׳� ����ϵ��� ����

SELECT 'Oracle mania', UPPER ('Oracle mania'), LOWER ('Oracle mania'),
initcap ('Oracle mania')
from dual;

SELECT * FROM employee;


SELECT ename, lower(ename), UPPER(ename), initcap(ename)
from employee;

SELECT * FROM employee
WHERE ename = 'allen'; -- �˻��� �ȵ�.

SELECT * FROM employee
WHERE lower(ename) = 'allen';

SELECT * FROM employee
WHERE initcap(ename) = 'Allen';

-- ���� ���̸� ����ϴ� �Լ�
    --length: ������ ���̸� ��ȯ, �����̳� �ѱ� ������� ���ڼ��� ������
    --lengthb: ������ ���̸� ��ȯ, ������ 1byte �ѱ� 3byte�� ��ȯ

SELECT LENGTH ('Oracle mania'), length ('����Ŭ �ŴϾ�')from dual;

SELECT LENGTHb ('Oracle mania'), lengthb ('����Ŭ �ŴϾ�')from dual;

SELECT * FROM employee;

SELECT ename, length (ename), job, length(job) from employee;

/* ���� ���� �Լ�
    concat: ���ڿ� ���ڸ� �����ؼ� �����
    substr:  ���ڸ� Ư�� ��ġ���� �߶���� �Լ� (����, �ѱ� ��� 1byte�� ó��)
    substrb: ���ڸ� Ư�� ��ġ���� �߶���� �Լ� ( ������ 1byte, �ѱ��� 3byteó��)
    instr: ������ Ư�� ��ġ�� �ε��� ���� ��ȯ�� ( ������ 1byte, �ѱ��� 3byteó��)
    lpad: �������� ������, ������ ���ڼ���ŭ, Ư�� ���ڿ��� �߰��� �Է�����.
    rpad: �������� ������, ������ ���ڼ���ŭ, Ư�� ���ڿ��� �߰��� �Է�����.
*/



-- concat: �ٿ��� ����ϱ�
SELECT 'Oracle', 'mania', concat ('Oracle', 'mania') from dual;

-- ���� �÷��� �� �������� �����ϱ�

SELECT 'Oracle', 'mania', concat ( 'Oracle', 'mania') from dual;
SELECT * from employee;
SELECT concat (ename, '   ' ||job) from employee; -- �� �÷� ���� ���� ��

SELECT '�̸��� ' || ename || '�̰�, ��å�� ' || job || '�Դϴ�' as �÷�����
from employee;

SELECT '�̸��� ' || ename || '�̰�, ���ӻ�� ����� ' || manager || '�Դϴ�'
as �÷�����
from employee;

--substr(���, ������ġ, ���ⰹ��): Ư�� ��ġ���� ���ڸ� �߶��. ���鵵 �����Ѵ�
SELECT 'Oracle mania', substr ('Oracle mania', 4,3), substr('����Ŭ �ŴϾ�', 2,4)
from dual;

SELECT 'Oracle mania', substr ('Oracle mania', -4,3), substr('����Ŭ �ŴϾ�', -6,4)
from dual; -- ù ������ 0���� ��Ƽ� ���������� n ��°���� �����

SELECT ename, substr(ename, 2,3), substr(ename, -5, 2) from employee;
-- ĭ�� ���ڶ�� ��쳪 ��Ÿ ��쿡�� null�� �� �� ����

SELECT substrb ('Oracle mania', 3,3), substrb ('����Ŭ �ŴϾ�', 4,6) from dual;

-- �̸��� N���� ������ ������ ����ϱ� (substr �Լ��� ����ؼ� ���)

SELECT ename ���� from employee
where substr (ename, -1, 1) = 'N';

-- 87�⵵�� �Ի��� ����� ����ϱ� (substr �Լ��� ����ؼ� ���)
select ename ����, hiredate �Ի��� from employee
where substr (hiredate, 0, 2) = '87';

--instr (���, ã�� ����, ���� ��ġ) ���° �߰�) 

select 'Oracle mania', instr ('oracle mania', 'a') from dual;

select 'Oraclea mania', instr ('oracle mania', 'a', 5, 2) from dual;
    -- 5��° ���� �����ؼ� 2��° �߰ߵǴ� a�� �ε��� ��ȣ�� �����
    
select 'Oraclea mania', instr ('oracle mania', 'a', -5, 1) from dual;
    -- ������ �������� �˻���. �������� �˻��ϰ� ��°��� �������� �ε��� ��ȣ �����
    
select distinct instr (job, 'A',1,1) ��å from employee
where lower(job) = 'manager';

-- lpad �������� ������, �Է��� ���ڼ���ŭ, Ư�� ���ڿ��� �߰��� �Է�����.
select lpad( salary, 10 ,'*') from employee;

-- rpad: �������� ������, ������ ���ڼ���ŭ, Ư�� ���ڿ��� �߰��� �Է�����.
select rpad( salary, 10 ,'*') from employee;

-- TRIM : ��������, Ư�� ���ڵ� ����
    --LTRIM: ������ ������ ����
    --RTRIM: �������� ������ ����
    --TRIM: ������ ������ ����
    
SELECT LTRIM ('   orcale mania   ') a, rtrim ('   ocalce mania   ') b, 
trim ('   oracle mania   ') c from dual;