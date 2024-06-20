//
//  AuthenticationViewModel.swift
//  ChattingApp
//
//  Created by 김민 on 6/20/24.
//

import Foundation
import Combine

enum AuthenticationState {
    case unauthenticated
    case authenticated
}

class AuthenticationViewModel: ObservableObject {

    enum Action {
        case googleLogin
    }

    @Published var authenticationState: AuthenticationState = .unauthenticated

    private var container: DIContainer
    private var subscriptions = Set<AnyCancellable>()

    var userId: String?

    init(container: DIContainer) {
        self.container = container
    }

    func send(action: Action) {
        switch action {
        case .googleLogin:
            container.services.authService.signInWithGoogle()
                .sink { completion in
                    // TODO: -
                } receiveValue: { [weak self] user in
                    self?.userId = user.id
                }
                .store(in: &subscriptions)

            return
        }
    }
}
