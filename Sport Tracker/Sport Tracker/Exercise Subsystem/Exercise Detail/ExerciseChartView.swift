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
    var data: [Performance]
    var exerciseType: ExerciseType
    var body: some View {
        Chart(data) {
            BarMark(
                x: .value("Day", $0.date),
                y: .value(exerciseType.description, $0.getValue(for: exerciseType) ?? 0.0)
            )
        }
        .frame(maxWidth: .infinity)
        .scaleEffect(0.8)
        .background(Color("CardColor"))
        .padding()
    }
}
