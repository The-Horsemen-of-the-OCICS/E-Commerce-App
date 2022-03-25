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

class MerchantCategoryList extends StatefulWidget {
  const MerchantCategoryList({Key? key}) : super(key: key);

  @override
  State<MerchantCategoryList> createState() => _MerchantCategoryListState();
}

class _MerchantCategoryListState extends State<MerchantCategoryList> {
  final _formKey = GlobalKey<FormState>();
  List<ItemCategory> _categories = [];

  Future<List<ItemCategory>> fetchCategories(http.Client client) async {
    final response =
        await client.get(Uri.parse(NetworkConfig.API_BASE_URL + 'category/'));

    return jsonDecode(response.body)
        .map<ItemCategory>((json) => ItemCategory.fromJson(json))
        .toList();
  }

  Future<void> deleteCategoryById(http.Client client, String id) async {
    await client.delete(
        Uri.parse(NetworkConfig.API_BASE_URL + 'category/' + id.toString()));
  }

  Future<ItemCategory> createItemCategory(
      http.Client client, ItemCategory itemCategory) async {
    final response = await client.post(
      Uri.parse(NetworkConfig.API_BASE_URL + 'category/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': itemCategory.id.toString(),
        'name': itemCategory.name,
        'icon': itemCategory.icon
      }),
    );

    return ItemCategory.fromJson(jsonDecode(response.body));
  }

  TextEditingController _name = TextEditingController(text: "");
  TextEditingController _icon = TextEditingController(text: "");

  void removeItemCategory(ItemCategory itemCategory) {
    var index = _categories.indexWhere((element) =>
        element.name == itemCategory.name && element.icon == itemCategory.icon);

    deleteCategoryById(http.Client(), itemCategory.id);

    setState(() {
      _categories.removeAt(index);
    });
  }

  void editItemCategory(ItemCategory itemCategory) {
    var index =
        _categories.indexWhere((element) => element.id == itemCategory.id);

    setState(() {
      _categories[index] = itemCategory;
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<AuthModel>(context).getCurrentUser();
    if (user == null || user.email != 'admin@gmail.com') {
      return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Merchant Category List',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
          ),
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Please login as an admin to view categories",
                  style: TextStyle(fontSize: 18),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: ElevatedButton(
                    child: const Text("Login"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyLoginPage()),
                      ).then((value) {
                        setState(() {});
                      });
                    },
                  ),
                )
              ],
            ),
          ));
    }

    if (_categories.isEmpty) {
      fetchCategories(http.Client()).then((categories) {
        setState(() {
          _categories = categories;
        });
      });
    }

    final merchantCategories = Column(
        children: _categories
            .map((merchantCategory) => MerchantCategoryCell(
                itemCategory: merchantCategory,
                removeItemCategory: removeItemCategory,
                editItemCategory: editItemCategory))
            .toList());

    final nameInputBox = Container(
      width: 630,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
          key: const Key('catgory_name_input_box'),
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

    final submitCategoryButton = ElevatedButton(
        key: const Key('catgory_submit_button'),
        style: ElevatedButton.styleFrom(
            onPrimary: Colors.black,
            primary: Colors.black,
            minimumSize: const Size(200, 60),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(2)),
            )),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            ItemCategory itemCategory =
                ItemCategory(id: "temp", name: _name.text, icon: _icon.text);

            createItemCategory(http.Client(), itemCategory)
                .then((createdItemCategory) {
              setState(() {
                _categories.add(createdItemCategory);
              });
            });
          }
        },
        child: const Text('Submit',
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold)));

    final iconUrlInputBox = Container(
      key: const Key('category_image_input_box'),
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

    return Form(
        key: _formKey,
        child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'Merchant Category List',
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
                    const SizedBox(height: 30),
                    merchantCategories,
                    const Padding(
                      padding:
                          EdgeInsets.only(left: 15.0, top: 20.0, bottom: 10.0),
                      child: Text(
                        "Add a category",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    nameInputBox,
                    iconUrlInputBox,
                    submitCategoryButton
                  ],
                ),
              ],
            )),
            drawer: const NavigationDrawer()));
  }
}
