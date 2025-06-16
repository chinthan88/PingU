//
//  ChatRepository.swift
//  PingU
//
//  Created by Chinthan M on 11/06/25.
//
import SwiftUI
import Combine

/// Defines chat repository interface
protocol ChatRepository {
    var messagesPublisher: AnyPublisher<[Message], Never> { get }
    func send(message: Message)
    func receive(message: Message)
}
