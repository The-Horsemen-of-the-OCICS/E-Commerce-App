import 'package:flutter/material.dart';
import '../models/order.dart';
import '../screens/forum/question_detail_screen.dart';

class OrderHistroyItem extends StatefulWidget {
  const OrderHistroyItem({Key? key, required this.order}) : super(key: key);

  final Order order;

  @override
  _OrderHistroyItemState createState() => _OrderHistroyItemState();
}

class _OrderHistroyItemState extends State<OrderHistroyItem> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
          onTap: () {},
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
                        Text(
                          "Order # ${widget.order.id}",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: .4),
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
                                    "${widget.order.orderDate}",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 10),
                    child: Text(
                      "Shipped To: ${widget.order.shippingAddress}",
                      maxLines: 3,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 18,
                          letterSpacing: .2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Total Price: ${widget.order.overallPrice.toString()}",
                      maxLines: 3,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 18,
                          letterSpacing: .2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Text(
                      "Items: ${widget.order.printItems()}",
                      maxLines: 3,
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
          ))
    ]);
  }
}
