# Wound-Recognition Frontend

Flutter‐powered mobile & web client for the **Wound Recognition POC** — a demo app exploring how AI can support wound-care professionals by classifying wound images automatically.

---

## ✨ Key Features

| Feature               | Description                                                  | Related requirements |
| --------------------- | ------------------------------------------------------------ | -------------------- |
| **Image picker**      | Select from gallery or open device camera                    | F1, F6               |
| **Secure upload**     | Sends image to FastAPI backend via `MultipartRequest`        | F2                   |
| **Async polling**     | Polls backend every second until classification ready        | F3–F5                |
| **Prediction viewer** | Displays label, confidence & timestamp in a `PredictionCard` | F4, F5               |
| **Local history**     | Saves predictions in `SharedPreferences`; supports delete    | F7, F9               |
| **Remote history**    | Retrieves all predictions from backend on demand             | F8                   |
| **Responsive UI**     | Works on Android, iOS and web (Chrome, Edge, …)              | —                    |

---

## 📇 Project Structure

```
lib/
 ├─ main.dart                 # App entry point, theme & routing init
 ├─ routes/                   # Declarative GoRouter setup
 ├─ pages/                    # Upload, result, history, predictions
 ├─ services/                 # API, storage, image picker abstractions
 ├─ widgets/                  # Reusable UI components
 ├─ theme/                    # Centralised colours & typography
 └─ constants/                # API endpoints, fixed strings
```

> For an in-depth architectural view (C4 component & code diagrams) see the **Software Architectuur Document** in `/docs`.

---

## 🚀 Getting Started

### Prerequisites

- **Flutter 3.19+** – [install guide](https://docs.flutter.dev/get-started/install)
- A running instance of the [wound-recognition-backend](https://github.com/koen-sikkema/wound-recognition-backend)

### 1. Clone & install

```bash
git clone https://github.com/koen-sikkema/wound-recognition-frontend.git
cd wound-recognition-frontend
flutter pub get
```

### 2. Configure API endpoint

Edit ``

```dart
class AppConstants {
  // Change if backend runs on a different host/port
  static const String BASE_URL = 'http://localhost:8000';
}
```

### 3. Run (mobile or web)

```bash
# Android/iOS
flutter run

# Web
flutter run -d chrome
```

---

## 🧪 Tests

> This POC focuses on backend test coverage.\
> Front-end functionality was manually verified (navigation, upload, polling, local storage).\
> Future work: add `flutter_test` widget tests and `integration_test` E2E flows.

---

## 📚 Documentation

- **Software Architectuur Document (SAD)** — full C4 model, code views, test strategy
- **Backend repo** – FastAPI service & ML pipeline\
  [https://github.com/koen-sikkema/wound-recognition-backend](https://github.com/koen-sikkema/wound-recognition-backend)

---

## 📦 Build & Install APK (Android – without Play Store)

Want to install the app directly on your Android device and connect it to your own backend?\
Follow these steps to build and install a custom APK:

### 🔧 1. Clone the repository

```bash
git clone https://github.com/koen-sikkema/wound-recognition-frontend.git
cd wound-recognition-frontend
flutter pub get
```

---

### ✏️ 2. Configure the backend URL

Edit the file:

```
lib/constants/app_constants.dart
```

Replace the default base URL with the actual location of your backend:

```dart
static const String BASE_URL = 'http://your-server-ip:8000';
```

Example: `http://192.168.1.100:8000` if your backend runs on another machine in the same network.

---

### 🏗️ 3. Build the release APK

```bash
flutter build apk --release
```

This creates a production-ready APK at:

```
build/app/outputs/flutter-apk/app-release.apk
```

---

### 📲 4. Install the APK on your Android device

- Transfer the APK to your phone (via USB, email, or cloud storage).
- Open the file on your device.
- Allow installation from "unknown sources" when prompted.
- Tap **Install** and launch the app.

> 💡 Make sure your backend is reachable from your device and allows CORS requests.

---

## 📝 License

This project is released under the **MIT License** — see [`LICENSE`](LICENSE) for details.

---

> 👤 **Author**: Koen Sikkema\
> 🧑‍🏫 **Supervised by**: Egbert Wiltens, on behalf of [**Health Hub Roden**](https://www.health-hub.eu/home)

