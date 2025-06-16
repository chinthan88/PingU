//
//  Message.swift
//  PingU
//
//  Created by Chinthan M on 11/06/25.
//
import SwiftUI

/// Represents a chat message
struct Message: Identifiable, Equatable {
    let id: UUID
    let content: String
    let isSentByUser: Bool
    let timestamp: Date
}
