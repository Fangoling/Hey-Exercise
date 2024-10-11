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
            }.sheet(isPresented: $addSheetOpen, content: {
                AddPerformanceView(id: id)
                    .presentationDetents([.medium])
            })
        }
    }
}

struct PerformanceView: View {
    var performance: Performance
    var body: some View {
        VStack(alignment: .leading) {
            Text(performance.date.formatted(.dateTime)).font(.caption)
            Spacer()
            HStack {
                Spacer()
                if let reps = performance.repetitions {
                    Text("\(reps.formatted(.number)) x").font(.headline)
                }
                if let weight = performance.weight {
                    Text("\(weight.formatted(.number)) kg").font(.headline)
                }
                if let duration = performance.duration {
                    Text("\(duration.formatted(.number)) seconds").font(.headline)
                }
            }
        }
    }
}

#Preview {
    ExercisePerformanceView(id: 0).environment(Model() as Model)
}
