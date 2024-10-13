//
//  WorkoutView.swift
//  Sport Tracker
//
//  Created by ipraktikum on 12.10.24.
//

import SwiftUI

struct WorkoutView: View {
    @Environment(Model.self) private var model: Model
    @State private var addSheetOpen: Bool = false
    @State private var workoutViewModel: AddWorkoutViewModel
    var id: Int
    init(model: Model, modelId: Int?, id: Int) {
        self._workoutViewModel = State(wrappedValue: AddWorkoutViewModel(model))
        self.id = id
    }
    var body: some View {
        let exercise = model.exercise(id)
        let exerciseTypes = exercise?.types ?? []
        let data = model.exercise(id)?.performances ?? []
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(exerciseTypes, id: \.self) { type in
                        ExerciseDetailView(id: id, type: type, data: data)
                    }
                    HStack(alignment: .center) {
                        WorkoutEditButton(viewModel: $workoutViewModel).padding()
                        WorkoutDeleteButton(viewModel: $workoutViewModel).padding()
                    }
                }
            }.sheet(isPresented: $workoutViewModel.showEditSheet) {
                AddExerciseView(model: model, id: id)
            }

        }
    }
}

struct WorkoutDetailView: View {
    var date: Date = .init()
    var exercises: [Exercise]

    var body: some View {
        VStack {
            Text(date.formatted(.dateTime))
                .font(.largeTitle)
        }
        .cardViewModifier()
    }
}

struct WorkoutDeleteButton: View {
    @Binding var viewModel: AddWorkoutViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Button(
            action: { viewModel.showDeleteAlert = true },
            label: { Text("Delete") }
        )
        .alert(isPresented: $viewModel.showDeleteAlert) {
            deleteAlert
        }
    }

    private var deleteAlert: Alert {
        Alert(title: Text("Delete Exercise"),
              message: Text("""
                            Are you sure you want to delete this exercise?
                            You will lose all your Performance Data
                            """),
              primaryButton: .destructive(Text("Delete"), action: delete),
              secondaryButton: .cancel())
    }

    private func delete() {
        viewModel.delete()
        dismiss()
    }
}

struct WorkoutEditButton: View {
    @Binding var viewModel: AddWorkoutViewModel
    var body: some View {
        Button {
            viewModel.showEditSheet = true
            viewModel.editing = true
        } label: {
            Text("Edit")
        }
    }
}
