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

      // // find two input fields in login page
      // final loginTextFormsFind = find.byType(TextFormField);
      // expect(loginTextFormsFind, findsNWidgets(2));

      // final emailFormFind = loginTextFormsFind.first;
      // final passwordFormFind = loginTextFormsFind.last;

      // // enter a valid credential to the form fields
      // await tester.enterText(emailFormFind, 'user1@gmail.com');
      // await tester.pumpAndSettle();
      // await tester.enterText(passwordFormFind, '123456');
      // await tester.pumpAndSettle();

      // // try login
      // await tester.tap(find.byType(ElevatedButton).last);
      // await tester.pumpAndSettle();
      // await tester.pump(const Duration(seconds: 3));

      // // Find add to cart button
      // final loginedCartButton =
      //     find.byKey(const Key('home_add_to_cart_button_1'));
      // expect(loginedCartButton, findsOneWidget);
      // await tester.tap(loginedCartButton.first);
      // await tester.pumpAndSettle();
      // await tester.pump(const Duration(seconds: 1));

      // Added to cart successfully toast displayed
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
