import 'package:ecommerceapp/models/category.dart';
import 'package:ecommerceapp/models/item.dart';
import 'package:ecommerceapp/screens/merchant/merchant_edit_category.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../../size_config.dart';
import 'package:ecommerceapp/utils/application_properties.dart';
import 'package:ecommerceapp/widgets/custom_text.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerceapp/utils/network_config.dart';
import 'dart:convert';

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
  Future<List<Item>> fetchItemsByCategory(
      http.Client client, String categoryId) async {
    final response = await client.get(Uri.parse(
        NetworkConfig.API_BASE_URL + 'item/category/' + categoryId.toString()));

    return jsonDecode(response.body)
        .map<Item>((json) => Item.fromJson(json))
        .toList();
  }

  Future<void> editItemById(
      http.Client client,
      String id,
      String newName,
      String newDesc,
      double newPrice,
      String newImage,
      String newDate,
      String newCategoryId) async {
    final response = await client.put(
      Uri.parse(NetworkConfig.API_BASE_URL + 'item/' + id.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': id.toString(),
        'name': newName,
        'description': newDesc,
        'price': newPrice,
        'image': newImage,
        'date': newDate,
        'categoryId': newCategoryId
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deleteItemCategoryButton = InkWell(
        key: Key('delete_category_button'),
        child: Container(
          child: const Icon(
            Icons.delete,
            size: 25.0,
          ),
        ),
        onTap: () {
          widget.removeItemCategory(widget.itemCategory);
          fetchItemsByCategory(http.Client(), widget.itemCategory.id)
              .then((categories) {
            for (int i = 0; i < categories.length; ++i) {
              editItemById(
                  http.Client(),
                  categories[i].id,
                  categories[i].name,
                  categories[i].desc,
                  categories[i].price,
                  categories[i].image,
                  DateTime.now().toString(),
                  "-1");
            }
          });
        });

    final editItemCategoryButton = InkWell(
        key: Key('edit_category_button'),
        child: Container(
          child: const Icon(
            Icons.edit,
            size: 25.0,
          ),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            MerchantEditCategory.routeName,
            arguments: EditCategoryArguments(
                widget.itemCategory.id,
                widget.itemCategory.name,
                widget.itemCategory.icon,
                widget.editItemCategory),
          );
        });

    return Container(
      key: Key('category_cell'),
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
                  child: Text(widget.itemCategory.name,
                      style: Theme.of(context).textTheme.titleLarge)),
            ],
          )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(children: [
                deleteItemCategoryButton,
                const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                editItemCategoryButton,
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

class EditCategoryArguments {
  final String id;
  final String name;
  final String icon;
  final Function editItemCategory;

  EditCategoryArguments(this.id, this.name, this.icon, this.editItemCategory);
}
