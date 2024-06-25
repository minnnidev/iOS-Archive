//
//  MyProfileViewModel.swift
//  ChattingApp
//
//  Created by 김민 on 6/25/24.
//

import Foundation

@MainActor
class MyProfileViewModel: ObservableObject {

    @Published var userInfo: User?
    @Published var isPresentedDescriptionEditView: Bool = false

    private let userId: String
    private var container: DIContainer

    init(container: DIContainer, userId: String) {
        self.container = container
        self.userId = userId
    }

    func getUser() async {
        if let user = try? await container.services.userService.getUser(userId: userId) {
            userInfo = user
        }
    }

    func updateDescription(description: String) async {
        do {
            try await container.services.userService.updateUserDescription(userId: userId, description: description)
            userInfo?.description = description
        } catch {

        }
    }
}
