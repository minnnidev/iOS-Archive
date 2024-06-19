//
//  AuthenticatedViewModel.swift
//  Messenger
//
//  Created by 김민 on 6/19/24.
//

import Foundation
import Combine
import AuthenticationServices

enum AuthenticationState {
    case unauthenticated
    case authenticated
}

class AuthenticatedViewModel: ObservableObject {
    @Published var authenticationState: AuthenticationState = .unauthenticated

    var userId: String?

    private var currentNonce: String?
    private var container: DIContainer
    private var subscriptions = Set<AnyCancellable>()

    init(container: DIContainer) {
        self.container = container
    }

    enum Action {
        case googleLogin
        case appleLogin(ASAuthorizationAppleIDRequest)
        case appleLoginCompletion(Result<ASAuthorization, Error>)
    }

    func send(action: Action) {
        switch action {
        case .googleLogin:
            container.services.authService.signInWithGoogle()
                .sink { completion in
                } receiveValue: { [weak self] user in
                    self?.userId = user.id
                }
                .store(in: &subscriptions)
        case .appleLogin(let request):
            let nonce = container.services.authService.handleSignInWithAppleRequest(request)
            currentNonce = nonce
            
        case .appleLoginCompletion(let result):
            if case let .success(authorization) = result {
                guard let nonce = currentNonce else { return }

                container.services.authService.handleSignInWithAppleCompletion(authorization, nonce: nonce)
                    .sink { completion in

                    } receiveValue: { [weak self] user in
                        self?.userId = user.id
                    }
                    .store(in: &subscriptions)
            } else if case let .failure(error) = result {
                print(error.localizedDescription)
            }
        }
    }
}
