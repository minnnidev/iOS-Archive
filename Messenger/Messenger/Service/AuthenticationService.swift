//
//  AuthenticationService.swift
//  Messenger
//
//  Created by 김민 on 6/19/24.
//

import Foundation
import Combine
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import AuthenticationServices

enum AuthenticationError: Error {
    case clientIDError
    case tokenError
    case invalid
}

protocol AuthenticationServiceType {
    func checkAuthenticationState() -> String?
    func signInWithGoogle() -> AnyPublisher<User, ServiceError>
    func handleSignInWithAppleRequest(_ request: ASAuthorizationAppleIDRequest) -> String
    func handleSignInWithAppleCompletion(_ authorization: ASAuthorization, nonce: String) -> AnyPublisher<User, ServiceError>
}

class AuthenticationService: AuthenticationServiceType {
    func checkAuthenticationState() -> String? {
        if let user = Auth.auth().currentUser {
            return user.uid
        } else {
            return nil
        }
    }
    

    func signInWithGoogle() -> AnyPublisher<User, ServiceError> {
        Future { [weak self] promise in
            self?.signInWithGoogle { result in
                switch result {
                case let .success(user):
                    promise(.success(user))
                case let .failure(error):
                    promise(.failure(.error(error)))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    func handleSignInWithAppleRequest(_ request: ASAuthorizationAppleIDRequest) -> String {
        request.requestedScopes = [.fullName, .email]
        let nounce = randomNonceString()
        request.nonce = sha256(nounce)
        
        return nounce
    }

    func handleSignInWithAppleCompletion(_ authorization: ASAuthorization, nonce: String) -> AnyPublisher<User, ServiceError> {
        Future { [weak self] promise in
            self?.handleSignInWithAppleCompletion(authorization, nonce: nonce) { result in
                switch result {
                case let .success(user):
                    promise(.success(user))
                case let .failure(error):
                    promise(.failure(.error(error)))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

extension AuthenticationService {

    private func signInWithGoogle(completion: @escaping (Result<User, Error>) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
           completion(.failure(AuthenticationError.clientIDError))
            return
        }


        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController else {
            return
        }

        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [weak self] result, error in
            if let error {
                completion(.failure(error))
                return
            }

            guard let user = result?.user, let idToken = user.idToken?.tokenString else {
                completion(.failure(AuthenticationError.tokenError))
                return
            }

            let accessToken = user.accessToken.tokenString
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)

            self?.authenticateUserWithFirebase(credential: credential, completion: completion)
        }
    }

    private func authenticateUserWithFirebase(credential: AuthCredential, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(with: credential) { result, error in
            if let error {
                completion(.failure(error))
                return
            }

            guard let result else {
                completion(.failure(AuthenticationError.invalid))
                return
            }

            let firebaseUser = result.user
            let user: User = .init(id: firebaseUser.uid,
                                   name: firebaseUser.displayName ?? "",
                                   phoneNumber: firebaseUser.phoneNumber,
                                   profileURL: firebaseUser.photoURL?.absoluteString)

            completion(.success(user))
        }
    }

    private func handleSignInWithAppleCompletion(_ authorization: ASAuthorization,
                                                 nonce: String,
                                                 completion: @escaping (Result<User, Error>) -> Void) {
        guard let appleIdCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let appleIdToken = appleIdCredential.identityToken else {
            completion(.failure(AuthenticationError.tokenError))
            return
        }

        guard let idTokenString = String(data: appleIdToken, encoding: .utf8) else {
            completion(.failure(AuthenticationError.tokenError))
            return
        }

        let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                  idToken: idTokenString,
                                                  rawNonce: nonce)

        authenticateUserWithFirebase(credential: credential) { result in
            switch result {
            case var .success(user):
                let name = [appleIdCredential.fullName?.givenName, appleIdCredential.fullName?.familyName]
                    .compactMap { $0 }
                    .joined(separator: " ")
                completion(.success(user))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

class StubAuthenticationService: AuthenticationServiceType {
    func checkAuthenticationState() -> String? {
        return nil
    }

    func signInWithGoogle() -> AnyPublisher<User, ServiceError> {
        Empty().eraseToAnyPublisher()
    }

    func handleSignInWithAppleRequest(_ request: ASAuthorizationAppleIDRequest) -> String {
        return ""
    }

    func handleSignInWithAppleCompletion(_ authorization: ASAuthorization, nonce: String) -> AnyPublisher<User, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
}
