//
//  RestToDoLoader.swift
//  ToDo
//
//  Implementation of ToDoLoader that will use
//  an external service to save and load to-dos.
//
//  To use this class, you'll need some sort of
//  server running locally that will serve up
//  a JSON representation of ToDo objects and
//  has a POST operation on the same endpoint
//  to save ToDo objects passed as JSON objects.
//  If you don't have this, use the FileStoreToDoLoader
//  class instead.
//
//  Created by Darren Danvers on 7/15/22.
//

import Foundation
import os

// An error to throw when experiencing issues
// calling the REST sevice.
struct RESTError: Error, CustomStringConvertible {
    
    let message: String
    
    var description: String {
        return message
    }
}

// Implementation of ToDoLoader that uses a REST serivce
// to fetch and store data.
struct RESTToDoLoader: ToDoLoader {
 
    let url: URL
    let log = Logger()
    
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
    
    // Loads the list of to-dos from a server.
    private func load(completion: @escaping (Result<[ToDo], Error>) -> Void) {

        let task = URLSession.shared.dataTask(with: self.url) { (data, response, error) in
            
            if let error = error {
                log.info("In error")
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            if let data = data {
                log.info("Doing data")
                do {
                    let toDos = try JSONDecoder().decode([ToDo].self, from: data)
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
        task.resume()
        log.info("leaving function")
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
    
    // Saves the list of to-dos to a server.
    private func save(toDos: [ToDo], completion: @escaping (Result<Int, Error>) -> Void) {
        
        guard let toPost = try? JSONEncoder().encode(toDos) else {
            return
        }
        log.info("About to do POST")
        var request = URLRequest(url: self.url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.uploadTask(with: request, from: toPost) { (data, response, error) in
            if let error = error {
                log.info("Got POST error")
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(RESTError(message: "Response was of wrong type")))
                }
                return
            }
                
            if (200...299).contains(httpResponse.statusCode) {
                log.info("Save succeeded")
                DispatchQueue.main.async {
                    completion(.success(toDos.count))
                }
            } else {
                log.info("Save failed")
                DispatchQueue.main.async {
                    completion(.failure(RESTError(message: "HTTP Error \(httpResponse.statusCode) calling REST service")))
                }
            }
        }
        task.resume()
    }
}
