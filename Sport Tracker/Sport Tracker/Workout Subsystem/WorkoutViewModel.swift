//
//  WorkoutViewModel.swift
//  Sport Tracker
//
//  Created by ipraktikum on 12.10.24.
//

import Foundation
import SwiftUI

@Observable class AddWorkoutViewModel {
    var id: Int?
    var date: Date = Date()
    var exercisePairs: [ExercisePerformancePair] = []
    private weak var model: Model?
    var showDeleteAlert = false
    var showEditSheet = false
    var editing = false
    var adding = true
    var exercises: [Exercise] {
        model?.exercises ?? []
    }
    var workouts: [Workout] {
        model?.workouts ?? []
    }
    init(_ model: Model, _ id: Int? = nil) {
        self.model = model
        self.id = id
    }
    func updateStates() {
        guard let model = model, let id = id else {
            return
        }
        guard let workout = model.workout(id) else {
            return
        }
        self.date = workout.date
        self.exercisePairs = workout.exercisePairs

    }
    func save() {
        guard let model = model else {
            return
        }
        let workout = Workout(id: self.id, date: self.date, exercisePairs: self.exercisePairs)
        model.saveWorkout(workout)
        self.updateStates()
    }
    func delete() {
        guard let model = model else {
            return
        }
        model.deleteWorkout(exerciseId: id)
        self.updateStates()
    }
    func onMove(from source: IndexSet, to destination: Int) {
        exercisePairs.move(fromOffsets: source, toOffset: destination)
    }
    func delete(at offsets: IndexSet) {
        exercisePairs.remove(atOffsets: offsets)
    }
}
