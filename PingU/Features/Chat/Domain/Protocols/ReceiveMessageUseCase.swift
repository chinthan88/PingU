//
//  Use.swift
//  PingU
//
//  Created by Chinthan M on 11/06/25.
//
import SwiftUI

/// Receives an incoming message
protocol ReceiveMessageUseCase {
    func execute(content: String)
}
