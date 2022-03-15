import 'package:ecommerceapp/routes/app_routes.dart';
import 'package:ecommerceapp/widgets/question_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ecommerceapp/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('login test', () {
    testWidgets('Test navigate to login page and try login',
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

      // enter an INVALID credential to the form fields
      await tester.enterText(emailFormFind, 'admin@gmail.com');
      await tester.pumpAndSettle();
      await tester.enterText(passwordFormFind, '()!@()Jf8q2jd');
      await tester.pumpAndSettle();

      // find the login button
      final loginButtonFind = find.byType(ElevatedButton);
      expect(loginButtonFind, findsOneWidget);

      // try login
      await tester.tap(loginButtonFind);
      await tester.pump();

      // find login failed warning snackbar
      final snackBarFind = find.byKey(const Key("login_error_snackbar"));
      expect(snackBarFind, findsOneWidget);

      // try enter correct password
      await tester.enterText(passwordFormFind, '123456');
      await tester.pumpAndSettle();

      // try login again
      await tester.tap(loginButtonFind);
      await tester.pumpAndSettle();
    });
  });
}
