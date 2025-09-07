import 'package:flick_finder/providers/movie_provider.dart';
import 'package:flick_finder/screens/movie_details_screen.dart';
import 'package:flick_finder/screens/tv_show_details_screen.dart';
import 'package:flick_finder/screens/view_all_screen.dart';
import 'package:flick_finder/widgets/movie_card.dart';
import 'package:flick_finder/widgets/tv_show_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load data when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieProvider>().loadAllData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Flick Finder',
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

            if (movieProvider.error != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.white,
                      size: 64,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error loading content',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      movieProvider.error!,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        movieProvider.loadAllData();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () => movieProvider.loadAllData(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Trending Movies Section
                    _buildSection(
                      title: 'Trending Movies',
                      icon: Icons.trending_up,
                      child: _buildMovieList(movieProvider.trendingMovies),
                      onViewAll: () => _navigateToViewAll(
                        context,
                        'Trending Movies',
                        movieProvider.trendingMovies,
                      ),
                    ),

                    // Popular Movies Section
                    _buildSection(
                      title: 'Popular Movies',
                      icon: Icons.local_fire_department,
                      child: _buildMovieList(movieProvider.popularMovies),
                      onViewAll: () => _navigateToViewAll(
                        context,
                        'Popular Movies',
                        movieProvider.popularMovies,
                      ),
                    ),

                    // Top Rated Movies Section
                    _buildSection(
                      title: 'Top Rated Movies',
                      icon: Icons.star,
                      child: _buildMovieList(movieProvider.topRatedMovies),
                      onViewAll: () => _navigateToViewAll(
                        context,
                        'Top Rated Movies',
                        movieProvider.topRatedMovies,
                      ),
                    ),

                    // Trending TV Shows Section
                    _buildSection(
                      title: 'Trending TV Shows',
                      icon: Icons.tv,
                      child: _buildTVShowList(movieProvider.trendingTVShows),
                      onViewAll: () => _navigateToViewAll(
                        context,
                        'Trending TV Shows',
                        movieProvider.trendingTVShows,
                      ),
                    ),

                    // Popular TV Shows Section
                    _buildSection(
                      title: 'Popular TV Shows',
                      icon: Icons.tv,
                      child: _buildTVShowList(movieProvider.popularTVShows),
                      onViewAll: () => _navigateToViewAll(
                        context,
                        'Popular TV Shows',
                        movieProvider.popularTVShows,
                      ),
                    ),

                    // Top Rated TV Shows Section
                    _buildSection(
                      title: 'Top Rated TV Shows',
                      icon: Icons.tv,
                      child: _buildTVShowList(movieProvider.topRatedTVShows),
                      onViewAll: () => _navigateToViewAll(
                        context,
                        'Top Rated TV Shows',
                        movieProvider.topRatedTVShows,
                      ),
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
    required VoidCallback onViewAll,
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
              const Spacer(),
              TextButton(
                onPressed: onViewAll,
                child: const Text(
                  'View all',
                  style: TextStyle(color: Colors.white70),
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
    if (movies.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: SizedBox(
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
      ),
    );
  }

  Widget _buildTVShowList(List tvShows) {
    if (tvShows.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: SizedBox(
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
      ),
    );
  }
}

void _navigateToViewAll(
  BuildContext context,
  String title,
  List<dynamic> items,
) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => ViewAllScreen(title: title, items: items),
    ),
  );
}
