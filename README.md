# Chat App 💬

A real-time chat application built with **Flutter** and **Firebase** that allows users to register, log in, create chat rooms, and send messages inside rooms.

---

## 🚀 Features

- 🔐 User Authentication (Register / Login) باستخدام Firebase Auth
- 👤 User data stored in Firestore
- 🏠 Home screen displays all available chat rooms
- ➕ Create new chat rooms
- 💬 Send messages inside chat rooms
- 📂 Room categories (Music, Movies, Sports)
- 📡 Firebase Firestore integration
- 🎨 Simple and clean UI

---

## 📱 Screens

- **Login Screen**
- **Register Screen**
- **Home Screen**
- **Add Room Screen**
- **Chat Thread Screen**

---

## 🛠 Tech Stack

- **Flutter**
- **Dart**
- :contentReference[oaicite:0]{index=0}
  - Firebase Authentication
  - Cloud Firestore
- **Provider** (State Management)

---
## 📝 Notes Stack 
- **User data is stored in Firestore after registration**.
- **Chat rooms are stored in Firestore**.
- **Messages are stored inside each room as a subcollection**.
- **Uses Provider for state management**.

## 📂 Project Structure

```bash
lib/
│
├── chat/
│   ├── chat_thread.dart
│   ├── chat_view_model.dart
│
├── customs/
│   ├── custom_text_form_field.dart
│
├── database/
│   ├── my_database.dart
│
├── model/
│   ├── Room.dart
│   ├── message.dart
│   ├── my_user.dart
│   ├── room_category.dart
│
├── ui/
│   ├── add_room/
│   ├── home_screen/
│   ├── regestretion/
│   ├── signIn/
│
├── utiles/
│   ├── dialogs_utils/
│   ├── email_validator.dart
│
├── sharedData.dart
└── main.dart


