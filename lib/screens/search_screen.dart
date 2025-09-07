import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flick_finder/providers/movie_provider.dart';
import 'package:flick_finder/widgets/movie_card.dart';
import 'package:flick_finder/widgets/tv_show_card.dart';
import 'package:flick_finder/models/movie.dart';
import 'package:flick_finder/models/tv_show.dart';
import 'package:flick_finder/screens/movie_details_screen.dart';
import 'package:flick_finder/screens/tv_show_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  List<Movie> _searchMovies = [];
  List<TVShow> _searchTVShows = [];
  bool _isSearching = false;
  String? _error;
  String _currentQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  Future<void> _performSearch(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _searchMovies = [];
        _searchTVShows = [];
        _isSearching = false;
        _error = null;
        _currentQuery = '';
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _error = null;
      _currentQuery = query;
    });

    try {
      final movieProvider = context.read<MovieProvider>();
      await Future.wait([
        movieProvider.searchMoviesQuery(query),
        movieProvider.searchTVShowsQuery(query),
      ]);

      setState(() {
        _searchMovies = movieProvider.searchMovies;
        _searchTVShows = movieProvider.searchTVShows;
        _isSearching = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isSearching = false;
      });
    }
  }

  void _onSearchSubmitted(String query) {
    _performSearch(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Search',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search for movies and TV shows',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            _searchController.clear();
                            _performSearch('');
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: Colors.grey[900],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                onSubmitted: _onSearchSubmitted,
                onChanged: (value) {
                  if (value.isEmpty) {
                    _performSearch('');
                  }
                },
              ),
            ),

            // Search Results
            Expanded(child: _buildSearchResults()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_currentQuery.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, color: Colors.grey, size: 64),
            SizedBox(height: 16),
            Text(
              'Search for movies and TV shows',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      );
    }

    if (_isSearching) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 64),
            const SizedBox(height: 16),
            Text(
              'Error searching',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _error!,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _performSearch(_currentQuery),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_searchMovies.isEmpty && _searchTVShows.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, color: Colors.grey, size: 64),
            const SizedBox(height: 16),
            Text(
              'No results found for "$_currentQuery"',
              style: const TextStyle(color: Colors.grey, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Movies Section
          if (_searchMovies.isNotEmpty) ...[
            _buildSection(
              title: 'Movies (${_searchMovies.length})',
              icon: Icons.movie,
              child: _buildMovieList(_searchMovies),
            ),
          ],

          // TV Shows Section
          if (_searchTVShows.isNotEmpty) ...[
            _buildSection(
              title: 'TV Shows (${_searchTVShows.length})',
              icon: Icons.tv,
              child: _buildTVShowList(_searchTVShows),
            ),
          ],

          const SizedBox(height: 20),
        ],
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

  Widget _buildMovieList(List<Movie> movies) {
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

  Widget _buildTVShowList(List<TVShow> tvShows) {
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
