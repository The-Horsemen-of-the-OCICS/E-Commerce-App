class User {
  String id;
  String name;
  String email;
  String defaultAddress;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.defaultAddress});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      defaultAddress: json['defaultAddress'] as String,
    );
  }
}

final User admin = User(
    id: "0",
    name: "Admin",
    email: "admin@gmail.com",
    defaultAddress: "75 Laurier Ave. E, Ottawa, ON K1N 6N5");

final User customer = User(
    id: "1",
    name: "Test Customer",
    email: "user1@gmail.com",
    defaultAddress: "75 Laurier Ave. E, Ottawa, ON K1N 6N5");

List<User> users = [admin, customer];
