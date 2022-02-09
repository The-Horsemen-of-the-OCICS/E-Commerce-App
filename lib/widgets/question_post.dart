import 'package:flutter/material.dart';
import '../screens/forum/question_detail_screen.dart';
import '../models/question.dart';

class QuestionPost extends StatefulWidget {
  const QuestionPost({Key? key, required this.question}) : super(key: key);

  final Question question;

  @override
  _QuestionPostState createState() => _QuestionPostState();
}

class _QuestionPostState extends State<QuestionPost> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => PostScreen(
                          question: widget.question,
                        )));
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
                                    widget.question.user.name,
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
                            "${widget.question.responses.length} responses",
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
