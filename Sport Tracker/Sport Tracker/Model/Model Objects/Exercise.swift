//
//  Exercise.swift
//  Sport Tracker
//
//  Created by ipraktikum on 08.10.24.
//

import Foundation

public enum ExerciseType: CustomStringConvertible {
    case weight
    case repetitions
    case duration
    public var description: String {
        switch self {
        case .weight: return "Weight"
        case .repetitions: return "Repetitions"
        case .duration: return "Duration"
        }
    }
}

public struct Exercise {
    static var currentId: Int = 0
    public var id: Int
    public var name: String
    public var description: String
    public var types: [ExerciseType]
    public var performances: [Performance]
    public init(name: String, description: String, types: [ExerciseType]) {
        self.id = Exercise.currentId
        Exercise.currentId += 1
        self.name = name
        self.description = description
        self.types = types
        self.performances = []
    }
    public mutating func addPerformance(_ performance: Performance) {
        self.performances.append(performance)
    }
}

// MARK: Exercise: Hashable
@available(iOS 17.0, *)
extension Exercise: Hashable { }
