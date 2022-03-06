import 'package:ecommerceapp/models/user.dart';

enum Type { invalid, buyer, merchant }

class AuthModel {
  bool _isLoggedIn = false;
  Type _loginType = Type.invalid;
  User? _user;

  bool isLoggedIn() => _isLoggedIn;
  User? getCurrentUser() => _user;

  AuthModel();

  logout() {
    _loginType = Type.invalid;
    _isLoggedIn = false;
  }

  bool login(String email, String password) {
    if (email == "admin@gmail.com" && password == "123456") {
      _isLoggedIn = true;
      _loginType = Type.merchant;
      _user = User(id: "0", name: "admin", email: "admin@gmail.com");
      return true;
    } else if (email == "user1@gmail.com" && password == "123456") {
      _isLoggedIn = true;
      _loginType = Type.buyer;
      _user = User(id: "1", name: "user1", email: "user1@gmail.com");
      return true;
    }
    return false;
  }
}
