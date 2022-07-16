//
//  ErrorView.swift
//  ToDo
//
//  View to display errors.
//
//  Created by Darren Danvers on 7/16/22.
//

import SwiftUI

struct ErrorView: View {
    
    let errorWrapper: ErrorWrapper
    @Environment(\.dismiss) private var dismiss;
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Error")
                    .font(.title)
                    .padding(.bottom)
                Text(errorWrapper.error.localizedDescription)
                    .font(.headline)
                Text(errorWrapper.guidance)
                    .font(.caption)
                    .padding(.top)
                Spacer()
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    
    enum FakeError: Error {
        case anError
    }
    
    static var previews: some View {
        ErrorView(errorWrapper: ErrorWrapper(error: FakeError.anError, guidance: "Try again"))
    }
}
