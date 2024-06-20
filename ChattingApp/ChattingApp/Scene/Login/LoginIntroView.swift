//
//  LoginIntroView.swift
//  ChattingApp
//
//  Created by 김민 on 6/20/24.
//

import SwiftUI

struct LoginIntroView: View {
    @State private var isPresentedLoginView: Bool = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()

                Text("환영합니다.")
                    .font(.system(size: 26, weight: .bold))

                Text("무료 메세지와 영상통화, 음성 통화를 부담없이 즐겨보세요!")
                    .font(.system(size: 12))
                    .foregroundStyle(Color.greyDeep)

                Spacer()

                Button {
                    isPresentedLoginView.toggle()
                } label: {
                    Text("로그인")
                }
                .buttonStyle(LoginButtonStyle(textColor: Color.green))
            }
            .navigationDestination(isPresented: $isPresentedLoginView) {
                LoginView()
                    .navigationBarBackButtonHidden()
            }
        }
    }
}

#Preview {
    LoginIntroView()
}
