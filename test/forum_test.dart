import 'package:ecommerceapp/models/auth.dart';
import 'package:ecommerceapp/screens/forum/forum_screen.dart';
import 'package:ecommerceapp/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Login widget functionality test', (WidgetTester tester) async {
    await tester.pumpWidget(Provider<AuthModel>(
      child: MaterialApp(
        home: ForumPage(),
        routes: {
          '/login': (context) => MyLoginPage(),
          '/forum': (context) => ForumPage()
        },
      ),
      create: (context) => AuthModel(),
    ));

    // find three

    // find two input fields
    final postTextFormsFind = find.byType(TextFormField);
    expect(postTextFormsFind, findsNWidgets(2));

    final titleFind = postTextFormsFind.first;
    final bodyFind = postTextFormsFind.last;

    // enter a invalid credential to the form fields
    await tester.enterText(titleFind, 'test post title');
    await tester.enterText(bodyFind, 'test post body');

    // find the submit button
    final submitButtonFind = find.byType(ElevatedButton).last;
    expect(submitButtonFind, findsOneWidget);

    // try submit
    await tester.tap(submitButtonFind);

    // find two input fields
    final loginTextFormsFind = find.byType(TextFormField);
    expect(loginTextFormsFind, findsNWidgets(2));

    final emailFormFind = loginTextFormsFind.first;
    final passwordFormFind = loginTextFormsFind.last;

    // enter a invalid credential to the form fields
    await tester.enterText(emailFormFind, 'user1@gmail.com');
    await tester.enterText(passwordFormFind, '123456');

    // try login
    await tester.tap(find.byType(ElevatedButton).last);

    // try submit
    await tester.tap(submitButtonFind);
  });
}
