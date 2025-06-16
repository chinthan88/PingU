//
//  ChatSendMessageUseCase.swift
//  PingU
//
//  Created by Chinthan M on 11/06/25.
//
import SwiftUI

/// Implementation for sending messages using chat
final class ChatSendMessageUseCase: SendMessageUseCase {
    private let repository: ChatRepository

    init(repository: ChatRepository) {
        self.repository = repository
    }

    func execute(content: String) {
        let message = Message(
            id: UUID(),
            content: content,
            isSentByUser: true,
            timestamp: Date()
        )
        repository.send(message: message)
    }
}
