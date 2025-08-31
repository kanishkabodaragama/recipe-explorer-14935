import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_frontend/theme/app_theme.dart';
import 'package:flutter_frontend/controllers/auth_controller.dart';
import 'package:flutter_frontend/screens/auth/sign_in_screen.dart';
import 'package:flutter_frontend/screens/home/home_shell.dart';

void main() {
  runApp(const MyApp());
}

/// Root application widget with theme and state initialization.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // PUBLIC_INTERFACE
  /// Builds the root MaterialApp with theming and state providers.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthController>(
      create: (_) => AuthController()..init(),
      child: Consumer<AuthController>(
        builder: (context, auth, _) {
          return MaterialApp(
            title: 'Recipe Explorer',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(),
            home: _buildHome(auth),
          );
        },
      ),
    );
  }

  /// Decides which screen to show based on authentication state.
  Widget _buildHome(AuthController auth) {
    if (!auth.initialized) {
      // Minimal splash while loading persisted auth state
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (auth.isLoggedIn) {
      return const HomeShell();
    }
    return const SignInScreen();
  }
}
