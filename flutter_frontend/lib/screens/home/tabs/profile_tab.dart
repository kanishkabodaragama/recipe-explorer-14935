import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_frontend/controllers/auth_controller.dart';

/// Profile tab: placeholder for user info and settings.
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const CircleAvatar(
          radius: 36,
          child: Icon(Icons.person, size: 36),
        ),
        const SizedBox(height: 12),
        Center(
          child: Text(
            'Guest User',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 24),
        Card(
          child: ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Settings'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sign Out'),
            onTap: () {
              // Fire and forget sign out; root will switch screens via Provider.
              context.read<AuthController>().signOut();
            },
          ),
        ),
      ],
    );
  }
}
