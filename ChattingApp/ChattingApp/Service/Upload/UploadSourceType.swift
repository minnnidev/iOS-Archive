//
//  UploadSourceType.swift
//  ChattingApp
//
//  Created by 김민 on 6/26/24.
//

import Foundation

enum UploadSourceType {
    case chat(chatRoomId: String)
    case profile(userId: String)

    var path: String {
        switch self {
        case let .chat(chatRoomId): // Chats/chatRoomId
            return "\(DBKey.chats)/\(chatRoomId)"
        case let .profile(userId): // Users/UserId
            return "\(DBKey.users)/\(userId)"
        }
    }
}
