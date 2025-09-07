import 'package:flick_finder/models/movie.dart';
import 'package:flick_finder/models/tv_show.dart';
import 'package:flick_finder/screens/movie_details_screen.dart';
import 'package:flick_finder/screens/tv_show_details_screen.dart';
import 'package:flick_finder/widgets/grid_movie_card.dart';
import 'package:flick_finder/widgets/tv_show_card.dart';
import 'package:flutter/material.dart';

class ViewAllScreen extends StatelessWidget {
  final String title;
  final List<dynamic> items;

  const ViewAllScreen({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    final bool isMovie = items.isNotEmpty && items.first is Movie;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.55,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          debugPrint(
            "Building card for index: $index | data: ${item is Movie ? item.title : (item as TVShow).name}",
          );
          if (isMovie) {
            final movie = items[index] as Movie;
            return GridMovieCard(
              movie: movie,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MovieDetailsScreen(movie: movie),
                  ),
                );
              },
            );
          } else {
            final tvShow = items[index] as TVShow;
            return TVShowCard(
              tvShow: tvShow,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TVShowDetailsScreen(tvShow: tvShow),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
