import 'package:cached_network_image/cached_network_image.dart';
import 'package:flick_finder/models/tv_show.dart';
import 'package:flutter/material.dart';

class TVShowCard extends StatelessWidget {
  final TVShow tvShow;
  final VoidCallback? onTap;

  const TVShowCard({super.key, required this.tvShow, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TV show poster
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AspectRatio(
                aspectRatio: 2 / 3,
                child: tvShow.posterPath.isEmpty || tvShow.posterPath == 'null'
                    ? Container(
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.tv,
                          color: Colors.grey,
                          size: 40,
                        ),
                      )
                    : CachedNetworkImage(
                        imageUrl: tvShow.fullPosterPath,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[300],
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.tv,
                            color: Colors.grey,
                            size: 40,
                          ),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 8),

            // TV show name
            Text(
              tvShow.name,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 4),

            // Rating and year
            Row(
              children: [
                Icon(Icons.star, size: 14, color: Colors.amber[600]),
                const SizedBox(width: 4),
                Text(
                  tvShow.voteAverage.toStringAsFixed(1),
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const Spacer(),
                if (tvShow.firstAirDate.isNotEmpty)
                  Text(
                    tvShow.firstAirDate.split('-')[0],
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
