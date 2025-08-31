import 'package:flutter/material.dart';

/// Search tab: placeholder UI for searching recipes.
class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final _searchCtrl = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final results = _query.isEmpty
        ? const <String>[]
        : List<String>.generate(5, (i) => 'Result ${i + 1} for "$_query"');

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TextField(
          controller: _searchCtrl,
          textInputAction: TextInputAction.search,
          decoration: const InputDecoration(
            hintText: 'Search recipes by name or ingredient',
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (value) {
            setState(() {
              _query = value.trim();
            });
          },
        ),
        const SizedBox(height: 16),
        if (results.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 48),
            child: Column(
              children: [
                Icon(Icons.search, size: 48, color: Colors.black.withAlpha(0x44)),
                const SizedBox(height: 8),
                Text(
                  'Try searching for "Pasta" or "Chicken"',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.black.withAlpha(0x99)),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        else
          ...results.map(
            (e) => Card(
              child: ListTile(
                leading: const Icon(Icons.fastfood),
                title: Text(e),
                subtitle: const Text('Mock search result'),
                onTap: () {},
              ),
            ),
          ),
      ],
    );
  }
}
