//
//  ExerciseOverviewView.swift
//  Sport Tracker
//
//  Created by Fangxing Liu on 08.10.24.
//

import SwiftUI

struct ExerciseOverView: View {
    @Environment(Model.self) private var model: Model
    @State private var addSheetOpen = false
    var body: some View {
       NavigationStack {
           ExerciseListView()
               .backgroundViewModifier()
               .navigationTitle("Exercises")
               .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: {
                            addSheetOpen.toggle()
                        }, label: {
                            Image(systemName: "plus")
                        })
                    }
               }.sheet(isPresented: $addSheetOpen, content: { AddExerciseView() })
       }
    }
}

#Preview {
    ExerciseOverView()
}
