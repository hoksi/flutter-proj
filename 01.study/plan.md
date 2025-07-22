# Flutter 학습 계획

이 계획은 Flutter를 처음 시작하는 분들을 위해 4주 과정으로 구성되었습니다. 각 주차별 목표를 달성하며 Flutter 개발에 익숙해지는 것을 목표로 합니다.

## 1주차: Flutter & Dart 기초 다지기

- **목표:** Dart 언어의 기본 문법을 익히고 Flutter 개발 환경을 설정합니다.
- **내용:**
  - Dart 언어 기초 학습 (변수, 함수, 클래스, 제어문)
  - Flutter 개발 환경 설정 (Flutter SDK, Android Studio/VS Code 설치)
  - 첫 Flutter 프로젝트 생성 및 실행 (`flutter create`, `flutter run`)
  - `StatelessWidget` vs `StatefulWidget`의 차이점 이해
  - 기본적인 위젯 사용해보기 (`Text`, `Container`, `Icon`, `Image`)

## 2주차: UI 레이아웃 및 핵심 위젯

- **목표:** 다양한 위젯을 조합하여 기본적인 UI 화면을 구성합니다.
- **내용:**
  - 레이아웃 위젯 학습 (`Row`, `Column`, `Stack`, `Expanded`)
  - 사용자 입력 처리 (`TextField`, `Button` 계열 위젯)
  - 스크롤 가능한 뷰 만들기 (`ListView`, `GridView`)
  - `pubspec.yaml` 파일을 통해 외부 패키지 추가 및 사용 (`flutter pub add`)

## 3주차: 네비게이션 및 상태 관리

- **목표:** 여러 화면을 가진 앱을 만들고 데이터를 관리하는 방법을 배웁니다.
- **내용:**
  - 화면 이동 구현 (`Navigator`, `MaterialPageRoute`)
  - `setState`를 이용한 간단한 상태 관리
  - 상태 관리 라이브러리(Provider, GetX 등) 중 하나를 선택하여 기초 학습
  - 데이터 모델 클래스 작성 (`lib/models` 디렉토리 활용)

## 4주차: 실전 프로젝트 및 심화 학습

- **목표:** 간단한 앱을 직접 만들면서 학습한 내용을 종합적으로 활용합니다.
- **내용:**
  - **미니 프로젝트:** 간단한 "To-Do List" 또는 "날씨 앱" 만들기
    - UI 디자인 및 구현
    - 데이터 저장 및 관리 (로컬 저장소 또는 간단한 API 연동)
  - 비동기 프로그래밍 (`Future`, `async`, `await`) 학습
  - `HTTP` 통신을 통해 외부 API 데이터 가져오기 (`http` 패키지 사용)
  - `GEMINI.md` 파일의 학습 자료를 참고하여 추가 학습 진행

---

**조언:**
- 매일 꾸준히 코딩하는 습관을 들이는 것이 중요합니다.
- 공식 문서를 자주 참고하고, 궁금한 점은 적극적으로 검색해보세요.
- 작은 성공을 자주 경험하며 흥미를 잃지 않도록 노력하세요.
