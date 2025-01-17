//
//  AddPerformanceView.swift
//  Sport Tracker
//
//  Created by ipraktikum on 10.10.24.
//

import SwiftUI

struct AddPerformanceView: View {
    @Environment(Model.self) private var model: Model
    @Environment(\.dismiss) private var dismiss
    @State var date = Date()
    @State var repetitions: Double?
    @State var weight: Double?
    @State var duration: Double?
    var id: Int
    var body: some View {
        NavigationStack {
            Form {
                DatePicker("Date", selection: $date, displayedComponents: [.date])
                ExerciseTypePicker(
                    weight: $weight,
                    duration: $duration,
                    repetitions: $repetitions,
                    id: id,
                    model: model
                )
            }
            .navigationTitle("Add Performance")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        model.addPerformance(
                            id: id,
                            Performance(date: date, repetitions: repetitions, weight: weight, duration: duration)
                        )
                        dismiss()
                    } label: {
                        Text("Add").bold()
                    }
                }
            }
        }
    }
}

struct ExerciseTypePicker: View {
    @Binding var weight: Double?
    @Binding var duration: Double?
    @Binding var repetitions: Double?
    var id: Int
    var model: Model
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    var body: some View {
        ForEach(model.getTypes(for: id), id: \.self) { type in
            Section(header: Text(type.description)) {
                switch type {
                case .weight:
                    TextField("", value: $weight, formatter: formatter)
                case .duration:
                    TextField("", value: $duration, formatter: formatter)
                case .repetitions:
                    TextField("", value: $repetitions, formatter: formatter)
                }
            }
        }
    }
}
