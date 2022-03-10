import 'package:ecommerceapp/models/cartItem.dart';

class Order {
  String id;
  String userId;
  List<CartItem> cartList;
  double overallPrice;
  String orderDate;
  String shippingAddress;

  Order(
      {required this.id,
      required this.userId,
      required this.cartList,
      required this.overallPrice,
      required this.orderDate,
      required this.shippingAddress});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      userId: json['userId'] as String,
      cartList: CartItem.fromListJson(json['cartList']),
      overallPrice: json['overallPrice'] as double,
      orderDate: json['orderDate'] as String,
      shippingAddress: json['shippingAddress'] as String,
    );
  }

  String printItems() {
    String result = "";
    this.cartList.forEach((element) {
      result =
          result + element.name + " x" + element.quantity.toString() + '\n';
    });
    return result;
  }
}
