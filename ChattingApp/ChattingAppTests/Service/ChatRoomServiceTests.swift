//
//  ChatRoomServiceTests.swift
//  ChattingAppTests
//
//  Created by 김민 on 6/28/24.
//

import XCTest
import Combine
@testable import ChattingApp

final class ChatRoomServiceTests: XCTestCase {

    private var subscriptions = Set<AnyCancellable>()

    // MARK: 각 test가 실행되기 전 호출
    override func setUpWithError() throws {
        subscriptions = Set<AnyCancellable>()
    }

    // MARK: test가 종료되면 실행되면 호출
    override func tearDownWithError() throws {

    }

    func test_creatChatRoomIfNeeded_not_existed() {
        let mockDBRepository = MockChatRoomDBRepository(mockData: nil)
        let chatRoomService = ChatRoomService(dbRepository: mockDBRepository)
        var result: ChatRoom?

        chatRoomService.createChatRoomIfNeeded(myUserId: "user1_id", otherUserId: "user2_id", otherUserName: "user2")
            .sink { completion in
                if case let .failure(error) = completion {
                    XCTFail("Unexpected fail: \(error)")
                }
            } receiveValue: { chatRoom in
                result = chatRoom
            }
            .store(in: &subscriptions)

        XCTAssertNotNil(result)
        XCTAssertEqual(result?.otherUserId, "user2_id")
        XCTAssertEqual(result?.otherUserName, "user2")

        XCTAssertEqual(mockDBRepository.addChatRoomCallCount, 1)
        XCTAssertEqual(mockDBRepository.getChatRoomCallCount, 1)
    }

    func test_creatChatRoomIfNeeded_existed() {
        let mockDBRepository = MockChatRoomDBRepository(mockData: ChatRoomObject.stub1)
        let chatRoomService = ChatRoomService(dbRepository: mockDBRepository)
        var result: ChatRoom?

        chatRoomService.createChatRoomIfNeeded(myUserId: "user1_id", otherUserId: "user2_id", otherUserName: "user2")
            .sink { completion in
                if case let .failure(error) = completion {
                    XCTFail("Unexpected fail: \(error)")
                }
            } receiveValue: { chatRoom in
                result = chatRoom
            }
            .store(in: &subscriptions)

        XCTAssertNotNil(result)
        XCTAssertEqual(result?.otherUserId, "user2_id")
        XCTAssertEqual(result?.otherUserName, "user2")

        XCTAssertEqual(mockDBRepository.addChatRoomCallCount, 0)
        XCTAssertEqual(mockDBRepository.getChatRoomCallCount, 1)
    }
}

class MockChatRoomDBRepository: ChatRoomDBRepositoryType {

    let mockData: Any?

    var addChatRoomCallCount = 0
    var getChatRoomCallCount = 0

    init(mockData: Any?) {
        self.mockData = mockData
    }

    func getChatRoom(myUserId: String, otherUserId: String) -> AnyPublisher<ChatRoomObject?, DBError> {
        getChatRoomCallCount += 1
        return Just(mockData as? ChatRoomObject).setFailureType(to: DBError.self).eraseToAnyPublisher()
    }

    func addChatRoom(_ object: ChatRoomObject, myUserId: String) -> AnyPublisher<Void, DBError> {
        addChatRoomCallCount += 1
        return Just(()).setFailureType(to: DBError.self).eraseToAnyPublisher()
    }

    func loadChatRooms(myUserId: String) -> AnyPublisher<[ChatRoomObject],DBError> {
        Just([]).setFailureType(to: DBError.self).eraseToAnyPublisher()
    }

    func updateChatRoomLastMessage(chatRoomId: String, myUserId: String, myUserName: String, otherUserId: String, lastMessage: String) -> AnyPublisher<Void, DBError> {
        Just(()).setFailureType(to: DBError.self).eraseToAnyPublisher()
    }
}
