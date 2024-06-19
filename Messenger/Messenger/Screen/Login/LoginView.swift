//
//  LoginView.swift
//  Messenger
//
//  Created by 김민 on 6/19/24.
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

            } label: {
                Text("Google로 로그인")
            }
            .buttonStyle(LoginButtonStyle(textColor: .black, borderColor: .gray))

            Button {

            } label: {
                Text("Apple로 로그인")
            }
            .buttonStyle(LoginButtonStyle(textColor: .black, borderColor: .gray))
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
