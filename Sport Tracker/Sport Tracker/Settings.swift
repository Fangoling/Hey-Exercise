//
//  Settings.swift
//  Sport Tracker
//
//  Created by ipraktikum on 12.10.24.
//

import SwiftUI

struct Settings: View {
    @Environment(Model.self) var model: Model
    @State private var enabled = false
    var body: some View {
        Form {
            Section {
                Toggle("Show notifications", isOn: $enabled)
            }
        }
    }
}
