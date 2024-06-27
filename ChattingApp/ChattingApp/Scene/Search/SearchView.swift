//
//  SearchView.swift
//  ChattingApp
//
//  Created by 김민 on 6/26/24.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var navigationRouter: NavigationRouter
    @StateObject var viewModel: SearchViewModel

    var body: some View {
        VStack {
            topView

            List {
                ForEach(viewModel.searchedUsersResult) { result in
                    HStack(spacing: 5) {
                        URLImageView(urlString: result.imageURL)
                            .frame(width: 26, height: 26)
                            .clipShape(Circle())
                        Text(result.name)
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(Color.bkText)
                    }
                }
                .listRowInsets(.init())
                .listRowSeparator(.hidden)
                .padding(.horizontal, 30)
            }
            .listStyle(.plain)
        }
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
    }

    private var topView: some View {
        HStack(spacing: 0) {
            Button {
                navigationRouter.pop()
            } label: {
                Image("back_search")
            }

            SearchBar(text: $viewModel.searchText, 
                      shouldBecomeFirstResponder: $viewModel.shouldBecomeFirstResponder)

            Button {
                viewModel.send(action: .clearSearchText)
            } label: {
                Image("close_search")
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    SearchView(viewModel: .init(userId: "user1_id", container: DIContainer(services: StubServices())))
        .environmentObject(NavigationRouter())
}
