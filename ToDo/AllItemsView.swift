//
//  ContentView.swift
//  ToDo
//
//  Created by Darren Danvers on 7/14/22.
//

import SwiftUI

struct AllItemsView: View {
    
    @Binding var toDos: [ToDo]
    
    var body: some View {
        ToDoListView(toDos: self.$toDos)
            .padding()
    }
}

struct AllItemsView_Previews: PreviewProvider {
    
    static let sampleData = [ToDo(toDo: "Thing one"), ToDo(isDone: true, toDo: "Thing two")]
    
    static var previews: some View {
        AllItemsView(toDos: .constant(sampleData))
    }
}
