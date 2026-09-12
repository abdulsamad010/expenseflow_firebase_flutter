# 💰 ExpenseFlow — Firebase Expense Tracker

<p align="center">
  <img src="assets/logo.png" alt="ExpenseFlow Logo" width="120"/>
</p>

<h2 align="center">🚀 ExpenseFlow</h2>

<p align="center">
  A Flutter-based personal finance application for managing income and expenses with Firebase Authentication, Cloud Firestore, BLoC state management, and Firebase Cloud Messaging.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-Framework-02569B?style=for-the-badge&logo=flutter&logoColor=white"/>
  <img src="https://img.shields.io/badge/Dart-Language-0175C2?style=for-the-badge&logo=dart&logoColor=white"/>
  <img src="https://img.shields.io/badge/Firebase-Backend-FFCA28?style=for-the-badge&logo=firebase&logoColor=black"/>
  <img src="https://img.shields.io/badge/BLoC-State%20Management-6C63FF?style=for-the-badge"/>
</p>

<p align="center">
  <a href="https://github.com/abdulsamad010/expenseflow_firebase_flutter">
    <img src="https://img.shields.io/badge/GitHub-Repository-181717?style=for-the-badge&logo=github&logoColor=white"/>
  </a>
</p>

---

## 🌟 About The Project

**ExpenseFlow** is a Flutter finance-management application developed to practice and implement:

- 📱 Flutter application development
- 🔐 Firebase Email/Password Authentication
- ☁️ Cloud Firestore data storage
- 🧠 BLoC state management
- 💵 Income and expense tracking
- ✏️ Transaction management
- 🔔 Firebase Cloud Messaging (FCM)
- 📅 Scheduled notification campaigns
- 🎨 Custom application branding and launcher icon

The application provides a simple way for users to maintain their financial transactions while keeping authentication and cloud data connected through Firebase.

---

## ✨ Features

### 🔐 Authentication
- User registration with Firebase Authentication
- User login with Firebase Authentication
- Form validation
- Loading states during authentication
- Authentication success/failure feedback

### 💳 Transaction Management
- Add income transactions
- Add expense transactions
- Edit transaction information
- Delete transactions
- Fetch transactions from Firestore
- Transaction categories
- Transaction date selection
- Amount handling for income and expenses

### 📊 Dashboard
- Dedicated ExpenseFlow dashboard
- Access to the application's transaction functionality
- User-specific transaction workflow

### 🔔 Firebase Cloud Messaging
- FCM permission handling
- FCM device token retrieval
- Foreground notification handling
- Background/closed-app notification delivery through Firebase
- Topic-based notification subscription
- Scheduled Firebase Console notification campaign

Current general notification topic:

```text
expenseflow_users
```

Current scheduled reminder:

```text
ExpenseFlow Reminder

Don't forget to add today's income and expenses to keep your finances up to date.
```

The notification is configured as a general reminder for users subscribed to the `expenseflow_users` topic.

---

## 🏗️ Project Architecture

The project uses a simple feature-based structure with BLoC for application state management.

```text
lib/
├── core/
│   ├── firebase_service.dart
│   └── models/
│       └── transaction_model.dart
│
├── features/
│   ├── authentication/
│   │   ├── authentication_bloc.dart
│   │   ├── authentication_event.dart
│   │   ├── authentication_state.dart
│   │   ├── login_screen.dart
│   │   └── signup_screen.dart
│   │
│   ├── dashboard/
│   │   └── dashboard_screen.dart
│   │
│   └── transactions/
│       ├── transaction_bloc.dart
│       ├── transaction_event.dart
│       ├── transaction_state.dart
│       ├── transactions_screen.dart
│       ├── add_transaction_screen.dart
│       └── edit_transaction_screen.dart
│
├── firebase_options.dart
└── main.dart
```

---

## 🧠 State Management

ExpenseFlow uses **BLoC (Business Logic Component)** to separate UI from application logic.

### Authentication BLoC

Handles:

- Signup
- Login
- Authentication loading state
- Authentication success state
- Authentication failure state

### Transaction BLoC

Handles:

- Adding transactions
- Fetching transactions
- Deleting transactions
- Transaction state updates

This keeps the screens focused mainly on presentation and user interaction.

---

## 🔥 Firebase Integration

ExpenseFlow is connected to the Firebase project:

```text
expenseflow-firebase-flutter
```

### Firebase services used

| Firebase Service | Purpose |
|---|---|
| 🔐 Firebase Authentication | User signup and login |
| ☁️ Cloud Firestore | Store user transaction data |
| 🔔 Firebase Cloud Messaging | Push notifications |

Firebase is initialized before the Flutter application starts.

---

## ☁️ Firestore Structure

Transactions are stored under a user-specific Firestore path.

```text
users
└── transactions
    └── {userUid}
        └── {transactionDocument}
```

Each transaction contains information such as:

```text
tId
uId
name
amount
isExpense
category
date
```

This structure associates transaction records with the authenticated user.

---

## 💰 Transaction Categories

ExpenseFlow currently supports categories including:

```text
food
groceries
shopping
transportation
fuel
bills
rent
healthcare
education
entertainment
travel
subscriptions
personal_care
gifts_donations
salary
freelance
business
investment
other
```

---

## 🔔 Notification System

ExpenseFlow uses **Firebase Cloud Messaging (FCM)** for push notifications.

The application subscribes users to:

```text
expenseflow_users
```

Firebase Console can then target subscribers of this topic.

### Current notification flow

```text
User runs ExpenseFlow
       ↓
Firebase initializes
       ↓
FCM permission requested
       ↓
FCM token generated
       ↓
User subscribes to expenseflow_users
       ↓
Firebase Console scheduled campaign
       ↓
Notification delivered to subscribed users
```

### Important

The current notification system is designed for **general notifications for subscribed users**.

It does not implement per-user notification scheduling or dynamic server-side financial alerts.

---

## 🛠️ Technologies Used

| Technology | Usage |
|---|---|
| 🐦 Flutter | Mobile application framework |
| 🎯 Dart | Programming language |
| 🔥 Firebase Core | Firebase initialization |
| 🔐 Firebase Auth | Authentication |
| ☁️ Cloud Firestore | Cloud database |
| 🔔 Firebase Messaging | Push notifications |
| 🧠 Flutter BLoC | State management |
| 🎨 Android launcher assets | Application branding |

---

## 📦 Main Dependencies

The project uses Flutter packages including:

```yaml
firebase_core
firebase_auth
firebase_messaging
cloud_firestore
flutter_bloc
```

The exact package versions are maintained in `pubspec.yaml` and `pubspec.lock`.

---

## 🚀 Getting Started

### 1️⃣ Clone the repository

```bash
git clone https://github.com/abdulsamad010/expenseflow_firebase_flutter.git
```

### 2️⃣ Open the project

```bash
cd expenseflow_firebase_flutter
```

### 3️⃣ Install dependencies

```bash
flutter pub get
```

### 4️⃣ Configure Firebase

This project uses FlutterFire configuration.

The Firebase configuration file is:

```text
lib/firebase_options.dart
```

For a new Firebase environment, configure Firebase with the FlutterFire CLI.

### 5️⃣ Run the application

```bash
flutter run
```

---

## 🔔 FCM Topic Subscription

The application uses the following FCM topic:

```text
expenseflow_users
```

The app subscribes to the topic using Firebase Messaging:

```dart
await FirebaseMessaging.instance.subscribeToTopic("expenseflow_users");
```

After running the application, the device can receive notifications targeted to this topic.

---

## 🧪 Testing

### Authentication
- Create a new account
- Log in with the created account
- Test invalid input
- Test authentication failure feedback

### Transactions
- Add an income
- Add an expense
- Select a category
- Select a date
- Edit a transaction
- Delete a transaction
- Fetch transactions from Firestore

### Notifications
- Run the application and subscribe to the FCM topic
- Send a Firebase Console test notification
- Test foreground notification handling
- Test background notification delivery
- Test closed-app notification delivery
- Test the scheduled topic notification

---

## 🎨 Branding

The project includes:

```text
assets/logo.png
```

Android launcher icon assets have also been updated to match the application branding.

---

## 📌 Repository

**GitHub Repository:**  
https://github.com/abdulsamad010/expenseflow_firebase_flutter

**GitHub Username:**  
`abdulsamad010`

---

## 👨‍💻 Developer

### Abdul Samad Abbasi

💻 **Flutter Developer**

🐙 GitHub: `@abdulsamad010`

📧 Email: `abdulsamadabbasi010@gmail.com`

---

## 📊 Project Status

| Component | Status |
|---|---|
| 🔐 Firebase Authentication | 🟢 Implemented |
| ☁️ Cloud Firestore | 🟢 Implemented |
| 💳 Transaction CRUD | 🟢 Implemented |
| 🧠 BLoC State Management | 🟢 Implemented |
| 🔔 Firebase Cloud Messaging | 🟢 Implemented |
| 📢 FCM Topic Subscription | 🟢 Implemented |
| 📅 Scheduled Reminder | 🟢 Configured |
| 🎨 App Branding | 🟢 Updated |

---

## 🔮 Future Improvements

Possible future enhancements include:

- 📊 Financial summaries and charts
- 🔎 Transaction search and filtering
- 📅 Monthly/yearly financial reports
- 💾 Exporting transaction data
- 🎯 Budget tracking
- 📈 Spending insights
- 👤 More detailed user profile management
- 🔔 More advanced personalized notification features

These are potential improvements and are **not currently represented as implemented features**.

---

## 📄 License

This project is intended as a personal/development project for learning and demonstrating Flutter, Firebase, BLoC, and FCM integration.

---

<p align="center">
  <strong>💡 Track your transactions. Understand your spending. Build better financial habits.</strong>
</p>

<p align="center">
  Made with ❤️ using Flutter & Firebase
</p>
