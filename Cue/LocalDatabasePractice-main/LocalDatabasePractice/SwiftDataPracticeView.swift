//
//  SwiftDataPracticeView.swift
//  LocalDatabasePractice
//
//  Created by Admin on 5/18/26.
//

import SwiftData
import SwiftUI

struct SwiftDataPracticeView: View {
    // modelContext는 SwiftData에서 insert, delete, save 같은 작업을 맡는다.
    // App 파일에서 주입한 ModelContainer 덕분에 여기서 꺼내 쓸 수 있다.
    @Environment(\.modelContext) private var modelContext

    // @Query는 저장소의 PracticeNote 목록을 읽고, 변경이 생기면 화면도 갱신한다.
    @Query(sort: \PracticeNote.createdAt, order: .reverse) private var notes: [PracticeNote]

    // TextField 입력값은 아직 저장된 데이터가 아니므로 @State로만 들고 있는다.
    @State private var title = ""
    @State private var bodyText = ""

    var body: some View {
        NavigationStack {
            List {
                Section("새 노트") {
                    TextField("제목", text: $title)
                    TextField("본문", text: $bodyText, axis: .vertical)

                    Button {
                        addNote()
                    } label: {
                        Label("SwiftData에 저장", systemImage: "plus")
                    }
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }

                Section("저장된 노트") {
                    if notes.isEmpty {
                        ContentUnavailableView("노트 없음", systemImage: "externaldrive")
                    } else {
                        ForEach(notes) { note in
                            NoteRow(note: note)
                        }
                        .onDelete(perform: deleteNotes)
                    }
                }
            }
            .navigationTitle("SwiftData")
        }
    }

    private func addNote() {
        // 저장하기 전에 공백만 있는 제목은 걸러내기 쉽게 정리한다.
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedBody = bodyText.trimmingCharacters(in: .whitespacesAndNewlines)

        // @Model 타입의 인스턴스를 만들지만, 아직 저장소에 들어간 것은 아니다.
        let note = PracticeNote(title: trimmedTitle, body: trimmedBody)

        // insert 이후 @Query가 다시 읽으면서 목록에 새 노트가 나타난다.
        modelContext.insert(note)

        // 저장 후 입력칸을 비워 다음 노트를 바로 작성할 수 있게 한다.
        title = ""
        bodyText = ""
    }

    private func deleteNotes(_ offsets: IndexSet) {
        // List에서 스와이프 삭제한 위치를 실제 모델 삭제로 연결한다.
        for offset in offsets {
            modelContext.delete(notes[offset])
        }
    }
}

private struct NoteRow: View {
    // @Bindable을 쓰면 @Model 객체의 값을 Row 안에서 바로 수정할 수 있다.
    @Bindable var note: PracticeNote

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(note.title)
                    .font(.headline)
                Spacer()
                Button {
                    // 별도의 update 함수 없이 프로퍼티를 바꾸면 SwiftData가 변경을 추적한다.
                    note.isPinned.toggle()
                } label: {
                    Image(systemName: note.isPinned ? "pin.fill" : "pin")
                }
                .buttonStyle(.borderless)
                .accessibilityLabel("고정")
            }

            if note.body.isEmpty == false {
                Text(note.body)
                    .foregroundStyle(.secondary)
            }

            Text(note.createdAt.formatted(date: .abbreviated, time: .shortened))
                .font(.caption)
                .foregroundStyle(.tertiary)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    SwiftDataPracticeView()
        .modelContainer(for: PracticeNote.self, inMemory: true)
}
