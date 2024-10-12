//
//  Workout.swift
//  Sport Tracker
//
//  Created by ipraktikum on 08.10.24.
//

import Foundation
import SwiftUI

public struct ExercisePerformancePair {
    public var exercise: Exercise
    public var performance: Performance
}

// MARK: ExercisePerformancePair: Codable
@available(iOS 17.0, *)
extension ExercisePerformancePair: Codable { }

// MARK: ExercisePerformancePair: Equatable
@available(iOS 17.0, *)
extension ExercisePerformancePair: Equatable { }

// MARK: ExercisePerformancePair: Hashable
@available(iOS 17.0, *)
extension ExercisePerformancePair: Hashable { }

public struct Workout {
    static var currentId: Int = 0
    public var id: Int
    public var date: Date
    public var exercisePairs: [ExercisePerformancePair]

    public init(id: Int? = nil, date: Date, exercisePairs: [ExercisePerformancePair]) {
        if let id = id {
            self.id = id
        } else {
            self.id = Workout.currentId
            Workout.currentId += 1
        }
        self.date = date
        self.exercisePairs = exercisePairs
    }

    public mutating func addExercise(_ exercise: Exercise, _ performace: Performance) {
        self.exercisePairs.append(ExercisePerformancePair(exercise: exercise, performance: performace))
    }
}

// MARK: Workout: Comparable
@available(iOS 17.0, *)
extension Workout: Comparable {
    public static func < (lhs: Workout, rhs: Workout) -> Bool {
        lhs.date < rhs.date
    }
}

// MARK: Workout: Codable
@available(iOS 17.0, *)
extension Workout: Codable { }

// MARK: Workout: Decodable
@available(iOS 17.0, *)
extension Workout: Identifiable { }

// MARK: Workout: Hashable
@available(iOS 17.0, *)
extension Workout: Hashable { }

// MARK: Workout: Equatable
@available(iOS 17.0, *)
extension Workout: Equatable {
    public static func == (lhs: Workout, rhs: Workout) -> Bool {
        lhs.id == rhs.id &&
            lhs.date == rhs.date &&
            lhs.exercisePairs == rhs.exercisePairs
    }
}
