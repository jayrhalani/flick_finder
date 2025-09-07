import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  // TMDB API Configuration
  static const String tmdbBaseUrl = 'https://api.themoviedb.org/3';
  static const String tmdbImageBaseUrl = 'https://image.tmdb.org/t/p';

  // Replace this with your actual TMDB API key
  // Get your API key from: https://www.themoviedb.org/settings/api
  static final String? tmdbApiKey = dotenv.env['TMDB_API_KEY'];

  // Image sizes
  static const String posterSize = 'w500';
  static const String backdropSize = 'original';

  // API endpoints
  static const String trendingMoviesEndpoint = '/trending/movie/week';
  static const String popularMoviesEndpoint = '/movie/popular';
  static const String topRatedMoviesEndpoint = '/movie/top_rated';
  static const String trendingTVShowsEndpoint = '/trending/tv/week';
  static const String popularTVShowsEndpoint = '/tv/popular';
  static const String topRatedTVShowsEndpoint = '/tv/top_rated';
  static const String searchMoviesEndpoint = '/search/movie';
  static const String searchTVShowsEndpoint = '/search/tv';
}
