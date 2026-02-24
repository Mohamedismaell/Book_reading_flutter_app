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

## Tech Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **State Management**: [BLoC](https://bloclibrary.dev/) & [Hydrated BLoC](https://pub.dev/packages/hydrated_bloc) for persistent state.
- **Navigation**: [GoRouter](https://pub.dev/packages/go_router) for declarative routing.
- **Backend & Auth**: [Supabase](https://supabase.com/) & [Google Sign-In](https://pub.dev/packages/google_sign_in).
- **Local Database**: [Hive](https://pub.dev/packages/hive) for high-performance local storage.
- **Dependency Injection**: [GetIt](https://pub.dev/packages/get_it).
- **Networking**: [Dio](https://pub.dev/packages/dio) with custom retry logic and interceptors.
- **UI/UX**: `skeletonizer`, `shimmer`, `flutter_svg`, `animations`, `glaze_nav_bar`.

---

## Architecture

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
    └── explore/      # Search & categories
    └── profile/      # User profile management
```

---

## Getting Started

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

<markdown-accessiblity-table data-catalyst=""><table>
## Screenshots

<p align="center">
  <img src="mocks/dark/Screenshot_1771917082-portrait.png" width="230"/>
  <img src="mocks/dark/Screenshot_1771917100-portrait.png" width="230"/>
   <img src="https://github.com/user-attachments/assets/665d8806-d2a3-4d43-a8bb-de2a79f4d61d" width="230"/>
</p>


<p align="center">
  <img src="https://github.com/user-attachments/assets/459a721c-6402-48c4-b2f0-09eeeb049f31" width="230"/>
  <img src="https://github.com/user-attachments/assets/ea6fcc83-711d-4d5c-ad57-9e8ac6c08fdb" width="230"/>
  <img src="https://github.com/user-attachments/assets/32cc7199-3d18-4ffe-8a36-89eb97c90878" width="230"/>
</p>
<p align="center">
  <img src="https://github.com/user-attachments/assets/ef457a19-74ff-4ba0-b544-89485751d5e3" width="230"/>
  <img src="https://github.com/user-attachments/assets/14f18b3c-b389-452f-8405-06bb23ad3946" width="230"/>
    <img src="https://github.com/user-attachments/assets/f72bd21d-c7b2-442e-8a56-15a767b5d822" width="230"/>
</p>
<p align="center">
  <img src="https://github.com/user-attachments/assets/ccbf4eff-1487-48ca-8a9b-8c7d32c4940d" width="230"/>
  <img src="https://github.com/user-attachments/assets/681303fb-6f39-42f5-9b5b-713a82052edc" width="230"/>
    <img src="https://github.com/user-attachments/assets/526318e0-dd73-45f8-abb1-375fba0d87ff" width="230"/>
</p>


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