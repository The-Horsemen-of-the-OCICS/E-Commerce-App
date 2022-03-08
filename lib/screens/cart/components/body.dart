import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ecommerceapp/models/cart.dart';
import 'cart_card.dart';
import 'cart_cart1.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  final CartList cartList;

  const Body({Key? key, required this.cartList}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ListView.builder(
        itemCount: widget.cartList.cartItems.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: Key(widget.cartList.cartItems[index].item.id.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                widget.cartList.remove(widget.cartList.cartItems[index]);
              });
            },
            background: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE6E6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  const Spacer(),
                  SvgPicture.asset("assets/icons/Trash.svg"),
                ],
              ),
            ),
            child: CartCard(cart: widget.cartList.cartItems[index]),
          ),
        ),
      ),
    );
  }
}
