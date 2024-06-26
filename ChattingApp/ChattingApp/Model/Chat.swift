//
//  Chat.swift
//  ChattingApp
//
//  Created by 김민 on 6/26/24.
//

import Foundation

struct Chat: Hashable, Identifiable {
    var chatId: String
    var userId: String
    var message: String?
    var photoURL: String?
    var date: Date
    var id: String { chatId }
}
