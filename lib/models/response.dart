import 'package:ecommerceapp/models/user.dart';

class Response{
  User user;
  String body;
  String createdDate;
  int upvotes;

  Response({
    required this.user,
    required this.body,
    required this.createdDate,
    this.upvotes = 1
  });
}
