import 'package:ecommerceapp/models/category.dart';
import 'package:ecommerceapp/models/item.dart';
import 'package:ecommerceapp/screens/drawer/navigation_drawer.dart';
import 'package:ecommerceapp/widgets/merchant_item_cell.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerceapp/utils/network_config.dart';
import 'dart:convert';
import 'dart:math';
import 'package:ecommerceapp/models/user.dart';
import 'package:ecommerceapp/screens/login.dart';
import 'package:provider/provider.dart';
import '../../../models/auth.dart';

class MerchantItemsList extends StatefulWidget {
  const MerchantItemsList({Key? key}) : super(key: key);

  @override
  _MerchantItemsListState createState() => _MerchantItemsListState();
}

class _MerchantItemsListState extends State<MerchantItemsList> {
  final _formKey = GlobalKey<FormState>();
  List<Item> _merchantItems = [];

  List<ItemCategory> _merchantCategories = [];

  final TextEditingController _name = TextEditingController(text: "");
  final TextEditingController _desc = TextEditingController(text: "");
  final TextEditingController _price = TextEditingController(text: "");
  final TextEditingController _image = TextEditingController(text: "");
  String _categoryId = "-1";

  void removeItem(Item item) {
    var index = _merchantItems.indexWhere((element) => element.id == item.id);

    deleteItemById(http.Client(), item.id);

    setState(() {
      _merchantItems.removeAt(index);
    });
  }

  void editItem(Item item) {
    var index = _merchantItems.indexWhere((element) => element.id == item.id);

    setState(() {
      _merchantItems[index] = item;
    });
  }

  Future<Item> createItem(http.Client client, Item item) async {
    final response =
        await client.post(Uri.parse(NetworkConfig.API_BASE_URL + 'item/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              'id': item.id.toString(),
              'name': item.name,
              'description': item.desc,
              'price': item.price,
              'image': item.image,
              'categoryId': item.categoryId.toString(),
              'date': DateTime.now().toString()
            }));

    return Item.fromJson(jsonDecode(response.body));
  }

  Future<List<Item>> fetchItems(http.Client client) async {
    final response =
        await client.get(Uri.parse(NetworkConfig.API_BASE_URL + 'item/'));

    return jsonDecode(response.body)
        .map<Item>((json) => Item.fromJson(json))
        .toList();
  }

  Future<List<ItemCategory>> fetchCategories(http.Client client) async {
    final response =
        await client.get(Uri.parse(NetworkConfig.API_BASE_URL + 'category/'));

    return jsonDecode(response.body)
        .map<ItemCategory>((json) => ItemCategory.fromJson(json))
        .toList();
  }

  Future<void> deleteItemById(http.Client client, int id) async {
    await client.delete(
        Uri.parse(NetworkConfig.API_BASE_URL + 'item/' + id.toString()));
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<AuthModel>(context).getCurrentUser();
    if (user == null || user.email != 'admin@gmail.com') {
      return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Merchant Item List',
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
                  "Please login as an admin to view items",
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

    if (_merchantCategories.isEmpty) {
      fetchCategories(http.Client()).then((categories) {
        setState(() {
          categories.insert(0, ItemCategory(id: -1, name: "-", icon: ""));
          _merchantCategories = categories;
        });
      });
    }

    if (_merchantItems.isEmpty) {
      fetchItems(http.Client()).then((items) {
        setState(() {
          _merchantItems = items;
        });
      });
    }

    final merchantItems = Column(
        children: _merchantItems
            .map((merchantItem) => MerchantItemCell(
                  item: merchantItem,
                  removeItem: removeItem,
                  editItem: editItem,
                  categorise: _merchantCategories,
                ))
            .toList());

    final nameInputBox = Container(
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

    final descInputBox = Container(
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

    final imageUrlInputBox = Container(
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
          setState(() => _categoryId = value!);
        },
        validator: (value) {
          if (value == null || value.isEmpty || value == "-1") {
            return 'Please select category';
          }
          return null;
        },
      ),
    );

    final submitItemButton = ElevatedButton(
        // key: const Key("submit_question_button"),
        style: ElevatedButton.styleFrom(
            onPrimary: Colors.black,
            primary: Colors.black,
            minimumSize: const Size(200, 60),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(2)),
            )),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Item item = Item(
                id: Random().nextInt(999999),
                name: _name.text,
                desc: _desc.text,
                price: double.parse(_price.text),
                image: _image.text,
                categoryId: int.parse(_categoryId));

            createItem(http.Client(), item).then((createdItem) {
              setState(() {
                _merchantItems.add(item);
              });
            });
          }
        },
        child: const Text('Submit',
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold)));

    return Form(
      key: _formKey,
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Merchant Item List',
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
                  merchantItems,
                  const Padding(
                    padding:
                        EdgeInsets.only(left: 15.0, top: 20.0, bottom: 10.0),
                    child: Text(
                      "Add an item",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  nameInputBox,
                  descInputBox,
                  priceInputBox,
                  imageUrlInputBox,
                  categorySelectionBox,
                  submitItemButton
                ],
              ),
            ],
          )),
          drawer: const NavigationDrawer()),
    );
  }
}
