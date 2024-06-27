//
//  UploadService.swift
//  ChattingApp
//
//  Created by 김민 on 6/26/24.
//

import Foundation
import Combine

protocol UploadServiceType {
    func uploadImage(source: UploadSourceType, data: Data) async throws -> URL
    func uploadImage(source: UploadSourceType, data: Data) -> AnyPublisher<URL, ServiceError>
}

class UploadService: UploadServiceType {

    private let provider: UploadProviderType

    init(provider: UploadProviderType) {
        self.provider = provider
    }

    func uploadImage(source: UploadSourceType, data: Data) async throws -> URL {
        let url = try await provider.upload(path: source.path, data: data, filename: UUID().uuidString)
        return url
    }

    func uploadImage(source: UploadSourceType, data: Data) -> AnyPublisher<URL, ServiceError> {
        provider.upload(path: source.path, data: data, filename: UUID().uuidString)
            .mapError { .error($0) }
            .eraseToAnyPublisher()
    }
}

class StubUploadService: UploadServiceType {

    func uploadImage(source: UploadSourceType, data: Data) async throws -> URL {
        return URL(string: "")!
    }

    func uploadImage(source: UploadSourceType, data: Data) -> AnyPublisher<URL, ServiceError> {
        Empty()
            .eraseToAnyPublisher()
    }
}
