import 'package:ecommerceapp/models/user.dart';

class Question {
  String id;
  String userId;
  String userName;
  String title;
  String body;
  String createdDate;
  int responseCount;
  int upvotes;

  Question(
      {required this.id,
      required this.userId,
      required this.userName,
      required this.title,
      required this.body,
      required this.createdDate,
      this.responseCount = 1,
      this.upvotes = 1});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userName: "Loading...",
      title: json['title'] as String,
      body: json['body'] as String,
      createdDate: json['date'] as String,
      upvotes: json['upvotes'] as int,
    );
  }
}
