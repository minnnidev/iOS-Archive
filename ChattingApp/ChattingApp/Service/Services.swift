//
//  Services.swift
//  ChattingApp
//
//  Created by 김민 on 6/20/24.
//

import Foundation

protocol ServiceType {
    var authService: AuthServiceType { get set }
    var userService: UserServiceType { get set }
}

class Services: ServiceType {
    var authService: AuthServiceType
    var userService: UserServiceType

    init() {
        self.authService = AuthService() 
        self.userService = UserService(dbRepository: UserDBRepository())
    }

}

class StubServices: ServiceType {
    var authService: AuthServiceType
    var userService: UserServiceType

    init() {
        self.authService = StubAuthService()
        self.userService = UserService(dbRepository: UserDBRepository())
    }
}
