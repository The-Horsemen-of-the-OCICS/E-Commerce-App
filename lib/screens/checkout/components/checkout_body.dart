import 'dart:convert';
import 'package:ecommerceapp/models/cartList.dart';
import 'package:ecommerceapp/routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../models/auth.dart';
import 'package:ecommerceapp/models/user.dart';
import 'package:http/http.dart' as http;
import '../../../utils/network_config.dart';

class CheckoutBody extends StatefulWidget {
  const CheckoutBody(
      {Key? key, required this.cartListPrice, required this.cartList})
      : super(key: key);
  final double cartListPrice;
  final CartList cartList;
  final double promoDiscount = 0;
  @override
  _CheckoutBodyState createState() => _CheckoutBodyState();
}

// POST
void createNewOrder(
  User user,
  CartList cartList,
  double overallPrice,
  String orderDate,
  String shippingAddress,
) async {
  final postBody = jsonEncode(<String, dynamic>{
    'id': UniqueKey().toString(),
    'userId': user.id,
    'cartList': cartList.cartItems,
    'overallPrice': overallPrice,
    'orderDate': orderDate,
    'shippingAddress': shippingAddress,
  });

  final response = await http.post(
    Uri.parse(NetworkConfig.API_BASE_URL + 'order'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: postBody,
  );
  debugPrint("LOL");
  debugPrint(response.statusCode.toString());
  debugPrint(response.body);

  if (response.statusCode == 204 ||
      response.statusCode == 200 ||
      response.statusCode == 201) {
    debugPrint("Order created");
    cartList.removeAll();
  } else {
    throw Exception('Failed to create order.');
  }
}

class _CheckoutBodyState extends State<CheckoutBody> {
  Color active = Colors.red;
  TextEditingController cardNumber = TextEditingController();
  TextEditingController year = TextEditingController();
  TextEditingController month = TextEditingController();
  TextEditingController cvc = TextEditingController();
  TextEditingController cardHolder = TextEditingController();

  TextEditingController phone = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController country = TextEditingController();

  ScrollController scrollController = ScrollController();
  bool _useDefaultShippingInfo = true;
  bool _useDefaultPaymentInfo = true;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection.index == 1) {
        FocusScope.of(context).requestFocus(FocusNode());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double overallPrice =
        widget.cartListPrice * 1.13 - widget.promoDiscount;
    final userAuth = Provider.of<AuthModel>(context);
    User? user = userAuth.getCurrentUser();

    if (user != null && _useDefaultShippingInfo) {
      phone.text = user.defaultShippingInfo.phone;
      street.text = user.defaultShippingInfo.street;
      city.text = user.defaultShippingInfo.city;
      state.text = user.defaultShippingInfo.state;
      country.text = user.defaultShippingInfo.country;
    }
    if (user != null && _useDefaultPaymentInfo) {
      cardNumber.text = '3904567890123456';
      month.text = '09';
      year.text = '25';
      cvc.text = '234';
      cardHolder.text = 'Tom Cruise';
    }
    final useDefaultShippingInfoToggle = Switch(
      value: _useDefaultShippingInfo,
      onChanged: (value) {
        setState(() {
          _useDefaultShippingInfo = value;
        });
      },
    );
    final useDefaultPaymentInfoToggle = Switch(
      value: _useDefaultPaymentInfo,
      onChanged: (value) {
        setState(() {
          _useDefaultPaymentInfo = value;
        });
      },
    );

    Widget submitOrderBtn = InkWell(
      key: const Key('checkout_confirm_button'),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width / 1.5,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(236, 60, 3, 1),
                  Color.fromRGBO(234, 60, 3, 1),
                  Color.fromRGBO(216, 78, 16, 1),
                ],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.16),
                offset: Offset(0, 5),
                blurRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.circular(9.0)),
        child: Center(
          child: Text("Pay",
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
        ),
      ),
      onTap: () => {
        createNewOrder(
          user!,
          widget.cartList,
          widget.cartListPrice,
          DateTime.now().toString(),
          '${street.text}, ${city.text}, ${state.text}, ${country.text}',
        ),
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Thank you for your order!'),
        )),
        Navigator.pushNamed(context, AppRoutes.home)
      },
    );

    Widget invoiceCard = Container(
      margin: const EdgeInsets.only(top: 16, bottom: 16),
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
          ],
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text('Cart value'),
            trailing: Text("\$${widget.cartListPrice.toStringAsFixed(2)}"),
          ),
          ListTile(
            title: Text('Tax'),
            trailing:
                Text("\$${(widget.cartListPrice * 0.13).toStringAsFixed(2)}"),
          ),
          ListTile(
            title: Text('Subtotal'),
            trailing:
                Text("\$${(widget.cartListPrice * 1.13).toStringAsFixed(2)}"),
          ),
          ListTile(
            title: Text('Discount'),
            trailing: Text("-\$${widget.promoDiscount.toStringAsFixed(2)}"),
          ),
          Divider(),
          ListTile(
            title: Text(
              'Total',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            trailing: Text(
              "\$${overallPrice.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );

    Widget paymentCard = Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
      height: 250,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
          ],
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: EdgeInsets.only(left: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.grey[200],
            ),
            child: TextField(
              inputFormatters: [LengthLimitingTextInputFormatter(16)],
              keyboardType: TextInputType.number,
              controller: cardNumber,
              onChanged: (val) {
                setState(() {});
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Card Number',
              ),
            ),
          ),
          Row(
            children: [
              Flexible(
                child: Container(
                  padding: EdgeInsets.only(left: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.grey[200],
                  ),
                  child: TextField(
                    inputFormatters: [LengthLimitingTextInputFormatter(2)],
                    keyboardType: TextInputType.number,
                    controller: month,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Month'),
                    onChanged: (val) {
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.only(left: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.grey[200],
                  ),
                  child: TextField(
                    inputFormatters: [LengthLimitingTextInputFormatter(2)],
                    keyboardType: TextInputType.number,
                    controller: year,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Year'),
                    onChanged: (val) {
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.only(left: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.grey[200],
                  ),
                  child: TextField(
                    controller: cvc,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'CVC'),
                    onChanged: (val) {
                      setState(() {});
                    },
                  ),
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.grey[200],
            ),
            child: TextField(
              controller: cardHolder,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Name on card'),
              onChanged: (val) {
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );

    Widget shippingInfoCard = Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.only(top: 8.0),
      height: 200,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
          ],
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.grey[200],
            ),
            child: TextField(
              inputFormatters: [LengthLimitingTextInputFormatter(16)],
              keyboardType: TextInputType.number,
              controller: phone,
              onChanged: (val) {
                setState(() {});
              },
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Phone Number'),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.grey[200],
            ),
            child: TextField(
              inputFormatters: [LengthLimitingTextInputFormatter(16)],
              controller: street,
              onChanged: (val) {
                setState(() {});
              },
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Street Address'),
            ),
          ),
          Row(
            children: <Widget>[
              Flexible(
                child: Container(
                  padding: EdgeInsets.only(left: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.grey[200],
                  ),
                  child: TextField(
                    inputFormatters: [LengthLimitingTextInputFormatter(16)],
                    controller: city,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'City'),
                    onChanged: (val) {
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.only(left: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.grey[200],
                  ),
                  child: TextField(
                    inputFormatters: [LengthLimitingTextInputFormatter(16)],
                    controller: state,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'State'),
                    onChanged: (val) {
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.only(left: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.grey[200],
                  ),
                  child: TextField(
                    controller: country,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Country'),
                    onChanged: (val) {
                      setState(() {});
                    },
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (_, constraints) => GestureDetector(
          onPanDown: (val) {},
          behavior: HitTestBehavior.opaque,
          child: SingleChildScrollView(
            controller: scrollController,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Invoice',
                          style: TextStyle(
                            color: Color(0xff202020),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 35,
                        )
                      ],
                    ),
                    invoiceCard,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Payment',
                          style: TextStyle(
                            color: Color(0xff202020),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        useDefaultPaymentInfoToggle
                      ],
                    ),
                    paymentCard,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Shipping Info',
                          style: TextStyle(
                            color: Color(0xff202020),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        useDefaultShippingInfoToggle
                      ],
                    ),
                    shippingInfoCard,
                    SizedBox(height: 24.0),
                    Center(
                        child: Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: submitOrderBtn,
                    ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
