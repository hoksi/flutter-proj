# Flutter 학습 프로젝트

---

## 📌 최신 상태 요약 (2025-07-21)

- **마지막 완료 작업**: 4주차 학습 완료 (날씨 앱 완성 및 비동기 프로그래밍 학습)
- **다음에 할 일**: 5주차 학습 시작 (상태 관리 심화 및 아키텍처)

---

이 프로젝트는 Flutter와 Dart를 학습하고 실험하기 위한 공간입니다.

## 🧑‍💻 기술 스택 (Tech Stack)

- **Framework**: Flutter
- **Language**: Dart

## 📂 추천 디렉터리 구조 (Recommended Structure)

Flutter 프로젝트를 진행할 때 아래와 같은 구조를 따르는 것을 추천합니다.

- `lib/main.dart`: 앱의 시작점 (entry point) 입니다.
- `lib/screens`: 각 화면(페이지)에 해당하는 위젯들을 모아두는 곳입니다. (예: `home_screen.dart`, `detail_screen.dart`)
- `lib/widgets`: 여러 화면에서 공통으로 사용되는 작은 위젯들을 모아두는 곳입니다. (예: `custom_button.dart`)
- `lib/models`: 앱에서 사용하는 데이터 모델 클래스를 정의하는 곳입니다. (예: `user_model.dart`)
- `lib/services`: API 호출 등 백엔드 서비스를 처리하는 로직을 모아두는 곳입니다.
- `assets/`: 이미지, 폰트 등 정적 파일을 저장하는 곳입니다. (`pubspec.yaml` 파일에 등록해야 합니다.)

## ⚙️ 자주 사용하는 명령어 (Common Commands)

- **새로운 Flutter 프로젝트 생성**: `flutter create .` (현재 디렉터리에 생성)
- **앱 실행 (Android/iOS/Web)**: `flutter run`
- **사용 가능한 디바이스 확인**: `flutter devices`
- **의존성(패키지) 추가**: `flutter pub add [package_name]` (예: `flutter pub add provider`)
- **의존성(패키지) 설치**: `flutter pub get` (`pubspec.yaml` 파일 수정 후 실행)
- **테스트 실행**: `flutter test`
- **Flutter 버전 확인 및 업그레이드**: `flutter upgrade`
- **Windows 단독 실행 파일 빌드**: `flutter build windows` (릴리스 모드)

## ✍️ 코딩 컨벤션 (Coding Conventions)

- **파일 및 디렉터리 이름**: `snake_case` (예: `my_home_screen.dart`)
- **클래스, enum, typedef 이름**: `PascalCase` (예: `MyHomeScreen`)
- **변수, 상수, 함수 이름**: `camelCase` (예: `userName`, `calculateAge()`)
- **상수**: `k`로 시작하는 `camelCase` (예: `kDefaultPadding`)
- 가능한 `const` 키워드를 사용하여 불필요한 리빌드를 방지하세요.
- 위젯 트리를 깔끔하게 유지하기 위해 위젯을 작은 단위로 분리하는 것을 권장합니다.

## 📚 학습 자료 (Learning Resources)

- **Flutter 공식 문서**: [https://docs.flutter.dev/](https://docs.flutter.dev/)
- **Dart 공식 문서**: [https://dart.dev/guides](https://dart.dev/guides)
- **유용한 위젯 모음 (Widget of the Week)**: [https://www.youtube.com/playlist?list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG](https://www.youtube.com/playlist?list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG)
- **Google Codelabs (실습)**: [https://codelabs.developers.google.com/?cat=flutter](https://codelabs.developers.google.com/?cat=flutter)

## ⚠️ 참고사항 (Notes)

- UI를 구성할 때는 `StatelessWidget`과 `StatefulWidget`의 차이점을 이해하는 것이 중요합니다.
- `pubspec.yaml` 파일은 프로젝트의 설정 파일이므로, 수정한 후에는 꼭 `flutter pub get`을 실행해야 합니다.

---

## 🚀 진행 상황 (Progress)

### 1주차: Flutter & Dart 기초 다지기 완료

- **Flutter 개발 환경 설정 완료**: Android Studio 및 Flutter SDK 설치 확인.
- **첫 Flutter 프로젝트 생성 및 실행**:
    - `01.study` 디렉터리 이름 문제로 인해 `flutter create .` 실패.
    - `hello_flutter_01` 및 `hello_flutter_02` 디렉터리를 생성하여 프로젝트를 성공적으로 생성하고 Windows 데스크톱에서 실행 확인.
    - **Windows 단독 실행 파일(exe) 빌드 방법 확인**: `flutter build windows` 명령어를 통해 `build\windows\runner\Release` 경로에 독립 실행 파일이 생성됨을 확인.
- **`StatelessWidget` vs `StatefulWidget` 차이점 이해 완료**: `01-04.md` 파일에 내용 정리.
- **기본적인 위젯 사용해보기 완료**: `Text`, `Container`, `Icon`, `Image` 위젯 사용 예제 코드 확인 및 `hello_flutter_02` 프로젝트에 적용. `01-05.md` 파일에 내용 정리.

## 💡 다음 단계 (Next Steps)

### 2주차: UI 레이아웃 및 핵심 위젯 학습 시작

- **목표:** 다양한 위젯을 조합하여 기본적인 UI 화면을 구성합니다.
- **내용:**
  - **레이아웃 위젯 학습 (`Row`, `Column`, `Stack`, `Expanded`) 완료**: `02-01.md` 파일에 내용 정리 및 `hello_flutter_03` 프로젝트에서 예제 코드 확인.
  - **사용자 입력 처리 (`TextField`, `Button` 계열 위젯) 완료**: `02-02.md` 파일에 내용 정리 및 `hello_flutter_04` 프로젝트에서 예제 코드 확인.
  - **스크롤 가능한 뷰 만들기 (`ListView`, `GridView`) 완료**: `02-03.md` 파일에 내용 정리 및 `hello_flutter_05` 프로젝트에서 예제 코드 확인.
  - **`pubspec.yaml` 파일을 통해 외부 패키지 추가 및 사용 (`flutter pub add`) 완료**: `02-04.md` 파일에 내용 정리 및 `hello_flutter_06` 프로젝트에서 예제 코드 확인.

### 3주차: 네비게이션 및 상태 관리

- **목표:** 여러 화면을 가진 앱을 만들고 데이터를 관리하는 방법을 배웁니다.
- **내용:**
  - **화면 이동 구현 (`Navigator`, `MaterialPageRoute`) 완료**: `03-01.md` 파일에 내용 정리 및 `hello_flutter_07` 프로젝트에서 예제 코드 확인.
  - `setState`를 이용한 간단한 상태 관리
  - **상태 관리 라이브러리(Provider, GetX 등) 중 하나를 선택하여 기초 학습 완료**: `03-03.md` 파일에 내용 정리 및 `hello_flutter_09` 프로젝트에서 예제 코드 확인.
  - **데이터 모델 클래스 작성 (`lib/models` 디렉토리 활용) 완료**: `03-04.md` 파일에 내용 정리 및 `hello_flutter_10` 프로젝트에서 예제 코드 확인.

### 4주차: 실전 프로젝트 및 심화 학습 완료

- **목표:** 간단한 앱을 직접 만들면서 학습한 내용을 종합적으로 활용합니다.
- **내용:**
  - **미니 프로젝트: To-Do List 앱 만들기 완료**: `04-01.md` 파일에 내용 정리 및 `hello_flutter_todo` 프로젝트에서 예제 코드 확인.
    - UI 디자인 및 구현 완료
    - 데이터 저장 및 관리 (로컬 저장소 또는 간단한 API 연동) - `Provider`를 통한 상태 관리로 구현 완료
  - **미니 프로젝트: 날씨 앱 만들기 완료**: `04-02.md` 파일에 개요 및 초기 설정 내용 정리. `hello_flutter_weather` 프로젝트에서 최종 결과물 확인.
    - UI 디자인 및 구현 완료
    - 데이터 저장 및 관리 (로컬 저장소 `shared_preferences` 활용) 완료
  - **비동기 프로그래밍 (`Future`, `async`, `await`) 학습 완료**: `04-03.md` 파일에 내용 정리.
  - **`HTTP` 통신을 통해 외부 API 데이터 가져오기 (`http` 패키지 사용) 완료**: 날씨 앱 프로젝트에서 실제 적용 완료.

### 5주차: 상태 관리 심화 및 아키텍처

- **목표:** 더 복잡한 앱을 위한 상태 관리 패턴과 아키텍처를 학습합니다.
- **내용:**
  - **상태 관리 심화**: `Provider`의 다양한 기능(e.g., `ChangeNotifierProvider`, `Consumer`, `Selector`)을 심도 있게 학습합니다.
  - **아키텍처 패턴 소개**: MVC, MVVM 등 Flutter 앱에 적용할 수 있는 아키텍처 패턴의 기초를 학습합니다.
  - **미니 프로젝트: 뉴스 앱 만들기**: 학습한 상태 관리 및 아키텍처 패턴을 적용하여 외부 뉴스 API를 연동한 앱을 만듭니다.
    - UI 디자인 및 구현
    - `Provider`를 이용한 상태 관리
    - 간단한 MVVM 패턴 적용
