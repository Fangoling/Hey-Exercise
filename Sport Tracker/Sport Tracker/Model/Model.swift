//
//  Model.swift
//  Sport Tracker
//
//  Created by ipraktikum on 09.10.24.
//

import Foundation

@Observable public class Model {
    
    public var exercises: [Exercise]
    public init(
        exercises: [Exercise] = []
    ) {
        self.exercises = []
    }
    
    public func addExercise(name: String, description: String) {
        exercises.append(Exercise(id: UUID(), name: name, description: description))
    }
    
    public func exercise(_ id: UUID?) -> Exercise? {
        exercises.first(where: { $0.id == id })
    }
}
