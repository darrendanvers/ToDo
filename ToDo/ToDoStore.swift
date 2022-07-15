//
//  ToDoStore.swift
//  ToDo
//
//  Created by Darren Danvers on 7/15/22.
//

import Foundation

class ToDoStore: ObservableObject {
    
    @Published var toDos: [ToDo] = []
    
    init() {
        self.toDos.append(ToDo(toDo: "Thing one"))
        self.toDos.append(ToDo(isDone: true, toDo: "Thing two"))
    }
}
