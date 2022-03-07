class CartItem {
  String id;
  String name;
  double totalPrice;
  String image;
  int quantity;

  CartItem(
      {required this.id,
      required this.name,
      required this.totalPrice,
      required this.image,
      required this.quantity});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['itemId'] as String,
      name: json['name'] as String,
      totalPrice: json['totalPrice'] as double,
      image: json['image'] as String,
      quantity: json['quantity'] as int,
    );
  }

  static List<CartItem> fromListJson(List<dynamic> json) {
    List<CartItem> result = <CartItem>[];
    for (Map<String, dynamic> j in json) {
      result.add(CartItem.fromJson(j));
    }
    return result;
  }
}
