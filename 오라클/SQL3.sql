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
          , decode(jikup, '사장', 1, '부장', 2, '과장', 3, '대리', 4, '주임', 5, 6) asc
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
			, decode(jikup, '사장', 1, '부장', 2, '과장', 3, '대리', 4) asc
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
			, decode(jikup, '사장', 1, '부장', 2, '과장', 3, '대리', 4) asc
			, hire_date asc
			, decode(substr(jumin_num,7,1), '1', '19', '2', '19', '20')||substr(jumin_num,1,6) asc

		) zxcvb) where RNUM<=5 and RNUM>=2
	);


select
	x.cnt-rownum+1					"번호", b.*
from
(
	select
		lpad( ' ', print_level*5, ' ' )||decode(print_no,0,'','ㄴ')||subject 	"글제목"
		, writer							                                    "글쓴이명"
		, to_char(reg_date, 'YYYY-MM-DD')			                        	"등록일"
		, readcount					                                           	"조회수"
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
	e.emp_name	"직원명"
	, e.jikup		"직원직급"
	, d.dep_name	"소속부서명"
	, s.sal_grade_no	"연봉등급"
from
	employee e, dept d, salary_grade s
where
	e.dep_no=d.dep_no and (e.salary>=s.min_salary and e.salary<=s.max_salary)
order by
	s.sal_grade_no asc
	, decode(e.jikup, '사장', 1, '부장', 2, '과장', 3, '대리', 4, '주임', 5, 6 ) asc
	, case when substr( e.jumin_num,7,1) in ('1', '2') then '19' else '20' end
	|| substr(e.jumin_num,1,6) asc;


select
	e.emp_name	"직원명"
	, e.jikup		"직원직급"
	, d.dep_name	"소속부서명"
	, s.sal_grade_no	"연봉등급"
from
	(dept d inner join employee e on d.dep_no=e.dep_no) inner join
	salary_grade s on (e.salary between s.min_salary and s.max_salary);
order by
	s.sal_grade_no asc
	, decode(e.jikup, '사장', 1, '부장', 2, '과장', 3, '대리', 4, '주임', 5, 6 ) asc
	, case when substr( e.jumin_num,7,1) in ('1', '2') then '19' else '20' end
	|| substr(e.jumin_num,1,6) asc;

--<96> 부하직원명, 부하직원직급, 직속상관명, 직속상관직급 출력<조건> 상관이 있는 직원만 포함
select
    e1.emp_name
    , e1.jikup
    , e2.emp_
    , e2,jikup
from
    employee e1, employee e2
where
    e1.mgr_emp_no=e2.emp_no;

-- 연습하기

-- employee 테이블에서 직원번호, 직원명, 입사일(년-월-일(요일) 분기 시분초) 검색
select
	emp_no
	, emp_name
	, to_char(hire_date,'YYYY-MM-DD Q AM HH:MI:SS'
	, 'nls_date_language = Korean')
from
	employee;
-- employee 테이블에서 직원번호, 직원명, 입사일(x년-x월-x일(요일) x분기 x시x분x초 ) 검색하라
-- 1999년-12월-25일(화) 4분기 11시 10분 22초

-- employee 테이블에서 직원번호, 직원명, 근무일수, 근무개월수, 입사후5개월후날짜(년-월-일), 입사한달의 마지막날짜(년-월-일)
-- 입사한날짜기준돌아오는일요일날짜(년-월-일) 검색
-- 단, 근무일수는 소수 2자리에서 반올림할것