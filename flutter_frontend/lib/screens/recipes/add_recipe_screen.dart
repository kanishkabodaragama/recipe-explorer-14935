import 'package:flutter/material.dart';

/// Placeholder screen for adding a new recipe.
class AddRecipeScreen extends StatelessWidget {
  const AddRecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Recipe'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 8),
          Text(
            'Create a new recipe',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          Text(
            'This is a placeholder screen. In future iterations, this will include '
            'form fields for recipe title, ingredients, steps, images, and categories.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Recipe Title',
              prefixIcon: Icon(Icons.title),
            ),
          ),
          const SizedBox(height: 16),
          const TextField(
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Short Description',
              prefixIcon: Icon(Icons.description_outlined),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Placeholder save
              Navigator.of(context).maybePop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
