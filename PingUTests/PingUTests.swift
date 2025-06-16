//
//  PingUTests.swift
//  PingUTests
//
//  Created by Chinthan M on 11/06/25.
//

import XCTest
import Combine
@testable import PingU

final class ChatAppTests: XCTestCase {

    // MARK: - Mocks

    final class MockChatRepository: ChatRepository {
        private(set) var sentMessages: [Message] = []
        private(set) var receivedMessages: [Message] = []
        private let subject = CurrentValueSubject<[Message], Never>([])

        var messagesPublisher: AnyPublisher<[Message], Never> {
            subject.eraseToAnyPublisher()
        }

        func send(message: Message) {
            sentMessages.append(message)
            subject.send(sentMessages + receivedMessages)
        }

        func receive(message: Message) {
            receivedMessages.append(message)
            subject.send(sentMessages + receivedMessages)
        }
    }

    final class MockReplyOptionsProvider: ReplyOptionsUseCase {
        func fetchReplies() -> [String] {
            ["Mock Reply 1", "Mock Reply 2"]
        }
    }

    // MARK: - Use Case Tests

    func testSendMessageUseCase_sendsMessage() {
        let repo = MockChatRepository()
        let useCase = ChatSendMessageUseCase(repository: repo)
        useCase.execute(content: "Hello")

        XCTAssertEqual(repo.sentMessages.count, 1)
        XCTAssertEqual(repo.sentMessages.first?.content, "Hello")
        XCTAssertTrue(repo.sentMessages.first!.isSentByUser)
    }

    func testReceiveMessageUseCase_receivesMessage() {
        let repo = MockChatRepository()
        let useCase = ChatReceiveMessageUseCase(repository: repo)
        useCase.execute(content: "Hi there")

        XCTAssertEqual(repo.receivedMessages.count, 1)
        XCTAssertEqual(repo.receivedMessages.first?.content, "Hi there")
        XCTAssertFalse(repo.receivedMessages.first!.isSentByUser)
    }

    func testRandomReplyUseCase_returnsOneOfProviderReplies() {
        let provider = MockReplyOptionsProvider()
        let useCase = ChatRandomReplyUseCase(provider: provider)

        let reply = useCase.execute()
        XCTAssertTrue(provider.fetchReplies().contains(reply))
    }

    func testStaticReplyOptionsProvider_fetchesAllOptions() {
        let provider = StaticReplyOptionsUsecase()
        let replies = provider.fetchReplies()

        XCTAssertGreaterThan(replies.count, 1)
        XCTAssertTrue(replies.contains("Hey there! 👋"))
    }

    // MARK: - Repository Tests

    func testRemoteChatRepository_sendsAndReceivesMessages() {
        let repository = RemoteChatRepository()
        var receivedMessages: [[Message]] = []
        let cancellable = repository.messagesPublisher
            .sink { receivedMessages.append($0) }

        let msg1 = Message(id: UUID(), content: "Hello", isSentByUser: true, timestamp: Date())
        repository.send(message: msg1)

        let msg2 = Message(id: UUID(), content: "Hi!", isSentByUser: false, timestamp: Date())
        repository.receive(message: msg2)

        XCTAssertEqual(receivedMessages.last?.count, 2)
        XCTAssertEqual(receivedMessages.last?.first?.content, "Hello")
        XCTAssertEqual(receivedMessages.last?.last?.content, "Hi!")

        cancellable.cancel()
    }

    // MARK: - ViewModel Test

    func testChatViewModel_sendMessageAndAutoReply() {
        let expectation = XCTestExpectation(description: "Receive auto-reply")
        let repo = MockChatRepository()
        let sendUseCase = ChatSendMessageUseCase(repository: repo)
        let receiveUseCase = ChatReceiveMessageUseCase(repository: repo)
        let provider = MockReplyOptionsProvider()
        let randomReplyUseCase = ChatRandomReplyUseCase(provider: provider)

        let viewModel = ChatViewModel(
            sendMessageUseCase: sendUseCase,
            receiveMessageUseCase: receiveUseCase,
            randomReplyUseCase: randomReplyUseCase,
            repository: repo
        )

        var cancellables = Set<AnyCancellable>()

        viewModel.inputText = "Test message"
        viewModel.sendMessage()

        repo.messagesPublisher
            .dropFirst()
            .sink { messages in
                if messages.count >= 2 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 6.0)

        XCTAssertEqual(repo.sentMessages.first?.content, "Test message")
        XCTAssertEqual(repo.receivedMessages.count, 1)
        XCTAssertTrue(provider.fetchReplies().contains(repo.receivedMessages.first!.content))
    }
}


