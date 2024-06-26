//
//  HomeViewModel.swift
//  ChattingApp
//
//  Created by 김민 on 6/23/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {

    enum Action {
        case load
        case presentMyProfileView
        case presentOtherProfileView(String)
        case requestContacts
        case goToChat(User)
    }

    @Published var myUser: User?
    @Published var users: [User] = []
    @Published var phase: Phase = .notRequested
    @Published var modalDestination: HomeModalDestination?

    var userId: String
    
    private var container: DIContainer
    private var navigationRouter: NavigationRouter
    private var subscriptions = Set<AnyCancellable>()

    init(container: DIContainer, navigationRouter: NavigationRouter, userId: String) {
        self.container = container
        self.navigationRouter = navigationRouter
        self.userId = userId
    }

    func send(_ action: Action) {
        switch action {
        case .load:
            phase = .loading
            container.services.userService.getUser(userId: userId)
                .handleEvents(receiveOutput: { [weak self] user in
                    self?.myUser = user
                })
                .flatMap { user in
                    self.container.services.userService.loadUsers(userId: user.id)
                }
                .sink { [weak self] completion in
                    if case .failure = completion {
                        self?.phase = .failed
                    }
                } receiveValue: { [weak self] users in
                    self?.phase = .successed
                    self?.users = users
                }
                .store(in: &subscriptions)

        case .presentMyProfileView:
            modalDestination = .myProfile

        case let .presentOtherProfileView(otherUserId):
            modalDestination = .otherProfile(otherUserId)

        case .requestContacts:
            container.services.contactService.fetchContacts()
                .flatMap { users in
                    self.container.services.userService.addUserAfterContact(users: users)
                }
                .flatMap { _ in
                    self.container.services.userService.loadUsers(userId: self.userId)
                }
                .sink { [weak self] completion in
                    if case .failure = completion {
                        self?.phase = .failed
                    }
                } receiveValue: { [weak self] users in
                    self?.phase = .successed
                    self?.users = users
                }
                .store(in: &subscriptions)
        case let .goToChat(otherUser):
            container.services.chatRoomService.createChatRoomIfNeeded(
                myUserId: userId,
                otherUserId: otherUser.id,
                otherUserName: otherUser.name
            )
            .sink { completion in
                // TODO:
            } receiveValue: { [weak self] chatRoom in
                // TODO: - 채팅 뷰로 navigation
                self?.navigationRouter.push(to: .chat)
            }
            .store(in: &subscriptions)
        }
    }
}
