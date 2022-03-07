import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:ecommerceapp/models/cart.dart';
import 'package:ecommerceapp/utils/application_properties.dart';
import '../../../size_config.dart';
import 'package:transparent_image/transparent_image.dart';

class ShopItemList extends StatefulWidget {
  final Cart cart;

  const ShopItemList({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  _ShopItemListState createState() => _ShopItemListState();
}

class _ShopItemListState extends State<ShopItemList> {
  int numberOfItems = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Container(
                height: 130,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: shadow,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Row(children: <Widget>[
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
                  SizedBox(width: 20),
                  Container(
                    padding: EdgeInsets.only(top: 12.0, right: 12.0),
                    width: getProportionateScreenWidth(180),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.cart.item.name,
                          style: TextStyle(color: Colors.black, fontSize: 18),
                          maxLines: 2,
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            SizedBox(
                              width: 40,
                              child: Text(
                                '\$${widget.cart.item.price}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFFF7643),
                                ),
                              ),
                            ),
                            Text('x${numberOfItems}',
                                style: Theme.of(context).textTheme.bodyText1)
                          ],
                        ),
                      ],
                    ),
                  ),
                  Theme(
                      data: ThemeData(
                          accentColor: Colors.black,
                          textTheme: TextTheme(
                            headline6: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            bodyText1: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 12,
                              color: Colors.grey[400],
                            ),
                          )),
                      child: NumberPicker(
                        value: widget.cart.numOfItem,
                        minValue: 1,
                        maxValue: 10,
                        onChanged: (value) {
                          setState(() {
                            numberOfItems = value;
                          });
                        },
                      ))
                ])),
          ),
        ],
      ),
    );
  }
}
