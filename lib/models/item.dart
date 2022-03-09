class Item {
  int id;
  String name;
  String desc;
  double price;
  String image;

  Item(
      {required this.id,
      required this.name,
      required this.desc,
      required this.price,
      required this.image});

  factory Item.fromJson(Map<String, dynamic> json) {
    var image =
        "https://i.postimg.cc/j5kCTjnV/16340030929e7b3bd5c75857d1c040c639acc70476-thumbnail-900x.jpg";
    if (int.parse(json['id'] as String) == 1) {
      image =
          "https://i.postimg.cc/Pr0ZZSxG/1641969100f69da7264d8688d9c11e7ce8cd3597b0-thumbnail-900x.jpg";
    } else if (int.parse(json['id'] as String) == 2) {
      image =
          "https://i.postimg.cc/2yMqQ5Cd/1624937261e1565ed7bb7611d917ff2e6a9ffe580a-thumbnail-900x.jpg";
    } else if (int.parse(json['id'] as String) == 3) {
      image =
          "https://i.postimg.cc/d10DgC1m/16172552205a1794e7dc17db68856850f0c26eeb53-thumbnail-900x.jpg";
    }
    return Item(
      id: int.parse(json['id'] as String),
      name: json['name'] as String,
      desc: json['description'] as String,
      price: json['price'] as double,
      image: image, //json['image'] as String,
    );
  }
}
