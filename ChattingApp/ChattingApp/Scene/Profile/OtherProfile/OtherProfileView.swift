//
//  OtherProfileView.swift
//  ChattingApp
//
//  Created by 김민 on 6/23/24.
//

import SwiftUI

struct OtherProfileView: View {
    @Environment(\.dismiss) var dismiss

    @StateObject var viewModel: OtherProfileViewModel

    var goToChat: (User) -> Void

    var body: some View {
        NavigationStack {
            ZStack {
                Image("profile_bg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea(edges: .vertical)

                VStack(spacing: 0) {
                    Spacer()

                    profileView
                        .padding(.bottom, 16)

                    nameView
                        .padding(.bottom, 26)

                    Spacer()

                    menuView
                        .padding(.bottom, 58)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image("close")
                    }
                }
            }
            .task {
                await viewModel.getUser()
            }
        }
    }

    private var profileView: some View {
        URLImageView(urlString: viewModel.userInfo?.imageURL)
            .frame(width: 80, height: 80)
            .clipShape(Circle())
    }

    private var nameView: some View {
        Text(viewModel.userInfo?.name ?? "이름")
            .font(.system(size: 24, weight: .bold))
            .foregroundStyle(Color.bgWh)
    }

    private var menuView: some View {
        HStack(alignment: .top, spacing: 27) {
            ForEach(OtherProfileMenuType.allCases, id: \.self) { menu in
                Button {
                    if menu == .chat, let userInfo = viewModel.userInfo {
                        dismiss()
                        goToChat(userInfo)
                    }
                } label: {
                    VStack(alignment: .center) {
                        Image(menu.imageName)
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text(menu.description)
                            .font(.system(size: 10))
                            .foregroundColor(.whiteFix)
                    }
                }
            }
        }
    }
}

#Preview {
    OtherProfileView(viewModel: .init(container: DIContainer(services: StubServices()), userId: "user2_id")) { _ in

    }
}
