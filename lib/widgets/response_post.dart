import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/response.dart';
import 'package:http/http.dart' as http;

import '../utils/network_config.dart';

class ResponsePost extends StatefulWidget {
  const ResponsePost({Key? key, required this.response}) : super(key: key);

  final Response response;

  @override
  _ResponsePostState createState() => _ResponsePostState();
}

// Put
void updateResponse(String body, String userId, String questionId,
    String responseId, String date, int upvotes) async {
  final response = await http.put(
    Uri.parse(NetworkConfig.API_BASE_URL + 'response/' + responseId),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'id': responseId,
      'questionId': questionId,
      'userId': userId,
      'body': body,
      'date': date,
      'upvotes': upvotes.toString()
    }),
  );

  debugPrint(response.body);

  if (response.statusCode == 204) {
    return;
  } else {
    throw Exception('Failed to update the response.');
  }
}

class _ResponsePostState extends State<ResponsePost> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
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
                          Row(
                            children: <Widget>[
                              Text(
                                widget.response.userName,
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(width: 15),
                              Text(
                                widget.response.createdDate,
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
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                  children: [
                    SizedBox(
                      width: 500,
                      child: Text(
                        widget.response.body,
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
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.response.upvotes += 1;
                            updateResponse(
                                widget.response.body,
                                widget.response.userId,
                                widget.response.questionId,
                                widget.response.id,
                                widget.response.createdDate,
                                widget.response.upvotes);
                          });
                        },
                        child: const Icon(
                          Icons.thumb_up,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        "${widget.response.upvotes} votes",
                        style:
                            const TextStyle(fontSize: 15, color: Colors.grey),
                      )
                    ],
                  ),
                ]),
              )
            ],
          ),
        ),
      )
    ]);
  }
}
