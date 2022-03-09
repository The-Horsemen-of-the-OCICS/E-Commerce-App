import 'dart:ui';
import 'package:ecommerceapp/models/item.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../../size_config.dart';
import 'package:ecommerceapp/utils/application_properties.dart';
import 'package:ecommerceapp/widgets/custom_text.dart';

class MerchantItemCell extends StatefulWidget {
  const MerchantItemCell({Key? key, required this.item}) : super(key: key);

  final Item item;

  @override
  _MerchantItemCellState createState() => _MerchantItemCellState();
}

class _MerchantItemCellState extends State<MerchantItemCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  image: widget.item.image,
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
                    text: widget.item.name,
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
                        '\$${widget.item.price}',
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
                    Text(widget.item.desc,
                        style: Theme.of(context).textTheme.subtitle2)
                  ],
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
