//
//  ContentView.swift
//  LocalDatabasePractice
//
//  Created by Admin on 5/18/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            UserDefaultsPracticeView()
                .tabItem {
                    Label("Defaults", systemImage: "switch.2")
                }

            FileManagerPracticeView()
                .tabItem {
                    Label("Files", systemImage: "doc.text")
                }

            SwiftDataPracticeView()
                .tabItem {
                    Label("SwiftData", systemImage: "externaldrive")
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: PracticeNote.self, inMemory: true)
}
