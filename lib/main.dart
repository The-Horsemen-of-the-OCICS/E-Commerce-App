import 'package:ecommerceapp/models/auth.dart';
import 'package:ecommerceapp/routes/app_routes.dart';
import 'package:ecommerceapp/screens/forum/forum_screen.dart';
import 'package:ecommerceapp/screens/home/home.dart';
import 'package:ecommerceapp/screens/login.dart';
import 'package:ecommerceapp/screens/profile/profile_screen.dart';
import 'package:ecommerceapp/screens/cart/cart_screen.dart';
import 'package:ecommerceapp/screens/checkout/checkout_screen.dart';
import 'package:ecommerceapp/screens/checkout/checkout_screen_new.dart';
import 'package:ecommerceapp/screens/merchant/items_list/merchant_items_list.dart';
import 'package:ecommerceapp/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerceapp/screens/checkout/components/checkout_body.dart';

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
        ],
        child: MaterialApp(
            title: "E-Commerce App",
            debugShowCheckedModeBanner: false,
            home: const Home(),
            routes: {
              AppRoutes.home: (context) => const Home(),
              AppRoutes.login: (context) => const MyLoginPage(),
              AppRoutes.profile: (context) => ProfilePage(),
              AppRoutes.forum: (context) => ForumPage(),
              AppRoutes.cart: (context) => CartScreen(),
              AppRoutes.checkout: (context) => const CheckoutScreen(
                    overallPrice: 120,
                  ),
              AppRoutes.merchant: (context) => const MerchantItemsList(),
            }));
  }
}
