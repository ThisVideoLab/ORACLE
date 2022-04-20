/* ���� �Լ�
ROUND : Ư�� �ڸ������� �ݿø�.
ROUND(���): �Ҽ����� ù��° �ڸ��� �ݿø��ع���
ROUND(���, �Ҽ��� �ڸ���)
    �Ҽ��� �ڸ����� ����� ��� : �Ҽ��� ���� ���������� �ڸ�����ŭ �̵��� �ڿ� �� ���� ���� �ݿø�.
    �Ҽ��� �ڸ����� ������ ��� : �Ҽ��� ���� �������� �ڸ�����ŭ �̵��� �ڿ� �� �ڸ� ���� �ݿø�.

TRUNC : Ư�� �ڸ������� �߶󳻼� ����
MOD : �Է¹��� ���� ���� ������ ������ �����
*/

-- ROUND: �Ҽ��� �ڸ����� ����� ����� �̵� ���
select 99.7564, ROUND (98.7654), round (98.7654,2) from dual; -- �Ҽ��� ���� 2�ڸ� ������ �̵�, �� �� ���� ������ 5�� ����.
                                                              -- �� ��� 98.77�� ��µ�.��������������������


-- ROUND: �Ҽ��� �ڸ����� ������ ����� �̵� ���
select ROUND (98.7654,-1) from dual; -- �Ҽ��� ���� 1�ڸ���ŭ �������� �̵��ϸ�,
                                     --  ���ڸ����� 8�� �ݿø��Ͽ� 100�� ���� ��� ��.
select ROUND (98.7654,-3) from dual; -- �Ҽ��� ���� 3�ڸ���ŭ �������� �̵��ϸ�,
                                     -- ���ڸ����� ���� �ݿø��ϴµ�, 0�̹Ƿ� �ݿø����� ���ϰ� ������ �� ��������.

-- TRUNC: ROUND�� �۵� ����� ������
select 98.7654 ��������, TRUNC(98.7654) as "turnc �⺻����", 
TRUNC(98.7654,2)as "turnc 2�Է�", TRUNC(98.7654,-1) as "turnc -1 �Է�"  from dual;

-- MOD (���, ������ ��) : ����� ����� ������ ���� �����.
SELECT mod (31,2), mod(31, 5), mod(31,8) from dual;

select *  from employee;

select salary, mod (salary, 300) from employee;

-- employee ���̺��� �����ȣ�� ¦���� �ο��鸸 �����

SELECT ename ����, eno �����ȣ
FROM employee
where mod(eno, 2) = 0;

select 12345.6789, round (12345.6789), round (12345.6789, -3) from dual;
 
/* ��¥ �Լ�

sysdate: �ý��ۿ� ����� ���� ��¥�� �����.
month_between: �� ��¥ ���̰� ��������� ��ȯ��.
add_month: Ư�� ��¥�� �������� ���Ѵ�.
next_day: Ư�� ��¥�� ���ʷ� �����ϴ� ���ڷ� ���� ������ ��¥�� ��ȯ��
*/

-- sysdate: �ڽ� �ý��� ������ ������� �����.
select sysdate from dual;

-- sysdate �� n: n�� ��ŭ �� �Ǵ� ���� ��¥�� �����.
select sysdate - 1 ������¥ , sysdate ���ó�¥, sysdate + 1 ���ϳ�¥ from dual;

-- ���������� ��¥�� ���õ� �Լ����, �ռ� sysdateó�� n ���� �߰� �Ǵ� ���� ������.
select ename ����,hiredate �Ի���, hiredate +365 �Ի�1�ֳ� from employee;

-- �� ������� �ٹ��� ���� �� ���ϱ�.
SELECT ename ����, hiredate �Ի���, trunc((sysdate - hiredate)/30) �ټӰ����� from employee;

-- months_between(data1, data2): data1�� data2 ������ �������� ���
SELECT ename ����, hiredate �Ի���, trunc(months_between (sysdate, hiredate)) �ټӰ����� from employee;

-- �� ������� �ټ� ��� ���ϱ�.
SELECT ename ����, hiredate �Ի���, trunc((sysdate - hiredate)/365) �ټӳ�� from employee;

-- Ư�� ���� �Ի��� �ο��� ���ϱ�: 12�� �Ի��� ���
SELECT ename ����, hiredate �Ի��� from employee where hiredate like '%/12/%';
SELECT ename ����, hiredate �Ի��� from employee where hiredate ('month')= 12;

-- trunck�� ��¥�� �����ϱ� : 01���̳� 01��, 01�� ���� �ʱⰪ���� ��µ�
select hiredate, trunc(hiredate, 'month') �Ի�� from employee;

-- round�� ��¥�� �����ϱ� : �Ⱓ�� ���� �̻��� �Ǹ� �ݿø� �Ǽ� �÷�����.
select hiredate, round(hiredate, 'year') �Ի�� from employee;

-- �л��� �� 6���� ���� ������ �����
SELECT hiredate, add_months (hiredate,6) from employee;


--next_day (data, '����'): date�� �����ϴ� ���Ͽ� ���� ��¥�� ����ϴ� �Լ�
select sysdate ����, next_day(sysdate, '�����') as"�̹��� �����" from dual;

--last_day(date): date�� �� ���� ������ ��¥.
select hiredate, last_day(hiredate) from employee; --�Ի���� ������ ���� �����

/* ����ȯ �Լ� (�ſ� �߿���)

TO_cHAR:  ��¥�� �Ǵ� ������ �����͸� ���������� ��ȯ�ϴ� �Լ�
TO_DATE: �������� ��¥������ ��ȯ�ϴ� �Լ�
TO_NUMBER: �������� ���������� ��ȯ�ϴ� �Լ�

*/

-- ��¥ �Լ� ����ϱ�
-- TO_CHAR(date, 'yymmdd') : ������ ���� �����Ӱ� ���� ������
select ename ����, hiredate �Ի���, to_char(hiredate, 'yyyymmdd') �Ի���2 from employee;
select ename ����, hiredate �Ի���, to_char(hiredate, 'yymmdd') �Ի���2 from employee;
select ename ����, hiredate �Ի���, to_char(hiredate, 'yydd') �Ի���2 from employee;
select ename ����, hiredate �Ի���, to_char(hiredate, 'yd') �Ի���2 from employee;

--��¥�� �Է� ������
select ename ����, to_char(hiredate, 'DaY') �Ի���� from employee;
select ename ����, to_char(hiredate, 'DY') �Ի���� from employee; --'DY'�� ������ ���

-- ���� �ý����� ���� ��¥�� ����ϰ� �ð� �ʱ��� �����.
select sysdate ����, to_char(sysdate, 'dy') ����, to_char(sysdate,'yymmdd hh:mi:ss') from dual;

desc employee;

select hiredate
from employee;

SELECT ename, hiredate, to_char(hiredate, 'yyyy-mm_dd hh:mi:ss') from employee;

/* TO_CHAR���� ���ڿ� ���õ� ����

0: �ڸ����� ��Ÿ���� �ڸ����� ���� ���� ��� 0���� ä��ϴ�.
9: �ڸ����� ��Ÿ���� �ڸ����� ���� ���� ��쿡�� ä���� �ʽ��ϴ�,
L: �� ������ ��ȭ ��ȣ�� ���
. : �Ҽ������� ǥ��
, : K ������ ������

*/

-- to_char(�÷���, 'L+�ڸ���): �÷��� ���ڸ� ����ϵ�, L(���� ��ȭ��ȣ ���)�� �Բ�
--                           ���ڰ� ���ִ� ��ŭ, 6�ڸ��� ����ϰ�, ���� �ڸ�����
--                           �ʰ��ϴ� ��쿡�� ä���� �ʴ� �ɼ��� ������.
SELECT ename ����, salary ����, to_char(salary, 'L999,999') from employee;
SELECT ename ����, salary ����, to_char(salary, 'L000,000') from employee;

-- ����� �ڸ����� �ʰ��ϸ� ��� ĭ�� ###���� ����Ǿ ��µ�. �̰� 0�� 9�� ������.
SELECT ename ����, salary ����, to_char(salary, 'L999') from employee;
SELECT ename ����, salary ����, to_char(salary, 'L000') from employee;

-- to_date('char', 'fornat'): ��¥ �������� ��ȯ
SELECT SYSDATE, trunc((SYSDATE - to_date('20000101', 'yyyymmdd'))/365) as "���(��)" FROM dual;

select sysdate ������,to_date('201010') ������, trunc((sysdate - to_date('201010'))/30) �ҿ䰳�� from dual;

select hiredate from employee;

select ename ����, hiredate �Ի��� from employee
where hiredate = '81/02/22';

select  ename,  hiredate 
from employee
where hiredate = to_date ('1981-02-22', 'yyyy-mm-dd') ;

-- 2000�� 12�� 25�Ϻ��� ���ݱ��� �� ����� ��������

select trunc((sysdate - to_date('2000-12-25'))/30) ��������� from dual;

-- to_number: number ������ Ÿ������ ��ȯ
select '100,000' - '50,000' from dual;

select to_number('100,000', '999,999') - to_number ('50,000', '999,999') as �Ž����� from dual;


-- NVL �Լ�: null�� �ٸ� ������ ġȯ���ִ� �Լ�
select ename, commission from employee;

select ename ����, nvl(commission, 0)���ʽ� from employee;

select ename ����, nvl(manager, 1111) "���ӻ�� ���" from employee;

--NVL �Լ�2

--nvl2 (Expr1, expr2, expr3): expr1 != null => expr2 ���
--                            expr1 == null => expr3 ���

select salary, commision from employee;

--nvl �Լ��� ���� ����ϱ�

select ename ����, salary "       ����        ",nvl(commission,0) "       ���ʽ�        " , (salary*12 + nvl(commission,0)) 
"       ����       " from employee;

--nvl2 �Լ��� ���� ����ϱ�
select ename ����, salary "       ����        ",nvl(commission,0) "       ���ʽ�        " ,
nvl2(commission,(salary*12)+commission, salary*12)"       ����       " 
from employee;

-- nullif : �� ǥ������ �豳�ؼ� ������ ���, null�� ��ȯ�ϰ� �������� ���� ��쿡�� 
--          ù��° ǥ������ ��ȯ��.

select nullif('A','A'), nullif('A','B') from dual; -- �� nullif�� null, �� nullif�� ���� ���� ����

-- nullif�� nvl2�� ȥ�� ��� -> ��ġ �ǵ���
select nvl2(nullif('A','A'),'����ġ','��ġ' ), nullif('A','B') from dual;


/* coalesce �Լ�

coalesce (expr1,expr2,expr3,....expr(n));
�������� ���������� üũ�ؼ� null���̸� �������� �Űܰ��鼭 ���� ���� ������ null�̿��� ���� �������.

*/

select coalesce ('abc','bcd','def','efg','fgh') from dual;
select coalesce (null,null,'def','efg','fgh') from dual;
select coalesce (null,null,null,'efg',null) from dual;

--coalesce�Լ��� Ȱ���� ���� ���
SELECT ename, salary ����, nvl(commission,0) ���ʽ�, coalesce(commission + salary*12, salary*12, 0) ���� from employee;

/* decode �Լ�

DECODE (ǥ����, ����1, ���1,
               ����2, ���2,
               ����3, ���3,
               �⺻���n
        )

*/

select ename ����, dno �μ���ȣ, decode(dno, 10, 'Accounting',
                                           20, 'Research',
                                           30, 'Sales',
                                           40, 'Operation',
                                           'Default') as �μ���
from employee;

--dno Į���� 10�� �μ� + 300 / 20�� �μ� +500 / 30�� �μ� + 500/
                          
select ename ����, dno �μ���ȣ,salary "�λ� �� ����", decode(dno, 10, 300,
                                                               20, 500,
                                                               30, 700,
                                                               'Default') "�λ��",

                                                   decode(dno, 10, salary + 300,
                                                               20, salary + 500,
                                                               30, salary + 700,
                                                               'Default') "�λ� �� ����"
from employee;             


-- case: 
~ else if, else if ~~
/*

case ǥ���� when ����1 then ���1
           when ����2 then ���2
           when ����3 then ���3
           else ���n
           end
*/

select ename ����, dno �μ���ȣ, case when dno = 10 then 'Accounting'
                                    when dno = 20 then 'Research'
                                    when dno = 30 then 'Sales'
                                    when dno = 40 then 'Operation'
                                    else 'Default'
                                    end as �μ���

from employee
order by dno;