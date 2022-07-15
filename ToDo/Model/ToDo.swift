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
    var isDone: Bool
    
    init(id: UUID = UUID(), isDone: Bool = false, toDo: String) {
        self.id = id
        self.toDo = toDo
        self.isDone = isDone
    }
}
