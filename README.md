# UTS Mobile Development - Data-Driven Architecture

**GitHub Repository Link:** [Insert your GitHub Link Here]

## 📁 Folder Structure (Modular Architecture)
To ensure clean code and scalable architecture (CPMK 1), this project is strictly organized into separated layers:

* **`/models`**: Contains the data structures (`user_model.dart`). It handles the parsing of raw JSON from the API into Dart objects, keeping data formatting completely separated from the UI.
* **`/services`**: Contains the networking logic (`api_service.dart`). It acts as the single source of truth for fetching API data and handling the `shared_preferences` offline caching mechanism.
* **`/widgets`**: Contains reusable UI components (`custom_data_card.dart`, `shimmer_loading.dart`, `error_view.dart`) to ensure visual consistency and code reusability across the app.
* **`/views`**: Contains the main application screens (`home_view.dart`). These files only handle UI rendering and do not contain any direct API call logic.

## ⚙️ State Management: Provider & FutureBuilder
For this project, I chose to implement **Provider** (alongside `FutureBuilder` for asynchronous operations) for the following reasons:

1. **Separation of Concerns:** Provider allows the business logic (fetching and filtering data) to exist outside of the UI tree. The UI merely "listens" to the state and rebuilds only when necessary.
2. **Minimal Boilerplate:** Compared to Bloc or Riverpod, Provider offers a straightforward, native-feeling approach to dependency injection and state management without over-engineering a single-feature application.
3. **Responsive UI:** By combining `async/await` with `FutureBuilder`, the local search filtering operates on an isolated asynchronous thread. This ensures the main UI thread never freezes while the user is typing in the search bar.
