
CREATE TABLE member 
   ( ID varchar(30 ) NOT NULL , 
   PW varchar(110 ) NOT NULL , 
   ADDR1 varchar(20 ) NOT NULL , 
   ADDR2 varchar(110 ) NOT NULL , 
   ADDR3 varchar(110 ) NOT NULL , 
   EMAIL varchar(100 ) NOT NULL , 
   SESSION_ID varchar(100 ) DEFAULT 'nan' NOT NULL , 
   PHONE_int varchar(100 ) NOT NULL , 
   REGISTER_DATE DATE DEFAULT current_timestamp(),
   LIMIT_TIME DATE, 
    PRIMARY KEY (ID)
    );


--------------------------------------------------------------------------------------------------------------

CREATE TABLE qna_board
(
    qna_no         int(10), 
    qna_title      varchar(50)     NOT NULL, 
    qna_content    varchar(300)    NOT NULL, 
    qna_hit        int(4)default 0, 
    savedate       date default current_timestamp(), 
    qna_pwd        varchar(100), 
    id             varchar(20),
    PRIMARY KEY (qna_no)
);


--------------------------------------------------------------------------------------------------------------
CREATE TABLE qna_reply
(
    id                varchar(20)     NOT NULL, 
    qr_content        varchar(300)    NOT NULL, 
    qr_write_group    int(10),        
    savedate       date default current_timestamp(),
    qr_id int(4) primary key
);
--------------------------------------------------------------------------------------------------------------
CREATE TABLE calendar
(
    calendar_no  int(30)primary key, 
    id        varchar(50), 
    title    varchar(100),         
    start_date  varchar(100), 
    end_date varchar(100),  
    allday varchar(10)
);
--------------------------------------------------------------------------------------------------------------
CREATE TABLE mylist(
list_no int(10) PRIMARY KEY,  
id varchar(50),
place varchar(50),
image varchar(300)
);
--------------------------------------------------------------------------------------------------------------
CREATE TABLE main(
place_name varchar(50) NOT NULL,
main_category varchar(50) NOT NULL, 
content_one varchar(100) NOT NULL, 
content_two varchar(3000) NOT NULL,
main_image_file varchar(100) NOT NULL,
image_file1 varchar(150) NOT NULL, 
image_file2 varchar(150) NOT NULL,
latitude varchar(100) NOT NULL,
longitude varchar(100) NOT NULL,
address varchar(200) NOT NULL
);
--------------------------------------------------------------------------------------------------------------
create table main_LIKE(
rep_no int(10) NOT NULL,
id varchar(30) NOT NULL
);
--------------------------------------------------------------------------------------------------------------
CREATE TABLE main_reply(
rep_no int(10) PRIMARY KEY,
place_name varchar(100),
id varchar(50),
rep_content varchar(300) NOT NULL, 
likeHit int(10),
savedate date default current_timestamp()
);
--------------------------------------------------------------------------------------------------------------
CREATE TABLE R_LIKE(
LIKE_NO int NOT NULL PRIMARY KEY,
REVIEW_NO int,
ID varchar(30) NOT NULL,
LIKE_CHECK int DEFAULT 0 NOT NULL,
LIKE_DATE DATE DEFAULT current_timestamp() NOT NULL
);
--------------------------------------------------------------------------------------------------------------
create table r_reply(
id varchar(30),
r_reply_content varchar(150),
r_reply_date date default current_timestamp(),
r_write_group int,
r_reply_tag varchar(30),
r_reply_no int primary key
);
--------------------------------------------------------------------------------------------------------------
create table review(
review_no int primary key,
review_title varchar(110),
review_content varchar(300),
review_hit_num int default 0,
review_like int,
review_date date default current_timestamp(),
id varchar(30),
r_reply_count int
);
--------------------------------------------------------------------------------------------------------------
create table r_photo(
id varchar(30) not null,
origin_file_name varchar(150),
stored_file_name varchar(200),
r_write_group int not null,
photo_num int
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
