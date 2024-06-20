//
//  LoginView.swift
//  ChattingApp
//
//  Created by 김민 on 6/20/24.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.dismiss) var dismiss

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
                // TODO: - Goolge 로그인
            } label: {
                Text("Google로 로그인")
            }
            .buttonStyle(LoginButtonStyle(textColor: .bkText, borderColor: .greyLight))

            Button {
                // TODO: - Apple 로그인
            } label: {
                Text("Apple로 로그인")
            }
            .buttonStyle(LoginButtonStyle(textColor: .bkText, borderColor: .greyLight))

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
    }
}

#Preview {
    LoginView()
}
