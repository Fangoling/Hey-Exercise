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
    
    var id: UUID?
    
    var body: some View {
        let exercise = model.exercise(id)
        VStack {
            Text(exercise?.description ?? "No description selected")
        }
        .navigationTitle(exercise?.name ?? "No exercise selected")
        .toolbar {
            ToolbarItem(placement: .automatic) {
                 Button(action: {
                     addSheetOpen.toggle()
                 }, label: {
                     Image(systemName: "plus")
                 })
             }
        }
        .sheet(isPresented: $addSheetOpen, content: { AddExerciseView() })
    }
    
}


