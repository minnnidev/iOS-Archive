//
//  MyProfileViewModel.swift
//  ChattingApp
//
//  Created by 김민 on 6/25/24.
//

import Foundation
import SwiftUI
import PhotosUI

@MainActor
class MyProfileViewModel: ObservableObject {

    @Published var userInfo: User?
    @Published var isPresentedDescriptionEditView: Bool = false
    @Published var imageSelection: PhotosPickerItem? {
        didSet {
            Task {
                await updateProfileImage(pickerItem: imageSelection)
            }
        }
    }

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
            print(error.localizedDescription)
        }
    }

    func updateProfileImage(pickerItem: PhotosPickerItem?) async {
        guard let pickerItem else { return }

        do {
            let data = try await container.services.photoPickerService.loadTransferable(from: pickerItem)

            // MARK: storage upload
            let url = try await container.services.uploadService.uploadImage(source: .profile(userId: userId), data: data)

            // MARK:  DB update
            try await container.services.userService.updateUserProfile(userId: userId, urlString: url.absoluteString)

            userInfo?.imageURL = url.absoluteString
        } catch {
            print(error.localizedDescription)
        }
    }
}
