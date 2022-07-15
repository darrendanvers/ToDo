//
//  FileStoreToDoLoader.swift
//  ToDo
//
//  Created by Darren Danvers on 7/15/22.
//

import Foundation
import SwiftUI

struct FileStoreToDoLoader: ToDoLoader {
    
    // Genrates the URL to the location to store to-dos on disk.
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("todo.data")
    }
    
    // Wrapper around the the load function to allow for the new style of async/await.
    func load() async throws -> [ToDo] {
        try await withCheckedThrowingContinuation { continuation in
            load { result in
                
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let toDos):
                    continuation.resume(returning: toDos)
                }
            }
        }
    }
    
    // Loads the list of to-dos from disk.
    private func load(completion: @escaping (Result<[ToDo], Error>) -> Void) {
         
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try FileStoreToDoLoader.fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let toDos = try JSONDecoder().decode([ToDo].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(toDos))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    // Wrapper around the the save function to allow for the new style of async/await.
    @discardableResult
    func save(toDos: [ToDo]) async throws -> Int {
        try await withCheckedThrowingContinuation { continuation in
            save(toDos: toDos) { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let countSaved):
                    continuation.resume(returning: countSaved)
                }
            }
        }
    }
    
    // Saves the list of to-dos to disk.
    private func save(toDos: [ToDo], completion: @escaping (Result<Int, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            
            do {
                let data = try JSONEncoder().encode(toDos)
                let outFile = try FileStoreToDoLoader.fileURL()
                try data.write(to: outFile)
                DispatchQueue.main.async {
                    completion(.success(toDos.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
}
