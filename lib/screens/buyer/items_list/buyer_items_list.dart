import 'package:ecommerceapp/screens/drawer/navigation_drawer.dart';
import 'package:flutter/material.dart';

class BuyerItemsList extends StatelessWidget {
  const BuyerItemsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      drawer: NavigationDrawer(),
    );
  }
}