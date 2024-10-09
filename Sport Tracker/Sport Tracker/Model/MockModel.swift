//
//  MockModel.swift
//  Sport Tracker
//
//  Created by ipraktikum on 09.10.24.
//

import Foundation

public class MockModel: Model {
    
    public convenience init() {
        
        let ex1 = Exercise(id: UUID(), name: "Pushup", description: "Do Pushups")
        let ex2 = Exercise(id: UUID(), name: "Squat", description: "Do Squats")
        let ex3 = Exercise(id: UUID(), name: "Plank", description: "Do Planks")
        let ex4 = Exercise(id: UUID(), name: "Jumping Jacks", description: "Do Jumping Jacks")
        
        
        let exercises: [Exercise] = [ex1, ex2, ex3, ex4]
        
        self.init(exercises: exercises)
    }
    
}
