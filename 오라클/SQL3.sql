create table board(
b_no            number(9)                       --> 게시판 글 고유번호

, subject       varchar2(50)    not null        --> 글 제목
, writer        varchar2(30)    not null        --> 저자 이름
, content       varchar2(2000)  not null        --> 글 내용
, pwd           varchar2(12)    not null        --> 암호 -- 수정 또는 삭제를 위해
, email         varchar2(30)                    --> 이메일

, reg_date      date            default sysdate --> 등록일
, readcount     number(5)       default 0       --> 조회수    -update

, group_no      number(9)       not null        --> 게시판 글의 소속 그룹번호.        --정렬 시 사용
, print_no      number(9)       not null        --> 같은 그룹번호 내에서 화면 출력 순서 번호.    --정렬 시 사용

, print_level   number(9)       not null        --> 같은 그룹번호 내에서 댓글 들여쓰기 레벨 단계 번호--부모 자식 관계 확인 가능

, primary key(b_no)
)

select * from board;

select
	x.cnt-rownum+1					"번호", b.*
from
(
	select
		lpad( ' ', print_level*5, ' ' )||decode(print_no,0,'','ㄴ')||subject 	"글제목"
		, writer							"글쓴이명"
		, to_char(reg_date, 'YYYY-MM-DD')				"등록일"
		, readcount						"조회수"
	from
		board
	order by
		group_no asc, print_no desc;
) b, (select count(*) CNT from board) x

commit;

select lpad