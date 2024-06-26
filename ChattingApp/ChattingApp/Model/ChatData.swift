//
//  ChatData.swift
//  ChattingApp
//
//  Created by 김민 on 6/26/24.
//

import Foundation

struct ChatData: Hashable, Identifiable {
    var dataStr: String
    var chats: [Chat]

    var id: String { dataStr }
}
