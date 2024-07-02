//
//  Swinject_SampleApp.swift
//  Swinject-Sample
//
//  Created by 김민 on 7/2/24.
//

import SwiftUI
import Swinject

@main
struct Swinject_SampleApp: App {
    @StateObject private var appDependency = AppDependency()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: appDependency.container.resolve(ViewModel.self)!)
                .environmentObject(appDependency)
        }
    }
}

class AppDependency: ObservableObject {
    let container: Container

    init() {
        self.container = Container()

        assembleDependencies()
    }

    private func assembleDependencies() {
        let assemblies: [Assembly] = [
            RepositoryAssembly(),
            UseCaseAssembly(),
            ViewModelAssembly()
        ]

        assemblies.forEach { $0.assemble(container: container) }
    }
}

class ViewModelAssembly: Assembly {

    func assemble(container: Container) {
        container.register(ViewModel.self) { r in
            ViewModel(useCase: r.resolve(UseCaseType.self)!)
        }

        container.register(DetailViewModel.self) { r in
            DetailViewModel(useCase: r.resolve(UseCaseType.self)!) }
    }
}

class RepositoryAssembly: Assembly {

    func assemble(container: Container) {
        container.register(RepositoryType.self) { _ in
            return Repository()
        }
    }
}

class UseCaseAssembly: Assembly {

    func assemble(container: Container) {
        container.register(UseCaseType.self) { r in
            return UseCase(repository: r.resolve(RepositoryType.self)!)
        }
    }
}
