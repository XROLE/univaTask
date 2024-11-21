# Task 1

A simple, functional, and modern Task Manager App built with Flutter, showcases essential features like user authentication, task management, offline support, and smooth transitions from the Login page to the dashboard. 
This project is built with scalability, maintainability, and testability in mind. It demonstrates the use of MVVM architecture, Dependency injection, Modularity and automated code generation (using build runner).<br/>


## Screenshots <br/>
<img src = "https://github.com/user-attachments/assets/99ece383-fad8-47cd-9c10-39f743c1d43a" width="320" /> &nbsp; &nbsp;
<img src = "https://github.com/user-attachments/assets/c1daa65b-e186-4be9-929a-649f97efa7bc" width="320" />
<br/><br/>
<img src = "https://github.com/user-attachments/assets/5a2d8a58-3544-4910-8728-279eb264ee72" width="320" /> &nbsp; &nbsp;
<img src = "https://github.com/user-attachments/assets/1afb210e-2fd3-40ea-9e9c-b96d940a6ec1" width="320" /> 

<br/> 
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

<br>
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
<br>
## Automated Test
1. All the test can be found in:
```
test/
```

2. To run the test
```
flutter test
```

3. To run the test and see the test coverage, follow the three steps below
- run the test with coverage flag
```
flutter test ---coverage
```
- generate html file from the coverage directory generated in the previous step
```
genhtml coverare/lcov.info -o coverage/html
```

- open the generated html file to see the test coverage
```
open coverage/html/index.html
```


<br><br>
# Task 2
Create a function in Dart that organizes tasks by grouping them based on priority and sorting each group by their deadlines in ascending order. The function should return a map where the keys are priorities, and the values are sorted lists of task names.

## Solution
1. The solution to this problem can be found in: 
```
lib/task_2/tast_2.dart
```

2. The solution to the test can be found in:
```
test/task_2/task_2_test.dart
```

3. To run the test:
```
flutter test test/task_2/task_2_test.dart
```

<be><br>
Facing any difficulty? You can contact me here xrolediamond@gmail.com


