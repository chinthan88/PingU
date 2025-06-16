//
//  Chat.swift
//  PingU
//
//  Created by Chinthan M on 11/06/25.
//
import SwiftUI

/// Implementation for receiving messages using chat
final class ChatReceiveMessageUseCase: ReceiveMessageUseCase {
    private let repository: ChatRepository

    init(repository: ChatRepository) {
        self.repository = repository
    }

    func execute(content: String) {
        let message = Message(
            id: UUID(),
            content: content,
            isSentByUser: false,
            timestamp: Date()
        )
        repository.receive(message: message)
    }
}
