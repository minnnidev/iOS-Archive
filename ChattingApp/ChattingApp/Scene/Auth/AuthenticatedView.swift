//
//  AuthenticatedView.swift
//  ChattingApp
//
//  Created by 김민 on 6/19/24.
//

import SwiftUI

struct AuthenticatedView: View {
    @StateObject var authViewModel: AuthenticationViewModel

    var body: some View {
        switch authViewModel.authenticationState {
        case .unauthenticated:
            LoginIntroView()
                .environmentObject(authViewModel)
        case .authenticated:
            MainTabView()
        }
    }
}

#Preview {
    AuthenticatedView(authViewModel: AuthenticationViewModel(container: .init(services: StubServices())))
}
