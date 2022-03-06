import 'package:flutter/material.dart';

import 'item.dart';

class Cart {
  final Item item;
  final int numOfItem;

  Cart({required this.item, required this.numOfItem});
}

// Demo data for our cart
List<Cart> demoCarts = [
  Cart(item: demoProducts[0], numOfItem: 2),
  Cart(item: demoProducts[1], numOfItem: 1),
  Cart(item: demoProducts[3], numOfItem: 1),
];
