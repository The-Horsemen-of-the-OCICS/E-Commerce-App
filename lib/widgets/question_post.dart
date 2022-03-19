import 'dart:convert';

import 'package:flutter/material.dart';
import '../screens/forum/question_detail_screen.dart';
import '../models/question.dart';
import 'package:http/http.dart' as http;

import '../utils/network_config.dart';

class QuestionPost extends StatefulWidget {
  const QuestionPost({Key? key, required this.question, required this.ifInner})
      : super(key: key);

  final Question question;

  final bool ifInner;

  @override
  _QuestionPostState createState() => _QuestionPostState();
}

// Put
void updateQuestion(String title, String body, String userId, String questionId,
    String date, int upvotes) async {
  final response = await http.put(
    Uri.parse(NetworkConfig.API_BASE_URL + 'question/' + questionId),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'id': questionId,
      'userId': userId,
      'title': title,
      'body': body,
      'date': date,
      'upvotes': upvotes.toString()
    }),
  );

  debugPrint(response.body);

  if (response.statusCode == 204) {
    return;
  } else {
    throw Exception('Failed to create Question.');
  }
}

class _QuestionPostState extends State<QuestionPost> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
          onTap: () {
            !widget.ifInner
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => PostScreen(
                              question: widget.question,
                            ))).then((value) => setState(() {}))
                : setState(() {
                    widget.question.upvotes += 1;
                    updateQuestion(
                        widget.question.title,
                        widget.question.body,
                        widget.question.userId,
                        widget.question.id,
                        widget.question.createdDate,
                        widget.question.upvotes);
                  });
          },
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 600,
            ),
            margin: EdgeInsets.all(2.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26.withOpacity(0.1),
                      offset: Offset(0.0, 6.0),
                      blurRadius: 10.0,
                      spreadRadius: 0.10)
                ]),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(
                              "https://cdn-icons-png.flaticon.com/512/1946/1946429.png"),
                          radius: 22,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  widget.question.title,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: .4),
                                ),
                              ),
                              SizedBox(height: 2.0),
                              Row(
                                children: <Widget>[
                                  Text(
                                    widget.question.userName,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(width: 15),
                                  Text(
                                    widget.question.createdDate,
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 500,
                          child: Text(
                            widget.question.body,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 18,
                                letterSpacing: .2),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    child: Row(children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Icon(
                            Icons.thumb_up,
                            color: Colors.grey,
                            size: 20,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            "${widget.question.upvotes} votes",
                            style: const TextStyle(
                                fontSize: 15, color: Colors.grey),
                          )
                        ],
                      ),
                      const SizedBox(width: 20),
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.chat,
                            color: Colors.grey,
                            size: 20,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            "${widget.question.responseCount} responses",
                            style: const TextStyle(
                                fontSize: 15, color: Colors.grey),
                          )
                        ],
                      )
                    ]),
                  )
                ],
              ),
            ),
          ))
    ]);
  }
}
