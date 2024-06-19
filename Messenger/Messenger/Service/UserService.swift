//
//  UserService.swift
//  Messenger
//
//  Created by 김민 on 6/19/24.
//

import Foundation
import Combine

protocol UserServiceType {
    func addUser(_ user: User) -> AnyPublisher<User, ServiceError> // service layer: User 모델 사용
    func getUser(userId: String) -> AnyPublisher<User, ServiceError>
}

class UserService: UserServiceType {

    private var dbRepository: UserDBRepositoryType

    init(dbRepository: UserDBRepositoryType) {
        self.dbRepository = dbRepository
    }

    func addUser(_ user: User) -> AnyPublisher<User, ServiceError> {
        dbRepository.addUser(user.toObject())
            .map { user }
            .mapError { .error($0) }
            .eraseToAnyPublisher()
    }

    func getUser(userId: String) -> AnyPublisher<User, ServiceError> {
        dbRepository.getUser(userId: userId)
            .map { $0.toUser() }
            .mapError { .error($0) }
            .eraseToAnyPublisher()
    }
}

class StubUserService: UserServiceType {

    func addUser(_ user: User) -> AnyPublisher<User, ServiceError> {
        Empty().eraseToAnyPublisher()
    }

    func getUser(userId: String) -> AnyPublisher<User, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
}
