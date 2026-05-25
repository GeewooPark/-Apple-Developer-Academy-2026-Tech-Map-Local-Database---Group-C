# FileManager

## 📁 FileManager란?
```text
A convenient interface to the contents of the file system, and the primary means of interacting with it.
```
- 파일을 관리해 주는 클래스
- 파일 생성 / 복사 / 이동 / 삭제
- 파일이나 폴더가 있는지 확인
- 파일 속성 확인

## 🔧 FileManager 사용법
- 📍 예제 코드(`FileManagerPracticeView.swift`) 기반으로 작성됨!
- 📍 예제 코드의 목적: 사용자가 입력한 로그를 `practice-logs.json` 파일에 저장

### 1. FileManager 준비
```swift
private let fileManager = FileManager.default
```
- `FileManager.default`: 앱에서 공통으로 사용할 수 있는 기본 FileManager 객체를 의미한다.

### 2. 저장할 파일 위치 만들기
```swift
let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
return documentsURL.appending(path: "practice-logs.json")
```

- `.documentDirectory`: Documents 폴더를 의미한다.
- `.userDomainMask`: 현재 사용자의 영역에서 폴더를 찾겠다는 의미이다.
- `appending(path:)`: Documents 폴더 안에 `practice-logs.json` 파일 경로를 만든다. (여기서 만드는 것은 폴더가 아니라 저장할 JSON 파일의 URL)

### 3. 파일 읽기
```swift
guard let data = try? Data(contentsOf: logFileURL) else {
    logs = []
    return
}

logs = (try? decoder.decode([PracticeLog].self, from: data)) ?? []
```
- 앱이 시작되면 저장된 JSON 파일을 읽고, `[PracticeLog]` 배열로 변환한다.
- 파일이 없거나 읽기에 실패하면 빈 배열로 시작한다.

### 4. 파일 저장
```swift
guard let data = try? encoder.encode(logs) else { return }
try? data.write(to: logFileURL, options: [.atomic])
```
- 로그 배열을 JSON 데이터로 바꾼 뒤 파일에 저장한다.
- `.atomic` 옵션은 임시 파일에 먼저 쓴 다음 교체하는 방식이라 일반적인 쓰기보다 더 안전하다.

### 5. 파일 삭제
```swift
try? fileManager.removeItem(at: logFileURL)
```
- 초기화할 때는 화면의 배열만 비우는 것이 아니라 실제 저장된 파일도 삭제한다. (앱을 다시 실행했을 때 이전 로그가 다시 나타나지 않게 하기 위함.)

## 🔎 JSONEncoder / JSONDecoder는 왜 쓸까?
```swift
private let encoder = JSONEncoder()
private let decoder = JSONDecoder()
```

`PracticeLog` 배열은 Swift에서 쓰는 타입이라 JSON 파일에 바로 저장되는 형태가 아니다.  
그래서 `JSONEncoder`로 Swift 데이터를 JSON 형식의 `Data`로 바꾸고, 다시 읽을 때는 `JSONDecoder`로 JSON 데이터를 `[PracticeLog]`로 되돌린다. 

날짜도 함께 저장하기 때문에 `dateEncodingStrategy`와 `dateDecodingStrategy`를 둘 다 `.iso8601`로 맞춰 둔다. 저장할 때와 읽을 때 날짜 형식이 같아야 다시 제대로 읽을 수 있다.

### 📎 참고
- [Apple Developer Documentation - FileManager](https://developer.apple.com/documentation/foundation/filemanager)
- [[iOS] FileManager - 폴더, 파일 생성 & 삭제](https://peppo.tistory.com/193)