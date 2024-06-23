//
//  MainTabView.swift
//  ChattingApp
//
//  Created by 김민 on 6/20/24.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @EnvironmentObject var container: DIContainer
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
                        Text("chat")
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
