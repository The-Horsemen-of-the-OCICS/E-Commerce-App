import 'package:ecommerceapp/models/item.dart';
import 'package:ecommerceapp/widgets/merchant_item_cell.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceapp/models/category.dart';
import 'package:ecommerceapp/screens/drawer/navigation_drawer.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerceapp/utils/network_config.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class MerchantEditItem extends StatelessWidget {
  const MerchantEditItem({Key? key}) : super(key: key);

  static const routeName = '/merchant/editItem';

  Future<List<ItemCategory>> fetchCategories(http.Client client) async {
    final response =
        await client.get(Uri.parse(NetworkConfig.API_BASE_URL + 'category/'));

    return jsonDecode(response.body)
        .map<ItemCategory>((json) => ItemCategory.fromJson(json))
        .toList();
  }

  Future<void> editItemById(
      http.Client client,
      int id,
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

    if (response.statusCode == 204) {
      Fluttertoast.showToast(msg: 'Update successfully!');
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as EditItemArguments;

    List<ItemCategory> _merchantCategories = args.categories;
    String _categoryId = args.categoryId.toString();

    final TextEditingController _name = TextEditingController(text: args.name);
    final TextEditingController _desc = TextEditingController(text: args.desc);
    final TextEditingController _price =
        TextEditingController(text: args.price.toString());
    final TextEditingController _image =
        TextEditingController(text: args.image);

    final nameEditBox = Container(
      width: 630,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
          maxLength: 30,
          maxLines: 1,
          controller: _name,
          decoration: const InputDecoration(
            hintText: 'Item Name',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter item name';
            }
            return null;
          }),
    );

    final descEditBox = Container(
      width: 630,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
          maxLength: 30,
          maxLines: 1,
          controller: _desc,
          decoration: const InputDecoration(
            hintText: 'Item Description',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter item description';
            }
            return null;
          }),
    );

    final priceInputBox = Container(
      width: 630,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
          maxLength: 30,
          maxLines: 1,
          controller: _price,
          decoration: const InputDecoration(
            hintText: 'Item Price',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter item price';
            }
            return null;
          }),
    );

    final imageUrlEditBox = Container(
      width: 630,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
          maxLines: 1,
          controller: _image,
          decoration: const InputDecoration(
            hintText: 'Item Image Url',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter item image url';
            }
            return null;
          }),
    );

    final categorySelectionBox = Container(
      width: 630,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: DropdownButtonFormField<String>(
        decoration:
            const InputDecoration(labelText: 'Please select a category'),
        value: _categoryId,
        items: _merchantCategories.map<DropdownMenuItem<String>>(
          (ItemCategory itemCategory) {
            return DropdownMenuItem(
              child: Text(itemCategory.name),
              value: itemCategory.id.toString(),
            );
          },
        ).toList(),
        onChanged: (String? value) {
          _categoryId = value!;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select category';
          }
          return null;
        },
      ),
    );

    final submitItemButton = ElevatedButton(
        style: ElevatedButton.styleFrom(
            onPrimary: Colors.black,
            primary: Colors.black,
            minimumSize: const Size(200, 60),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(2)),
            )),
        onPressed: () {
          editItemById(
                  http.Client(),
                  args.id,
                  _name.text,
                  _desc.text,
                  double.parse(_price.text),
                  _image.text,
                  DateTime.now().toString(),
                  _categoryId)
              .then((value) {
            args.editItem(Item(
                id: args.id,
                name: _name.text,
                desc: _desc.text,
                price: double.parse(_price.text),
                image: _image.text,
                categoryId: int.parse(_categoryId)));
          });
        },
        child: const Text('Submit',
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold)));

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Edit Merchant Item',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Center(
            child: ListView(
          children: [
            Column(
              children: <Widget>[
                nameEditBox,
                descEditBox,
                priceInputBox,
                imageUrlEditBox,
                categorySelectionBox,
                submitItemButton
              ],
            ),
          ],
        )),
        drawer: const NavigationDrawer());
  }
}
