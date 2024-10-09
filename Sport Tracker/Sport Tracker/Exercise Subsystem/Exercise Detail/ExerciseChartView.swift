//
//  ExerciseChartView.swift
//  Sport Tracker
//
//  Created by ipraktikum on 09.10.24.
//

import SwiftUI
import Charts

struct ExerciseChartView: View {
    
    @Environment(Model.self) private var model: Model
    
    var data: [Int]
    
    var body: some View {
        Chart {
            ForEach(data, id: \.self) { value in
                BarMark(
                   x: .value("Day", value),
                   y: .value("Reps", value)
                )
            }
        }
        .frame(height: 200)
        .padding()
    }
    
}
