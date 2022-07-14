//
//  ToDoListView.swift
//  ToDo
//
//  View that displays each item that has been added to
//  the to-do list.
//
//  Created by Darren Danvers on 7/14/22.
//

import SwiftUI

struct ToDoListView: View {
    
    @Binding var toDos: [ToDo]
    
    var body: some View {
        List {
            ForEach($toDos) { $toDo in
                Text(toDo.toDo)
            }
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    
    static let sampleData = [ToDo(toDo: "Thing one"), ToDo(toDo: "Thing two")]
    
    static var previews: some View {
        ToDoListView(toDos: .constant(sampleData))
    }
}
