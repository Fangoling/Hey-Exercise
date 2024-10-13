//
//  ExerciseChartView.swift
//  Sport Tracker
//
//  Created by ipraktikum on 09.10.24.
//

import SwiftUI
import SwiftUICharts

struct ExerciseChartView: View {
    @Environment(Model.self) private var model: Model
    var data: [Performance]
    var exerciseType: ExerciseType
    var body: some View {
        let values: [(String, Double)] = data.map {
            ($0.date.formatted(.dateTime), $0.getValue(for: exerciseType) ?? 0.0)
        }
        CardView(showShadow: false) {
            ChartLabel(exerciseType.description, type: .title)
            BarChart()
                .scaleEffect(0.8)
        }
        .data(values)
        .chartStyle(ChartStyle(
            backgroundColor: .clear,
            foregroundColor: ColorGradient(.blue, .purple)
        ))
        .frame(height: 300)
        .cornerRadius(10)
    }
}
