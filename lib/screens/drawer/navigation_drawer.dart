import 'package:ecommerceapp/routes/app_routes.dart';
import 'package:ecommerceapp/widgets/drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/auth.dart';
import '../../models/user.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    final userAuth = Provider.of<AuthModel>(context);
    User? user = userAuth.getCurrentUser();

    List<Widget> commonItems = [
      drawerItem(
          text: 'Home',
          onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.home)),
      drawerItem(
          text: 'Cart',
          onTap: () => Navigator.pushNamed(context, AppRoutes.cart)),
      drawerItem(
          text: 'Profile',
          onTap: () => Navigator.pushNamed(context, AppRoutes.profile))
    ];

    List<Widget> adminItems = [
      drawerItem(
          text: 'Merchant Items',
          onTap: () => Navigator.pushNamed(context, AppRoutes.merchantItems)),
      drawerItem(
          text: 'Merchant Categories',
          onTap: () =>
              Navigator.pushNamed(context, AppRoutes.merchantCategories))
    ];
    if (user == null || user.email != 'admin@gmail.com') {
      return Drawer(
        key: const Key('navigation_drawer'),
        child: ListView(
          padding: EdgeInsets.zero,
          children: commonItems,
        ),
      );
    }
    return Drawer(
      key: const Key('navigation_drawer'),
      child: ListView(
        padding: EdgeInsets.zero,
        children: commonItems + adminItems,
      ),
    );
  }
}
