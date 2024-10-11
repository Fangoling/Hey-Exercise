//
//  AddExerciseView.swift
//  Sport Tracker
//
//  Created by ipraktikum on 09.10.24.
//

import SwiftUI

struct AddExerciseView: View {
    @Environment(Model.self) private var model: Model
    @Environment(\.dismiss) private var dismiss
    @State var name: String = ""
    @State var description: String = ""
    @State var exerciseTypes: [ExerciseType] = []

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Name")) {
                    TextField("Name", text: $name)
                }
                Section(header: Text("Notes")) {
                    TextField("", text: $description)
                }
                ExerciseTypePickerView(exerciseTypes: $exerciseTypes)
            }.navigationTitle("Add Exercise")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        model.addExercise(name: name, description: description, exerciseTypes: exerciseTypes)
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
#Preview {
    AddExerciseView().environment(Model() as Model)
}
