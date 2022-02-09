import 'package:ecommerceapp/models/response.dart';
import 'package:ecommerceapp/models/user.dart';

class Question {
  User user;
  String title;
  String body;
  String createdDate;
  List<Response> responses;
  int upvotes;

  Question(
      {required this.user,
      required this.title,
      required this.body,
      required this.createdDate,
      required this.responses,
      this.upvotes = 1});
}
