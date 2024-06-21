-- system 계정으로 작업할 내용
-- bts이란 이름의 계정 생성
create user bts IDENTIFIED by 12345 account unlock;
-- bts에 테이블 스페이스 관련 권한 부여(계속 생성)
grant unlimited tablespace to bts;
-- 기본 테이블스페이스 설정
ALTER USER bts DEFAULT TABLESPACE USERS;
-- 임시 테이블스페이스 설정
ALTER USER bts TEMPORARY TABLESPACE TEMP;
-- bts 사용자 계정에 권한 부여
grant connect, resource to bts;
-- bts 사용자 계정 접속 권한 부여
grant create session to bts;
-- bts 사용자 계정에 테이블 생성 권한 부여
grant create table to bts;
-- 다른 사람들은 system계정의 이 명령어를 실행하면 됨(system 계정으로)
conn bts/12345;

-- 테이블들 제거 코드
 DROP TABLE MEMBER;
 DROP TABLE ESCALATOR;
 DROP TABLE ELEVATOR;
 DROP TABLE CHAIRLIFT;
 DROP TABLE ATTRACTION;
 DROP TABLE RESTAURANT;
 DROP TABLE CONGESTION;


-- 회원 테이블 생성
Create Table Member(
    mno NUMBER(4)
        CONSTRAINT MEMB_NO_PK PRIMARY KEY,
    name VARCHAR2(15 CHAR)
        CONSTRAINT MEMB_NAME_NN NOT NULL,
    id VARCHAR2(10 CHAR)
        CONSTRAINT MEMB_ID_UK UNIQUE
        CONSTRAINT MEMB_ID_NN NOT NULL,
    pw VARCHAR2(10 CHAR)
        CONSTRAINT MEMB_PW_NN NOT NULL,
    isshow CHAR(1) DEFAULT 'Y'
        CONSTRAINT MEMB_ISSHOW_CK CHECK (ISSHOW IN ('Y', 'N'))
        CONSTRAINT MEMB_ISSHOW_NN NOT NULL
);

-- 에스컬레이터 테이블 생성
CREATE TABLE ESCALATOR(
    "일련번호" NUMBER
        CONSTRAINT ESC_NO_PK PRIMARY KEY,
    "철도운영기관명" VARCHAR2(4000 CHAR),
    "운영노선명" VARCHAR2(4000 CHAR),
    "역명" VARCHAR2(4000 CHAR),
    "상하행구분" VARCHAR2(4000 CHAR),
    "(근접)출입구번호" VARCHAR2(4000 CHAR),
    "시작층(지상/지하)" VARCHAR2(4000 CHAR),
    "시작층(운행역층)" VARCHAR2(4000 CHAR),
    "시작층(상세위치)" VARCHAR2(4000 CHAR),
    "종료층(지상/지하)" VARCHAR2(4000 CHAR),
    "종료층(운행역층)" VARCHAR2(4000 CHAR),
    "종료층(상세위치)" VARCHAR2(4000 CHAR),
    "승강기 상태" VARCHAR2(4000 CHAR),
    "승강기형폭" VARCHAR2(4000 CHAR)
);

-- 엘리베이터 테이블 생성
CREATE TABLE ELEVATOR(
    "일련번호" NUMBER
        CONSTRAINT ELE_NO_PK PRIMARY KEY,
    "철도운영기관명" VARCHAR2(4000 CHAR),
    "운영노선명" VARCHAR2(4000 CHAR),
    "역명" VARCHAR2(4000 CHAR),
    "(근접)출입구번호" VARCHAR2(4000 CHAR),
    "상세위치" VARCHAR2(4000 CHAR),
    "시작층(지상/지하)" VARCHAR2(4000 CHAR),
    "시작층(운행역층)" VARCHAR2(4000 CHAR),
    "종료층(지상/지하)" VARCHAR2(4000 CHAR),
    "종료층(운행역층)" VARCHAR2(4000 CHAR),
    "정원(인원수)" VARCHAR2(4000 CHAR),
    "정원(중량)(kg)" VARCHAR2(4000 CHAR),
    "승강기상태" VARCHAR2(4000 CHAR)
);

-- 휠체어 리프트 테이블 생성
CREATE TABLE CHAIRLIFT(
    "일련번호" NUMBER
        CONSTRAINT LIFT_NO_PK PRIMARY KEY,
    "철도운영기관명" VARCHAR2(4000 CHAR),
    "운영노선명" VARCHAR2(4000 CHAR),
    "역명" VARCHAR2(4000 CHAR),
    "(근접)출입구번호" VARCHAR2(4000 CHAR),
    "시작층(지상/지하)" VARCHAR2(4000 CHAR),
    "시작층(운행역층)" VARCHAR2(4000 CHAR),
    "시작층(상세위치)" VARCHAR2(4000 CHAR),
    "종료층(지상/지하)" VARCHAR2(4000 CHAR),
    "종료층(운행역층)" VARCHAR2(4000 CHAR),
    "종료층(상세위치)" VARCHAR2(4000 CHAR),
    "길이(Cm)" VARCHAR2(4000 CHAR),
    "폭(Cm)" VARCHAR2(4000 CHAR),
    "한계중량(Kg)" VARCHAR2(4000 CHAR),
    "승강기상태" VARCHAR2(4000 CHAR)
);

-- 관광지 테이블 생성
CREATE TABLE ATTRACTION(
    "관광지 번호" NUMBER
        CONSTRAINT ATTR_NO_PK PRIMARY KEY,
    "중심 POI X 좌표" VARCHAR2(4000 CHAR),
    "중심 POI Y 좌표" VARCHAR2(4000 CHAR),
    "관광지명" VARCHAR2(4000 CHAR),
    "주소" VARCHAR2(4000 CHAR),
    "중심카테고리 명_대" VARCHAR2(4000 CHAR),
    "분류" VARCHAR2(4000 CHAR),
    "자치구별 순위" NUMBER
);

-- 맛집 테이블 생성
CREATE TABLE RESTAURANT(
    "음식점 번호" NUMBER
        CONSTRAINT REST_NO_PK PRIMARY KEY,
    "업소명" VARCHAR2(4000 CHAR),
    "주소" VARCHAR2(4000 CHAR),
    "분류" VARCHAR2(4000 CHAR),
    "자치구별 랭킹" NUMBER
);

-- 혼잡도 테이블 생성
CREATE TABLE CONGESTION(
    "연번" NUMBER
        CONSTRAINT SERIAL_NO_PK PRIMARY KEY,
    "요일구분" VARCHAR2(10 CHAR),
    "호선" VARCHAR2(10 CHAR),
    "역번호" NUMBER,
    "출발역" VARCHAR2(30 CHAR),
    "상하구분" VARCHAR2(10 CHAR),
    "5시30분" VARCHAR2(10 CHAR),
    "6시00분" VARCHAR2(10 CHAR),
    "6시30분" VARCHAR2(10 CHAR),
    "7시00분" VARCHAR2(10 CHAR),
    "7시30분" VARCHAR2(10 CHAR),
    "8시00분" VARCHAR2(10 CHAR),
    "8시30분" VARCHAR2(10 CHAR),
    "9시00분" VARCHAR2(10 CHAR),
    "9시30분" VARCHAR2(10 CHAR),
    "10시00분" VARCHAR2(10 CHAR),
    "10시30분" VARCHAR2(10 CHAR),
    "11시00분" VARCHAR2(10 CHAR),
    "11시30분" VARCHAR2(10 CHAR),
    "12시00분" VARCHAR2(10 CHAR),
    "12시30분" VARCHAR2(10 CHAR),
    "13시00분" VARCHAR2(10 CHAR),
    "13시30분" VARCHAR2(10 CHAR),
    "14시00분" VARCHAR2(10 CHAR),
    "14시30분" VARCHAR2(10 CHAR),
    "15시00분" VARCHAR2(10 CHAR),
    "15시30분" VARCHAR2(10 CHAR),
    "16시00분" VARCHAR2(10 CHAR),
    "16시30분" VARCHAR2(10 CHAR),
    "17시00분" VARCHAR2(10 CHAR),
    "17시30분" VARCHAR2(10 CHAR),
    "18시00분" VARCHAR2(10 CHAR),
    "18시30분" VARCHAR2(10 CHAR),
    "19시00분" VARCHAR2(10 CHAR),
    "19시30분" VARCHAR2(10 CHAR),
    "20시00분" VARCHAR2(10 CHAR),
    "20시30분" VARCHAR2(10 CHAR),
    "21시00분" VARCHAR2(10 CHAR),
    "21시30분" VARCHAR2(10 CHAR),
    "22시00분" VARCHAR2(10 CHAR),
    "22시30분" VARCHAR2(10 CHAR),
    "23시00분" VARCHAR2(10 CHAR),
    "23시30분" VARCHAR2(10 CHAR),
    "00시00분" VARCHAR2(10 CHAR),
    "00시30분" VARCHAR2(10 CHAR)
);

-- 회원가입 관련 시퀀스 생성 코드
CREATE Sequence membSeq
start with 1001
increment by 1
nocache
nocycle;

-- 그리고 파이썬에서의 데이터는 UTF-8로 인코딩이 되어있는데
-- 오라클에서 SELECT절을 편하게 쓰려면 EUC_KR(추천)이나 UTF-8로 인코딩 설정이 되어야 한다.
-- 도구(T) -> 맨 밑에 있는 환경설정 클릭 -> 환경 메뉴의 인코딩 설정 EUC_KR이나 UTF-8로 변경 후 확인.
-- 안 그러면 컬럼을 조회할 때도 to_char("컬럼명")으로 형태를 작성해야 한다.
-- 물론 테이블을 만들고 난 뒤 데이터를 삽입하려고 할 때 UTF-8로 인코딩이 되어있는지 확인하고 삽입을 해야 한다.

commit;

-- UTF-8로 인코딩 되어있는 상태
SELECT
    "철도운영기관명" 회사, "운영노선명" 노선
FROM
    elevator
where
    "철도운영기관명" = '서울교통공사'
order by
    노선
;

-- 다른 경우
SELECT
    to_Char("철도운영기관명") 회사, to_char("운영노선명") 노선
FROM
    elevator
where
    to_Char("철도운영기관명") = '서울교통공사'
order by
    노선
;

-- 강서구에 있는 관광지 이름과 주소 그리고 카테고리만 검색
SELECT
    "관광지명" 관광지명,"주소" 주소, "중심카테고리 명_대" 카테고리
FROM
    attraction
WHERE
    주소 LIKE '%양천구%'
;