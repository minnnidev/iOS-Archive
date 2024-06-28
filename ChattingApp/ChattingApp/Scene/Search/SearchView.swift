//
//  SearchView.swift
//  ChattingApp
//
//  Created by 김민 on 6/26/24.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var container: DIContainer
    @Environment(\.managedObjectContext) var objectContext
    @StateObject var viewModel: SearchViewModel

    var body: some View {
        VStack {
            topView

            if viewModel.searchedUsersResult.isEmpty {
                RecentSearchView()
            } else {
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
        }
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
    }

    private var topView: some View {
        HStack(spacing: 0) {
            Button {
                container.navigationRouter.pop()
            } label: {
                Image("back_search")
            }

            SearchBar(text: $viewModel.searchText,
                      shouldBecomeFirstResponder: $viewModel.shouldBecomeFirstResponder) {
                setSearchedResultWithContext()
            }

            Button {
                viewModel.send(action: .clearSearchText)
            } label: {
                Image("close_search")
            }
        }
        .padding(.horizontal, 20)
    }

    private func setSearchedResultWithContext() {
        let result = SearchResult(context: objectContext)

        result.id = UUID().uuidString
        result.name = viewModel.searchText
        result.date = Date()

        try? objectContext.save()
    }
}

#Preview {
    SearchView(viewModel: .init(userId: "user1_id", container: DIContainer(services: StubServices())))
}
