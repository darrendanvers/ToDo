//
//  ErrorWrapper.swift
//  ToDo
//
//  Wraps an Error as Identifiable
//  so that it can be passed to a Sheet.
//
//  Created by Darren Danvers on 7/16/22.
//

import Foundation

struct ErrorWrapper: Identifiable {
 
    let id: UUID
    let error: Error
    let guidance: String
    
    init(id: UUID = UUID(), error: Error, guidance: String) {
        self.id = id
        self.error = error
        self.guidance = guidance
    }
}
