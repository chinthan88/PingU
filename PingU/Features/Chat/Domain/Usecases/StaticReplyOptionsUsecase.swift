//
//  StaticReplyOptionsUsecase.swift
//  PingU
//
//  Created by Chinthan M on 11/06/25.
//
import SwiftUI

/// Provides static reply options
final class StaticReplyOptionsUsecase: ReplyOptionsUseCase {
    func fetchReplies() -> [String] {
        [
            "Hey there! 👋",
            "What’s up?",
            "Let me think about that...",
            "Interesting point!",
            "Haha, nice one!",
            "Sounds great!",
            "I’ll get back to you on that.",
            "Cool cool cool.",
            "Gotcha! 😎",
            "That's awesome!"
        ]
    }
}
