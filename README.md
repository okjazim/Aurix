# AURIX

Aurix is a high-performance digital gold savings application built with Flutter. This project was developed within a **24-hour technical window** to demonstrate proficiency in clean architecture, persistent state management, and interactive financial UI for technical evaluation.

---

## Tech Stack
* **Framework:** [Flutter 3.x](https://flutter.dev/)
* **State Management:** [Riverpod 2.5.1](https://riverpod.dev/) — Chosen for its reactive, unidirectional data flow and superior testability.
* **Navigation:** [GoRouter](https://pub.dev/packages/go_router) — Declarative routing with deep-link support.
* **Data Persistence:** [Shared Preferences](https://pub.dev/packages/shared_preferences) — Local storage with JSON serialization for wallet and history.
* **Data Visualization:** [fl_chart](https://pub.dev/packages/fl_chart) — Interactive, touch-responsive portfolio trends.
* **Formatting:** [Intl](https://pub.dev/packages/intl) — Professional currency and date localization.

---

## Features
* **Persistent Authentication:** Full Login/Register flow. Once authenticated, the session is saved locally to bypass the login screen on restart.
* **Interactive Dashboard:** Real-time calculation of gold-to-EUR value with a "fintech-style" growth chart.
* **Gold Trading Engine:**
  * **Buy:** Instant conversion of EUR balance to Gold Grams.
  * **Sell:** Conversion of Grams back to EUR with real-time balance validation.
* **Transaction History:** A persistent, color-coded log (Green for Buys, Red for Sells) of every trade made within the app.
* **Premium UX:** Hero animations for the brand logo and optimized chart interaction (slope tracking tooltips).

---

## Setup Instructions
1.  **Clone the repository:**
    ```powershell
    git clone [https://github.com/okjazim/Aurix.git](https://github.com/okjazim/Aurix.git)
    ```
2.  **Install dependencies:**
    ```powershell
    flutter pub get
    ```
3.  **Generate Launcher Icons:**
    ```powershell
    flutter pub run flutter_launcher_icons
    ```
4.  **Run the application (Release mode recommended for performance):**
    ```powershell
    flutter run --release
    ```

---

## Usage
* **New User:** Start by registering a new account via the Registration screen.
* **Initial Capital:** For testing purposes, new accounts are initialized with a mock balance of **€1,000.00**.
* **Trading:** Use the "Buy" button to exchange EUR for gold at the mock rate of **€65/g**.
* **Tracking:** Slide your finger across the dashboard chart to see specific portfolio values at different points in time via the interactive tooltip.

---

## Screenshots / Video Demo
> *[Insert Screenshots or Video Link here]*
> *(Note: The generated APK is included in the GitHub Releases section for immediate evaluation).*

---

## File Structure
```
lib/
├── core/           # AppRouter, Validators, and AppColors constants
├── features/       # Feature-First Architecture (Auth, Dashboard, Trade, History)
│   ├── auth/       # Login and Registration screens
│   ├── dashboard/  # Portfolio overview and Interactive Chart
│   ├── history/    # Transaction List UI
│   └── trade/      # Buy/Sell input logic
├── models/         # Transaction and User Wallet data classes (JSON mapping)
├── providers/      # Riverpod Notifiers & State providers (Business Logic)
├── services/       # StorageService (Shared Preferences Persistence Logic)
└── main.dart       # App Entry & Initial Persistence Check
```

---

## Enhancement Roadmap
* **Live Market Integration:** Replace mock values with real-time data from a Gold Price API.
* **Biometric Security:** Add FaceID/Fingerprint unlock capabilities for wallet access.
* **Advanced Analytics:** Detailed breakdown of Profit/Loss per transaction over different timeframes.
* **Cloud Sync:** Transition from local storage to a Firebase or Supabase backend.

---

## Contribution
This project was developed as a one-time technical evaluation task. While it is a completed submission, feedback or educational pull requests are welcome.

---

## Important Note
* **Evaluation Focus:** Every requirement of the 24-hour brief (Login, Dashboard, Buy/Sell Logic, History, and State Management) has been met.
* **Assumptions Made:** The gold price is fixed at **€65/g** for this version. The portfolio chart currently uses a mocked 7-day trend to demonstrate UI interactivity and slope-tracking capabilities.
* **Logic Correctness:** The app includes strict validation to prevent selling gold that does not exist in the user's wallet and ensures all fields are validated before processing trades.

---

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for the full text.

---

## References
* [Flutter Documentation](https://docs.flutter.dev/)
* [Riverpod Best Practices](https://riverpod.dev/docs/introduction/getting_started)
* [fl_chart Library](https://flchart.dev/)
