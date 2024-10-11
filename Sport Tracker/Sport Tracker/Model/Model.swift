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
        self.exercises = [
            Exercise(
                name: "Push-ups",
                description: "Doing Push-ups",
                types: [.repetitions]
            ),
            Exercise(
                name: "Squats",
                description: "Doing Squats",
                types: [.repetitions]
            ),
            Exercise(
                name: "Plank",
                description: "Doing Planks",
                types: [.duration]
            ),
            Exercise(
                name: "Benchpress",
                description: "Doing Benchpress",
                types: [.repetitions, .weight]
            )
        ]
        let startDate: Date = Date.now
        let repetitions = [10.0, 11.0, 12.0, 20.0, 23.0, 27.0, 30.0]
        let durations: [Double] = [30, 30, 40, 50, 55, 55, 60]
        let repAndWeight: [(Double, Double)] = [(10, 30), (12, 30), (8, 40), (3, 50), (7, 50)]
        for (index, rep) in repetitions.enumerated() {
            if let perfday = Calendar.current.date(byAdding: .day, value: index, to: startDate) {
                self.exercises[0].addPerformance(Performance(date: perfday, repetitions: rep))
                self.exercises[1].addPerformance(Performance(date: perfday, repetitions: rep))
            }
        }
        for (index, repweight) in repAndWeight.enumerated() {
            if let perfday = Calendar.current.date(byAdding: .day, value: index, to: startDate) {
                let performance = Performance(date: perfday, repetitions: repweight.0, weight: repweight.1)
                self.exercises[3].addPerformance(performance)
            }
        }
        for (index, duration) in durations.enumerated() {
            if let perfday = Calendar.current.date(byAdding: .day, value: index, to: startDate) {
                let performance = Performance(date: perfday, duration: duration)
                self.exercises[2].addPerformance(performance)
            }

        }
    }
    public func addExercise(name: String, description: String, exerciseTypes: [ExerciseType]) {
        exercises.append(Exercise(name: name, description: description, types: exerciseTypes))
    }
    public func addPerformance(id: Int, _ performance: Performance) {
        var performances: [Performance] = []
        if let exercise = exercise(id) {
            performances = exercise.performances
            performances.append(performance)
            exercises[id].performances = performances
        }
    }
    public func exercise(_ id: Int) -> Exercise? {
        return exercises.first(where: { $0.id == id })
    }
    public func bestPerformance(_ id: Int, for exerciseType: ExerciseType) -> Performance? {
        let performanceList = exercise(id)?.performances
        return performanceList?.max {
            return switch exerciseType {
            case .repetitions: $0.repetitions! < $1.repetitions!
            case .duration: $0.duration! < $1.duration!
            case .weight: $0.weight! < $1.weight!
            }
        }
    }
    public func getTypes(for id: Int) -> [ExerciseType] {
        return exercise(id)?.types ?? []
    }
    public func sortedPerformance(_ id: Int, for exerciseType: ExerciseType) -> [Performance] {
        if let exercise = exercise(id) {
            return exercise.performances.sorted {
                $0.date < $1.date
            }
        }
        return []
    }
}
