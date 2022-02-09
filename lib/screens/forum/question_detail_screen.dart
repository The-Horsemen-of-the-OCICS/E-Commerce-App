import 'package:ecommerceapp/models/question.dart';
import 'package:ecommerceapp/widgets/response_post.dart';
import 'package:ecommerceapp/widgets/question_post.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  @override
  final Question question;
  PostScreen({required this.question});
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
  var allResponses =  Column(
    children: widget.question.responses.map((res) =>
          ResponsePost(response: res)
        ).toList()
  );

  var responseTextBox = Container(
                  width: 630,
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: const TextField(
                    maxLength: 200,
                    minLines: 4,
                    maxLines: 4,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Type your response',
                    ),
                  ),
                );

  final submitButton = ElevatedButton(
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
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold)),
            );
    
  return Scaffold(
      appBar: AppBar(
        title: const Text('Question Detail', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
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
      ),
    );
  }
}