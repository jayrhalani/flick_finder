import 'package:flutter/foundation.dart';
import 'package:flick_finder/models/movie.dart';
import 'package:flick_finder/models/tv_show.dart';
import 'package:flick_finder/services/tmdb_service.dart';
import 'package:flick_finder/services/watchlist_service.dart' as favorites_service;

class MovieProvider with ChangeNotifier {
  List<Movie> _trendingMovies = [];
  List<Movie> _popularMovies = [];
  List<Movie> _topRatedMovies = [];
  List<TVShow> _trendingTVShows = [];
  List<TVShow> _popularTVShows = [];
  List<TVShow> _topRatedTVShows = [];
  List<Movie> _searchMovies = [];
  List<TVShow> _searchTVShows = [];
  List<Movie> _favoriteMovies = [];
  List<TVShow> _favoriteTVShows = [];

  bool _isLoading = false;
  String? _error;

  // Getters
  List<Movie> get trendingMovies => _trendingMovies;
  List<Movie> get popularMovies => _popularMovies;
  List<Movie> get topRatedMovies => _topRatedMovies;
  List<TVShow> get trendingTVShows => _trendingTVShows;
  List<TVShow> get popularTVShows => _popularTVShows;
  List<TVShow> get topRatedTVShows => _topRatedTVShows;
  List<Movie> get searchMovies => _searchMovies;
  List<TVShow> get searchTVShows => _searchTVShows;
  List<Movie> get favoriteMovies => _favoriteMovies;
  List<TVShow> get favoriteTVShows => _favoriteTVShows;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Load all data
  Future<void> loadAllData() async {
    _setLoading(true);
    _clearError();
    try {
      await Future.wait([
        loadTrendingMovies(),
        loadPopularMovies(),
        loadTopRatedMovies(),
        loadTrendingTVShows(),
        loadPopularTVShows(),
        loadTopRatedTVShows(),
      ]);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Load favorites data
  Future<void> loadFavorites() async {
    _setLoading(true);
    _clearError();
    try {
      await Future.wait([loadFavoriteMovies(), loadFavoriteTVShows()]);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> loadTrendingMovies() async {
    try {
      _trendingMovies = await TMDBService.getTrendingMovies();
      notifyListeners();
    } catch (e) {
      _setError('Failed to load trending movies: $e');
    }
  }

  Future<void> loadPopularMovies() async {
    try {
      _popularMovies = await TMDBService.getPopularMovies();
      notifyListeners();
    } catch (e) {
      _setError('Failed to load popular movies: $e');
    }
  }

  Future<void> loadTopRatedMovies() async {
    try {
      _topRatedMovies = await TMDBService.getTopRatedMovies();
      notifyListeners();
    } catch (e) {
      _setError('Failed to load top rated movies: $e');
    }
  }

  Future<void> loadTrendingTVShows() async {
    try {
      _trendingTVShows = await TMDBService.getTrendingTVShows();
      notifyListeners();
    } catch (e) {
      _setError('Failed to load trending TV shows: $e');
    }
  }

  Future<void> loadPopularTVShows() async {
    try {
      _popularTVShows = await TMDBService.getPopularTVShows();
      notifyListeners();
    } catch (e) {
      _setError('Failed to load popular TV shows: $e');
    }
  }

  Future<void> loadTopRatedTVShows() async {
    try {
      _topRatedTVShows = await TMDBService.getTopRatedTVShows();
      notifyListeners();
    } catch (e) {
      _setError('Failed to load top rated TV shows: $e');
    }
  }

  Future<void> loadFavoriteMovies() async {
    try {
      final favs = await favorites_service.FavoritesService.getFavorites(
        type: 'movie',
      );
      _favoriteMovies = favs
          .map(
            (fav) => Movie(
              id: fav['id'],
              title: fav['title'],
              overview: '',
              posterPath: fav['posterPath'],
              backdropPath: '',
              voteAverage: fav['voteAverage'] ?? 0.0,
              releaseDate: '',
              genreIds: const [],
            ),
          )
          .toList();
      notifyListeners();
    } catch (e) {
      _setError('Failed to load favorite movies: $e');
    }
  }

  Future<void> loadFavoriteTVShows() async {
    try {
      final favs = await favorites_service.FavoritesService.getFavorites(
        type: 'tv',
      );
      _favoriteTVShows = favs
          .map(
            (fav) => TVShow(
              id: fav['id'],
              name: fav['title'],
              overview: '',
              posterPath: fav['posterPath'],
              backdropPath: '',
              voteAverage: fav['voteAverage'] ?? 0.0,
              firstAirDate: '',
              genreIds: const [],
            ),
          )
          .toList();
      notifyListeners();
    } catch (e) {
      _setError('Failed to load favorite TV shows: $e');
    }
  }

  Future<void> searchMoviesQuery(String query) async {
    try {
      _searchMovies = await TMDBService.searchMovies(query);
      notifyListeners();
    } catch (e) {
      _setError('Failed to search movies: $e');
    }
  }

  Future<void> searchTVShowsQuery(String query) async {
    try {
      _searchTVShows = await TMDBService.searchTVShows(query);
      notifyListeners();
    } catch (e) {
      _setError('Failed to search TV shows: $e');
    }
  }

  Future<void> addFavoriteMovie(Movie movie) async {
    await favorites_service.FavoritesService.addToFavorites(
      id: movie.id,
      title: movie.title,
      posterPath: movie.posterPath,
      type: 'movie',
      voteAverage: movie.voteAverage,
    );
    await loadFavoriteMovies();
  }

  Future<void> removeFavoriteMovie(int id) async {
    await favorites_service.FavoritesService.removeFromFavorites(id);
    await loadFavoriteMovies();
  }

  Future<bool> isFavoriteMovie(int id) async {
    return await favorites_service.FavoritesService.isFavorite(id);
  }

  Future<void> addFavoriteTVShow(TVShow tvShow) async {
    await favorites_service.FavoritesService.addToFavorites(
      id: tvShow.id,
      title: tvShow.name,
      posterPath: tvShow.posterPath,
      type: 'tv',
      voteAverage: tvShow.voteAverage,
    );
    await loadFavoriteTVShows();
  }

  Future<void> removeFavoriteTVShow(int id) async {
    await favorites_service.FavoritesService.removeFromFavorites(id);
    await loadFavoriteTVShows();
  }

  Future<bool> isFavoriteTVShow(int id) async {
    return await favorites_service.FavoritesService.isFavorite(id);
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
    notifyListeners();
  }
}
