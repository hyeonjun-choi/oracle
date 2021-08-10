/*
데이터베이스  - 검색이 쉽도록 일정한 기준에 맞추어 자료를 분류, 정리해 놓은 '자료의 집합'
데이터베이스 조건   - 실시간 접근성, 지속적인 변화(=최신의 정보가 정확하게 저장), 동시 공유 등
                - 포괄적 개념에서 엑셀 등이 데이터베이스라고 부르긴 어렵다.

RDBMS 관계형 데이터베이스 관리 시스템?
- 데이터가 컬럼(column - 열)과 로우(row - 행)로 이루어진 테이블(table)에 저장되며,
테이블들 사이에 관계가 설정하여 관리하는 시스템


대략적인 구조
                   customer                            => 테이블명
------------------------------------------
고객번호      고객명        주소       전화번호               =>column 명
------------------------------------------
  1         저팔계        서울      02-1234-1234          =>row(행)
------------------------------------------
  2         사오정        부산      02-2345-2345          =>row(행)
------------------------------------------
  3         손오공        제주      02-3456-3456          =>row(행)
------------------------------------------
  ↓           ↓          ↓            ↓
column      column      column      column
 (컬럼)       (컬럼)       (컬럼)        (컬럼)
  (열)        (열)         (열)          (열)


SQL -- RDBMS에 접근하여 데이터의 입력, 수정, 삭제, 검색 등의 기능을 가진 RDBMS 관리 언더
'구조적 언더'

SQL 종류

<15번부터 예시 문제풀이 통한 복습>

<>하나의 테이블에서의 모든 컬럼, 행의 데이터를 검색하기 위한 구문
==
select 모든 column명 from 테이블
또는
select * from 테이블(*사용시 create 구문 그대로 나옴)

ex)
15번 employee 테이블에서 모든 컬럼, 모든 행의 데이터를 검색하면?

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

<> 테이블의 검색 결과에 명칭을 추가하는 방법

작성되는 전체 테이블 표에서 컬럼명 옆에 "컬럼명"을 한글로 표기함으로서 별칭(alias)을 추가한다.

<> 검색 결과에 특정 문자를 추가해서 나타내는 방법

넣고자 하는 칼럼 옆에 ||추가 후 싱글코트'블라블라' 같은 방식으로 작성

ex)
16. employee 테이블에서 emp_no, emp_name, jikup, hire_date을 검색하면서 별칭(= alias), 즉,
헤더를 붙여 사원번호, 직원명, 직급, 연봉, 입사일로 하고 연봉에 '만원'이란 문자를 붙여 검색

select
	emp_no		          직원번호  ------------------  테이블에 들어갈 데이터가 아니므로 더블 코트를 사용
	, emp_name	          "직원 명"  ------------------ 가능하면 무조건 더블코트 사용
	, jikup		          "직급"    ------------------ as 생략 가능
	, salary||'만원'		 "연봉"    ------------------ 별칭에 공백 없을시 더블코드 생략 가능
	, hire_date 	      "입사일"  ------------------ 오라클에서 연결연산자는 +가 아니라 ||이다. 자바와 다름.
from
	employee;

<> 테이블에서 특수한 계산식을 써야 하는 경우

계산하고자 하는 number 자료형 컬럼에 산수기호(ex; *)숫자 등을 기입한다

ex)

employee 테이블에서 직원명, 직급, 연봉, 세금, 실수령액을 검색하면? (세금은 연봉의 12%)

select
    emp_name                "직원명"
    , jikup                 "직급"
    , salary                "연봉"
    , salary*0.12||'만원'    "세금"
    , salary*0.88||'만원'    "실수령액"
from
    employee;

<>테이블에서 중복을 없애는 기능

select <distinct> 컬럼 from 테이블 순으로

ex) select distinct jikup from employee;

ex) eslect distinct jikup, dep_no from employee

<> 특정 숫자문자형 칼럼에 조건을 거는 것

끝에 where을 추가하고 조건을 추가할 컬럼명과 조건내용을 함께 추가한다.

ex) select * from employee where salary >= 3000

<> 오름차순, 내림차순 표현

오름차순, 내림차순 표현한 때는 각각 asc/ desc 를 사용한다.
사용 문구는 select 컬럼 from 테이블 <order by 조건적용 컬럼 asc/desc>
즉, oreder by가 필요하다.

ex) employee 테이블에서 연봉 오름차순으로 검색하면

select * from employee order by salary  asc;
                                --- <행의 순서를 바꾸고자 할 때 키워드>
select * from employee order by salary; ---- asc 생략 가능

select * from employee order by 5 asc; ----order by 바로 뒤 column 명 대신 해당 column의 번호를 쳐도 가능

select * from employee order by 5;

ex) employee 테이블에서 연봉 내림차순으로 검색하면?

select * from employee order by salary desc; ---- 내림차순. 생략 불가능

select * from employee order by 5 desc;

ex) employee 테이블에서 부서번호 오름차순을 유지하면서 연봉을 내림차순으로 검색

select * from employee order by dep_no asc, salary desc;

select * from employee order by dep_no, salary desc; -- asc생략은 가능하나 전체를 착각하게 만들 가능성 있음

<> 숫자형이 아닌 문자형 컬럼에서 순서 나열하고자 할때

인간이 생각하는 기준과 오라클의 정렬기준이 다르기 때문에 추후 조건문을 통해 정렬의 기준을 바쭤줘야 한다.
바꾸기 위해 추가하는 공식으로 order by <decode(컬럼명, '컬럼 안 데이터1', 1, '컬럼 안 데이커2', 2,~~~ alary desc;>

ex) employee 테이블에서 직급이 높은 순서대로 나열해서 검색하면

select * from employee order by jikup asc;
select * from employee order by jikup desc;
★둘 다 잘못된 예시
직급순서는 인간이 생각하는 기준과 오라클의 정렬기준과 다르기 때문
추후 조건문을 통해 정렬의 기준을 바꿔야 함

select * from employee order by decode( jikup , '사장' ,1, '부장' ,2, '과장' ,3, '대리' , 4), alary desc;
<명심> 고객의 요구사항을 보고 select문을 작성하는 것 또한 중요하지만,
	이미 작성된 select문을 보고 고객의 요구를 알아내는 것 역시 중요함.

<> 특정 컬럼만 따로 검색하고자 할때

where 을 활용
where 이후 찾는 위치 컬러명과 =, 찾는 데이터명을 적는다
and 또는 or, 혹은 >=, <=와 같은 기호 등과 같은  추가조건이 더 붙기도 한다.



ex) select * from employee where jikup = '부장'

ex) select * from employee where dep_no = 20 and jikup = '과장'

ex) select * from employee where dep_no = 20 or jikup = '과장'

ex) select * from employee where jikup = '과장' and salary >= 3400

ex) select * from employee where  salary*0.88>=4000;


ex) employee 테이블에서 세금을 제일 많이 내는 직원 순서로 나열하면서 부서번호가 내림차순이면서 사장이 아닌직원ㅇ르 검색

select * from employee where jikup != '사장' order by salary*0.12 desc, dep_no desc;

// 사장이 아닌 직원을 찾아야 하므로 jikup에 !='사장'을 붙여 사장 지급을 제외시키고 나머지 중에서
// 세금을 많이 내는 직원을 부서번호로 내림차순을 하는 것이므로
// order by로 차례대로 정렬시키고 각각 desc를 붙이면 된다.

ex) employee 테이블에서 20번째 부서 중에서 연봉 2000~3000 사이 검색

select * from employee where dep_no=20 and salary>=2000 and salary<=3000;    2000<=salary<=3000 - 안됨

select * from employee where dep_no=20 and salary between 2000 and 3000; <참고>

<> 테이블에서 null값을 찾을 때

해당 컬럼 내의 데이터에서 null을 찾을 때 =을 쓰지 말것

ex) employee 테이블에서 직속상관이 없는 직원 검색

select * from employee where mgr_emp_no = null

select * from employee where mgr_emp_no is null

<주의> null값을 찾을 땐 = 을 쓰지 말것

ex ) employee 테이블에서 직속상관이 있는 직원 검색

select * from employee where mgr_emp_no is not null

<> [그룹함수], 또는 [연산함수] 의 활용

min, max, avg, sum, count 함수들을 부르는 명칭. 이들은 주로 group by와 같이 많이 쓰인다
또한 null값을 제외하고 계산한다.
count(컬럼명) => 컬럼안의 null이 아닌 데이터의 개수를 리턴한다.
count(*)	      => 행의 개수를 리턴한다.

ex, select count (cus_no) from customer;

ex) employee 테이블에서 [최소 연봉], [최대 연봉], [평균 연봉], [연봉 총합], [총 인원수]를 검색해서 출력

select
	min( slalry )	as "최소 연봉"  -- salary 컬럼에서 최소값을 리턴
	,max( salary )	as "최대 연봉"  -- salary 컬럼에서 최대값을 리턴
	,avg( salary )	as "평균 연봉"  -- salary 컬럼에서 평균값을 리턴 <조심> avg 사용 시 null 있으면 더할 때 빠지고, 나누는 개수에서도 빠진다
	,sum( salary )	as "연봉 총합"  -- salary 컬럼에서 총합을 리턴
	,count( * )    	as "총 인원수"  -- count( * )는 총행의 개수 --
from
	employee;

<> count 사용

ex) 고객을 담당하고 있는 직원 명수

select count(distinct emp_no) from customer;

ex) 담당 직원이 있는 고객의 명수

select count (emp_no) from customer;

직원 번호의 개수의 의미가 distinct의 존재유무에 따라 달라지게 된다. 해석의 의미가 달라지게 되므로 주의해야 한다.
distinct 컬럼명 => 컬럼 안의 데이터 중 중복을 제거
<주의> count에는 업무적 특징이 숨어 있어 조심히 날려야한다.
		  ||
고객의 다양하고 복잡한 요구사항

ex) 직속상관이 있는 직원의 명수

select count(mgr_emp_no) from employee;

<주의>mgr_emp_no 컬럼 안의 데이터가 뭔지 뭔저 파악해야한다. 바로 직속 상관의 직원번호이다.

ex) 부하직원이 있는 직원의 명수

select count(distinct mdr_emp_no) from employee;

<> 오라클은 인덱스 번호가 없다
<> substr(컬럼명, 복사할 시작순서번호, 복사할 개수) => 시작순서번호 부터 복사할개수 만큼 복사해서 리턴

ex) employee 테이블에서 [직원번호], [직원명], [생일월-생일일]를 검색해서 출력

select
    emp_no                                                  "직원번호"
    ,emp_name                                               "직원명"
    ,substr(jumin_num, 3, 2)||'-'||substr(jumin_num,5,2)    "생일월일"
from
    employee;

substr 문구와 ||'-'|| 조합을 통해 원하는 자리의 결과를 받는다
|| = 문자열을 합치는 기호(파이프)로 싱글코트로 감싸서 문자열로 취급하는 '-'을 양 옆 substr문구와 합치는 방식으로 쓰인다.

ex) customer 테이블에서 모든 컬럼, 모든 행을 검색해서 출력. 단, 주민번호는 901225-2****** 형태로 출력할것

select
    cus_no
    , cus_name
    , tel_num
    , substr(jumin_num,1,6)||'-'||substr(jumin_num,7,1)||'******'
    , emp_no
from
    customer;
<주의> '모든 행' 이란 말이 나오면 where절이 없다.

*****substr(컬럼명, 복사할 시작순서번호, 복사할개수) => 시작순서번호 부터 복사할개수 만큼 복사해서 리턴하기
						엄청난 사용빈도를 자랑한다.
||  ==> 좌우의 문자열을 붙이는 연산자, 즉 연결 연산자이다.
<주의> 오라클에서 + 는 연결연산자가 아니라 사칙연산자이다.

<> 자동형변환 활용에 대한 설명

★nvl( 컬럼명, null값일때 대체데이터)

 -- null값 처리 함수. 컬럼명 안의 데이터가 null이 아니면 그냥 리턴하고,
  null값 이면 null값대체데이터를 리턴하는 [null처리 내장함수]이다.

ex) customer 테이블에서 고객번호, 고객명, 담당직원번호 를 출력하면?
단, 담당직원번호가 없으면 null 출력하지 말고 '없음' 으로 표시

<자동 형 변환 활용>
select
    cus_no
    ,cus_name
    ,nvl(emp_no||'','없음')
from
    customer;
-----------------------------------
<정석>
select
    cus_no
    ,cus_name
    ,nvl(to_char(emp_no),'없음')
from
    customer;

nvl문구 사용법
정석 : nvl( to_char(컬럼명),'null값일때 대체할 문자데이터')
      숫자형 데이터 컬럼일 경우 문자형으로 바꿔주기 위해 to_char를 적용

★nvl2( 컬럼명, null값 아닐때 대체 데이터, null값 일때 대체 데이터 )

-- 컬럼명 안의 데이터가 null이 아니면 null값 아닐때 대체데이터로 출력하고
null이면 null값일때 대체데이터를 리턴하는 [null 처리 내장함수] 이다.

ex) customer 테이블에서 고객번호, 고객명, 담당직원존재여부 를 출력하면?
단, 직원번호가 있으면 '있음', 없으면 '없음'으로 표시

select
    cus_no
    , cus_name
    , nvl2(emp_no, '있음', '없음')
from
    customer;

<> case ~ end 구문 패턴 설명

<패턴1>
●case (컬럼명(※일반적으로 원하는 형태의 값을 얻기 위해 substr을 같이 사용하는 경우가 많으며 이때는
substr다음에 컬럼을 적을 때 괄호를 넣으면 된다))
	when 데이터1 then 리턴값1
	when 데이터2 then 리턴값2
	~
	else 리턴값n
end

컬럼명 안의 데이터가 데이터1과 같으면 리턴값1을 리턴
컬럼명 안의 데이터가 데이터2과 같으면 리턴값2을 리턴
~
그 외에는 리턴값n을 리턴하기

<패턴2>
●case (컬럼명※)
	when 컬럼명 = 데이터1 then 리턴값1
	when 컬럼명 = 데이터2 then 리턴값2
	~
	else 리턴값n
end


컬럼명 안의 데이터가 데이터1과 같으면 리턴값1을 리턴
컬럼명 안의 데이터가 데이터2과 같으면 리턴값2을 리턴
~
그 외에는 리턴값n을 리턴하기

패턴2 에서 = 대신에 필요에 따라 >=, >, <, <=, != 등의 비교연산자도 사용할 수 있다.
필요에 따라 else 리턴값n은 생략될 수 있다.

decode(~) 구문의 패턴 설명

decode(
	※컬럼명  -- decode의 경우 시작부터 괄호를 넣어줘서 substr이 괄호 안에 들어가도록
	, 비교데이터1, 리턴값1
	, 비교데이터2, 리턴값2
	, ~
	, 리턴값n
)


컬럼명 안의 데이터가 데이터1과 같으면 리턴값1을 리턴
컬럼명 안의 데이터가 데이터2과 같으면 리턴값2을 리턴
~
그 외에는 리턴값n을 리턴하기


필요에 따라 그외 경우 리턴값n은 생략될 수 있다.

decode 단점 =
 오라클에서밖에 못쓰는 오라클 전용함수. case ~ end 구문은 모든 DB에서 사용가능하다.
 '같다'라는 조건에서만 사용 가능
-----------------------------------------------------------------------------------------------------------
각 자리수마다 무엇이 있는지 알기 어렵기 때문에 사용에 주의해야

case = 모든 데이터베이스에서 사용 가능

case substr(컬럼명, 카피해올 데이터의 시작번호, 갯수) when A then B (else) end

ex) employee 테이블에서 직원번호, 직원명, 직급, <성별> 을 출력하면...

select   -----  when ~ then ~ end형식(너무 길다)
    emp_no
    ,emp_name
    ,jikup
    ,case
       substr(jumin_num,7,1)
       when '1' then '남'
       when '3' then '남'
       when '2' then '여'
       when '4' then '여'
    end
from
    employee
----------------------------------------------------------------------------------------------------------------------------------
select  ----- when ~ then ~ else ~ end (when then 처리 후 나머지를 else로)
	emp_no
	, emp_name
	, jikup
	, case
		substr(jumin_num,7,1)
		when '1' then '남'
		when '3' then '남'
		else '여'
	end
from
	employee
----------------------------------------------------------------------------------------------------------------------------------
 select  -----  when then else end(substr컬럼이 when 뒤로 옴, 부등호 수식 사용)
	emp_no
	, emp_name
	, jikup
	, case
		when substr(jumin_num,7,1)='1' then '남'
		when substr(jumin_num,7,1)='3' then '남'
		else '여'
	end
from
	employee
----------------------------------------------------------------------------------------------------------------------------------
select ----- decode substr컬럼 '','','','',''(end 없음, else 없음, when then 없음)
	emp_no
	, emp_name
	, jikup
	, decode(
		substr(jumin_num,7,1),'1','남','3','남','여')
from
	employee

ex) employee 테이블에서 직원번호, 직원명, 직급, <출생년도> 출력

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
	, decode (substr(jumin_num,7,1),'1','19','2','19','20')||substr(jumin_num,1,2) <= 실제 정답
from
	employee;

ex) employee 테이블에서 직원번호, 직원명, 직급, 출생년대(4자리)를 출력

select
    emp_no
    , emp_name
    , jikup
    , case
    when substr(jumin_num,7,1)='1'then'19'
    when substr(jumin_num,7,1)='2'then'19'
    else '20'
    end||substr(jumin_num,1,1)||'0년대'
from
    employee;
----------------------------------------------------
select
    emp_no
    , emp_name
    , jikup
    , decode(substr(jumin_num,7,1),'1','19','2','19','20')||substr(jumin_num,1,1)||'0년대')
from
    employee;

ex) employee 테이블에서 나이순으로 출력(연장자가 먼저 나오도록)

select * from employee order by
    case
    when substr(jumin_num,7,1)='1'then'19'
    when substr(jumin_num,7,1)='2'then'19'
    else '20'
    end||substr(jumin_num,1,6)asc;

테이블 명 이후에 order by를 넣고 case when 문구를 넣어 정렬시킨다.(오름차순, 내림차순 정렬 시)

rder by 뒤는 정렬 기준 컬럼이 나온다. 정렬 기준 컬럼을 case가 끌어 안아서 다른 형태로 바꾼 것이다.

order by 구문의 패턴

order by 컬럼명 | 컬럼순서번호 | 컬럼알리아스 [asc] | desc

ex) employee 테이블에서 직급순서대로 정렬하여 모든 컬럼을 보이게

select * from employee order by
	case jikup
		when '사장' then 1
		when '부장' then 2
		when '과장' then 3
		when '대리' then 4
		when '주임' then 5 else 6
	end
	asc;

문자형 데이터에 순서를 부여해주기 위해 각 문자 데이터에 숫자를 차례대로 부여해준 후 정렬해준다
case (문자데이터)컬럼 when '데이터1' then 1 ~~~~~~~~~~~~ end asc/desc;

order by 뒤는 정렬 기준 컬럼이 나온다. 정렬 기준 컬럼을 case가 끌어 안아서 다른 형태로 바꾼 것이다.

정렬 시 사장은 1로 보고, 부장은 2로 보고, 과장은 3으로 보고, 대리는 4로 보고, 주임은 5로 보고 기타는 6으로 보고
오름차순으로 정렬. 즉, 직급을 정수로 바꿔서 정렬을 한 것이다.

＠asc를 desc로 바꾸면 직급이 낮은 사람이 먼저 나온다

<> 입사일(년-월-일(요일) 분기 시분초) 출력하는 방법

to_char( 날짜 또는 숫자 컬럼, '출력시 원하는 문자패턴' )

문자데이터가 아닌 데이터를 작성자가 원하는 데이터로 전환할 때 필요.

지정한 날짜 또는 숫자를 원하는 출력문자패턴 으로 바꾸어 주는 변환함수의 일종
주로 출력할기 위해 사용.

YYYY 	=> 년도 4자리
MM  	=> 월 2자리
DD   	=> 일 2자리
AM HH	=> 오전 | 오후 1~12 사이의 시간
HH24 	=> 0~23 사이의 시간
MI	=> 0~59 사이의 분
SI	=> 0~59 사이의 초
DAY	=> 영문 요일 풀네임
DY 	=> 영문 요일 요약
Q 	=> 1~4 사이의 분기

to_char(hire_date, 'YYYY-MM-DD')
hire_date 컬럼 안의 데이터를 년-월-일 패턴의 문자열로 바꾸어 리턴하라

ex) employee 테이블에서 직원번호, 직원명, 입사일(년-월-일(요일) 분기 시분초) 검색

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
	, to_char(hire_date,'YYYY-MM-DD(D(A생략가능)Y) Q<분기> AM<오전. 오후는 PM 또는 HH24> < HH:MI:SS<시분초>'
	, 'nls_date_language = Korean')
from
	employee;

ex) employee 테이블에서 직원번호, 직원명, 입사일(x년-x월-x일(요일) x분기 x시x분x초 ) 검색하라
1999년-12월-25일(화) 4분기 11시 10분 22초

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
------------------------------------------------------------------------------
select
	emp_no
	, emp_name
	, to_char(hire_date, 'YYYY"년"MM"월"DD"일"(DY) Q"분기" AM HH"시"MI"분"SS"초" ' , 'NLS_DATE_LANGUAGE = KOREAN' )
from
	employee;

1> 각자 따로 분류해서 하나하나씩 잡고 연결시켜주거나
2> 한번에 이어서 완성시켜주는 방법이 있다.

심화) 50) employee 테이블에서 직원번호, 직원명, 나이 검색

select
    emp_no
    , emp_name
    , to_number( to_char( sysdate,'YYYY'))
    -
    to_number(
        (case substr(jumin_num,7,1)when'1'then'19'when'2'then'19'else'20'end||substr(jumin_num,1,2)+1||'세'
    from
        employee;
------------------------------------------------------------------------------------------------------------
sysdate -- 오늘날 지금 시간
나이 구하는 방법 오늘날짜 - (현재 시간에서 테이블에 저장된 날짜데이터)

51) employee 테이블에서 직원번호, 직원명, 근무년차를 검색 출력

select
    emp_no
    , emp_name
    , ceil( (sysdate-hire_date)365)||'년차'
      <오늘날짜에서 입사일 날짜까지의 차이를 일수로 구한 다음 365로 나눈 후 소수 첫째 자리에서 무조건 올림>
from
    employee;

52) employee 테이블에서 직원번호, 직원명, 연령대를 검색해서 출력하면

select
    emp_no
    , emp_name
    , floor( (to_number( to_char(sysdate, 'YYYY') )-
    to_number( case substr( jumin_num,7,1) when '1' then '19' when '2' then '19' else '20' end||substr(jumin_num,1,2)
    )+1 )*0.1)||'0대'
from
    employee;

연령대 구하기 -- 나이 구하기와 비슷한 구문으로 정확한 연령대 도출을 위해 소수 첫째 자리에서 무조건 내림해서 리턴하는 floor를 전체적으로 묶어준다.
★오라클은 날짜-날짜 의 결과값은 날짜차이만큼의 일수이다
ceil(~)  	=> 소수 첫째 자리에서 무조건 올림해서 리턴하는 수학 함수의 일종이다. (숫자 자료형의 칼럼을 끌어안고)
floor(~) 	=> 소수 첫째 자리에서 무조건 내림해서 리턴하는 수학 함수의 일종이다.

<참고> 오라클은 날짜 데이터에서 날짜 데이터를 빼면 그 차이만큼을 일 수로 리턴하는 특징 있음.(전용 함수가 없기 때문)
	더하는 건 아예 없음.

53) employee 테이블에서 직원번호, 직원명, 100일잔치 날짜를 검색해서 출력하면

select
    emp_no
    ,emp_name
    ,to_char(to_date(case when substr(jumin_num,7,1)in('1','2')then'19'else'20'end||substr(jumin_num,1,6),'YYYYMMDD')+100
    ,'YYYY-MM-DD')
from
    employee;

to_char//to_date==각 목적으로 인해 사용되어지는 문구들이다
to_char -- 주로 특정 문자 패턴으로 변형시키기 위해
to_date -- 날짜로 전환시켜 정수를 더하거나 빼거나, 혹은 날짜끼리 빼기 위해 (날짜끼리 더하는 것은 없다)

날짜 + 정수 	==> 날짜에 정수만큼의 일수를 더한 날짜를 리턴
날짜 - 정수 	==> 날짜에 정수만큼의 일수를 뺀 날짜 리턴
날짜1-날짜2 	==> 날짜1과 날짜2 까지의 차이를 일수로 리턴. 일수 양수가 날짜1이 날짜2보다 큰 것(음수 반대)
날짜1+날짜2	==> 없음


순서대로 1. 100을 더하기 위해 날짜로 바꾸고 2. 'YYYY-MM-DD'화 하기 위해 문자로 바꿈

54) 개강일이 2021년 5월 12일 이고 종강일이 2021년 11월 10일 이다. 몇일 동안 학원 생활

select
    to_date('20211110','YYYYMMDD')-to_date('20210512','YYYYMMDD')
from
    dual;

dual(가상 호은 더미 테이블)
