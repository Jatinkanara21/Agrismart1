# AgriSmart 🌱

**Smart Farming. Better Harvest.**

A production-style Flutter agriculture dashboard for crop management, farm monitoring, weather intelligence, AI disease scanning, recommendations, and agricultural market insights.

## Included

- Animated splash and 3-step onboarding
- Login, registration and forgot-password flows
- Material 3 responsive UI
- Light/dark theme support
- Farmer dashboard with weather and farm overview
- Crop management with progress and crop details
- Camera/gallery disease scanning UI with mock AI result
- Weather dashboard and farming recommendations
- Agricultural market prices and trend chart
- Farm management
- Notifications with read/unread indicators
- Profile and preferences
- Pull-to-refresh and loading states
- Mock data with backend-ready service contracts

## Run

```bash
flutter pub get
flutter run
```

For web:

```bash
flutter build web --release
```

## Backend roadmap

The service contracts in `lib/services/backend_contract.dart` are ready to be implemented with Firebase Authentication, Firestore, Storage, a weather API, a disease ML/API service, market APIs, and push notifications.

## Structure

```text
lib/
├── main.dart
├── app.dart
├── core/theme/
├── models/
├── providers/
├── services/
├── widgets/
└── screens/
    ├── splash/
    ├── onboarding/
    ├── auth/
    ├── home/
    ├── crops/
    ├── disease_detection/
    ├── weather/
    ├── market/
    ├── farm/
    ├── notifications/
    └── profile/
```
