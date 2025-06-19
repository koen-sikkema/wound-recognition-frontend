# Wound-Recognition Frontend

Flutter‐powered mobile & web client for the **Wound Recognition POC** — a demo app exploring how AI can support wound-care professionals by classifying wound images automatically.

<p align="center">
  <img src="docs/screenshot_upload_page.png" width="280"/>
  <img src="docs/screenshot_result_page.png" width="280"/>
</p>

---

## ✨ Key Features

| Feature | Description | Related requirements |
|---------|-------------|----------------------|
| **Image picker** | Select from gallery or open device camera | F1, F6 |
| **Secure upload** | Sends image to FastAPI backend via `MultipartRequest` | F2 |
| **Async polling** | Polls backend every second until classification ready | F3–F5 |
| **Prediction viewer** | Displays label, confidence & timestamp in a `PredictionCard` | F4, F5 |
| **Local history** | Saves predictions in `SharedPreferences`; supports delete | F7, F9 |
| **Remote history** | Retrieves all predictions from backend on demand | F8 |
| **Responsive UI** | Works on Android, iOS and web (Chrome, Edge, …) | — |

---

## 🏗️ Project Structure

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

Edit **`lib/constants/app_constants.dart`**

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

> This POC focuses on backend test coverage.  
> Front-end functionality was manually verified (navigation, upload, polling, local storage).  
> Future work: add `flutter_test` widget tests and `integration_test` E2E flows.

---

## 📚 Documentation

- **Software Architectuur Document (SAD)** — full C4 model, code views, test strategy
- **Backend repo** – FastAPI service & ML pipeline  
  <https://github.com/koen-sikkema/wound-recognition-backend>

---

## 📝 License

This project is released under the **MIT License** — see [`LICENSE`](LICENSE) for details.

---

> _Made with ❤️ during a Health-Hub Roden internship — exploring AI innovations in wound care._