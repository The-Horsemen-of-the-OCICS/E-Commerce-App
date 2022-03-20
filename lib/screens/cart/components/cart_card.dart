import 'dart:ui';

import 'package:ecommerceapp/models/cartItem.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceapp/models/cartList.dart';
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

  final CartItem cartItem;
  final CartList cartList;
  @override
  _ShopItemListState createState() => _ShopItemListState();
}

class _ShopItemListState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 800,
        ),
        height: 140,
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
                  padding: EdgeInsets.all(5),
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
                    image: widget.cartItem.image,
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
                    margin:
                        EdgeInsets.only(top: getProportionateScreenHeight(5)),
                    padding: EdgeInsets.all(8),
                    child: CustomText(
                      text: widget.cartItem.name,
                      size: 20,
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
                          '\$${widget.cartItem.itemPrice}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFFF7643),
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
                          'Sub: \$${widget.cartItem.itemPrice * widget.cartItem.quantity}',
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
                        key:
                            Key("cart_decrease_quantity_${widget.cartItem.id}"),
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
                        key: Key("cart_quantity_${widget.cartItem.id}"),
                        text: widget.cartItem.quantity.toString(),
                      ),
                    ),
                    InkWell(
                        key:
                            Key("cart_increase_quantity_${widget.cartItem.id}"),
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
      ),
    );
  }
}
