//
//  ChatView.swift
//  PingU
//
//  Created by Chinthan M on 11/06/25.
//
import SwiftUI

struct ChatView: View {
    @StateObject var viewModel: ChatViewModel

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Image(systemName: "message.fill")
                    .foregroundColor(.blue)
                Text("PingU")
                    .font(.title2)
                    .fontWeight(.bold)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(UIColor.systemGray6))

            Divider()

            // Messages
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    ForEach(viewModel.messages) { message in
                        HStack {
                            if message.isSentByUser { Spacer() }
                            Text(message.content)
                                .padding()
                                .background(message.isSentByUser ? Color.blue : Color.gray.opacity(0.3))
                                .foregroundColor(message.isSentByUser ? .white : .black)
                                .cornerRadius(10)
                                .accessibilityIdentifier("Message_\(message.id.uuidString)")
                            if !message.isSentByUser { Spacer() }
                        }
                    }
                }
                .padding()
            }

            // Input bar
            HStack(spacing: 8) {
                TextField("Enter message...", text: $viewModel.inputText)
                    .padding(10)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                    .accessibilityIdentifier("InputTextEditor")

                Button(action: {
                    viewModel.sendMessage()
                }) {
                    Text("Send")
                        .fontWeight(.semibold)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 16)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .accessibilityIdentifier("SendButton")
            }
            .padding()
            .background(Color(UIColor.systemBackground))
        }
    }
}
