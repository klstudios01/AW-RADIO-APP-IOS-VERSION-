# AW Radio - Native iOS Application (Swift 6 & SwiftUI)

> **"Listen Live. Anytime. Anywhere."**

AW Radio is a premium, production-ready native iOS streaming application designed exclusively for Apple devices. Inspired by Apple Music and Spotify, AW Radio offers live radio audio streaming, real-time broadcast schedules, breaking news publishing, local favorites caching, background audio playback with Dynamic Island & Live Activities, and a web-based Admin Dashboard.

---

## 🌟 Key Features

* **Swift 6 & SwiftUI Architecture**: Declarative, responsive UI utilizing MVVM and Combine.
* **Audio Engine (`AVPlayer` & `AVFoundation`)**:
  * Live Icecast, SHOUTcast, HLS, AAC, and MP3 streaming.
  * Automatic stream reconnection with exponential backoff.
  * Background audio playback with Lock Screen & Control Center metadata (`MPNowPlayingInfoCenter`).
  * AirPlay audio routing support via `AVRoutePickerView`.
  * Integrated Sleep Timer with automatic fade-out.
* **Dynamic Island & Live Activities**: Native `ActivityKit` support for tracking live broadcasts.
* **Glassmorphic UI Design**: Blur effects, modern gradients, soft shadows, rounded cards, and SF Symbols.
* **Supabase Integration**: Auth, PostgreSQL database schema with Row-Level Security (RLS) policies, and Realtime sync.
* **Web Admin Portal**: Web dashboard to manage radio stations, stream URLs, broadcast schedules, publish news, and monitor active listeners.

---

## 📁 Project Structure

```
AWRadio/
├── App/
│   ├── AWRadioApp.swift
│   └── AppDelegate.swift
├── Core/
│   ├── Networking/
│   │   ├── SupabaseClientManager.swift
│   │   └── APIEndpoint.swift
│   ├── Authentication/
│   │   └── AuthManager.swift
│   ├── Database/
│   │   └── LocalCacheManager.swift
│   ├── Audio/
│   │   ├── AudioStreamManager.swift
│   │   ├── NowPlayingInfoManager.swift
│   │   └── SleepTimerManager.swift
│   ├── Notifications/
│   │   └── PushNotificationManager.swift
│   ├── Analytics/
│   │   └── AnalyticsManager.swift
│   └── Utilities/
│       ├── DesignSystem.swift
│       ├── HapticsManager.swift
│       └── FormattingUtils.swift
├── Models/
│   ├── UserProfile.swift
│   ├── RadioStation.swift
│   ├── Program.swift
│   ├── NewsArticle.swift
│   ├── Podcast.swift
│   ├── FavoriteItem.swift
│   └── AppNotification.swift
├── Services/
│   ├── StationService.swift
│   ├── ProgramService.swift
│   ├── NewsService.swift
│   ├── FavoriteService.swift
│   └── UserService.swift
├── ViewModels/
│   ├── AuthViewModel.swift
│   ├── HomeViewModel.swift
│   ├── PlayerViewModel.swift
│   ├── ScheduleViewModel.swift
│   ├── NewsViewModel.swift
│   ├── FavoritesViewModel.swift
│   ├── SearchViewModel.swift
│   ├── ProfileViewModel.swift
│   └── SettingsViewModel.swift
├── Views/
│   ├── Splash/SplashView.swift
│   ├── Onboarding/OnboardingView.swift
│   ├── Authentication/ (LoginView, SignUpView, ForgotPasswordView)
│   ├── MainContainerView.swift
│   ├── Home/ (HomeView, HeroLiveCard)
│   ├── Player/ (ExpandedPlayerView, MiniPlayerView, AnimatedWaveformView)
│   ├── Schedule/ScheduleView.swift
│   ├── News/ (NewsView, ArticleDetailView)
│   ├── Favorites/FavoritesView.swift
│   ├── Search/SearchView.swift
│   ├── Profile/ProfileView.swift
│   └── Settings/SettingsView.swift
├── Components/ (GlassCard, PrimaryButton, SkeletonLoader, SectionHeader, CategoryPill, CustomTabBar)
├── LiveActivities/LiveRadioActivity.swift
├── Widgets/RadioWidget.swift
└── Extensions/ (Color+Theme, View+Glass, Date+Formatter)

backend/
├── supabase_schema.sql
└── rls_policies.sql

admin-portal/
├── index.html
├── styles.css
└── app.js
```

---

## 🚀 Getting Started

### 1. Requirements
* Xcode 15.0 or later (Swift 6)
* iOS 17.0+ SDK / Simulator
* Supabase Account (for live production database)

### 2. Opening in Xcode
1. Open the repository folder on a Mac.
2. Double-click `AWRadio.xcodeproj` to launch Xcode.
3. Select your target device or iOS Simulator (e.g. iPhone 15 Pro).
4. Press `Cmd + R` to build and run the app.

### 3. Supabase Setup
1. In your Supabase Dashboard SQL Editor, run `backend/supabase_schema.sql` to create database tables.
2. Next, execute `backend/rls_policies.sql` to enforce Row Level Security rules.
3. Open `AWRadio/Core/Networking/SupabaseClientManager.swift` and insert your `SUPABASE_URL` and `SUPABASE_ANON_KEY`.

### 4. Admin Web Dashboard
1. Navigate to the `admin-portal/` folder.
2. Open `index.html` in any web browser to view active listener metrics, manage radio stream URLs, and publish news articles.

---

## 🧪 Unit Testing
Unit tests are included under `AWRadioTests/`. Run unit tests in Xcode using `Cmd + U`.

---

## 📄 License
All rights reserved © 2026 AW Radio.