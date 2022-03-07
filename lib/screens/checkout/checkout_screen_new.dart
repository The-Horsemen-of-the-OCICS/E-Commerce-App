import 'package:flutter/material.dart';
import 'package:ecommerceapp/models/cart.dart';
import 'components/checkout_body.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key, required this.overallPrice})
      : super(key: key);
  final int overallPrice;
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: buildAppBar(context),
      body: CheckoutBody(overallPrice: widget.overallPrice),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Checkout',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
    );
  }
}
