import 'package:flutter/material.dart';
import 'package:loginapp/root_page.dart';
import 'package:loginapp/authentication.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      home: new RootPage(auth: Auth(),),
    );
  }
}