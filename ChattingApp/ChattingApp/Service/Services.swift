//
//  Services.swift
//  ChattingApp
//
//  Created by 김민 on 6/20/24.
//

import Foundation

protocol ServiceType {
    var authService: AuthServiceType { get set }
}

class Services: ServiceType {
    var authService: AuthServiceType

    init() {
        self.authService = AuthService() 
    }

}

class StubServices: ServiceType {
    var authService: AuthServiceType

    init() {
        self.authService = StubAuthService()
    }
}
