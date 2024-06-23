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
    }

    @Published var myUser: User?
    @Published var users: [User] = []

    private var userId: String
    private var container: DIContainer
    private var subscriptions = Set<AnyCancellable>()

    init(container: DIContainer, userId: String) {
        self.container = container
        self.userId = userId
    }

    func send(_ action: Action) {
        switch action {
        case .load:
            container.services.userService.getUser(userId: userId)
                .handleEvents(receiveOutput: { [weak self] user in
                    self?.myUser = user
                })
                .flatMap { user in
                    self.container.services.userService.loadUsers(userId: user.id)
                }
                .sink { completion in
                    // TODO:
                } receiveValue: { [weak self] users in
                    self?.users = users
                }
                .store(in: &subscriptions)
        }
    }
}
