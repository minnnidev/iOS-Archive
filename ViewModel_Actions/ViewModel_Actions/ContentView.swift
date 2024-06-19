//
//  ContentView.swift
//  ViewModel_Actions
//
//  Created by 김민 on 6/19/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        VStack {
            Button {
                viewModel.send(.add)
            } label: {
                Text("add")
            }

            Button {
                viewModel.send(.delete)
            } label: {
                Text("delete")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
