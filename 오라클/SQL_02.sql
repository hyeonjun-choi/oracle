/*
-------------------------
--- king 계정 만들기
--- create user king identified by k123;
--------------------------
--- king 계정에 system과 비슷한 권한 주기
--------------------------
---grant connect, resource, dba to king;


select floor(-3.1) from dual;


-------------------------------------
---emp_sq 시퀀스 제거
---cus_sq 시퀀스 제거
---dept 테이블 제거
---employee 테이블 제거
---customer 테이블 제거
---salary grade 테이블 제거
-------------------------------------
drop table dept;
drop table employee;
drop table customer;
drop table salary_grade;
drop sequence cus_sq;
drop sequence emp_sq;
*/


-----------------------------
----dept 테이블 만들기
-----------------------------
create table dept(
 dep_no     number(3)                       ----부서번호 저장 컬럼 선언. 자료형은 숫자형.
 ,dep_name  varchar2(20)    not null unique ----부서명 저장 컬럼 선언. 자료형은 문자형. 제약조건 not null, unique
 ,loc       varchar2(20)    not null        ----부서위치 저장 컬럼 선언. 자료형은 숫자형. 제약조건 not null
 ,primary key(dep_no)                       ----dep_no 컬럼에 primary key 설정하기.
);

-- 4행 입력하기
Insert into dept(dep_no, dep_name, loc) values(10, '청무부', '서울');
Insert into dept(dep_no, dep_name, loc) values(20, '영업부', '부산');
Insert into dept(dep_no, dep_name, loc) values(30, '전산부', '대전');
Insert into dept(dep_no, dep_name, loc) values(40, '자재부', '광주');

-------------------------------------------------
-- dept 테이블의 모든 컬럼과 모든 행을 검색하기
-------------------------------------------------
select * from dept;

commit;


--------------------------------------------------------------------------------
--employee 테이블에서 PK값으로 사용할 일련번호를 생성하는 시퀀스 생성하기(일련 번호 자동 생성기)
--------------------------------------------------------------------------------
create sequence emp_sq
       start with 1
       increment by 1
       minvalue 1
       maxvalue 999;


-----------------------------
----employee 테이블 만들기. 직원 정보가 저장되는 테이블
-----------------------------
  create table employee(
   emp_no       number(3)                           --[직원번호]가 저장되는 컬럼 선언.
   ,emp_name    varchar2(20)    not null            --[직원명]이 저장되는 컬럼 선언.
   ,dep_no      number(3)                           --[소속부서번호]가 저장되는 컬럼 선언.
   ,jikup       varchar2(20)    not null            --[직급]이 저장되는 컬럼 선언.
   ,salary      number(9)       default 0           --[연봉]이 저장되는 컬럼 선언. 해당 컬럼의 자료형이 숫자형일 경우, default 오른쪽 역시 숫자형이어야.
   ,hire_date   date            default  sysdate    --[입사일]이 저장되는 컬럼 선언.
   ,jumin_num   char(13)        not null unique     --[주민번호]가 저장되는 컬럼 선언.
   ,phone_num   varchar2(15)    not null            --[전화번호]가 저장되는 컬럼 선언.
   ,mgr_emp_no  number(3)                           --[직속상관직원번호]가 저장되는 컬럼 선언.

   , primary key(emp_no)                            --[직원번호]컬럼에 pk 제약조건 걸기
   , foreign key(dep_no) references dept(dep_no)    --[소속부서번호]컬럼에 fk 제약조건 걸기. dept 테이블에 dep_no 컬럼 참조하게 하기.
   , constraint employee_mgr_emp_no_fk foreign key(mgr_emp_no) references employee(emp_no)
);                                                  --[직속상관직원번호]컬럼에 fk 제약조건 걸기. employee 테이블에 emp_no 컬럼 참조하게 하기.
                                                    --employee_mgr_emp_no_fk는 제약 조건에 붙이는 이름이다.



  select * from employee;    -- ( * 사용 시 create 구문 안의 column 순서대로 전부 사용)

  select
	emp_no		          직원번호  ------------------  테이블에 들어갈 데이터가 아니므로 더블 코트를 사용
	, emp_name	          "직원 명"  ------------------ 가능하면 무조건 더블코트 사용
	, jikup		          "직급"    ------------------ as 생략 가능
	, salary||'만원'		 "연봉"    ------------------ 별칭에 공백 없을시 더블코드 생략 가능
	, hire_date 	      "입사일"  ------------------ 오라클에서 연결연산자는 +가 아니라 ||이다. 자바와 다름.
from
	employee;

   select
	emp_name           	 as "직원명"
	, jikup		         as "직급"
	, salary*0.12||'만원'	as "세금"
	, salary*0.88||'만원'	as "실수령액"
from
	employee;


select distinct jikup from employee;

select distinct (jikup) from employee;

select unique (jikup) from employee;

select * from employee where salary >= 3000

select * from employee order by salary  asc;
                                --- 행의 순서를 바꾸고 싶을때
select * from employee order by salary; ---- asc 생략 가능

select * from employee order by 5 asc;

select * from employee order by 5;

select * from employee order by salary desc; ---- 내림차순. 생략 불가능

select * from employee order by 5 desc;

select * from employee order by dep_no asc, salary desc;

select distinct dep_no, jikup from employee;

select * from employee where jikup = '부장'

select * from employee where salary*0.88>=4000;

select * from employee where dep_no = 20 and 3000 >= salary and 2000 <= salary;

select * from employee where mgr_emp_no = null


select
	min( salary )	as "최소 연봉"
	,max( salary )	as "최대 연봉"
	,avg( salary )	as "연봉 총합"
	,sum( salary )	as "총 인원수"
from
	employee;

select count(emp_no) from customer;

select count(distinct emp_no) from customer;

select count(mgr_emp_no) from employee;

select
		emp_no						"직원번호"
		, emp_name					"직원명"
		, substr(jumin_num,3,2)||'-'||substr(jumin_num,5,2)	"생일월일"
from
		employee;

select
		cus_no
		, cus_name
		, tel_num
		, substr(jumin_num,1,6)||'-'||substr(jumin_num,7,1)||'******'
		, emp_no
from
		customer;


select
	cus_no
	, cus_name
	, nvl(emp_no||'','없음')
from
	customer;

select
	emp_no
	, emp_name
	, jikup
	, case
		substr(jumin_num,7,1) when '1' then '남' when '3' then '남' when '2' then '여' when '4' then '여'
	end
from
	employee;

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



select
	emp_no
	, emp_name
	, jikup
	, case
		when substr( jumin_num,7,1)='1'then'19'
		when substr( jumin_num,7,1)='2'then'19'
		else '20'
		end || substr(jumin_num,1,1)||'0년대'
from
	employee;

select
	emp_no
	, emp_name
	, jikup
    , decode (substr(jumin_num,7,1),'1','19','2','19','20'||substr(jumin_num,1,2))

from
	employee;


select * from employee order by
	case
	when substr( jumin_num,7,1)='1'then'19'
	when substr( jumin_num,7,1)='2'then'19'
	else '20'
	end || substr(jumin_num,1,6)
	asc;



select * from employee order by
	case jikup
		when '사장' then 1
		when '부장' then 2
		when '과장' then 3
		when '대리' then 4
		when '주임' then 5 else 6
	end
	asc;


select
	emp_no
	, emp_name
	, to_char(hire_date,'YYYY-MM-DD(DY) Q AM HH:MI:SS', 'nls_date_language = Korean')
from
	employee;

select
	emp_no
	, emp_name
	, to_char(hire_date,'YYYY')||'년'
		|| to_char(hire_date, 'MM')||'월'
		|| to_char(hire_date, 'DD') ||'일'
		|| to_char(hire_date, '(DY)', 'nls_date_language = Korean')
		|| to_char(hire_date, 'Q' ) || '분기'
		|| to_char(hire_date, 'AM HH' ) || '시'
		|| to_char(hire_date, ' :MI' ) || '분'
		|| to_char(hire_date, ' :SS' ) || '초'
from
	employee;

select
	emp_no		"직원번호"
	, emp_name	"직원명"
	, jumin_num	"주민번호"
	, case when
	to_date( to_char( sysdate,'YYYY') || substr(jumin_num,3,4), 'YYYYMMDD')  --- 올해 생일
	- sysdate				      			       --- 지금 이시각 날짜
	>=0
	then
	to_char( to_date( to_char(sysdate,'YYYY') || substr(jumin_num,3,4), 'YYYYMMDD'), 'YYYYMMDD' )
	else
	to_char( to_date( to_number(to_char(sysdate,'YYYY'))+1 || substr(jumin_num,3,4), 'YYYYMMDD'), 'YYYYMMDD (DY)' )
	end  "다가올 생일날"
	, case when
	to_date( to_number( to_char( sysdate,'YYYY') || substr(jumin_num,3,4), 'YYYYMMDD')
	- sysdate
	>=0
	then
	to_date( to_number( to_char( sysdate,'YYYY') || substr(jumin_num,3,4), 'YYYYMMDD')
	- sysdate
	else
	to_date( extract( year from sysdate,'YYYY')+1 || substr(jumin_num,3,4), 'YYYYMMDD')
	- sysdate
	end  "생일까지 남은 일수"
from
	employee
order by 5 asc;

select
	emp_no						"직원번호"
	, emp_name					"직원명"
	, jikup						"직급"
	, to_char( salary, '099,999,999' ) || '만원'		"연봉"
from
	employee



select * from employee where jikup = '대리'


select
	emp_no
	, emp_name
	, to_number(to_char(sysdate, 'YYYY'))
- to_number(
	case
	substr( jumin_num,7,1) when '1' then'19' when '2' then '19' else '20' end
	|| substr(jumin_num,1,2))
	+ 1||'세'
from
	employee;

select
	emp_no
	, emp_name
	,
	floor(
		(
 to_number(to_char(sysdate, 'YYYY'))
- to_number(
	case substr( jumin_num,7,1) when '1' then'19' when '2' then '19' else '20' end
	|| substr(jumin_num,1,2)
	)+ 1
	)*0.1
	)||'0대'

from employee;

select
	emp_no
	, emp_name
	, to_number(to_char(sysdate, 'YYYY'))
	- to_number(
	case
	substr( jumin_num,7,1) when '1' then'19' when '2' then '19' else '20' end
	|| substr(jumin_num,1,2))
	+ 1||'세'
		, to_number(to_char(hire_date, 'YYYY'))
	- to_number(
	case
	substr( jumin_num,7,1) when '1' then'19' when '2' then '19' else '20' end
	|| substr(jumin_num,1,2))
	+ 1||'세'

from
employee;

-- employee 테이블에서 수요일에 태어난 직원을 검색


select * from employee
where to_char(
		to_date(
			decode( substr( jumin_num,7,1), '1' , '19' , '2' , '19' , '20' ) || substr( jumin_num,1,6 ), 'YYYYMMDD' )
		,'DAY'
		,'nls_date_language = Korean') = '수요일'


select * from employee
	where
		substr( jumin_num, 1, 1) = '7'
		and
		substr( jumin_num, 7, 1) = '1'

select * from employee
	where
		(substr( jumin_num, 1, 1) = '6' or substr( jumin_num, 1, 1) = '7')
		and
		(substr( jumin_num, 7, 1) = '1' or substr( jumin_num, 7, 1) = '3')

select * from employee order by
	to_number(sysdate - hire_date) desc;

select * from employee order by
	(sysdate - hire_date) desc;

select
	emp_no					as		"직원번호"
	, emp_name				as		"직원명"
	, sysdate-hire_date				as		"근무일수"
	, months_between(sysdate, hire_date)		as		"근무개월수"
	, to_char(add_months(hire_date, 5), 'YYYY-MM-DD' )	as	"입사후5개월후날짜"
	, to_char(last_day(hire_date), 'YYYY-MM-DD' )		as	"입사한달의마지막날짜"
	, to_char(next_day(hire_date,1) 'YYYY-MM-DD' )		as	"입사한날짜기준돌아오는일요일날짜"
from
	employee


select * from employee where
		dep_no in(10, 30)
			and salary < 3000
				and hire_date<to_date('1996-01-01', 'YYYY-MM-DD');


select * from employee where substr(emp_name, 1, 1) = '김'

select * from employee where substr(emp_name, 1, 1) = '황'


select * from employee where jikup = '과장' or jikup = '부장'

select * from employee where jikup in( '과장', '부장' );

select * from employee where jikup = any('과장', '부장');




select * from employee where (dep_no=10 or dep_no=20) and jikup = '과장';


select * from employee where (dep_no=10 or dep_no=20) and jikup = '과장';


select * from employee
	floor( ( to_number( case substr( jumin_num,7,1) when '1' then'19' when '2' then '19' else '20' end
	|| substr(jumin_num,1,2) )+ 1)*0.1)||'0대'
	and decode( substr(jumin_num,7,1),'1','남','3','남','여')end = '70년대생 남자 직원'

select * from employee where hire_date >= to_date('1995-1-1', 'YYYY-MM-DD');

select * from employee where substr(emp_name, 1, 1) = '김' and length(emp_name)=3

select * from employee where emp_name like '김%' and length(emp_name)=3

select * from employee where emp_name not like '김%' and '%김' else



select
	employee.emp_no
	,employee.emp_name
	,dept.dep_name
from
	employee, dept
where
	employee.dep_no=dept.dep_no

select
	c.cus_no				"고객번호"
	,c.cus_name			"고객명"
	,e.emp_name			"고객담당직원이름"
from
	customer c, employee e
where
	c.emp_no=e.emp_no


select
	employee.emp_no			"직원번호"
	,employee.emp_name			"직원명"
	,dept.dep_name			"소속부서명"
from
	employee, dept
where
	employee.dep_no=dept.dep_no

select
	d.dep_name	"직원부서명"
	, e.emp_name	"직원명"
	, e.jikup		"직원직급"
	, c.cus_name	"담당고객명"
	, c.tel_num	"고객전화번호"
from
	employee e, dept d, customer c
where
	c.emp_no=e.emp_no and e.emp_no=c.emp_no
order by
	e.emp_name asc;

select
	e1.emp_name
	, e1.jikup
	, e2.emp_name
	, e2.jikup
from
	employee e1, employee e2
where
	e1.mgr_emp_no=e2.emp_no

select
	c.cus_name		"고객명"
	, c.tel_num		"고객전화번호"
	, e.emp_name		"담당직원명"
	, e.jikup			"담당직원직급"
from
	customer c, employee e
where
	c.emp_no=e.emp_no


select
	e1.emp_name
	, e1.jikup
	, d.dep_name
	, s.sal_grade
	, e2.emp_name
	, e2.jikup
	, c.cus_name
from
	employee1 e1, employee2 e2, dept d, salary_s, customer c
where
	e1.mgr_emp_no=e2.emp_no and e.dep_no=d.dep_no and (e.salary between s.min_salary and s.max_salary);


select
	e1.emp_name		"직원명"
	, e1.jikup			"직원직급"
	, d.dep_name		"소속부서명"
	, s.sal_grade_no		"연봉등급"
	, e2.emp_name		"직속상관명"
	, e2.jikup			"직속상관직급"
	, c.cus_name		"고객명"
from
	employee1 e1, dept d, salary_grade s, employee e2, customer c
where
	e1.dep_no=d.dep_no
	and (e1.salary>=s.min_sal and e1.salary<=s.max_sal)
	and e2.emp_no=e1.mgr_emp_no
	and e1.emp_no=c.emp_no;



select
	e1.emp_name		"직원명"
	, e1.jikup			"직원직급"
	, d.dep_name		"소속부서명"
	, s.sal_grade_no		"연봉등급"
	, e2.emp_name		"직속상관명"
	, e2.jikup			"직속상관직급"
	, c.cus_name		"고객명"
from
	(((employee e inner join dept d
	on e.dep_no = d.dep_no) inner join salary_grade s
	on e.salary between s.min_salary and s.max_salary) inner join employee e2
	on e.mgr_emp_no = e2.emp_no) inner join customer c
	on c.emp_no = e.emp_no


select
	c.cus_name		"고객명"
	, c.tel_num		"고객전화번호"
	, e.emp_name		"담당직원명"
	, e.jikup			"담당직원직급"
	, e.dep_no		"부서번호"
from
	customer c, employee e
where
	c.emp_no=e.emp_no(+) -- 딸려 나오는 테이블 뒤에다가

select
	c.cus_no
	, c.cus_name
	, c.tel_num
	, e.emp_name
	, e.jikup
	, e.dep_no
from
	customer c, employee e
where
	c.emp_no = e.emp_no(+) and e.dep_no(+)=10

select 	c.cus_no		"고객번호"
	, c.cus_name
	, c.tel_num
	, e.emp_name
	, e.jikup
	, s.sal_grade_no
from
	customer c, employee e, salary_grade s
where
	c.emp_no = e.emp_no(+)
	and
	s.min_salary(+)<=e.salary
	and
	s.max_salary(+)>=e.salary

select
	c.cus_no
	, c.cus_name
	, c.tel_num
from
	customer c, employee e
where
	e.salary>=3000 and e.emp_no<=c.emp_no
order by


select
	c.cus_no
	, c.cus_name
	, c.jumin_num
from
	customer c, employee e
where
	c.emp_no=e.emp_no
	and
	( extract( year from sysdate ) - extract( year from to_date
	( decode( substr( e.jumin_num,7,1), '1', '19', '2', '19', '20') || substr(e.jumin_num,1,6), 'YYYYMMDD') )+1 ) >=40




 --employee_mgr_emp_no_fk라는 이름의 fk 제약조건 끄기. 즉, 제약 조건 임시 무력화.
alter table employee disable constraint employee_mgr_emp_no_fk;

--alter -- 객체 구조를 바꾸는 것

----------------------------------------------지금 현재 로그인한 계정이 날짜 데이터는 '년-월-일' 로 취급하게 하기--------------------------------------------alter session set nls_date_format = 'yyyy-mm-dd' ;

--------------------------------------------
--지금 현재 로그인한 계정이 날짜 데이터는 '년-월-일' 로 취급하게 하기
--------------------------------------------insert into employee values( emp_sq.nextval, '홍길동', 10, '사장', 5000, '1980-01-01', '7211271109410', '01099699515', null );
insert into employee values( emp_sq.nextval, '한국남', 40, '부장', 3000, '1988-11-01', '6002061841224', '01024948424', 1 );
insert into employee values( emp_sq.nextval, '이순신', 20, '과장', 3500, '1989-03-01', '6209172010520', '01026352672', 2 );
insert into employee values( emp_sq.nextval, '이미라', 30, '대리', 2503, '1983-04-01', '8409282070226', '01094215694', 17 );
insert into employee values( emp_sq.nextval, '이순라', 20, '사원', 1200, '1990-05-01', '8401041483626', '01028585900', 3 );
insert into employee values( emp_sq.nextval, '공부만', 30, '과장', 4003, '1995-05-01', '8402121563616', '01191338328', 17 );
insert into employee values( emp_sq.nextval, '놀기만', 20, '과장', 2300, '1996-06-01', '8011221713914', '01029463523', 2 );
insert into employee values( emp_sq.nextval, '채송화', 30, '대리', 1703, '1992-06-01', '8105271014112', '01047111052', 17 );
insert into employee values( emp_sq.nextval, '무궁화', 10, '사원', 1100, '1984-08-01', '8303291319116', '01025672300', 12 );
insert into employee values( emp_sq.nextval, '공부해', 30, '사원', 1303, '1988-11-01', '8410031281312', '01027073174', 4 );
insert into employee values( emp_sq.nextval, '류별나', 20, '과장', 1600, '1989-12-01', '8409181463545', '01071628290', 2 );
insert into employee values( emp_sq.nextval, '류명한', 10, '대리', 1800, '1990-10-01', '8207211661117', '01042072622', 20 );
insert into employee values( emp_sq.nextval, '무궁화', 10, '부장', 3000, '1996-11-01', '8603231183011', '01098110955', 1 );
insert into employee values( emp_sq.nextval, '채시라', 20, '사원', 3400, '1993-10-01', '8001172065410', '01044452437', 3 );
insert into employee values( emp_sq.nextval, '최진실', 10, '사원', 2000, '1991-04-01', '8303101932611', '01027491145', 12 );
insert into employee values( emp_sq.nextval, '김유신', 30, '사원', 4000, '1981-04-01', '7912031009014', '01098218448', 4 );
insert into employee values( emp_sq.nextval, '이성계', 30, '부장', 2803, '1984-05-01', '8102261713921', '0165358075', 1 );
insert into employee values( emp_sq.nextval, '강감찬', 30, '사원', 1003, '1986-07-01', '8203121977315', '01033583130', 4 );
insert into employee values( emp_sq.nextval, '임꺽정', 20, '사원', 2200, '1988-04-01', '8701301040111', '01086253078', 7 );
insert into employee values( emp_sq.nextval, '깨똥이', 10, '과장', 4500, '1990-05-01', '8811232452719', '01090084876', 13 );

---제약 조건 임시 활성화
alter table employee enable constraint employee_mgr_emp_no_fk;


commit;

delete from employee;


--------------------------------------------------------------------------------
--customer 테이블에서 PK값으로 사용할 일련번호를 생성하는 시퀀스 생성하기(일련 번호 자동 생성기)
--------------------------------------------------------------------------------
create sequence cus_sq
       start with 1
       increment by 1
       minvalue 1
       maxvalue 999;



-- customer table 생성

create table customer (
 cus_no      number(3)
,cus_name   varchar2(20)    not null
,tel_num    varchar2(15)    not null
,jumin_num  char(13)        not null unique
,emp_no     number(3)

, primary key(cus_no)
, foreign key(emp_no) references employee(emp_no)
);


select * from customer;


select * from customer where emp_no != 9 or emp_no is null;


insert into customer values( cus_sq.nextval, '류민이', '123-1234', '7001131537915', 3);insert into customer values( cus_sq.nextval, '이강민', '343-1454', '6902161627914', 2);insert into customer values( cus_sq.nextval, '이영희', '144-1655', '7503202636215', null);insert into customer values( cus_sq.nextval, '김철이', '673-1674', '7704301234567', 4);insert into customer values( cus_sq.nextval, '박류완', '123-1674', '7205211123675', 3);insert into customer values( cus_sq.nextval, '서캔디', '673-1764', '6507252534566', null);insert into customer values( cus_sq.nextval, '신똘이', '176-7677', '0006083648614', 7);insert into customer values( cus_sq.nextval, '도쇠돌', '673-6774', '0008041346574', 9);insert into customer values( cus_sq.nextval, '권홍이', '767-1234', '7312251234689', 13);insert into customer values( cus_sq.nextval, '김안나', '767-1677', '7510152432168', 4);



commit;


-- salary grade 테이블 생성

create table salary_grade (
sal_grade_no    number(3)
,min_salary     number(5)   not null
,max_salary     number(5)   not null

, primary key(sal_grade_no)
);

insert into salary_grade values(1, 8000, 10000 );
insert into salary_grade values(2, 6000, 7999 );
insert into salary_grade values(3, 4000, 5999 );
insert into salary_grade values(4, 2000, 3999 );
insert into salary_grade values(5, 1000, 1999 );

select * from salary_grade;



commit;

--참조하는 테이블을 먼저 지우는 것을 원칙으로(그다음이 당하는 테이블)



select
	to_date('20211110', 'YYYYMMDD')
	-
	to_date('20210512', 'YYYYMMDD')
from
	dual;
