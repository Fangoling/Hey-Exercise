//
//  DetailContentView.swift
//  Sport Tracker
//
//  Created by ipraktikum on 12.10.24.
//

import SwiftUI

struct DetailContentView: View {
    var body: some View {
        TabView {
            Tab("Workouts", systemImage: "list.bullet.indent") {
                WorkoutOverviewView()
            }
            Tab("Exercises", systemImage: "dumbbell") {
                ExerciseOverView()
            }
            Tab("Settings", systemImage: "gearshape") {
                Settings()
            }
        }
    }
}
