import 'package:flutter/material.dart';
import 'package:ecommerceapp/models/cartList.dart';
import 'package:ecommerceapp/screens/drawer/navigation_drawer.dart';
import 'package:provider/provider.dart';
import 'components/body.dart';
import 'components/check_out_card.dart';
import 'package:ecommerceapp/routes/app_routes.dart';
import '../../../models/auth.dart';
import 'package:ecommerceapp/models/user.dart';
import 'package:ecommerceapp/screens/login.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
      var cartListPrice = cartList.getCartListPrice();

      if (cartList.cartItems.isEmpty) {
        return Scaffold(
          appBar: buildAppBar(context),
          drawer: const NavigationDrawer(),
          body: const Center(
            child: Text("No items in cart..."),
          ),
        );
      } else {
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
