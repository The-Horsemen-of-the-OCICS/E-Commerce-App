class Item {
  int id;
  String name;
  String desc;
  int price;
  String image;

  Item(this.id, this.name, this.desc, this.price, this.image);
}

final List<Item> demoProducts = [
  Item(1, 'Men Cloth', 'Men cloth desc', 100,
      'https://i.postimg.cc/Pr0ZZSxG/1641969100f69da7264d8688d9c11e7ce8cd3597b0-thumbnail-900x.jpg'),
  Item(2, 'Women Cloth', 'Women cloth desc', 50,
      'https://i.postimg.cc/2yMqQ5Cd/1624937261e1565ed7bb7611d917ff2e6a9ffe580a-thumbnail-900x.jpg'),
  Item(3, 'Kids Cloth', 'Kids cloth desc', 80,
      'https://i.postimg.cc/d10DgC1m/16172552205a1794e7dc17db68856850f0c26eeb53-thumbnail-900x.jpg'),
  Item(4, 'Home products', 'Home products desc', 120,
      'https://i.postimg.cc/j5kCTjnV/16340030929e7b3bd5c75857d1c040c639acc70476-thumbnail-900x.jpg'),
];
