//
//  ToDoLoader.swift
//  ToDo
//
//  Protocol for classes that store and retrieve
//  to-dos from a persistent store.
//
//  Created by Darren Danvers on 7/15/22.
//

import Foundation

protocol ToDoLoader {
  
    // Loads the to-dos from a persistent store.
    //
    // Returns an array to ToDo objects.
    func load() async throws -> [ToDo]
    
    // Saves a list of ToDo objects to a persistent store.
    //
    // Returns the number of ToDos saved.
    @discardableResult
    func save(toDos: [ToDo]) async throws -> Int
}
