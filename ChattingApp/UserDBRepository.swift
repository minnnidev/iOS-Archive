//
//  UserDBRepository.swift
//  ChattingApp
//
//  Created by 김민 on 6/23/24.
//

import Foundation
import Combine
import FirebaseDatabase

protocol UserDBRepositoryType {
    func addUser(_ object: UserObject) -> AnyPublisher<Void, DBError>
    func getUser(userId: String) -> AnyPublisher<UserObject, DBError>
    func getUser(userId: String) async throws -> UserObject
    func updateUser(userId: String, key: String, value: Any) async throws
    func updateUser(userId: String, key: String, value: Any) -> AnyPublisher<Void, DBError>
    func loadUsers() -> AnyPublisher<[UserObject], DBError>
    func addUserAfterContact(_ objects: [UserObject]) -> AnyPublisher<Void, DBError>
    func filterUsers(with queryString: String) -> AnyPublisher<[UserObject], DBError>
}

class UserDBRepository: UserDBRepositoryType {

    var db: DatabaseReference = Database.database().reference()

    func addUser(_ object: UserObject) -> AnyPublisher<Void, DBError> {
        // MARK: object -> data -> dictionary
        Just(object)
            .compactMap { try? JSONEncoder().encode($0) }
            .compactMap { try? JSONSerialization.jsonObject(with: $0, options: .fragmentsAllowed)}
            .flatMap { value in
                Future<Void, Error>  { [weak self] promise in
                    self?.db.child(DBKey.users).child(object.id).setValue(value) { error, _ in
                        if let error {
                            promise(.failure(error))
                        } else {
                            promise(.success(()))
                        }
                    }
                }
            }
            .mapError { DBError.error($0) }
            .eraseToAnyPublisher()
    }

    func getUser(userId: String) -> AnyPublisher<UserObject, DBError> {
        Future<Any?, DBError> { [weak self] promise in
            self?.db.child(DBKey.users).child(userId).getData { error, snapshot in
                if let error {
                    promise(.failure(DBError.error(error)))
                } else if snapshot?.value is NSNull {
                    promise(.success(nil))
                } else {
                    promise(.success(snapshot?.value))
                }
            }
        }
        .flatMap { value in
            if let value {
                return Just(value)
                    .tryMap { try JSONSerialization.data(withJSONObject: $0) }
                    .decode(type: UserObject.self, decoder: JSONDecoder())
                    .mapError { DBError.error($0) }
                    .eraseToAnyPublisher()
            } else {
                return Fail(error: DBError.emptyValue)
                    .eraseToAnyPublisher()
            }
        }
        .eraseToAnyPublisher()
    }

    func getUser(userId: String) async throws -> UserObject {
        guard let value = try await self.db.child(DBKey.users).child(userId).getData().value else {
            throw DBError.emptyValue
        }

        let data = try JSONSerialization.data(withJSONObject: value)
        let userObject = try JSONDecoder().decode(UserObject.self, from: data)
        
        return userObject
    }

    func loadUsers() -> AnyPublisher<[UserObject], DBError> {
        Future<Any?, DBError> { [weak self] promise in
            self?.db.child(DBKey.users).getData { error, snapshot in
                if let error {
                    promise(.failure(DBError.error(error)))
                } else if snapshot?.value is NSNull {
                    promise(.success(nil))
                } else {
                    promise(.success(snapshot?.value))
                }
            }
        }
        .flatMap { value in
            if let dic = value as? [String: [String: Any]] {
                return Just(dic)
                    .tryMap { try JSONSerialization.data(withJSONObject: $0) }
                    .decode(type: [String: UserObject].self, decoder: JSONDecoder())
                    .map { $0.values.map { $0 as UserObject } }
                    .mapError { DBError.error($0) }
                    .eraseToAnyPublisher()
            } else if value == nil {
                return Just([])
                    .setFailureType(to: DBError.self)
                    .eraseToAnyPublisher()
            } else {
                return Fail(error: DBError.invalidatedType)
                    .eraseToAnyPublisher()
            }
        }
        .eraseToAnyPublisher()
    }

    func updateUser(userId: String, key: String, value: Any) async throws {
        try await self.db.child(DBKey.users).child(userId).child(key).setValue(value)
    }

    func updateUser(userId: String, key: String, value: Any) -> AnyPublisher<Void, DBError> {
        Future { [weak self] promise in
            self?.db.child(DBKey.users).child(userId).child(key).setValue(value) { error, _ in
                if let error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            }
        }
        .mapError { DBError.error($0) }
        .eraseToAnyPublisher()
    }

    func addUserAfterContact(_ objects: [UserObject]) -> AnyPublisher<Void, DBError> {
        Publishers.Zip(objects.publisher, objects.publisher)
            .compactMap { origin, converted in
                if let converted = try? JSONEncoder().encode(converted) {
                    return (origin, converted)
                } else {
                    return nil
                }
            }
            .compactMap { origin, converted in
                if let converted = try? JSONSerialization.jsonObject(with: converted, options: .fragmentsAllowed) {
                    return (origin, converted)
                } else {
                    return nil
                }
            }
            .flatMap { origin, converted in
                Future<Void, Error> { [weak self] promise in
                    self?.db.child(DBKey.users).child(origin.id).setValue(converted) { error, _ in
                        if let error {
                            promise(.failure(error))
                        } else {
                            promise(.success(()))
                        }
                    }
                }
            }
            .last()
            .mapError { .error($0) }
            .eraseToAnyPublisher()
    }

    func filterUsers(with queryString: String) -> AnyPublisher<[UserObject], DBError> {
        Future { [weak self] promise in
            self?.db.child(DBKey.users)
                .queryOrdered(byChild: "name")
                .queryStarting(atValue: queryString)
                .queryEnding(atValue: queryString + "\u{f8ff}")
                .observeSingleEvent(of: .value) { snapshot in
                    promise(.success(snapshot.value))
                }
        }
        .flatMap { value in
            if let dic = value as? [String: [String: Any]] {
                return Just(dic)
                    .tryMap { try JSONSerialization.data(withJSONObject: $0) }
                    .decode(type: [String: UserObject].self, decoder: JSONDecoder())
                    .map { $0.values.map { $0 as UserObject } }
                    .mapError { DBError.error($0) }
                    .eraseToAnyPublisher()
            } else if value == nil {
                return Just([])
                    .setFailureType(to: DBError.self)
                    .eraseToAnyPublisher()
            } else {
                return Fail(error: DBError.invalidatedType)
                    .eraseToAnyPublisher()
            }
        }
        .eraseToAnyPublisher()
    }
}
