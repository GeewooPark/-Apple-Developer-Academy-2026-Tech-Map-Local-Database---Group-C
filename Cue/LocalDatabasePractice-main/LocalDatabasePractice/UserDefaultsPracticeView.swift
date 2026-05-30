//
//  UserDefaultsPracticeView.swift
//  LocalDatabasePractice
//
//  Created by Admin on 5/18/26.
//

import SwiftUI

struct UserDefaultsPracticeView: View {
    // UserDefaults는 앱 설정처럼 작고 단순한 값을 저장할 때 어울린다.
    // @AppStorage는 UserDefaults의 key와 SwiftUI 상태를 바로 묶어 준다.
    @AppStorage("displayName") private var displayName = "Learner"
    @AppStorage("isDarkModePreferred") private var isDarkModePreferred = false
    @AppStorage("dailyGoal") private var dailyGoal = 2

    // UserDefaults에는 Date를 직접 넣을 수도 있지만,
    // 여기서는 저장되는 값의 형태를 보기 쉽게 숫자 형태로 남긴다.
    @AppStorage("lastOpenedAt") private var lastOpenedAt = Date.now.timeIntervalSince1970

    var body: some View {
        NavigationStack {
            Form {
                Section("저장할 설정") {
                    TextField("이름", text: $displayName)
                    Toggle("다크 모드 선호", isOn: $isDarkModePreferred)
                    Stepper("하루 목표 \(dailyGoal)개", value: $dailyGoal, in: 1...10)
                }

                Section("읽어온 값") {
                    // 화면을 다시 열어도 이전 값이 보이면 로컬 저장이 된 것이다.
                    LabeledContent("이름", value: displayName)
                    LabeledContent("선호 모드", value: isDarkModePreferred ? "Dark" : "System")
                    LabeledContent("마지막 실행", value: Date(timeIntervalSince1970: lastOpenedAt).formatted(date: .abbreviated, time: .shortened))
                }

                Section("실험") {
                    Button("마지막 실행 시간 갱신") {
                        // 값을 바꾸는 순간 UserDefaults에도 같은 key로 저장된다.
                        lastOpenedAt = Date.now.timeIntervalSince1970
                    }

                    Button("설정 초기화", role: .destructive) {
                        // 실제 앱에서는 "기본 설정으로 되돌리기" 같은 흐름에 해당한다.
                        displayName = "Learner"
                        isDarkModePreferred = false
                        dailyGoal = 2
                        lastOpenedAt = Date.now.timeIntervalSince1970
                    }
                }
            }
            .navigationTitle("UserDefaults")
        }
    }
}

#Preview {
    UserDefaultsPracticeView()
}
