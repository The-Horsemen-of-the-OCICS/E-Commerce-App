import 'package:ecommerceapp/routes/app_routes.dart';
import 'package:ecommerceapp/widgets/question_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ecommerceapp/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('forum test', () {
    testWidgets('Test navigate to forum page and try post',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // find forum button on home page
      final homeForumButtonFind = find.byKey(const Key("home_forum_button"));
      expect(homeForumButtonFind, findsOneWidget);

      // tap and enter forum page
      await tester.tap(homeForumButtonFind);
      await tester.pumpAndSettle();

      // find two input fields
      final postTextFormsFind = find.byType(TextFormField);
      expect(postTextFormsFind, findsNWidgets(2));

      final titleFind = postTextFormsFind.first;
      final bodyFind = postTextFormsFind.last;

      // enter new post text
      await tester.enterText(titleFind, 'test post title');
      await tester.pumpAndSettle();
      await tester.enterText(bodyFind, 'test post body');
      await tester.pumpAndSettle();

      // find the submit button
      final submitButtonFind = find.byKey(const Key("submit_question_button"));
      expect(submitButtonFind, findsOneWidget);

      // try submit and get redirect to login page
      await tester.ensureVisible(submitButtonFind);
      await tester.pumpAndSettle();
      await tester.tap(submitButtonFind);
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

      // back to forum page and try submit
      await tester.ensureVisible(submitButtonFind);
      await tester.pumpAndSettle();
      await tester.tap(submitButtonFind);
      await tester.pumpAndSettle();

      // 2s delay to next test
      await tester.pump(new Duration(seconds: 2));
    });

    testWidgets('Test open a question and add response',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // enter forum page
      NavigatorState navigator = tester.state(find.byType(Navigator));
      navigator.pushNamed(AppRoutes.forum);
      await tester.pumpAndSettle();

      // find press on the first question
      final questionFind = find.byType(QuestionPost);
      expect(questionFind, findsWidgets);

      await tester.tap(questionFind.first);
      await tester.pumpAndSettle();

      // find response textfield
      final responseFormFind = find.byType(TextFormField);
      expect(responseFormFind, findsOneWidget);

      // enter new response text
      await tester.enterText(responseFormFind, 'test new response');
      await tester.pumpAndSettle();

      // find the submit button
      final submitButtonFind = find.byKey(const Key("submit_response_button"));
      expect(submitButtonFind, findsOneWidget);

      // try submit and get redirect to login page
      await tester.ensureVisible(submitButtonFind);
      await tester.pumpAndSettle();
      await tester.tap(submitButtonFind);
      await tester.pumpAndSettle();

      // find two input fields
      final loginTextFormsFind = find.byType(TextFormField);
      expect(loginTextFormsFind, findsNWidgets(2));

      final emailFormFind = loginTextFormsFind.first;
      final passwordFormFind = loginTextFormsFind.last;

      // enter a valid credential to the form fields
      await tester.enterText(emailFormFind, 'user1@gmail.com');
      await tester.enterText(passwordFormFind, '123456');

      await tester.pump(new Duration(seconds: 1));

      // try login
      await tester.tap(find.byType(ElevatedButton).last);
      await tester.pumpAndSettle();

      // back to question detail page and try submit
      await tester.ensureVisible(submitButtonFind);
      await tester.tap(submitButtonFind);
      await tester.pumpAndSettle();
    });
  });
}
