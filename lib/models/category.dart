class ItemCategory {
  String id;
  String name;
  String icon;

  ItemCategory({required this.id, required this.name, required this.icon});

  factory ItemCategory.fromJson(Map<String, dynamic> json) {
    return ItemCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
    );
  }
}
