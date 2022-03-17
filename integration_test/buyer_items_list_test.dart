// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ecommerceapp/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('buyer items list test', () {
    testWidgets('add to cart', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Find add to cart button
      final cartButton = find.byKey(const Key('home_add_to_cart_button_1'));
      expect(cartButton, findsOneWidget);

      // Tap add to cart button
      await tester.tap(cartButton.first);
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(SnackBar), findsOneWidget);

      await tester.pump(const Duration(seconds: 3));
    });
    testWidgets('tap item', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Tap the first item in PagedSliverGrid and present item detail popup
      final item = find.byType(Card);
      expect(item, findsWidgets);

      await tester.tap(item.first);
      await tester.pumpAndSettle();

      // Item detail popup should contain a cancel button
      expect(find.text('CANCEL'), findsOneWidget);

      await tester.pump(const Duration(seconds: 3));
    });
  });
}
