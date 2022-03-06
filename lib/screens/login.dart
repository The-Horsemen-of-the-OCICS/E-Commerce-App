import 'package:ecommerceapp/models/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../size_config.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key}) : super(key: key);

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  TextEditingController _email = TextEditingController(text: "");
  TextEditingController _password = TextEditingController(text: "");

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final userAuth = Provider.of<AuthModel>(context);

    final emailField = TextFormField(
      controller: _email,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: const InputDecoration(
        icon: Icon(
          Icons.email,
          color: Colors.black,
          size: 24.0,
        ),
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
      ),
      validator: (value) {
        if (value == null ||
            value.isEmpty ||
            !RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                .hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );

    final passwordField = TextFormField(
      controller: _password,
      autofocus: false,
      obscureText: true,
      decoration: const InputDecoration(
        icon: Icon(
          Icons.lock,
          color: Colors.black,
          size: 24.0,
        ),
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter password';
        }
        return null;
      },
    );

    final loginButton = SizedBox(
      width: MediaQuery.of(context).size.width / 2.5,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            onPrimary: Colors.black,
            primary: Colors.black,
            minimumSize: const Size(80, 60),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(2)),
            )),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            if (userAuth.login(_email.text, _password.text)) {
              Navigator.pop(context);
            } else {
              final snackBar = SnackBar(
                content: const Text('Invalid Account Credentials!'),
                action: SnackBarAction(
                  label: 'Ok',
                  onPressed: () {
                    // Some code to undo the change.
                  },
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          }
        },
        child: const Text('Log In',
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );

    Color getCheckBoxColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.black;
      }
      return Colors.black;
    }

    return Form(
        key: _formKey,
        child: Scaffold(
          backgroundColor: const Color(0xFF212332),
          body: Center(
            child: Card(
              elevation: 5.0,
              child: Container(
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width / 2.5,
                height: MediaQuery.of(context).size.height / 3,
                constraints: const BoxConstraints(
                    maxWidth: 500, maxHeight: 320, minHeight: 320),
                child: Column(
                  children: <Widget>[
                    const Center(
                        child: Text(
                      "E-Commerce Login",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    const SizedBox(height: 20.0),
                    emailField,
                    const SizedBox(height: 10.0),
                    passwordField,
                    const SizedBox(height: 20.0),
                    Expanded(
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: loginButton))
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
