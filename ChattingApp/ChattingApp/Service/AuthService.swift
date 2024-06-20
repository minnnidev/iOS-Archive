//
//  AuthService.swift
//  ChattingApp
//
//  Created by 김민 on 6/20/24.
//

import Foundation
import Combine
import GoogleSignIn
import FirebaseCore
import FirebaseAuth

enum AuthError: Error {
    case cliendIDError
    case tokenError
    case invalidated
}

protocol AuthServiceType {
    func signInWithGoogle() -> AnyPublisher<User, ServiceError>
}

class AuthService: AuthServiceType {
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
}

extension AuthService {

    private func signInWithGoogle(completion: @escaping (Result<User, Error>) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            completion(.failure(AuthError.cliendIDError))
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
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let user = result?.user, let idToken = user.idToken?.tokenString else {
                completion(.failure(AuthError.tokenError))
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)


            self?.authenticateWithFirebase(credential: credential, completion: completion)
        }
    }

    private func authenticateWithFirebase(credential: AuthCredential, completion: @escaping (Result<User,Error>) -> Void) {
        Auth.auth().signIn(with: credential) { result, error in
            if let error {
                completion(.failure(error))
            }

            guard let result = result else {
                completion(.failure(AuthError.invalidated))
                return
            }

            let firebaseUser = result.user
            let user: User = .init(id: firebaseUser.uid,
                                   name: firebaseUser.displayName ?? "",
                                   phoneNumber: firebaseUser.phoneNumber,
                                   imageURL: firebaseUser.photoURL?.absoluteString)

            completion(.success(user))
        }
    }
}

class StubAuthService: AuthServiceType {
    func signInWithGoogle() -> AnyPublisher<User, ServiceError> {
        return Empty().eraseToAnyPublisher()
    }
}
