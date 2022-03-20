import 'package:ecommerceapp/routes/app_routes.dart';
import 'package:ecommerceapp/screens/buyer/items_list/buyer_items_list.dart';
import 'package:ecommerceapp/screens/drawer/navigation_drawer.dart';
import 'package:flutter/material.dart';
import '../../../size_config.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              tooltip: 'Enter the cart page',
              key: const Key("home_cart_button"),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.cart);
              },
              icon: const Icon(Icons.shopping_cart),
              padding: const EdgeInsets.only(right: 15)),
          IconButton(
              tooltip: 'Enter the Login page',
              key: const Key("home_login_button"),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.login);
              },
              icon: const Icon(Icons.login),
              padding: const EdgeInsets.only(right: 15)),
          IconButton(
              tooltip: 'Enter the Forum page',
              key: const Key("home_forum_button"),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.forum);
              },
              icon: const Icon(Icons.help_outline),
              padding: const EdgeInsets.only(right: 10)),
        ],
      ),
      drawer: const NavigationDrawer(),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 1000,
          ),
          child: const BuyerItemsList(),
        ),
      ),
    );
  }
}
