//
//  WorkoutListView.swift
//  Sport Tracker
//
//  Created by ipraktikum on 12.10.24.
//

import SwiftUI

struct WorkoutListView: View {
    @Environment(Model.self) private var model: Model
    @State private var showAddWorkoutSheet: Bool = false
    @State var currentID: Int = 0
    var body: some View {
        List {
            ForEach(model.workouts, id: \.self) { workout in
                NavigationLink(destination: AddWorkoutView(model: model, id: workout.id)) {
                    HStack {
                        Text(workout.date.formatted(.dateTime))
                            .padding()
                    }
                }
            }
        }
        .navigationTitle("Workouts")
        .listStyle(.sidebar)
    }
}
