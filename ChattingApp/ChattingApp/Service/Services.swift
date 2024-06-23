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
    var contactService: ContactServiceType { get set }
}

class Services: ServiceType {
    var authService: AuthServiceType
    var userService: UserServiceType
    var contactService: ContactServiceType

    init() {
        self.authService = AuthService() 
        self.userService = UserService(dbRepository: UserDBRepository())
        self.contactService = ContactService()
    }

}

class StubServices: ServiceType {
    var authService: AuthServiceType = StubAuthService()
    var userService: UserServiceType = StubUserService()
    var contactService: ContactServiceType = ContactService()
}
