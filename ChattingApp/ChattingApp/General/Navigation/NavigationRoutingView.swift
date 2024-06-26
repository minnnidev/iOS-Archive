//
//  NavigationRoutingView.swift
//  ChattingApp
//
//  Created by 김민 on 6/26/24.
//

import SwiftUI

struct NavigationRoutingView: View {
    @State var destination: NavigationDestination

    var body: some View {
        switch destination {
        case .chat:
            ChatView()
        case .search:
            SearchView()
        }
    }
}
