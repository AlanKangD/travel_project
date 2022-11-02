
CREATE TABLE member 
   (   "ID" VARCHAR2(30 BYTE) NOT NULL ENABLE, 
   "PW" VARCHAR2(110 BYTE) NOT NULL ENABLE, 
   "ADDR1" VARCHAR2(20 BYTE) NOT NULL ENABLE, 
   "ADDR2" VARCHAR2(110 BYTE) NOT NULL ENABLE, 
   "ADDR3" VARCHAR2(110 BYTE) NOT NULL ENABLE, 
   "EMAIL" VARCHAR2(100 BYTE) NOT NULL ENABLE, 
   "SESSION_ID" VARCHAR2(100 BYTE) DEFAULT 'nan' NOT NULL ENABLE, 
   "PHONE_NUMBER" VARCHAR2(100 BYTE) NOT NULL ENABLE, 
   "REGISTER_DATE" DATE DEFAULT sysdate, 
   "LIMIT_TIME" DATE, 
    PRIMARY KEY ("ID")
    );


--------------------------------------------------------------------------------------------------------------

CREATE TABLE qna_board
(
    qna_no         NUMBER(10), 
    qna_title      VARCHAR2(50)     NOT NULL, 
    qna_content    VARCHAR2(300)    NOT NULL, 
    qna_hit        NUMBER(4)default 0, 
    savedate       date default sysdate, 
    qna_pwd        VARCHAR2(100), 
    id             VARCHAR2(20),
    PRIMARY KEY (qna_no)
);


--------------------------------------------------------------------------------------------------------------
CREATE TABLE qna_reply
(
    id                VARCHAR2(20)     NOT NULL, 
    qr_content        VARCHAR2(300)    NOT NULL, 
    qr_write_group    NUMBER(10),        
    savedate       date default sysdate,
    qr_id number(4) primary key
)
--------------------------------------------------------------------------------------------------------------
CREATE TABLE calendar
(
    calendar_no  NUMBER(30)primary key, 
    id        VARCHAR2(50), 
    title    VARCHAR2(100),         
    start_date  VARCHAR2(100), 
    end_date VARCHAR2(100),  
    allday VARCHAR2(10)
);
--------------------------------------------------------------------------------------------------------------
CREATE TABLE mylist(
list_no NUMBER(10) PRIMARY KEY,  
id VARCHAR2(50),
place VARCHAR2(50),
image VARCHAR2(300)
);
--------------------------------------------------------------------------------------------------------------
CREATE TABLE main(
place_name VARCHAR2(50) NOT NULL,
main_category VARCHAR2(50) NOT NULL, 
content_one VARCHAR2(100) NOT NULL, 
content_two VARCHAR2(3000) NOT NULL,
main_image_file VARCHAR2(100) NOT NULL,
image_file1 VARCHAR2(150) NOT NULL, 
image_file2 VARCHAR2(150) NOT NULL,
latitude VARCHAR2(100) NOT NULL,
longitude VARCHAR2(100) NOT NULL,
address VARCHAR2(200) NOT NULL
);
--------------------------------------------------------------------------------------------------------------
create table main_LIKE(
rep_no NUMBER(10) NOT NULL,
id VARCHAR2(30) NOT NULL
);
--------------------------------------------------------------------------------------------------------------
CREATE TABLE main_reply(
rep_no NUMBER(10) PRIMARY KEY,
place_name varchar2(100),
id varchar2(50),
rep_content VARCHAR2(300) NOT NULL, 
likeHit NUMBER(10),
savedate date default sysdate
);
--------------------------------------------------------------------------------------------------------------
CREATE TABLE R_LIKE(
LIKE_NO NUMBER NOT NULL PRIMARY KEY,
REVIEW_NO NUMBER,
ID VARCHAR2(30) NOT NULL,
LIKE_CHECK NUMBER DEFAULT 0 NOT NULL,
LIKE_DATE DATE DEFAULT SYSDATE NOT NULL
);
--------------------------------------------------------------------------------------------------------------
create table r_reply(
id varchar2(30),
r_reply_content varchar2(150),
r_reply_date date default sysdate,
r_write_group number,
r_reply_tag varchar2(30),
r_reply_no number primary key
);
--------------------------------------------------------------------------------------------------------------
create table review(
review_no number primary key,
review_title varchar2(110),
review_content varchar2(300),
review_hit_num number default 0,
review_like number,
review_date date default sysdate,
id varchar2(30),
r_reply_count number
);
--------------------------------------------------------------------------------------------------------------
create table r_photo(
id varchar2(30) not null,
origin_file_name varchar2(150),
stored_file_name varchar2(200),
r_write_group number not null,
photo_num number
);
--------------------------------------------------------------------------------------------------------------
create sequence qna_board_SEQ;
create sequence qna_reply_SEQ;
create sequence mylist_seq;
create sequence main_reply_seq;
create sequence review_seq_seq;
create sequence r_reply_no;
create sequence calendar_no_SEQ;
create SEQUENCE photo_num INCREMENT by 1 start with 1;
--------------------------------------------------------------------------------------------------------------
