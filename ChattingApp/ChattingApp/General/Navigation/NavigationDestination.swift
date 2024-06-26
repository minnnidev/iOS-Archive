//
//  NavigationDestination.swift
//  ChattingApp
//
//  Created by 김민 on 6/26/24.
//

import Foundation

enum NavigationDestination: Hashable {
    case chat(chatroomId: String, myUserId: String, otherUserId: String)
    case search
}
