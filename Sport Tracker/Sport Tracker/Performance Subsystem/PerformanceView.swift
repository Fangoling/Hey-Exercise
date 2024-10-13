//
//  PerformanceView.swift
//  Sport Tracker
//
//  Created by ipraktikum on 10.10.24.
//

import SwiftUI

struct PerformanceView: View {
    var performance: Performance
    var body: some View {
        HStack {
            Text(performance.date.formatted(.dateTime))
                .font(.callout)
            Spacer()
            if let reps = performance.repetitions {
                Text("\(reps.formatted(.number)) x")
                    .font(.title)
                    .cornerRadius(10)
            }
            if let weight = performance.weight {
                Text("\(weight.formatted(.number)) kg")
                    .font(.title)
                    .cornerRadius(10)
            }
            if let duration = performance.duration {
                Text("\(duration.formatted(.number)) seconds")
                    .font(.title)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

struct BestPerformanceView: View {
    @Environment(Model.self) private var model: Model
    var id: Int
    var exerciseType: ExerciseType
    var body: some View {
        // let exercise = model.exercise(id)
        if let bestPerformance = model.bestPerformance(id, for: exerciseType) {
            HStack {
                Text("Best Performance: ").font(.title)
                Spacer()
                if let repetitions = bestPerformance.repetitions {
                    Text("\(repetitions.formatted(.number)) x").font(.title)
                }
                if let weight = bestPerformance.weight {
                    Text("\(weight.formatted(.number)) kg.").font(.title)
                }
                if let duration = bestPerformance.duration {
                    Text("\(duration.formatted(.number)) seconds.").font(.title)
                }
            }.padding()
        }
    }
}

#Preview {
    BestPerformanceView(id: 0, exerciseType: .repetitions)
        .environment(Model() as Model)
}
