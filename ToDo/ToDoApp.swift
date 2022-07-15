//
//  ToDoApp.swift
//  ToDo
//
//  Created by Darren Danvers on 7/14/22.
//

import SwiftUI

@main
struct ToDoApp: App {
    
    @StateObject private var toDoStore = ToDoStore()
    
    // sampleData = [ToDo(toDo: "Thing one"), ToDo(isDone: true, toDo: "Thing two")]
    
    var body: some Scene {
        WindowGroup {
            AllItemsView(toDos: $toDoStore.toDos)
        }
    }
}
