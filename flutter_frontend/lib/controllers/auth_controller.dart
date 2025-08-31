import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Controller handling authentication state and actions.
class AuthController extends ChangeNotifier {
  static const _kLoggedInKey = 'logged_in';

  bool initialized = false;
  bool isLoggedIn = false;
  bool isAuthenticating = false;

  // PUBLIC_INTERFACE
  /// Initializes the auth controller by loading session from storage.
  Future<void> init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool saved = prefs.getBool(_kLoggedInKey) ?? false;
    isLoggedIn = saved;
    initialized = true;
    notifyListeners();
  }

  // PUBLIC_INTERFACE
  /// Simulates a sign-in process and updates state.
  /// Note: No BuildContext usage post-await to follow async context safety.
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    if (isAuthenticating) return;
    isAuthenticating = true;
    notifyListeners();

    // Simulate network delay
    await Future<void>.delayed(const Duration(milliseconds: 800));

    // Any email/password is accepted in this mock implementation.
    isLoggedIn = true;
    isAuthenticating = false;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kLoggedInKey, true);

    notifyListeners();
  }

  // PUBLIC_INTERFACE
  /// Simulates a sign-up process and updates state.
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    if (isAuthenticating) return;
    isAuthenticating = true;
    notifyListeners();

    // Simulate network delay
    await Future<void>.delayed(const Duration(milliseconds: 1000));

    isLoggedIn = true;
    isAuthenticating = false;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kLoggedInKey, true);

    notifyListeners();
  }

  // PUBLIC_INTERFACE
  /// Signs out current user, clears persisted state.
  Future<void> signOut() async {
    isLoggedIn = false;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kLoggedInKey);
    notifyListeners();
  }
}
