# 🧪 Rick & Morty App

A Flutter mobile application for exploring characters from the **Rick and Morty** universe.

The app consumes data from the **Rick and Morty API** and uses **BLoC** for state management and **Dio** for handling HTTP requests.

## ✨ Features

* 🧪 Browse Rick and Morty characters
* 👤 View character information
* 🌐 Fetch data from the Rick and Morty API
* 🔄 State management using BLoC
* 📡 Handle network connectivity
* 🎨 SVG asset support
* 📱 Responsive Flutter UI
* ⚡ Clean separation between UI, business logic, and data handling

## 🛠️ Tech Stack

| Technology          | Purpose                              |
| ------------------- | ------------------------------------ |
| **Flutter**         | Cross-platform mobile development    |
| **Dart**            | Programming language                 |
| **BLoC**            | State management                     |
| **Dio**             | HTTP requests and API communication  |
| **Flutter BLoC**    | Connecting BLoC with Flutter widgets |
| **connectivity_plus** | Network connectivity handling        |
| **Flutter SVG**     | Rendering SVG assets                 |

## 🌐 API

This project uses the **Rick and Morty API** to retrieve character data.

API documentation:

https://rickandmortyapi.com/

## 🏗️ Project Structure

The project follows a layered structure to keep the application organized and easier to maintain.

```text
lib/
├── constants/
├── data/
├── logic/
├── presentation/
└── ...
```

### Main Layers

**Data**

Responsible for working with API responses and application models.

**Logic**

Contains BLoC/Cubit classes responsible for managing application state and business logic.

**Presentation**

Contains screens and widgets responsible for displaying the application's UI.

**Constants**

Contains reusable constants such as colors and other application-wide values.

## 📦 Dependencies

The project uses the following main packages:

```yaml
bloc: ^9.1.1
dio: ^5.11.1
flutter_bloc: ^9.1.1
connectivity_plus: ^7.3.1
flutter_svg: ^2.3.0
meta: ^1.18.3
```

## 🚀 Getting Started

### Prerequisites

Make sure you have the following installed:

* Flutter SDK
* Dart SDK
* Android Studio or VS Code
* An Android emulator, physical Android device, or iOS simulator

You can verify your Flutter installation with:

```bash
flutter doctor
```

### Installation

Clone the repository:

```bash
git clone https://github.com/MohamedAbdAlmawjoud/Rick-Morty.git
```

Navigate to the project directory:

```bash
cd Rick-Morty
```

Install the dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

## 📱 Build APK

To create a release APK:

```bash
flutter build apk --release
```

For smaller APK files targeting specific CPU architectures:

```bash
flutter build apk --release --split-per-abi
```

The generated APK files can be found inside:

```text
build/app/outputs/flutter-apk/
```

## 🧪 Development

This project was built as a Flutter practice project to explore:

* REST API integration
* HTTP requests with Dio
* BLoC/Cubit state management
* Flutter UI development
* Network connectivity handling
* Working with API models
* Organizing a Flutter application into separate layers

## 🔮 Future Improvements

Possible improvements for future versions include:

* 🔍 Character search
* ⭐ Favorite characters
* 📄 Pagination
* 🎭 Character filtering
* 📺 Episode information
* 🌍 Location information
* 💾 Local caching
* 🌙 Theme customization
* 🧪 More automated tests

## 📸 Screenshots

Screenshots of the application will be added here.

```text
Coming soon...
```

## 📚 What I Learned

While building this project, I practiced working with:

* Flutter and Dart
* REST APIs
* Dio
* BLoC and Cubit
* Asynchronous programming
* JSON/API data handling
* Network connectivity
* Flutter project organization
* Reusable widgets and UI components

## 👨‍💻 Author

**Mohamed Abd Al Mawjoud**

Flutter Developer

GitHub:
https://github.com/MohamedAbdAlmawjoud

Mail:
mohamedabdalmawjoudd@gmail.com

---

⭐ If you find this project useful, feel free to star the repository!
