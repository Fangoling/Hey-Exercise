//
//  ExerciseDetailContentView.swift
//  Sport Tracker
//
//  Created by ipraktikum on 09.10.24.
//

import SwiftUI
import Charts

struct ExerciseDetailContentView: View {
    @Environment(Model.self) private var model: Model
    var id: Int
    var body: some View {
        TabView {
            Tab("Overview", systemImage: "list.bullet") {
                ExerciseView(model: model, modelId: id, id: id)
            }
            Tab("Performance", systemImage: "chart.bar.fill") {
                ExercisePerformanceView(id: id)
            }
        }
    }
}
