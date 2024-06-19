//
//  Service.swift
//  Messenger
//
//  Created by 김민 on 6/19/24.
//

import Foundation

protocol ServiceType {
    var authService: AuthenticationServiceType { get set }
}

class Service: ServiceType {
    var authService: AuthenticationServiceType

    init() {
        self.authService = AuthenticationService()
    }
}

class StubService: ServiceType {
    var authService: AuthenticationServiceType = StubAuthenticationService()
}
