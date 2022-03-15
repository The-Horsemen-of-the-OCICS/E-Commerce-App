class ItemCategory {
  int id;
  String name;
  String icon;

  ItemCategory({required this.id, required this.name, required this.icon});

  factory ItemCategory.fromJson(Map<String, dynamic> json) {
    return ItemCategory(
      id: int.parse(json['id'] as String),
      name: json['name'],
      icon: json['icon'],
    );
  }
}
