import 'package:ecommerceapp/models/shippingInfo.dart';

class User {
  String id;
  String name;
  String email;
  ShippingInfo defaultShippingInfo;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.defaultShippingInfo});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      defaultShippingInfo: ShippingInfo.fromJson(json['defaultShippingInfo']),
    );
  }
}

final User admin = User(
    id: "0",
    name: "Admin",
    email: "admin@gmail.com",
    defaultShippingInfo: ShippingInfo(
        phone: "(111) 222-3333",
        street: "75 Laurier Ave. E",
        city: "Ottawa",
        state: "ON",
        country: "Canada"));

final User customer = User(
    id: "1",
    name: "Test Customer",
    email: "user1@gmail.com",
    defaultShippingInfo: ShippingInfo(
        phone: "(111) 222-3333",
        street: "75 Laurier Ave. E",
        city: "Ottawa",
        state: "ON",
        country: "Canada"));

List<User> users = [admin, customer];
