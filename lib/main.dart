import 'package:ecommerceapp/routes/app_routes.dart';
import 'package:ecommerceapp/screens/forum/forum_screen.dart';
import 'package:ecommerceapp/screens/home/home.dart';
import 'package:ecommerceapp/screens/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ECommerceApp());
}

class ECommerceApp extends StatelessWidget {
  const ECommerceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "E-Commerce App", home: const Home(), routes: {
      AppRoutes.home: (context) => const Home(),
      AppRoutes.login: (context) => const MyLoginPage(),
      AppRoutes.forum: (context) => ForumPage()
    });
  }
}
