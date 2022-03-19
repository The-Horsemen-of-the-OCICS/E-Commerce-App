import 'package:ecommerceapp/routes/app_routes.dart';
import 'package:ecommerceapp/screens/drawer/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ecommerceapp/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('user profile test', () {
    testWidgets('Test navigate to user profile page without login',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // navigate to user profile page directly
      NavigatorState navigatorState = tester.state(find.byType(Navigator));
      navigatorState.pushNamed(AppRoutes.profile);
      await tester.pumpAndSettle();

      // find warning text
      final textFind = find.text('Please login to access your profile!');
      expect(textFind, findsOneWidget);

      // 2s delay to next test
      await tester.pump(new Duration(seconds: 2));
    });

    testWidgets('Test navigate to user profile page after logged in',
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

      // enter an valid credential to the form fields
      await tester.enterText(emailFormFind, 'user1@gmail.com');
      await tester.pumpAndSettle();
      await tester.enterText(passwordFormFind, '123456');
      await tester.pumpAndSettle();

      // find the login button
      final loginButtonFind = find.byType(ElevatedButton);
      expect(loginButtonFind, findsOneWidget);

      // login
      await tester.tap(loginButtonFind);
      await tester.pumpAndSettle();

      // navigate to user profile page directly
      NavigatorState navigatorState = tester.state(find.byType(Navigator));
      navigatorState.pushNamed(AppRoutes.profile);
      await tester.pumpAndSettle();

      // find shipping info text
      final shippingFind = find.byKey(const Key('default_street_field'));
      expect(shippingFind, findsOneWidget);

      // find edit switch
      final switchFind = find.byType(Switch);
      expect(switchFind, findsOneWidget);

      // tap on switch to enable editing
      await tester.tap(switchFind);
      await tester.pumpAndSettle();

      // change address
      await tester.tap(shippingFind);
      await tester.pumpAndSettle();
      await tester.enterText(shippingFind, '');
      await tester.enterText(shippingFind, "testtesttesttesttest");
      await tester.pumpAndSettle();

      // find the submit button
      final submitButtonFind = find.byType(ElevatedButton);
      expect(submitButtonFind, findsOneWidget);

      // submit new address
      await tester.tap(submitButtonFind);
      await tester.pumpAndSettle();

      navigatorState.popAndPushNamed(AppRoutes.profile);
      await tester.pumpAndSettle();

      await tester.pump(const Duration(seconds: 2));

      // find first invoice download button
      final invoiceDownloadFind = find.byType(IconButton);
      expect(invoiceDownloadFind, findsWidgets);
      await tester.tap(invoiceDownloadFind.first);
      await tester.pumpAndSettle();

      await tester.pump(const Duration(seconds: 10));
    });
  });
}
