//
//  ChattingAppApp.swift
//  ChattingApp
//
//  Created by 김민 on 6/19/24.
//

import SwiftUI

@main
struct ChattingAppApp: App {
    @StateObject private var container: DIContainer = .init(services: Services())

    var body: some Scene {
        WindowGroup {
            AuthenticatedView(viewModel: .init())
                .environmentObject(container)
        }
    }
}
