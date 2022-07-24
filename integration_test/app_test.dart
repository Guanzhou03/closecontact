import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../lib/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Register', (WidgetTester tester) async {
    await tester.pumpWidget(app.MyApp());

    await tester.pumpAndSettle();
    final Finder registerButton = find.text("Register");

    await tester.tap(registerButton);

    await tester.pumpAndSettle();

    expect(find.text("Confirm password"), findsOneWidget);
    final Finder nameField = find.byKey(Key("name"));
    final Finder emailField = find.byKey(Key("email"));
    final Finder passwordField = find.byKey(Key("password"));
    final Finder confirmPasswordField = find.byKey(Key("confirmPassword"));

    await tester.pumpAndSettle();

    await tester.enterText(nameField, "test");
    await tester.enterText(emailField, "testing6@u.nus.edu");
    await tester.enterText(passwordField, "123456");
    await tester.enterText(confirmPasswordField, "123456");

    await tester.tap(find.byType(ElevatedButton));

    await tester.pumpAndSettle(Duration(seconds: 10));

    expect(find.text("Email verification sent!"), findsOneWidget);
  });

  testWidgets("Sign In", (WidgetTester tester) async {
    await tester.pumpWidget(app.MyApp());
    await tester.pumpAndSettle();

    final Finder emailFormField = find.byType(TextFormField).first;
    final Finder passwordFormField = find.byType(TextFormField).last;
    final Finder loginButton = find.text("Login");

    await tester.enterText(emailFormField, "test1@u.nus.edu");
    await tester.enterText(passwordFormField, "123456");

    await tester.tap(loginButton);
    await tester.pumpAndSettle(Duration(seconds: 1));

    expect(find.text("Find Close Contacts"), findsOneWidget);

    await tester.pumpAndSettle();
  });

  testWidgets("Reset Password", (WidgetTester tester) async {
    await tester.pumpWidget(app.MyApp());
    await tester.pumpAndSettle();

    final Finder forgetPasswordButton = find.text("Forgot Password");

    await tester.tap(forgetPasswordButton);

    await tester.pumpAndSettle();

    final Finder resetEmailField = find.byKey(Key("resetEmail"));
    await tester.enterText(resetEmailField, "e0725800@u.nus.edu");
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle(Duration(seconds: 5));
    expect(
        find.text(
            "Password reset email has been sent! Follow the instructions in your email to reset your password."),
        findsOneWidget);

    await tester.pumpAndSettle();
  });
}
