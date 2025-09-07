import 'package:flick_finder/services/db_service.dart';

class FavoritesService {
  // Add a movie or TV show to favorites
  static Future<void> addToFavorites({
    required int id,
    required String title,
    required String posterPath,
    required String type, // 'movie' or 'tv'
    required double voteAverage,
  }) async {
    await DbService().addFavorite(
      id: id,
      title: title,
      posterPath: posterPath,
      type: type,
      voteAverage: voteAverage,
    );
  }

  // Remove a movie or TV show from favorites
  static Future<void> removeFromFavorites(int id) async {
    await DbService().removeFavorite(id);
  }

  // Check if a movie or TV show is in favorites
  static Future<bool> isFavorite(int id) async {
    return await DbService().isFavorite(id);
  }

  // Get all favorite movies or TV shows
  static Future<List<Map<String, dynamic>>> getFavorites({String? type}) async {
    return await DbService().getFavorites(type: type);
  }
}
