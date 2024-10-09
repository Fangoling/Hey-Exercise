//
//  Exercise.swift
//  Sport Tracker
//
//  Created by ipraktikum on 08.10.24.
//

import Foundation

public struct Exercise {
    public var id: UUID?
    public var name: String
    public var description: String
    public var icon: String?
    public var progress: [Int] = [1,2,3,4,5,6,7]
}

// MARK: Exercise: Hashable
@available(iOS 17.0, *)
extension Exercise: Hashable { }
