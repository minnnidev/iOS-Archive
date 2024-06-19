//
//  AuthenticatedViewModel.swift
//  Messenger
//
//  Created by 김민 on 6/19/24.
//

import Foundation
import Combine

enum AuthenticationState {
    case unauthenticated
    case authenticated
}

class AuthenticatedViewModel: ObservableObject {
    @Published var authenticationState: AuthenticationState = .unauthenticated

    var userId: String?

    private var container: DIContainer
    private var subscriptions = Set<AnyCancellable>()

    init(container: DIContainer) {
        self.container = container
    }

    enum Action {
        case googleLogin
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
