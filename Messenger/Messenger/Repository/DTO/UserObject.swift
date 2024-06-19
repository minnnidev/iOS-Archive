//
//  UserObject.swift
//  Messenger
//
//  Created by 김민 on 6/19/24.
//

import Foundation

struct UserObject: Codable {
    var id: String
    var name: String
    var phoneNumber: String?
    var profileURL: String?
    var description: String?
}

extension UserObject {
    func toUser() -> User {
        .init(id: id,
              name: name,
              phoneNumber: phoneNumber,
              profileURL: profileURL,
              description: description)
    }
}
