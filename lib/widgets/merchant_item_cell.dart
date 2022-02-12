import 'package:ecommerceapp/models/item.dart';
import 'package:flutter/material.dart';

class MerchantItemCell extends StatefulWidget {
  const MerchantItemCell({Key? key, required this.item}) : super(key: key);

  final Item item;

  @override
  _MerchantItemCellState createState() => _MerchantItemCellState();
}

class _MerchantItemCellState extends State<MerchantItemCell> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        widget.item.name +
            " " +
            widget.item.desc +
            " \$" +
            widget.item.price.toString(),
        textAlign: TextAlign.center,
      ),
    );
  }
}
