//
//  ChatListViewModel.swift
//  ChattingApp
//
//  Created by 김민 on 6/26/24.
//

import Foundation
import Combine

class ChatListViewModel: ObservableObject {

    @Published var chatRooms: [ChatRoom] = []

    enum Action {
        case load
    }

    let userId: String

    private var container: DIContainer
    private var subscriptions = Set<AnyCancellable>()

    init(container: DIContainer, userId: String) {
        self.container = container
        self.userId = userId
    }

    func send(action: Action) {
        switch action {
        case .load:
            container.services.chatRoomService.loadChatRooms(myUserId: userId)
                .sink { completion in

                } receiveValue: { [weak self] chatrooms in
                    self?.chatRooms = chatrooms
                }
                .store(in: &subscriptions)

        }
    }
}
