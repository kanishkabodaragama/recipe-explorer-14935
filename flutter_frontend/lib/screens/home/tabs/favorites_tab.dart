import 'package:flutter/material.dart';

/// Favorites tab: displays placeholder for favorited recipes.
class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = <String>[];

    if (favorites.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite_border, size: 56, color: Colors.black.withAlpha(0x44)),
              const SizedBox(height: 12),
              Text(
                'No favorites yet',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 6),
              Text(
                'Mark recipes as favorites and they will appear here.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black.withAlpha(0x99),
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, i) => Card(
        child: ListTile(
          title: Text(favorites[i]),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemCount: favorites.length,
    );
  }
}
