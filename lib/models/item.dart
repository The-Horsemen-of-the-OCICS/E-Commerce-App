class Item {
  String id;
  String name;
  String desc;
  double price;
  String image;
  String categoryId;

  Item(
      {required this.id,
      required this.name,
      required this.desc,
      required this.price,
      required this.image,
      required this.categoryId});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] as String,
      name: json['name'] as String,
      desc: json['description'] as String,
      price: json['price'] as double,
      image: json['image'] as String,
      categoryId: json['categoryId'] as String,
    );
  }
}
