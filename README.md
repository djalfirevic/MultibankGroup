# Real-Time Price Tracker

A SwiftUI iOS app that displays real-time price updates for 25 stock symbols using WebSocket communication.

## Features

- **Live Price Feed** — 25 stock symbols with real-time price updates every 2 seconds
- **WebSocket Integration** — Connects to `wss://ws.postman-echo.com/raw` echo server
- **Sorted List** — Symbols sorted by price (highest first), updating in real-time
- **Price Change Indicators** — Green ↑ for increases, red ↓ for decreases
- **Price Flash Animation** — Row briefly flashes green/red on price change
- **Symbol Details** — Tap any symbol to see detailed view with description
- **Connection Controls** — Start/Stop toggle and connection status indicator (🟢/🔴)
- **Deep Linking** — `stocks://symbol/{SYMBOL}` opens the detail screen directly
- **Light & Dark Mode** — Full support for both themes

## Architecture

The app uses **Unidirectional Data Flow** with a **Coordinator** pattern for navigation.

**Why UDF over MVVM?** The `WebSocketService` acts as a single source of truth — state flows down to views via `@Published` properties, and user actions flow back up through method calls (`connect()`, `disconnect()`). This avoids unnecessary ViewModel wrappers that would just pass through data, and ensures both screens always reflect the same state from a single shared service.

```
┌─────────────┐    @Published     ┌─────────────────┐
│  WebSocket   │ ──────────────── │   Views          │
│  Service     │   symbols,       │   (PriceFeed,    │
│  (State)     │   isConnected    │    SymbolDetail)  │
│              │ ◄──────────────  │                   │
└─────────────┘  connect(),       └─────────────────┘
                 disconnect()
```

```
MultibankGroup/
├── Models/
│   └── StockSymbol.swift              # Data model with 25 stock symbols
├── Services/
│   └── WebSocketService.swift         # Single source of truth (ObservableObject)
├── Navigation/
│   ├── Router.swift                   # Generic router (push, pop, present, dismiss)
│   ├── RouterView.swift               # NavigationStack wrapper
│   ├── Coordinator.swift              # Coordinator protocol
│   ├── AppRoute.swift                 # Route enum (feed, symbolDetail)
│   └── RootCoordinator.swift          # App coordinator with deep link handling
├── Views/
│   ├── PriceFeedView.swift            # Feed screen with sorted list and toolbar
│   ├── SymbolRowView.swift            # Row with symbol, price, indicator + flash
│   └── SymbolDetailView.swift         # Detail screen with price and description
├── RootView.swift                     # Entry view wiring coordinator + service
└── MultibankGroupApp.swift            # @main app entry point
```

### Key Technical Decisions

- **Unidirectional Data Flow** — `WebSocketService` owns all state; views only read and dispatch actions
- **Combine** `Timer.publish` drives the 2-second update cycle
- **Single `WebSocketService`** shared via `@EnvironmentObject` — no duplicate connections between screens
- **`ObservableObject` + `@Published`** for reactive state propagation
- **`@StateObject`** in `RootView`, **`@EnvironmentObject`** in child views
- **`NavigationStack`** with typed routes via the generic `Router<T>`
- **Coordinator pattern** decouples navigation logic from views

## Requirements

- Xcode 26.0+
- iOS 26.0+
- Swift 5.0

## How to Run

1. Clone the repository
2. Open `MultibankGroup.xcodeproj` in Xcode
3. Select a simulator and run (⌘R)
4. Tap **Start** to begin the live price feed

## Testing

The project includes both unit tests and UI tests.

**Run all tests:**
```bash
xcodebuild test -project MultibankGroup.xcodeproj -scheme MultibankGroup -destination 'platform=iOS Simulator,name=iPhone 17 Pro'
```

### Unit Tests (48 tests)

| Suite | Tests | Coverage |
|-------|-------|----------|
| `StockSymbolTests` | 9 | Price change logic, allSymbols validation, Identifiable/Hashable |
| `WebSocketServiceTests` | 14 | Initialization, sorting, message parsing, price updates |
| `RouterTests` | 8 | Push/pop/popToRoot, present/dismiss, updateRoot |
| `AppRouteTests` | 6 | Route IDs, Hashable equality |
| `RootCoordinatorTests` | 5 | Initial state, deep link handling (valid & invalid URLs) |

### UI Tests (6 tests)

| Test | Verifies |
|------|----------|
| Feed screen title | "Price Feed" navigation bar |
| Start button | Button exists with correct label |
| Connection indicator | Status circle present |
| Start/Stop toggle | Full Start → Stop → Start cycle |
| Back navigation | Tap symbol → detail → back to feed |
| List scrolling | Bottom symbols reachable via swipe |

## Deep Linking

Test deep links from Terminal:
```bash
xcrun simctl openurl booted "stocks://symbol/AAPL"
```
