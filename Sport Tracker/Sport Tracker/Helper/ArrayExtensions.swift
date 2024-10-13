//
//  ArrayExtensions.swift
//  Sport Tracker
//
//  Created by ipraktikum on 11.10.24.
//

import Foundation

// MARK: Array + Replace and Sort
extension Array where Element: Identifiable & Codable & Comparable {
    /// Replaces all instances in the Array that have the same `id ` as `element`,
    /// appends the `element` and sorts the `Array`
    /// - Parameter element: The `element` that is used to perform the `replaceAndSort` operation
    public mutating func replaceAndSort(_ element: Element) {
        removeAll(where: { $0.id == element.id })
        append(element)
        sort()
    }
}
