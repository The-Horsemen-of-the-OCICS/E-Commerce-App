import 'package:ecommerceapp/models/response.dart';
import 'package:ecommerceapp/models/user.dart';

class Question{
  User user;
  String title;
  String body;
  String createdDate;
  List<Response> responses;
  int upvotes;

  Question({
    required this.user,
    required this.title,
    required this.body,
    required this.createdDate,
    required this.responses,
    this.upvotes = 1
  });
}

List<Question> questions = [
  Question(
    user: wenjiu,
    title: 'Is shipping free',
    body: "Hi I wonder if shipping is free???",
    createdDate: DateTime.now().toString(),
    responses: [
      Response(user: wenjiu, body: "Please answer.", createdDate: DateTime.now().toString()),
      Response(user: admin, body: "Yes, it is free.", createdDate: DateTime.now().toString())]
  ),
  Question(
    user: wenjiu,
    title: 'Do you ship to Canada',
    body: "Hi I wonder if I can use this site in Canada Hi I wonder if I can use this site in CanadaHi I wonder if I can use this site in CanadaHi I wonder if I can use this site in CanadaHi I wonder if I can use this site in CanadaHi I wonder if I can use this site in CanadaHi I wonder if I can use this site in CanadaHi I wonder if I can use this site in CanadaHi I wonder if I can use this site in CanadaHi I wonder if I can use this site in CanadaHi I wonder if I can use this site in CanadaHi I wonder if I can use this site in CanadaHi I wonder if I can use this site in CanadaHi I wonder if I can use this site in CanadaHi I wonder if I can use this site in CanadaHi I wonder if I can use this site in CanadaHi I wonder if I can use this site in CanadaHi I wonder if I can use this site in CanadaHi I wonder if I can use this site in CanadaHi I wonder if I can use this site in CanadaHi I wonder if I can use this site in Canada",
    createdDate: DateTime.now().toString(),
    responses: [Response(user: admin, body: "Yes, you can.", createdDate: DateTime.now().toString())]
  ),
  Question(
    user: wenjiu,
    title: 'When does the sale end?',
    body: "Can you tell me when does the spring sale end",
    createdDate: DateTime.now().toString(),
    responses: [Response(user: admin, body: "April 1st.", createdDate: DateTime.now().toString())]
  )
];
