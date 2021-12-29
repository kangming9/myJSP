# myJSP

# readme.md

* 웹 프로젝트(유기동물 입양센터 홈페이지)에 대한 소개
* 각 화면별 기능
* 개발 환경
* 팀원 및 역할 소개

# Description

동물들과 공존하는 삶의 소중함과 가치를 널리 알리고 더불어 사는 삶에 대한 소중함을 깨닫기 위한 유기동물 입양센터 홈페이지(웹 프로젝트)

* 화면
  * Header
  * Footer
  * Login / Join
  * Main / Introduce
  * Dodation
  * Volunteer
  * Adopt / After
  * Community

# Header

메인으로 이동할 수 있는 로고와 각 게시판으로 이동하는 하이퍼링크, 로그인 정보로 구성

# Footer

입양센터 정보와 SNS로 이동할 수 있는 로고로 구성

# Login / Join

아이디(중복 불허), 이름, 비밀번호, 전화번호를 활용한 가입
가입된 아이디와 비밀번호를 통해 로그인 가능(탈퇴 회원 제외)
관리자는 관리자 페이지, 일반 회원은 마이페이지 기능이 활성화

* 관리자 페이지 : 회원 및 후원자 관리, 입양 및 봉사신청 신청 관리(승인/반려) 등의 기능
* 마이페이지 : 계정 관리, 작성한 글과 댓글 확인, 탈퇴 등의 기능

# Main / Introduce

입양센터와 각 게시판에 대한 소개글로 구성

# Dodation

후원자와 후원에 대한 정보를 등록하는 폼으로 구성

# Volunteer

날짜별 봉사활동 신청 현황을 확인할 수 있는 캘린더 - 클릭 시 시간별로 해당 날짜의 봉사자 수를 확인 가능
원하는 날짜 및 시간에 봉사를 신청하고 취소할 수 있는 폼 작성 가능

* 각 날짜 및 시간별로 제한된 인원수를 초과할 경우, 신청 불가
* 이미 봉사를 신청했을 경우, 취소 혹은 진행 전까지 신청 불가

# Adopt / After

입양을 기다리고 있는 동물에 대한 글 리스트와 각 글의 상세 페이지,
입양한 후의 후기 리스트와 각 후기글의 상세 페이지로 구성

* 일정 조건을 달성한 회원은 상세 페이지에서 입양 신청 가능 - 폼으로 이동
* 각 신청은 관리자의 승인이 있어야 입양 완료 처리
* 글이 작성된 날짜로부터 하루동안 [새로왔냥!]이라는 문구가 제목 앞에 생성

# Community

회원만 작성할 수 있는 게시글 리스트와 각 글의 상세 페이지로 구성

* 게시글은 제목, 작성자, 내용으로 구성되고 댓글과 조회수를 확인 가능
* 게시글 리스트에서 댓글 수를 확인 가능
* 각 게시글의 상세 페이지에서 댓글 작성 가능

# Environment

* OS : Windows 10 Home
* Server : Apache Tomcat v.9.0
* DBMS : Oracle 11g Release2
* Language : Java, HTML5, CSS3, Javascript, JSP, SQL 

# Team

* e-jo216 : Main / Introduce, Footer, Donation, Volunteer
* eheh10 : Login, Join, MyPage, Adopt - AdoptForm, Community
* kangming9 : Adopt - After, Community
* ryuyj96 : Community
* heeyun(yunniez) : Adopt, Community

멍냥멍냥🐈
==================
* 개발인원 : 5명
* 개발기간 : 약 2주

-----------------
## + 소개
> 매년 반려동물 입양 추이가 늘어가는 만큼 유기되는 동물 또한 늘어가고 있습니다.
> 유기동물이 다시 사랑받을 수 있도록 정보를 관리하고 홍보하여 새로운 주인을 만날 수 있도록 합니다.

<p></p>

## + 개발 환경
* OS : windows 10 Home
* Server : Apache Tomcat v9.0
* DBMS : Oracle 11 Release2
* Language : Java / HTML / CSS / Javascript / JSP / SQL

<p></p>

## + 화면구성
* 로그인 / 회원가입
* 메인페이지 / 관리자페이지
* 후원 페이지 / 봉사활동 신청페이지
* 입양대기 동물 페이지
* 입양후기 페이지
* 커뮤니티 게시판

<p></p>

----------------
## + 담당 기능

#### 입양후기 게시판 #1
<img width="348" alt="1" src="https://user-images.githubusercontent.com/90167498/147642646-485054c8-5b17-4c20-89b4-455a1b907ae5.PNG">

#### 입양후기 게시판 상세 #2
<img width="408" alt="2" src="https://user-images.githubusercontent.com/90167498/147642650-64eb3e8e-9044-48d9-ac78-31ed9d1b6a4c.PNG">

#### 커뮤니티 게시판 #3
![3](https://user-images.githubusercontent.com/90167498/147642661-7e23c946-a2cf-4b74-85c9-7c8ad039c303.png)

#### 커뮤니티 게시판 상세 #4
![4](https://user-images.githubusercontent.com/90167498/147642695-00a8a48a-b907-489b-8de5-732adfb5942c.png)







