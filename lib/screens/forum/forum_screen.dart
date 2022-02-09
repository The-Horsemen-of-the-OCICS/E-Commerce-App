import 'dart:developer';

import 'package:ecommerceapp/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceapp/widgets/question_post.dart';
import 'package:ecommerceapp/models/question.dart';
import 'package:provider/provider.dart';

import '../../models/auth.dart';
import '../../models/response.dart';
import '../../models/user.dart';

class ForumPage extends StatefulWidget {
  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  final _questionFormKey = GlobalKey<FormState>(debugLabel: "questionFormKey");

  TextEditingController _title = TextEditingController(text: "");
  TextEditingController _body = TextEditingController(text: "");

  final List<Question> _questions = [
    Question(
        user: wenjiu,
        title: 'Is shipping free',
        body: "Hi I wonder if shipping is free???",
        createdDate: DateTime.now().toString(),
        responses: [
          Response(
              user: wenjiu,
              body: "Please answer.",
              createdDate: DateTime.now().toString()),
          Response(
              user: admin,
              body: "Yes, it is free.",
              createdDate: DateTime.now().toString())
        ]),
    Question(
        user: wenjiu,
        title: 'Do you ship to Canada',
        body:
            "Hi I wonder if I can use this site in Canada Hi I wonder if I can use this site in CanadaHi I wonder if I can use this site in CanadaHi I wonder if I can use this site in CanadaHi I wonder if I can use this site in CanadaHi I wonder if I can use this site in CanadaHi I wonder if I can use this site in CanadaHi I wonder if I can use this site in CanadaHi I wonder if I can use this site in CanadaHi I wonder if I can use this site in CanadaHi I wonder if I can use this site in CanadaHi I wonder if I can use this site in CanadaHi I wonder if I can use this site in CanadaHi I wonder if I can use this site in CanadaHi I wonder if I can use this site in CanadaHi I wonder if I can use this site in CanadaHi I wonder if I can use this site in CanadaHi I wonder if I can use this site in CanadaHi I wonder if I can use this site in CanadaHi I wonder if I can use this site in CanadaHi I wonder if I can use this site in Canada",
        createdDate: DateTime.now().toString(),
        responses: [
          Response(
              user: admin,
              body: "Yes, you can.",
              createdDate: DateTime.now().toString())
        ]),
    Question(
        user: wenjiu,
        title: 'When does the sale end?',
        body: "Can you tell me when does the spring sale end",
        createdDate: DateTime.now().toString(),
        responses: [
          Response(
              user: admin,
              body: "April 1st.",
              createdDate: DateTime.now().toString())
        ])
  ];

  @override
  Widget build(BuildContext context) {
    final userAuth = Provider.of<AuthModel>(context);

    final titleTextBox = Container(
      width: 630,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: TextFormField(
          maxLength: 30,
          maxLines: 1,
          controller: _title,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Type your question title',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter something';
            }
            return null;
          }),
    );

    final bodyTextBox = Container(
      width: 630,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: TextFormField(
        controller: _body,
        maxLength: 400,
        minLines: 4,
        maxLines: 8,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Type your question detail',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter something';
          }
          return null;
        },
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
        onPressed: () {
          if (userAuth.getCurrentUser() != null) {
            final user = userAuth.getCurrentUser();
            setState(() {
              _questions.add(Question(
                  user: user!,
                  title: _title.text,
                  body: _body.text,
                  createdDate: DateTime.now().toString(),
                  responses: []));
              debugPrint(_questions.toString());
            });
          } else {
            Navigator.of(context).pushNamed(AppRoutes.login);
          }
        },
        child: const Text('Submit',
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold)));

    final allQuestions = Column(
        children: _questions
            .map((question) => QuestionPost(question: question))
            .toList());

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
          child: ListView(
        children: [
          Column(
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
          ),
        ],
      )),
    );
  }
}
