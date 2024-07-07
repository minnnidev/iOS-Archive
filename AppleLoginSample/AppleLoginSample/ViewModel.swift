//
//  ViewModel.swift
//  AppleLoginSample
//
//  Created by 김민 on 7/5/24.
//

import Foundation
import AuthenticationServices

class ViewModel: ObservableObject {

    enum Action {
        case appleLogin(ASAuthorizationAppleIDRequest)
        case appleLoginHandler(Result<ASAuthorization, Error>)
    }

    func send(action: Action) {
        switch action {
        case let .appleLogin(request):
            // MARK: 필요한 정보 요청
            request.requestedScopes = [.fullName]

        case let .appleLoginHandler(result):
            switch result {
                // MARK: - 로그인 성공 시 ASAuthorizationAppleIDCredential 객체 추출
            case let .success(authorization):
                guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
                print(credential.email) // nil
                print(credential.fullName)
                // identityToken, authorizationCode 등등...

                // TODO: credential에서 필요한 정보를 사용하여 서비스 서버로 요청
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
