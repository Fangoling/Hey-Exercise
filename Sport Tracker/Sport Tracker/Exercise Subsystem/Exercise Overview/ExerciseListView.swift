//
//  ExerciseListView.swift
//  Sport Tracker
//
//  Created by ipraktikum on 08.10.24.
//
import SwiftUI

struct ExerciseListView: View {
    @Environment(Model.self) private var model: Model
    var body: some View {
        List {
            ForEach(model.exercises, id: \.self) { exercise in
                NavigationLink(value: exercise, label: {
                    ZStack {
                        HStack {
                            Text(exercise.name).font(Font.system(size: 22))
                        }.padding()
                    }
                })
            }
        }
        .listStyle(.sidebar)
        .navigationDestination(for: Exercise.self) { exercise in
            if let exerciseId = exercise.id {
                ExerciseDetailContentView(id: exerciseId)
            }
        }
    }
}

#Preview {
    ExerciseListView().environment(Model() as Model)
}
