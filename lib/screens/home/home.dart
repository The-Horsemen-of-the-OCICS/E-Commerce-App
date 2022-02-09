import 'package:ecommerceapp/screens/buyer/items_list/buyer_items_list.dart';
import 'package:ecommerceapp/screens/drawer/navigation_drawer.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      drawer: const NavigationDrawer(),
      body: const BuyerItemsList(),
    );
  }
}
