import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/auth.dart';
import '../../models/user.dart';
import '../../routes/app_routes.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final userAuth = Provider.of<AuthModel>(context);
    late User user;
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
        body: Center());
  }
}
