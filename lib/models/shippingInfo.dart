class ShippingInfo {
  String phone;
  String street;
  String city;
  String state;
  String country;

  ShippingInfo(
      {required this.phone,
      required this.street,
      required this.city,
      required this.state,
      required this.country});

  factory ShippingInfo.fromJson(Map<String, dynamic> json) {
    return ShippingInfo(
        phone: json['phone'] as String,
        street: json['street'] as String,
        city: json['city'] as String,
        state: json['state'] as String,
        country: json['country'] as String);
  }
}
