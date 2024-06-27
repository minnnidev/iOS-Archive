//
//  User.swift
//  ChattingApp
//
//  Created by 김민 on 6/20/24.
//

import Foundation

struct User: Identifiable {
    var id: String
    var name: String
    var phoneNumber: String?
    var imageURL: String?
    var description: String?
    var fcmToken: String?
}

extension User {
    static var stub1: User {
        .init(id: "user1_id", name: "user1")
    }

    static var stub2: User {
        .init(id: "user2_id", name: "user2")
    }
}

extension User {

    func toObject() -> UserObject {
        .init(
            id: id,
            name: name,
            phoneNumber: phoneNumber,
            imageURL: imageURL,
            description: description,
            fcmToken: fcmToken
        )
    }
}
