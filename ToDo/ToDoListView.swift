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
                    // Strike through the text if the to-do is done.
                    .strikethrough(toDo.isDone)
                    // Allow the user to swipe left to say they are done
                    // and right to undo.
                    .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onEnded({value in
                            if value.translation.width < 0 {
                                toDo.complete()
                            }
                            if value.translation.width > 0 {
                                toDo.uncomplete()
                            }
                        }))
            }
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    
    static let sampleData = [ToDo(toDo: "Thing one"), ToDo(isDone: true, toDo: "Thing two")]
    
    static var previews: some View {
        ToDoListView(toDos: .constant(sampleData))
    }
}
