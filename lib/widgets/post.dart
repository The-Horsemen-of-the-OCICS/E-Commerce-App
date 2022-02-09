import 'package:flutter/material.dart';
import '../screens/forum/question_detail_screen.dart';
import '../models/question.dart';

class Posts extends StatefulWidget {
  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: questions.map((question) =>
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PostScreen(
                    question: question,
                  )
                )
              );
            },
            child: Row(
              children: [
                Container(
                  constraints: const BoxConstraints(
                      maxWidth: 600,
                  ),                  
                  margin: EdgeInsets.all(15.0),
                  decoration: BoxDecoration( 
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [BoxShadow(
                      color: Colors.black26.withOpacity(0.1),
                      offset: Offset(0.0,6.0),
                      blurRadius: 10.0,
                      spreadRadius: 0.10
                    )]
                  ),
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
                              backgroundImage: NetworkImage("https://cdn-icons-png.flaticon.com/512/1946/1946429.png"),
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
                                            question.title,
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: .4
                                            ),
                                          ),
                                        ), 
                                        SizedBox(height: 2.0),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              question.user.name,
                                              style: TextStyle(
                                                color: Colors.grey
                                              ),
                                            ),
                                            SizedBox(width: 15),
                                            Text(
                                              question.createdDate,
                                              style: TextStyle(
                                                color: Colors.grey
                                              ),
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
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                          child: Row(
                            children: [ SizedBox(
                              width: 500,
                              child: Text(
                                question.body,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 20, 
                                letterSpacing: .2
                              ),
                              ),
                            )],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          child: Row(
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.thumb_up,
                                    color: Colors.grey.withOpacity(0.8),
                                    size: 20,
                                  ),
                                  SizedBox(width: 4.0),
                                  Text(
                                    "${question.upvotes} votes",
                                    style: TextStyle(
                                      fontSize: 20,
                                    color: Colors.grey.withOpacity(0.8),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(width: 20),
                              Row(
                                children: <Widget>[
                                  const Icon(
                                    Icons.chat,
                                    color: Colors.grey,
                                    size: 29,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    "${question.responses.length} responses",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey
                                    ),
                                  )
                                ],
                              )
                            ]
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ).toList()
    );
  }
}