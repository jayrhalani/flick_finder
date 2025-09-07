import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flick_finder/providers/movie_provider.dart';
import 'package:flick_finder/widgets/movie_card.dart';
import 'package:flick_finder/widgets/tv_show_card.dart';
import 'package:flick_finder/screens/movie_details_screen.dart';
import 'package:flick_finder/screens/tv_show_details_screen.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  @override
  void initState() {
    super.initState();
    // Load favorites data when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieProvider>().loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'My Watchlist',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Consumer<MovieProvider>(
          builder: (context, movieProvider, child) {
            if (movieProvider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }

            final favoriteMovies = movieProvider.favoriteMovies;
            final favoriteTVShows = movieProvider.favoriteTVShows;

            if (favoriteMovies.isEmpty && favoriteTVShows.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.bookmark_border,
                      color: Colors.grey[600],
                      size: 80,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Your favorites list is empty',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Add movies and TV shows to your favorites\nby tapping the bookmark icon',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () => movieProvider.loadFavorites(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Movies Section
                    if (favoriteMovies.isNotEmpty)
                      _buildSection(
                        title: 'Movies (${favoriteMovies.length})',
                        icon: Icons.movie,
                        child: _buildMovieList(favoriteMovies),
                      ),

                    // TV Shows Section
                    if (favoriteTVShows.isNotEmpty)
                      _buildSection(
                        title: 'TV Shows (${favoriteTVShows.length})',
                        icon: Icons.tv,
                        child: _buildTVShowList(favoriteTVShows),
                      ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        child,
      ],
    );
  }

  Widget _buildMovieList(List movies) {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return MovieCard(
            movie: movies[index],
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      MovieDetailsScreen(movie: movies[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildTVShowList(List tvShows) {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: tvShows.length,
        itemBuilder: (context, index) {
          return TVShowCard(
            tvShow: tvShows[index],
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      TVShowDetailsScreen(tvShow: tvShows[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
