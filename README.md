# 🎬 Flick Finder – Flutter App

A **Flutter project** showcasing a modern movie & TV show discovery app.
It integrates with the **TMDB API** to fetch **real-time data** and demonstrates clean UI design along with local persistence for a watchlist.

---

## 📸 Screenshots

|                                         Home Screen                                         |                                           Details Screen                                          |                                            Watchlist Screen                                           |
| :-----------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------: |
| <img src="/screenshots/screenshot_home_screen.png?raw=true" width="250" alt="Home Screen"/> | <img src="/screenshots/screenshot_details_screen.png?raw=true" width="250" alt="Details Screen"/> | <img src="/screenshots/screenshot_watchlist_screen.png?raw=true" width="250" alt="Watchlist Screen"/> |

---

## 🚀 Tech Stack

* **Flutter**
* **Dart**
* **TMDB API** (real-time data)
* **Sqflite** (local watchlist storage)
* **Material Design 3**

---

## 🔧 Setup Instructions

1. Clone the repo:

   ```bash
   git clone https://github.com/your-username/flick-finder.git
   ```
2. Install dependencies:

   ```bash
   flutter pub get
   ```
3. Create a `.env` file in the project root and add your **TMDB API key**:

   ```env
   TMDB_API_KEY=YOUR_API_KEY
   ```

   > 🔑 Get your API key from [TMDB](https://www.themoviedb.org/).
4. Run the app:

   ```bash
   flutter run
   ```

---

## 🙌 Notes

* Real-time data fetched from **TMDB API**:

    * `/trending/movie/week`
    * `/movie/popular`
    * `/movie/top_rated`
    * `/trending/tv/week`
    * `/tv/popular`
    * `/tv/top_rated`
* Search support:

    * `/search/movie`
    * `/search/tv`
* Navigate to details screen for movies/TV shows.
* Watch trailers on **YouTube** (button on details screen).
* Add to **watchlist** (stored locally with Sqflite).

---

## 👋 Author

Made with 🎥 and ☕ by **Jay Halani**