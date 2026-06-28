<div align="center">
 
# 🧮 ScientIQ
 
### A Professional Scientific Calculator Mobile App
 
![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![BLoC](https://img.shields.io/badge/BLoC-State%20Management-blueviolet?style=for-the-badge)
![Clean Architecture](https://img.shields.io/badge/Clean-Architecture-378ADD?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
 
<img src="https://img.shields.io/badge/Platform-Android-3DDC84?style=for-the-badge&logo=android&logoColor=white"/>
<img src="https://img.shields.io/badge/Status-Active-success?style=for-the-badge"/>
 
</div>
 
---
 
## 📱 Overview
 
**ScientIQ** is a professional-grade scientific calculator mobile application built with **Flutter** using **Clean Architecture**, **BLoC state management**, and **local data persistence**. Designed as a real-world production application, ScientIQ goes far beyond basic arithmetic — offering a full suite of scientific, trigonometric, hyperbolic, statistical, and combinatorial functions.
 
> Built as part of the SEN 104 & SEN 214 Mobile Application Development course at **Obafemi Awolowo University, Ile-Ife** — developed to production-grade standards.
 
---
 
## ✨ Features
 
### 🔢 Basic Operations
- Addition, Subtraction, Multiplication, Division
- Percentage calculations
- Decimal support
- Backspace and Clear functionality
 
### 📐 Trigonometric Functions
- `sin`, `cos`, `tan`
- DEG/RAD toggle for angle mode switching
- Accurate degree-to-radian conversion
 
### 🔬 Hyperbolic Functions
- `sinh`, `cosh`, `tanh`
- Manually evaluated using Euler's number for precision
 
### 🧪 Scientific Operations
- `log` (base 10), `ln` (natural log)
- `sqrt` (square root)
- Powers (`^`)
- π (Pi) and e (Euler's number) constants
 
### 🎲 Combinatorics
- Permutations
- Combinations `C(n, r)`
- Factorial `n!`
 
### 📊 History
- Automatic calculation history saved locally
- View all past calculations with timestamps
- Clear history with one tap
 
---
 
## 🏗️ Architecture
 
ScientIQ is built following **Clean Architecture** principles, ensuring separation of concerns, testability, and scalability.
 
```
lib/
├── core/
│   ├── constants/        # App-wide constants
│   ├── errors/           # Failure classes
│   ├── injection/        # Dependency injection (GetIt)
│   ├── router/           # GoRouter navigation
│   ├── theme/            # App theme & colors
│   └── usecases/         # Base use case abstraction
│
├── data/
│   ├── datasources/      # Hive local data source
│   ├── models/           # Hive models with adapters
│   └── repositories/     # Repository implementations
│
├── domain/
│   ├── entities/         # Pure Dart entities
│   ├── repositories/     # Abstract repository contracts
│   └── usecases/         # Business logic use cases
│
└── presentation/
    ├── bloc/             # BLoC events, states, bloc
    ├── pages/            # Calculator & History pages
    └── widgets/          # Reusable UI components
```
 
### Architecture Diagram
 
```
┌─────────────────────────────────────────┐
│           PRESENTATION LAYER            │
│     BLoC │ Pages │ Widgets              │
└──────────────────┬──────────────────────┘
                   │ calls
┌──────────────────▼──────────────────────┐
│             DOMAIN LAYER                │
│    Entities │ Use Cases │ Repositories  │
└──────────────────┬──────────────────────┘
                   │ implements
┌──────────────────▼──────────────────────┐
│              DATA LAYER                 │
│   Models │ DataSources │ Repositories   │
└─────────────────────────────────────────┘
```
 
---
 
## 🛠️ Tech Stack
 
| Technology | Purpose |
|-----------|---------|
| **Flutter** | UI Framework |
| **Dart** | Programming Language |
| **flutter_bloc** | State Management |
| **equatable** | Value Equality |
| **go_router** | Navigation |
| **hive + hive_flutter** | Local Storage |
| **math_expressions** | Expression Evaluation |
| **google_fonts** | Typography |
| **flutter_animate** | Animations |
| **get_it** | Dependency Injection |
| **uuid** | Unique ID Generation |
 
---
 
## 📲 Android Lifecycle Integration
 
ScientIQ is built with full awareness of the **Android Activity Lifecycle**:
 
| Lifecycle Method | How ScientIQ Handles It |
|-----------------|------------------------|
| `onCreate()` | App initializes Hive, registers adapters, sets up DI |
| `onStart()` | Flutter engine starts, widget tree is built |
| `onResume()` | BLoC loads calculation history from local storage |
| `onPause()` | Hive automatically persists all data to disk |
| `onStop()` | App state is preserved via BLoC |
| `onDestroy()` | Hive closes boxes cleanly |
 
---
 
## 🚀 Getting Started
 
### Prerequisites
 
- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`
- Android Studio / VS Code
- Android device or emulator (API 21+)
 
### Installation
 
1. **Clone the repository**
```bash
git clone https://github.com/thefortune-tech/scientific-calculator.git
cd scientific-calculator
```
 
2. **Install dependencies**
```bash
flutter pub get
```
 
3. **Generate Hive adapters**
```bash
dart run build_runner build --delete-conflicting-outputs
```
 
4. **Run the app**
```bash
flutter run
```
 
### Build APK
 
```bash
flutter build apk --release
```
 
The APK will be located at:
```
build/app/outputs/flutter-apk/app-release.apk
```
 
---
 
## 📁 Project Structure
 
```
scientific_calculator/
├── android/                    # Android native files
├── ios/                        # iOS native files
├── lib/
│   ├── core/
│   │   ├── constants/
│   │   │   └── app_constants.dart
│   │   ├── errors/
│   │   │   └── failures.dart
│   │   ├── injection/
│   │   │   └── injection.dart
│   │   ├── router/
│   │   │   └── app_router.dart
│   │   ├── theme/
│   │   │   └── app_theme.dart
│   │   └── usecases/
│   │       └── usecase.dart
│   ├── data/
│   │   ├── datasources/
│   │   │   └── calculator_local_datasource.dart
│   │   ├── models/
│   │   │   ├── calculation_model.dart
│   │   │   └── calculation_model.g.dart
│   │   └── repositories/
│   │       └── calculator_repository_impl.dart
│   ├── domain/
│   │   ├── entities/
│   │   │   └── calculation.dart
│   │   ├── repositories/
│   │   │   └── calculator_repository.dart
│   │   └── usecases/
│   │       ├── clear_history.dart
│   │       ├── evaluate_expression.dart
│   │       ├── get_history.dart
│   │       └── save_calculation.dart
│   ├── presentation/
│   │   ├── bloc/
│   │   │   ├── calculator_bloc.dart
│   │   │   ├── calculator_event.dart
│   │   │   └── calculator_state.dart
│   │   ├── pages/
│   │   │   ├── calculator_page.dart
│   │   │   └── history_page.dart
│   │   └── widgets/
│   │       ├── calculator_button.dart
│   │       ├── calculator_display.dart
│   │       ├── history_item.dart
│   │       └── scientific_panel.dart
│   └── main.dart
├── test/
│   ├── unit/
│   └── widget/
├── .github/
│   └── workflows/
│       └── ci.yml
├── pubspec.yaml
└── README.md
```
 
---
 
## 🧪 Testing
 
### Run all tests
```bash
flutter test
```
 
### Run unit tests only
```bash
flutter test test/unit/
```
 
### Run widget tests only
```bash
flutter test test/widget/
```
 
---
 
## 🔄 CI/CD Pipeline
 
ScientIQ uses **GitHub Actions** for continuous integration. Every push to `main` automatically:
 
1. ✅ Runs Flutter analyzer
2. ✅ Executes all unit and widget tests
3. ✅ Builds a release APK
4. ✅ Uploads the APK as a build artifact
 
See `.github/workflows/ci.yml` for the full pipeline configuration.
 
---
 
## 🤝 Contributing
 
Contributions are welcome! Please follow these steps:
 
1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'feat: add AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request
 
---
 
## 👨‍💻 Author
 
**Fortune Adeyemi Adeboye**
- GitHub: [@thefortune-tech](https://github.com/thefortune-tech)
- YouTube: [@Fortune_Dev](https://youtube.com/@Fortune_Dev)
 
---
 
## 📄 License
 
This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.
 
---
 
<div align="center">
Built with ❤️ using Flutter
</div>
 