//
//  HomeView.swift
//  Messenger
//
//  Created by 김민 on 6/19/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                profileView
                    .padding(.bottom, 30)
                searchButton
                    .padding(.bottom, 24)

                HStack {
                    Text("친구")
                        .font(.system(size: 14, weight: .semibold))
                    Spacer()
                }
                .padding(.horizontal, 30)

                if viewModel.users.isEmpty {
                    Spacer(minLength: 89)
                    emptyView
                } else {
                    ForEach(viewModel.users, id: \.id) { user in
                        HStack {
                            Image("person")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                            Text(user.name)
                                .font(.system(size: 12, weight: .bold))
                            Spacer()
                        }
                        .padding(.horizontal, 30)
                    }
                }
            }
            .toolbar {
                Button {
                    // TODO: setting action
                } label: {
                    Image("settings")
                }
            }
            .onAppear {
                viewModel.send(action: .getUser)
            }
        }
    }

    private var profileView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 7) {
                Text(viewModel.myUser?.name ?? "이름")
                    .font(.system(size: 22, weight: .bold))
                Text(viewModel.myUser?.description ?? "흠냐흠냐")
                    .font(.system(size: 12))
            }
            Spacer()

            Image("person")
                .resizable()
                .frame(width: 52, height: 52)
                .clipShape(Circle())
        }
        .padding(.horizontal, 30)
    }

    private var searchButton: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.clear)
                .frame(height: 36)
                .background(.clear)
                .cornerRadius(5)
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(lineWidth: 0.5)
                        .background(.clear)
                }

            HStack {
                Text("검색")
                    .font(.system(size: 12))
                Spacer()
            }
            .padding(.leading, 20)
        }
        .padding(.horizontal, 20)
    }

    private var emptyView: some View {
        VStack(spacing: 30) {
            VStack(spacing: 3) {
                Text("친구를 추가해 보세요.")
                Text("큐알코드나 검색을 이용해서 친구를 추가해 보세요.")
                    .foregroundStyle(Color.gray)
            }

            Button {
                
            } label: {
                Text("친구 추가")
            }
        }
    }
}

#Preview {
    HomeView(viewModel: .init(container: .init(services: StubService()), userId: ""))
}
