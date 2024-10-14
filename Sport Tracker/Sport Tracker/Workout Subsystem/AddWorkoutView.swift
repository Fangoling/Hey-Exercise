//
//  AddExerciseView.swift
//  Sport Tracker
//
//  Created by ipraktikum on 09.10.24.
//

import SwiftUI

struct AddWorkoutView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(Model.self) private var mainModel: Model
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var workoutViewModel: AddWorkoutViewModel
    @State private var weight: Double?
    @State private var repetitions: Double?
    @State private var duration: Double?
    @State private var showTabBar: Bool = false
    @State private var exerciseSelected: Exercise?
    init(model: Model, id: Int? = nil) {
        self._workoutViewModel = State(wrappedValue: AddWorkoutViewModel(model, id))
    }
    var body: some View {
        Form {
            Section(header: Text("Date")) {
                DatePicker("Date", selection: $workoutViewModel.date, displayedComponents: [.date])
            }
            ForEach(workoutViewModel.exercisePairs, id: \.self) {
                PerformanceInWorkoutView(exercise: $0.exercise, performance: $0.performance)
            }
            // .onMove (perform: workoutViewModel.move)
            .onDelete(perform: workoutViewModel.delete)
            Section {
                ExercisePickerView(
                    pickedExercises: $workoutViewModel.exercisePairs,
                    exercises: mainModel.exercises,
                    model: mainModel,
                    weight: $weight,
                    repetitions: $repetitions,
                    duration: $duration,
                    expandedExercise: $exerciseSelected
                )
            }
        }
        .task {
            workoutViewModel.updateStates()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    workoutViewModel.save()
                    workoutViewModel.editing = false
                    dismiss()
                    notification(date: workoutViewModel.date)
                } label: {
                    Text("Save")
                        .bold()
                        .foregroundStyle(.blue)
                }
            }
        }
        // hacky toolbar to hide outer tabbar when inside the nested tabbar
        // prevents slow reload of outer tabbar when going back
        .toolbar(showTabBar ? .visible : .hidden, for: .tabBar, .bottomBar)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.mode.wrappedValue.dismiss()
            showTabBar.toggle()
        }, label: {
            Image(systemName: "chevron.backward").bold().foregroundStyle(.blue)
            Text("Back").foregroundStyle(.blue)
        }))
    }
    func notification(date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Hey you have a workout today."
        content.subtitle = "This is going to be really fun"
        content.sound = UNNotificationSound.default
        var notificationInterval: Double = 5
        if date.timeIntervalSinceNow > 1 {
            notificationInterval = date.timeIntervalSinceNow
        }
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: notificationInterval,
            repeats: false
        )
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(request)
    }
}

struct PerformanceInWorkoutView: View {
    var exercise: Exercise
    var performance: Performance

    var body: some View {
        HStack {
            Text(exercise.name)
            Spacer()
            if let repetitions = performance.repetitions {
                Text("\(repetitions.formatted(.number)) x")
            }
            if let weight = performance.weight {
                Text("\(weight.formatted(.number)) kg.")
            }
            if let duration = performance.duration {
                Text("\(duration.formatted(.number)) seconds.")
            }
        }
    }
}

struct ExercisePickerView: View {
    @Binding var pickedExercises: [ExercisePerformancePair]
    var exercises: [Exercise]
    var model: Model
    @Binding var weight: Double?
    @Binding var repetitions: Double?
    @Binding var duration: Double?
    @Binding var expandedExercise: Exercise?
    var body: some View {
        ForEach(exercises, id: \.self) { exercise in
            Section(header: Button(action: {
                withAnimation {
                    expandedExercise = (expandedExercise == exercise) ? nil : exercise
                }
            }, label: {
                HStack {
                    Text(exercise.name)
                }
            })) {
                if expandedExercise == exercise {
                    let id = exercise.id ?? 0
                    ExerciseTypePicker(
                        weight: $weight,
                        duration: $duration,
                        repetitions: $repetitions,
                        id: id,
                        model: model
                    )
                    Button(action: {
                        let performance = Performance(
                            date: Date(),
                            repetitions: repetitions,
                            weight: weight,
                            duration: duration
                        )
                        let pair = ExercisePerformancePair(exercise: exercise, performance: performance)
                        pickedExercises.append(pair)
                        resetSelection()
                    }, label: {
                        Text("Add to workout")
                    })
                    .transition(.slide)
                }
            }
        }
    }
    private func resetSelection() {
        expandedExercise = nil
        weight = nil
        repetitions = nil
        duration = nil
    }
}
