import 'package:ecommerceapp/models/item.dart';
import 'package:ecommerceapp/screens/drawer/navigation_drawer.dart';
import 'package:ecommerceapp/widgets/merchant_item_cell.dart';
import 'package:flutter/material.dart';

class MerchantItemsList extends StatefulWidget {
  const MerchantItemsList({Key? key}) : super(key: key);

  @override
  _MerchantItemsListState createState() => _MerchantItemsListState();
}

class _MerchantItemsListState extends State<MerchantItemsList> {
  final List<Item> _merchantItems = [
    Item(
        id: 1,
        name: 'Men Cloth',
        desc: 'Men cloth desc',
        price: 100,
        image:
            'https://i.postimg.cc/Pr0ZZSxG/1641969100f69da7264d8688d9c11e7ce8cd3597b0-thumbnail-900x.jpg',
        categoryId: 1),
    Item(
        id: 2,
        name: 'Women Cloth',
        desc: 'Women cloth desc',
        price: 50,
        image:
            'https://i.postimg.cc/2yMqQ5Cd/1624937261e1565ed7bb7611d917ff2e6a9ffe580a-thumbnail-900x.jpg',
        categoryId: 2),
    Item(
        id: 3,
        name: 'Kids Cloth',
        desc: 'Kids cloth desc',
        price: 80,
        image:
            'https://i.postimg.cc/d10DgC1m/16172552205a1794e7dc17db68856850f0c26eeb53-thumbnail-900x.jpg',
        categoryId: 3),
    Item(
        id: 4,
        name: 'Home products',
        desc: 'Home products desc',
        price: 120,
        image:
            'https://i.postimg.cc/j5kCTjnV/16340030929e7b3bd5c75857d1c040c639acc70476-thumbnail-900x.jpg',
        categoryId: 4),
  ];

  TextEditingController _name = TextEditingController(text: "");
  TextEditingController _desc = TextEditingController(text: "");
  TextEditingController _price = TextEditingController(text: "");
  TextEditingController _image = TextEditingController(text: "");

  void removeItem(Item item) {
    var index = _merchantItems.indexWhere((element) => element.id == item.id);

    setState(() {
      _merchantItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final merchantItems = Column(
        children: _merchantItems
            .map((merchantItem) => MerchantItemCell(
                  item: merchantItem,
                  removeItem: removeItem,
                ))
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
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
          maxLength: 30,
          maxLines: 1,
          controller: _desc,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
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
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
          maxLength: 30,
          maxLines: 1,
          controller: _price,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
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
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
          maxLines: 1,
          controller: _image,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Item Image Url',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter item image url';
            }
            return null;
          }),
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
          setState(() {
            _merchantItems.add(Item(
                id: _merchantItems.length,
                name: _name.text,
                desc: _desc.text,
                price: double.parse(_price.text),
                image: _image.text,
                categoryId: 1));
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
                  padding: EdgeInsets.only(left: 15.0, top: 20.0, bottom: 10.0),
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
                submitItemButton
              ],
            ),
          ],
        )),
        drawer: const NavigationDrawer());
  }
}
