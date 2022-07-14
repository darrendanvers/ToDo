//
//  ToDo.swift
//  ToDo
//
//  Model obect for to-do items.
//
//  Created by Darren Danvers on 7/14/22.
//

import Foundation

struct ToDo: Identifiable {
    let id: UUID
    let toDo: String
    var isDone = false
    
    init(id: UUID = UUID(), toDo: String) {
        self.id = id
        self.toDo = toDo
    }
}
