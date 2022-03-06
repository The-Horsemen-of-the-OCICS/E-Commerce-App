class User {
  String id;
  String name;
  String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }
}

final User admin = User(id: "0", name: "admin", email: "admin@gmail.com");

final User wenjiu =
    User(id: "1", name: "Wenjiu Wang", email: "wenjiu@gmail.com");

List<User> users = [admin];
