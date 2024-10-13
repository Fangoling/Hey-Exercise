//
//  AddExerciseView.swift
//  Sport Tracker
//
//  Created by ipraktikum on 09.10.24.
//

import SwiftUI

struct AddExerciseView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var addExerciseViewModel: AddExerciseViewModel
    init(model: Model, id: Int?) {
        self._addExerciseViewModel = State(wrappedValue: AddExerciseViewModel(model, id: id))
    }
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Name")) {
                    TextField("Name", text: $addExerciseViewModel.name)
                }
                Section(header: Text("Notes")) {
                    TextField("", text: $addExerciseViewModel.description)
                }
                if addExerciseViewModel.editing {
                    Section(header: Text("Exercise Type")) {
                        ExerciseTypePickerView(exerciseTypes: $addExerciseViewModel.types)
                    }
                }
            }
            .task {
                addExerciseViewModel.updateStates()
            }
            .navigationTitle(addExerciseViewModel.editing ? "Edit Exercise" : "Add Exercise")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        addExerciseViewModel.save()
                        addExerciseViewModel.editing = false
                        dismiss()
                    } label: {
                        Text("Add").bold()
                    }
                }
            }
        }
    }
}

struct ExerciseTypePickerView: View {
    @Binding var exerciseTypes: [ExerciseType]
    var exerciseTypeOverview: [ExerciseType] = [.repetitions, .weight, .duration]
    var body: some View {
        List {
            ForEach(exerciseTypeOverview, id: \.self) { type in
                Button(action: {
                    exerciseTypes.contains(type)
                        ? exerciseTypes.removeAll(where: { $0 == type })
                        : exerciseTypes.append(type)
                }, label: {
                    HStack {
                        Text(type.description)
                        Spacer()
                        if exerciseTypes.contains(type) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                }
                )
            }
        }
    }
}
