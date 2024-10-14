//
//  Performance.swift
//  Sport Tracker
//
//  Created by ipraktikum on 10.10.24.
//

import Foundation
import Charts

public struct Performance {
    public var id: Int
    static var currentId: Int = 0
    var date: Date
    var weight: Double?
    var repetitions: Double?
    var duration: Double?
    init(date: Date, repetitions: Double? = nil, weight: Double? = nil, duration: Double? = nil) {
        self.id = Performance.currentId
        Performance.currentId += 1
        self.date = date
        self.repetitions = repetitions
        self.weight = weight
        self.duration = duration
    }
    public func getValue(for key: ExerciseType) -> Double? {
        switch key {
        case .repetitions: return repetitions
        case .weight: return weight
        case .duration: return duration
        }
    }
}

// MARK: Performance: Hashable
@available(iOS 17.0, *)
extension Performance: Hashable { }

// MARK: Performance: Identifiable
@available(iOS 17.0, *)
extension Performance: Identifiable { }

// MARK: Performance: Codable
@available(iOS 17.0, *)
extension Performance: Codable { }
