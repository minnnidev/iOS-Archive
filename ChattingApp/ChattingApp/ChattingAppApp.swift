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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            AuthenticatedView(
                authViewModel: .init(container: container), 
                navigationRouter: .init(), 
                searchDataController: .init()
            )
            .environmentObject(container)
        }
    }
}
