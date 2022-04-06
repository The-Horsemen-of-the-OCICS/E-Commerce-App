import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ecommerceapp/models/cartList.dart';
import 'package:ecommerceapp/screens/drawer/navigation_drawer.dart';
import 'package:provider/provider.dart';
import 'components/body.dart';
import 'components/check_out_card.dart';
import 'package:ecommerceapp/routes/app_routes.dart';
import '../../../models/auth.dart';
import 'package:ecommerceapp/models/item.dart';
import 'package:ecommerceapp/models/user.dart';
import 'package:ecommerceapp/screens/login.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerceapp/utils/network_config.dart';
import 'package:flutter/foundation.dart';

Future<List<Item>> fetchItems(http.Client client) async {
  final response =
      await client.get(Uri.parse(NetworkConfig.API_BASE_URL + 'item/'));

  return compute(parseItems, response.body);
}

Future<List<Item>> parseItems(String responseBody) async {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  List<Item> items = parsed.map<Item>((json) => Item.fromJson(json)).toList();

  return items;
}

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Item>? itemList;
  @override
  void initState() {
    super.initState();

    // fetchName function is a asynchronously to GET http data
    fetchItems(http.Client()).then((result) {
      // Once we receive our name we trigger rebuild.
      setState(() {
        itemList = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<AuthModel>(context).getCurrentUser();
    if (user == null) {
      return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Cart',
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
                  "Please login to view your cart",
                  style: TextStyle(fontSize: 18),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: ElevatedButton(
                    key: const Key("cart_login_button"),
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
    return Consumer<CartList>(builder: (context, cartList, _) {
      if (cartList.cartItems.isEmpty) {
        return Scaffold(
          appBar: buildAppBar(context),
          drawer: const NavigationDrawer(),
          body: const Center(
            child: Text("No items in cart..."),
          ),
        );
      } else {
        cartList.update(itemList);
        var cartListPrice = cartList.getCartListPrice();
        return Scaffold(
          appBar: buildAppBar(context),
          drawer: const NavigationDrawer(),
          body: Center(child: Body(cartList: cartList)),
          bottomNavigationBar: CheckoutCard(
              cartListPrice: cartListPrice.toDouble(), cartList: cartList),
        );
      }
    });
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      iconTheme: const IconThemeData(color: Color(0xff202020)),
      title: Column(
        children: const [
          Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
      actions: [
        IconButton(
            key: const Key("cart_to_home_button"),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.home);
            },
            icon: const Icon(Icons.home),
            padding: const EdgeInsets.only(right: 15)),
      ],
    );
  }
}
