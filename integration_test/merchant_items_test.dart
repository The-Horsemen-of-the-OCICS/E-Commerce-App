import 'package:ecommerceapp/routes/app_routes.dart';
import 'package:ecommerceapp/widgets/custom_text.dart';
import 'package:ecommerceapp/widgets/drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ecommerceapp/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Merchant Items', () {
    testWidgets('As a merchant, I can view a list of items',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // find login button on home page
      final homeLoginButtonFind = find.byKey(const Key("home_login_button"));
      expect(homeLoginButtonFind, findsOneWidget);

      // tap and enter login page
      await tester.tap(homeLoginButtonFind);
      await tester.pumpAndSettle();

      // find two input fields
      final textFormsFind = find.byType(TextFormField);
      expect(textFormsFind, findsNWidgets(2));

      final emailFormFind = textFormsFind.first;
      final passwordFormFind = textFormsFind.last;

      await tester.enterText(emailFormFind, 'admin@gmail.com');
      await tester.pumpAndSettle();
      await tester.enterText(passwordFormFind, '123456');
      await tester.pumpAndSettle();

      // find the login button
      final loginButtonFind = find.byType(ElevatedButton);
      expect(loginButtonFind, findsOneWidget);

      // try login
      await tester.tap(find.byType(ElevatedButton).last);
      await tester.pumpAndSettle();

      // enter merchant items page
      NavigatorState navigator = tester.state(find.byType(Navigator));
      navigator.pushNamed(AppRoutes.merchantItems);
      await tester.pumpAndSettle();

      // find the login button
      final merchantItemsPage = find.byKey(const Key('merchant_items_page'));
      await tester.pumpAndSettle();
      expect(merchantItemsPage, findsOneWidget);
    });
  });
}
