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
    var id: Int
    var body: some View {
        let sortedPerformances = model.sortedPerformance(id, for: .repetitions)
        Text(model.exercise(id)?.name ?? "No exercise selected").font(.title)
        List {
            ForEach(sortedPerformances, id: \.self) { perf in
                VStack(alignment: .leading) {
                    Text(perf.date.formatted(.dateTime)).font(.caption)
                    Spacer()
                    HStack {
                        if let reps = perf.repetitions {
                            Spacer()
                            Text("\(reps) repetitions").font(Font.system(size: 24, weight: .bold))
                            Spacer()
                        }
                        if let weight = perf.weight {
                            Text("\(weight) kg").font(.caption)
                        }
                        Spacer()
                        if let duration = perf.duration {
                            Text("\(duration) seconds").font(.caption)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ExercisePerformanceView(id: 0).environment(Model() as Model)
}
