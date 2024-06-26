//
//  ChatRoom.swift
//  ChattingApp
//
//  Created by 김민 on 6/26/24.
//

import Foundation

struct ChatRoom: Codable {
    var chatRoomId: String
    var lastMessage: String?
    var otherUserName: String
    var otherUserId: String
}

extension ChatRoom {

    func toObject() -> ChatRoomObject {
        .init(
            chatRoomId: chatRoomId,
            lastMessage: lastMessage,
            otherUserName: otherUserName,
            otherUserId: otherUserId
        )
    }
}
