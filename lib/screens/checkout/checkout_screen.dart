import 'dart:developer';

import 'package:ecommerceapp/routes/app_routes.dart';
import 'package:ecommerceapp/widgets/item_pickup.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceapp/models/user.dart';
import 'package:ecommerceapp/models/item.dart';
import 'package:provider/provider.dart';

import '../../models/auth.dart';
import '../../models/response.dart';
import '../../models/user.dart';
import '../../models/item.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _checkoutKey = GlobalKey<FormState>(debugLabel: 'checkoutKey');

  final List<Item> _items = [
    Item('Men Cloth', 'Men cloth desc', 100,
        'https://i.postimg.cc/Pr0ZZSxG/1641969100f69da7264d8688d9c11e7ce8cd3597b0-thumbnail-900x.jpg'),
    Item('Women Cloth', 'Women cloth desc', 50,
        'https://i.postimg.cc/2yMqQ5Cd/1624937261e1565ed7bb7611d917ff2e6a9ffe580a-thumbnail-900x.jpg'),
    Item('Kids Cloth', 'Kids cloth desc', 80,
        'https://i.postimg.cc/d10DgC1m/16172552205a1794e7dc17db68856850f0c26eeb53-thumbnail-900x.jpg'),
    Item('Home products', 'Home products desc', 120,
        'https://i.postimg.cc/j5kCTjnV/16340030929e7b3bd5c75857d1c040c639acc70476-thumbnail-900x.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    final userAuth = Provider.of<AuthModel>(context);

    final checkoutButton = SizedBox(
      width: MediaQuery.of(context).size.width / 1.5,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            onPrimary: Colors.black,
            primary: Colors.black,
            minimumSize: const Size(80, 60),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(2)),
            )),
        onPressed: () {
          if (userAuth.getCurrentUser() != null) {
            final snackBar = SnackBar(
              content: const Text('Thank you for your order!'),
              action: SnackBarAction(
                label: 'Ok',
                onPressed: () {
                  // Some code to undo the change.
                },
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {
            Navigator.pushNamed(context, AppRoutes.login);
          }
        },
        child: const Text('Check out',
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );
    final allItems = Column(
        children: _items.map((item) => ItemPickedup(item: item)).toList());

    final allItemsGrid = GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      children: _items.map((item) => ItemPickedup(item: item)).toList(),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          children: [
            Column(
              children: <Widget>[
                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.only(left: 15.0, top: 20.0, bottom: 10.0),
                  child: Text(
                    "Here is your order",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                allItemsGrid,
                checkoutButton,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
