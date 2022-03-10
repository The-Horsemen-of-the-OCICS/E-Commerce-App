class CartItem {
  String id;
  String name;
  double itemPrice;
  String image;
  int quantity;

  CartItem(
      {required this.id,
      required this.name,
      required this.itemPrice,
      required this.image,
      required this.quantity});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] as String,
      name: json['name'] as String,
      itemPrice: json['price'] as double,
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'itemPrice': itemPrice,
      'image': image,
      'quantity': quantity,
    };
  }
}
