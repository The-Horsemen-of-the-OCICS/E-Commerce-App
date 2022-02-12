import 'package:ecommerceapp/models/item.dart';
import 'package:ecommerceapp/widgets/merchant_item_cell.dart';
import 'package:ecommerceapp/widgets/merchant_item_form.dart';
import 'package:flutter/material.dart';

class MerchantItemsList extends StatefulWidget {
  const MerchantItemsList({Key? key}) : super(key: key);

  @override
  _MerchantItemsListState createState() => _MerchantItemsListState();
}

class _MerchantItemsListState extends State<MerchantItemsList> {
  final List<Item> _merchantItems = [
    Item('Men Cloth', 'Men cloth desc', 100,
        'https://i.postimg.cc/Pr0ZZSxG/1641969100f69da7264d8688d9c11e7ce8cd3597b0-thumbnail-900x.jpg'),
    Item('Women Cloth', 'Women cloth desc', 50,
        'https://i.postimg.cc/2yMqQ5Cd/1624937261e1565ed7bb7611d917ff2e6a9ffe580a-thumbnail-900x.jpg'),
    Item('Kids Cloth', 'Kids cloth desc', 80,
        'https://i.postimg.cc/d10DgC1m/16172552205a1794e7dc17db68856850f0c26eeb53-thumbnail-900x.jpg'),
    Item('Home products', 'Home products desc', 120,
        'https://i.postimg.cc/j5kCTjnV/16340030929e7b3bd5c75857d1c040c639acc70476-thumbnail-900x.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    final merchantItems = Column(
        children: _merchantItems
            .map((merchantItem) => MerchantItemCell(item: merchantItem))
            .toList());

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
            _merchantItems.add(Item('', '', 10, ''));
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
              const MerchantItemForm(),
              submitItemButton
            ],
          ),
        ],
      )),
    );
  }
}
