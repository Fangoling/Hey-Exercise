//
//  AddExerciseViewModel.swift
//  Sport Tracker
//
//  Created by ipraktikum on 11.10.24.
//

import Foundation
import SwiftUI

@Observable class AddExerciseViewModel {
    var id: Int?
    var name: String = ""
    var description: String = ""
    var types: [ExerciseType] = []
    var performances: [Performance] = []
    private weak var model: Model?
    var showDeleteAlert = false
    var showEditSheet = false
    var editing = false
    var adding = true
    var exercises: [Exercise] {
        model?.exercises ?? []
    }
    init(_ model: Model, id: Int?) {
        self.model = model
        self.id = id
    }
    func updateStates() {
        guard let model = model, let id = id else {
            return
        }
        guard let exercise = model.exercise(id) else {
            return
        }
        self.name = exercise.name
        self.description = exercise.description
        self.types = exercise.types
        self.performances = exercise.performances
    }
    func save() {
        guard let model = model else {
            return
        }
        let exercise = Exercise(
            id: self.id,
            name: self.name,
            description: self.description,
            types: self.types
        )
        model.saveExercise(exercise)
        self.updateStates()
    }
    func delete() {
        guard let id = id, let model = model else {
            return
        }
        model.deleteExercise(exerciseId: id)
        self.updateStates()
    }
}
