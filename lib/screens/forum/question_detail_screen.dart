import 'dart:convert';

import 'package:ecommerceapp/models/question.dart';
import 'package:ecommerceapp/widgets/response_post.dart';
import 'package:ecommerceapp/widgets/question_post.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../models/auth.dart';
import '../../models/response.dart';
import '../../models/user.dart';
import '../../routes/app_routes.dart';
import '../../utils/network_config.dart';

class PostScreen extends StatefulWidget {
  @override
  final Question question;
  PostScreen({required this.question});
  _PostScreenState createState() => _PostScreenState();
}

// Get
Future<List<Response>> fetchResponses(
    http.Client client, String questionId) async {
  final response = await client
      .get(Uri.parse(NetworkConfig.API_BASE_URL + 'response/q/' + questionId));
  return compute(parseResponses, response.body);
}

Future<String> fetchUserName(http.Client client, String userId) async {
  final response =
      await client.get(Uri.parse(NetworkConfig.API_BASE_URL + 'user/$userId'));

  final parsed = jsonDecode(response.body);
  return parsed["name"];
}

Future<List<Response>> parseResponses(String responseBody) async {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  List<Response> r =
      parsed.map<Response>((json) => Response.fromJson(json)).toList();
  for (var element in r) {
    element.userName = await fetchUserName(http.Client(), element.userId);
  }
  return r;
}

// Post
Future<Response> createResponse(
    String body, User user, String questionId, String newId) async {
  final response = await http.post(
    Uri.parse(NetworkConfig.API_BASE_URL + 'response'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'id': newId,
      'questionId': questionId,
      'userId': user.id,
      'body': body,
      'date': DateTime.now().toIso8601String(),
      'upvotes': "1"
    }),
  );

  debugPrint(response.body);

  if (response.statusCode == 201) {
    return Response.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create Response.');
  }
}

class _PostScreenState extends State<PostScreen> {
  Future<Response>? _futureResponse;

  List<Response> _responses = [];

  final _responseFormKey = GlobalKey<FormState>(debugLabel: "responseFormKey");

  final TextEditingController _body = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    final userAuth = Provider.of<AuthModel>(context);

    final futureResponses = FutureBuilder<List<Response>>(
      future: fetchResponses(http.Client(), widget.question.id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('No responses found!'),
          );
        } else if (snapshot.hasData) {
          _responses = snapshot.data!;
          return Column(
              children: _responses
                  .map((res) => ResponsePost(response: res))
                  .toList());
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );

    var responseTextBox = Container(
      width: 630,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: TextFormField(
          controller: _body,
          maxLength: 200,
          minLines: 4,
          maxLines: 4,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Type your response',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter something';
            }
            return null;
          }),
    );

    final submitButton = ElevatedButton(
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
            _futureResponse = createResponse(
                _body.text,
                user!,
                widget.question.id,
                widget.question.id.toString() +
                    "_" +
                    (widget.question.responseCount + 1).toString());
            debugPrint(_responses.length.toString());
          });
        } else {
          Navigator.of(context).pushNamed(AppRoutes.login);
        }
      },
      child: const Text('Submit',
          style: TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Question Detail',
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
                QuestionPost(question: widget.question),
                Text(
                  "Replies [${widget.question.responseCount}]",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                futureResponses,
                Text(
                  "Add a response",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                responseTextBox,
                submitButton
              ],
            ),
          ],
        ),
      ),
    );
  }
}
