# Send Money App

A Flutter application built using the **BLoC architecture**, **MVVM pattern**, and **offline/online support**. The app features Login, Wallet Management, Transaction History, and Send Money functionality with integration to a fake API. Unit tests and integration tests ensure high-quality code.

---



## **Features**

1. **Login Screen:**
   - Simple username and password authentication.
   - Ability to log out from any screen.

2. **Home Screen:**
   - Displays wallet balance with show/hide functionality.
   - Buttons for navigating to the "Send Money" and "Transaction History" screens.

3. **Send Money Screen:**
   - Allows users to send money by entering an amount.
   - Displays a bottom sheet indicating success or failure.

4. **Transaction History Screen:**
   - Lists all past transactions.
   - Offline mode support: Displays cached data when offline and syncs data upon returning online.

5. **Offline Support:**
   - Last fetched data is displayed in offline mode.
   - Syncs data with the server when back online.

6. **API Integration:**
   - Uses a fake API ([JSONPlaceholder](https://jsonplaceholder.typicode.com)) for posting and fetching transaction data.

7. **Unit and Integration Testing:**
   - Thorough tests for Login, Send Money, and Transaction History functionality.
  
8. **Credentials to the app:**
   - user name : testuser.
   - password: password

---

## **Project Structure**

```
lib/
├── bloc/                    # BLoC files for Login, Send Money, and Transactions
├── models/                  # Data models (e.g., User, Transaction)
├── repository/              # Repository classes for handling API calls
├── screens/                 # UI Screens for Login, Home, Send Money, and Transaction History
├── widgets/                 # Shared widgets
├── utils/                   # Utility functions (e.g., offline mode handling)
├── main.dart                # Entry point of the app
```

---

## **How to Run**

### **Step 1: Prerequisites**
- Install Flutter: [Flutter Installation Guide](https://docs.flutter.dev/get-started/install)
- Ensure you have an IDE like **VS Code** or **Android Studio**.

### **Step 2: Clone the Repository**
```bash
git clone https://github.com/jadhavarun94/send_money_app/tree/master 
cd send_money_app
```

### **Step 3: Install Dependencies**
```bash
flutter pub get
```

### **Step 4: Run the App**
```bash
flutter run
git clone https://github.com/jadhavarun94/send_money_app/tree/master 
cd send_money_app


### **Step 5: Run Tests**
- **Unit Tests:**
  ```bash
  flutter test
  ```
- **Integration Tests:**
  ```bash
  flutter test integration_test/app_test.dart
  ```

---

## **Dependencies**

Below are the major dependencies used in the project:

- **flutter_bloc:** State management library.
- **http:** API calls.
- **connectivity_plus:** For detecting online/offline status.
- **hive:** Local storage for offline data.
- **mockito:** For mocking dependencies in unit tests.
- **bloc_test:** BLoC testing utility.

Check the `pubspec.yaml` file for a complete list.

---

## **Key Components**

### **Login Functionality**

- Validates username and password.
- Emits `LoginSuccess` or `LoginFailure` states using BLoC.

### **Send Money**

- Accepts amount as input.
- Makes API call to save the transaction.
- Shows success or failure bottom sheet based on response.

### **Transaction History**

- Fetches transaction data from the server.
- Displays cached data when offline.
- Syncs data upon reconnecting to the internet.

---

## **Offline Mode**

1. **Implementation:**

   - **Hive** is used for local storage.
   - Connectivity is monitored using `connectivity_plus`.

2. **Behavior:**

   - When offline, displays the last fetched wallet balance and transactions.
   - Automatically syncs new transactions when the app reconnects.

---

## **Testing**

### **Unit Tests**

1. **Login Tests:**

   - Validate `LoginBloc` state transitions for successful and failed login attempts.

2. **Send Money Tests:**

   - Test success and failure of API calls for sending money.

3. **Transaction Tests:**

   - Verify fetching and error handling of transactions.

### **Integration Tests**

1. **Login and Navigation:**
   - Test end-to-end functionality for logging in and navigating between screens.

Run the tests with the following commands:

```bash
flutter test
```

---

## **Future Enhancements**

1. **Authentication API Integration:** Replace the placeholder login logic with a real authentication API.
2. **Improved UI:** Add animations and enhanced visual components.
3. **Error Reporting:** Implement a robust error handling and reporting mechanism.

---



