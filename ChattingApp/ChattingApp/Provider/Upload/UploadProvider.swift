//
//  UploadProvider.swift
//  ChattingApp
//
//  Created by 김민 on 6/26/24.
//

import Foundation
import FirebaseStorage

protocol UploadProviderType {
    func upload(path: String, data: Data, filename: String) async throws -> URL
}

class UploadProvider: UploadProviderType {
    let storageRef = Storage.storage().reference()

    func upload(path: String, data: Data, filename: String) async throws -> URL {
        let ref = storageRef.child(path).child(filename)
        let _ = try await ref.putDataAsync(data)
        let url = try await ref.downloadURL()

        return url
    }
}
