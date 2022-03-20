import 'dart:ui';
import 'package:ecommerceapp/models/category.dart';
import 'package:ecommerceapp/models/item.dart';
import 'package:ecommerceapp/screens/merchant/merchant_edit_item.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../../size_config.dart';
import 'package:ecommerceapp/utils/application_properties.dart';
import 'package:ecommerceapp/widgets/custom_text.dart';

class MerchantItemCell extends StatefulWidget {
  const MerchantItemCell(
      {Key? key,
      required this.item,
      required this.removeItem,
      required this.editItem,
      required this.categorise})
      : super(key: key);

  final Item item;
  final List<ItemCategory> categorise;
  final Function removeItem;
  final Function editItem;

  @override
  _MerchantItemCellState createState() => _MerchantItemCellState();
}

class _MerchantItemCellState extends State<MerchantItemCell> {
  @override
  Widget build(BuildContext context) {
    final deleteItemButton = InkWell(
        key: const Key('delete_item_key'),
        child: Container(
          child: const Icon(
            Icons.delete,
            size: 25.0,
          ),
        ),
        onTap: () {
          widget.removeItem(widget.item);
        });
    final editItemButton = InkWell(
        key: const Key('edit_item_key'),
        child: Container(
          child: const Icon(
            Icons.edit,
            size: 25.0,
          ),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            MerchantEditItem.routeName,
            arguments: EditItemArguments(
                widget.item.id,
                widget.item.name,
                widget.item.desc,
                widget.item.price,
                widget.item.image,
                widget.item.categoryId,
                widget.categorise,
                widget.editItem),
          );
        });

    return Container(
      constraints: const BoxConstraints(
        maxWidth: 800,
      ),
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
                  child: Text(widget.item.name,
                      style: Theme.of(context).textTheme.titleLarge)),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    SizedBox(
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(children: [
                deleteItemButton,
                const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                editItemButton,
                const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
              ]),
            ],
          )
        ],
      ),
    );
  }
}

class EditItemArguments {
  final int id;
  final String name;
  final String desc;
  final double price;
  final String image;
  final int categoryId;
  final List<ItemCategory> categories;
  final Function editItem;

  EditItemArguments(this.id, this.name, this.desc, this.price, this.image,
      this.categoryId, this.categories, this.editItem);
}
