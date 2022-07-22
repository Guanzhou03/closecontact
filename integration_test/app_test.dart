import 'package:close_contact/widgets/card_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../lib/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Sign In', (WidgetTester tester) async {
    app.main();

    await tester.pumpAndSettle();

    final Finder emailFormField = find.byType(TextFormField).first;
    final Finder passwordFormField = find.byType(TextFormField).last;
    final Finder loginButton = find.text("Login");

    await tester.enterText(emailFormField, "test1@u.nus.edu");
    await tester.enterText(passwordFormField, "123456");
    await tester.pumpAndSettle();

    await tester.tap(loginButton);

    await tester.pumpAndSettle();

    //expect(find.byWidget(CardsStackWidget()), findsOneWidget);

    await tester.pumpAndSettle();
  });
}
