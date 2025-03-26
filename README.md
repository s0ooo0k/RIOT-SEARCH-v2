# 🎯 TFT SEARCH 

[Riot API 기반 전적 검색 + 커뮤니티 기능이 포함된 웹 플랫폼]

> 📊 **Teamfight Tactics (TFT)** 플레이어들의 전적을 실시간으로 조회하고, 자신의 플레이 기록을 커뮤니티에 공유해보세요!

---

## 🧭 프로젝트 소개

**TFT Summoner Stats**는 Riot Games의 Teamfight Tactics(TFT) 플레이어를 위한 웹 애플리케이션입니다.  
플레이어의 소환사 정보, 매치 히스토리, 티어 등을 실시간으로 조회하고, 다른 플레이어들과 자신의 기록 **공유**할 수 있는 커뮤니티 기능도 제공합니다.

---
## ✨ 주요 기능

- 🔍 **소환사 정보 검색** (username + tag)
- 🧾 **TFT 매치 히스토리 조회**
- 🏆 **개인 티어 및 랭크 확인**
- 📝 **티어 공유**

---

## 🛠️ 기술 스택

### Backend+Frontend
![Java](https://img.shields.io/badge/Java-ED8B00?style=flat&logo=OpenJDK&logoColor=white)
![Spring](https://img.shields.io/badge/Spring%20MVC-6DB33F?style=flat&logo=Spring&logoColor=white)
![JDBC](https://img.shields.io/badge/JDBC-007396?style=flat) 
![JSP](https://img.shields.io/badge/JSP-007396?style=flat)
![HTML](https://img.shields.io/badge/HTML-E34F26?style=flat&logo=html5&logoColor=white)
![CSS](https://img.shields.io/badge/CSS-1572B6?style=flat&logo=css3&logoColor=white)

### API  
![Riot Games API](https://img.shields.io/badge/Riot%20Games%20API-EB0029?style=flat&logo=riot-games&logoColor=white)

### Database  
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=flat&logo=mysql&logoColor=white)

### Dependencies  
- Jackson (JSON 파싱)
- dotenv (환경 변수 설정)
- SLF4J (로깅)

----
## 📂 프로젝트 구조
```sh
src/main/java/io/github/s0ooo0k/tftv2/
├── config/           # Spring 설정 파일
├── controller/       # 웹 요청 처리 컨트롤러
├── model/
│   ├── dto/          # 데이터 전송 객체
│   └── repository/   # 데이터베이스 접근 로직
├── service/          # 비즈니스 로직
└── util/             # 유틸리티 클래스
```

## 💡 향후 개선 예정

- 🔐 **OAuth 2.0 소셜 로그인 연동**
- 🦔 **Gemini LLM 연동을 통한 게임 조언**
- 📈 **상세한 매치 통계 및 분석 기능 추가**
- 📱 **반응형 UI로 모바일 대응**
- 💬 **댓글 / 좋아요 기능 등 커뮤니티 확장**
- ⚡ **캐싱을 통한 API 호출 최적화**

---

## 📚 이 프로젝트를 통해 배운 점

- ⚙️ **Spring MVC 구조에 대한 실전 감각**  
  컨트롤러-서비스-레포지토리 계층 분리를 직접 구현하며 Spring MVC의 흐름을 체득했습니다.
  
- 🔌 **외부 API(Riot API) 연동 경험**  
  인증 키 관리부터 API 호출, 응답 파싱까지 전 과정을 경험할 수 있었습니다.
  
- 🧵 **JDBC를 활용한 DB 연동 및 설계 능력 향상**  
  MySQL과 직접 연결하고 쿼리를 작성하며, 데이터 흐름과 SQL 설계 능력을 실무적으로 키웠습니다.

- 🧱 **DTO와 도메인 분리의 중요성**  
  외부 API와 DB 응답 형식이 다를 때, DTO를 사용해 안정적으로 데이터를 변환하는 방식에 익숙해졌습니다.

- 🧰 **예외 처리 및 로깅의 필요성 체감**  
  예상치 못한 API 응답 오류나 네트워크 이슈를 처리하며, SLF4J를 활용한 로깅의 중요성을 깨달았습니다.

- 💡 **유저 중심 기능 설계 경험**  
  단순 전적 조회를 넘어서 커뮤니티 기능을 붙이며 사용자 경험을 고려한 기능 기획과 UI 흐름을 고민하게 되었습니다.

---

## 📝 라이선스 및 저작권

이 프로젝트는 Riot Games의 API를 사용하고 있으며, Riot Games는 본 프로젝트의 후원 또는 지원과는 무관합니다.  
[Riot Games Developer Portal](https://developer.riotgames.com/)에서 제공하는 데이터를 활용하고 있습니다.  
서비스 이용 시 Riot API 정책을 준수해야 합니다.

> 🔒 Riot Games 및 Teamfight Tactics는 Riot Games, Inc.의 상표입니다.


