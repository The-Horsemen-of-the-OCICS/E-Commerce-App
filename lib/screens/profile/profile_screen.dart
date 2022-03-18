import 'dart:convert';

import 'package:ecommerceapp/widgets/order_history_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../models/auth.dart';
import '../../models/order.dart';
import '../../models/user.dart';
import 'package:http/http.dart' as http;

import '../../utils/network_config.dart';
import '../login.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

// GET
Future<List<Order>> fetchOrders(http.Client client, String userId) async {
  final response = await client
      .get(Uri.parse(NetworkConfig.API_BASE_URL + 'order/u/' + userId));
  return compute(parseOrders, response.body);
}

Future<List<Order>> parseOrders(String responseBody) async {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Order>((json) => Order.fromJson(json)).toList();
}

// POST
void updateShipInfo(String userId, String phone, String street, String city,
    String state, String country) async {
  final response = await http.put(
    Uri.parse(NetworkConfig.API_BASE_URL + 'user/shippingInfo/$userId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'phone': phone,
      'street': street,
      'city': city,
      'state': state,
      'country': country
    }),
  );
  debugPrint(response.body);

  if (response.statusCode == 204) {
    debugPrint("Shipping info change successed");
  } else {
    throw Exception('Failed to change address.');
  }
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  List<Order> _orders = [];

  TextEditingController phoneNumber = TextEditingController();
  TextEditingController streetAddress = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController country = TextEditingController();

  bool _isEditEnabled = false;

  @override
  Widget build(BuildContext context) {
    final userAuth = Provider.of<AuthModel>(context);
    User? user = userAuth.getCurrentUser();

    if (user == null) {
      return Scaffold(
          appBar: AppBar(
            title: const Text(
              'User Profile',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
          ),
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Please login to access your profile!",
                  style: TextStyle(fontSize: 18),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: ElevatedButton(
                    key: const Key("profile_login_button"),
                    child: const Text("Login"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyLoginPage()),
                      ).then((value) {
                        setState(() {});
                      });
                      //Navigator.of(context).pushNamed(AppRoutes.login);
                    },
                  ),
                )
              ],
            ),
          ));
    }

    final futureOrders = FutureBuilder<List<Order>>(
      future: fetchOrders(http.Client(), user.id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          debugPrint(snapshot.error.toString());
          return const Center(
            child: Text('Failed to load order history from the server!'),
          );
        } else if (snapshot.hasData) {
          _orders = snapshot.data!;
          return Column(
              children: _orders
                  .map((order) => OrderHistroyItem(order: order))
                  .toList());
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );

    phoneNumber.text = user.defaultShippingInfo.phone;
    streetAddress.text = user.defaultShippingInfo.street;
    city.text = user.defaultShippingInfo.city;
    state.text = user.defaultShippingInfo.state;
    country.text = user.defaultShippingInfo.country;

    final editToggle = Switch(
      value: _isEditEnabled,
      onChanged: (value) {
        setState(() {
          _isEditEnabled = value;
        });
      },
      activeTrackColor: Colors.lightGreenAccent,
      activeColor: Colors.green,
    );

    final submitButton = ElevatedButton(
        style: ElevatedButton.styleFrom(
            onPrimary: Colors.black,
            primary: Colors.black,
            minimumSize: const Size(100, 60),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(2)),
            )),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            setState(() {
              user.defaultShippingInfo.phone = phoneNumber.text;
              user.defaultShippingInfo.street = streetAddress.text;
              user.defaultShippingInfo.city = city.text;
              user.defaultShippingInfo.state = state.text;
              user.defaultShippingInfo.country = country.text;
              updateShipInfo(user.id, phoneNumber.text, streetAddress.text,
                  city.text, state.text, country.text);
            });
          }
        },
        child: const Text('Submit',
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold)));

    Widget shippingInfoCard = Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.only(top: 8.0),
      height: 200,
      width: MediaQuery.of(context).size.width,
      constraints: const BoxConstraints(
        maxWidth: 600,
      ),
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
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter something';
                }
                return null;
              },
              inputFormatters: [LengthLimitingTextInputFormatter(16)],
              keyboardType: TextInputType.number,
              controller: phoneNumber,
              enabled: _isEditEnabled,
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
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter something';
                }
                return null;
              },
              key: const Key('default_street_field'),
              inputFormatters: [LengthLimitingTextInputFormatter(16)],
              controller: streetAddress,
              enabled: _isEditEnabled,
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
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter something';
                      }
                      return null;
                    },
                    inputFormatters: [LengthLimitingTextInputFormatter(16)],
                    controller: city,
                    enabled: _isEditEnabled,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'City'),
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
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter something';
                      }
                      return null;
                    },
                    inputFormatters: [LengthLimitingTextInputFormatter(16)],
                    controller: state,
                    enabled: _isEditEnabled,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'State'),
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
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter something';
                      }
                      return null;
                    },
                    controller: country,
                    enabled: _isEditEnabled,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Country'),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );

    return Form(
      key: _formKey,
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'User Profile',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
          ),
          backgroundColor: Colors.white,
          body: Center(
              child: ListView(
            children: [
              Column(
                children: <Widget>[
                  Padding(
                      padding:
                          EdgeInsets.only(left: 15.0, top: 20.0, bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Your Default Shipping Info",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            width: 150,
                          ),
                          Text(
                            "Edit",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          editToggle,
                        ],
                      )),
                  shippingInfoCard,
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 400.0, top: 20.0, bottom: 10.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[submitButton])),
                  Padding(
                      padding:
                          EdgeInsets.only(left: 15.0, top: 20.0, bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Your Order History",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      )),
                  futureOrders
                ],
              ),
            ],
          ))),
    );
  }
}
