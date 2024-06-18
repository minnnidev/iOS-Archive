//
//  MessengerApp.swift
//  Messenger
//
//  Created by 김민 on 6/19/24.
//

import SwiftUI

@main
struct MessengerApp: App {
    @StateObject var container: DIContainer = .init(services: Service())

    var body: some Scene {
        WindowGroup {
            AuthenticatedView(authViewModel: .init())
                .environmentObject(container)
        }
    }
}
