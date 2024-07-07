//
//  ContentView.swift
//  AppleLoginSample
//
//  Created by 김민 on 7/5/24.
//

import SwiftUI
import AuthenticationServices

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        VStack {
            SignInWithAppleButton { request in
                viewModel.send(action: .appleLogin(request))
            } onCompletion: { result in
                viewModel.send(action: .appleLoginHandler(result))
            }
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .padding(.horizontal, 30)

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
