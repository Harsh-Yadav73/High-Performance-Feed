# 🚀 High Performance Feed (Flutter + Supabase)

## 📌 Overview

This project implements a **high-performance, infinite-scrolling social feed** using Flutter and Supabase.
The focus is on **UI performance, memory optimization, and smooth user experience**, similar to production-level apps like Instagram.

---

## 🎯 Key Features

### 📱 Feed System

* Infinite scrolling with pagination (10 items per request)
* Pull-to-refresh support
* Smooth scrolling with no frame drops

### ⚡ Performance Optimization

* `RepaintBoundary` used to isolate heavy UI rendering (shadows)
* `memCacheWidth` used to match image decode size with UI → prevents OOM
* Efficient list rendering using `ListView.builder`

### ❤️ Optimistic UI (Likes)

* Instant UI update on like/unlike
* Background API call using Supabase RPC
* Silent rollback on failure (no user interruption)

### 🎬 UI/UX Enhancements

* Hero animation for smooth navigation
* Gradient-based modern UI
* Shimmer loading (no blank screen)
* Smooth animations on like interaction

### 🖼️ Tiered Image Loading

* Thumbnail (300px) → used in feed
* Mobile image (1080px) → used in detail screen
* Raw image → downloaded only on demand

---

## 🧠 Architecture

```text
lib/
 ├── core/          → Supabase setup
 ├── models/        → Data models
 ├── providers/     → Riverpod state management
 ├── screens/       → UI screens
 ├── widgets/       → Reusable UI components
```

* State Management: **Riverpod**
* Backend: **Supabase (DB + Storage + RPC)**
* Image Handling: **Cached Network Image**

---

## 🗄️ Backend Setup

### 1. Supabase

* Create a project on Supabase
* Run provided SQL script to create:

  * `posts` table
  * `user_likes` table
  * `toggle_like` RPC function

### 2. Storage

* Create a public bucket named:

```
media
```

### 3. Data Seeding

* Run Python script to:

  * Upload images (raw, mobile, thumbnail)
  * Insert URLs into database

---

## ▶️ How to Run

```bash
flutter pub get
flutter run
```

### Add your Supabase credentials:

```dart
await Supabase.initialize(
  url: 'YOUR_URL',
  anonKey: 'YOUR_ANON_KEY',
);
```

---

## 🎥 Demo Video

👉 (Paste your video link here)

---

## 🧪 Edge Cases Handled

* ✅ Rapid scrolling (no jank)
* ✅ Spam clicking like button
* ✅ Offline mode with silent UI rollback
* ✅ Image memory optimization (no crashes)

---

## 🔥 Performance Highlights

* Prevented GPU overdraw using `RepaintBoundary`
* Reduced RAM usage using `memCacheWidth`
* Optimized network usage via tiered image pipeline
* Maintained 60 FPS scrolling under heavy UI load

---

## 🛠️ Tech Stack

* Flutter
* Riverpod
* Supabase (Auth, Database, Storage, RPC)
* CachedNetworkImage

---

## 💡 Key Learnings

* Importance of **optimistic UI in real-time apps**
* Handling **race conditions via backend RPC**
* Balancing **UI richness vs performance**
* Memory management in Flutter image rendering

---

## 📎 Submission Includes

* ✅ GitHub repository
* ✅ Demo video
* ✅ Clean architecture + optimized code

---

## 👨‍💻 Author

Harsh Yadav

---
