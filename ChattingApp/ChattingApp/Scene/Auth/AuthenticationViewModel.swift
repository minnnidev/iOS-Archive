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
        case checkAuthenticationState
        case googleLogin
        case appleLogin(ASAuthorizationAppleIDRequest)
        case appleLoginCompletion(Result<ASAuthorization, Error>)
        case logout
        case requestPushNotification
        case setFcmToken
    }

    @Published var authenticationState: AuthenticationState = .unauthenticated
    @Published var isLoading = false

    private var container: DIContainer
    private var subscriptions = Set<AnyCancellable>()
    private var currentNonce: String?

    var userId: String?

    init(container: DIContainer) {
        self.container = container
    }

    func send(action: Action) {
        switch action {
        case .checkAuthenticationState:
            if let userId = container.services.authService.checkAuthentication() {
                self.userId = userId
                self.authenticationState = .authenticated
            }
            
        case .googleLogin:
            isLoading = true
            container.services.authService.signInWithGoogle()
                .flatMap { user in
                    self.container.services.userService.addUser(user)
                }
                .sink { [weak self] completion in
                    if case .failure = completion {
                        self?.isLoading = false
                        // TODO: - alert 추가
                    }
                } receiveValue: { [weak self] user in
                    self?.isLoading = false
                    self?.userId = user.id
                    self?.authenticationState = .authenticated
                }
                .store(in: &subscriptions)

        case let .appleLogin(request):
            let nonce = container.services.authService.handleSignInWithAppleRequest(request)
            currentNonce = nonce

        case let .appleLoginCompletion(result):
            isLoading = true
            if case let .success(authorization) = result {
                guard let nonce = currentNonce else { return }

                container.services.authService.handleSignInWithAppleCompletion(authorization, nonce: nonce)
                    .flatMap { user in
                        self.container.services.userService.addUser(user)
                    }
                    .sink { [weak self] completion in
                        if case .failure = completion {
                            self?.isLoading = false
                            // TODO: - alert 추가
                        }
                    } receiveValue: { [weak self] user in
                        self?.isLoading = false
                        self?.userId = user.id
                        self?.authenticationState = .authenticated
                    }
                    .store(in: &subscriptions)
            } else if case let .failure(error) = result {
                print(error.localizedDescription)
                isLoading = false
            }

        case .logout:
            container.services.authService.logout()
                .sink { completion in
                    // TODO: 
                } receiveValue: { [weak self] _ in
                    self?.authenticationState = .unauthenticated
                    self?.userId = nil
                }
                .store(in: &subscriptions)

        case .requestPushNotification:
            container.services.pushNotificationService.requestAuthorization { [weak self] granted in
                guard granted else { return }
                self?.send(action: .setFcmToken)
            }
        case .setFcmToken:
            container.services.pushNotificationService.fcmToken
                .compactMap { $0 }
                .flatMap { fcmToken -> AnyPublisher<Void, Never> in
                    guard let userId = self.userId else { return Empty().eraseToAnyPublisher() }

                    return self.container.services.userService.updateUserFcmToken(userId: userId, fcmToken: fcmToken)
                        .replaceError(with: ())
                        .eraseToAnyPublisher()
                }
                .sink { _ in
                }
                .store(in: &subscriptions)
            return
        }
    }
}
