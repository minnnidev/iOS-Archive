//
//  AuthenticatedView.swift
//  ChattingApp
//
//  Created by 김민 on 6/19/24.
//

import SwiftUI

struct AuthenticatedView: View {
    @StateObject var viewModel: AuthenticationViewModel

    var body: some View {
        switch viewModel.authenticationState {
        case .unauthenticated:
            LoginIntroView()
        case .authenticated:
            MainTabView()
        }
    }
}

#Preview {
    AuthenticatedView(viewModel: AuthenticationViewModel(container: .init(services: StubServices())))
}
