//
//  AddExerciseView.swift
//  Sport Tracker
//
//  Created by ipraktikum on 09.10.24.
//

import SwiftUI

struct AddExerciseView: View{
    @Environment(Model.self) private var model: Model
    @Environment(\.dismiss) private var dismiss
    
    @State var name: String = ""
    @State var description: String = ""

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Name")) {
                    TextField("Name", text: $name)
                }
                Section(header: Text("Description")) {
                    TextField("Description", text: $description)
                }
            }.navigationBarTitle("Add Exercise", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            model.addExercise(name: name, description: description)
                            dismiss()
                        } label: {
                            Text("Add").bold()
                        }
                    }
                }
        }
    }
}


#Preview {
    AddExerciseView().environment(Model() as Model)
}
