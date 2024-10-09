//
//  ExerciseStatisticsView.swift
//  Sport Tracker
//
//  Created by ipraktikum on 09.10.24.
//

import SwiftUI
import Charts

struct ExerciseStatisticsView: View {
    
    @Environment(Model.self) private var model: Model
    
    var id: UUID?
    
    var body: some View {
        let data = model.exercise(id)?.progress ?? [0]
        
        VStack {
            Text(model.exercise(id)?.name ?? "No exercise selected").font(.headline)
            Divider()
            Text("Repetitions").font(.subheadline)
            ExerciseChartView(data: data)
            Text("Weight").font(.subheadline)
            ExerciseChartView(data: data)
        }

    }
    
}
