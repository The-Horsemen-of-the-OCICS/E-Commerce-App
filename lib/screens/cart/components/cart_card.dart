import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ecommerceapp/models/cart.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../../size_config.dart';
import 'package:ecommerceapp/utils/application_properties.dart';
import 'package:ecommerceapp/widgets/custom_text.dart';

class CartCard extends StatefulWidget {
  const CartCard({
    Key? key,
    required this.cartItem,
    required this.cartList,
  }) : super(key: key);

  final Cart cartItem;
  final CartList cartList;
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
        mainAxisAlignment: MainAxisAlignment.center,
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
                  image: widget.cartItem.item.image,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(top: getProportionateScreenHeight(5)),
                  padding: EdgeInsets.all(8),
                  child: CustomText(
                    text: widget.cartItem.item.name,
                    size: getProportionateScreenWidth(14),
                    weight: FontWeight.bold,
                  )),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    SizedBox(
                      width: 40,
                      child: Text(
                        '\$${widget.cartItem.item.price}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFF7643),
                          fontFeatures: [
                            FontFeature.tabularFigures(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                        'Sub: \$${widget.cartItem.item.price * widget.cartItem.numOfItem}',
                        style: Theme.of(context).textTheme.subtitle2)
                  ],
                ),
              ),
            ],
          )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  InkWell(
                      child: Container(
                        child: const Icon(
                          Icons.chevron_left,
                          size: 35.0,
                        ),
                      ),
                      onTap: () {
                        widget.cartList.reduce(widget.cartItem);
                      }),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(
                      text: widget.cartItem.numOfItem.toString(),
                    ),
                  ),
                  InkWell(
                      child: Container(
                        child: const Icon(
                          Icons.chevron_right,
                          size: 35.0,
                        ),
                      ),
                      onTap: () {
                        widget.cartList.add(widget.cartItem);
                      }),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
