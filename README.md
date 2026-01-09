## Backend API
Source code: https://github.com/TranDucNam17/magicenglish-api

# 📚 Magic English - Flutter Application

> **A comprehensive English learning application** with AI-powered grammar checking, vocabulary management, progress tracking, and interactive practice features.

![Flutter](https://img.shields.io/badge/Flutter-3.9.2-blue)
![Dart](https://img.shields.io/badge/Dart-3.9.2-blue)
![License](https://img.shields.io/badge/License-MIT-green)

---

## 🎯 Overview

**Magic English** is a mobile learning platform designed to help users improve their English skills through:
- 📝 **Grammar Checking** - AI-powered grammar and style analysis with CEFR level detection
- 📖 **Vocabulary Management** - Learn and manage English words with CEFR levels
- 📊 **Progress Tracking** - Monitor learning progress with achievements and streaks
- 🤖 **AI Assistant** - Interactive AI chatbot for English learning support
- 🎮 **Practice Modules** - Interactive exercises and practice sessions
- 🔔 **Notifications** - Reminders and learning notifications

---

## 📂 Project Structure

```
lib/
├── core/                    # Core utilities and shared code
│   ├── api/           
│   ├── config/          # Dart extensions
│   ├── services/          
│
├── features/                # Feature modules (Clean Architecture)
│   ├── achievements/        # User achievements & badges
│   ├── ai_assistant/        # AI chatbot integration
│   ├── auth/                # Authentication & login
│   ├── common/               
│   ├── dashboard/           # Home dashboard
│   ├── grammar/             # Grammar checker module
│   │   ├── data/            # API services & repositories
│   │   └── presentation/    # UI screens & state management
│   ├── notifications/       # Notification system
│   ├── onboarding/          # App onboarding flow
│   ├── practice/            # Practice exercises
│   ├── profile/             # User profile management
│   ├── progress/            # Learning progress tracking
│   ├── settings/            # App settings
│   ├── splash/              # Splash screen
│   ├── streak/              # Learning streaks
│   ├── systems/             # Core app systems
│   └── vocab/               # Vocabulary management
│       ├── data/            # Word API services
│       └── presentation/    # Word UI screens
│
└── main.dart               # App entry point
```

---

## ✨ Key Features

### 1️⃣ **Grammar Checker Module** ✍️
- **Text Analysis**: Submit text for grammar and style checking
- **CEFR Levels**: Automatic detection of English proficiency levels (A1-C2)
- **Grammar Tips**: Learn from 5 major grammar rules with examples
- **History**: Track all grammar checks with search and filtering
- **Real-time Feedback**: Instant suggestions and corrections

**Supported Levels**: A1, A2, B1, B2, C1, C2

### 2️⃣ **Vocabulary Management** 📚
- **Add Words**: Create custom word entries with definitions
- **AI Enrichment**: Automatic CEFR level detection via API
- **Magic View**: Special vocabulary learning interface
- **Word Lists**: Organize and categorize your vocabulary

### 3️⃣ **AI Assistant** 🤖
- **Chat Interface**: Interactive conversations with AI for learning
- **Gemini Integration**: Google Gemini API for intelligent responses
- **Context Awareness**: Learn based on conversation history

### 4️⃣ **Progress & Analytics** 📊
- **Achievement System**: Earn badges and rewards
- **Learning Streaks**: Track consecutive learning days
- **Progress Dashboard**: Visual representation of learning metrics
- **Stats Overview**: View overall learning statistics

### 5️⃣ **Practice & Exercises** 🎮
- **Interactive Modules**: Engage with various practice activities
- **Skill Building**: Target specific English skills
- **Performance Metrics**: Track improvement over time

---

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK**: 3.9.2 or higher
- **Dart SDK**: 3.9.2 or higher
- **Mobile Device/Emulator**: Android or iOS
- **Backend Server**: Magic English API (Laravel)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/TranDucNam17/MAGIC-ENGLISH.git
   cd Frontend/btl_magicenglish
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure API endpoint**
   
   Edit [lib/core/services/api_service.dart](lib/core/services/api_service.dart):
   ```dart
   const String baseUrl = 'http://your-api-url:8000/api';
   ```

4. **Run the application**
   ```bash
   flutter run
   ```

### Platform-Specific Setup

**Android:**
```bash
flutter run -d android
```

**iOS:**
```bash
flutter run -d ios
```

**Web:**
```bash
flutter run -d chrome
```

---

## 📦 Dependencies

### Core Dependencies
- **http**: ^1.1.0 - HTTP client for API requests
- **shared_preferences**: ^2.2.0 - Local data persistence
- **flutter**: SDK - Flutter framework
- **cupertino_icons**: ^1.0.8 - iOS style icons

### UI & Charts
- **fl_chart**: ^0.68.0 - Beautiful charts and graphs
- **clipboard**: ^0.1.3 - Clipboard operations

### Utilities
- **uuid**: ^4.0.0 - UUID generation

### Dev Dependencies
- **flutter_lints**: ^5.0.0 - Lint rules
- **flutter_test**: SDK - Testing framework

---

## 🏗️ Architecture

This project follows **Clean Architecture** principles:

```
Presentation Layer
    ↓ (depends on)
Domain Layer (Business Logic)
    ↓ (depends on)
Data Layer (Repositories & API)
```

### Layer Responsibilities

**Presentation Layer** (`presentation/`)
- UI Screens (Pages)
- State Management
- User Interactions

**Data Layer** (`data/`)
- API Services
- Repository Implementations
- Network Requests

**Core Layer** (`core/`)
- Shared Utilities
- Constants
- Custom Widgets
- Services

---

## 🔌 API Integration

### Grammar Checker API

**Endpoint**: `POST /api/grammar/check`

```dart
final response = await grammarApiService.checkGrammar(
  text: 'Your text here'
);
// Returns: { errors: [...], cefr_level: 'B1', suggestions: [...] }
```

### Word Enrichment API

**Endpoint**: `POST /api/words/enrich`

```dart
final enrichedWord = await aiEnrichService.enrich(
  text: 'example'
);
// Returns: { cefr: 'B1', definition: '...', examples: [...] }
```

---

## 🎨 UI Components

### Reusable Widgets
Located in [lib/core/widgets/](lib/core/widgets/)

- Custom buttons
- Input fields with validation
- Loading indicators
- Error dialogs
- Navigation bars

### Theming
Centralized theme configuration with:
- Color schemes
- Typography
- Component styles

---

## 💾 Local Storage

Using **SharedPreferences** for:
- User preferences
- Cache data
- Offline storage
- Settings persistence

---

## 🧪 Testing

### Run Tests
```bash
flutter test
```

### Test Coverage
```bash
flutter test --coverage
```

---

## 🐛 Troubleshooting

### Common Issues

**Problem**: API connection refused
```
Solution: Verify backend server is running at configured URL
```

**Problem**: Flutter not found
```
Solution: flutter pub get && flutter clean
```

**Problem**: Build errors
```
Solution: flutter pub upgrade --major-versions
```

### Debug Mode

Enable detailed logging:
```dart
// In main.dart
import 'dart:developer' as developer;
developer.Timeline.startSync('Your event');
```

---

## 📱 Supported Platforms

| Platform | Status | Min Version |
|----------|--------|------------|
| Android  | ✅ Supported | API 21+ |
| iOS      | ✅ Supported | iOS 11+ |
| Web      | ✅ Supported | Latest |
| Windows  | ⚠️ Partial | Windows 10+ |
| macOS    | ⚠️ Partial | macOS 10.11+ |
| Linux    | ⚠️ Partial | Ubuntu 18+ |

---

## 📚 Documentation

For detailed guides, see:

- [Week 7 FR1 Setup Guide](../../WEEK7_FR1_SETUP_GUIDE.md) - Initial setup instructions
- [Grammar Checker Documentation](../../README_GRAMMAR_CHECKER.md) - Grammar module details
- [Code Structure Guide](../../CODE_STRUCTURE_GUIDE.md) - Architecture overview
- [Database Schema](../../DATABASE_SCHEMA_DESIGN.md) - Backend schema details

---

## 🔒 Security Considerations

- Never commit API keys or secrets
- Use environment variables for sensitive data
- Validate all user inputs
- Sanitize API responses

---

## 🤝 Contributing

1. Create a feature branch: `git checkout -b feature/YourFeature`
2. Commit your changes: `git commit -m 'Add YourFeature'`
3. Push to the branch: `git push origin feature/YourFeature`
4. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

## 👥 Author

**Tran Duc Nam**
- GitHub: [@TranDucNam17](https://github.com/TranDucNam17)
- Email: your.email@example.com

---

## 🙏 Acknowledgments

- Flutter & Dart teams
- Google Gemini AI
- LanguageTool API
- Ollama for local LLM

---

## 📞 Support

For issues and questions:
- 📧 Email: your.email@example.com
- 🐛 Report bugs in Issues section
- 💬 Start discussions for feature requests

---

## 📝 Changelog

### Version 1.0.0 (Current)
- ✅ Grammar Checker module
- ✅ Vocabulary management
- ✅ AI Assistant integration
- ✅ Progress tracking
- ✅ Achievement system
- ✅ Practice modules

---

**Last Updated**: January 2026
**Status**: 🟢 Active Development
