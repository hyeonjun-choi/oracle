create table board(
b_no            number(9)                       --> �Խ��� �� ������ȣ

, subject       varchar2(50)    not null        --> �� ����
, writer        varchar2(30)    not null        --> ���� �̸�
, content       varchar2(2000)  not null        --> �� ����
, pwd           varchar2(12)    not null        --> ��ȣ -- ���� �Ǵ� ������ ����
, email         varchar2(30)                    --> �̸���

, reg_date      date            default sysdate --> �����
, readcount     number(5)       default 0       --> ��ȸ��    -update

, group_no      number(9)       not null        --> �Խ��� ���� �Ҽ� �׷��ȣ.        --���� �� ���
, print_no      number(9)       not null        --> ���� �׷��ȣ ������ ȭ�� ��� ���� ��ȣ.    --���� �� ���

, print_level   number(9)       not null        --> ���� �׷��ȣ ������ ��� �鿩���� ���� �ܰ� ��ȣ--�θ� �ڽ� ���� Ȯ�� ����

, primary key(b_no)
)

select * from board;

select
	x.cnt-rownum+1					"��ȣ", b.*
from
(
	select
		lpad( ' ', print_level*5, ' ' )||decode(print_no,0,'','��')||subject 	"������"
		, writer							"�۾��̸�"
		, to_char(reg_date, 'YYYY-MM-DD')				"�����"
		, readcount						"��ȸ��"
	from
		board
	order by
		group_no asc, print_no desc;
) b, (select count(*) CNT from board) x

commit;

select lpad


---
update
    employee
set
    salary = salary * 0.9
where
    emp_no in (
        select
        emp_no
        from
        (
        select
          rownum RNUM
          , zxcvb.*
        from (
          select emp_no
          from employee
          order by
          salary desc
          , decode(jikup, '����', 1, '����', 2, '����', 3, '�븮', 4, '����', 5, 6) asc
          , hire_date asc
          , decode(substr(jumin_num,7,1),'1','19','2','19','20')||substr(jumin_num,1,6) asc
        ) zxcvb where rownum <=5 ) where RNUM >= 2
    );



update
	employee
set
	salary = salary * 0.9
where
	emp_no in(
		select emp_no from ( select rownum RNUM, zxcvb.* from (

			select emp_no from employee
			order by
			salary desc
			, decode(jikup, '����', 1, '����', 2, '����', 3, '�븮', 4) asc
			, hire_date asc
			, decode(substr(jumin_num,7,1), '1', '19', '2', '19', '20')||substr(jumin_num,1,6) asc

		) zxcvb where rownum<=5 ) where RNUM>=2
	);

 update
	employee
set
	salary = salary * 0.9
where
	emp_no in(
		select emp_no from ( select rownum RNUM, zxcvb.* from (

			select emp_no from employee
			order by
			salary desc
			, decode(jikup, '����', 1, '����', 2, '����', 3, '�븮', 4) asc
			, hire_date asc
			, decode(substr(jumin_num,7,1), '1', '19', '2', '19', '20')||substr(jumin_num,1,6) asc

		) zxcvb) where RNUM<=5 and RNUM>=2
	);


select
	x.cnt-rownum+1					"��ȣ", b.*
from
(
	select
		lpad( ' ', print_level*5, ' ' )||decode(print_no,0,'','��')||subject 	"������"
		, writer							                                    "�۾��̸�"
		, to_char(reg_date, 'YYYY-MM-DD')			                        	"�����"
		, readcount					                                           	"��ȸ��"
	from
		board
	order by
		group_no asc, print_no desc;
) b, (select count(*) CNT from board) x


select
	(select count(*) from employee)-rownum+1	no_desc
	, rownum					no_asc
	, e.*
from
	employee e

select
	X.cnt-rownum+1				no_desc
	, rownum					no_asc
	, e.*
from
	employee e, (select count(*) from employee) X


select
	e.emp_name	"������"
	, e.jikup		"��������"
	, d.dep_name	"�ҼӺμ���"
	, s.sal_grade_no	"�������"
from
	employee e, dept d, salary_grade s
where
	e.dep_no=d.dep_no and (e.salary>=s.min_salary and e.salary<=s.max_salary)
order by
	s.sal_grade_no asc
	, decode(e.jikup, '����', 1, '����', 2, '����', 3, '�븮', 4, '����', 5, 6 ) asc
	, case when substr( e.jumin_num,7,1) in ('1', '2') then '19' else '20' end
	|| substr(e.jumin_num,1,6) asc;


select
	e.emp_name	"������"
	, e.jikup		"��������"
	, d.dep_name	"�ҼӺμ���"
	, s.sal_grade_no	"�������"
from
	(dept d inner join employee e on d.dep_no=e.dep_no) inner join
	salary_grade s on (e.salary between s.min_salary and s.max_salary);
order by
	s.sal_grade_no asc
	, decode(e.jikup, '����', 1, '����', 2, '����', 3, '�븮', 4, '����', 5, 6 ) asc
	, case when substr( e.jumin_num,7,1) in ('1', '2') then '19' else '20' end
	|| substr(e.jumin_num,1,6) asc;

--<96> ����������, ������������, ���ӻ����, ���ӻ������ ���<����> ����� �ִ� ������ ����
select
    e1.emp_name
    , e1.jikup
    , e2.emp_
    , e2,jikup
from
    employee e1, employee e2
where
    e1.mgr_emp_no=e2.emp_no;

-- �����ϱ�

-- employee ���̺��� ������ȣ, ������, �Ի���(��-��-��(����) �б� �ú���) �˻�
select
	emp_no
	, emp_name
	, to_char(hire_date,'YYYY-MM-DD Q AM HH:MI:SS'
	, 'nls_date_language = Korean')
from
	employee;
-- employee ���̺��� ������ȣ, ������, �Ի���(x��-x��-x��(����) x�б� x��x��x�� ) �˻��϶�
-- 1999��-12��-25��(ȭ) 4�б� 11�� 10�� 22��

-- employee ���̺��� ������ȣ, ������, �ٹ��ϼ�, �ٹ�������, �Ի���5�����ĳ�¥(��-��-��), �Ի��Ѵ��� ��������¥(��-��-��)
-- �Ի��ѳ�¥���ص��ƿ����Ͽ��ϳ�¥(��-��-��) �˻�
-- ��, �ٹ��ϼ��� �Ҽ� 2�ڸ����� �ݿø��Ұ�