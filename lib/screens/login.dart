import 'package:flutter/material.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key}) : super(key: key);

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  bool isChecked = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
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
      autofocus: false,
      initialValue: '',
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
            if (isChecked) {
              // Launch admin page
            } else {
              // Launch customer page
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

    final loginCheckBox = Row(
      children: <Widget>[
        Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getCheckBoxColor),
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),
        const Text("Login as Admin?")
      ],
    );

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
                constraints:
                    const BoxConstraints(maxWidth: 500, maxHeight: 400),
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
                    loginCheckBox,
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
