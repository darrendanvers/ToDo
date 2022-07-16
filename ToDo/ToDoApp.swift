//
//  ToDoApp.swift
//  ToDo
//
//  Main application driver.
//
//  Created by Darren Danvers on 7/14/22.
//

import SwiftUI

@main
struct ToDoApp: App {
    
    @StateObject private var toDoStore = ToDoStore()
    @State private var errorWrapper: ErrorWrapper?
    
    private var toDoLoader: ToDoLoader = RESTToDoLoader(url: URL(string: "http://localhost:8080")!)
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                AllItemsView(toDos: $toDoStore.toDos) {
                    // Saves to-dos when the application goes inactive.
                    Task {
                        do {
                            try await self.toDoLoader.save(toDos: toDoStore.toDos)
                        } catch {
                            self.errorWrapper = ErrorWrapper(error: error, guidance: "Unable to save data. Try again later.")
                        }
                    }
                    
                }
            }
            // Load the to-dos from disk when the application starts up.
            .task {
                do {
                    toDoStore.toDos = try await self.toDoLoader.load()
                } catch {
                    self.errorWrapper = ErrorWrapper(error: error, guidance: "Unable to load data. Try again later.")
                }
            }
            .sheet(item: self.$errorWrapper, onDismiss: { }) { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
        }
    }
}
