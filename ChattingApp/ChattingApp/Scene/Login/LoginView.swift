//
//  LoginView.swift
//  ChattingApp
//
//  Created by 김민 on 6/20/24.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthenticationViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("로그인")
                    .font(.system(size: 28, weight: .bold))
                    .padding(.top, 80)
                    .padding(.bottom, 18)
                Text("아래 제공되는 서비스로 로그인을 해주세요.")
                    .font(.system(size: 14))
            }
            .padding(.leading, 30)

            Spacer()

            Button {
                viewModel.send(action: .googleLogin)
            } label: {
                Text("Google로 로그인")
            }
            .buttonStyle(LoginButtonStyle(textColor: .bkText, borderColor: .greyLight))

            SignInWithAppleButton { request in
                viewModel.send(action: .appleLogin(request))
            } onCompletion: { result in
                viewModel.send(action: .appleLoginCompletion(result))
            }
            .frame(maxWidth: .infinity, maxHeight: 40)
            .cornerRadius(5)
            .padding(.horizontal, 15)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image("back")
                }
            }
        }
        .overlay {
            if viewModel.isLoading {
                ProgressView()
            }
        }
    }
}

#Preview {
    LoginView()
}
