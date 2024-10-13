//
//  WorkoutOverviewView.swift
//  Sport Tracker
//
//  Created by ipraktikum on 08.10.24.
//

import SwiftUI

struct WorkoutOverviewView: View {
    @Environment(Model.self) private var model: Model
    @State private var showAddWorkoutSheet: Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Welcome Back ")
                        .font(.largeTitle) +
                        Text(model.username)
                        .font(.largeTitle)
                        .bold()
                }
                MotivationalQuoteView(quote: model.currentQuote)
                UpComingWorkoutView()
                HStack {
                    SeeAllWorkoutsButton()
                        .cardViewModifier()
                    AddWorkoutButton(showAddWorkoutSheet: $showAddWorkoutSheet)
                        .cardViewModifier()
                }
            }
            .sheet(isPresented: $showAddWorkoutSheet) { AddWorkoutView(model: model) }
            .onAppear {
                Task {
                    do {
                        try await model.getQuote()
                    }
                }
            }
        }
    }
}

struct UpComingWorkoutView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Upcoming workout: ")
                .font(.title)
            HStack {
                Text(Date().formatted(.dateTime))
                    .font(.title)
            }
        }
        .cardViewModifier()
    }
}

struct MotivationalQuoteView: View {
    var quote: Quote
    @State var showCustomFont: Bool = true
    var body: some View {
        Button(action: {
            showCustomFont.toggle()
        }, label: {
            VStack {
                if showCustomFont {
                    Text("\(quote.quote)")
                        .font(Font.custom("adelia", size: 20))
                } else {
                    Text("\(quote.quote)").font(Font.system(size: 20))
                }
                Text("- \(quote.author)").font(.headline)
            }
            .foregroundStyle(.black)
            .cardViewModifier()
        })
    }
}

struct SeeAllWorkoutsButton: View {
    var body: some View {
        NavigationLink(destination: WorkoutListView()) {
            Text("See all workouts")
                .font(.title)
        }
    }
}

struct AddWorkoutButton: View {
    @Binding var showAddWorkoutSheet: Bool
    var body: some View {
        Button(action: {
            showAddWorkoutSheet.toggle()
        }, label: {
            Text("Add new workout")
                .font(.title)
        })
    }
}

#Preview {
    ExerciseOverView()
}
