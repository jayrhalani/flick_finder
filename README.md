# Flick Finder

A Flutter app that displays movies and TV shows using the TMDB (The Movie Database) API.

**Supported Platforms:** Android, iOS

## Features

- Browse trending, popular, and top-rated movies
- Browse trending, popular, and top-rated TV shows
- Modern dark theme UI
- Pull-to-refresh functionality
- Error handling with retry options
- Cached network images for better performance

## Setup

### 1. Get a TMDB API Key

1. Go to [The Movie Database (TMDB)](https://www.themoviedb.org/)
2. Create an account or sign in
3. Go to your account settings
4. Navigate to the "API" section
5. Request an API key for developer use
6. Copy your API key

### 2. Configure the API Key

1. Open `lib/config/api_config.dart`
2. Replace `'YOUR_TMDB_API_KEY'` with your actual API key:

```dart
static const String tmdbApiKey = 'your_actual_api_key_here';
```

### 3. Run the App

```bash
flutter pub get
flutter run
```

## Project Structure

```
lib/
├── config/
│   └── api_config.dart     # API configuration
├── models/
│   ├── movie.dart          # Movie data model
│   └── tv_show.dart        # TV show data model
├── providers/
│   └── movie_provider.dart # State management for movies and TV shows
├── screens/
│   └── home_screen.dart    # Main home screen
├── services/
│   └── tmdb_service.dart   # TMDB API service
├── widgets/
│   ├── movie_card.dart     # Movie card widget
│   └── tv_show_card.dart   # TV show card widget
└── main.dart               # App entry point
```

## Dependencies

- `http`: For making HTTP requests to TMDB API
- `cached_network_image`: For loading and caching images
- `provider`: For state management

## API Endpoints Used

- Trending movies: `/trending/movie/week`
- Popular movies: `/movie/popular`
- Top rated movies: `/movie/top_rated`
- Trending TV shows: `/trending/tv/week`
- Popular TV shows: `/tv/popular`
- Top rated TV shows: `/tv/top_rated`

## Future Enhancements

- Search functionality
- Movie/TV show details screen
- Watchlist functionality
- User authentication
- Offline support
- Movie/TV show trailers
- Cast and crew information
