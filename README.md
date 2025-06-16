# 🐧 PingU — A Simple SwiftUI Chat App

[![iOS Build](https://github.com/chinthan88/PingU/actions/workflows/ios.yml/badge.svg)](https://github.com/chinthan88/PingU/actions/workflows/ios.yml)

**PingU** is a cleanly architected iOS chat application built with **SwiftUI**, **Combine**, and **Clean Architecture**, following **SOLID principles**.

---

## ✨ Features

- 💬 Send and receive messages  
- 🔄 Auto-reply with random responses (simulates future WebSocket integration)  
- 🧠 Clean Architecture (Domain, Data, Presentation layers)  
- ✅ Unit Tested (No external test dependencies)  
- 🧪 UI Tests with `XCTest`
- 🧱 Scalable and testable with solid Dependency Injection  

---

## 📁 Project Structure

```
PingUChatApp/
├── App
│   └── PingUApp.swift
├── Presentation
│   ├── ChatView.swift
│   └── ViewModel/
│       └── ChatViewModel.swift
├── Domain
│   ├── Entities/
│   │   └── Message.swift
│   ├── UseCases/
│   │   ├── ChatSendMessageUseCase.swift
│   │   ├── ChatReceiveMessageUseCase.swift
│   │   └── ChatRandomReplyUseCase.swift
│   └── Protocols/
│       ├── ChatRepository.swift
│       └── ReplyOptionsProvider.swift
├── Data
│   ├── Repository/
│   │   └── RemoteChatRepository.swift
│   └── Reply/
│       └── StaticReplyOptionsProvider.swift
├── Resources
│   └── Assets.xcassets, LaunchScreen
├── Tests/
│   ├── ChatAppTests.swift (Unit Tests)
│   └── ChatAppUITests.swift (UI Tests)
```

---

## 🧪 Test Coverage

- ✅ `ChatSendMessageUseCase` and `ChatReceiveMessageUseCase`
- ✅ `ChatRandomReplyUseCase` and `StaticReplyOptionsProvider`
- ✅ `RemoteChatRepository`
- ✅ `ChatViewModel` including async auto-reply handling
- ✅ `ChatView` UI tested using `XCTest` with `accessibilityIdentifiers`

---

## 💡 Dependency Injection

All dependencies like repositories and use cases are injected using initializer injection for better testability and adherence to **Inversion of Control** principle.

---

## 🔨 How to Run

1. Open the project in **Xcode 15+ or Xcode 16**.
2. Select `PingU` target and press **⌘R** to run the app.
3. To run tests, press **⌘U** or go to `Product > Test`.

---

## ✅ Accessibility for UI Testing

All UI elements (TextEditor, Buttons, etc.) are tagged with `accessibilityIdentifier` to allow seamless `XCUITest` integration.

---

## 📦 Future Enhancements

- Replace `StaticReplyOptionsProvider` with real-time `WebSocketClient`
- Add user profiles and message timestamps
- Integrate chat bubbles with avatars
- Add persistent message storage (e.g. using CoreData or SQLite)

---

## 👨‍💻 Author

**Chinthan M**  
Senior iOS Developer

---

## 📜 License

MIT License — Use freely with attribution.
