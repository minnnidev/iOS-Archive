//
//  User.swift
//  Messenger
//
//  Created by 김민 on 6/19/24.
//

import Foundation

struct User {
    var id: String
    var name: String
    var phoneNumber: String?
    var profileURL: String?
    var description: String?
}

extension User {
    static var stub1: User {
        .init(id: "user1", name: "밍니")
    }

    static var stub2: User {
        .init(id: "user2", name: "망공")
    }
}

extension User {
    func toObject() -> UserObject {
        .init(id: id,
              name: name,
              phoneNumber: phoneNumber,
              profileURL: profileURL,
              description: description)
    }
}
