-- 테이블 순서는 관계를 고려하여 한 번에 실행해도 에러가 발생하지 않게 정렬되었습니다.

-- Member Table Create SQL
CREATE TABLE Member
(
    member_num         NUMBER          NOT NULL, 
    member_id          VARCHAR2(20)    NOT NULL, 
    member_pw          VARCHAR2(20)    NOT NULL, 
    member_name        VARCHAR2(20)    NOT NULL, 
    member_reg_date    DATE            NOT NULL, 
    member_grade       NUMBER          NOT NULL, 
    member_new_date    DATE            NOT NULL, 
    member_phone       VARCHAR2(20)    NOT NULL, 
    member_photo       VARCHAR2(20)    NULL, 
    CONSTRAINT PK_Member PRIMARY KEY (member_num)
)
/

CREATE SEQUENCE Member_SEQ
START WITH 1
INCREMENT BY 1;
/

CREATE OR REPLACE TRIGGER Member_AI_TRG
BEFORE INSERT ON Member 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT Member_SEQ.NEXTVAL
    INTO :NEW.member_num
    FROM DUAL;
END;
/

--DROP TRIGGER Member_AI_TRG;
/

--DROP SEQUENCE Member_SEQ;
/

COMMENT ON TABLE Member IS '회원'
/

COMMENT ON COLUMN Member.member_num IS '회원번호'
/

COMMENT ON COLUMN Member.member_id IS '아이디'
/

COMMENT ON COLUMN Member.member_pw IS '비밀번호'
/

COMMENT ON COLUMN Member.member_name IS '이름'
/

COMMENT ON COLUMN Member.member_reg_date IS '가입날짜'
/

COMMENT ON COLUMN Member.member_grade IS '등급'
/

COMMENT ON COLUMN Member.member_new_date IS '수정날짜'
/

COMMENT ON COLUMN Member.member_phone IS '휴대폰번호'
/

COMMENT ON COLUMN Member.member_photo IS '사진'
/


-- Pet Table Create SQL
CREATE TABLE Pet
(
    pet_num       NUMBER          NOT NULL, 
    pet_name      VARCHAR2(20)    NOT NULL, 
    pet_type      VARCHAR2(20)    NOT NULL, 
    pet_adopt     NUMBER          NOT NULL, 
    pet_detail    CLOB            NOT NULL, 
    CONSTRAINT PK_Pet PRIMARY KEY (pet_num)
)
/

CREATE SEQUENCE Pet_SEQ
START WITH 1
INCREMENT BY 1;
/

CREATE OR REPLACE TRIGGER Pet_AI_TRG
BEFORE INSERT ON Pet 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT Pet_SEQ.NEXTVAL
    INTO :NEW.pet_num
    FROM DUAL;
END;
/

--DROP TRIGGER Pet_AI_TRG;
/

--DROP SEQUENCE Pet_SEQ;
/

COMMENT ON TABLE Pet IS '동물 입양 정보'
/

COMMENT ON COLUMN Pet.pet_num IS '동물번호'
/

COMMENT ON COLUMN Pet.pet_name IS '동물이름'
/

COMMENT ON COLUMN Pet.pet_type IS '동물종류'
/

COMMENT ON COLUMN Pet.pet_adopt IS '입양여부'
/

COMMENT ON COLUMN Pet.pet_detail IS '상세정보'
/


-- Volunteer Table Create SQL
CREATE TABLE Volunteer
(
    vol_num           NUMBER    NOT NULL, 
    vol_Member_num    NUMBER    NOT NULL, 
    Vol_date          DATE      NOT NULL, 
    Vol_time          NUMBER    NOT NULL, 
    Vol_reg_date      DATE      NOT NULL, 
    CONSTRAINT PK_Volunteer PRIMARY KEY (vol_num)
)
/

CREATE SEQUENCE Volunteer_SEQ
START WITH 1
INCREMENT BY 1;
/

CREATE OR REPLACE TRIGGER Volunteer_AI_TRG
BEFORE INSERT ON Volunteer 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT Volunteer_SEQ.NEXTVAL
    INTO :NEW.vol_num
    FROM DUAL;
END;
/

--DROP TRIGGER Volunteer_AI_TRG;
/

--DROP SEQUENCE Volunteer_SEQ;
/

COMMENT ON TABLE Volunteer IS '봉사 정보'
/

COMMENT ON COLUMN Volunteer.vol_num IS '봉사번호'
/

COMMENT ON COLUMN Volunteer.vol_Member_num IS '회원번호'
/

COMMENT ON COLUMN Volunteer.Vol_date IS '봉사날짜'
/

COMMENT ON COLUMN Volunteer.Vol_time IS '봉사시간'
/

COMMENT ON COLUMN Volunteer.Vol_reg_date IS '신청날짜'
/

ALTER TABLE Volunteer
    ADD CONSTRAINT FK_Volunteer_vol_Member_num_Me FOREIGN KEY (vol_Member_num)
        REFERENCES Member (member_num)
/


-- Adopt Table Create SQL
CREATE TABLE Adopt
(
    adopt_num           NUMBER          NOT NULL, 
    adopt_member_num    NUMBER          NOT NULL, 
    adopt_pet_num       NUMBER          NOT NULL, 
    adopt_date          DATE            NOT NULL, 
    adopt_reg           CLOB            NOT NULL, 
    adopt_married       NUMBER          NOT NULL, 
    adopt_house         VARCHAR2(20)    NOT NULL, 
    CONSTRAINT PK_Adopt PRIMARY KEY (adopt_num)
)
/

CREATE SEQUENCE Adopt_SEQ
START WITH 1
INCREMENT BY 1;
/

CREATE OR REPLACE TRIGGER Adopt_AI_TRG
BEFORE INSERT ON Adopt 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT Adopt_SEQ.NEXTVAL
    INTO :NEW.adopt_num
    FROM DUAL;
END;
/

--DROP TRIGGER Adopt_AI_TRG;
/

--DROP SEQUENCE Adopt_SEQ;
/

COMMENT ON TABLE Adopt IS '입양 신청'
/

COMMENT ON COLUMN Adopt.adopt_num IS '입양신청번호'
/

COMMENT ON COLUMN Adopt.adopt_member_num IS '회원번호'
/

COMMENT ON COLUMN Adopt.adopt_pet_num IS '동물번호'
/

COMMENT ON COLUMN Adopt.adopt_date IS '신청날짜'
/

COMMENT ON COLUMN Adopt.adopt_reg IS '자기소개'
/

COMMENT ON COLUMN Adopt.adopt_married IS '결혼여부'
/

COMMENT ON COLUMN Adopt.adopt_house IS '거주형태'
/

ALTER TABLE Adopt
    ADD CONSTRAINT FK_Adopt_adopt_member_num_Memb FOREIGN KEY (adopt_member_num)
        REFERENCES Member (member_num)
/

ALTER TABLE Adopt
    ADD CONSTRAINT FK_Adopt_adopt_pet_num_Pet_pet FOREIGN KEY (adopt_pet_num)
        REFERENCES Pet (pet_num)
/


-- Community Table Create SQL
CREATE TABLE Community
(
    com_num           NUMBER          NOT NULL, 
    com_title         VARCHAR2(20)    NOT NULL, 
    com_member_num    NUMBER          NOT NULL, 
    com_content       CLOB            NOT NULL, 
    com_date          DATE            NOT NULL, 
    com_hit           NUMBER          NOT NULL, 
    CONSTRAINT PK_Community PRIMARY KEY (com_num)
)
/

CREATE SEQUENCE Community_SEQ
START WITH 1
INCREMENT BY 1;
/

CREATE OR REPLACE TRIGGER Community_AI_TRG
BEFORE INSERT ON Community 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT Community_SEQ.NEXTVAL
    INTO :NEW.com_num
    FROM DUAL;
END;
/

--DROP TRIGGER Community_AI_TRG;
/

--DROP SEQUENCE Community_SEQ;
/

COMMENT ON TABLE Community IS '커뮤니티'
/

COMMENT ON COLUMN Community.com_num IS '게시글번호'
/

COMMENT ON COLUMN Community.com_title IS '제목'
/

COMMENT ON COLUMN Community.com_member_num IS '회원번호'
/

COMMENT ON COLUMN Community.com_content IS '내용'
/

COMMENT ON COLUMN Community.com_date IS '등록날짜'
/

COMMENT ON COLUMN Community.com_hit IS '조회수'
/

ALTER TABLE Community
    ADD CONSTRAINT FK_Community_com_member_num_Me FOREIGN KEY (com_member_num)
        REFERENCES Member (member_num)
/


-- Adopt_after Table Create SQL
CREATE TABLE Adopt_after
(
    after_num           NUMBER          NOT NULL, 
    after_pet_num       NUMBER          NOT NULL, 
    after_title         VARCHAR2(20)    NOT NULL, 
    after_content       CLOB            NOT NULL, 
    after_date          DATE            NOT NULL, 
    after_member_num    NUMBER          NOT NULL, 
    after_photo         VARCHAR2(20)    NOT NULL, 
    CONSTRAINT PK_Adopt_after PRIMARY KEY (after_num)
)
/

CREATE SEQUENCE Adopt_after_SEQ
START WITH 1
INCREMENT BY 1;
/

CREATE OR REPLACE TRIGGER Adopt_after_AI_TRG
BEFORE INSERT ON Adopt_after 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT Adopt_after_SEQ.NEXTVAL
    INTO :NEW.after_num
    FROM DUAL;
END;
/

--DROP TRIGGER Adopt_after_AI_TRG;
/

--DROP SEQUENCE Adopt_after_SEQ;
/

COMMENT ON TABLE Adopt_after IS '입양후기'
/

COMMENT ON COLUMN Adopt_after.after_num IS '후기번호'
/

COMMENT ON COLUMN Adopt_after.after_pet_num IS '동물번호'
/

COMMENT ON COLUMN Adopt_after.after_title IS '제목'
/

COMMENT ON COLUMN Adopt_after.after_content IS '내용'
/

COMMENT ON COLUMN Adopt_after.after_date IS '등록날짜'
/

COMMENT ON COLUMN Adopt_after.after_member_num IS '회원번호'
/

COMMENT ON COLUMN Adopt_after.after_photo IS '동물사진'
/

ALTER TABLE Adopt_after
    ADD CONSTRAINT FK_Adopt_after_after_pet_num_P FOREIGN KEY (after_pet_num)
        REFERENCES Pet (pet_num)
/

ALTER TABLE Adopt_after
    ADD CONSTRAINT FK_Adopt_after_after_member_nu FOREIGN KEY (after_member_num)
        REFERENCES Member (member_num)
/


-- Adopt_wait Table Create SQL
CREATE TABLE Adopt_wait
(
    wait_num           NUMBER          NOT NULL, 
    wait_pet_num       NUMBER          NOT NULL, 
    wait_title         VARCHAR2(20)    NOT NULL, 
    wait_content       CLOB            NOT NULL, 
    wait_date          DATE            NOT NULL, 
    wait_member_num    NUMBER          NOT NULL, 
    wait_photo         VARCHAR2(20)    NOT NULL, 
    CONSTRAINT PK_Adopt_wait PRIMARY KEY (wait_num)
)
/

CREATE SEQUENCE Adopt_wait_SEQ
START WITH 1
INCREMENT BY 1;
/

CREATE OR REPLACE TRIGGER Adopt_wait_AI_TRG
BEFORE INSERT ON Adopt_wait 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT Adopt_wait_SEQ.NEXTVAL
    INTO :NEW.wait_num
    FROM DUAL;
END;
/

--DROP TRIGGER Adopt_wait_AI_TRG;
/

--DROP SEQUENCE Adopt_wait_SEQ;
/

COMMENT ON TABLE Adopt_wait IS '입양대기'
/

COMMENT ON COLUMN Adopt_wait.wait_num IS '대기번호'
/

COMMENT ON COLUMN Adopt_wait.wait_pet_num IS '동물번호'
/

COMMENT ON COLUMN Adopt_wait.wait_title IS '제목'
/

COMMENT ON COLUMN Adopt_wait.wait_content IS '내용'
/

COMMENT ON COLUMN Adopt_wait.wait_date IS '등록날짜'
/

COMMENT ON COLUMN Adopt_wait.wait_member_num IS '회원번호'
/

COMMENT ON COLUMN Adopt_wait.wait_photo IS '동물사진'
/

ALTER TABLE Adopt_wait
    ADD CONSTRAINT FK_Adopt_wait_wait_pet_num_Pet FOREIGN KEY (wait_pet_num)
        REFERENCES Pet (pet_num)
/

ALTER TABLE Adopt_wait
    ADD CONSTRAINT FK_Adopt_wait_wait_member_num_ FOREIGN KEY (wait_member_num)
        REFERENCES Member (member_num)
/


