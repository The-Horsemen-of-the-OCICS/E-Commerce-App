import 'package:ecommerceapp/routes/app_routes.dart';
import 'package:ecommerceapp/widgets/drawer_item.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      key: const Key('navigation_drawer'),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          drawerItem(
              text: 'Home',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, AppRoutes.home)),
          drawerItem(
              text: 'Merchant Items',
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.merchantItems)),
          drawerItem(
              text: 'Merchant Categories',
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.merchantCategories)),
          drawerItem(
              text: 'Cart',
              onTap: () => Navigator.pushNamed(context, AppRoutes.cart)),
          drawerItem(
              text: 'Profile',
              onTap: () => Navigator.pushNamed(context, AppRoutes.profile)),
        ],
      ),
    );
  }
}
