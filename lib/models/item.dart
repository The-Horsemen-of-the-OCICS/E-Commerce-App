class Item {
  int id;
  String name;
  String desc;
  double price;
  String image;
  int categoryId;

  Item(
      {required this.id,
      required this.name,
      required this.desc,
      required this.price,
      required this.image,
      required this.categoryId});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: int.parse(json['id'] as String),
      name: json['name'] as String,
      desc: json['description'] as String,
      price: json['price'] as double,
      image: json['image'] as String,
      categoryId: int.parse(json['categoryId'] as String),
    );
  }
}
