//
//  PingUApp.swift
//  PingU
//
//  Created by Chinthan M on 11/06/25.
//

import SwiftUI

@main
struct PingUApp: App {
    var body: some Scene {
        WindowGroup {
            let repository = RemoteChatRepository()
            let sendUseCase = ChatSendMessageUseCase(repository: repository)
            let receiveUseCase = ChatReceiveMessageUseCase(repository: repository)
            let replyProvider = StaticReplyOptionsUsecase()
            let randomReplyUseCase = ChatRandomReplyUseCase(provider: replyProvider)
            let viewModel = ChatViewModel(
                sendMessageUseCase: sendUseCase,
                receiveMessageUseCase: receiveUseCase,
                randomReplyUseCase: randomReplyUseCase,
                repository: repository
            )
            ChatView(viewModel: viewModel)
        }
    }
}
