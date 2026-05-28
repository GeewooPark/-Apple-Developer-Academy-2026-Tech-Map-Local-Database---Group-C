# FileManager

> 파일 시스템의 내용에 접근하고, 파일 시스템과 상호작용할 수 있는 편리한 인터페이스

```
class FileManager
```

**지원 플랫폼**
iOS 2.0+ · iPadOS 2.0+ · Mac Catalyst 13.0+ · macOS 10.0+ · tvOS 9.0+ · visionOS 1.0+ · watchOS 2.0+

---

## 개요

`FileManager` 객체는 파일 시스템의 내용을 살펴보고 변경할 수 있게 해주는 도구. 쉽게 말해, 앱에서 **파일이나 폴더를 다루고 싶을 때 사용하는 객체**임.

이 객체로 할 수 있는 일:

- 파일/폴더의 **위치 찾기**
- 파일/폴더 **생성, 복사, 이동, 삭제**
- 파일/폴더의 **정보(속성) 확인 및 변경**

파일 위치를 지정할 때는 `URL` 또는 `String` 둘 다 사용 가능하지만, **`URL` 사용이 권장됨**. 내부적으로 더 효율적이고, 나중에 파일을 다시 찾을 때 유용한 "북마크" 기능도 제공하기 때문.

iOS 5.0 / macOS 10.7부터는 **iCloud**에 저장된 파일을 관리하는 기능도 포함되어 있어, 사용자의 여러 기기 간에 파일을 자동으로 동기화할 수 있음.

### 동기화 제어

**패키지(package)** 는 여러 개의 파일을 담고 있지만 사용자에게는 하나의 파일처럼 보이는 폴더. iOS 26 / macOS 26부터는 패키지를 열거나 닫을 때 동기화를 잠깐 멈췄다가 다시 시작할 수 있어서, 파일이 꼬이는 문제를 막을 수 있음.

### 스레드 안전성

공유 `FileManager` 객체는 **여러 스레드에서 동시에 사용해도 안전함**. 다만 델리게이트로 작업 상태를 받으려면, 따로 인스턴스를 만들어 사용해야 함.

---

## Topics

### Creating a file manager

- `convenience init(authorization:)` — 권한이 필요한 파일 시스템 작업을 수행할 수 있는 파일 매니저 초기화
- `class var default: FileManager` — 프로세스의 공유 파일 매니저 객체

### Accessing user directories

- `var homeDirectoryForCurrentUser: URL` — 현재 사용자의 홈 디렉터리
- `func NSHomeDirectory() -> String` — 사용자 또는 앱의 홈 디렉터리 경로 반환
- `func NSUserName() -> String` — 현재 사용자의 로그온 이름
- `func NSFullUserName() -> String` — 현재 사용자의 전체 이름
- `func homeDirectory(forUser:) -> URL?` — 지정한 사용자의 홈 디렉터리
- `func NSHomeDirectoryForUser(_:) -> String?` — 지정한 사용자의 홈 디렉터리 경로
- `var temporaryDirectory: URL` — 현재 사용자의 임시 디렉터리
- `func NSTemporaryDirectory() -> String` — 임시 디렉터리 경로

### Locating system directories

- `func url(for:in:appropriateFor:create:)` — 도메인 내 공통 디렉터리를 찾고, 필요시 생성
- `func urls(for:in:)` — 요청한 도메인의 공통 디렉터리 URL 배열 반환
- `func NSSearchPathForDirectoriesInDomains(_:_:_:)` — 디렉터리 검색 경로 리스트 생성
- `func NSOpenStepRootDirectory() -> String` — 사용자 시스템의 루트 디렉터리

### Locating application group container directories

- `func containerURL(forSecurityApplicationGroupIdentifier:)` — 보안 앱 그룹 식별자와 연결된 컨테이너 디렉터리
- `App Groups Entitlement` — 앱이 속한 그룹의 식별자 리스트

### Discovering directory contents

- `func contentsOfDirectory(at:includingPropertiesForKeys:options:)` — 디렉터리의 직속 자식만 검색해 URL 배열 반환
- `func contentsOfDirectory(atPath:)` — 디렉터리의 직속 자식 경로 배열 반환
- `func enumerator(at:includingPropertiesForKeys:options:errorHandler:)` — 디렉터리를 깊이 탐색하는 열거자 반환
- `func enumerator(atPath:)` — 경로 기반 깊이 탐색 열거자 반환
- `class DirectoryEnumerator` — 디렉터리 콘텐츠를 열거하는 객체
- `func mountedVolumeURLs(includingResourceValuesForKeys:options:)` — 마운트된 볼륨 URL 배열 반환
- `struct VolumeEnumerationOptions` — 마운트된 볼륨 열거 옵션
- `func subpathsOfDirectory(atPath:)` — 모든 하위 디렉터리 경로 반환
- `func subpaths(atPath:)` — 디렉터리 안 모든 항목 경로 배열 반환

### Creating and deleting items

- `func createDirectory(at:withIntermediateDirectories:attributes:)` — URL에 디렉터리 생성
- `func createDirectory(atPath:withIntermediateDirectories:attributes:)` — 경로에 디렉터리 생성
- `func createFile(atPath:contents:attributes:) -> Bool` — 지정된 내용과 속성으로 파일 생성
- `func removeItem(at:)` — URL의 파일/디렉터리 삭제
- `func removeItem(atPath:)` — 경로의 파일/디렉터리 삭제
- `func trashItem(at:resultingItemURL:)` — 항목을 휴지통으로 이동

### Replacing items

- `func replaceItemAt(_:withItemAt:backupItemName:options:)` — 데이터 손실 없이 항목 교체
- `func replaceItem(at:withItemAt:backupItemName:options:resultingItemURL:)` — 데이터 손실 없이 항목 교체
- `struct ItemReplacementOptions` — 항목 교체 동작 옵션

### Moving and copying items

- `func copyItem(at:to:)` — URL의 파일을 새 위치로 동기 복사
- `func copyItem(atPath:toPath:)` — 경로의 파일을 새 위치로 동기 복사
- `func moveItem(at:to:)` — URL의 파일을 새 위치로 동기 이동
- `func moveItem(atPath:toPath:)` — 경로의 파일을 새 위치로 동기 이동

### Managing iCloud-based items

- `var ubiquityIdentityToken` — 현재 사용자의 iCloud Drive 신원 토큰
- `func url(forUbiquityContainerIdentifier:)` — iCloud 컨테이너 URL 반환 및 접근 권한 설정
- `func isUbiquitousItem(at:) -> Bool` — 항목이 iCloud 저장 대상인지 확인
- `func setUbiquitous(_:itemAt:destinationURL:)` — 항목을 iCloud에 저장하도록 지정
- `func startDownloadingUbiquitousItem(at:)` — 지정 항목 다운로드 시작
- `func evictUbiquitousItem(at:)` — iCloud 항목의 로컬 사본 제거
- `func url(forPublishingUbiquitousItemAt:expiration:)` — 공유 가능한 다운로드 URL 반환

### Accessing file provider services

- `func getFileProviderServicesForItem(at:completionHandler:)` — 항목을 관리하는 File Provider extension의 서비스 반환
- `class NSFileProviderService` — 앱과 File Provider extension 간 커스텀 통신 채널
- `struct NSFileProviderServiceName` — File Provider 서비스 식별 이름

### Controlling file provider synchronization

- `struct NSFileManagerSupportedSyncControls` — 항목에 사용 가능한 동기화 제어 옵션
- `func pauseSyncForUbiquitousItem(at:completionHandler:)` — 동기화 일시 중지
- `func resumeSyncForUbiquitousItem(at:with:completionHandler:)` — 동기화 재개
- `enum NSFileManagerResumeSyncBehavior` — 재개 시 충돌 해결 동작
- `func fetchLatestRemoteVersionOfItem(at:completionHandler:)` — 서버에서 최신 원격 버전 가져오기
- `class NSFileVersion` — 특정 시점의 파일 스냅샷
- `func uploadLocalVersionOfUbiquitousItem(at:withConflictResolutionPolicy:completionHandler:)` — 로컬 버전 업로드
- `enum NSFileManagerUploadLocalVersionConflictPolicy` — 업로드 시 충돌 해결 정책

### Creating symbolic and hard links

- `func createSymbolicLink(at:withDestinationURL:)` — URL에 심볼릭 링크 생성
- `func createSymbolicLink(atPath:withDestinationPath:)` — 경로에 심볼릭 링크 생성
- `func linkItem(at:to:)` — URL 간 하드 링크 생성
- `func linkItem(atPath:toPath:)` — 경로 간 하드 링크 생성
- `func destinationOfSymbolicLink(atPath:)` — 심볼릭 링크가 가리키는 항목 경로 반환

### Determining access to files

- `func fileExists(atPath:) -> Bool` — 파일/디렉터리 존재 여부
- `func fileExists(atPath:isDirectory:) -> Bool` — 존재 여부 + 디렉터리 여부 확인
- `func isReadableFile(atPath:) -> Bool` — 읽기 가능 여부
- `func isWritableFile(atPath:) -> Bool` — 쓰기 가능 여부
- `func isExecutableFile(atPath:) -> Bool` — 실행 가능 여부
- `func isDeletableFile(atPath:) -> Bool` — 삭제 가능 여부

### Getting and setting attributes

- `func componentsToDisplay(forPath:)` — 사용자에게 표시할 경로 컴포넌트
- `func displayName(atPath:)` — 파일/디렉터리의 표시 이름
- `func attributesOfItem(atPath:)` — 항목의 속성 반환
- `func attributesOfFileSystem(forPath:)` — 마운트된 파일 시스템 속성 반환
- `func setAttributes(_:ofItemAtPath:)` — 파일/디렉터리 속성 설정

### Getting and comparing file contents

- `func contents(atPath:) -> Data?` — 파일의 내용 반환
- `func contentsEqual(atPath:andPath:) -> Bool` — 두 항목 내용이 같은지 비교

### Getting the relationship between items

- `func getRelationship(_:ofDirectoryAt:toItemAt:)` — 디렉터리와 항목 간 관계 확인
- `func getRelationship(_:of:in:toItemAt:)` — 시스템 디렉터리와 항목 간 관계 확인
- `enum URLRelationship` — 디렉터리와 항목 간 관계 상수

### Converting file paths to strings

- `func fileSystemRepresentation(withPath:)` — 경로의 C-string 표현 반환
- `func string(withFileSystemRepresentation:length:)` — C-string에서 `NSString` 생성

### Managing the delegate

- `var delegate: (any FileManagerDelegate)?` — 파일 매니저의 델리게이트

### Managing the current directory

- `func changeCurrentDirectoryPath(_:) -> Bool` — 현재 작업 디렉터리 변경
- `var currentDirectoryPath: String` — 현재 작업 디렉터리 경로

### Unmounting volumes

- `func unmountVolume(at:options:completionHandler:)` — 볼륨 언마운트 시작
- `struct UnmountOptions` — 언마운트 동작 옵션
- `let NSFileManagerUnmountDissentingProcessIdentifierErrorKey` — 언마운트를 막은 프로세스 ID

### Working with HFS file types

- `func NSFileTypeForHFSTypeCode(_:)` — 파일 타입 코드를 문자열로 인코딩
- `func NSHFSTypeCodeFromFileType(_:)` — 파일 타입 코드 반환
- `func NSHFSTypeOfFile(_:)` — 파일 타입을 문자열로 인코딩

### Determining resource fork support

- `var NSFoundationVersionWithFileManagerResourceForkSupport` — 리소스 포크를 지원한 Foundation 첫 버전

### Supporting Types

- `struct DirectoryEnumerationOptions` — 디렉터리 열거 옵션
- `enum SearchPathDirectory` — 주요 디렉터리 위치
- `struct SearchPathDomainMask` — 검색 시 사용할 도메인 상수
- `struct FileAttributeKey` — 파일 속성 키
- `struct FileAttributeType` — 파일 타입 속성 값
- `struct FileProtectionType` — 파일 보호 수준 값
- `struct URLFileProtection` — URL 리소스의 보호 수준 값

### Notifications

- `static let NSUbiquityIdentityDidChange` — iCloud 신원이 변경된 후 발송
