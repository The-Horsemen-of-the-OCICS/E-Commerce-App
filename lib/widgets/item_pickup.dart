import 'package:ecommerceapp/models/item.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceapp/routes/app_routes.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:transparent_image/transparent_image.dart';

class ItemPickedup extends StatefulWidget {
  const ItemPickedup({Key? key, required this.item}) : super(key: key);

  final Item item;

  @override
  _ItemPickedupState createState() => _ItemPickedupState();
}

class _ItemPickedupState extends State<ItemPickedup> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.home);
          },
          child: Container(
            constraints: const BoxConstraints(maxWidth: 245, minHeight: 400),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26.withOpacity(0.1),
                      offset: Offset(0.0, 0.0),
                      blurRadius: 10.0,
                      spreadRadius: 0.10)
                ]),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10, top: 10, bottom: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                    margin: const EdgeInsets.only(left: 0, right: 0),
                    color: Colors.white,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: widget.item.image,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 10),
                            child: Text(widget.item.name,
                                style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 5),
                            child: Text(widget.item.desc,
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 10),
                            child: Text("\$${widget.item.price}",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 239, 83, 80),
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold)),
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
