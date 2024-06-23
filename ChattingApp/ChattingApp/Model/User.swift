//
//  User.swift
//  ChattingApp
//
//  Created by 김민 on 6/20/24.
//

import Foundation

struct User {
    var id: String
    var name: String
    var phoneNumber: String?
    var imageURL: String?
    var description: String?
}

extension User {
    static var stub1: User {
        .init(id: "user1_id", name: "user1")
    }

    static var stub2: User {
        .init(id: "user2_id", name: "user2")
    }
}
