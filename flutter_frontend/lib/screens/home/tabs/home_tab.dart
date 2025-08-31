import 'package:flutter/material.dart';

/// Home tab: placeholder recipe feed.
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List<int>.generate(8, (i) => i + 1);

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(0x22),
              child: Text('${items[index]}'),
            ),
            title: Text('Sample Recipe ${items[index]}'),
            subtitle: const Text('A delicious placeholder recipe.'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemCount: items.length,
    );
  }
}
