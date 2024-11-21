# Mini Task Manager App

A simple, functional, and modern Task Manager App built with Flutter, showcasing essential features like user authentication, task management, offline support, and smooth transitions from the Login page to the dashboard. 
This project is built with scalability, maintanability and testability in mind. It demostrates the use of MVVM architecture, Dependency injection, Modularity and automated code generation (using build runner).

## Screenshots
<img src = "https://github.com/user-attachments/assets/99ece383-fad8-47cd-9c10-39f743c1d43a" width="320"/> &nbsp; &nbsp;
<img src = "https://github.com/user-attachments/assets/5a2d8a58-3544-4910-8728-279eb264ee72" width="320"/> \n\n;
<img src = "https://github.com/user-attachments/assets/c1daa65b-e186-4be9-929a-649f97efa7bc" width="320"/>


## Features
1. Login Screen
Secure login functionality with email and password.
Input validation for email format and a minimum password length of 6 characters.
Mock API integration to simulate login.
2. Task Dashboard
Displays a paginated list of tasks fetched from a mock API.
Users can mark tasks as Complete or Incomplete.
Includes Pull to Refresh functionality for seamless task updates.
3. State Management
Powered by Provider or Riverpod to efficiently manage application state.
4. Offline Caching
Stores task lists locally using Hive or SharedPreferences to ensure functionality when offline.
5. Transitions and Animations
Smooth and visually appealing transition animations between the login screen and the task dashboard.
6. Testing
Comprehensive testing:
Unit tests for core functionality.
Widget tests for key components.


## Getting Started

Ensure you have the following installed:

- Flutter SDK
- Dart
- An IDE such as VS Code or Android Studio.

### Installation
1. Clone the repository:
```
git clone https://github.com/XROLE/univaTask.git
cd mini-task-manager 
```

2. Fetch the dependencies:
``` 
flutter pub get 
```

3. Run code generation:
``` 
flutter pub run build_runner build --delete-conflicting-outputs 
```

4. Run the app:
``` 
flutter run 
```


