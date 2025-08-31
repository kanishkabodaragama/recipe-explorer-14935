import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_frontend/main.dart';

void main() {
  testWidgets('Shows sign-in screen initially', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Initial splash may show for a brief frame during provider init
    await tester.pumpAndSettle();

    expect(find.text('Sign In'), findsOneWidget);
    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Sign In'), findsWidgets);
  });

  testWidgets('Navigate to sign-up screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    final createAccountButton = find.text('Create account');
    expect(createAccountButton, findsOneWidget);

    await tester.tap(createAccountButton);
    await tester.pumpAndSettle();

    expect(find.text('Sign Up'), findsOneWidget);
    expect(find.text('Create Account'), findsOneWidget);
  });
}
