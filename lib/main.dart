import 'package:ecommerceapp/models/auth.dart';
import 'package:ecommerceapp/models/cartList.dart';
import 'package:ecommerceapp/routes/app_routes.dart';
import 'package:ecommerceapp/screens/forum/forum_screen.dart';
import 'package:ecommerceapp/screens/home/home.dart';
import 'package:ecommerceapp/screens/login.dart';
import 'package:ecommerceapp/screens/merchant/merchant_category_list.dart';
import 'package:ecommerceapp/screens/merchant/merchant_edit_category.dart';
import 'package:ecommerceapp/screens/merchant/merchant_edit_item.dart';
import 'package:ecommerceapp/screens/profile/profile_screen.dart';
import 'package:ecommerceapp/screens/cart/cart_screen.dart';
import 'package:ecommerceapp/screens/checkout/checkout_screen.dart';
import 'package:ecommerceapp/screens/merchant/merchant_items_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const ECommerceApp());
}

class ECommerceApp extends StatelessWidget {
  const ECommerceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider(create: (context) => AuthModel()),
          ChangeNotifierProvider(create: (context) => CartList())
        ],
        child: ChangeNotifierProvider(
          create: (_) => CartList(),
          child: MaterialApp(
              title: "E-Commerce App",
              debugShowCheckedModeBanner: false,
              home: const Home(),
              routes: {
                AppRoutes.home: (context) => const Home(),
                AppRoutes.login: (context) => const MyLoginPage(),
                AppRoutes.profile: (context) => ProfilePage(),
                AppRoutes.forum: (context) => ForumPage(),
                AppRoutes.cart: (context) => const CartScreen(),
                AppRoutes.checkout: (context) => CheckoutScreen(
                      cartListPrice: 120,
                      cartList: CartList(),
                    ),
                AppRoutes.merchantItems: (context) => const MerchantItemsList(),
                AppRoutes.merchantEditItem: (context) =>
                    const MerchantEditItem(),
                AppRoutes.merchantCategories: (context) =>
                    const MerchantCategoryList(),
                AppRoutes.merchantEditCategory: (context) =>
                    const MerchantEditCategory(),
              }),
        ));
  }
}
