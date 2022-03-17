import 'package:ecommerceapp/models/category.dart';
import 'package:ecommerceapp/screens/merchant/merchant_edit_category.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../../size_config.dart';
import 'package:ecommerceapp/utils/application_properties.dart';
import 'package:ecommerceapp/widgets/custom_text.dart';

class MerchantCategoryCell extends StatefulWidget {
  const MerchantCategoryCell(
      {Key? key,
      required this.itemCategory,
      required this.removeItemCategory,
      required this.editItemCategory})
      : super(key: key);

  final ItemCategory itemCategory;
  final Function removeItemCategory;
  final Function editItemCategory;

  @override
  _MerchantItemCellState createState() => _MerchantItemCellState();
}

class _MerchantItemCellState extends State<MerchantCategoryCell> {
  @override
  Widget build(BuildContext context) {
    final deleteItemCategoryButton = ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(10),
            onPrimary: Colors.red,
            primary: Colors.red,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(2)),
            )),
        onPressed: () {
          widget.removeItemCategory(widget.itemCategory);
        },
        child: const Text('Delete',
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold)));

    final editItemCategoryButton = ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(10),
            onPrimary: Colors.blue,
            primary: Colors.blue,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(2)),
            )),
        onPressed: () {
          Navigator.pushNamed(
            context,
            MerchantEditCategory.routeName,
            arguments: EditCategoryArguments(
                widget.itemCategory.id,
                widget.itemCategory.name,
                widget.itemCategory.icon,
                widget.editItemCategory),
          );
        },
        child: const Text('Edit',
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold)));

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
                  image: widget.itemCategory.icon,
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
                    text: widget.itemCategory.name,
                    size: getProportionateScreenWidth(14),
                    weight: FontWeight.bold,
                  )),
            ],
          )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                  children: [deleteItemCategoryButton, editItemCategoryButton]),
            ],
          )
        ],
      ),
    );
  }
}

class EditCategoryArguments {
  final int id;
  final String name;
  final String icon;
  final Function editItemCategory;

  EditCategoryArguments(this.id, this.name, this.icon, this.editItemCategory);
}
