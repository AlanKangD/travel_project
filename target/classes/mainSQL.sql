
CREATE TABLE main( 
place_name VARCHAR2(50) primary key,
main_category VARCHAR2(50) NOT NULL, 
content_one VARCHAR2(100) NOT NULL, 
content_two VARCHAR2(800) NOT NULL,
main_image_file VARCHAR2(100) NOT NULL,
likeHit NUMBER(10),
upHit NUMBER(10),
latitude VARCHAR2(100) not null,
longitude VARCHAR2(100) not null,
address VARCHAR2(200) not null
);

create table mylist(
list_no int primary key,
id varchar2(50),
place varchar2(50),
image varchar2(300)
)
