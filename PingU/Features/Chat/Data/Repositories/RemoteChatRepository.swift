//
//  ChatRepository.swift
//  PingU
//
//  Created by Chinthan M on 11/06/25.
//
import SwiftUI
import Combine

// MARK: - Data Layer
/// Repository implementation storing messages in memory
final class RemoteChatRepository: ChatRepository {
    private var messages: [Message] = []
    private let messagesSubject = CurrentValueSubject<[Message], Never>([])

    var messagesPublisher: AnyPublisher<[Message], Never> {
        messagesSubject.eraseToAnyPublisher()
    }

    func send(message: Message) {
        messages.append(message)
        messagesSubject.send(messages)
    }

    func receive(message: Message) {
        messages.append(message)
        messagesSubject.send(messages)
    }
}
