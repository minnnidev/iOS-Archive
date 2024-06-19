//
//  AuthenticatedViewModel.swift
//  Messenger
//
//  Created by 김민 on 6/19/24.
//

import Foundation

enum AuthenticationState {
    case unauthenticated
    case authenticated
}

class AuthenticatedViewModel: ObservableObject {
    @Published var authenticationState: AuthenticationState = .unauthenticated
    
    private var container: DIContainer

    init(container: DIContainer) {
        self.container = container
    }
}
