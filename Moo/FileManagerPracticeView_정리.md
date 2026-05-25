# FileManagerPracticeView.swift 코드 학습 정리

`FileManagerPracticeView.swift` 코드를 분석하면서 모르는 개념들을 정리한 문서입니다.

---

## 9번 줄 — Combine 프레임워크

**Combine 프레임워크**는 시간에 따른 값들을 다룰 수 있도록 해준다.

- 비동기적으로 발생하는 이벤트(값의 변화, 사용자 입력, 네트워크 응답 등)를 처리하기 위한 Apple의 선언적 Swift API.
- Publisher와 Subscriber 개념을 통해 시간의 흐름에 따라 변화하는 값을 스트림 형태로 처리한다.

---

## 12번 줄 — Codable, Identifiable

### Codable
- `Encodable`과 `Decodable` 프로토콜을 합친 **type alias**.
- JSON 등 외부 형식으로 데이터를 변환 및 전송 가능하도록 해준다.

### Identifiable
- 클래스나 값 타입에 `id`와 같은 **정체성(identity)** 을 부여할 때 사용.
- SwiftUI의 `List`, `ForEach` 같은 뷰에서 각 요소를 고유하게 식별할 때 필요하다.

---

## 18번 줄 — @MainActor

- `@MainActor`는 코드가 **메인 스레드에서 실행되도록 보장**해준다.
- UI 업데이트는 반드시 메인 스레드에서 이루어져야 하므로, UI와 관련된 작업을 처리하는 클래스나 메서드에 자주 붙인다.

---

## 19번 줄 — final, ObservableObject

### final
- **상속과 재정의 모두 막아준다.**
- 컴파일 시점에 컴파일러가 재정의 또는 상속이 안됨을 알기 때문에 **성능 향상**에 도움이 된다.

### ObservableObject
- `ObservableObject`인 객체는 **속성이 변경될 때마다 뷰 업데이트**를 해준다.
- 보통 내부의 `@Published` 프로퍼티가 변경될 때 변경 사항을 발행(publish)하여 구독 중인 뷰가 갱신된다.

---

## 21번 줄 — private(set)

- `private(set)`은 **private임에도 값에 접근은 가능하게 해준다.**
- 즉, **읽기는 외부에서 가능**하지만 **쓰기(수정)는 내부에서만** 가능하도록 제한한다.
- 캡슐화를 유지하면서도 외부에 값을 노출할 때 유용하다.

---

## 41번 줄 — guard문

- `guard`문은 `if`문과 달리 **조건에 맞지 않으면 끝낸다.**
- **얼리 리턴(early return)** 같은 방식.
- 조건이 만족되지 않으면 `else` 블록에서 함수를 빠져나가므로, 이후 코드에서는 조건이 만족된다는 것이 보장된다.

---

## 참고 리소스

- [Combine — Apple Developer Documentation](https://developer.apple.com/documentation/combine)
- [Codable 정리 — moon-works](https://moon-works.tistory.com/76)
- [Identifiable — Apple Developer Documentation](https://developer.apple.com/documentation/Swift/Identifiable)
- [@MainActor 제대로 사용하기 (Swift Concurrency) — velog](https://velog.io/@gyu_u0108/MainActor-%EC%A0%9C%EB%8C%80%EB%A1%9C-%EC%82%AC%EC%9A%A9%ED%95%98%EA%B8%B0-Swift-Concurrency-1)
- [final 키워드 — zzeroarchive](https://zzeroarchive.tistory.com/13)
- [ObservableObject — green1229](https://green1229.tistory.com/228)
- [guard문 정리 — didu-story](https://didu-story.tistory.com/154)
