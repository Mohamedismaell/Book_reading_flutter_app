## 📖  Book Reading App (Flutter)

A modern Book Reading and Listening application built with Flutter.  
The project focuses on clean architecture, scalable theming, and real-world production practices.

---

## Project Status

**Current Phase:** Core Setup and Theming Architecture  
**Development Status:** Active

This application is being developed step by step with emphasis on maintainability, performance, and scalability.

---

## App Goals

### Main Objectives
- Read digital books
- Listen to audiobooks
- Favorite and organize books
- Track reading and listening progress
- Secure authentication using Supabase
- Fully customizable light and dark themes

---

## Current Progress

### Completed
- Flutter project structure setup
- Clean architecture organization
- Advanced theming system
  - Light and dark ColorScheme
  - Centralized ThemeData
  - Custom TextTheme
  - Theme switching using Cubit (Bloc)
- Theme extensions for easy access via BuildContext
- Responsive UI setup using flutter_screenutil
- Authentication UI components
- Initial Supabase authentication integration

### In Progress
- Theme refinement (global vs component-level colors)
- Authentication flow improvements and route guards
- UI consistency across all screens
- Reusable shared widgets library

---

## Tech Stack

### Frontend
- Flutter
- Dart
- Material 3
- Responsive layouts

### State Management
- Bloc / Cubit

### Backend and Services
- Supabase (authentication, database, storage)

### Navigation and Utilities
- GoRouter
- Flutter ScreenUtil
- Clean Architecture principles

---

## Project Structure (Simplified)

```text
lib/
│
├── core/
│   ├── theme/
│   │   ├── app_colors.dart
│   │   ├── app_text_theme.dart
│   │   ├── theme_cubit.dart
│   │   └── theme_extensions.dart
│   │
│   ├── routes/
│   └── utils/
│
├── features/
│   ├── auth/
│   ├── home/
│   └── reader/
│
└── main.dart
Roadmap
Short Term

Complete authentication flow

Implement auth guards using GoRouter

Book listing screen

Favorite books feature

Mid Term

Audiobook support

Reading and listening statistics

Notes and highlights

Search and filtering

Long Term

Smart reading analytics

AI-based book recommendations

Offline support with cloud sync

Localization and multi-language support

Design Direction

Clean and minimal UI

Smooth animations

Light and dark mode parity

Mobile and tablet responsive layouts

Purpose of This Project

Demonstrate real-world Flutter architecture

Apply scalable theming strategies

Practice production-level state management

Serve as a strong portfolio project

Author

Mohamed Ismael
Flutter Developer
Egypt

Status

This project is actively maintained and continuously improved.

If you want next:
- A **short GitHub repo description**
- A **commit message style guide**
- `CONTRIBUTING.md`
- `CHANGELOG.md`
- GitHub badges section

Tell me what to add and I’ll format it the same way.
