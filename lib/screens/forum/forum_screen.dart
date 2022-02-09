import 'package:flutter/material.dart';
import 'package:ecommerceapp/widgets/question_post.dart';
import 'package:ecommerceapp/models/question.dart';

class ForumPage extends StatefulWidget {
  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  var titleTextBox = Container(
    width: 630,
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: const TextField(
      maxLength: 30,
      maxLines: 1,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Type your question title',
      ),
    ),
  );

  var bodyTextBox = Container(
    width: 630,
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: const TextField(
      maxLength: 400,
      minLines: 4,
      maxLines: 8,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Type your question detail',
      ),
    ),
  );

  final submitQuestionButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
          onPrimary: Colors.black,
          primary: Colors.black,
          minimumSize: const Size(200, 60),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2)),
          )),
      onPressed: () {},
      child: const Text('Submit',
          style: TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)));

  final allQuestions = Column(
      children: questions
          .map((question) => QuestionPost(question: question))
          .toList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forum',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        children: <Widget>[
          const SizedBox(height: 30),
          allQuestions,
          const Padding(
            padding: EdgeInsets.only(left: 15.0, top: 20.0, bottom: 10.0),
            child: Text(
              "Add a question",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          titleTextBox,
          bodyTextBox,
          submitQuestionButton
        ],
      )),
    );
  }
}
