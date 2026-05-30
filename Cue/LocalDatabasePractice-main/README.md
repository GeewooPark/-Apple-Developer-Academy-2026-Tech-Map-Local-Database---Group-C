# Persistence Co Lab

Apple Developer Academy 러너가 3주 동안 로컬 데이터 저장 방식을 직접 써 보고 비교하는 Tech Map입니다.

## 구성

| 주차 | 방식 | 내용 | 결과물 |
| --- | --- | --- | --- |
| Week 1 | 킥오프 30분 | 저장 방식 소개, 학습할 주제 선택, 페어 배정 | 학습 목표 |
| Week 2 | 자율 학습 | 공식 문서 읽기, 추가 리소스 찾기, 작은 샘플 만들기 | 샘플 앱, 학습 노트 |
| Week 3 | Wrap 60분 | 데모, 코드 워크쓰루, 서로 리뷰 | README, 리뷰 코멘트 |

## 배울 수 있는 것

- `UserDefaults`, `FileManager`, `SwiftData`가 각각 어떤 상황에 맞는지 구분합니다.
- 앱을 껐다 켜도 데이터가 남는 흐름을 직접 확인합니다.
- 저장, 읽기, 삭제 코드가 어디에서 실행되는지 설명합니다.
- 장점과 한계를 README에 정리하고 다른 페어의 코드를 리뷰합니다.

## 실습 앱

이 프로젝트는 SwiftUI로 만든 작은 실습 앱입니다. 화면은 세 탭으로 나뉩니다.

- `UserDefaultsPracticeView`는 `@AppStorage`로 설정값을 저장합니다.
- `FileManagerPracticeView`는 로그를 JSON 파일로 저장합니다.
- `SwiftDataPracticeView`는 노트를 만들고 지우며 `@Model`, `@Query`, `modelContext`를 봅니다.

뷰는 최대한 얇게 두었습니다. 저장 방식이 어디에서 갈리는지 보는 것이 목적입니다.

## 선택 기준

세 방식은 서로 대체재라기보다 쓰임이 다릅니다. 저장하려는 데이터의 크기, 모양, 조회 방식에 따라 고르면 됩니다.

| 저장 방식 | 주로 쓰는 때 | 예시 |
| --- | --- | --- |
| `UserDefaults` | 값이 작고 앱 설정에 가까울 때 | 테마, 온보딩 완료 여부, 마지막 선택값 |
| `FileManager` | 파일 자체를 저장하거나 앱 밖으로 내보낼 수 있어야 할 때 | 이미지, JSON 로그, 첨부 파일 |
| `SwiftData` | 여러 개의 모델을 만들고 검색하고 삭제해야 할 때 | 노트, 할 일, 북마크, 일기 |

### UserDefaults

작은 설정값에 적합합니다. 앱의 동작을 바꾸는 개인 설정이나 마지막 상태를 남길 때 주로 씁니다.

- 좋은 예시: 테마, 온보딩 완료 여부, 마지막으로 고른 탭
- 피할 예시: 민감 정보, 이미지, 큰 배열, 복잡한 모델
- 볼 코드: `@AppStorage`, key 이름, 기본값

### FileManager

파일 자체를 다룰 때 적합합니다. 데이터베이스처럼 검색하기보다, 파일을 저장하고 다시 읽거나 내보내는 상황에 주로 씁니다.

- 좋은 예시: JSON 로그, 이미지 캐시, 첨부 파일
- 피할 예시: 자주 검색하고 정렬해야 하는 관계형 데이터
- 볼 코드: Documents 폴더, `Codable`, atomic write

### SwiftData

앱 안에서 계속 만들고 수정하고 삭제하는 구조화된 데이터에 적합합니다. 목록 화면에서 여러 항목을 보여주고, 조건에 따라 정렬하거나 필터링할 때 주로 씁니다.

- 좋은 예시: 노트, 할 일, 북마크, 일기
- 피할 예시: 단일 설정값, 단순 파일 캐시
- 볼 코드: `@Model`, `ModelContainer`, `@Query`, `modelContext.insert`, `modelContext.delete`

## 제출 README에 들어가면 좋은 내용

- 선택한 저장 방식과 이유
- 장점 2개 이상
- 한계 2개 이상
- 내 프로젝트에 적용할 때 조심할 점
- 실행 방법
- 참고 리소스
- 페어 리뷰 링크

## 참고 공식 문서

- UserDefaults  
  https://developer.apple.com/documentation/foundation/userdefaults
- AppStorage  
  https://developer.apple.com/documentation/swiftui/appstorage
- FileManager  
  https://developer.apple.com/documentation/foundation/filemanager
- ModelContainer  
  https://developer.apple.com/documentation/swiftdata/modelcontainer

## 실행 방법

Xcode에서 `LocalDatabasePractice.xcodeproj`를 열고 iPhone 시뮬레이터로 실행합니다.
