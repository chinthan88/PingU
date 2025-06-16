//
//  ReplyOptionsProvider.swift
//  PingU
//
//  Created by Chinthan M on 11/06/25.
//
import SwiftUI

/// Abstraction for providing reply options
protocol ReplyOptionsUseCase {
    func fetchReplies() -> [String]
}
