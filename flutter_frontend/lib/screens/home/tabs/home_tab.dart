import 'package:flutter/material.dart';

/// Home tab: Implements the Home screen per Figma (screen 17:80) with
/// greeting, search/filter bar, category chips, a dish card carousel, and a
/// "New Recipes" horizontal list.
/// Uses mock data and placeholder visuals faithful to the design cues.
class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  // Figma token colors used in the provided assets
  static const Color _figmaGreen = Color(0xFF129575); // style_11
  static const Color _chipOutlineGreen = Color(0xFF71B1A1);
  static const Color _mutedGrey = Color(0xFFD9D9D9);
  static const Color _deepGrey4848 = Color(0xFF484848);
  static const Color _textGreyA9 = Color(0xFFA9A9A9);
  static const Color _badgeAmberBg = Color(0xFFFFE1B3); // style_48
  static const Color _badgeAmber = Color(0xFFFFAD30); // rating star/accents
  static const Color _cardShadow = Color(0x40202020); // 25% shadow approx.

  final TextEditingController _searchCtrl = TextEditingController();

  // Simple mock categories inspired by the Figma chips
  final List<String> _categories = const <String>[
    'All',
    'Indian',
    'Italian',
    'Asian',
    'Chinese',
    'Fruit',
    'Vegetables',
    'Protein',
    'Cereal',
    'Local Dishes',
  ];

  String _selectedCategory = 'All';

  // Toggle state for saved bookmarks by dish index
  final Set<int> _savedDish = <int>{};

  // Mock data for dish carousel
  final List<_Dish> _dishes = const <_Dish>[
    _Dish(title: 'Classic Greek Salad', time: '15 Mins', rating: 4.5, category: 'Vegetables'),
    _Dish(title: 'Crunchy Nut Coleslaw', time: '10 Mins', rating: 3.5, category: 'Vegetables'),
    _Dish(title: 'Shrimp Chicken Andouille Sausage Jambalaya', time: '10 Mins', rating: 3.0, category: 'Protein'),
    _Dish(title: 'Barbecue Chicken Jollof Rice', time: '10 Mins', rating: 4.5, category: 'Local Dishes'),
    _Dish(title: 'Portuguese Piri Piri Chicken', time: '10 Mins', rating: 4.5, category: 'Protein'),
  ];

  // Mock data for "New Recipes"
  final List<_NewRecipe> _newRecipes = const <_NewRecipe>[
    _NewRecipe(
      title: 'Steak with tomato sauce and bulgur rice.',
      time: '20 mins',
      author: 'By James Milner',
      rating: 5.0,
    ),
    _NewRecipe(
      title: 'Pilaf sweet with lamb-and-raisins',
      time: '20 mins',
      author: 'By Laura wilson',
      rating: 5.0,
    ),
    _NewRecipe(
      title: 'Rice Pilaf, Broccoli and Chicken',
      time: '20 mins',
      author: 'By Lucas Moura',
      rating: 5.0,
    ),
    _NewRecipe(
      title: 'Chicken meal with sauce',
      time: '20 mins',
      author: 'By Issabella Ethan',
      rating: 5.0,
    ),
    _NewRecipe(
      title: 'Stir-fry chicken with broccoli in sweet and sour sauce and rice.',
      time: '20 mins',
      author: 'By Miquel Ferran',
      rating: 5.0,
    ),
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  // PUBLIC_INTERFACE
  /// Builds the Home screen body with sections stacked inside a scroll view.
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;

    // Filter dishes by category when a specific chip is selected
    final List<_Dish> visibleDishes = _selectedCategory == 'All'
        ? _dishes
        : _dishes.where((d) => d.category.toLowerCase() == _selectedCategory.toLowerCase()).toList();

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Top spacing similar to 44 status bar space in Figma iOS frame
            const SizedBox(height: 12),
            _buildGreeting(theme),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: _buildSearchAndFilter(theme),
            ),
            const SizedBox(height: 14),
            _buildCategories(),
            const SizedBox(height: 24),
            _buildDishCarousel(visibleDishes, scheme),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'New Recipes',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600, // typo_74
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildNewRecipes(theme),
            const SizedBox(height: 24 + 106), // leave space for bottom nav overlap
          ],
        ),
      ),
    );
  }

  Widget _buildGreeting(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SizedBox(
        height: 52,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // "Hello Jega"
                  Text(
                    'Hello Jega',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: 20, // typo_68
                      height: 30 / 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'What are you cooking today?',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 11, // typo_70
                      height: 16.5 / 11,
                      fontWeight: FontWeight.w400,
                      color: _textGreyA9,
                    ),
                  ),
                ],
              ),
            ),
            // Avatar square (40x40, radius 10)
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFFFCE80), // avatar bg from tokens
                borderRadius: BorderRadius.circular(10),
              ),
              clipBehavior: Clip.antiAlias,
              child: Container(
                decoration: const BoxDecoration(
                  // subtle placeholder gradient feel
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0x10000000),
                      Color(0x1F000000),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Icon(Icons.person, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter(ThemeData theme) {
    return SizedBox(
      height: 40,
      child: Row(
        children: <Widget>[
          // Search surface (width ~255 on Figma; here use Expanded)
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10), // style_11 radius
                    border: Border.all(color: _mutedGrey, width: 1.3), // style_53
                  ),
                  padding: const EdgeInsets.only(left: 36, right: 12),
                  alignment: Alignment.centerLeft,
                  child: TextField(
                    controller: _searchCtrl,
                    textInputAction: TextInputAction.search,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      hintText: 'Search recipe',
                    ),
                    style: const TextStyle(
                      fontSize: 11, // typo_65
                      height: 16.5 / 11,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF121212),
                    ),
                  ),
                ),
                const Positioned(
                  left: 12,
                  top: 0,
                  bottom: 0,
                  child: Icon(Icons.search, size: 18, color: Color(0xFFD9D9D9)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          // Filter button 40x40, filled green square (style_11)
          SizedBox(
            width: 40,
            height: 40,
            child: Material(
              color: _figmaGreen,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  // Placeholder: filter interaction hook
                  // No context operations after async; this is sync.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Filter clicked')),
                  );
                },
                child: const Center(
                  child: Icon(Icons.tune_rounded, color: Colors.white, size: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 31,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int i) {
          final String label = _categories[i];
          final bool isSelected = label == _selectedCategory;
          return _CategoryChip(
            label: label,
            isSelected: isSelected,
            onTap: () {
              setState(() {
                _selectedCategory = label;
              });
            },
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemCount: _categories.length,
      ),
    );
  }

  Widget _buildDishCarousel(List<_Dish> dishes, ColorScheme scheme) {
    return SizedBox(
      height: 231,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        scrollDirection: Axis.horizontal,
        itemCount: dishes.length,
        separatorBuilder: (_, __) => const SizedBox(width: 20),
        itemBuilder: (BuildContext context, int index) {
          final _Dish dish = dishes[index];
          final bool saved = _savedDish.contains(index);

          return SizedBox(
            width: 150,
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                // Base rectangle at bottom (150 x 176)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: 176,
                  child: Container(
                    decoration: BoxDecoration(
                      color: _mutedGrey.withAlpha(0x80), // 50% approx
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                // Top circular image area (109x110) centered horizontally
                Positioned(
                  top: 0,
                  left: (150 - 109) / 2,
                  width: 109,
                  height: 110,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFC1C1C1),
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: _cardShadow,
                          blurRadius: 25,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.fastfood, color: Colors.white70),
                  ),
                ),
                // Rating pill (top-right)
                Positioned(
                  right: 8,
                  top: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: _badgeAmberBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.star, size: 10, color: _badgeAmber),
                        const SizedBox(width: 6),
                        Text(
                          dish.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 11, // typo_73
                            height: 16.5 / 11,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Bookmark button (bottom-right)
                Positioned(
                  right: 12,
                  bottom: 20,
                  child: _BookmarkButton(
                    saved: saved,
                    onTap: () {
                      setState(() {
                        if (saved) {
                          _savedDish.remove(index);
                        } else {
                          _savedDish.add(index);
                        }
                      });
                    },
                  ),
                ),
                // Card body (meta + title)
                Positioned(
                  left: 10,
                  right: 10,
                  bottom: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Meta block
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'Time',
                              style: TextStyle(
                                fontSize: 11, // typo_70
                                height: 16.5 / 11,
                                fontWeight: FontWeight.w400,
                                color: _textGreyA9,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              dish.time,
                              style: const TextStyle(
                                fontSize: 11, // typo_71
                                height: 16.5 / 11,
                                fontWeight: FontWeight.w600,
                                color: _deepGrey4848,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Title
                      Text(
                        dish.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14, // typo_72
                          height: 21 / 14,
                          fontWeight: FontWeight.w600,
                          color: _deepGrey4848,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNewRecipes(ThemeData theme) {
    return SizedBox(
      height: 139,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        scrollDirection: Axis.horizontal,
        itemCount: _newRecipes.length,
        separatorBuilder: (_, __) => const SizedBox(width: 20),
        itemBuilder: (BuildContext context, int index) {
          final _NewRecipe r = _newRecipes[index];
          return SizedBox(
            width: 270,
            height: 127,
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                // Surface card (95 height) anchored to bottom
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: 95,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Color(0x26000000), // 15%
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Rating row as star glyphs
                        Row(
                          children: <Widget>[
                            _buildStars(count: r.rating.round()),
                          ],
                        ),
                        const SizedBox(height: 4),
                        // Title up to 2 lines
                        SizedBox(
                          width: 150, // match Figma width constraint
                          child: Text(
                            r.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 21 / 14,
                              fontWeight: FontWeight.w600,
                              color: _deepGrey4848,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Meta time
                        Row(
                          children: <Widget>[
                            const Icon(Icons.schedule, size: 17, color: _textGreyA9),
                            const SizedBox(width: 6),
                            Text(
                              r.time,
                              style: const TextStyle(
                                fontSize: 11,
                                height: 16.5 / 11,
                                fontWeight: FontWeight.w400,
                                color: _textGreyA9,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        // Creator row
                        Row(
                          children: <Widget>[
                            Container(
                              width: 25,
                              height: 25,
                              decoration: const BoxDecoration(
                                color: Color(0xFFD9D9D9),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.person, size: 14, color: Colors.white70),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              r.author,
                              style: const TextStyle(
                                fontSize: 11,
                                height: 16.5 / 11,
                                fontWeight: FontWeight.w400,
                                color: _textGreyA9,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Right circular thumbnail (86x86)
                Positioned(
                  right: 0,
                  top: 0,
                  width: 86,
                  height: 86,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFC1C1C1),
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(color: Color(0x33000000), blurRadius: 4, offset: Offset(0, 4)),
                      ],
                    ),
                    child: const Icon(Icons.ramen_dining, color: Colors.white70),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStars({required int count}) {
    return Text(
      '★★★★★'.substring(0, count).padRight(5, '☆'),
      style: const TextStyle(
        fontSize: 10,
        letterSpacing: 2,
        color: _badgeAmber,
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bool filled = isSelected;
    return SizedBox(
      height: 31,
      child: Material(
        color: filled ? _HomeTabState._figmaGreen : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: filled ? BorderSide.none : const BorderSide(color: _HomeTabState._chipOutlineGreen),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  height: 16.5 / 11,
                  fontWeight: FontWeight.w600,
                  color: filled ? Colors.white : _HomeTabState._chipOutlineGreen,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BookmarkButton extends StatelessWidget {
  const _BookmarkButton({required this.saved, required this.onTap});

  final bool saved;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: Material(
        color: saved ? _HomeTabState._badgeAmberBg : Colors.white, // style_43 white; saved -> amber bg
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Center(
            child: Icon(
              saved ? Icons.bookmark : Icons.bookmark_border,
              size: 16,
              color: saved ? _HomeTabState._badgeAmber : const Color(0xFF130F26),
            ),
          ),
        ),
      ),
    );
  }
}

class _Dish {
  const _Dish({
    required this.title,
    required this.time,
    required this.rating,
    required this.category,
  });

  final String title;
  final String time;
  final double rating;
  final String category;
}

class _NewRecipe {
  const _NewRecipe({
    required this.title,
    required this.time,
    required this.author,
    required this.rating,
  });

  final String title;
  final String time;
  final String author;
  final double rating;
}
