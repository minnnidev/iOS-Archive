//
//  SearchViewModel.swift
//  ChattingApp
//
//  Created by 김민 on 6/28/24.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {

    enum Action {
        case requestQuery(String)
        case clearSearchedResult
        case clearSearchText
    }

    @Published var shouldBecomeFirstResponder: Bool = false
    @Published var searchText: String = ""
    @Published var searchedUsersResult: [User] = []

    private let userId: String
    private var container: DIContainer
    private var subscriptions = Set<AnyCancellable>()

    init(userId: String, container: DIContainer) {
        self.userId = userId
        self.container = container

        bind()
    }

    func bind() {
        $searchText
            .removeDuplicates()
            .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                if text.isEmpty {
                    self?.send(action: .clearSearchedResult)
                } else {
                    self?.send(action: .requestQuery(text))
                }
            }
            .store(in: &subscriptions)
    }

    func send(action: Action) {
        switch action {
        case let .requestQuery(query):
            container.services.userService.filterUsers(with: query, userId: userId)
                .sink { completion in

                } receiveValue: { [weak self] users in
                    self?.searchedUsersResult = users
                }
                .store(in: &subscriptions)

        case .clearSearchedResult:
            searchedUsersResult = []

        case .clearSearchText:
            searchText = ""
            shouldBecomeFirstResponder = false
        }
    }
}
