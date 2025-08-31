import 'package:flutter/material.dart';
import 'package:flutter_frontend/screens/home/tabs/home_tab.dart';
import 'package:flutter_frontend/screens/home/tabs/search_tab.dart';
import 'package:flutter_frontend/screens/home/tabs/favorites_tab.dart';
import 'package:flutter_frontend/screens/home/tabs/profile_tab.dart';
import 'package:flutter_frontend/screens/recipes/add_recipe_screen.dart';

/// Main shell after login, hosting tab navigation and FAB.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  static const _titles = <String>['Home', 'Search', 'Favorites', 'Profile'];
  final _tabs = const <Widget>[
    HomeTab(),
    SearchTab(),
    FavoritesTab(),
    ProfileTab(),
  ];

  void _onTab(int idx) {
    if (idx == _index) return;
    setState(() {
      _index = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String title = _titles[_index];

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: IndexedStack(
        index: _index,
        children: _tabs,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => const AddRecipeScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: _onTab,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
