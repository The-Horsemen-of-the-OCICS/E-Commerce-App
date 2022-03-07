import 'package:ecommerceapp/routes/app_routes.dart';
import 'package:ecommerceapp/screens/buyer/items_list/buyer_items_list.dart';
import 'package:ecommerceapp/screens/drawer/navigation_drawer.dart';
import 'package:flutter/material.dart';
import '../../../size_config.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

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
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.cart);
              },
              icon: const Icon(Icons.shopping_cart),
              padding: const EdgeInsets.only(right: 15)),
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.login);
              },
              icon: const Icon(Icons.login),
              padding: const EdgeInsets.only(right: 15)),
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.forum);
              },
              icon: const Icon(Icons.help_outline),
              padding: const EdgeInsets.only(right: 10)),
        ],
      ),
      drawer: const NavigationDrawer(),
      body: const BuyerItemsList(),
    );
  }
}
