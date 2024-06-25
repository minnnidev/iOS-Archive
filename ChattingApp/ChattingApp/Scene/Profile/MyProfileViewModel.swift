//
//  MyProfileViewModel.swift
//  ChattingApp
//
//  Created by 김민 on 6/25/24.
//

import Foundation

class MyProfileViewModel: ObservableObject {

    @Published var userInfo: User?

    private let userId: String
    private var container: DIContainer

    init(container: DIContainer, userId: String) {
        self.container = container
        self.userId = userId
    }
}
