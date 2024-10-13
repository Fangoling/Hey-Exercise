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
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var showTabBar = false
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
        // hacky toolbar to hide outer tabbar when inside the nested tabbar
        // prevents slow reload of outer tabbar when going back
        .toolbar(showTabBar ? .visible : .hidden, for: .tabBar)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.mode.wrappedValue.dismiss()
            showTabBar.toggle()
        }, label: {
            Image(systemName: "chevron.backward").bold()
            Text("Back")
        }))
    }
}
