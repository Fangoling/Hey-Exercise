//
//  ExerciseView.swift
//  Sport Tracker
//
//  Created by ipraktikum on 09.10.24.
//

import SwiftUI
import Charts

struct ExerciseView: View {
    @Environment(Model.self) private var model: Model
    @State private var addSheetOpen: Bool = false
    @State private var addExerciseViewModel: AddExerciseViewModel
    var id: Int
    init(model: Model, modelId: Int?, id: Int) {
        self._addExerciseViewModel = State(wrappedValue: AddExerciseViewModel(model, id: modelId))
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
                    VStack {
                        Text("Notes").font(.largeTitle)
                        Text(exercise?.description ?? "No notes")
                    }
                    .cardViewModifier()
                    HStack(alignment: .center) {
                        EditButton(viewModel: $addExerciseViewModel).padding()
                        DeleteButton(viewModel: $addExerciseViewModel).padding()
                    }
                }
            }.sheet(isPresented: $addExerciseViewModel.showEditSheet) {
                AddExerciseView(model: model, id: id)
            }

        }
    }
}

struct ExerciseDetailView: View {
    var id: Int
    var type: ExerciseType
    var data: [Performance]
    var body: some View {
        VStack {
            Text(type.description).font(.largeTitle)
            BestPerformanceView(id: id, exerciseType: type)
            ExerciseChartView(data: data, exerciseType: type)
        }
        .cardViewModifier()
    }
}

struct DeleteButton: View {
    @Binding var viewModel: AddExerciseViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Button(action: { viewModel.showDeleteAlert = true }) {
            Text("Delete")
        }
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

struct EditButton: View {
    @Binding var viewModel: AddExerciseViewModel
    var body: some View {
        Button(action: {
            viewModel.showEditSheet = true
            viewModel.editing = true
        }) {
            Text("Edit")
        }
    }
}
