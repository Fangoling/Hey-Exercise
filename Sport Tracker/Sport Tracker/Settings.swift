//
//  Settings.swift
//  Sport Tracker
//
//  Created by ipraktikum on 12.10.24.
//

import SwiftUI
import UserNotifications

struct Settings: View {
    @Environment(Model.self) var model: Model
    @State private var enabled = false
    var body: some View {
        Form {
            Section {
                Toggle("Show notifications", isOn: $enabled)
                    .onChange(of: enabled) { oldValue, newValue in
                        print(oldValue)
                        toggleNotifications(newValue)
                    }
            }
        }
    }
    func toggleNotifications(_ isEnabled: Bool) {
        if isEnabled {
            UNUserNotificationCenter.current()
                .requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("Enabled!")
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
        }
    }
}
