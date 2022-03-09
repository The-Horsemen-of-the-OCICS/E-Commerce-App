import 'dart:collection';

import 'package:flutter/material.dart';

import 'item.dart';

class Cart {
  final Item item;
  final int numOfItem;

  Cart({required this.item, required this.numOfItem});
}

class CartList extends ChangeNotifier {
  final List<Cart> _cartItems = [];

  UnmodifiableListView<Cart> get cartItems => UnmodifiableListView(_cartItems);

  void add(Cart cartItem) {
    var matchedCartIndex =
        _cartItems.indexWhere((element) => element.item.id == cartItem.item.id);
    if (matchedCartIndex == -1) {
      _cartItems.add(cartItem);
    } else {
      _cartItems[matchedCartIndex] = Cart(
          item: _cartItems[matchedCartIndex].item,
          numOfItem: _cartItems[matchedCartIndex].numOfItem + 1);
    }
    notifyListeners();
  }

  void reduce(Cart cartItem) {
    var matchedCartIndex =
        _cartItems.indexWhere((element) => element.item.id == cartItem.item.id);
    if (_cartItems[matchedCartIndex].numOfItem > 1) {
      _cartItems[matchedCartIndex] = Cart(
          item: _cartItems[matchedCartIndex].item,
          numOfItem: _cartItems[matchedCartIndex].numOfItem - 1);
    } else {
      _cartItems.removeAt(matchedCartIndex);
    }
    notifyListeners();
  }

  void remove(Cart cartItem) {
    _cartItems.removeWhere((element) => element.item.id == cartItem.item.id);
  }
}

// Demo data for our cart
List<Cart> demoCarts = [
  Cart(item: demoProducts[0], numOfItem: 2),
  Cart(item: demoProducts[1], numOfItem: 1),
  Cart(item: demoProducts[3], numOfItem: 1),
];
