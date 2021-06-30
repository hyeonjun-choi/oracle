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