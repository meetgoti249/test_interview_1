//
//  InterviewApp.swift
//  Interview
//
//  Created by Meet Goti on 09/08/24.
//

import SwiftUI
import IQKeyboardManagerSwift

@main
struct InterviewApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    IQKeyboardManager.shared.enable = true
                }

        }
    }
}
