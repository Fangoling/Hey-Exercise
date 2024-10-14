//
//  Exercise.swift
//  Sport Tracker
//
//  Created by ipraktikum on 08.10.24.
//

import Foundation

public enum ExerciseType: CustomStringConvertible, Codable {
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
    public var id: Int?
    public var name: String
    public var description: String
    public var types: [ExerciseType]
    public var performances: [Performance]
    public init(
        id: Int? = nil,
        name: String,
        description: String,
        types: [ExerciseType],
        performances: [Performance] = []
    ) {
        if let id = id {
            self.id = id
        } else {
            self.id = Exercise.currentId
            Exercise.currentId += 1
        }
        self.name = name
        self.description = description
        self.types = types
        self.performances = performances
    }
    public mutating func addPerformance(_ performance: Performance) {
        self.performances.append(performance)
    }
}

// MARK: Exercise: Hashable
@available(iOS 17.0, *)
extension Exercise: Hashable { }

// MARK: Exercise: Comparable
@available(iOS 17.0, *)
extension Exercise: Comparable {
    public static func < (lhs: Exercise, rhs: Exercise) -> Bool {
        let lhsId = lhs.id ?? 0
        let rhsId = rhs.id ?? 0
        return lhsId < rhsId
    }
}

// MARK: Exercise: Codable
@available(iOS 17.0, *)
extension Exercise: Codable { }

// MARK: Exercise: Identifiable
@available(iOS 17.0, *)
extension Exercise: Identifiable { }
