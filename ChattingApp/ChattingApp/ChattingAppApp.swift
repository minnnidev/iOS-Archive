//
//  ChattingAppApp.swift
//  ChattingApp
//
//  Created by 김민 on 6/19/24.
//

import SwiftUI
import FirebaseCore

@main
struct ChattingAppApp: App {
    @StateObject private var container: DIContainer = .init(services: Services())
    @AppStorage(AppStorageType.appearance) var appearanceValue: Int = UserDefaults.standard.integer(forKey: AppStorageType.appearance)
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            AuthenticatedView(
                authViewModel: .init(container: container)
            )
            .environmentObject(container)
            .onAppear {
                container.appearanceController.changeAppearance(AppearanceType(rawValue: appearanceValue))
            }
        }
    }
}
