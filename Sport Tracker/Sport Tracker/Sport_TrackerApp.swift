//
//  Sport_TrackerApp.swift
//  Sport Tracker
//
//  Created by ipraktikum on 08.10.24.
//

import SwiftUI

@main
struct SportTrackerApp: App {
    @State var globalViewModel = Model()
    var body: some Scene {
        WindowGroup {
            DetailContentView()
                .environment(globalViewModel)
        }
    }
}
