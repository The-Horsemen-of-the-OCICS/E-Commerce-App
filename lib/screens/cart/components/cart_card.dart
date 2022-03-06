import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ecommerceapp/models/cart.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../../size_config.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(5)),
              decoration: BoxDecoration(
                  color: Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26.withOpacity(0.1),
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.10)
                  ]),
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: cart.item.image,
              ),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cart.item.name,
              style: TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(
                  width: 40,
                  child: Text(
                    '\$${cart.item.price}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFFF7643),
                      fontFeatures: [
                        FontFeature.tabularFigures(),
                      ],
                    ),
                  ),
                ),
                Text('x${cart.numOfItem}',
                    style: Theme.of(context).textTheme.bodyText1)
              ],
            ),
          ],
        )
      ],
    );
  }
}
