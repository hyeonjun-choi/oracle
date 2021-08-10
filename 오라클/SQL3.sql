/*
�����ͺ��̽�  - �˻��� ������ ������ ���ؿ� ���߾� �ڷḦ �з�, ������ ���� '�ڷ��� ����'
�����ͺ��̽� ����   - �ǽð� ���ټ�, �������� ��ȭ(=�ֽ��� ������ ��Ȯ�ϰ� ����), ���� ���� ��
                - ������ ���信�� ���� ���� �����ͺ��̽���� �θ��� ��ƴ�.

RDBMS ������ �����ͺ��̽� ���� �ý���?
- �����Ͱ� �÷�(column - ��)�� �ο�(row - ��)�� �̷���� ���̺�(table)�� ����Ǹ�,
���̺�� ���̿� ���谡 �����Ͽ� �����ϴ� �ý���


�뷫���� ����
                   customer                            => ���̺��
------------------------------------------
����ȣ      ����        �ּ�       ��ȭ��ȣ               =>column ��
------------------------------------------
  1         ���Ȱ�        ����      02-1234-1234          =>row(��)
------------------------------------------
  2         �����        �λ�      02-2345-2345          =>row(��)
------------------------------------------
  3         �տ���        ����      02-3456-3456          =>row(��)
------------------------------------------
  ��           ��          ��            ��
column      column      column      column
 (�÷�)       (�÷�)       (�÷�)        (�÷�)
  (��)        (��)         (��)          (��)


SQL -- RDBMS�� �����Ͽ� �������� �Է�, ����, ����, �˻� ���� ����� ���� RDBMS ���� ���
'������ ���'

SQL ����

<15������ ���� ����Ǯ�� ���� ����>

<>�ϳ��� ���̺����� ��� �÷�, ���� �����͸� �˻��ϱ� ���� ����
==
select ��� column�� from ���̺�
�Ǵ�
select * from ���̺�(*���� create ���� �״�� ����)

ex)
15�� employee ���̺��� ��� �÷�, ��� ���� �����͸� �˻��ϸ�?

select * from employee
select
	emp_no
	, emp_name
	, dep_no
	, jikup
	, salary
	, hire_date
	, jumin_num
	, phone_num
	, mgr_emp_no
from
	employee;

<> ���̺��� �˻� ����� ��Ī�� �߰��ϴ� ���

�ۼ��Ǵ� ��ü ���̺� ǥ���� �÷��� ���� "�÷���"�� �ѱ۷� ǥ�������μ� ��Ī(alias)�� �߰��Ѵ�.

<> �˻� ����� Ư�� ���ڸ� �߰��ؼ� ��Ÿ���� ���

�ְ��� �ϴ� Į�� ���� ||�߰� �� �̱���Ʈ'�����' ���� ������� �ۼ�

ex)
16. employee ���̺��� emp_no, emp_name, jikup, hire_date�� �˻��ϸ鼭 ��Ī(= alias), ��,
����� �ٿ� �����ȣ, ������, ����, ����, �Ի��Ϸ� �ϰ� ������ '����'�̶� ���ڸ� �ٿ� �˻�

select
	emp_no		          ������ȣ  ------------------  ���̺� �� �����Ͱ� �ƴϹǷ� ���� ��Ʈ�� ���
	, emp_name	          "���� ��"  ------------------ �����ϸ� ������ ������Ʈ ���
	, jikup		          "����"    ------------------ as ���� ����
	, salary||'����'		 "����"    ------------------ ��Ī�� ���� ������ �����ڵ� ���� ����
	, hire_date 	      "�Ի���"  ------------------ ����Ŭ���� ���Ῥ���ڴ� +�� �ƴ϶� ||�̴�. �ڹٿ� �ٸ�.
from
	employee;

<> ���̺��� Ư���� ������ ��� �ϴ� ���

����ϰ��� �ϴ� number �ڷ��� �÷��� �����ȣ(ex; *)���� ���� �����Ѵ�

ex)

employee ���̺��� ������, ����, ����, ����, �Ǽ��ɾ��� �˻��ϸ�? (������ ������ 12%)

select
    emp_name                "������"
    , jikup                 "����"
    , salary                "����"
    , salary*0.12||'����'    "����"
    , salary*0.88||'����'    "�Ǽ��ɾ�"
from
    employee;

<>���̺��� �ߺ��� ���ִ� ���

select <distinct> �÷� from ���̺� ������

ex) select distinct jikup from employee;

ex) eslect distinct jikup, dep_no from employee

<> Ư�� ���ڹ����� Į���� ������ �Ŵ� ��

���� where�� �߰��ϰ� ������ �߰��� �÷���� ���ǳ����� �Բ� �߰��Ѵ�.

ex) select * from employee where salary >= 3000

<> ��������, �������� ǥ��

��������, �������� ǥ���� ���� ���� asc/ desc �� ����Ѵ�.
��� ������ select �÷� from ���̺� <order by �������� �÷� asc/desc>
��, oreder by�� �ʿ��ϴ�.

ex) employee ���̺��� ���� ������������ �˻��ϸ�

select * from employee order by salary  asc;
                                --- <���� ������ �ٲٰ��� �� �� Ű����>
select * from employee order by salary; ---- asc ���� ����

select * from employee order by 5 asc; ----order by �ٷ� �� column �� ��� �ش� column�� ��ȣ�� �ĵ� ����

select * from employee order by 5;

ex) employee ���̺��� ���� ������������ �˻��ϸ�?

select * from employee order by salary desc; ---- ��������. ���� �Ұ���

select * from employee order by 5 desc;

ex) employee ���̺��� �μ���ȣ ���������� �����ϸ鼭 ������ ������������ �˻�

select * from employee order by dep_no asc, salary desc;

select * from employee order by dep_no, salary desc; -- asc������ �����ϳ� ��ü�� �����ϰ� ���� ���ɼ� ����

<> �������� �ƴ� ������ �÷����� ���� �����ϰ��� �Ҷ�

�ΰ��� �����ϴ� ���ذ� ����Ŭ�� ���ı����� �ٸ��� ������ ���� ���ǹ��� ���� ������ ������ ������� �Ѵ�.
�ٲٱ� ���� �߰��ϴ� �������� order by <decode(�÷���, '�÷� �� ������1', 1, '�÷� �� ����Ŀ2', 2,~~~ alary desc;>

ex) employee ���̺��� ������ ���� ������� �����ؼ� �˻��ϸ�

select * from employee order by jikup asc;
select * from employee order by jikup desc;
�ڵ� �� �߸��� ����
���޼����� �ΰ��� �����ϴ� ���ذ� ����Ŭ�� ���ı��ذ� �ٸ��� ����
���� ���ǹ��� ���� ������ ������ �ٲ�� ��

select * from employee order by decode( jikup , '����' ,1, '����' ,2, '����' ,3, '�븮' , 4), alary desc;
<���> ���� �䱸������ ���� select���� �ۼ��ϴ� �� ���� �߿�������,
	�̹� �ۼ��� select���� ���� ���� �䱸�� �˾Ƴ��� �� ���� �߿���.

<> Ư�� �÷��� ���� �˻��ϰ��� �Ҷ�

where �� Ȱ��
where ���� ã�� ��ġ �÷���� =, ã�� �����͸��� ���´�
and �Ǵ� or, Ȥ�� >=, <=�� ���� ��ȣ ��� ����  �߰������� �� �ٱ⵵ �Ѵ�.



ex) select * from employee where jikup = '����'

ex) select * from employee where dep_no = 20 and jikup = '����'

ex) select * from employee where dep_no = 20 or jikup = '����'

ex) select * from employee where jikup = '����' and salary >= 3400

ex) select * from employee where  salary*0.88>=4000;


ex) employee ���̺��� ������ ���� ���� ���� ���� ������ �����ϸ鼭 �μ���ȣ�� ���������̸鼭 ������ �ƴ��������� �˻�

select * from employee where jikup != '����' order by salary*0.12 desc, dep_no desc;

// ������ �ƴ� ������ ã�ƾ� �ϹǷ� jikup�� !='����'�� �ٿ� ���� ������ ���ܽ�Ű�� ������ �߿���
// ������ ���� ���� ������ �μ���ȣ�� ���������� �ϴ� ���̹Ƿ�
// order by�� ���ʴ�� ���Ľ�Ű�� ���� desc�� ���̸� �ȴ�.

ex) employee ���̺��� 20��° �μ� �߿��� ���� 2000~3000 ���� �˻�

select * from employee where dep_no=20 and salary>=2000 and salary<=3000;    2000<=salary<=3000 - �ȵ�

select * from employee where dep_no=20 and salary between 2000 and 3000; <����>

<> ���̺��� null���� ã�� ��

�ش� �÷� ���� �����Ϳ��� null�� ã�� �� =�� ���� ����

ex) employee ���̺��� ���ӻ���� ���� ���� �˻�

select * from employee where mgr_emp_no = null

select * from employee where mgr_emp_no is null

<����> null���� ã�� �� = �� ���� ����

ex ) employee ���̺��� ���ӻ���� �ִ� ���� �˻�

select * from employee where mgr_emp_no is not null

<> [�׷��Լ�], �Ǵ� [�����Լ�] �� Ȱ��

min, max, avg, sum, count �Լ����� �θ��� ��Ī. �̵��� �ַ� group by�� ���� ���� ���δ�
���� null���� �����ϰ� ����Ѵ�.
count(�÷���) => �÷����� null�� �ƴ� �������� ������ �����Ѵ�.
count(*)	      => ���� ������ �����Ѵ�.

ex, select count (cus_no) from customer;

ex) employee ���̺��� [�ּ� ����], [�ִ� ����], [��� ����], [���� ����], [�� �ο���]�� �˻��ؼ� ���

select
	min( slalry )	as "�ּ� ����"  -- salary �÷����� �ּҰ��� ����
	,max( salary )	as "�ִ� ����"  -- salary �÷����� �ִ밪�� ����
	,avg( salary )	as "��� ����"  -- salary �÷����� ��հ��� ���� <����> avg ��� �� null ������ ���� �� ������, ������ ���������� ������
	,sum( salary )	as "���� ����"  -- salary �÷����� ������ ����
	,count( * )    	as "�� �ο���"  -- count( * )�� ������ ���� --
from
	employee;

<> count ���

ex) ���� ����ϰ� �ִ� ���� ���

select count(distinct emp_no) from customer;

ex) ��� ������ �ִ� ���� ���

select count (emp_no) from customer;

���� ��ȣ�� ������ �ǹ̰� distinct�� ���������� ���� �޶����� �ȴ�. �ؼ��� �ǹ̰� �޶����� �ǹǷ� �����ؾ� �Ѵ�.
distinct �÷��� => �÷� ���� ������ �� �ߺ��� ����
<����> count���� ������ Ư¡�� ���� �־� ������ �������Ѵ�.
		  ||
���� �پ��ϰ� ������ �䱸����

ex) ���ӻ���� �ִ� ������ ���

select count(mgr_emp_no) from employee;

<����>mgr_emp_no �÷� ���� �����Ͱ� ���� ���� �ľ��ؾ��Ѵ�. �ٷ� ���� ����� ������ȣ�̴�.

ex) ���������� �ִ� ������ ���

select count(distinct mdr_emp_no) from employee;

<> ����Ŭ�� �ε��� ��ȣ�� ����
<> substr(�÷���, ������ ���ۼ�����ȣ, ������ ����) => ���ۼ�����ȣ ���� �����Ұ��� ��ŭ �����ؼ� ����

ex) employee ���̺��� [������ȣ], [������], [���Ͽ�-������]�� �˻��ؼ� ���

select
    emp_no                                                  "������ȣ"
    ,emp_name                                               "������"
    ,substr(jumin_num, 3, 2)||'-'||substr(jumin_num,5,2)    "���Ͽ���"
from
    employee;

substr ������ ||'-'|| ������ ���� ���ϴ� �ڸ��� ����� �޴´�
|| = ���ڿ��� ��ġ�� ��ȣ(������)�� �̱���Ʈ�� ���μ� ���ڿ��� ����ϴ� '-'�� �� �� substr������ ��ġ�� ������� ���δ�.

ex) customer ���̺��� ��� �÷�, ��� ���� �˻��ؼ� ���. ��, �ֹι�ȣ�� 901225-2****** ���·� ����Ұ�

select
    cus_no
    , cus_name
    , tel_num
    , substr(jumin_num,1,6)||'-'||substr(jumin_num,7,1)||'******'
    , emp_no
from
    customer;
<����> '��� ��' �̶� ���� ������ where���� ����.

*****substr(�÷���, ������ ���ۼ�����ȣ, �����Ұ���) => ���ۼ�����ȣ ���� �����Ұ��� ��ŭ �����ؼ� �����ϱ�
						��û�� ���󵵸� �ڶ��Ѵ�.
||  ==> �¿��� ���ڿ��� ���̴� ������, �� ���� �������̴�.
<����> ����Ŭ���� + �� ���Ῥ���ڰ� �ƴ϶� ��Ģ�������̴�.

<> �ڵ�����ȯ Ȱ�뿡 ���� ����

��nvl( �÷���, null���϶� ��ü������)

 -- null�� ó�� �Լ�. �÷��� ���� �����Ͱ� null�� �ƴϸ� �׳� �����ϰ�,
  null�� �̸� null����ü�����͸� �����ϴ� [nulló�� �����Լ�]�̴�.

ex) customer ���̺��� ����ȣ, ����, ���������ȣ �� ����ϸ�?
��, ���������ȣ�� ������ null ������� ���� '����' ���� ǥ��

<�ڵ� �� ��ȯ Ȱ��>
select
    cus_no
    ,cus_name
    ,nvl(emp_no||'','����')
from
    customer;
-----------------------------------
<����>
select
    cus_no
    ,cus_name
    ,nvl(to_char(emp_no),'����')
from
    customer;

nvl���� ����
���� : nvl( to_char(�÷���),'null���϶� ��ü�� ���ڵ�����')
      ������ ������ �÷��� ��� ���������� �ٲ��ֱ� ���� to_char�� ����

��nvl2( �÷���, null�� �ƴҶ� ��ü ������, null�� �϶� ��ü ������ )

-- �÷��� ���� �����Ͱ� null�� �ƴϸ� null�� �ƴҶ� ��ü�����ͷ� ����ϰ�
null�̸� null���϶� ��ü�����͸� �����ϴ� [null ó�� �����Լ�] �̴�.

ex) customer ���̺��� ����ȣ, ����, ����������翩�� �� ����ϸ�?
��, ������ȣ�� ������ '����', ������ '����'���� ǥ��

select
    cus_no
    , cus_name
    , nvl2(emp_no, '����', '����')
from
    customer;

<> case ~ end ���� ���� ����

<����1>
��case (�÷���(���Ϲ������� ���ϴ� ������ ���� ��� ���� substr�� ���� ����ϴ� ��찡 ������ �̶���
substr������ �÷��� ���� �� ��ȣ�� ������ �ȴ�))
	when ������1 then ���ϰ�1
	when ������2 then ���ϰ�2
	~
	else ���ϰ�n
end

�÷��� ���� �����Ͱ� ������1�� ������ ���ϰ�1�� ����
�÷��� ���� �����Ͱ� ������2�� ������ ���ϰ�2�� ����
~
�� �ܿ��� ���ϰ�n�� �����ϱ�

<����2>
��case (�÷����)
	when �÷��� = ������1 then ���ϰ�1
	when �÷��� = ������2 then ���ϰ�2
	~
	else ���ϰ�n
end


�÷��� ���� �����Ͱ� ������1�� ������ ���ϰ�1�� ����
�÷��� ���� �����Ͱ� ������2�� ������ ���ϰ�2�� ����
~
�� �ܿ��� ���ϰ�n�� �����ϱ�

����2 ���� = ��ſ� �ʿ信 ���� >=, >, <, <=, != ���� �񱳿����ڵ� ����� �� �ִ�.
�ʿ信 ���� else ���ϰ�n�� ������ �� �ִ�.

decode(~) ������ ���� ����

decode(
	���÷���  -- decode�� ��� ���ۺ��� ��ȣ�� �־��༭ substr�� ��ȣ �ȿ� ������
	, �񱳵�����1, ���ϰ�1
	, �񱳵�����2, ���ϰ�2
	, ~
	, ���ϰ�n
)


�÷��� ���� �����Ͱ� ������1�� ������ ���ϰ�1�� ����
�÷��� ���� �����Ͱ� ������2�� ������ ���ϰ�2�� ����
~
�� �ܿ��� ���ϰ�n�� �����ϱ�


�ʿ信 ���� �׿� ��� ���ϰ�n�� ������ �� �ִ�.

decode ���� =
 ����Ŭ�����ۿ� ������ ����Ŭ �����Լ�. case ~ end ������ ��� DB���� ��밡���ϴ�.
 '����'��� ���ǿ����� ��� ����
-----------------------------------------------------------------------------------------------------------
�� �ڸ������� ������ �ִ��� �˱� ��Ʊ� ������ ��뿡 �����ؾ�

case = ��� �����ͺ��̽����� ��� ����

case substr(�÷���, ī���ؿ� �������� ���۹�ȣ, ����) when A then B (else) end

ex) employee ���̺��� ������ȣ, ������, ����, <����> �� ����ϸ�...

select   -----  when ~ then ~ end����(�ʹ� ���)
    emp_no
    ,emp_name
    ,jikup
    ,case
       substr(jumin_num,7,1)
       when '1' then '��'
       when '3' then '��'
       when '2' then '��'
       when '4' then '��'
    end
from
    employee
----------------------------------------------------------------------------------------------------------------------------------
select  ----- when ~ then ~ else ~ end (when then ó�� �� �������� else��)
	emp_no
	, emp_name
	, jikup
	, case
		substr(jumin_num,7,1)
		when '1' then '��'
		when '3' then '��'
		else '��'
	end
from
	employee
----------------------------------------------------------------------------------------------------------------------------------
 select  -----  when then else end(substr�÷��� when �ڷ� ��, �ε�ȣ ���� ���)
	emp_no
	, emp_name
	, jikup
	, case
		when substr(jumin_num,7,1)='1' then '��'
		when substr(jumin_num,7,1)='3' then '��'
		else '��'
	end
from
	employee
----------------------------------------------------------------------------------------------------------------------------------
select ----- decode substr�÷� '','','','',''(end ����, else ����, when then ����)
	emp_no
	, emp_name
	, jikup
	, decode(
		substr(jumin_num,7,1),'1','��','3','��','��')
from
	employee

ex) employee ���̺��� ������ȣ, ������, ����, <����⵵> ���

select
	emp_no
	, emp_name
	, jikup
	, case
		when substr( jumin_num,7,1)='1'then'19'||substr(jumin_num,1,2)
		when substr( jumin_num,7,1)='2'then'19'||substr(jumin_num,1,2)
		when substr( jumin_num,7,1)='3'then'20'||substr(jumin_num,1,2)
		when substr( jumin_num,7,1)='4'then'20'||substr(jumin_num,1,2)
	end
from
	employee;
-------------------------->>>
select
	emp_no
	, emp_name
	, jikup
	, case
		when substr( jumin_num,7,1)='1'then'19'
		when substr( jumin_num,7,1)='2'then'19'
		else '20'
		end || substr(jumin_num,1,2)
from
	employee;
--------------------------->>>
select
	emp_no
	, emp_name
	, jikup
	, decode (substr(jumin_num,7,1),'1','19'||substr(jumin_num,1,2),'2','19'||substr(jumin_num,1,2),'20'||substr(jumin_num,1,2))
	, decode (substr(jumin_num,7,1),'1','19','2','19','20')||substr(jumin_num,1,2) <= ���� ����
from
	employee;

ex) employee ���̺��� ������ȣ, ������, ����, ������(4�ڸ�)�� ���

select
    emp_no
    , emp_name
    , jikup
    , case
    when substr(jumin_num,7,1)='1'then'19'
    when substr(jumin_num,7,1)='2'then'19'
    else '20'
    end||substr(jumin_num,1,1)||'0���'
from
    employee;
----------------------------------------------------
select
    emp_no
    , emp_name
    , jikup
    , decode(substr(jumin_num,7,1),'1','19','2','19','20')||substr(jumin_num,1,1)||'0���')
from
    employee;

ex) employee ���̺��� ���̼����� ���(�����ڰ� ���� ��������)

select * from employee order by
    case
    when substr(jumin_num,7,1)='1'then'19'
    when substr(jumin_num,7,1)='2'then'19'
    else '20'
    end||substr(jumin_num,1,6)asc;

���̺� �� ���Ŀ� order by�� �ְ� case when ������ �־� ���Ľ�Ų��.(��������, �������� ���� ��)

rder by �ڴ� ���� ���� �÷��� ���´�. ���� ���� �÷��� case�� ���� �ȾƼ� �ٸ� ���·� �ٲ� ���̴�.

order by ������ ����

order by �÷��� | �÷�������ȣ | �÷��˸��ƽ� [asc] | desc

ex) employee ���̺��� ���޼������ �����Ͽ� ��� �÷��� ���̰�

select * from employee order by
	case jikup
		when '����' then 1
		when '����' then 2
		when '����' then 3
		when '�븮' then 4
		when '����' then 5 else 6
	end
	asc;

������ �����Ϳ� ������ �ο����ֱ� ���� �� ���� �����Ϳ� ���ڸ� ���ʴ�� �ο����� �� �������ش�
case (���ڵ�����)�÷� when '������1' then 1 ~~~~~~~~~~~~ end asc/desc;

order by �ڴ� ���� ���� �÷��� ���´�. ���� ���� �÷��� case�� ���� �ȾƼ� �ٸ� ���·� �ٲ� ���̴�.

���� �� ������ 1�� ����, ������ 2�� ����, ������ 3���� ����, �븮�� 4�� ����, ������ 5�� ���� ��Ÿ�� 6���� ����
������������ ����. ��, ������ ������ �ٲ㼭 ������ �� ���̴�.

��asc�� desc�� �ٲٸ� ������ ���� ����� ���� ���´�

<> �Ի���(��-��-��(����) �б� �ú���) ����ϴ� ���

to_char( ��¥ �Ǵ� ���� �÷�, '��½� ���ϴ� ��������' )

���ڵ����Ͱ� �ƴ� �����͸� �ۼ��ڰ� ���ϴ� �����ͷ� ��ȯ�� �� �ʿ�.

������ ��¥ �Ǵ� ���ڸ� ���ϴ� ��¹������� ���� �ٲپ� �ִ� ��ȯ�Լ��� ����
�ַ� ����ұ� ���� ���.

YYYY 	=> �⵵ 4�ڸ�
MM  	=> �� 2�ڸ�
DD   	=> �� 2�ڸ�
AM HH	=> ���� | ���� 1~12 ������ �ð�
HH24 	=> 0~23 ������ �ð�
MI	=> 0~59 ������ ��
SI	=> 0~59 ������ ��
DAY	=> ���� ���� Ǯ����
DY 	=> ���� ���� ���
Q 	=> 1~4 ������ �б�

to_char(hire_date, 'YYYY-MM-DD')
hire_date �÷� ���� �����͸� ��-��-�� ������ ���ڿ��� �ٲپ� �����϶�

ex) employee ���̺��� ������ȣ, ������, �Ի���(��-��-��(����) �б� �ú���) �˻�

select
    emp_no
    , emp_name
    , to_char(hire_date,'YYYY-MM-DD Q AM HH:MI:SS'
    , 'nls_date_language = korean')
from
    employee;

select
	emp_no
	, emp_name
	, to_char(hire_date,'YYYY-MM-DD(D(A��������)Y) Q<�б�> AM<����. ���Ĵ� PM �Ǵ� HH24> < HH:MI:SS<�ú���>'
	, 'nls_date_language = Korean')
from
	employee;

ex) employee ���̺��� ������ȣ, ������, �Ի���(x��-x��-x��(����) x�б� x��x��x�� ) �˻��϶�
1999��-12��-25��(ȭ) 4�б� 11�� 10�� 22��

select
    emp_no
	, emp_name
	, to_char(hire_date,'YYYY')||'��'
		|| to_char(hire_date, 'MM')||'��'
		|| to_char(hire_date, 'DD') ||'��'
		|| to_char(hire_date, '(DY)', 'nls_date_language = Korean')
		|| to_char(hire_date, 'Q' ) || '�б�'
		|| to_char(hire_date, 'AM HH' ) || '��'
		|| to_char(hire_date, ' :MI' ) || '��'
		|| to_char(hire_date, ' :SS' ) || '��'
from
	employee;
------------------------------------------------------------------------------
select
	emp_no
	, emp_name
	, to_char(hire_date, 'YYYY"��"MM"��"DD"��"(DY) Q"�б�" AM HH"��"MI"��"SS"��" ' , 'NLS_DATE_LANGUAGE = KOREAN' )
from
	employee;

1> ���� ���� �з��ؼ� �ϳ��ϳ��� ��� ��������ְų�
2> �ѹ��� �̾ �ϼ������ִ� ����� �ִ�.

��ȭ) 50) employee ���̺��� ������ȣ, ������, ���� �˻�

select
    emp_no
    , emp_name
    , to_number( to_char( sysdate,'YYYY'))
    -
    to_number(
        (case substr(jumin_num,7,1)when'1'then'19'when'2'then'19'else'20'end||substr(jumin_num,1,2)+1||'��'
    from
        employee;
------------------------------------------------------------------------------------------------------------
sysdate -- ���ó� ���� �ð�
���� ���ϴ� ��� ���ó�¥ - (���� �ð����� ���̺� ����� ��¥������)

51) employee ���̺��� ������ȣ, ������, �ٹ������� �˻� ���

select
    emp_no
    , emp_name
    , ceil( (sysdate-hire_date)365)||'����'
      <���ó�¥���� �Ի��� ��¥������ ���̸� �ϼ��� ���� ���� 365�� ���� �� �Ҽ� ù° �ڸ����� ������ �ø�>
from
    employee;

52) employee ���̺��� ������ȣ, ������, ���ɴ븦 �˻��ؼ� ����ϸ�

select
    emp_no
    , emp_name
    , floor( (to_number( to_char(sysdate, 'YYYY') )-
    to_number( case substr( jumin_num,7,1) when '1' then '19' when '2' then '19' else '20' end||substr(jumin_num,1,2)
    )+1 )*0.1)||'0��'
from
    employee;

���ɴ� ���ϱ� -- ���� ���ϱ�� ����� �������� ��Ȯ�� ���ɴ� ������ ���� �Ҽ� ù° �ڸ����� ������ �����ؼ� �����ϴ� floor�� ��ü������ �����ش�.
�ڿ���Ŭ�� ��¥-��¥ �� ������� ��¥���̸�ŭ�� �ϼ��̴�
ceil(~)  	=> �Ҽ� ù° �ڸ����� ������ �ø��ؼ� �����ϴ� ���� �Լ��� �����̴�. (���� �ڷ����� Į���� ����Ȱ�)
floor(~) 	=> �Ҽ� ù° �ڸ����� ������ �����ؼ� �����ϴ� ���� �Լ��� �����̴�.

<����> ����Ŭ�� ��¥ �����Ϳ��� ��¥ �����͸� ���� �� ���̸�ŭ�� �� ���� �����ϴ� Ư¡ ����.(���� �Լ��� ���� ����)
	���ϴ� �� �ƿ� ����.

53) employee ���̺��� ������ȣ, ������, 100����ġ ��¥�� �˻��ؼ� ����ϸ�

select
    emp_no
    ,emp_name
    ,to_char(to_date(case when substr(jumin_num,7,1)in('1','2')then'19'else'20'end||substr(jumin_num,1,6),'YYYYMMDD')+100
    ,'YYYY-MM-DD')
from
    employee;

to_char//to_date==�� �������� ���� ���Ǿ����� �������̴�
to_char -- �ַ� Ư�� ���� �������� ������Ű�� ����
to_date -- ��¥�� ��ȯ���� ������ ���ϰų� ���ų�, Ȥ�� ��¥���� ���� ���� (��¥���� ���ϴ� ���� ����)

��¥ + ���� 	==> ��¥�� ������ŭ�� �ϼ��� ���� ��¥�� ����
��¥ - ���� 	==> ��¥�� ������ŭ�� �ϼ��� �� ��¥ ����
��¥1-��¥2 	==> ��¥1�� ��¥2 ������ ���̸� �ϼ��� ����. �ϼ� ����� ��¥1�� ��¥2���� ū ��(���� �ݴ�)
��¥1+��¥2	==> ����


������� 1. 100�� ���ϱ� ���� ��¥�� �ٲٰ� 2. 'YYYY-MM-DD'ȭ �ϱ� ���� ���ڷ� �ٲ�

54) �������� 2021�� 5�� 12�� �̰� �������� 2021�� 11�� 10�� �̴�. ���� ���� �п� ��Ȱ

select
    to_date('20211110','YYYYMMDD')-to_date('20210512','YYYYMMDD')
from
    dual;

dual(���� ȣ�� ���� ���̺�)
