## FileManager Apple 공식 문서 정리

출처 :  
https://developer.apple.com/documentation/foundation/filemanager

### 1. Overview - 개요

- **Definition**

    - A file manager object lets you examine the contents of the file system and make changes to it.

    - 파일 매니저 객체는 파일 시스템의 콘텐츠를 검사하고, 이를 변경할 수 있도록 도와준다.

- **Primary Mode of Interaction**

    - You use it to locate, create, copy, and move files and directories. You also use it to get information about a file or directory or change some of its attributes.

    - File manager는 파일 시스템과 상호작용하는 기본 수단이다. 파일 및 디렉토리를 찾고, 생성하고, 복사하고, 이동하는 데 사용한다. 또한 파일이나 디렉토리의 정보를 가져오거나 속성을 변경할 때도 사용한다.

- **Location Specifying**

    - When specifying the location of files, you can use either NSURL or NSString objects. The use of the NSURL class is generally preferred because URLs can convert path information to a more efficient representation internally.

    - 파일 위치를 지정할 때는 `NSURL` 또는 `NSString` 객체를 모두 사용할 수 있다. 다만, URL은 내부적으로 경로 정보를 더 효율적인 표현 방식으로 변환하기 때문에 일반적으로 `NSURL` 클래스 사용이 선호된다.

### 2. Important Implementation Considerations - 구현 시 고려해야할 중요한 사항들

- **Threading Considerations**

    - The methods of the shared `FileManager` object can be called from multiple threads safely.

    - 공유된(shared) `FileManager` 객체의 메서드들은 여러 스레드에서 동시에 안전하게 호출할 수 있다.

    - However, if you use a delegate to receive notifications about the status of operations, you should create a unique instance of the file manager object, assign your delegate to that object, and use that file manager to initiate your operations.

    - 하지만, 이동·복사·삭제·링크 작업의 상태 알림을 받기 위해 대리자(delegate)를 사용하는 경우에는 파일 매니저 객체의 고유한 인스턴스를 새로 생성하고, 해당 객체에 대리자를 할당한 후 작업을 시작해야 한다.

### 3. Essential Instance Methods (핵심 인스턴스 메서드)

- **Creating a File Manager**

    `class var default: FileManager`

    - The shared file manager object for the process.

    - 현재 프로세스를 위한 공유 파일 매니저 객체.

- **Accessing & Locating Directories**

    `var temporaryDirectory: URL`

    - The temporary directory for the current user.

    - 현재 사용자의 임시 디렉토리 경로.

    `func url(for: FileManager.SearchPathDirectory, in: FileManager.SearchPathDomainMask, appropriateFor: URL?, create: Bool) throws -> URL`

    - Locates and optionally creates the specified common directory in a domain.

    - 도메인 내에서 지정된 공통 시스템 디렉토리(Documents, Library 등)를 찾아내고, 옵션에 따라 생성까지 수행한다.

- **Discovering Directory Contents**

    `func contentsOfDirectory(at: URL, includingPropertiesForKeys: [URLResourceKey]?, options: FileManager.DirectoryEnumerationOptions) throws -> [URL]`

    - Performs a shallow search of the specified directory and returns URLs for the contained items.

    - 지정된 디렉토리를 얕은 탐색(Shallow search)하여 포함된 아이템들의 URL 배열을 반환한다.

    `func enumerator(at: URL, includingPropertiesForKeys: [URLResourceKey]?, options: FileManager.DirectoryEnumerationOptions, errorHandler: ((URL, any Error) -> Bool)?) -> FileManager.DirectoryEnumerator?`

    - Returns a directory enumerator object that can be used to perform a deep enumeration of the directory.

    - 디렉토리 내부를 깊은 탐색(Deep enumeration, 하위 폴더까지 탐색)할 수 있는 열거자 객체를 반환한다.

- **Creating and Deleting Items**

    `func createDirectory(at: URL, withIntermediateDirectories: Bool, attributes: [FileAttributeKey : Any]?) throws`

    - Creates a directory with the given attributes at the specified URL.

    - 지정된 URL에 주어진 속성을 가진 디렉토리를 생성한다. 중간 경로 폴더 자동 생성 여부(`withIntermediateDirectories`)를 설정할 수 있다.

    `func createFile(atPath: String, contents: Data?, attributes: [FileAttributeKey: Any]?) -> Bool`

    - Creates a file with the specified content and attributes at the given location.

    - 지정된 위치에 파일 내용(Data)과 속성을 가진 파일을 생성한다.

    `func removeItem(at: URL) throws`

    - Removes the file or directory at the specified URL.

    - 지정된 URL의 파일이나 디렉토리를 완전히 삭제한다.

- **Moving, Copying, and Replacing Items**

    `func copyItem(at: URL, to: URL) throws`

    - Copies the file at the specified URL to a new location synchronously.

    - 지정된 URL의 파일을 새로운 위치로 동기적으로 복사한다.

    `func moveItem(at: URL, to: URL) throws`

    - Moves the file or directory at the specified URL to a new location synchronously.

    - 지정된 URL의 파일이나 디렉토리를 새로운 위치로 동기적으로 이동시킨다.

    `func replaceItemAt(URL, withItemAt: URL, backupItemName: String?, options: FileManager.ItemReplacementOptions) throws -> URL?`

    - Replaces the contents of the item at the specified URL in a manner that ensures no data loss occurs.

    - 데이터 유실이 발생하지 않도록 보장하는 안전한 방식으로 지정된 URL의 파일 내용을 교체한다.

- **Determining Access and Contents (접근 권한 및 콘텐츠 확인)**

    `func fileExists(atPath: String) -> Bool`

    - Returns a Boolean value that indicates whether a file or directory exists at a specified path.

    - 지정된 경로에 파일이나 디렉토리가 실제로 존재하는지 여부를 불리언 값으로 반환한다.

    `func contents(atPath: String) -> Data?`

    - Returns the contents of the file at the specified path.

    - 지정된 경로에 있는 파일의 알맹이(콘텐츠)를 Data 형태로 읽어와 반환한다.

### 4. See Also - 추가로 확인하면 좋은 사항

- Prevent data loss and app crashes by interacting with the file system in a coordinated, asynchronous manner and by avoiding unnecessary disk I/O.

    - 불필요한 디스크 I/O를 피하고 조정된 비동기 방식으로 파일 시스템과 상호작용하여, 데이터 유실과 앱 크래시를 방지해야 한다.

    - Article : Improving performance and stability when accessing the file system

    - https://developer.apple.com/documentation/foundation/improving-performance-and-stability-when-accessing-the-file-system

- Gain access to benefits like automatic backup or purging by using purpose-built directories provided by the system.

    - 시스템이 제공하는 목적별 전용 디렉토리(Documents, Caches 등)를 올바르게 사용해야 자동 백업 및 무효화(Purging) 같은 OS 차원의 이점을 누릴 수 있다.

    - Article : Using the file system effectively

    - https://developer.apple.com/documentation/foundation/using-the-file-system-effectively

### 5. 추가 리소스
- iOS File System Basics 공식 문서 번역본
https://baechukim.tistory.com/138

- iOS Accessing Files and Directories 공식 문서 번역 & 정리본
https://baechukim.tistory.com/140