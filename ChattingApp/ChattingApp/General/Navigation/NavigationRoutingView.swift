//
//  NavigationRoutingView.swift
//  ChattingApp
//
//  Created by 김민 on 6/26/24.
//

import SwiftUI

struct NavigationRoutingView: View {
    @EnvironmentObject var container: DIContainer
    @State var destination: NavigationDestination

    var body: some View {
        switch destination {
        case let .chat(chatroomId, myUserId, otherUserId):
            ChatView(viewModel: .init(
                container: container,
                chatRoomId: chatroomId,
                myUserId: myUserId,
                otherUserId: otherUserId)
            )
        case let .search(myUserId):
            SearchView(viewModel: .init(userId: myUserId, container: container))
        }
    }
}
