//
//  ChatRoomObject.swift
//  ChattingApp
//
//  Created by 김민 on 6/26/24.
//

import Foundation

struct ChatRoomObject: Codable {
    var chatRoomId: String
    var lastMessage: String?
    var otherUserName: String
    var otherUserId: String
}

extension ChatRoomObject {

    func toChatRoom() -> ChatRoom {
        .init(
            chatRoomId: chatRoomId,
            lastMessage: lastMessage,
            otherUserName: otherUserName,
            otherUserId: otherUserId
        )
    }
}

extension ChatRoomObject {

    static var stub1: ChatRoomObject {
        .init(
            chatRoomId: "chatRoom1_id",
              otherUserName: "user2",
              otherUserId: "user2_id"
        )
    }
}
