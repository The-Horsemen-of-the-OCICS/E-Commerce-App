import 'package:ecommerceapp/routes/app_routes.dart';
import 'package:ecommerceapp/widgets/custom_text.dart';
import 'package:ecommerceapp/widgets/drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ecommerceapp/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Merchant category', () {
    testWidgets('As a merchant, I can view a list of categories',
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
      navigator.pushNamed(AppRoutes.merchantCategories);
      await tester.pumpAndSettle();
    });
    testWidgets('As a merchant, I can add a new category',
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

      // enter merchant category page
      NavigatorState navigator = tester.state(find.byType(Navigator));
      navigator.pushNamed(AppRoutes.merchantCategories);
      await tester.pumpAndSettle();

      // find the category name input field
      final Finder categoryNameInputField =
          find.byKey(const Key('catgory_name_input_box'));
      await tester.ensureVisible(categoryNameInputField);
      await tester.pumpAndSettle();
      await tester.dragUntilVisible(
        categoryNameInputField, // what you want to find
        find.byType(SingleChildScrollView), // widget you want to scroll
        const Offset(0, 50), // delta to move
      );
      await tester.pumpAndSettle();
      await tester.enterText(
          categoryNameInputField, 'Integration Test Category');
      await tester.pumpAndSettle();

      // find the image input field
      final Finder categoryImageInputField =
          find.byKey(const Key('category_image_input_box'));
      await tester.ensureVisible(categoryImageInputField);
      await tester.pumpAndSettle();
      await tester.dragUntilVisible(
        categoryImageInputField, // what you want to find
        find.byType(SingleChildScrollView), // widget you want to scroll
        const Offset(0, 50), // delta to move
      );
      await tester.pumpAndSettle();
      await tester.enterText(categoryImageInputField,
          'https://i.postimg.cc/NfRGJDDv/7534386-cardigan-knitwear-women-fashion-clothing-icon.png');
      await tester.pumpAndSettle();

      // click submit button
      final Finder submitItemButton =
          find.byKey(const Key('catgory_submit_button'));

      await tester.tap(submitItemButton);
      await tester.pumpAndSettle();
    });

    testWidgets('As a merchant, I can edit a category',
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
      navigator.pushNamed(AppRoutes.merchantCategories);
      await tester.pumpAndSettle();

      // find the item name input field
      final Finder editedCategory = find.text("Integration Test Category");
      await tester.ensureVisible(editedCategory);
      await tester.pumpAndSettle();
      await tester.dragUntilVisible(
        editedCategory, // what you want to find
        find.byType(SingleChildScrollView), // widget you want to scroll
        const Offset(0, 50), // delta to move
      );
      await tester.pumpAndSettle();

      final Finder editCategoryButton =
          find.byKey(const Key('edit_category_button')).last;
      await tester.ensureVisible(editCategoryButton);
      await tester.pumpAndSettle();
      await tester.tap(editCategoryButton);
      await tester.pumpAndSettle();
    });

    testWidgets('As a merchant, I can delete a category',
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
      navigator.pushNamed(AppRoutes.merchantCategories);
      await tester.pumpAndSettle();

      // find the category name input field
      final Finder deletedItem = find.text("Integration Test Category");
      await tester.ensureVisible(deletedItem);
      await tester.pumpAndSettle();
      await tester.dragUntilVisible(
        deletedItem, // what you want to find
        find.byType(SingleChildScrollView), // widget you want to scroll
        const Offset(0, 50), // delta to move
      );
      await tester.pumpAndSettle();

      final Finder deleteItemButton =
          find.byKey(const Key('delete_category_button')).last;
      await tester.ensureVisible(deleteItemButton);
      await tester.pumpAndSettle();
      await tester.tap(deleteItemButton);
      await tester.pumpAndSettle();
    });
  });
}
