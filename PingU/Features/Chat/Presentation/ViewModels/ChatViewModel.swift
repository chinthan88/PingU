//
//  ChatViewModel.swift
//  PingU
//
//  Created by Chinthan M on 11/06/25.
//
import SwiftUI
import Combine

/// ViewModel for handling chat interaction
final class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var inputText: String = ""

    private let sendMessageUseCase: SendMessageUseCase
    private let receiveMessageUseCase: ReceiveMessageUseCase
    private let randomReplyUseCase: RandomReplyUseCase
    private var cancellables = Set<AnyCancellable>()

    init(
        sendMessageUseCase: SendMessageUseCase,
        receiveMessageUseCase: ReceiveMessageUseCase,
        randomReplyUseCase: RandomReplyUseCase,
        repository: ChatRepository
    ) {
        self.sendMessageUseCase = sendMessageUseCase
        self.receiveMessageUseCase = receiveMessageUseCase
        self.randomReplyUseCase = randomReplyUseCase

        repository.messagesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.messages = $0 }
            .store(in: &cancellables)
    }

    /// Sends a new message and triggers auto-reply
    func sendMessage() {
        let trimmed = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        sendMessageUseCase.execute(content: trimmed)
        inputText = ""
        autoReply()
    }

    /// Simulates receiving a reply after 5 seconds
    private func autoReply() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            guard let self = self else { return }
            let randomReply = self.randomReplyUseCase.execute()
            self.receiveMessageUseCase.execute(content: randomReply)
        }
    }
}

