//
//  UserObject.swift
//  ChattingApp
//
//  Created by 김민 on 6/23/24.
//

import Foundation

struct UserObject: Codable {
    var id: String
    var name: String
    var phoneNumber: String?
    var imageURL: String?
    var description: String?
    var fcmToken: String?
}

extension UserObject {

    func toUser() -> User {
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
