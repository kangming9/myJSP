-- member Table Create SQL
CREATE TABLE member
(
    member_num      NUMBER          NOT NULL, 
    member_id       VARCHAR2(20)    NOT NULL, 
    member_grade    NUMBER          DEFAULT 3 NOT NULL, 
    CONSTRAINT PK_member PRIMARY KEY (member_num)
)
/

CREATE SEQUENCE member_SEQ
START WITH 1
INCREMENT BY 1;
/

COMMENT ON TABLE member IS '사이트에 가입한 회원의 정보(탈퇴 후에도 삭제되지 않는 정보)'
/

COMMENT ON COLUMN member.member_num IS '회원번호'
/

COMMENT ON COLUMN member.member_id IS '아이디'
/

COMMENT ON COLUMN member.member_grade IS '등급'
/

-- pet Table Create SQL
CREATE TABLE pet
(
    pet_num       NUMBER          NOT NULL, 
    pet_name      VARCHAR2(20)    NOT NULL, 
    pet_type      VARCHAR2(20)    NOT NULL, 
    pet_adopt     NUMBER          DEFAULT 0 NOT NULL, 
    pet_detail    CLOB            NOT NULL, 
    pet_date      DATE            DEFAULT sysdate NOT NULL, 
    pet_photo     VARCHAR2(150)    NOT NULL, 
    CONSTRAINT PK_pet PRIMARY KEY (pet_num)
)
/

CREATE SEQUENCE pet_SEQ
START WITH 1
INCREMENT BY 1;
/

COMMENT ON TABLE pet IS '동물의 입양 정보와 그 정보를 남기는 게시글(기다리개)'
/

COMMENT ON COLUMN pet.pet_num IS '동물번호'
/

COMMENT ON COLUMN pet.pet_name IS '동물이름'
/

COMMENT ON COLUMN pet.pet_type IS '동물종류'
/

COMMENT ON COLUMN pet.pet_adopt IS '입양여부'
/

COMMENT ON COLUMN pet.pet_detail IS '상세정보'
/

COMMENT ON COLUMN pet.pet_date IS '등록날짜'
/

COMMENT ON COLUMN pet.pet_photo IS '동물사진'
/

-- volunteer Table Create SQL
CREATE TABLE volunteer
(
    vol_num           NUMBER    NOT NULL, 
    vol_member_num    NUMBER    NOT NULL, 
    vol_date          DATE      NOT NULL, 
    vol_time          NUMBER    NOT NULL, 
    vol_checked		  NUMBER    DEFAULT 0 NOT NULL;
    vol_reg_date      DATE      DEFAULT sysdate NOT NULL, 
    CONSTRAINT PK_volunteer PRIMARY KEY (vol_num)
)
/

CREATE SEQUENCE volunteer_SEQ
START WITH 1
INCREMENT BY 1;
/

COMMENT ON TABLE volunteer IS '봉사를 신청하는 양식(힘드냥 도울개)'
/

COMMENT ON COLUMN volunteer.vol_num IS '봉사번호'
/

COMMENT ON COLUMN volunteer.vol_member_num IS '회원번호'
/

COMMENT ON COLUMN volunteer.vol_date IS '봉사날짜'
/

COMMENT ON COLUMN volunteer.vol_time IS '봉사시간'
/

COMMENT ON COLUMN volunteer.vol_checked IS '봉사수행여부'
/

COMMENT ON COLUMN volunteer.vol_reg_date IS '신청날짜'
/

ALTER TABLE volunteer
    ADD CONSTRAINT FK_volunteer_vol_member_num_me FOREIGN KEY (vol_member_num)
        REFERENCES member (member_num)
/


-- adopt Table Create SQL
CREATE TABLE adopt
(
    adopt_num           NUMBER          NOT NULL, 
    adopt_member_num    NUMBER          NOT NULL, 
    adopt_pet_num       NUMBER          NOT NULL, 
    adopt_date          DATE            DEFAULT sysdate NOT NULL, 
    adopt_intro         CLOB            NOT NULL, 
    adopt_married       NUMBER          NOT NULL, 
    adopt_house         VARCHAR2(20)    NOT NULL, 
    adopt_now           NUMBER          DEFAULT 0 NOT NULL, 
    adopt_why           CLOB            NULL, 
    CONSTRAINT PK_adopt PRIMARY KEY (adopt_num)
)
/

CREATE SEQUENCE adopt_SEQ
START WITH 1
INCREMENT BY 1;
/

COMMENT ON TABLE adopt IS '원하는 동물을 입양 신청하는 게시글'
/

COMMENT ON COLUMN adopt.adopt_num IS '입양신청번호'
/

COMMENT ON COLUMN adopt.adopt_member_num IS '회원번호'
/

COMMENT ON COLUMN adopt.adopt_pet_num IS '동물번호'
/

COMMENT ON COLUMN adopt.adopt_date IS '신청날짜'
/

COMMENT ON COLUMN adopt.adopt_intro IS '자기소개'
/

COMMENT ON COLUMN adopt.adopt_married IS '결혼여부'
/

COMMENT ON COLUMN adopt.adopt_house IS '거주형태'
/

COMMENT ON COLUMN adopt.adopt_now IS '신청처리상태'
/

COMMENT ON COLUMN adopt.adopt_why IS '사유'
/

ALTER TABLE adopt
    ADD CONSTRAINT FK_adopt_adopt_member_num_memb FOREIGN KEY (adopt_member_num)
        REFERENCES member (member_num)
/

ALTER TABLE adopt
    ADD CONSTRAINT FK_adopt_adopt_pet_num_pet_pet FOREIGN KEY (adopt_pet_num)
        REFERENCES pet (pet_num)
/

-- community Table Create SQL
CREATE TABLE community
(
    com_num           NUMBER          NOT NULL, 
    com_title         VARCHAR2(20)    NOT NULL, 
    com_member_num    NUMBER          NOT NULL, 
    com_content       CLOB            NOT NULL, 
    com_date          DATE            DEFAULT sysdate NOT NULL, 
    com_hit           NUMBER          DEFAULT 0 NOT NULL, 
    CONSTRAINT PK_community PRIMARY KEY (com_num)
)
/

CREATE SEQUENCE community_SEQ
START WITH 1
INCREMENT BY 1;
/

COMMENT ON TABLE community IS '회원들이 자율적으로 남길 수 있는 게시글(멍냥토크)'
/

COMMENT ON COLUMN community.com_num IS '게시글번호'
/

COMMENT ON COLUMN community.com_title IS '제목'
/

COMMENT ON COLUMN community.com_member_num IS '회원번호'
/

COMMENT ON COLUMN community.com_content IS '내용'
/

COMMENT ON COLUMN community.com_date IS '등록날짜'
/

COMMENT ON COLUMN community.com_hit IS '조회수'
/

ALTER TABLE community
    ADD CONSTRAINT FK_community_com_member_num_me FOREIGN KEY (com_member_num)
        REFERENCES member (member_num)
/


-- adopt_after Table Create SQL
CREATE TABLE adopt_after
(
    after_num           NUMBER          NOT NULL, 
    after_pet_num       NUMBER          NOT NULL, 
    after_title         VARCHAR2(20)    NOT NULL, 
    after_content       CLOB            NOT NULL, 
    after_date          DATE            DEFAULT sysdate NOT NULL, 
    after_member_num    NUMBER          NOT NULL, 
    after_photo         VARCHAR2(150)    NOT NULL, 
    CONSTRAINT PK_adopt_after PRIMARY KEY (after_num)
)
/

CREATE SEQUENCE adopt_after_SEQ
START WITH 1
INCREMENT BY 1;
/

COMMENT ON TABLE adopt_after IS '입양한 동물의 후기를 작성하는 게시글(찾았냥?묘?냥?묘?)'
/

COMMENT ON COLUMN adopt_after.after_num IS '후기번호'
/

COMMENT ON COLUMN adopt_after.after_pet_num IS '동물번호'
/

COMMENT ON COLUMN adopt_after.after_title IS '제목'
/

COMMENT ON COLUMN adopt_after.after_content IS '내용'
/

COMMENT ON COLUMN adopt_after.after_date IS '등록날짜'
/

COMMENT ON COLUMN adopt_after.after_member_num IS '회원번호'
/

COMMENT ON COLUMN adopt_after.after_photo IS '동물사진'
/

ALTER TABLE adopt_after
    ADD CONSTRAINT FK_adopt_after_after_pet_num_p FOREIGN KEY (after_pet_num)
        REFERENCES pet (pet_num)
/

ALTER TABLE adopt_after
    ADD CONSTRAINT FK_adopt_after_after_member_nu FOREIGN KEY (after_member_num)
        REFERENCES member (member_num)
/


-- member_detail Table Create SQL
CREATE TABLE member_detail
(
    member_detail_num         NUMBER          NOT NULL, 
    member_detail_pw          VARCHAR2(20)    NOT NULL, 
    member_detail_name        VARCHAR2(20)    NOT NULL, 
    member_detail_reg_date    DATE            DEFAULT sysdate NOT NULL, 
    member_detail_new_date    DATE            DEFAULT sysdate NOT NULL, 
    member_detail_phone       VARCHAR2(20)    NOT NULL, 
    member_detail_photo       VARCHAR2(150)    NULL, 
    CONSTRAINT PK_member_detail PRIMARY KEY (member_detail_num)
)
/

CREATE SEQUENCE member_detail_SEQ
START WITH 1
INCREMENT BY 1;
/

COMMENT ON TABLE member_detail IS '사이트에 가입한 회원의 정보(탈퇴 후 삭제되는 정보)'
/

COMMENT ON COLUMN member_detail.member_detail_num IS '회원번호'
/

COMMENT ON COLUMN member_detail.member_detail_pw IS '비밀번호'
/

COMMENT ON COLUMN member_detail.member_detail_name IS '이름'
/

COMMENT ON COLUMN member_detail.member_detail_reg_date IS '가입날짜'
/

COMMENT ON COLUMN member_detail.member_detail_new_date IS '수정날짜'
/

COMMENT ON COLUMN member_detail.member_detail_phone IS '휴대폰번호'
/

COMMENT ON COLUMN member_detail.member_detail_photo IS '사진'
/

ALTER TABLE member_detail
    ADD CONSTRAINT FK_member_detail_member_detail FOREIGN KEY (member_detail_num)
        REFERENCES member (member_num)
/


ALTER TABLE adopt MODIFY adopt_house varchar2(150);

/*댓글*/
create table community_reply(
	re_num number not null,
	re_content varchar2(900) not null,
	re_date date default sysdate not null,
	com_num number not null,
	member_num number not null,
	constraint reply_pk primary key (re_num),
	constraint reply_fk foreign key (com_num) references community (com_num),
	constraint reply_fk2 foreign key (member_num) references member (member_num)
);

create sequence reply_seq
START WITH 1
INCREMENT BY 1;

