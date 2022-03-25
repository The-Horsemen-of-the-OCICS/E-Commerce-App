import 'dart:convert';

import 'package:ecommerceapp/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../utils/network_config.dart';

enum Type { invalid, buyer, merchant }

class AuthModel {
  bool _isLoggedIn = false;
  Type _loginType = Type.invalid;
  late User _user;

  bool isLoggedIn() => _isLoggedIn;
  User? getCurrentUser() {
    if (isLoggedIn()) {
      return _user;
    } else {
      return null;
    }
  }

  AuthModel();

  logout() {
    _loginType = Type.invalid;
    _isLoggedIn = false;
  }

  Future<User> fetchUser(http.Client client, String userId) async {
    final response = await client
        .get(Uri.parse(NetworkConfig.API_BASE_URL + 'user/$userId'));
    return compute(parseUser, response.body);
  }

  User parseUser(String responseBody) {
    print(responseBody);
    final parsed = jsonDecode(responseBody);
    return User.fromJson(parsed);
  }

  Future<bool> login(String email, String password) async {
    if (email == "admin@gmail.com" && password == "123456") {
      _loginType = Type.merchant;
      _user = await fetchUser(http.Client(), "623d5633607835026d13135f");
      _isLoggedIn = true;
      return true;
    } else if (email == "user1@gmail.com" && password == "123456") {
      _loginType = Type.buyer;
      _user = await fetchUser(http.Client(), "623d56e3607835026d131360");
      _isLoggedIn = true;
      return true;
    }
    return false;
  }
}
