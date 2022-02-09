import 'package:flutter/material.dart';
import 'package:ecommerceapp/widgets/post.dart';

class ForumPage extends StatefulWidget {
  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {

  var titleTextBox = Row(
              children: [
                Container(
                  width: 630,
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: const TextField(
                    maxLength: 30,
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Type your question title',
                    ),
                  ),
                ),
              ],
            );

    var bodyTextBox = Row(
              children: [
                Container(
                  width: 630,
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: const TextField(
                    maxLength: 400,
                    minLines: 4,
                    maxLines: 8,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Type your question detail',
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

  final submitQuestionButton = Padding(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          children: <Widget>[
            Container( 
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35.0),
                  topRight: Radius.circular(35.0)
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[ 
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0, top: 20.0, bottom: 10.0),
                    child: Text(
                      "All Questions",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Posts(),
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
              )
            )
          ],
        )
      ),
    );
  }
}