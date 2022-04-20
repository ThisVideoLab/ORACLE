-- �Ϸ�ð� : 6: 10�б��� . p.jangwoo@gmail.com, ����Ե鿡�Ե� ����. 

-- 1. SUBSTR �Լ��� ����Ͽ� ������� �Ի��� �⵵�� �Ի��� �޸� ��� �Ͻÿ�. 

select ename ����, substr(hiredate,1,5) �Ի��� from employee;

-- 2. SUBSTR �Լ��� ����Ͽ� 4���� �Ի��� ����� ��� �Ͻÿ�. 

select ename ����, substr(hiredate,4,2) �Ի��
from employee
where substr(hiredate,4,2) ='04';

-- 3. MOD �Լ��� ����Ͽ� ���ӻ���� Ȧ���� ����� ����Ͻÿ�. 
SELECT ename ����, manager "���ӻ�� �����ȣ" FROM employee
where mod(manager, 2) = 1;

--3-1. MOD �Լ��� ����Ͽ� ������ 3�� ����� ����鸸 ����ϼ���.

SELECT ename ����, salary "3��� ����" FROM employee
where mod(salary , 3) = 0;

-- 4. �Ի��� �⵵�� 2�ڸ� (YY), ���� (MON)�� ǥ���ϰ� ������ ��� (DY)�� �����Ͽ� ��� �Ͻÿ�. 
select ename ����, to_char(hiredate, 'yy') �Ի�⵵,
to_char(hiredate, 'MON') �Ի��, to_char(hiredate, 'DY') �Ի���� from employee;

--5. ���� �� ���� �������� ��� �Ͻÿ�. ���� ��¥���� ���� 1�� 1���� �� ����� ����ϰ�
--   TO_DATE �Լ��� ����Ͽ� ������ ������ ��ġ ��Ű�ÿ�. 
SELECT  to_date('20220101', 'yyyymmdd') �������� ,SYSDATE ��������, 
trunc(SYSDATE - to_date('20220101', 'yyyymmdd'))as "�����" FROM dual;


-- 5-1. �ڽ��� �¾ ��¥���� ������� �� ���� �������� ��� �ϼ���. 
SELECT  to_date('19880509', 'yyyymmdd') �������� ,SYSDATE ��������,
trunc(SYSDATE - to_date('19880509', 'yyyymmdd')) as "����ϼ�" FROM dual;

--5-2. �ڽ��� �¾ ��¥���� ������� �� ������ �������� ��� �ϼ���. 

SELECT  to_date('19880509', 'yyyymmdd') �������� ,SYSDATE ��������,
trunc(months_between (sysdate,to_date('19880509', 'yyyymmdd'))) from dual;

--6. ������� ��� ����� ����ϵ� ����� ���� ����� ���ؼ��� null ����� 0���� ��� �Ͻÿ�. 

SELECT ename ����, eno �����ȣ, nvl(manager,0) "���ӻ�� �����ȣ" 
from employee
order by ename;

--7.  DECODE �Լ��� ���޿� ���� �޿��� �λ��ϵ��� �Ͻÿ�. ������ 'ANALYST' ����� 200 , 'SALESMAN' ����� 180,
--    'MANAGER'�� ����� 150, 'CLERK'�� ����� 100�� �λ��Ͻÿ�. 
select ename ����, dno �μ���ȣ, salary "�λ� �� ����", decode(JOB, 'ANALYST', 200,
                                                               'SALESMAN', 180,
                                                               'MANAGER', 150,
                                                               'CLERK', 100,
                                                               salary) as "�λ��",

                                                  decode(JOB, 'ANALYST', salary + 200,
                                                               'SALESMAN', salary + 180,
                                                               'MANAGER', salary + 150,
                                                               'CLERK', salary + 100,
                                                               salary) as "�λ��Ŀ���" 
from employee;

--8. �����ȣ, �����ȣ 2�ڸ��� ����ϰ� �������� ���� as ���� ��ȣ ,
select eno �����ȣ, rpad(substr(eno,2,2),4,'*') ������ȣ, ename ����, rpad(substr(ename,2,2),4,'*') �������� from employee;

--9.
select rpad(substr('880509-1000000',0,8),14,'*') "���� �ֹι�ȣ", rpad(substr('010-8998-7325',0,6),13,'*') "���� ��ȭ��ȣ" from dual;

--10.�����ȣ, ���ӻ�� �����ȣ(������ 0000)���ӻ��
select eno �����ȣ, nvl2(manager,manager,'0000') ���ӻ��,decode(substr(manager,0,2), 75 , 5555,
                                                               76, 6666,
                                                               77, 77777,
                                                               78, 8888,
                                                               substr(manager,0,2))  "��ȯ��ȣ"
from employee;
