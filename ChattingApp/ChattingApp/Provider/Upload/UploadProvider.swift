//
//  UploadProvider.swift
//  ChattingApp
//
//  Created by 김민 on 6/26/24.
//

import Foundation
import Combine
import FirebaseStorage
import FirebaseStorageCombineSwift

enum UploadError: Error {
    case error(Error)
}


protocol UploadProviderType {
    func upload(path: String, data: Data, filename: String) async throws -> URL
    func upload(path: String, data: Data, filename: String) -> AnyPublisher<URL, UploadError>
}

class UploadProvider: UploadProviderType {

    let storageRef = Storage.storage().reference()

    func upload(path: String, data: Data, filename: String) async throws -> URL {
        let ref = storageRef.child(path).child(filename)
        let _ = try await ref.putDataAsync(data)
        let url = try await ref.downloadURL()

        return url
    }

    func upload(path: String, data: Data, filename: String) -> AnyPublisher<URL, UploadError> {
        let ref = storageRef.child(path).child(filename)

        return ref.putData(data)
            .flatMap { _ in
                ref.downloadURL()
            }
            .mapError { .error($0) }
            .eraseToAnyPublisher()
    }
}
