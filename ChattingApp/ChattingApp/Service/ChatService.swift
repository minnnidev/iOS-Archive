//
//  ChatService.swift
//  ChattingApp
//
//  Created by 김민 on 6/27/24.
//

import Foundation
import Combine

protocol ChatServiceType {
    func addChat(_ chat: Chat, to chatRoomId: String) -> AnyPublisher<Chat, ServiceError>
    func observeChat(chatRoomId: String) -> AnyPublisher<Chat?, Never>
}

class ChatService: ChatServiceType {

    private let dBRepository: ChatDBRepositoryType

    init(dBRepository: ChatDBRepositoryType) {
        self.dBRepository = dBRepository
    }

    func addChat(_ chat: Chat, to chatRoomId: String) -> AnyPublisher<Chat, ServiceError> {
        var chat = chat
        chat.chatId = dBRepository.childByAutoId(chatRoomId: chatRoomId)
        
        return dBRepository.addChat(chat.toObject(), to: chatRoomId)
            .map { chat }
            .mapError { ServiceError.error($0) }
            .eraseToAnyPublisher()
    }

    func observeChat(chatRoomId: String) -> AnyPublisher<Chat?, Never> {
        dBRepository.observeChat(chatRoomId: chatRoomId)
            .map { $0?.toChat() }
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }
}

class StubChatService: ChatServiceType {

    func addChat(_ chat: Chat, to chatRoomId: String) -> AnyPublisher<Chat, ServiceError> {
        Empty().eraseToAnyPublisher()
    }

    func observeChat(chatRoomId: String) -> AnyPublisher<Chat?, Never> {
        Empty().eraseToAnyPublisher()
    }
}
