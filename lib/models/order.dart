import 'package:ecommerceapp/models/cartItem.dart';

class Order {
  String id;
  String userId;
  List<CartItem> itemList;
  String overallPrice;
  String date;
  String shippingAddress;

  Order(
      {required this.id,
      required this.userId,
      required this.itemList,
      required this.overallPrice,
      required this.date,
      required this.shippingAddress});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      userId: json['userId'] as String,
      itemList: CartItem.fromListJson(json['ItemList']),
      overallPrice: json['OverallPrice'] as String,
      date: json['date'] as String,
      shippingAddress: json['shippingAddress'] as String,
    );
  }
}
