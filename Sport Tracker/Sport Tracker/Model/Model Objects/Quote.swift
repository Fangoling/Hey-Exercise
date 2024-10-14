//
//  Quote.swift
//  Sport Tracker
//
//  Created by ipraktikum on 11.10.24.
//

public struct Quote: Codable {
    public var quote: String
    public var author: String
    public var html: String
    enum CodingKeys: String, CodingKey {
        case quote = "q"
        case author = "a"
        case html = "h"
    }
}
