//
//  ContentView.swift
//  Swinject-Sample
//
//  Created by 김민 on 7/2/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appDependency: AppDependency
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        NavigationStack {
            NavigationLink {
                DetailView(viewModel: appDependency.container.resolve(DetailViewModel.self)!)
            } label: {
                Text("Go to Detail button")
            }
            .onAppear {
                viewModel.hi()
            }
        }
    }
}

#Preview {
    ContentView(viewModel: .init(useCase: StubUseCase()))
        .environmentObject(AppDependency())
}
