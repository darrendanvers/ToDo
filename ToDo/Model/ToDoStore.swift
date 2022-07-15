//
//  ToDoStore.swift
//  ToDo
//
//  The class that contains the application's to-do list and the
//  functions to read and write that list to the file system.
//
//  Created by Darren Danvers on 7/15/22.
//

import Foundation

class ToDoStore: ObservableObject {
    
    @Published var toDos: [ToDo] = []
}
