import 'package:ecommerceapp/models/question.dart';
import 'package:ecommerceapp/widgets/response_post.dart';
import 'package:ecommerceapp/widgets/question_post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/auth.dart';
import '../../models/response.dart';
import '../../routes/app_routes.dart';

class PostScreen extends StatefulWidget {
  @override
  final Question question;
  PostScreen({required this.question});
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final _responseFormKey = GlobalKey<FormState>(debugLabel: "responseFormKey");

  final TextEditingController _body = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    final userAuth = Provider.of<AuthModel>(context);

    var allResponses = Column(
        children: widget.question.responses
            .map((res) => ResponsePost(response: res))
            .toList());

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
            widget.question.responses.add(Response(
              user: user!,
              body: _body.text,
              createdDate: DateTime.now().toString(),
            ));
            debugPrint(widget.question.responses.toString());
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
                  "Replies [${widget.question.responses.length}]",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                allResponses,
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
