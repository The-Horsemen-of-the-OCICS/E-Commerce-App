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
    });

    testWidgets('As a merchant, I can add a new item',
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

      // find the item name input field
      final Finder itemNameInputField =
          find.byKey(const Key('item_name_input_box'));
      await tester.ensureVisible(itemNameInputField);
      await tester.pumpAndSettle();
      await tester.dragUntilVisible(
        itemNameInputField, // what you want to find
        find.byType(SingleChildScrollView), // widget you want to scroll
        const Offset(0, 50), // delta to move
      );
      await tester.pumpAndSettle();
      await tester.enterText(itemNameInputField, 'Integration Test Item');
      await tester.pumpAndSettle();

      // find the desc name input field
      final Finder itemDescInputField =
          find.byKey(const Key('item_desc_input_box'));
      await tester.ensureVisible(itemDescInputField);
      await tester.pumpAndSettle();
      await tester.dragUntilVisible(
        itemDescInputField, // what you want to find
        find.byType(SingleChildScrollView), // widget you want to scroll
        const Offset(0, 50), // delta to move
      );
      await tester.pumpAndSettle();
      await tester.enterText(
          itemDescInputField, 'Integration Test Description');
      await tester.pumpAndSettle();

      // find the desc name input field
      final Finder itemPriceInputField =
          find.byKey(const Key('item_price_input_box'));
      await tester.ensureVisible(itemPriceInputField);
      await tester.pumpAndSettle();
      await tester.dragUntilVisible(
        itemPriceInputField, // what you want to find
        find.byType(SingleChildScrollView), // widget you want to scroll
        const Offset(0, 50), // delta to move
      );
      await tester.pumpAndSettle();
      await tester.enterText(itemPriceInputField, '25');
      await tester.pumpAndSettle();

      // find the desc name input field
      final Finder itemImageInputField =
          find.byKey(const Key('item_image_input_box'));
      await tester.ensureVisible(itemImageInputField);
      await tester.pumpAndSettle();
      await tester.dragUntilVisible(
        itemImageInputField, // what you want to find
        find.byType(SingleChildScrollView), // widget you want to scroll
        const Offset(0, 50), // delta to move
      );
      await tester.pumpAndSettle();
      await tester.enterText(itemImageInputField,
          'https://i.postimg.cc/j5kCTjnV/16340030929e7b3bd5c75857d1c040c639acc70476-thumbnail-900x.jpg');
      await tester.pumpAndSettle();

      // find the desc name input field
      final Finder itemCategorySelectionField =
          find.byKey(const Key('item_category_selection_box'));
      await tester.ensureVisible(itemCategorySelectionField);
      await tester.pumpAndSettle();
      await tester.dragUntilVisible(
        itemCategorySelectionField, // what you want to find
        find.byType(SingleChildScrollView), // widget you want to scroll
        const Offset(0, 50), // delta to move
      );
      await tester.pumpAndSettle();
      await tester.tap(itemCategorySelectionField);
      await tester.pumpAndSettle();

      // select category 'Men'
      final dropdownItem = find.text("Men").last;

      await tester.tap(dropdownItem);
      await tester.pumpAndSettle();

      // click submit button
      final Finder submitItemButton =
          find.byKey(const Key('submit_item_button'));

      await tester.tap(submitItemButton);
      await tester.pumpAndSettle();
    });
  });
}
