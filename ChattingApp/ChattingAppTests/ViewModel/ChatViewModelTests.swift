//
//  ChatViewModelTests.swift
//  ChattingAppTests
//
//  Created by 김민 on 6/28/24.
//

import XCTest
import Combine
@testable import ChattingApp

final class ChatViewModelTests: XCTestCase {

    private var subscriptions = Set<AnyCancellable>()

    // MARK: 각 test가 실행되기 전 호출
    override func setUpWithError() throws {
        subscriptions = Set<AnyCancellable>()
    }

    // MARK: test가 종료되면 실행되면 호출
    override func tearDownWithError() throws {

    }

    func test_addChat_equal_date() {
        let viewModel: ChatViewModel = .init(
            container: .stub,
            chatRoomId: "chatRoom1_id",
            myUserId: "user1_id",
            otherUserId: "user2_id"
        )
        let date = Date(year: 2024, month: 6, day: 28)!

        viewModel.updateChatDataList(.init(chatId: "chat1_id", userId: "user1_id", date: date))
        viewModel.updateChatDataList(.init(chatId: "chat2_id", userId: "user1_id", date: date))
        viewModel.updateChatDataList(.init(chatId: "chat3_id", userId: "user1_id", date: date))
        viewModel.updateChatDataList(.init(chatId: "chat4_id", userId: "user1_id", date: date))

        XCTAssertEqual(viewModel.chatDataList.count, 1)
        XCTAssertEqual(viewModel.chatDataList[0].chats.count, 4)
    }

    func test_addChat_not_equal_date() {
        let viewModel: ChatViewModel = .init(
            container: .stub,
            chatRoomId: "chatRoom1_id",
            myUserId: "user1_id",
            otherUserId: "user2_id"
        )
        var date = Date(year: 2024, month: 6, day: 28)!

        viewModel.updateChatDataList(.init(chatId: "chat1_id", userId: "user1_id", date: date))
        viewModel.updateChatDataList(.init(chatId: "chat2_id", userId: "user1_id", date: date))

        date = date.addingTimeInterval(24 * 60 * 60)
        viewModel.updateChatDataList(.init(chatId: "chat3_id", userId: "user1_id", date: date))
        
        date = date.addingTimeInterval(24 * 60 * 60)
        viewModel.updateChatDataList(.init(chatId: "chat4_id", userId: "user1_id", date: date))

        XCTAssertEqual(viewModel.chatDataList.count, 3)
        XCTAssertEqual(viewModel.chatDataList[0].chats.count, 2)
        XCTAssertEqual(viewModel.chatDataList[1].chats.count, 1)
        XCTAssertEqual(viewModel.chatDataList[2].chats.count, 1)
    }
}
