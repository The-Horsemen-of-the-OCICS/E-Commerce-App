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
