//
//  ContentView.swift
//  ToDo
//
//  Main application view.
//
//  Created by Darren Danvers on 7/14/22.
//

import SwiftUI

struct AllItemsView: View {
    
    @Binding var toDos: [ToDo]
    @State private var newToDo = ""
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: () -> Void
    
    var body: some View {
        
        VStack {
            HStack {
                TextField("I will...", text: $newToDo)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    guard !self.newToDo.isEmpty else {
                        return
                    }
                    self.toDos.append(ToDo(toDo: self.newToDo))
                    self.newToDo = ""
                }) {
                    Image(systemName: "plus")
                }
            }
            .padding()
            
            Spacer()
            
            ToDoListView(toDos: self.$toDos)
        }.onChange(of: scenePhase) { phase in
            if phase == .inactive { self.saveAction() }
        }
    }
}

struct AllItemsView_Previews: PreviewProvider {
    
    static let sampleData = [ToDo(toDo: "Thing one"), ToDo(isDone: true, toDo: "Thing two")]
    
    static var previews: some View {
        AllItemsView(toDos: .constant(sampleData), saveAction: {})
    }
}
