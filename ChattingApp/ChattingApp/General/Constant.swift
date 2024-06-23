//
//  Constant.swift
//  ChattingApp
//
//  Created by 김민 on 6/23/24.
//

import Foundation

typealias DBKey = Constant.DBKey

enum Constant { }

extension Constant {

    struct DBKey {
        static let users = "Users"
        static let chatRooms = "ChatRooms"
        static let chats = "Chats"
    }
}
