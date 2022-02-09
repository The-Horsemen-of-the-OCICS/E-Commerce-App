import 'package:ecommerceapp/models/question.dart';
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

  var detailHeader = Row(children: [
              Container( 
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
              child: Row(
                children: <Widget>[
                  IconButton(   
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back,
                      size: 20,
                      color: Colors.black,
                    )
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    "Question Details",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                    ),
                  )
                ],
              ),
            )]
            );

  var questionCard = Row(children: [
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
                                            widget.question.title,
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
                                              widget.question.user.name,
                                              style: TextStyle(
                                                color: Colors.grey
                                              ),
                                            ),
                                            SizedBox(width: 15),
                                            Text(
                                              widget.question.createdDate,
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
                                widget.question.body,
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
                                    "${widget.question.upvotes}",
                                    style: TextStyle(
                                      fontSize: 20,
                                    color: Colors.grey.withOpacity(0.8),
                                    ),
                                  )
                                ],
                              ),

                            ]
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            ]);
  
  var replyCards = Column(
              children: widget.question.responses.map((response) => 
                Row(
                  children: [
                    Container( 
                      constraints: const BoxConstraints(
                        maxWidth: 600,
                      ),          
                      margin: EdgeInsets.only(left:15.0, right: 15.0, top: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [BoxShadow(
                          color: Colors.black26.withOpacity(0.1),
                          offset: Offset(0.0,6.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.10
                        )],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 60,
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        backgroundImage: NetworkImage("https://cdn-icons-png.flaticon.com/512/1946/1946429.png"),
                                        radius: 22,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(  
                                              child: Text(
                                                response.user.name,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: .4
                                                ),
                                              ),
                                            ), 
                                            SizedBox(height: 2.0),
                                            Text(
                                              widget.question.createdDate,
                                              style: TextStyle(
                                                color: Colors.grey
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ), 
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 15, bottom: 15),
                              child: Text(
                                response.body,
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 19, 
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 15, bottom: 15),
                              child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[ 
                                Icon(
                                  Icons.thumb_up, 
                                  color: Colors.grey.withOpacity(0.8),
                                  size: 20,
                                ), 
                                SizedBox(width: 5.0),
                                Text(
                                  "${response.upvotes}",
                                  style: TextStyle(
                                    color: Colors.grey.withOpacity(0.8)
                                  ),
                                )
                              ],
                            )
                          )
                          ],
                        ),
                      )
                    ),
                  ],
                )
              ).toList(),
            );
  var responseTextBox = Row(
              children: [
                Container(
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
                ),
              ],
            );

  final submitButton = Padding(
    padding: EdgeInsets.only(left: 15.0),
    child: Row(children: [
      SizedBox(
        width: 200,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.black,
            primary: Colors.black,
            minimumSize: const Size(80, 60),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(2)),
          )),
          onPressed: () {},
          child: const Text('Submit',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold)),
            ),
      )
      ]
      )
    );
    
  return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          children: <Widget>[
            detailHeader,
            questionCard,

            Padding(
              padding: EdgeInsets.only(left: 15.0, top: 20.0, bottom: 10.0),
              child: Text(
                "Replies [${widget.question.responses.length}]",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            replyCards,

            const Padding(
              padding: EdgeInsets.only(left: 15.0, top: 20.0, bottom: 10.0),
              child: Text(
                "Add a response",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
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