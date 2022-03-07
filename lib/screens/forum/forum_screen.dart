import 'dart:convert';

import 'package:ecommerceapp/routes/app_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceapp/widgets/question_post.dart';
import 'package:ecommerceapp/models/question.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../models/auth.dart';
import '../../models/user.dart';

String API_BASE_URL = "https://localhost:5000/api/";

class ForumPage extends StatefulWidget {
  @override
  _ForumPageState createState() => _ForumPageState();
}

// GET
Future<List<Question>> fetchQuestions(http.Client client) async {
  final response = await client.get(Uri.parse(API_BASE_URL + 'question/'));
  return compute(parseQuestions, response.body);
}

Future<List<Question>> parseQuestions(String responseBody) async {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  List<Question> q =
      parsed.map<Question>((json) => Question.fromJson(json)).toList();

  for (var element in q) {
    element.userName = await fetchUserName(http.Client(), element.userId);
    element.responseCount = await fetchResponseCount(http.Client(), element.id);
  }
  return q;
}

Future<String> fetchUserName(http.Client client, String userId) async {
  final response = await client.get(Uri.parse(API_BASE_URL + 'user/$userId'));

  final parsed = jsonDecode(response.body);
  return parsed["name"];
}

Future<int> fetchResponseCount(http.Client client, String questionId) async {
  final response =
      await client.get(Uri.parse(API_BASE_URL + 'response/count/$questionId'));

  return int.parse(response.body);
}

// POST
Future<Question> createQuestion(
    String title, String body, User user, int newId) async {
  final response = await http.post(
    Uri.parse(API_BASE_URL + 'question'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'id': newId.toString(),
      'userId': user.id,
      'title': title,
      'body': body,
      'date': DateTime.now().toIso8601String(),
      'upvotes': "1"
    }),
  );

  debugPrint(response.body);

  if (response.statusCode == 201) {
    return Question.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create Question.');
  }
}

class _ForumPageState extends State<ForumPage> {
  Future<Question>? _futureQuestion;

  List<Question> _questions = [];

  final _questionFormKey = GlobalKey<FormState>(debugLabel: "questionFormKey");

  TextEditingController _title = TextEditingController(text: "");
  TextEditingController _body = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    final userAuth = Provider.of<AuthModel>(context);
    fetchQuestions(http.Client());

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
              _futureQuestion = createQuestion(
                  _title.text, _body.text, user!, _questions.length + 1);
              debugPrint(_questions.length.toString());
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

    final futureQuestions = FutureBuilder<List<Question>>(
      future: fetchQuestions(http.Client()),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Failed to load questions from the server!'),
          );
        } else if (snapshot.hasData) {
          _questions = snapshot.data!;
          return Column(
              children: _questions
                  .map((question) => QuestionPost(question: question))
                  .toList());
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );

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
              futureQuestions,
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
