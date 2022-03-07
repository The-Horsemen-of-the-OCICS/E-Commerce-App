import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ecommerceapp/models/cart.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../../size_config.dart';
import 'package:ecommerceapp/utils/application_properties.dart';

class CartCard extends StatefulWidget {
  const CartCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;
  @override
  _ShopItemListState createState() => _ShopItemListState();
}

class _ShopItemListState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: shadow,
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 98,
            child: AspectRatio(
              aspectRatio: 0.7,
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
                  image: widget.cart.item.image,
                ),
              ),
            ),
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: getProportionateScreenHeight(5)),
                padding: EdgeInsets.all(8),
                child: Text(
                  widget.cart.item.name,
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(14),
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    SizedBox(
                      width: 40,
                      child: Text(
                        '\$${widget.cart.item.price}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFF7643),
                          fontFeatures: [
                            FontFeature.tabularFigures(),
                          ],
                        ),
                      ),
                    ),
                    Text('x${widget.cart.numOfItem}',
                        style: Theme.of(context).textTheme.bodyText1)
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                        'Sub: ${widget.cart.item.price * widget.cart.numOfItem}',
                        style: Theme.of(context).textTheme.subtitle2)
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
