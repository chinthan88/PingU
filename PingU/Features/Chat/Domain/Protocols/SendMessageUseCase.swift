//
//  SendMessageUsecase.swift
//  PingU
//
//  Created by Chinthan M on 11/06/25.
//
import SwiftUI

/// Sends a user message
protocol SendMessageUseCase {
    func execute(content: String)
}
