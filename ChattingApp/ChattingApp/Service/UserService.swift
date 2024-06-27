//
//  UserService.swift
//  ChattingApp
//
//  Created by 김민 on 6/23/24.
//

import Foundation
import Combine

protocol UserServiceType {
    func addUser(_ user: User) -> AnyPublisher<User, ServiceError>
    func getUser(userId: String) -> AnyPublisher<User, ServiceError>
    func getUser(userId: String) async throws -> User
    func updateUserDescription(userId: String, description: String) async throws
    func updateUserProfile(userId: String, urlString: String) async throws
    func updateUserFcmToken(userId: String, fcmToken: String) -> AnyPublisher<Void, ServiceError>
    func loadUsers(userId: String) -> AnyPublisher<[User], ServiceError>
    func addUserAfterContact(users: [User]) -> AnyPublisher<Void, ServiceError>
    func filterUsers(with queryString: String, userId: String) -> AnyPublisher<[User], ServiceError>
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

    func getUser(userId: String) async throws -> User {
        let userObject = try await dbRepository.getUser(userId: userId)
        return userObject.toUser()
    }

    func loadUsers(userId: String) -> AnyPublisher<[User], ServiceError> {
        dbRepository.loadUsers()
            .map {
                $0.map { $0.toUser() }
                    .filter { $0.id != userId }
            }
            .mapError { .error($0) }
            .eraseToAnyPublisher()
    }

    func updateUserDescription(userId: String, description: String) async throws {
        try await dbRepository.updateUser(userId: userId, key: "description", value: description)
    }

    func updateUserProfile(userId: String, urlString: String) async throws {
        try await dbRepository.updateUser(userId: userId, key: "imageURL", value: urlString)
    }

    func updateUserFcmToken(userId: String, fcmToken: String) -> AnyPublisher<Void, ServiceError> {
        dbRepository.updateUser(userId: userId, 
                                key: "fcmToken",
                                value: fcmToken)
            .mapError { .error($0) }
            .eraseToAnyPublisher()
    }

    func addUserAfterContact(users: [User]) -> AnyPublisher<Void, ServiceError> {
        dbRepository.addUserAfterContact(users.map { $0.toObject() })
            .mapError { .error($0) }
            .eraseToAnyPublisher()
    }

    func filterUsers(with queryString: String, userId: String) -> AnyPublisher<[User], ServiceError> {
        dbRepository.filterUsers(with: queryString)
            .map { $0.map { $0.toUser() }.filter { $0.id != userId } }
            .mapError { .error($0) }
            .eraseToAnyPublisher()
    }
}

class StubUserService: UserServiceType {

    func addUser(_ user: User) -> AnyPublisher<User, ServiceError> {
        Empty().eraseToAnyPublisher()
    }

    func getUser(userId: String) -> AnyPublisher<User, ServiceError> {
        Just(User.stub1)
            .setFailureType(to: ServiceError.self)
            .eraseToAnyPublisher()
    }

    func getUser(userId: String) async throws -> User {
        return .stub1
    }

    func loadUsers(userId: String) -> AnyPublisher<[User], ServiceError> {
        Just([User.stub1, User.stub2])
            .setFailureType(to: ServiceError.self)
            .eraseToAnyPublisher()
    }

    func updateUserDescription(userId: String, description: String) async throws {

    }

    func updateUserProfile(userId: String, urlString: String) async throws {
        
    }

    func updateUserFcmToken(userId: String, fcmToken: String) -> AnyPublisher<Void, ServiceError> {
        Empty()
            .eraseToAnyPublisher()
    }

    func addUserAfterContact(users: [User]) -> AnyPublisher<Void, ServiceError> {
        Empty().eraseToAnyPublisher()
    }

    func filterUsers(with queryString: String, userId: String) -> AnyPublisher<[User], ServiceError> {
        Just([User.stub1, User.stub2])
            .setFailureType(to: ServiceError.self)
            .eraseToAnyPublisher()
    }
}
