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
    
    var id: UUID?
    
    var body: some View {
        TabView {
            
            Tab("Overview", systemImage: "list.bullet") {
                ExerciseView(id: id)
            }
            
            Tab("Statistics", systemImage: "chart.bar.fill") {
                ExerciseStatisticsView(id: id)
            }
        }

    }
    
}

