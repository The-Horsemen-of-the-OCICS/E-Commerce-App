import 'package:ecommerceapp/models/auth.dart';
import 'package:ecommerceapp/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Login widget functionality test', (WidgetTester tester) async {
    await tester.pumpWidget(Provider<AuthModel>(
      child: MaterialApp(home: MyLoginPage()),
      create: (context) => AuthModel(),
    ));

    // find two input fields
    final textFormsFind = find.byType(TextFormField);
    expect(textFormsFind, findsNWidgets(2));

    final emailFormFind = textFormsFind.first;
    final passwordFormFind = textFormsFind.last;

    // enter a invalid credential to the form fields
    await tester.enterText(emailFormFind, 'admin@gmail.com');
    await tester.enterText(passwordFormFind, '1234567');

    // find the login button
    final loginButtonFind = find.byType(ElevatedButton);
    expect(loginButtonFind, findsOneWidget);

    // try login
    await tester.tap(loginButtonFind);

    // find login failed snackbar
    final snackBarFind = find.byType(SnackBar);
    expect(snackBarFind, findsOneWidget);
  });
}
