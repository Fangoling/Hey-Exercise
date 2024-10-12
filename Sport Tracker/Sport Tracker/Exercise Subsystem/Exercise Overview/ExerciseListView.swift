//
//  ExerciseListView.swift
//  Sport Tracker
//
//  Created by ipraktikum on 08.10.24.
//
import SwiftUI

struct ExerciseListView: View {
    @Environment(Model.self) private var model: Model
    @State private var searchText: String = ""
    var body: some View {
        List {
            ForEach(searchResults, id: \.self) { exercise in
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
        .searchable(text: $searchText)
    }
    var searchResults: [Exercise] {
        if searchText.isEmpty {
            return model.exercises
        } else {
            return model.exercises.filter { $0.name.contains(searchText) }
        }
    }
}

#Preview {
    ExerciseListView().environment(Model() as Model)
}
