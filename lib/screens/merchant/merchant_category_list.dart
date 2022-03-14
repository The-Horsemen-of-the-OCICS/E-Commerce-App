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
    ItemCategory('Men',
        'https://i.postimg.cc/NfRGJDDv/7534386-cardigan-knitwear-women-fashion-clothing-icon.png'),
    ItemCategory('Women',
        'https://i.postimg.cc/cLsWDS6f/7534390-women-shirt-tops-fashion-clothing-icon.png'),
    ItemCategory('Kids',
        'https://i.postimg.cc/zvbZgzt1/7534391-women-shirt-tops-fashion-clothing-icon.png'),
    ItemCategory('Home',
        'https://i.postimg.cc/NjpcSzrS/7534405-makeup-beauty-women-fashion-female-icon.png'),
  ];

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
                // nameInputBox,
                // descInputBox,
                // priceInputBox,
                // imageUrlImageBox,
                // submitItemButton
              ],
            ),
          ],
        )),
        drawer: const NavigationDrawer());
  }
}
