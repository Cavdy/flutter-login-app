import 'package:flutter/material.dart';
import 'package:loginapp/login_page.dart';
import 'package:loginapp/authentication.dart';
import 'package:loginapp/home_page.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final BaseAuth auth;

  @override
  _RootPageState createState() => _RootPageState();
}

enum AuthStatus {
  notSignedIn,
  signedIn
}

class _RootPageState extends State<RootPage> {

  AuthStatus _status = AuthStatus.notSignedIn;

  @override
  void initState() {
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
        _status = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _onSignedIn() {
    setState(() {
      _status = AuthStatus.signedIn;
    });
  }

  void _onSignedOut() {
    setState(() {
      _status = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch(_status) {
      case AuthStatus.notSignedIn:
        return LoginPage(auth: widget.auth, onSignedIn: _onSignedIn,);
        break;
      case AuthStatus.signedIn:
        return HomePage(auth: widget.auth, onSignedOut: _onSignedOut,);
        break;
    }
  }
}
