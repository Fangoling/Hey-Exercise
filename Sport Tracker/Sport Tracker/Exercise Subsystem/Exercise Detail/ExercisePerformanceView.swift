//
//  ExerciseStatisticsView.swift
//  Sport Tracker
//
//  Created by ipraktikum on 09.10.24.
//

import SwiftUI
import Charts

struct ExercisePerformanceView: View {
    @Environment(Model.self) private var model: Model
    @State private var addSheetOpen: Bool = false
    var id: Int
    var body: some View {
        let sortedPerformances = model.sortedPerformance(id, for: .repetitions)
        NavigationView {
            List {
                ForEach(sortedPerformances, id: \.self) { perf in
                    PerformanceView(performance: perf)
                }
            }
            .navigationTitle("Perfomances")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        addSheetOpen.toggle()
                    }, label: {
                        ZStack {
                            Image(systemName: "plus")
                        }
                    })
                }
            }
            .sheet(isPresented: $addSheetOpen) {
                AddPerformanceView(id: id)
                    .presentationDetents([.medium])
            }
        }
    }
}

#Preview {
    ExercisePerformanceView(id: 0).environment(Model() as Model)
}
