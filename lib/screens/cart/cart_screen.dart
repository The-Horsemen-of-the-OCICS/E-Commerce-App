import 'package:flutter/material.dart';
import 'package:ecommerceapp/models/cart.dart';
import 'package:ecommerceapp/screens/drawer/navigation_drawer.dart';
import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";

  final overallPrice = demoCarts
      .map((cart) => cart.item.price * cart.numOfItem)
      .reduce((value, element) => value + element);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: Body(),
        bottomNavigationBar: CheckoutCard(overallPrice: overallPrice),
        drawer: const NavigationDrawer());
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Color(0xff202020)),
      title: Column(
        children: [
          Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
