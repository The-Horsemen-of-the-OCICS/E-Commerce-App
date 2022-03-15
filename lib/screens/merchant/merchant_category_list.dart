import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceapp/models/category.dart';
import 'package:ecommerceapp/screens/drawer/navigation_drawer.dart';
import 'package:ecommerceapp/widgets/merchant_category_cell.dart';

class MerchantCategoryList extends StatefulWidget {
  const MerchantCategoryList({Key? key}) : super(key: key);

  @override
  State<MerchantCategoryList> createState() => _MerchantCategoryListState();
}

class _MerchantCategoryListState extends State<MerchantCategoryList> {
  final List<ItemCategory> _merchantCategories = [
    ItemCategory(
        id: 1,
        name: 'Men',
        icon:
            'https://i.postimg.cc/NfRGJDDv/7534386-cardigan-knitwear-women-fashion-clothing-icon.png'),
    ItemCategory(
        id: 2,
        name: 'Women',
        icon:
            'https://i.postimg.cc/cLsWDS6f/7534390-women-shirt-tops-fashion-clothing-icon.png'),
    ItemCategory(
        id: 3,
        name: 'Kids',
        icon:
            'https://i.postimg.cc/zvbZgzt1/7534391-women-shirt-tops-fashion-clothing-icon.png'),
    ItemCategory(
        id: 4,
        name: 'Home',
        icon:
            'https://i.postimg.cc/NjpcSzrS/7534405-makeup-beauty-women-fashion-female-icon.png'),
  ];

  TextEditingController _name = TextEditingController(text: "");
  TextEditingController _icon = TextEditingController(text: "");

  void removeItemCategory(ItemCategory itemCategory) {
    var index = _merchantCategories.indexWhere((element) =>
        element.name == itemCategory.name && element.icon == itemCategory.icon);

    setState(() {
      _merchantCategories.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final merchantCategories = Column(
        children: _merchantCategories
            .map((merchantCategory) => MerchantCategoryCell(
                itemCategory: merchantCategory,
                removeItemCategory: removeItemCategory))
            .toList());

    final nameInputBox = Container(
      width: 630,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
          maxLength: 30,
          maxLines: 1,
          controller: _name,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
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
        style: ElevatedButton.styleFrom(
            onPrimary: Colors.black,
            primary: Colors.black,
            minimumSize: const Size(200, 60),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(2)),
            )),
        onPressed: () {
          setState(() {
            _merchantCategories.add(ItemCategory(
                id: _merchantCategories.length,
                name: _name.text,
                icon: _icon.text));
          });
        },
        child: const Text('Submit',
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold)));

    final iconUrlInputBox = Container(
      width: 630,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
          maxLines: 1,
          controller: _icon,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Category Icon Url',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter icon url';
            }
            return null;
          }),
    );

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
            child: ListView(
          children: [
            Column(
              children: <Widget>[
                const SizedBox(height: 30),
                merchantCategories,
                const Padding(
                  padding: EdgeInsets.only(left: 15.0, top: 20.0, bottom: 10.0),
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
        drawer: const NavigationDrawer());
  }
}
