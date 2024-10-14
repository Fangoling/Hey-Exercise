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
            VStack(spacing: 16) {
                HStack {
                    Text("Welcome Back ")
                        .font(.largeTitle) +
                        Text(model.username)
                        .font(.largeTitle)
                        .bold()
                }
                MotivationalQuoteView(quote: model.currentQuote)
                UpComingWorkoutView(model: model, latestWorkout: model.getLatestWorkout())
                HStack(spacing: 16) {
                    SeeAllWorkoutsButton()
                        .cardViewModifier()
                    AddWorkoutButton(model: model, showAddWorkoutSheet: $showAddWorkoutSheet)
                }
            }
            .padding()
            .sheet(isPresented: $showAddWorkoutSheet) { AddWorkoutView(model: model) }
            .onAppear {
                Task {
                    do {
                        try await model.getQuote()
                    }
                }
            }
        }
        .foregroundStyle(.font)
    }
}

struct UpComingWorkoutView: View {
    var model: Model
    var latestWorkout: Workout?
    var body: some View {
        if let workout = latestWorkout {
            NavigationLink(destination: AddWorkoutView(
                model: model,
                id: workout.id
            )) {
                VStack(alignment: .center) {
                    Text("Upcoming workout: ")
                        .font(.title)
                        .bold()
                    Text(workout.date.formatted(.dateTime))
                        .font(.title2)
                }
            }
            .cardViewModifier()
        } else {
            VStack(alignment: .leading) {
                Text("Upcoming workout: ")
                    .font(.title)
            }
            .cardViewModifier()
        }
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
                    Text("\(quote.quote)")
                        .font(Font.system(size: 20))
                }
                Text("- \(quote.author)")
                    .font(.headline)
            }
            .foregroundStyle(.primary)
            .cardViewModifier()
        })
    }
}

struct SeeAllWorkoutsButton: View {
    var body: some View {
        NavigationLink(destination: WorkoutListView()) {
            Text("See all workouts")
                .font(.title2)
        }
    }
}

struct AddWorkoutButton: View {
    var model: Model
    @Binding var showAddWorkoutSheet: Bool
    var body: some View {
        NavigationLink(destination: AddWorkoutView(
            model: model,
            id: nil
        )) {
            VStack(alignment: .leading) {
                Text("Add new workout")
                    .font(.title2)
            }
        }
        .cardViewModifier()
    }
}

#Preview {
    ExerciseOverView()
}
