# Bookly - Modern Book Reading App

[![Flutter](https://img.shields.io/badge/Flutter-3.9.2-blue.svg)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.x-blue.svg)](https://dart.dev/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A premium, cross-platform book discovery and reading application built with Flutter. Bookly offers a seamless user experience for exploring new titles, managing your digital library, and tracking your reading progress with a modern, high-performance interface.

---

## ✨ Features

- **Personalized Home**: Discover trending books and recommendations tailored to your tastes.
- **Deep Exploration**: Search and browse books by categories and authors using a sleek search experience.
- **Personal Library**: Keep track of your favorite books and manage your bookmarks efficiently.
- **Advanced Reader**: A comfortable reading interface designed for focus and ease of use.
- **Cloud Sync**: Secure authentication using Supabase with support for Google Sign-In.
- **Responsive Design**: Pixel-perfect UI that scales beautifully across all device sizes using `flutter_screenutil`.
- **Offline First**: Robust connectivity handling and local caching using Hive for an uninterrupted experience.
- **Dynamic Theming**: Elegant light and dark modes with smooth transitions.

---

## 🚀 Tech Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **State Management**: [BLoC](https://bloclibrary.dev/) & [Hydrated BLoC](https://pub.dev/packages/hydrated_bloc) for persistent state.
- **Navigation**: [GoRouter](https://pub.dev/packages/go_router) for declarative routing.
- **Backend & Auth**: [Supabase](https://supabase.com/) & [Google Sign-In](https://pub.dev/packages/google_sign_in).
- **Local Database**: [Hive](https://pub.dev/packages/hive) for high-performance local storage.
- **Dependency Injection**: [GetIt](https://pub.dev/packages/get_it).
- **Networking**: [Dio](https://pub.dev/packages/dio) with custom retry logic and interceptors.
- **UI/UX**: `skeletonizer`, `shimmer`, `flutter_svg`, `animations`, `glaze_nav_bar`.

---

## 🏗️ Architecture

The project follows a **Clean Architecture** approach, ensuring separation of concerns, testability, and scalability.

```
lib/
├── core/             # Shared utilities, themes, global widgets, and navigation
│   ├── connections/  # Network connectivity and retry logic
│   ├── database/     # Local storage (Hive/SharedPreferences)
│   ├── shared/       # Domain/Data/Presentation layers for global features
│   └── theme/        # Design system and theme management
└── features/         # Feature-specific modules
    ├── auth/         # Authentication flow
    ├── book/         # Book details and reading logic
    ├── home/         # Home screen and discovery
    ├── library/      # User's personal collection
    └── ...           # explore, profile, onboarding, etc.
```

---

## 🛠️ Getting Started

### Prerequisites

- Flutter SDK (>= 3.9.2)
- Dart SDK
- A Supabase account for backend services

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Mohamedismaell/Book_reading_flutter_app.git
   cd Book_reading_flutter_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate needed files**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the application**
   ```bash
   flutter run
   ```

---

## 📸 Screenshots

*(Add your screenshots here)*

---

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.

---

## 🤝 Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

Created with ❤️ by [Mohamed Ismael](https://github.com/Mohamedismaell)
