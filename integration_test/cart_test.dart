import 'package:ecommerceapp/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ecommerceapp/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('cart test', () {
    testWidgets('Test navigate to cart page and try checkout',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // find cart button on home page
      final homeCartButtonFind = find.byKey(const Key("home_cart_button"));
      expect(homeCartButtonFind, findsOneWidget);

      // tap and enter cart page
      await tester.tap(homeCartButtonFind);
      await tester.pumpAndSettle();

      // find the login button
      final loginButton = find.byKey(const Key("cart_login_button"));
      expect(loginButton, findsOneWidget);

      // tap login button
      await tester.ensureVisible(loginButton);
      await tester.pumpAndSettle();
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // find two input fields
      final loginTextFormsFind = find.byType(TextFormField);
      expect(loginTextFormsFind, findsNWidgets(2));

      final emailFormFind = loginTextFormsFind.first;
      final passwordFormFind = loginTextFormsFind.last;

      // enter a valid credential to the form fields
      await tester.enterText(emailFormFind, 'user1@gmail.com');
      await tester.pumpAndSettle();
      await tester.enterText(passwordFormFind, '123456');
      await tester.pumpAndSettle();

      // try login
      await tester.tap(find.byType(ElevatedButton).last);
      await tester.pumpAndSettle();

      // back to cart page and go to home page to add items
      final cartToHomeButton = find.byKey(const Key("cart_to_home_button"));
      await tester.ensureVisible(cartToHomeButton);
      await tester.pumpAndSettle();
      await tester.tap(cartToHomeButton);
      await tester.pumpAndSettle();

      // add a new item to cart
      final addItemButton = find.byKey(const Key("home_add_to_cart_button_1"));
      await tester.ensureVisible(addItemButton);
      await tester.pumpAndSettle();
      await tester.tap(addItemButton);
      await tester.pumpAndSettle();

      // go to cart page
      await tester.tap(homeCartButtonFind);
      await tester.pumpAndSettle();

      // find the checkout button
      final checkoutButton = find.byKey(const Key("cart_checkout_button"));
      await tester.ensureVisible(checkoutButton);
      await tester.pumpAndSettle();
      await tester.tap(checkoutButton);

      // 2s delay to next test
      await tester.pump(new Duration(seconds: 2));
    });
  });
}
