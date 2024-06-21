//
//  AuthenticationViewModel.swift
//  ChattingApp
//
//  Created by 김민 on 6/20/24.
//

import Foundation
import Combine
import AuthenticationServices

enum AuthenticationState {
    case unauthenticated
    case authenticated
}

class AuthenticationViewModel: ObservableObject {

    enum Action {
        case googleLogin
        case appleLogin(ASAuthorizationAppleIDRequest)
        case appleLoginCompletion(Result<ASAuthorization, Error>)
    }

    @Published var authenticationState: AuthenticationState = .unauthenticated

    private var container: DIContainer
    private var subscriptions = Set<AnyCancellable>()
    private var currentNonce: String?

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
        case let .appleLogin(request):
            let nonce = container.services.authService.handleSignInWithAppleRequest(request)
            currentNonce = nonce
        case let .appleLoginCompletion(result):
            if case let .success(authorization) = result {
                guard let nonce = currentNonce else { return }

                container.services.authService.handleSignInWithAppleCompletion(authorization, nonce: nonce)
                    .sink { completion in
                        // TODO:
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
