import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceapp/models/category.dart';
import 'package:ecommerceapp/screens/drawer/navigation_drawer.dart';
import 'package:ecommerceapp/widgets/merchant_category_cell.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerceapp/utils/network_config.dart';
import 'dart:convert';
import 'dart:math';
import 'package:ecommerceapp/models/user.dart';
import 'package:ecommerceapp/screens/login.dart';
import 'package:provider/provider.dart';
import '../../../models/auth.dart';

class MerchantEditCategory extends StatelessWidget {
  const MerchantEditCategory({Key? key}) : super(key: key);

  static const routeName = '/merchant/editCategory';

  Future<void> editCategoryById(
      http.Client client, int id, String newName, String newIcon) async {
    final response = await client.put(
      Uri.parse(NetworkConfig.API_BASE_URL + 'category/' + id.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': id.toString(),
        'name': newName,
        'icon': newIcon
      }),
    );
    // response.statusCode should be 204
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as EditCategoryArguments;

    TextEditingController _name = TextEditingController(text: args.name);
    TextEditingController _icon = TextEditingController(text: args.icon);

    final nameEditBox = Container(
      width: 630,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
          maxLength: 30,
          maxLines: 1,
          controller: _name,
          decoration: const InputDecoration(
            hintText: 'Category Name',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter category name';
            }
            return null;
          }),
    );

    final iconUrlEditBox = Container(
      width: 630,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
          maxLines: 1,
          controller: _icon,
          decoration: const InputDecoration(
            hintText: 'Category Icon Url',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter icon url';
            }
            return null;
          }),
    );

    final editCategoryButton = ElevatedButton(
        style: ElevatedButton.styleFrom(
            onPrimary: Colors.black,
            primary: Colors.black,
            minimumSize: const Size(200, 60),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(2)),
            )),
        onPressed: () {
          editCategoryById(http.Client(), args.id, _name.text, _icon.text);
        },
        child: const Text('Edit',
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold)));

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Edit Merchant Category',
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
                iconUrlEditBox,
                editCategoryButton
              ],
            ),
          ],
        )),
        drawer: const NavigationDrawer());
  }
}
