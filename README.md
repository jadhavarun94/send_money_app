A Flutter application built using the BLoC architecture, MVVM pattern, and offline/online support. The app features Login, Wallet Management, Transaction History, and Send Money functionality with integration to a fake API. Unit tests and integration tests ensure high-quality code.

Features
Login Screen:
Simple username and password authentication.
Ability to log out from any screen.
Home Screen:
Displays wallet balance with show/hide functionality.
Buttons for navigating to the "Send Money" and "Transaction History" screens.
Send Money Screen:
Allows users to send money by entering an amount.
Displays a bottom sheet indicating success or failure.
Transaction History Screen:
Lists all past transactions.
Offline mode support: Displays cached data when offline and syncs data upon returning online.
Offline Support:
Last fetched data is displayed in offline mode.
Syncs data with the server when back online.
API Integration:
Uses a fake API (JSONPlaceholder) for posting and fetching transaction data.
Unit and Integration Testing:
Thorough tests for Login, Send Money, and Transaction History functionality.

Project Structure
lib/
├── bloc/                    # BLoC files for Login, Send Money, and Transactions
├── models/                  # Data models (e.g., User, Transaction)
├── repository/              # Repository classes for handling API calls
├── screens/                 # UI Screens for Login, Home, Send Money, and Transaction History
├── widgets/                 # Shared widgets
├── utils/                   # Utility functions (e.g., offline mode handling)
├── main.dart                # Entry point of the app

How to Run
Step 1: Prerequisites
Install Flutter: Flutter Installation Guide
Ensure you have an IDE like VS Code or Android Studio.
Step 2: Clone the Repository
git clone https://github.com/jadhavarun94/send_money_app/tree/master 
cd send_money_app
Step 3: Install Dependencies
flutter pub get
flutter pub run build_runner clean
flutter pub run build_runner build –delete-conflicting-output

Step 4: Run the App
flutter run
Step 5: Run Tests
Unit Tests:
flutter test
Integration Tests:
flutter test integration_test/app_test.dart

Dependencies
Below are the major dependencies used in the project:
flutter_bloc: State management library.
http: API calls.
connectivity_plus: For detecting online/offline status.
hive: Local storage for offline data.
mockito: For mocking dependencies in unit tests.
bloc_test: BLoC testing utility.
Check the pubspec.yaml file for a complete list.

