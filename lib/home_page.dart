import 'package:flutter/material.dart';
import 'package:loginapp/authentication.dart';

class HomePage extends StatefulWidget {
  HomePage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String uid = '';

  getUid() {}

  @override
  void initState() {
    this.uid = "";
    widget.auth.currentUser().then((val) {
      setState(() {
        this.uid = val;
      });
    });
    super.initState();
  }

  void _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page Cavdy"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Welcome \n$uid", style: TextStyle(fontSize: 18.0),),
              RaisedButton(
                child: Text("Logout", style: TextStyle(color: Colors.white),),
                onPressed: _signOut,
                color: Colors.red,
              )
            ],
          ),
        ),
      ),
    );
  }
}
