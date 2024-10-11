//
//  ExerciseView.swift
//  Sport Tracker
//
//  Created by ipraktikum on 09.10.24.
//

import SwiftUI
import Charts

struct ExerciseView: View {
    @Environment(Model.self) private var model: Model
    @State private var addSheetOpen: Bool = false
    var id: Int
    var body: some View {
        let exercise = model.exercise(id)
        let exerciseTypes = exercise?.types ?? []
        let data = model.exercise(id)?.performances ?? []
        ScrollView {
            VStack {
                ForEach(exerciseTypes, id: \.self) { type in
                    ExerciseDetailView(id: id, type: type, data: data)
                        .shadow(color: Color.black.opacity(0.2), radius: 4)
                }
                VStack {
                    Text("Notes").font(.largeTitle)
                    Text(exercise?.description ?? "No notes")
                        .frame(minHeight: 100)
                }
            }
        }
    }
}

struct ExerciseDetailView: View {
    var id: Int
    var type: ExerciseType
    var data: [Performance]
    var body: some View {
        VStack {
            Text(type.description).font(.largeTitle)
            BestPerformanceView(id: id, exerciseType: type)
            ExerciseChartView(data: data, exerciseType: type)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color("CardColor"))
        .cornerRadius(20)
        .padding()
    }
}

#Preview {
    ExerciseView(id: 0)
        .environment(Model() as Model)
}
