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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    AuthenticatedView(viewModel: .init())
}
