//
//  HomeView.swift
//  ChattingApp
//
//  Created by 김민 on 6/23/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel

    var body: some View {
        NavigationStack {
            contentView
                .fullScreenCover(item: $viewModel.modalDestination) {
                    switch $0 {
                    case .myProfile:
                        MyProfileView()
                    case let .otherProfile(userId):
                        OtherProfileView()
                    }
                }
        }
    }

    @ViewBuilder
    private var contentView: some View {
        switch viewModel.phase {
        case .notRequested:
            PlaceholderView()
                .onAppear {
                    viewModel.send(.load)
                }
        case .loading:
            LoadingView()
        case .successed:
            loadedView
                .toolbar {
                    Button {
                        // TODO: setting action
                    } label: {
                        Image("settings")
                    }
                }
        case .failed:
            ErrorView()
        }
    }

    private var loadedView: some View {
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
                Spacer(minLength: 24)
                LazyVStack {
                    ForEach(viewModel.users, id: \.id) { user in
                        Button {
                            viewModel.send(.presentOtherProfileView(user.id))
                        } label: {
                            HStack {
                                Image("person")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                Text(user.name)
                                    .font(.system(size: 11, weight: .bold))
                                    .foregroundStyle(Color.bkText)
                                Spacer()
                            }
                            .padding(.horizontal, 30)
                            .padding(.bottom, 7)
                        }
                    }
                }
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
        .onTapGesture {
            viewModel.send(.presentMyProfileView)
        }
    }

    private var searchButton: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.clear)
                .frame(height: 36)
                .background(Color.greyCool)
                .cornerRadius(5)

            HStack {
                Text("검색")
                    .font(.system(size: 12))
                    .foregroundStyle(Color.greyLightVer2)
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
                    .foregroundStyle(Color.bkText)
                Text("큐알코드나 검색을 이용해서 친구를 추가해 보세요.")
                    .foregroundStyle(Color.greyDeep)
            }

            Button {
                viewModel.send(.requestContacts)
            } label: {
                Text("친구 추가")
                    .font(.system(size: 14))
                    .foregroundStyle(Color.bkText)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 9)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.greyLight)
            }
        }
    }
}

#Preview {
    HomeView(viewModel: .init(container: .init(services: StubServices()), userId: "user1_id"))
}
