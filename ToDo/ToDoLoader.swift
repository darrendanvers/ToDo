//
//  ToDoLoader.swift
//  ToDo
//
//  Created by Darren Danvers on 7/15/22.
//

import Foundation

protocol ToDoLoader {
    
    func load() async throws -> [ToDo]
    
    @discardableResult
    func save(toDos: [ToDo]) async throws -> Int
}
