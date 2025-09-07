import 'package:flick_finder/config/api_config.dart';

class TVShow {
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final double voteAverage;
  final String firstAirDate;
  final List<int> genreIds;

  TVShow({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    required this.firstAirDate,
    required this.genreIds,
  });

  factory TVShow.fromJson(Map<String, dynamic> json) {
    return TVShow(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      voteAverage: (json['vote_average'] ?? 0.0).toDouble(),
      firstAirDate: json['first_air_date'] ?? '',
      genreIds: List<int>.from(json['genre_ids'] ?? []),
    );
  }

  String get fullPosterPath {
    if (posterPath.isEmpty) return '';
    return '${ApiConfig.tmdbImageBaseUrl}/${ApiConfig.posterSize}$posterPath';
  }

  String get fullBackdropPath {
    if (backdropPath.isEmpty) return '';
    return '${ApiConfig.tmdbImageBaseUrl}/${ApiConfig.backdropSize}$backdropPath';
  }
}
