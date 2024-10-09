//
//  Sport_TrackerApp.swift
//  Sport Tracker
//
//  Created by ipraktikum on 08.10.24.
//

import SwiftUI

@main
struct Sport_TrackerApp: App {
    @State var globalViewModel: Model = Model()
    
    var body: some Scene {
        WindowGroup {
            ExerciseOverView().environment(globalViewModel)
        }
    }
}
