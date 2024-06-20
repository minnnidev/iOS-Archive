//
//  AuthenticationViewModel.swift
//  ChattingApp
//
//  Created by 김민 on 6/20/24.
//

import Foundation

enum AuthenticationState {
    case unauthenticated
    case authenticated
}

class AuthenticationViewModel: ObservableObject {

    @Published var authenticationState: AuthenticationState = .unauthenticated

    private var container: DIContainer

    init(container: DIContainer) {
        self.container = container
    }
}
