//
//  MainTabView.swift
//  Messenger
//
//  Created by 김민 on 6/19/24.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: MainTabType = .home

    init() {
        UITabBar.appearance().unselectedItemTintColor = .black
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(MainTabType.allCases, id: \.self) { tab in
                Group {
                    switch tab {
                    case .home:
                        HomeView(viewModel: .init())
                    case .chat:
                        ChatListView()
                    case .phone:
                        Text("Phone")
                    }
                }
                .tabItem {
                    Label(tab.title, image: tab.imageName(selected: selectedTab == tab))
                }
                .tag(tab)
            }
        }
        .tint(Color.black)
    }
}

#Preview {
    MainTabView()
}
