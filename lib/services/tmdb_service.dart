import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flick_finder/models/movie.dart';
import 'package:flick_finder/models/tv_show.dart';
import 'package:flick_finder/config/api_config.dart';

class TMDBService {
  // Get trending movies
  static Future<List<Movie>> getTrendingMovies() async {
    try {
      final uri = Uri.parse(
        '${ApiConfig.tmdbBaseUrl}${ApiConfig.trendingMoviesEndpoint}?api_key=${ApiConfig.tmdbApiKey}',
      );
      print('[DEBUG] Requesting: $uri');
      final response = await http
          .get(uri)
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw Exception(
                'Request timed out. Please check your internet connection.',
              );
            },
          );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;
        return results.map((json) => Movie.fromJson(json)).toList();
      } else {
        print('[DEBUG] Response status: ${response.statusCode}');
        print('[DEBUG] Response body: ${response.body}');
        throw Exception(
          'Failed to load trending movies: Status ${response.statusCode}',
        );
      }
    } catch (e) {
      print('[DEBUG] Error in getTrendingMovies: $e');
      if (e.toString().contains('SocketException')) {
        throw Exception('Network error: Please check your internet connection');
      } else if (e.toString().contains('HandshakeException')) {
        throw Exception('SSL error: Could not establish secure connection');
      }
      throw Exception('Error fetching trending movies: $e');
    }
  }

  // Get popular movies
  static Future<List<Movie>> getPopularMovies() async {
    try {
      final uri = Uri.parse(
        '${ApiConfig.tmdbBaseUrl}${ApiConfig.popularMoviesEndpoint}?api_key=${ApiConfig.tmdbApiKey}',
      );
      print('[DEBUG] Requesting: $uri');
      final response = await http
          .get(uri)
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw Exception(
                'Request timed out. Please check your internet connection.',
              );
            },
          );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;
        return results.map((json) => Movie.fromJson(json)).toList();
      } else {
        print('[DEBUG] Response status: ${response.statusCode}');
        print('[DEBUG] Response body: ${response.body}');
        throw Exception(
          'Failed to load popular movies: Status ${response.statusCode}',
        );
      }
    } catch (e) {
      print('[DEBUG] Error in getPopularMovies: $e');
      if (e.toString().contains('SocketException')) {
        throw Exception('Network error: Please check your internet connection');
      } else if (e.toString().contains('HandshakeException')) {
        throw Exception('SSL error: Could not establish secure connection');
      }
      throw Exception('Error fetching popular movies: $e');
    }
  }

  // Get top rated movies
  static Future<List<Movie>> getTopRatedMovies() async {
    try {
      // Check if the URL is reachable first
      final uri = Uri.parse(
        '${ApiConfig.tmdbBaseUrl}${ApiConfig.topRatedMoviesEndpoint}?api_key=${ApiConfig.tmdbApiKey}',
      );

      final response = await http
          .get(uri)
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw Exception(
                'Request timed out. Please check your internet connection.',
              );
            },
          );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;
        return results.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to load top rated movies: Status ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        throw Exception('Network error: Please check your internet connection');
      } else if (e.toString().contains('HandshakeException')) {
        throw Exception('SSL error: Could not establish secure connection');
      }
      throw Exception('Error fetching top rated movies: $e');
    }
  }

  // Get trending TV shows
  static Future<List<TVShow>> getTrendingTVShows() async {
    try {
      final uri = Uri.parse(
        '${ApiConfig.tmdbBaseUrl}${ApiConfig.trendingTVShowsEndpoint}?api_key=${ApiConfig.tmdbApiKey}',
      );

      final response = await http
          .get(uri)
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw Exception(
                'Request timed out. Please check your internet connection.',
              );
            },
          );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;
        return results.map((json) => TVShow.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to load trending TV shows: Status ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        throw Exception('Network error: Please check your internet connection');
      } else if (e.toString().contains('HandshakeException')) {
        throw Exception('SSL error: Could not establish secure connection');
      }
      throw Exception('Error fetching trending TV shows: $e');
    }
  }

  // Get popular TV shows
  static Future<List<TVShow>> getPopularTVShows() async {
    try {
      final uri = Uri.parse(
        '${ApiConfig.tmdbBaseUrl}${ApiConfig.popularTVShowsEndpoint}?api_key=${ApiConfig.tmdbApiKey}',
      );

      final response = await http
          .get(uri)
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw Exception(
                'Request timed out. Please check your internet connection.',
              );
            },
          );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;
        return results.map((json) => TVShow.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to load popular TV shows: Status ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        throw Exception('Network error: Please check your internet connection');
      } else if (e.toString().contains('HandshakeException')) {
        throw Exception('SSL error: Could not establish secure connection');
      }
      throw Exception('Error fetching popular TV shows: $e');
    }
  }

  // Get top rated TV shows
  static Future<List<TVShow>> getTopRatedTVShows() async {
    try {
      final uri = Uri.parse(
        '${ApiConfig.tmdbBaseUrl}${ApiConfig.topRatedTVShowsEndpoint}?api_key=${ApiConfig.tmdbApiKey}',
      );

      final response = await http
          .get(uri)
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw Exception(
                'Request timed out. Please check your internet connection.',
              );
            },
          );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;
        return results.map((json) => TVShow.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to load top rated TV shows: Status ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        throw Exception('Network error: Please check your internet connection');
      } else if (e.toString().contains('HandshakeException')) {
        throw Exception('SSL error: Could not establish secure connection');
      }
      throw Exception('Error fetching top rated TV shows: $e');
    }
  }

  // Search movies
  static Future<List<Movie>> searchMovies(String query) async {
    try {
      final uri = Uri.parse(
        '${ApiConfig.tmdbBaseUrl}${ApiConfig.searchMoviesEndpoint}?api_key=${ApiConfig.tmdbApiKey}&query=${Uri.encodeComponent(query)}',
      );

      final response = await http
          .get(uri)
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw Exception(
                'Request timed out. Please check your internet connection.',
              );
            },
          );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;
        return results.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to search movies: Status ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        throw Exception('Network error: Please check your internet connection');
      } else if (e.toString().contains('HandshakeException')) {
        throw Exception('SSL error: Could not establish secure connection');
      }
      throw Exception('Error searching movies: $e');
    }
  }

  // Search TV shows
  static Future<List<TVShow>> searchTVShows(String query) async {
    try {
      final uri = Uri.parse(
        '${ApiConfig.tmdbBaseUrl}${ApiConfig.searchTVShowsEndpoint}?api_key=${ApiConfig.tmdbApiKey}&query=${Uri.encodeComponent(query)}',
      );

      final response = await http
          .get(uri)
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw Exception(
                'Request timed out. Please check your internet connection.',
              );
            },
          );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;
        return results.map((json) => TVShow.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to search TV shows: Status ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        throw Exception('Network error: Please check your internet connection');
      } else if (e.toString().contains('HandshakeException')) {
        throw Exception('SSL error: Could not establish secure connection');
      }
      throw Exception('Error searching TV shows: $e');
    }
  }

  // Get movie trailer key
  static Future<String?> getMovieTrailerKey(int movieId) async {
    try {
      final uri = Uri.parse(
        '${ApiConfig.tmdbBaseUrl}/movie/$movieId/videos?api_key=${ApiConfig.tmdbApiKey}',
      );

      final response = await http
          .get(uri)
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw Exception(
                'Request timed out. Please check your internet connection.',
              );
            },
          );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;

        // Find the first YouTube trailer
        for (final video in results) {
          if (video['site'] == 'YouTube' && video['type'] == 'Trailer') {
            return video['key'] as String;
          }
        }
      }
      return null;
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        throw Exception('Network error: Please check your internet connection');
      } else if (e.toString().contains('HandshakeException')) {
        throw Exception('SSL error: Could not establish secure connection');
      }
      return null;
    }
  }

  // Get TV show trailer key
  static Future<String?> getTVShowTrailerKey(int tvShowId) async {
    try {
      final uri = Uri.parse(
        '${ApiConfig.tmdbBaseUrl}/tv/$tvShowId/videos?api_key=${ApiConfig.tmdbApiKey}',
      );

      final response = await http
          .get(uri)
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw Exception(
                'Request timed out. Please check your internet connection.',
              );
            },
          );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;

        // Find the first YouTube trailer
        for (final video in results) {
          if (video['site'] == 'YouTube' && video['type'] == 'Trailer') {
            return video['key'] as String;
          }
        }
      }
      return null;
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        throw Exception('Network error: Please check your internet connection');
      } else if (e.toString().contains('HandshakeException')) {
        throw Exception('SSL error: Could not establish secure connection');
      }
      return null;
    }
  }

  // Get movie details by ID
  static Future<Movie> getMovieDetails(int movieId) async {
    try {
      final uri = Uri.parse(
        '${ApiConfig.tmdbBaseUrl}/movie/$movieId?api_key=${ApiConfig.tmdbApiKey}',
      );

      final response = await http
          .get(uri)
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw Exception(
                'Request timed out. Please check your internet connection.',
              );
            },
          );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Movie.fromJson(data);
      } else {
        throw Exception(
          'Failed to load movie details: Status ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        throw Exception('Network error: Please check your internet connection');
      } else if (e.toString().contains('HandshakeException')) {
        throw Exception('SSL error: Could not establish secure connection');
      }
      throw Exception('Error fetching movie details: $e');
    }
  }

  // Get TV show details by ID
  static Future<TVShow> getTVShowDetails(int tvShowId) async {
    try {
      final uri = Uri.parse(
        '${ApiConfig.tmdbBaseUrl}/tv/$tvShowId?api_key=${ApiConfig.tmdbApiKey}',
      );

      final response = await http
          .get(uri)
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw Exception(
                'Request timed out. Please check your internet connection.',
              );
            },
          );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return TVShow.fromJson(data);
      } else {
        throw Exception(
          'Failed to load TV show details: Status ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        throw Exception('Network error: Please check your internet connection');
      } else if (e.toString().contains('HandshakeException')) {
        throw Exception('SSL error: Could not establish secure connection');
      }
      throw Exception('Error fetching TV show details: $e');
    }
  }
}
