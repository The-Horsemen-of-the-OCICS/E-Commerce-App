import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:ecommerceapp/models/item.dart';
import 'cartItem.dart';

class CartList extends ChangeNotifier {
  List<CartItem> _cartItems = [];

  UnmodifiableListView<CartItem> get cartItems =>
      UnmodifiableListView(_cartItems);

  void add(CartItem cartItem) {
    var matchedCartIndex =
        _cartItems.indexWhere((element) => element.id == cartItem.id);
    if (matchedCartIndex == -1) {
      _cartItems.add(cartItem);
    } else {
      _cartItems[matchedCartIndex] = CartItem(
          id: cartItem.id,
          name: cartItem.name,
          itemPrice: cartItem.itemPrice,
          quantity: _cartItems[matchedCartIndex].quantity + 1,
          image: cartItem.image);
    }
    notifyListeners();
  }

  void reduce(CartItem cartItem) {
    var matchedCartIndex =
        _cartItems.indexWhere((element) => element.id == cartItem.id);
    if (_cartItems[matchedCartIndex].quantity > 1) {
      _cartItems[matchedCartIndex] = CartItem(
          id: cartItem.id,
          name: cartItem.name,
          itemPrice: cartItem.itemPrice,
          quantity: _cartItems[matchedCartIndex].quantity - 1,
          image: cartItem.image);
    } else {
      _cartItems.removeAt(matchedCartIndex);
    }
    notifyListeners();
  }

  void remove(CartItem cartItem) {
    _cartItems.removeWhere((element) => element.id == cartItem.id);
  }

  void removeAll() {
    _cartItems.clear();
  }

  double getCartListPrice() {
    double total = 0.0;
    for (var item in _cartItems) {
      total += item.quantity * item.itemPrice;
    }
    return total;
  }

  void update(List<Item>? itemList) {
    if (itemList != null) {
      List<CartItem> newList = [];
      itemList.forEach((item) {
        _cartItems.forEach((cItem) {
          if (item.id == cItem.id) {
            cItem.name = item.name;
            cItem.image = item.image;
            cItem.itemPrice = item.price;
            newList.add(cItem);
          }
        });
      });
      _cartItems = List.from(newList);
    }
  }
}
