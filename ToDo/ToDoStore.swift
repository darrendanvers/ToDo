//
//  ToDoStore.swift
//  ToDo
//
//  Created by Darren Danvers on 7/15/22.
//

import Foundation
import SwiftUI

class ToDoStore: ObservableObject {
    
    @Published var toDos: [ToDo] = []
    
    init() {
        self.toDos.append(ToDo(toDo: "Thing one"))
        self.toDos.append(ToDo(isDone: true, toDo: "Thing two"))
    }
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("todo.data")
    }
    
    @discardableResult
    func save() async throws -> Int {
        try await withCheckedThrowingContinuation { continuation in
            save() { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let countSaved):
                    continuation.resume(returning: countSaved)
                }
            }
        }
    }
    
    func save(completion: @escaping (Result<Int, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            
            do {
                let data = try JSONEncoder().encode(self.toDos)
                let outFile = try ToDoStore.fileURL()
                try data.write(to: outFile)
                DispatchQueue.main.async {
                    completion(.success(self.toDos.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
