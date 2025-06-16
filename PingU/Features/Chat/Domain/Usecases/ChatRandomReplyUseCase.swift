//
//  Usecase.swift
//  PingU
//
//  Created by Chinthan M on 11/06/25.
//
import SwiftUI

/// Provides random reply from the injected reply provider
final class ChatRandomReplyUseCase: RandomReplyUseCase {
    private let provider: ReplyOptionsUseCase

    init(provider: ReplyOptionsUseCase) {
        self.provider = provider
    }

    func execute() -> String {
        provider.fetchReplies().randomElement() ?? "Hello!"
    }
}
