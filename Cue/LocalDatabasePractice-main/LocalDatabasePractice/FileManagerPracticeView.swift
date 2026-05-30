//
//  FileManagerPracticeView.swift
//  LocalDatabasePractice
//
//  Created by Admin on 5/18/26.
//

import SwiftUI
import Combine

// FileManager 실습에서는 모델을 파일에 저장해야 하므로 Codable이 필요하다.
struct PracticeLog: Codable, Identifiable {
    let id: UUID
    let message: String
    let createdAt: Date
}

@MainActor
final class PracticeLogStore: ObservableObject {
    // View는 logs만 보고 그리도록 두고, 파일 입출력은 Store 안에 모은다.
    @Published private(set) var logs: [PracticeLog] = []
    @Published private(set) var fileName = ""

    private let fileManager = FileManager.default
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    init() {
        // 날짜 저장 규칙은 encode와 decode가 같아야 다시 읽을 수 있다.
        encoder.dateEncodingStrategy = .iso8601
        decoder.dateDecodingStrategy = .iso8601
        fileName = logFileURL.lastPathComponent

        // 앱이 시작될 때 파일에서 이전 로그를 읽어 온다.
        load()
    }

    func append(message: String) {
        // 파일에 저장하기 전에 화면 입력값을 먼저 정리한다.
        let trimmedMessage = message.trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmedMessage.isEmpty == false else { return }

        let log = PracticeLog(id: UUID(), message: trimmedMessage, createdAt: .now)
        logs.insert(log, at: 0)

        // 배열을 바꾼 뒤 파일 전체를 다시 저장하는 가장 단순한 방식이다.
        save()
    }

    func clear() {
        logs.removeAll()

        // 화면 상태만 비우면 다음 실행 때 파일에서 다시 살아난다.
        // 그래서 실제 파일도 함께 지운다.
        try? fileManager.removeItem(at: logFileURL)
    }

    private var logFileURL: URL {
        // Documents 폴더는 앱을 껐다 켜도 남는 파일을 둘 때 사용한다.
        // 캐시처럼 지워져도 되는 파일이면 cachesDirectory가 더 맞을 수 있다.
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsURL.appending(path: "practice-logs.json")
    }

    private func load() {
        // 첫 실행처럼 파일이 아직 없으면 빈 배열로 시작한다.
        guard let data = try? Data(contentsOf: logFileURL) else {
            logs = []
            return
        }

        // 파일 내용이 깨졌거나 모델이 바뀌면 decode가 실패할 수 있다.
        // 실습에서는 실패 시 빈 배열로 시작하게 둔다.
        logs = (try? decoder.decode([PracticeLog].self, from: data)) ?? []
    }

    private func save() {
        guard let data = try? encoder.encode(logs) else { return }

        // atomic은 임시 파일에 먼저 쓴 다음 교체하는 방식이라 더 안전하다.
        try? data.write(to: logFileURL, options: [.atomic])
    }
}

struct FileManagerPracticeView: View {
    // @StateObject를 쓰면 화면이 다시 그려져도 Store 인스턴스가 유지된다.
    @StateObject private var store = PracticeLogStore()
    @State private var message = ""

    var body: some View {
        NavigationStack {
            List {
                Section("파일에 남길 로그") {
                    TextField("예: 앱을 처음 실행했다", text: $message)

                    Button {
                        store.append(message: message)
                        message = ""
                    } label: {
                        Label("로그 추가", systemImage: "plus")
                    }

                    LabeledContent("파일", value: store.fileName)
                }

                Section("저장된 로그") {
                    if store.logs.isEmpty {
                        ContentUnavailableView("로그 없음", systemImage: "doc.text")
                    } else {
                        ForEach(store.logs) { log in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(log.message)
                                    .font(.headline)
                                Text(log.createdAt.formatted(date: .abbreviated, time: .shortened))
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("FileManager")
            .toolbar {
                Button("초기화", role: .destructive) {
                    store.clear()
                }
            }
        }
    }
}

#Preview {
    FileManagerPracticeView()
}
