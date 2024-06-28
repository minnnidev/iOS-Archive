//
//  AuthenticatedView.swift
//  ChattingApp
//
//  Created by 김민 on 6/19/24.
//

import SwiftUI

struct AuthenticatedView: View {
    @StateObject var authViewModel: AuthenticationViewModel
    @StateObject var navigationRouter: NavigationRouter
    @StateObject var searchDataController: SearchDataController
    @StateObject var appearanceController: AppearanceController

    var body: some View {
        Group {
            switch authViewModel.authenticationState {
            case .unauthenticated:
                LoginIntroView()
                    .environmentObject(authViewModel)
            case .authenticated:
                MainTabView()
                    .environment(\.managedObjectContext, searchDataController.persistantContainer.viewContext)
                    .environmentObject(authViewModel)
                    .environmentObject(navigationRouter)
                    .environmentObject(appearanceController)
                    .onAppear {
                        authViewModel.send(action: .requestPushNotification)
                    }
            }
        }
        .onAppear {
            authViewModel.send(action: .checkAuthenticationState)
        }
        .preferredColorScheme(appearanceController.appearance.colorScheme)
    }
}

#Preview {
    AuthenticatedView(authViewModel: AuthenticationViewModel(
        container: .init(services: StubServices())),
                      navigationRouter: .init(),
                      searchDataController: .init(), 
                      appearanceController: .init(.init(0))
    )
}
